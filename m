Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF417A4C27
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjIRP1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIRP1L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEC19AD
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D5EC32779;
        Mon, 18 Sep 2023 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045733;
        bh=IdTdyDpdBato/bTnTFqZ+mN7N2a+jtToSoHwzF6AAtI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hY7takWeeRSEFHncg9ZFpl7VDNI4pRgWlK6nToGI/0eKf/CxcU9X9C7deHw0Z+Fjo
         6kWeWkP/D4tuKVpZ4wSElLYXEjyi/9VKaB2xX7204GoPLXcnU+lj7N8BN5+ITevfLH
         UFWqaZS4O+oREYas83O+b4PJzhb/bp0HwUj6rc3M68UZesGR8Nq1G1PdHwxvE/cs8Q
         2Al3ke30v06ZZTwgHY1WGZyBTNtjfJ1VeOfdbsRlILvMqwdg9a0TssBfnCEJQCJwQF
         1NNdAPxLIZTWqPGUojp8fg6/kU3Ps/YNzZkik0iBC6LZoq9qvzBH7JdWLiMouSHeem
         OdzEvhwTmjFqw==
Subject: [PATCH v1 51/52] NFSD: Use a bitmask loop to encode FATTR4 results
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:02:12 -0400
Message-ID: <169504573247.133720.11599512132060333899.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The fattr4 encoder is now structured like the COMPOUND op encoder:
one function for each individual attribute, called by bit number.
Benefits include:

- The individual attributes are now guaranteed to be encoded in
  bitmask order into the send buffer

- There can be no unwanted side effects between attribute encoders

- The code now clearly documents which attributes are /not/
  implemented on this server

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  429 ++++++++++++++++++-----------------------------------
 1 file changed, 142 insertions(+), 287 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97654a2b876f..d7f690a3ea86 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2902,6 +2902,15 @@ struct nfsd4_fattr_args {
 	bool			ignore_crossmnt;
 };
 
+typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
+				const struct nfsd4_fattr_args *args);
+
+static __be32 nfsd4_encode_fattr4__noop(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfs_ok;
+}
+
 static __be32 nfsd4_encode_fattr4__true(struct xdr_stream *xdr,
 					const struct nfsd4_fattr_args *args)
 {
@@ -3354,6 +3363,108 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, err == 0);
 }
 
+static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
+	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
+	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
+	[FATTR4_FH_EXPIRE_TYPE]		= nfsd4_encode_fattr4_fh_expire_type,
+	[FATTR4_CHANGE]			= nfsd4_encode_fattr4_change,
+	[FATTR4_SIZE]			= nfsd4_encode_fattr4_size,
+	[FATTR4_LINK_SUPPORT]		= nfsd4_encode_fattr4__true,
+	[FATTR4_SYMLINK_SUPPORT]	= nfsd4_encode_fattr4__true,
+	[FATTR4_NAMED_ATTR]		= nfsd4_encode_fattr4__false,
+	[FATTR4_FSID]			= nfsd4_encode_fattr4_fsid,
+	[FATTR4_UNIQUE_HANDLES]		= nfsd4_encode_fattr4__true,
+	[FATTR4_LEASE_TIME]		= nfsd4_encode_fattr4_lease_time,
+	[FATTR4_RDATTR_ERROR]		= nfsd4_encode_fattr4_rdattr_error,
+	[FATTR4_ACL]			= nfsd4_encode_fattr4_acl,
+	[FATTR4_ACLSUPPORT]		= nfsd4_encode_fattr4_aclsupport,
+	[FATTR4_ARCHIVE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CANSETTIME]		= nfsd4_encode_fattr4__true,
+	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4__false,
+	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4__true,
+	[FATTR4_CHOWN_RESTRICTED]	= nfsd4_encode_fattr4__true,
+	[FATTR4_FILEHANDLE]		= nfsd4_encode_fattr4_filehandle,
+	[FATTR4_FILEID]			= nfsd4_encode_fattr4_fileid,
+	[FATTR4_FILES_AVAIL]		= nfsd4_encode_fattr4_files_avail,
+	[FATTR4_FILES_FREE]		= nfsd4_encode_fattr4_files_free,
+	[FATTR4_FILES_TOTAL]		= nfsd4_encode_fattr4_files_total,
+	[FATTR4_FS_LOCATIONS]		= nfsd4_encode_fattr4_fs_locations,
+	[FATTR4_HIDDEN]			= nfsd4_encode_fattr4__noop,
+	[FATTR4_HOMOGENEOUS]		= nfsd4_encode_fattr4__true,
+	[FATTR4_MAXFILESIZE]		= nfsd4_encode_fattr4_maxfilesize,
+	[FATTR4_MAXLINK]		= nfsd4_encode_fattr4_maxlink,
+	[FATTR4_MAXNAME]		= nfsd4_encode_fattr4_maxname,
+	[FATTR4_MAXREAD]		= nfsd4_encode_fattr4_maxread,
+	[FATTR4_MAXWRITE]		= nfsd4_encode_fattr4_maxwrite,
+	[FATTR4_MIMETYPE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_MODE]			= nfsd4_encode_fattr4_mode,
+	[FATTR4_NO_TRUNC]		= nfsd4_encode_fattr4__true,
+	[FATTR4_NUMLINKS]		= nfsd4_encode_fattr4_numlinks,
+	[FATTR4_OWNER]			= nfsd4_encode_fattr4_owner,
+	[FATTR4_OWNER_GROUP]		= nfsd4_encode_fattr4_owner_group,
+	[FATTR4_QUOTA_AVAIL_HARD]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_QUOTA_AVAIL_SOFT]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_QUOTA_USED]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RAWDEV]			= nfsd4_encode_fattr4_rawdev,
+	[FATTR4_SPACE_AVAIL]		= nfsd4_encode_fattr4_space_avail,
+	[FATTR4_SPACE_FREE]		= nfsd4_encode_fattr4_space_free,
+	[FATTR4_SPACE_TOTAL]		= nfsd4_encode_fattr4_space_total,
+	[FATTR4_SPACE_USED]		= nfsd4_encode_fattr4_space_used,
+	[FATTR4_SYSTEM]			= nfsd4_encode_fattr4__noop,
+	[FATTR4_TIME_ACCESS]		= nfsd4_encode_fattr4_time_access,
+	[FATTR4_TIME_ACCESS_SET]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_TIME_BACKUP]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_TIME_CREATE]		= nfsd4_encode_fattr4_time_create,
+	[FATTR4_TIME_DELTA]		= nfsd4_encode_fattr4_time_delta,
+	[FATTR4_TIME_METADATA]		= nfsd4_encode_fattr4_time_metadata,
+	[FATTR4_TIME_MODIFY]		= nfsd4_encode_fattr4_time_modify,
+	[FATTR4_TIME_MODIFY_SET]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_MOUNTED_ON_FILEID]	= nfsd4_encode_fattr4_mounted_on_fileid,
+	[FATTR4_DIR_NOTIF_DELAY]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_DIRENT_NOTIF_DELAY]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_DACL]			= nfsd4_encode_fattr4__noop,
+	[FATTR4_SACL]			= nfsd4_encode_fattr4__noop,
+	[FATTR4_CHANGE_POLICY]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_FS_STATUS]		= nfsd4_encode_fattr4__noop,
+
+#ifdef CONFIG_NFSD_PNFS
+	[FATTR4_FS_LAYOUT_TYPES]	= nfsd4_encode_fattr4_fs_layout_types,
+	[FATTR4_LAYOUT_HINT]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_LAYOUT_TYPES]		= nfsd4_encode_fattr4_layout_types,
+	[FATTR4_LAYOUT_BLKSIZE]		= nfsd4_encode_fattr4_layout_blksize,
+	[FATTR4_LAYOUT_ALIGNMENT]	= nfsd4_encode_fattr4__noop,
+#else
+	[FATTR4_FS_LAYOUT_TYPES]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_LAYOUT_HINT]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_LAYOUT_TYPES]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_LAYOUT_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_LAYOUT_ALIGNMENT]	= nfsd4_encode_fattr4__noop,
+#endif
+
+	[FATTR4_FS_LOCATIONS_INFO]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_MDSTHRESHOLD]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RETENTION_GET]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RETENTION_SET]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RETENTEVT_GET]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RETENTEVT_SET]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_RETENTION_HOLD]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_MODE_SET_MASKED]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_SUPPATTR_EXCLCREAT]	= nfsd4_encode_fattr4_suppattr_exclcreat,
+	[FATTR4_FS_CHARSET_CAP]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_SPACE_FREED]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CHANGE_ATTR_TYPE]	= nfsd4_encode_fattr4__noop,
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	[FATTR4_SEC_LABEL]		= nfsd4_encode_fattr4_sec_label,
+#else
+	[FATTR4_SEC_LABEL]		= nfsd4_encode_fattr4__noop,
+#endif
+
+	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+};
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3361,13 +3472,10 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 static __be32
 nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		struct svc_export *exp,
-		struct dentry *dentry, u32 *bmval,
+		struct dentry *dentry, const u32 *bmval,
 		struct svc_rqst *rqstp, int ignore_crossmnt)
 {
 	struct nfsd4_fattr_args args;
-	u32 bmval0 = bmval[0];
-	u32 bmval1 = bmval[1];
-	u32 bmval2 = bmval[2];
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
 	__be32 *attrlen_p, status;
@@ -3379,23 +3487,32 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
+	unsigned long bit, *mask;
+	u32 attrmask[3];
 
-	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
-	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
+	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
+	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
 
 	args.rqstp = rqstp;
 	args.exp = exp;
 	args.dentry = dentry;
 	args.ignore_crossmnt = (ignore_crossmnt != 0);
 
+	/*
+	 * Make a local copy of the attribute bitmap that can be modified.
+	 */
+	attrmask[0] = bmval[0];
+	attrmask[1] = bmval[1];
+	attrmask[2] = bmval[2];
+
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
-		status = fattr_handle_absent_fs(&bmval0, &bmval1, &bmval2,
-						&args.rdattr_err);
+		status = fattr_handle_absent_fs(&attrmask[0], &attrmask[1],
+						&attrmask[2], &args.rdattr_err);
 		if (status)
 			goto out;
 	}
-	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
 		if (status)
 			goto out;
@@ -3409,16 +3526,17 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
-		bmval1 &= ~FATTR4_WORD1_TIME_CREATE;
-	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	if ((attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
-	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
+	    (attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
 		err = vfs_statfs(&path, &args.statfs);
 		if (err)
 			goto out_nfserr;
 	}
-	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
+	    !fhp) {
 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 		status = nfserr_jukebox;
 		if (!tempfh)
@@ -3432,10 +3550,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		args.fhp = fhp;
 
 	args.acl = NULL;
-	if (bmval0 & FATTR4_WORD0_ACL) {
+	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
 		if (err == -EOPNOTSUPP)
-			bmval0 &= ~FATTR4_WORD0_ACL;
+			attrmask[0] &= ~FATTR4_WORD0_ACL;
 		else if (err == -EINVAL) {
 			status = nfserr_attrnotsupp;
 			goto out;
@@ -3447,24 +3565,25 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	args.context = NULL;
-	if ((bmval2 & FATTR4_WORD2_SECURITY_LABEL) ||
-	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
+	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
+	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
 						&args.context, &args.contextlen);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
-		if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
+		if (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
 			if (err == -EOPNOTSUPP)
-				bmval2 &= ~FATTR4_WORD2_SECURITY_LABEL;
+				attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 			else if (err)
 				goto out_nfserr;
 		}
 	}
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
-	status = nfsd4_encode_bitmap4(xdr, bmval0, bmval1, bmval2);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0],
+				      attrmask[1], attrmask[2]);
 	if (status)
 		goto out;
 
@@ -3472,276 +3591,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!attrlen_p)
 		goto out_resource;
-
-	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
-		status = nfsd4_encode_fattr4_supported_attrs(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_TYPE) {
-		status = nfsd4_encode_fattr4_type(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FH_EXPIRE_TYPE) {
-		status = nfsd4_encode_fattr4_fh_expire_type(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_CHANGE) {
-		status = nfsd4_encode_fattr4_change(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_SIZE) {
-		status = nfsd4_encode_fattr4_size(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_SYMLINK_SUPPORT) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_NAMED_ATTR) {
-		status = nfsd4_encode_fattr4__false(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FSID) {
-		status = nfsd4_encode_fattr4_fsid(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_UNIQUE_HANDLES) {
-		status = nfsd4_encode_fattr4__false(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
-		status = nfsd4_encode_fattr4_lease_time(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR) {
-		status = nfsd4_encode_fattr4_rdattr_error(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_ACL) {
-		status = nfsd4_encode_fattr4_acl(xdr, &args);
-		if (status)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_ACLSUPPORT) {
-		status = nfsd4_encode_fattr4_aclsupport(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_CANSETTIME) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
-		status = nfsd4_encode_fattr4__false(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_CHOWN_RESTRICTED) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
-		status = nfsd4_encode_fattr4_filehandle(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FILEID) {
-		status = nfsd4_encode_fattr4_fileid(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
-		status = nfsd4_encode_fattr4_files_avail(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
-		status = nfsd4_encode_fattr4_files_free(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
-		status = nfsd4_encode_fattr4_files_total(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
-		status = nfsd4_encode_fattr4_fs_locations(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_MAXFILESIZE) {
-		status = nfsd4_encode_fattr4_maxfilesize(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_MAXLINK) {
-		status = nfsd4_encode_fattr4_maxlink(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_MAXNAME) {
-		status = nfsd4_encode_fattr4_maxname(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_MAXREAD) {
-		status = nfsd4_encode_fattr4_maxread(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
-		status = nfsd4_encode_fattr4_maxwrite(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_MODE) {
-		status = nfsd4_encode_fattr4_mode(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
-		status = nfsd4_encode_fattr4__true(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_NUMLINKS) {
-		status = nfsd4_encode_fattr4_numlinks(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_OWNER) {
-		status = nfsd4_encode_fattr4_owner(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
-		status = nfsd4_encode_fattr4_owner_group(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_RAWDEV) {
-		status = nfsd4_encode_fattr4_rawdev(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
-		status = nfsd4_encode_fattr4_space_avail(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
-		status = nfsd4_encode_fattr4_space_free(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
-		status = nfsd4_encode_fattr4_space_total(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
-		status = nfsd4_encode_fattr4_space_used(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
-		status = nfsd4_encode_fattr4_time_access(xdr, &args);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		status = nfsd4_encode_fattr4_time_create(xdr, &args);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
-		status = nfsd4_encode_fattr4_time_delta(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		status = nfsd4_encode_fattr4_time_metadata(xdr, &args);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		status = nfsd4_encode_fattr4_time_modify(xdr, &args);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		status = nfsd4_encode_fattr4_mounted_on_fileid(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-#ifdef CONFIG_NFSD_PNFS
-	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {
-		status = nfsd4_encode_fattr4_fs_layout_types(xdr, &args);
-		if (status)
-			goto out;
-	}
-
-	if (bmval2 & FATTR4_WORD2_LAYOUT_TYPES) {
-		status = nfsd4_encode_fattr4_layout_types(xdr, &args);
-		if (status)
-			goto out;
-	}
-
-	if (bmval2 & FATTR4_WORD2_LAYOUT_BLKSIZE) {
-		status = nfsd4_encode_fattr4_layout_blksize(xdr, &args);
+	mask = (unsigned long *)attrmask;
+	for_each_set_bit(bit, mask, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
+		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
 		if (status != nfs_ok)
 			goto out;
 	}
-#endif /* CONFIG_NFSD_PNFS */
-	if (bmval2 & FATTR4_WORD2_SUPPATTR_EXCLCREAT) {
-		status = nfsd4_encode_fattr4_suppattr_exclcreat(xdr, &args);
-		if (status)
-			goto out;
-	}
-
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_fattr4_sec_label(xdr, &args);
-		if (status)
-			goto out;
-	}
-#endif
-
-	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
-		status = nfsd4_encode_fattr4_xattr_support(xdr, &args);
-		if (status != nfs_ok)
-			goto out;
-	}
-
 	*attrlen_p = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
 	status = nfs_ok;
 


