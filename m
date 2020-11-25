Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81932C47F1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgKYSwq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 13:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgKYSwp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Nov 2020 13:52:45 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D5420674
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606330365;
        bh=VAcHBRCuzZmQ32LgXpd9ndcKWoiJTPeWJo56L5v1+Uc=;
        h=From:To:Subject:Date:From;
        b=EPRpyt5k1c8Lfc7256g8FkFCCKM4Zg55/50ZGZC7Z/tffaVR3V7wOlYQ6fI8NgOUD
         ldbH3shl4KxpMSfdY4BilF/Zx3/rviwcRu/G2t0omXoDqJD2FC1qh9zmJTe8k+/9Fq
         MyeDJ8nOe1Qch17MC6vJo2x/SOnHqIwRpDjfev64=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix a pNFS layout related use-after-free race when freeing the inode
Date:   Wed, 25 Nov 2020 13:52:40 -0500
Message-Id: <20201125185240.295065-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When returning the layout in nfs4_evict_inode(), we need to ensure that
the layout is actually done being freed before we can proceed to free the
inode itself.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4super.c |  2 +-
 fs/nfs/pnfs.c      | 22 ++++++++++++++++++++--
 fs/nfs/pnfs.h      |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 93f5c1678ec2..984cc42ee54d 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -67,7 +67,7 @@ static void nfs4_evict_inode(struct inode *inode)
 	nfs_inode_evict_delegation(inode);
 	/* Note that above delegreturn would trigger pnfs return-on-close */
 	pnfs_return_layout(inode);
-	pnfs_destroy_layout(NFS_I(inode));
+	pnfs_destroy_layout_final(NFS_I(inode));
 	/* First call standard NFS clear_inode() code */
 	nfs_clear_inode(inode);
 	nfs4_xattr_cache_zap(inode);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0e50b9d45c32..b4cc2059a5ba 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -294,6 +294,7 @@ void
 pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 {
 	struct inode *inode;
+	unsigned long i_state;
 
 	if (!lo)
 		return;
@@ -304,8 +305,12 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 		if (!list_empty(&lo->plh_segs))
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
+		i_state = inode->i_state;
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
+		/* Notify pnfs_destroy_layout_final() that we're done */
+		if (i_state & (I_FREEING | I_CLEAR))
+			wake_up_var(lo);
 	}
 }
 
@@ -734,8 +739,7 @@ pnfs_free_lseg_list(struct list_head *free_me)
 	}
 }
 
-void
-pnfs_destroy_layout(struct nfs_inode *nfsi)
+static struct pnfs_layout_hdr *__pnfs_destroy_layout(struct nfs_inode *nfsi)
 {
 	struct pnfs_layout_hdr *lo;
 	LIST_HEAD(tmp_list);
@@ -753,9 +757,23 @@ pnfs_destroy_layout(struct nfs_inode *nfsi)
 		pnfs_put_layout_hdr(lo);
 	} else
 		spin_unlock(&nfsi->vfs_inode.i_lock);
+	return lo;
+}
+
+void pnfs_destroy_layout(struct nfs_inode *nfsi)
+{
+	__pnfs_destroy_layout(nfsi);
 }
 EXPORT_SYMBOL_GPL(pnfs_destroy_layout);
 
+void pnfs_destroy_layout_final(struct nfs_inode *nfsi)
+{
+	struct pnfs_layout_hdr *lo = __pnfs_destroy_layout(nfsi);
+
+	if (lo)
+		wait_var_event(lo, nfsi->layout != lo);
+}
+
 static bool
 pnfs_layout_add_bulk_destroy_list(struct inode *inode,
 		struct list_head *layout_list)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index f618c49697bb..ef19499e1e0f 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -268,6 +268,7 @@ struct pnfs_layout_segment *pnfs_layout_process(struct nfs4_layoutget *lgp);
 void pnfs_layoutget_free(struct nfs4_layoutget *lgp);
 void pnfs_free_lseg_list(struct list_head *tmp_list);
 void pnfs_destroy_layout(struct nfs_inode *);
+void pnfs_destroy_layout_final(struct nfs_inode *);
 void pnfs_destroy_all_layouts(struct nfs_client *);
 int pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
 		struct nfs_fsid *fsid,
-- 
2.28.0

