Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FC743245
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF3Be4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF3Bev (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62962974
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E5361583
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 01:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C01C433C0;
        Fri, 30 Jun 2023 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088888;
        bh=GZ5Mg+M0GTMsj6m/ghtYGJ7MxWBdC+aJ6MR+GXWkQzg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BY16OYcNR93PnyzbpB0QXQhNbXR63ToXFBx7Xi4HzYwXNcE0z/J7nwtiw7jAv3PaN
         aNj4oFZp9GgjkqoRYjZVoO+aSE2GP3bIGRuLFQWrBG0Mr3lyZRrcvB5Tu4qUPYElLd
         Dk//2y3GItds+ZdEk4+eI/p84jzLFsH0mHvhcNAxZGoxLqQe8BfCOGZzRAjM7JUF5N
         GNjesmYpKkEwFHa/qJpzep3sDzkDqScjC2yzGB5Iu2QAXVDAo1S01WaUGonUomd10+
         cKuGwO1T01+EH+DCy+VFyBpQ+SxNA0v/BfwtVRlwzwy1UgEZqtLNK1ZDJ2x4CklUm5
         DLAVhZI+kjq8g==
Subject: [PATCH RFC 2/4] NFSD: Encode attributes in WORD0 using a bitmask loop
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 29 Jun 2023 21:34:47 -0400
Message-ID: <168808888743.7728.8019458825069278051.stgit@manet.1015granger.net>
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

Replace the current implementation with a branch table. This creates
hard function scope boundaries, limiting side effects and reducing
instruction cache footprint (uncalled encoders remain out of the
cache).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  598 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 341 insertions(+), 257 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a22a6015afe5..20e09e5510c9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2939,7 +2939,10 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 }
 
 struct nfsd4_fattr_args {
+	struct svc_rqst		*rqstp;
 	struct svc_fh		*fhp;
+	struct svc_export	*exp;
+	struct dentry		*dentry;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -2947,6 +2950,332 @@ struct nfsd4_fattr_args {
 	bool			contextsupport;
 };
 
+typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
+				struct nfsd4_fattr_args *args);
+
+static __be32 nfsd4_encode_fattr4__noop(struct xdr_stream *xdr,
+					struct nfsd4_fattr_args *args)
+{
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4__true(struct xdr_stream *xdr,
+					struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_bool(xdr, true) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4__false(struct xdr_stream *xdr,
+					 struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_bool(xdr, false) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_supported_attrs(struct xdr_stream *xdr,
+						  struct nfsd4_fattr_args *args)
+{
+	struct nfsd4_compoundres *resp = args->rqstp->rq_resp;
+	u32 minorversion = resp->cstate.minorversion;
+	u32 supp[3];
+
+	memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
+	if (!IS_POSIXACL(args->dentry->d_inode))
+		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!args->contextsupport)
+		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+
+	return nfsd4_encode_bitmap(xdr, supp[0], supp[1], supp[2]);
+}
+
+static __be32 nfsd4_encode_fattr4_type(struct xdr_stream *xdr,
+				       struct nfsd4_fattr_args *args)
+{
+	u32 type = nfs4_file_type(args->stat.mode);
+	__be32 *p;
+
+	if (type == NF4BAD)
+		return nfserr_serverfault;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!p)
+		return nfserr_resource;
+
+	*p = cpu_to_be32(type);
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_fh_expire_type(struct xdr_stream *xdr,
+						 struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!p)
+		return nfserr_resource;
+
+	if (args->exp->ex_flags & NFSEXP_NOSUBTREECHECK)
+		*p = cpu_to_be32(NFS4_FH_PERSISTENT);
+	else
+		*p = cpu_to_be32(NFS4_FH_PERSISTENT | NFS4_FH_VOL_RENAME);
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
+					 struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+	if (!p)
+		return nfserr_resource;
+
+	encode_change(p, &args->stat, d_inode(args->dentry), args->exp);
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
+				       struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, args->stat.size) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_fsid(struct xdr_stream *xdr,
+				       struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 4);
+	if (!p)
+		return nfserr_resource;
+
+	if (unlikely(args->exp->ex_fslocs.migrated)) {
+		p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MAJOR);
+		xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
+		return nfs_ok;
+	}
+
+	switch (fsid_source(args->fhp)) {
+	case FSIDSOURCE_FSID:
+		p = xdr_encode_hyper(p, (u64)args->exp->ex_fsid);
+		xdr_encode_hyper(p, (u64)0);
+		break;
+	case FSIDSOURCE_DEV:
+		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(MAJOR(args->stat.dev));
+		*p++ = cpu_to_be32(0);
+		*p   = cpu_to_be32(MINOR(args->stat.dev));
+		break;
+	case FSIDSOURCE_UUID:
+		xdr_encode_opaque_fixed(p, args->exp->ex_uuid, EX_UUID_LEN);
+		break;
+	}
+
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_lease_time(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(args->rqstp), nfsd_net_id);
+
+	if (xdr_stream_encode_u32(xdr, nn->nfsd4_lease) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_rdattr_error(struct xdr_stream *xdr,
+					       struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, args->rdattr_err) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
+				      struct nfsd4_fattr_args *args)
+{
+	struct nfs4_acl *acl = args->acl;
+	struct nfs4_ace *ace;
+	__be32 *p, status;
+
+	if (!acl) {
+		if (xdr_stream_encode_item_absent(xdr) < 0)
+			return nfserr_resource;
+		p = xdr_reserve_space(xdr, XDR_UNIT);
+		if (!p)
+			return nfserr_resource;
+		*p = cpu_to_be32(IS_POSIXACL(d_inode(args->dentry)) ?
+				 ACL4_SUPPORT_ALLOW_ACL | ACL4_SUPPORT_DENY_ACL : 0);
+		return nfs_ok;
+	}
+
+	if (xdr_stream_encode_u32(xdr, acl->naces) < 0)
+		return nfserr_resource;
+
+	for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
+		p = xdr_reserve_space(xdr, XDR_UNIT * 3);
+		if (!p)
+			return nfserr_resource;
+
+		*p++ = cpu_to_be32(ace->type);
+		*p++ = cpu_to_be32(ace->flag);
+		*p   = cpu_to_be32(ace->access_mask & NFS4_ACE_MASK_ALL);
+		status = nfsd4_encode_aclname(xdr, args->rqstp, ace);
+		if (status)
+			return status;
+	}
+
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_aclsupport(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!p)
+		return nfserr_resource;
+
+	*p = cpu_to_be32(IS_POSIXACL(d_inode(args->dentry)) ?
+			 ACL4_SUPPORT_ALLOW_ACL | ACL4_SUPPORT_DENY_ACL : 0);
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, args->fhp->fh_handle.fh_size + 4);
+	if (!p)
+		return nfserr_resource;
+
+	xdr_encode_opaque(p, &args->fhp->fh_handle.fh_raw,
+			  args->fhp->fh_handle.fh_size);
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
+					 struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, args->stat.ino) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_files_avail(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, args->statfs.f_ffree) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_files_free(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, args->statfs.f_ffree) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_files_total(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, args->statfs.f_files) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_fs_locations(struct xdr_stream *xdr,
+					       struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_fs_locations(xdr, args->rqstp, args->exp);
+}
+
+static __be32 nfsd4_encode_fattr4_maxfilesize(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr,
+				  args->exp->ex_path.mnt->mnt_sb->s_maxbytes) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_maxlink(struct xdr_stream *xdr,
+					  struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, 255) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_maxname(struct xdr_stream *xdr,
+					  struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, args->statfs.f_namelen) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_maxread(struct xdr_stream *xdr,
+					  struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, svc_max_payload(args->rqstp)) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_maxwrite(struct xdr_stream *xdr,
+					   struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u64(xdr, svc_max_payload(args->rqstp)) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static const nfsd4_enc_attr nfsd4_enc_fattr4_word0_ops[] = {
+	[0]		= nfsd4_encode_fattr4_supported_attrs,
+	[1]		= nfsd4_encode_fattr4_type,
+	[2]		= nfsd4_encode_fattr4_fh_expire_type,
+	[3]		= nfsd4_encode_fattr4_change,
+	[4]		= nfsd4_encode_fattr4_size,
+	[5]		= nfsd4_encode_fattr4__true,	/* link support */
+	[6]		= nfsd4_encode_fattr4__true,	/* symlink support */
+	[7]		= nfsd4_encode_fattr4__false,	/* named attributes */
+	[8]		= nfsd4_encode_fattr4_fsid,
+	[9]		= nfsd4_encode_fattr4__true,	/* unique handles */
+	[10]		= nfsd4_encode_fattr4_lease_time,
+	[11]		= nfsd4_encode_fattr4_rdattr_error,
+	[12]		= nfsd4_encode_fattr4_acl,
+	[13]		= nfsd4_encode_fattr4_aclsupport,
+	[14]		= nfsd4_encode_fattr4__noop,	/* archive */
+	[15]		= nfsd4_encode_fattr4__true,	/* can set time */
+	[16]		= nfsd4_encode_fattr4__false,	/* case insensitive */
+	[17]		= nfsd4_encode_fattr4__true,	/* case preserving */
+	[18]		= nfsd4_encode_fattr4__true,	/* chown restricted */
+	[19]		= nfsd4_encode_fattr4_filehandle,
+	[20]		= nfsd4_encode_fattr4_fileid,
+	[21]		= nfsd4_encode_fattr4_files_avail,
+	[22]		= nfsd4_encode_fattr4_files_free,
+	[23]		= nfsd4_encode_fattr4_files_total,
+	[24]		= nfsd4_encode_fattr4_fs_locations,
+	[25]		= nfsd4_encode_fattr4__noop,	/* hidden */
+	[26]		= nfsd4_encode_fattr4__true,	/* homogeneous */
+	[27]		= nfsd4_encode_fattr4_maxfilesize,
+	[28]		= nfsd4_encode_fattr4_maxlink,
+	[29]		= nfsd4_encode_fattr4_maxname,
+	[30]		= nfsd4_encode_fattr4_maxread,
+	[31]		= nfsd4_encode_fattr4_maxwrite,
+};
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2962,27 +3291,27 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	u32 bmval1 = bmval[1];
 	u32 bmval2 = bmval[2];
 	struct svc_fh *tempfh = NULL;
-	__be32 *p, *attrlen_p;
 	int starting_len = xdr->buf->len;
-	int attrlen_offset;
-	u32 dummy;
 	u64 dummy64;
-	__be32 status;
-	int err;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void *context = NULL;
 	int contextlen;
 #endif
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
+	int err, i, attrlen_offset;
+	__be32 status, *attrlen_p;
 	struct path path = {
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	unsigned long mask;
+	__be32 *p;
 
-	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
-	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
+	args.rqstp = rqstp;
+	args.fhp = fhp;
+	args.exp = exp;
+	args.dentry = dentry;
 
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
@@ -3063,258 +3392,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	if (!attrlen_p)
 		goto out_resource;
 
-	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
-		u32 supp[3];
-
-		memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-
-		if (!IS_POSIXACL(dentry->d_inode))
-			supp[0] &= ~FATTR4_WORD0_ACL;
-		if (!args.contextsupport)
-			supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-		if (!supp[2]) {
-			p = xdr_reserve_space(xdr, 12);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(2);
-			*p++ = cpu_to_be32(supp[0]);
-			*p++ = cpu_to_be32(supp[1]);
-		} else {
-			p = xdr_reserve_space(xdr, 16);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(3);
-			*p++ = cpu_to_be32(supp[0]);
-			*p++ = cpu_to_be32(supp[1]);
-			*p++ = cpu_to_be32(supp[2]);
-		}
-	}
-	if (bmval0 & FATTR4_WORD0_TYPE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		dummy = nfs4_file_type(args.stat.mode);
-		if (dummy == NF4BAD) {
-			status = nfserr_serverfault;
-			goto out;
-		}
-		*p++ = cpu_to_be32(dummy);
-	}
-	if (bmval0 & FATTR4_WORD0_FH_EXPIRE_TYPE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
-			*p++ = cpu_to_be32(NFS4_FH_PERSISTENT);
-		else
-			*p++ = cpu_to_be32(NFS4_FH_PERSISTENT|
-						NFS4_FH_VOL_RENAME);
-	}
-	if (bmval0 & FATTR4_WORD0_CHANGE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = encode_change(p, &args.stat, d_inode(dentry), exp);
-	}
-	if (bmval0 & FATTR4_WORD0_SIZE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, args.stat.size);
-	}
-	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_SYMLINK_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_NAMED_ATTR) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
-	}
-	if (bmval0 & FATTR4_WORD0_FSID) {
-		p = xdr_reserve_space(xdr, 16);
-		if (!p)
-			goto out_resource;
-		if (exp->ex_fslocs.migrated) {
-			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MAJOR);
-			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
-		} else switch(fsid_source(args.fhp)) {
-		case FSIDSOURCE_FSID:
-			p = xdr_encode_hyper(p, (u64)exp->ex_fsid);
-			p = xdr_encode_hyper(p, (u64)0);
-			break;
-		case FSIDSOURCE_DEV:
-			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MAJOR(args.stat.dev));
-			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MINOR(args.stat.dev));
-			break;
-		case FSIDSOURCE_UUID:
-			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
-								EX_UUID_LEN);
-			break;
-		}
-	}
-	if (bmval0 & FATTR4_WORD0_UNIQUE_HANDLES) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
-	}
-	if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(nn->nfsd4_lease);
-	}
-	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.rdattr_err);
-	}
-	if (bmval0 & FATTR4_WORD0_ACL) {
-		struct nfs4_ace *ace;
-
-		if (args.acl == NULL) {
-			p = xdr_reserve_space(xdr, 4);
-			if (!p)
-				goto out_resource;
-
-			*p++ = cpu_to_be32(0);
-			goto out_acl;
-		}
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.acl->naces);
-
-		for (ace = args.acl->aces; ace < args.acl->aces + args.acl->naces; ace++) {
-			p = xdr_reserve_space(xdr, 4*3);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(ace->type);
-			*p++ = cpu_to_be32(ace->flag);
-			*p++ = cpu_to_be32(ace->access_mask &
-							NFS4_ACE_MASK_ALL);
-			status = nfsd4_encode_aclname(xdr, rqstp, ace);
-			if (status)
-				goto out;
-		}
-	}
-out_acl:
-	if (bmval0 & FATTR4_WORD0_ACLSUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(IS_POSIXACL(dentry->d_inode) ?
-			ACL4_SUPPORT_ALLOW_ACL|ACL4_SUPPORT_DENY_ACL : 0);
-	}
-	if (bmval0 & FATTR4_WORD0_CANSETTIME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
-	}
-	if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_CHOWN_RESTRICTED) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
-		p = xdr_reserve_space(xdr, args.fhp->fh_handle.fh_size + 4);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_opaque(p, &args.fhp->fh_handle.fh_raw,
-					args.fhp->fh_handle.fh_size);
-	}
-	if (bmval0 & FATTR4_WORD0_FILEID) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, args.stat.ino);
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
-	}
-	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_files);
-	}
-	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
-		status = nfsd4_encode_fs_locations(xdr, rqstp, exp);
+	mask = bmval0;
+	for_each_set_bit(i, &mask, 32) {
+		status = nfsd4_enc_fattr4_word0_ops[i](xdr, &args);
 		if (status)
 			goto out;
 	}
-	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval0 & FATTR4_WORD0_MAXFILESIZE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, exp->ex_path.mnt->mnt_sb->s_maxbytes);
-	}
-	if (bmval0 & FATTR4_WORD0_MAXLINK) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(255);
-	}
-	if (bmval0 & FATTR4_WORD0_MAXNAME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.statfs.f_namelen);
-	}
-	if (bmval0 & FATTR4_WORD0_MAXREAD) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) svc_max_payload(rqstp));
-	}
-	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) svc_max_payload(rqstp));
-	}
+
 	if (bmval1 & FATTR4_WORD1_MODE) {
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)


