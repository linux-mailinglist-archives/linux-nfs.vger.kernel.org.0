Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368C2C8FFE
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbgK3VZo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388607AbgK3VZo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:25:44 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03576208FE;
        Mon, 30 Nov 2020 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606771503;
        bh=ehKoeRQqCtqwzwU9iqCAkFba82xZ6gMw2ZiEuos4uc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4DOkHrxLeBCFtZxEAma1s/JgZC89G/UI/mO1JNbo9eqCJaG+8g726dOi0Ff4tzyi
         zukgVh4Zm5iNM3DFIL9r+uD6fdbjRHLfTJT/VfHCPBr+pqyfB249mORl9dMEgejt0v
         APKKM0nFqC4oJWnJzbBvS+6deGaV64/i9cTvKLiQ=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] exportfs: Add a function to return the raw output from fh_to_dentry()
Date:   Mon, 30 Nov 2020 16:24:53 -0500
Message-Id: <20201130212455.254469-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130212455.254469-4-trondmy@kernel.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
 <20201130212455.254469-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to allow nfsd to accept return values that are not
acceptable to overlayfs and others, add a new function.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/exportfs/expfs.c      | 32 ++++++++++++++++++++++++--------
 include/linux/exportfs.h |  5 +++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 2dd55b172d57..0106eba46d5a 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -417,9 +417,11 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_fh);
 
-struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
-		int fh_len, int fileid_type,
-		int (*acceptable)(void *, struct dentry *), void *context)
+struct dentry *
+exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
+		       int fileid_type,
+		       int (*acceptable)(void *, struct dentry *),
+		       void *context)
 {
 	const struct export_operations *nop = mnt->mnt_sb->s_export_op;
 	struct dentry *result, *alias;
@@ -432,10 +434,8 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 	if (!nop || !nop->fh_to_dentry)
 		return ERR_PTR(-ESTALE);
 	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
-	if (PTR_ERR(result) == -ENOMEM)
-		return ERR_CAST(result);
 	if (IS_ERR_OR_NULL(result))
-		return ERR_PTR(-ESTALE);
+		return result;
 
 	/*
 	 * If no acceptance criteria was specified by caller, a disconnected
@@ -561,10 +561,26 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 
  err_result:
 	dput(result);
-	if (err != -ENOMEM)
-		err = -ESTALE;
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(exportfs_decode_fh_raw);
+
+struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
+				  int fh_len, int fileid_type,
+				  int (*acceptable)(void *, struct dentry *),
+				  void *context)
+{
+	struct dentry *ret;
+
+	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
+				     acceptable, context);
+	if (IS_ERR_OR_NULL(ret)) {
+		if (ret == ERR_PTR(-ENOMEM))
+			return ret;
+		return ERR_PTR(-ESTALE);
+	}
+	return ret;
+}
 EXPORT_SYMBOL_GPL(exportfs_decode_fh);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index d829403ffd3b..846df3c96730 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -223,6 +223,11 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 	int *max_len, int connectable);
+extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
+					     struct fid *fid, int fh_len,
+					     int fileid_type,
+					     int (*acceptable)(void *, struct dentry *),
+					     void *context);
 extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 	int fh_len, int fileid_type, int (*acceptable)(void *, struct dentry *),
 	void *context);
-- 
2.28.0

