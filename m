Return-Path: <linux-nfs+bounces-17700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8351D0B412
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB564311F046
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C73644CB;
	Fri,  9 Jan 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpTzipBp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588C272803
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975714; cv=none; b=R81qAWhOR1lWRyRAgVf5zH5UM7y8fPOFvQDCwfvgN/a6iyHM5d6Kri2seegT7c1/+334+3HpzHW6DpTgTBTk0gK0l/jM6DH40Sd9nZOdHQRGb0/bQx4nG7a2Rf35c5iamMVwOn8nbmPhOMOygOPJdiZ0JNGccpJLOGZ5FaK5ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975714; c=relaxed/simple;
	bh=lMhV0wRdKVSXy7kMBRLBwi/7KOQkBOay3o083AEDk/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktRSJWbgGKcfqYLBWInQ4eKmgzN7ZtJlzvQ5matpFpqxEf5VD4kyYU7Gtjskx/JQKQZEmmP/QzFyv8q8ffOGrOob8+uZmVzMraRrVJKBmUr6tfl5TEGckk9Yct1ZRrbyiB9PPtCOuO+IsnqVJRm/ZiaiP/qHgCpTa08VPm7gP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpTzipBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96190C19422;
	Fri,  9 Jan 2026 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975714;
	bh=lMhV0wRdKVSXy7kMBRLBwi/7KOQkBOay3o083AEDk/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpTzipBpGkh6xFrEJmF6oZn5Z00d1juKqqAtftx0OpIl66E4Q2Kg8YF+uvHlJnFa0
	 Tp4HEw3fz5wEVOge8rI+EgGXlrJRnME3UnTtFwNR/IHTQMr2mLFQOKB8nWDwUpQTrn
	 nABV9Cvj094AjUXbNjMrCC+uURJXpBSkwZmy7N/9NiR9t9ygRR1WRQWNqJcEp1d00i
	 yxAXcZDw9DhSJ7BnMunFrDydKW2ri7grlNdXla6vA6o+jD7fENmTf7iZnEUyBJwWKW
	 Dfquh+pFqVG04OwpNUPc6KWsuzk7i/WfPcr4h7qF4NE+Gg36FIoSaHhkv8lW5aOV50
	 +tglG4IF/sx+Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 06/13] NFSD: Add nfsd4_encode_fattr4_posix_default_acl
Date: Fri,  9 Jan 2026 11:21:35 -0500
Message-ID: <20260109162143.4186112-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The POSIX ACL extension to NFSv4 defines FATTR4_POSIX_DEFAULT_ACL
for retrieving a directory's default ACL. This patch adds the
XDR encoder for that attribute.

For directories, the default ACL is retrieved via get_inode_acl()
and each entry is encoded as a posixace4: tag type, permission
bits, and principal name (empty for structural entries like
USER_OBJ/GROUP_OBJ/MASK/OTHER, resolved via idmapping for
USER/GROUP entries).

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 63295cff23ed..781f662d8918 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -43,6 +43,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/xattr.h>
 #include <linux/vmalloc.h>
+#include <linux/nfsacl.h>
 
 #include <uapi/linux/xattr.h>
 
@@ -2849,6 +2850,89 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 { return 0; }
 #endif
 
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+
+static int nfsd4_posix_tagtotype(short tag)
+{
+	switch (tag) {
+	case ACL_USER_OBJ:	return POSIXACE4_TAG_USER_OBJ;
+	case ACL_GROUP_OBJ:	return POSIXACE4_TAG_GROUP_OBJ;
+	case ACL_USER:		return POSIXACE4_TAG_USER;
+	case ACL_GROUP:		return POSIXACE4_TAG_GROUP;
+	case ACL_MASK:		return POSIXACE4_TAG_MASK;
+	case ACL_OTHER:		return POSIXACE4_TAG_OTHER;
+	default:		return -EINVAL;
+	}
+}
+
+static __be32
+nfsd4_encode_posixace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
+		       struct posix_acl_entry *acep)
+{
+	__be32 status;
+	int type;
+
+	type = nfsd4_posix_tagtotype(acep->e_tag);
+	if (type < 0)
+		return nfserr_resource;
+	if (!xdrgen_encode_posixacetag4(xdr, type))
+		return nfserr_resource;
+	if (!xdrgen_encode_posixaceperm4(xdr, acep->e_perm))
+		return nfserr_resource;
+
+	/* who */
+	switch (acep->e_tag) {
+	case ACL_USER_OBJ:
+	case ACL_GROUP_OBJ:
+	case ACL_MASK:
+	case ACL_OTHER:
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		break;
+	case ACL_USER:
+		status = nfsd4_encode_user(xdr, rqstp, acep->e_uid);
+		if (status != nfs_ok)
+			return status;
+		break;
+	case ACL_GROUP:
+		status = nfsd4_encode_group(xdr, rqstp, acep->e_gid);
+		if (status != nfs_ok)
+			return status;
+		break;
+	default:
+		return nfserr_resource;
+	}
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_encode_posixacl(struct xdr_stream *xdr, struct svc_rqst *rqstp,
+		      struct posix_acl *acl)
+{
+	__be32 status;
+	int i;
+
+	if (!acl) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
+	if (acl->a_count > NFS_ACL_MAX_ENTRIES)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, acl->a_count) != XDR_UNIT)
+		return nfserr_resource;
+	for (i = 0; i < acl->a_count; i++) {
+		status = nfsd4_encode_posixace4(xdr, rqstp, &acl->a_entries[i]);
+		if (status != nfs_ok)
+			return status;
+	}
+
+	return nfs_ok;
+}
+
+#endif /* CONFIG_NFSD_V4_POSIX_ACL */
+
 static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *bmval2, u32 *rdattr_err)
 {
 	/* As per referral draft:  */
@@ -2929,6 +3013,9 @@ struct nfsd4_fattr_args {
 	u64			change_attr;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	struct lsm_context	context;
+#endif
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	struct posix_acl	*dpacl;
 #endif
 	u32			rdattr_err;
 	bool			contextsupport;
@@ -3492,6 +3579,12 @@ static __be32 nfsd4_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_posix_default_acl(struct xdr_stream *xdr,
+						    const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_posixacl(xdr, args->rqstp, args->dpacl);
+}
+
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
@@ -3605,9 +3698,11 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
 	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4_acl_trueform_scope,
+	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4_posix_default_acl,
 #else
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4__noop,
 #endif
 };
 
@@ -3649,6 +3744,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	args.context.context = NULL;
 #endif
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	args.dpacl = NULL;
+#endif
 
 	/*
 	 * Make a local copy of the attribute bitmap that can be modified.
@@ -3755,6 +3853,32 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	}
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	if (attrmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) {
+		struct inode *inode = d_inode(dentry);
+		struct posix_acl *dpacl;
+
+		if (S_ISDIR(inode->i_mode)) {
+			dpacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
+			if (IS_ERR(dpacl)) {
+				switch (PTR_ERR(dpacl)) {
+				case -EOPNOTSUPP:
+					attrmask[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+					break;
+				case -EINVAL:
+					status = nfserr_attrnotsupp;
+					goto out;
+				default:
+					err = PTR_ERR(dpacl);
+					goto out_nfserr;
+				}
+			} else {
+				args.dpacl = dpacl;
+			}
+		}
+	}
+#endif /* CONFIG_NFSD_V4_POSIX_ACLS */
+
 	/* attrmask */
 	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
 				      attrmask[2]);
@@ -3778,6 +3902,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	status = nfs_ok;
 
 out:
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	if (args.dpacl)
+		posix_acl_release(args.dpacl);
+#endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (args.context.context)
 		security_release_secctx(&args.context);
-- 
2.52.0


