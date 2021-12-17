Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF44796A4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhLQV5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhLQV5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F606B82AE1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52FBC36AE9;
        Fri, 17 Dec 2021 21:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778235;
        bh=kbXOWMHfDAatrQkEzimO/QP75+Rla1z/WzTHE3+sFfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXgcikOx4a4ymnO8VqpAsURyb+wMDomKcfCg4l+lgaTH9Bh2TjitbvDgWpLC/ICRs
         6dCVyJ04Rsw5IH/d9/NEgipDbA1WR6FgIRfPLVAroedRPOtOv/fv00uN94jJ9eGhFM
         3AWKvIZ0RkIJLqMpCbonjCBiVJ6BKxuiwjr70dN9gAztJbF4aet9G7bP3Kb1qabQxf
         tIPXl9xS970vWFQkph2AoLqzfIhEDmUkutRsflSgAQe/NzjHK1pUxbDc+J1E/QGI+x
         BUIiFw2QnqZNGyejfSNERgf/aubSelxPLXgfgJ8/Ef7oTrhn9OLFa4cJxup9ZBtvAG
         M15ib16WoU5Cw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/9] nfs: Add export support for weak cache consistency attributes
Date:   Fri, 17 Dec 2021 16:50:41 -0500
Message-Id: <20211217215046.40316-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-4-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Allow knfsd to request weak cache consistency attributes on files that
have delegations and/or have up to date attribute caches.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c          | 24 ++++++++++++
 fs/nfsd/nfs3xdr.c        | 83 +++++++++++++++++++++++++++-------------
 fs/nfsd/nfs4xdr.c        |  6 +--
 fs/nfsd/vfs.c            | 14 +++++++
 fs/nfsd/vfs.h            |  5 ++-
 include/linux/exportfs.h |  3 ++
 6 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 171c424cb6d5..967f8902c49b 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -151,10 +151,34 @@ static u64 nfs_fetch_iversion(struct inode *inode)
 	return inode_peek_iversion_raw(inode);
 }
 
+static int nfs_exp_getattr(struct path *path, struct kstat *stat, bool force)
+{
+	const unsigned long check_valid =
+		NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_ATIME |
+		NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME |
+		NFS_INO_INVALID_SIZE | /* NFS_INO_INVALID_BLOCKS | */
+		NFS_INO_INVALID_OTHER | NFS_INO_INVALID_NLINK;
+	struct inode *inode = d_inode(path->dentry);
+	int flags = force ? AT_STATX_SYNC_AS_STAT : AT_STATX_DONT_SYNC;
+	int ret, ret2 = 0;
+
+	if (!force && nfs_check_cache_invalid(inode, check_valid))
+		ret2 = -EAGAIN;
+	ret = vfs_getattr(path, stat, STATX_BASIC_STATS & ~STATX_BLOCKS, flags);
+	if (ret < 0)
+		return ret;
+	stat->blocks = nfs_calc_block_size(stat->size);
+	if (S_ISDIR(inode->i_mode))
+		stat->blksize = NFS_SERVER(inode)->dtsize;
+	stat->result_mask |= STATX_BLOCKS;
+	return ret2;
+}
+
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
+	.getattr = nfs_exp_getattr,
 	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..81b6cf228517 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -415,21 +415,14 @@ svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
 	return svcxdr_encode_wcc_attr(xdr, fhp);
 }
 
-/**
- * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
- * @rqstp: Context of a completed RPC transaction
- * @xdr: XDR stream
- * @fhp: File handle to encode
- *
- * Return values:
- *   %false: Send buffer space was exhausted
- *   %true: Success
- */
-bool
-svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
-			   const struct svc_fh *fhp)
+static bool
+__svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			     const struct svc_fh *fhp, bool force)
 {
 	struct dentry *dentry = fhp->fh_dentry;
+	struct path path = {
+		.dentry = dentry,
+	};
 	struct kstat stat;
 
 	/*
@@ -437,9 +430,10 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	 * stale file handle. In this case, no attributes are
 	 * returned.
 	 */
-	if (fhp->fh_no_wcc || !dentry || !d_really_is_positive(dentry))
+	if (!dentry || !d_really_is_positive(dentry))
 		goto no_post_op_attrs;
-	if (fh_getattr(fhp, &stat) != nfs_ok)
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	if (nfsd_getattr(&path, &stat, force) != nfs_ok)
 		goto no_post_op_attrs;
 
 	if (xdr_stream_encode_item_present(xdr) < 0)
@@ -454,6 +448,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return xdr_stream_encode_item_absent(xdr) > 0;
 }
 
+/**
+ * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
+ * @rqstp: Context of a completed RPC transaction
+ * @xdr: XDR stream
+ * @fhp: File handle to encode
+ *
+ * Return values:
+ *   %false: Send buffer space was exhausted
+ *   %true: Success
+ */
+bool
+svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			   const struct svc_fh *fhp)
+{
+	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, true);
+}
+
+static bool
+svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst *rqstp,
+					 struct xdr_stream *xdr,
+					 const struct svc_fh *fhp)
+{
+	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, !fhp->fh_no_wcc);
+}
+
 /*
  * Encode weak cache consistency data
  */
@@ -481,7 +500,7 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 neither:
 	if (xdr_stream_encode_item_absent(xdr) < 0)
 		return false;
-	if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
+	if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr, fhp))
 		return false;
 
 	return true;
@@ -879,11 +898,13 @@ int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
 			return 0;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->dirfh))
 			return 0;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->dirfh))
 			return 0;
 	}
 
@@ -901,13 +922,15 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
 			return 0;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 	}
 
@@ -926,7 +949,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
 			return 0;
@@ -935,7 +959,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 			return 0;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 	}
 
@@ -954,7 +979,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
 			return 0;
@@ -968,7 +994,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 			return 0;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 	}
 
@@ -1065,7 +1092,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
 			return 0;
@@ -1077,7 +1105,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 			return 0;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return 0;
 	}
 
@@ -1221,7 +1250,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
 	if (compose_entry_fh(resp, fhp, name, namlen, ino) != nfs_ok)
 		goto out_noattrs;
 
-	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
+	if (!svcxdr_encode_post_op_attr_opportunistic(resp->rqstp, xdr, fhp))
 		goto out;
 	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
 		goto out;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..e14af0383b70 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2865,9 +2865,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
-	if (err)
-		goto out_nfserr;
+	status = nfsd_getattr(&path, &stat, true);
+	if (status)
+		goto out;
 	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a90cc08211a3..4d57befdac6e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2412,3 +2412,17 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+
+__be32
+nfsd_getattr(struct path *p, struct kstat *stat, bool force)
+{
+	const struct export_operations *ops = p->dentry->d_sb->s_export_op;
+	int err;
+
+	if (ops->getattr)
+		err = ops->getattr(p, stat, force);
+	else
+		err = vfs_getattr(p, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
+	return err ? nfserrno(err) : 0;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b21b76e6b9a8..6edae1b9a96e 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -132,6 +132,8 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
 
+__be32		nfsd_getattr(struct path *p, struct kstat *, bool);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
@@ -156,8 +158,7 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
 	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
 			 .dentry = fh->fh_dentry};
-	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
-				    AT_STATX_SYNC_AS_STAT));
+	return nfsd_getattr(&p, stat, true);
 }
 
 static inline int nfsd_create_is_exclusive(int createmode)
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 3260fe714846..58f36022787e 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -10,6 +10,8 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
+struct path;
+struct kstat;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -224,6 +226,7 @@ struct export_operations {
 #define EXPORT_OP_SYNC_LOCKS		(0x20) /* Filesystem can't do
 						  asychronous blocking locks */
 	unsigned long	flags;
+	int (*getattr)(struct path *, struct kstat *, bool);
 };
 
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-- 
2.33.1

