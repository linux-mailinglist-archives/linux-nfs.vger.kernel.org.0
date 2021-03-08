Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A233177F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 20:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCHTnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhCHTm6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 14:42:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF18652B4;
        Mon,  8 Mar 2021 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615232577;
        bh=kNBS1R0WkB83LNM80WtsfoKI13TVL935hXzuGrn+doc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELvs3mL24k/u7/6Id9FXAiL7BYpCbxPjWQTPuuHOyw+oVOaJgTO88PrvY/TC87C1z
         WRISjdQvIM7JhDuqsicYOKy7ZSNSTALk17/KFBXVMH0CrqnGfh1wXMvybvdJtawzBa
         7zx9K9rHfueRqVx5JXAtCuaA69ETxnvfYyscklRW8C8I4BfsA0CiiTVupLAg6A/v0J
         f3BLnhazn8Y+N//kLbIN6QXQf1VWw8gFFv6CnOSHEDOX7GrIkBmjkOSQtl3dUnbNIP
         m3eIEwpk/wmL4jS7YIIrVISnzdNZAN8VQZX/E1ynhGLUcLTyg1ueS8w9OahTG4cJE3
         0QpFgCKOyQ+qg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Geert Jansen <gerardu@amazon.com>
Subject: [PATCH v2 3/5] NFS: Clean up function nfs_mark_dir_for_revalidate()
Date:   Mon,  8 Mar 2021 14:42:53 -0500
Message-Id: <20210308194255.7873-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308194255.7873-2-trondmy@kernel.org>
References: <20210308194255.7873-1-trondmy@kernel.org>
 <20210308194255.7873-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 4 +---
 fs/nfs/inode.c    | 2 +-
 fs/nfs/internal.h | 3 ++-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a91f324cca49..02ac982846f4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1403,10 +1403,8 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
 
 static void nfs_mark_dir_for_revalidate(struct inode *inode)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
-
 	spin_lock(&inode->i_lock);
-	nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
+	nfs_set_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE);
 	spin_unlock(&inode->i_lock);
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 749bbea14d99..d21bfaac10b0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -207,7 +207,7 @@ static bool nfs_has_xattr_cache(const struct nfs_inode *nfsi)
 }
 #endif
 
-static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
+void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	bool have_delegation = NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 25fb43b69e5a..7b644d6c09e4 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -411,7 +411,8 @@ extern int nfs_write_inode(struct inode *, struct writeback_control *);
 extern int nfs_drop_inode(struct inode *);
 extern void nfs_clear_inode(struct inode *);
 extern void nfs_evict_inode(struct inode *);
-void nfs_zap_acl_cache(struct inode *inode);
+extern void nfs_zap_acl_cache(struct inode *inode);
+extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
-- 
2.29.2

