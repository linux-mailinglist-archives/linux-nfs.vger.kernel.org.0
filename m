Return-Path: <linux-nfs+bounces-17439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE7CF11EA
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 584BD30065A9
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100864400;
	Sun,  4 Jan 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSpeI4XK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5D26E6F4
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543026; cv=none; b=DDC/8oy92o/O9ry+pYtEBjDurdCSE8esFWzgNzQZX/09VwnS+UK/myLGwKCedvV+uU/1kVs64LDxKGurJxm+1XIkDgU4TYsVkJxkT3rHzdl5dz+N0Xo+UPtoOMr0t/NHyZGmhWu0jnP5TaNcyf45lGiL8bdrUBmZUSoi7Pp9dkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543026; c=relaxed/simple;
	bh=GsrSfEwMP4YqbhtMb2GGSCuuEMvmEqsWq5ZLUCB8XVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJxSjLYEnF57L7EADPX38wFcvj79aIOaPEyr1GzcaMe8bHrEIOi4LsabEo7LWru6UKBx0CGSPff9jlnzwEDajSpZBVVEBJ27RdFjQJh0QDPpn9n3xVQMkjgraIrrqBKjH7sSdbEAukKwdKvAYU6PUHSXKCHGTeHDvQ7erg9CJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSpeI4XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01D8C19421;
	Sun,  4 Jan 2026 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543026;
	bh=GsrSfEwMP4YqbhtMb2GGSCuuEMvmEqsWq5ZLUCB8XVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSpeI4XK4m+q/1lqB+AQcVhiN9AL9EqpO9HOIJSo637mNx86ypTbYXKIyhSs6xNf9
	 ZfL/KINHk/lK24CcSFxnPL+S+gAG663gWoPhNTZcIY9f3L0AAoDIKf/Xiov4tLJiNs
	 45xAHOH/jUL21sAI0crdtpbuzNfnXkJH5RPU3SLYBQ7C6YS3urNMxNJtqtRma2RZoa
	 ArKRXB/CjP6CG/j2RQsz7on2ylZvSgHypVDc79aChoqjKvkG1/qFXEdET6RNTTYVQx
	 9A9gm6QyuQyy8O6vbtGmlY4GAK1Yk7d6ekR+bIXbz55UWSdY2WBfEISfGEgrZFoG4/
	 2kXGCLveuWKPg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 05/12] NFSD: Add nfsd4_encode_fattr4_posix_default_acl
Date: Sun,  4 Jan 2026 11:10:15 -0500
Message-ID: <20260104161019.3404489-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161019.3404489-1-cel@kernel.org>
References: <20260104161019.3404489-1-cel@kernel.org>
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


