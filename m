Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24211479EBD
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhLSBo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhLSBoz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8DC061574
        for <linux-nfs@vger.kernel.org>; Sat, 18 Dec 2021 17:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370E860C63
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB14BC36AE9;
        Sun, 19 Dec 2021 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878293;
        bh=mcewRnT0CEgizuQUK0rKMjzB+cN1Q8v+6KeMfTTrBao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpHsCYxUzEObughhcOI5aw9kZn+Iyc5/9ckkDn5ba3YMxwFxWzAsYo7LBpVA6xku5
         B2oRjNCfdEJ/NVwPM7Kg8ueyIWwYQ8ZHWNgc+g6ijWYEc9L4G1a201xRgqTWHJxcdn
         4TlVxtdavwV5EI+BU8M2Hr56gzKy8LbXESfGw9YezDVB3mvXiY7phRygCiJm92X/nj
         HVLld+C2/Lxzzluhfh18nkHSaMWSHC8llFTaR2NXt+in2EpgiBqj62Hze9ADYSy82J
         h/bW5XEvs/cR+eCkMfxo5tif+CMLi7nMpD080lxc65VlHqhdpwdQQUw9ffYFGd6QP6
         4wzxBX8dHoEMA==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/10] nfs: Add export support for weak cache consistency attributes
Date:   Sat, 18 Dec 2021 20:37:58 -0500
Message-Id: <20211219013803.324724-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-5-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Allow knfsd to request weak cache consistency attributes on files that
have delegations and/or have up to date attribute caches by propagating
the information to NFS that the attributes being requested are optional.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c          | 24 ++++++++++++++++++++++++
 fs/nfsd/nfs3xdr.c        |  8 ++++++--
 fs/nfsd/nfs4xdr.c        |  6 +++---
 fs/nfsd/vfs.c            | 14 ++++++++++++++
 fs/nfsd/vfs.h            |  5 +++--
 include/linux/exportfs.h |  3 +++
 6 files changed, 53 insertions(+), 7 deletions(-)

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
index 6adfc40722fa..df6e29796494 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -420,6 +420,9 @@ __svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			     const struct svc_fh *fhp, bool force)
 {
 	struct dentry *dentry = fhp->fh_dentry;
+	struct path path = {
+		.dentry = dentry,
+	};
 	struct kstat stat;
 
 	/*
@@ -427,9 +430,10 @@ __svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	 * stale file handle. In this case, no attributes are
 	 * returned.
 	 */
-	if (!force || !dentry || !d_really_is_positive(dentry))
+	if (!dentry || !d_really_is_positive(dentry))
 		goto no_post_op_attrs;
-	if (fh_getattr(fhp, &stat) != nfs_ok)
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	if (nfsd_getattr(&path, &stat, force) != nfs_ok)
 		goto no_post_op_attrs;
 
 	if (xdr_stream_encode_item_present(xdr) < 0)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..8026925c121f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2862,9 +2862,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
index 0faa3839ea6c..eb9818432149 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2411,3 +2411,17 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
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

