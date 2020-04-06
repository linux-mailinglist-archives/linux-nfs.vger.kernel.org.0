Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5319FE21
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 21:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFTgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 15:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFTgH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 15:36:07 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD12206F5
        for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2020 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586201766;
        bh=ve3C8JGHOplU4sbU4ikKE9qhRnOGXbrlPy6qN5qo9qw=;
        h=From:To:Subject:Date:From;
        b=jYe8g/HXF8R/OQnDMQYvQbdz1P/3a4CmCVIqut1jQtKvgnt6tCFWpX0Lxmjthn6Je
         dJfXVwF9mIHAnVhxaPH2l0c2PBWdNhzI/eUYLJ5WNSXC7IDnMCS/cMVF0tuxelBAHJ
         L5Ps5YkbQAxQxjQVv+T/UlOsjM9wbPNO8u3KzE/E=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Clean up process of marking inode stale.
Date:   Mon,  6 Apr 2020 15:33:52 -0400
Message-Id: <20200406193353.101924-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of the various open coded calls to set the NFS_INO_STALE bit
and call nfs_zap_caches(), consolidate them into a single function
nfs_set_inode_stale().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           |  5 +++--
 fs/nfs/inode.c         | 18 +++++++++++++-----
 fs/nfs/nfstrace.h      |  1 +
 fs/nfs/read.c          |  2 +-
 include/linux/nfs_fs.h |  1 +
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f14184d0ba82..d729d8311c7e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2669,9 +2669,10 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	status = NFS_PROTO(inode)->access(inode, &cache);
 	if (status != 0) {
 		if (status == -ESTALE) {
-			nfs_zap_caches(inode);
 			if (!S_ISDIR(inode->i_mode))
-				set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
+				nfs_set_inode_stale(inode);
+			else
+				nfs_zap_caches(inode);
 		}
 		goto out;
 	}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a10fb87c6ac3..b9d0921cb4fe 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -62,7 +62,6 @@
 /* Default is to see 64-bit inode numbers */
 static bool enable_ino64 = NFS_64_BIT_INODE_NUMBERS_ENABLED;
 
-static void nfs_invalidate_inode(struct inode *);
 static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct kmem_cache * nfs_inode_cachep;
@@ -284,10 +283,18 @@ EXPORT_SYMBOL_GPL(nfs_invalidate_atime);
  * Invalidate, but do not unhash, the inode.
  * NB: must be called with inode->i_lock held!
  */
-static void nfs_invalidate_inode(struct inode *inode)
+static void nfs_set_inode_stale_locked(struct inode *inode)
 {
 	set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
 	nfs_zap_caches_locked(inode);
+	trace_nfs_set_inode_stale(inode);
+}
+
+void nfs_set_inode_stale(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	nfs_set_inode_stale_locked(inode);
+	spin_unlock(&inode->i_lock);
 }
 
 struct nfs_find_desc {
@@ -1163,9 +1170,10 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 				status = 0;
 			break;
 		case -ESTALE:
-			nfs_zap_caches(inode);
 			if (!S_ISDIR(inode->i_mode))
-				set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
+				nfs_set_inode_stale(inode);
+			else
+				nfs_zap_caches(inode);
 		}
 		goto err_out;
 	}
@@ -2064,7 +2072,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	 * lookup validation will know that the inode is bad.
 	 * (But we fall through to invalidate the caches.)
 	 */
-	nfs_invalidate_inode(inode);
+	nfs_set_inode_stale_locked(inode);
 	return -ESTALE;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index a9588d19a5ae..7e7a97ae21ed 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -181,6 +181,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 				int error \
 			), \
 			TP_ARGS(inode, error))
+DEFINE_NFS_INODE_EVENT(nfs_set_inode_stale);
 DEFINE_NFS_INODE_EVENT(nfs_refresh_inode_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_refresh_inode_exit);
 DEFINE_NFS_INODE_EVENT(nfs_revalidate_inode_enter);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 34bb9add2302..13b22e898116 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -250,7 +250,7 @@ static int nfs_readpage_done(struct rpc_task *task,
 	trace_nfs_readpage_done(task, hdr);
 
 	if (task->tk_status == -ESTALE) {
-		set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
+		nfs_set_inode_stale(inode);
 		nfs_mark_for_revalidate(inode);
 	}
 	return 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5d5b91e54f73..73eda45f1cfd 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -354,6 +354,7 @@ static inline unsigned long nfs_save_change_attribute(struct inode *dir)
 extern int nfs_sync_mapping(struct address_space *mapping);
 extern void nfs_zap_mapping(struct inode *inode, struct address_space *mapping);
 extern void nfs_zap_caches(struct inode *);
+extern void nfs_set_inode_stale(struct inode *inode);
 extern void nfs_invalidate_atime(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
 				struct nfs_fattr *, struct nfs4_label *);
-- 
2.25.2

