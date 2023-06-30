Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B8743244
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjF3Bep (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3Beo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE13297C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA4A661666
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 01:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16104C433C8;
        Fri, 30 Jun 2023 01:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088882;
        bh=9UR4z1ekAL+Lt00ddjpQK13tGN1tlJZm3jamHdSceU8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CLZ/nxc18EretOfHBDNm6Z2V/QhKSWVJIAYrKyri7U/bHfUqcAr5qWnXp7ACzDExD
         iiBm8+RRiQqTZ8JK25g5tPfg16d2NE65FDZNjDDF09jETi548NsMZ3IsiglVS02/vs
         ZLN/Dcxq+PDZYv2UBqgNY+OkF1fiI60yLVaYhWyPRPk/JqRk7Pv3lq8kw9WbnN7ksN
         S+5uJcKk7kpDD4bLCM89q+usQplQtgxMJ8Wu+4yzwDT8T3twnyFt0xbe6AfNulS1BR
         ePTJBThpkG3FiqbEpMXLnOaNKGpmtk0GmZetvUBHcdLl7rEeGkGtMHKSiS0fQEEWAa
         vAHOoCquRvkkA==
Subject: [PATCH RFC 1/4] NFSD: Add struct nfsd4_fattr_args
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 29 Jun 2023 21:34:41 -0400
Message-ID: <168808888115.7728.1975663372150214688.stgit@manet.1015granger.net>
In-Reply-To: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to split nfsd4_encode_fattr() into a number of smaller
functions. Instead of passing a large number of arguments to each
of the smaller functions, create a struct that can gather the
common argument variables into something with a handle on it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  111 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26b1343c8035..a22a6015afe5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2938,6 +2938,15 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 	return nfserr_resource;
 }
 
+struct nfsd4_fattr_args {
+	struct svc_fh		*fhp;
+	struct kstat		stat;
+	struct kstatfs		statfs;
+	struct nfs4_acl		*acl;
+	u32			rdattr_err;
+	bool			contextsupport;
+};
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2948,26 +2957,22 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		struct dentry *dentry, u32 *bmval,
 		struct svc_rqst *rqstp, int ignore_crossmnt)
 {
+	struct nfsd4_fattr_args args;
 	u32 bmval0 = bmval[0];
 	u32 bmval1 = bmval[1];
 	u32 bmval2 = bmval[2];
-	struct kstat stat;
 	struct svc_fh *tempfh = NULL;
-	struct kstatfs statfs;
 	__be32 *p, *attrlen_p;
 	int starting_len = xdr->buf->len;
 	int attrlen_offset;
 	u32 dummy;
 	u64 dummy64;
-	u32 rdattr_err = 0;
 	__be32 status;
 	int err;
-	struct nfs4_acl *acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void *context = NULL;
 	int contextlen;
 #endif
-	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
 	struct path path = {
@@ -2979,25 +2984,28 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
 
+	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
-		status = fattr_handle_absent_fs(&bmval0, &bmval1, &bmval2, &rdattr_err);
+		status = fattr_handle_absent_fs(&bmval0, &bmval1, &bmval2,
+						&args.rdattr_err);
 		if (status)
 			goto out;
 	}
 
-	err = vfs_getattr(&path, &stat,
+	err = vfs_getattr(&path, &args.stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
 			  AT_STATX_SYNC_AS_STAT);
 	if (err)
 		goto out_nfserr;
-	if (!(stat.result_mask & STATX_BTIME))
+
+	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
 		bmval1 &= ~FATTR4_WORD1_TIME_CREATE;
 	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
-		err = vfs_statfs(&path, &statfs);
+		err = vfs_statfs(&path, &args.statfs);
 		if (err)
 			goto out_nfserr;
 	}
@@ -3010,10 +3018,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		status = fh_compose(tempfh, exp, dentry, NULL);
 		if (status)
 			goto out;
-		fhp = tempfh;
-	}
+		args.fhp = tempfh;
+	} else
+		args.fhp = fhp;
+
+	args.acl = NULL;
 	if (bmval0 & FATTR4_WORD0_ACL) {
-		err = nfsd4_get_nfs4_acl(rqstp, dentry, &acl);
+		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
 		if (err == -EOPNOTSUPP)
 			bmval0 &= ~FATTR4_WORD0_ACL;
 		else if (err == -EINVAL) {
@@ -3023,6 +3034,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out_nfserr;
 	}
 
+	args.contextsupport = false;
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if ((bmval2 & FATTR4_WORD2_SECURITY_LABEL) ||
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
@@ -3031,7 +3044,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 						&context, &contextlen);
 		else
 			err = -EOPNOTSUPP;
-		contextsupport = (err == 0);
+		args.contextsupport = (err == 0);
 		if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
 			if (err == -EOPNOTSUPP)
 				bmval2 &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -3057,7 +3070,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 		if (!IS_POSIXACL(dentry->d_inode))
 			supp[0] &= ~FATTR4_WORD0_ACL;
-		if (!contextsupport)
+		if (!args.contextsupport)
 			supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (!supp[2]) {
 			p = xdr_reserve_space(xdr, 12);
@@ -3080,7 +3093,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		dummy = nfs4_file_type(stat.mode);
+		dummy = nfs4_file_type(args.stat.mode);
 		if (dummy == NF4BAD) {
 			status = nfserr_serverfault;
 			goto out;
@@ -3101,13 +3114,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = encode_change(p, &stat, d_inode(dentry), exp);
+		p = encode_change(p, &args.stat, d_inode(dentry), exp);
 	}
 	if (bmval0 & FATTR4_WORD0_SIZE) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, stat.size);
+		p = xdr_encode_hyper(p, args.stat.size);
 	}
 	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
 		p = xdr_reserve_space(xdr, 4);
@@ -3134,16 +3147,16 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (exp->ex_fslocs.migrated) {
 			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MAJOR);
 			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
-		} else switch(fsid_source(fhp)) {
+		} else switch(fsid_source(args.fhp)) {
 		case FSIDSOURCE_FSID:
 			p = xdr_encode_hyper(p, (u64)exp->ex_fsid);
 			p = xdr_encode_hyper(p, (u64)0);
 			break;
 		case FSIDSOURCE_DEV:
 			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MAJOR(stat.dev));
+			*p++ = cpu_to_be32(MAJOR(args.stat.dev));
 			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MINOR(stat.dev));
+			*p++ = cpu_to_be32(MINOR(args.stat.dev));
 			break;
 		case FSIDSOURCE_UUID:
 			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
@@ -3167,12 +3180,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(rdattr_err);
+		*p++ = cpu_to_be32(args.rdattr_err);
 	}
 	if (bmval0 & FATTR4_WORD0_ACL) {
 		struct nfs4_ace *ace;
 
-		if (acl == NULL) {
+		if (args.acl == NULL) {
 			p = xdr_reserve_space(xdr, 4);
 			if (!p)
 				goto out_resource;
@@ -3183,9 +3196,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(acl->naces);
+		*p++ = cpu_to_be32(args.acl->naces);
 
-		for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
+		for (ace = args.acl->aces; ace < args.acl->aces + args.acl->naces; ace++) {
 			p = xdr_reserve_space(xdr, 4*3);
 			if (!p)
 				goto out_resource;
@@ -3231,35 +3244,35 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(1);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
-		p = xdr_reserve_space(xdr, fhp->fh_handle.fh_size + 4);
+		p = xdr_reserve_space(xdr, args.fhp->fh_handle.fh_size + 4);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_opaque(p, &fhp->fh_handle.fh_raw,
-					fhp->fh_handle.fh_size);
+		p = xdr_encode_opaque(p, &args.fhp->fh_handle.fh_raw,
+					args.fhp->fh_handle.fh_size);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, stat.ino);
+		p = xdr_encode_hyper(p, args.stat.ino);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) statfs.f_ffree);
+		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) statfs.f_ffree);
+		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) statfs.f_files);
+		p = xdr_encode_hyper(p, (u64) args.statfs.f_files);
 	}
 	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
 		status = nfsd4_encode_fs_locations(xdr, rqstp, exp);
@@ -3288,7 +3301,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(statfs.f_namelen);
+		*p++ = cpu_to_be32(args.statfs.f_namelen);
 	}
 	if (bmval0 & FATTR4_WORD0_MAXREAD) {
 		p = xdr_reserve_space(xdr, 8);
@@ -3306,7 +3319,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(stat.mode & S_IALLUGO);
+		*p++ = cpu_to_be32(args.stat.mode & S_IALLUGO);
 	}
 	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
 		p = xdr_reserve_space(xdr, 4);
@@ -3318,15 +3331,15 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(stat.nlink);
+		*p++ = cpu_to_be32(args.stat.nlink);
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER) {
-		status = nfsd4_encode_user(xdr, rqstp, stat.uid);
+		status = nfsd4_encode_user(xdr, rqstp, args.stat.uid);
 		if (status)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
-		status = nfsd4_encode_group(xdr, rqstp, stat.gid);
+		status = nfsd4_encode_group(xdr, rqstp, args.stat.gid);
 		if (status)
 			goto out;
 	}
@@ -3334,39 +3347,39 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32((u32) MAJOR(stat.rdev));
-		*p++ = cpu_to_be32((u32) MINOR(stat.rdev));
+		*p++ = cpu_to_be32((u32) MAJOR(args.stat.rdev));
+		*p++ = cpu_to_be32((u32) MINOR(args.stat.rdev));
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		dummy64 = (u64)statfs.f_bavail * (u64)statfs.f_bsize;
+		dummy64 = (u64)args.statfs.f_bavail * (u64)args.statfs.f_bsize;
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		dummy64 = (u64)statfs.f_bfree * (u64)statfs.f_bsize;
+		dummy64 = (u64)args.statfs.f_bfree * (u64)args.statfs.f_bsize;
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		dummy64 = (u64)statfs.f_blocks * (u64)statfs.f_bsize;
+		dummy64 = (u64)args.statfs.f_blocks * (u64)args.statfs.f_bsize;
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		dummy64 = (u64)stat.blocks << 9;
+		dummy64 = (u64)args.stat.blocks << 9;
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
-		status = nfsd4_encode_nfstime4(xdr, &stat.atime);
+		status = nfsd4_encode_nfstime4(xdr, &args.stat.atime);
 		if (status)
 			goto out;
 	}
@@ -3377,22 +3390,22 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = encode_time_delta(p, d_inode(dentry));
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		status = nfsd4_encode_nfstime4(xdr, &stat.ctime);
+		status = nfsd4_encode_nfstime4(xdr, &args.stat.ctime);
 		if (status)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		status = nfsd4_encode_nfstime4(xdr, &stat.mtime);
+		status = nfsd4_encode_nfstime4(xdr, &args.stat.mtime);
 		if (status)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		status = nfsd4_encode_nfstime4(xdr, &stat.btime);
+		status = nfsd4_encode_nfstime4(xdr, &args.stat.btime);
 		if (status)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		u64 ino = stat.ino;
+		u64 ino = args.stat.ino;
 
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
@@ -3427,7 +3440,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		*p++ = cpu_to_be32(stat.blksize);
+		*p++ = cpu_to_be32(args.stat.blksize);
 	}
 #endif /* CONFIG_NFSD_PNFS */
 	if (bmval2 & FATTR4_WORD2_SUPPATTR_EXCLCREAT) {
@@ -3468,7 +3481,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	if (context)
 		security_release_secctx(context, contextlen);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
-	kfree(acl);
+	kfree(args.acl);
 	if (tempfh) {
 		fh_put(tempfh);
 		kfree(tempfh);


