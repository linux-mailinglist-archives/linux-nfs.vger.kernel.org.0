Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DF191DAC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCXXtj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCXXtj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:39 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54192072E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093779;
        bh=ogmst/gQoqoMT45GiaXzThYRPK322Tm06zT3I5HCDIU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qcEXbJDYflBSRi3nTdpLGgO9fx34TKxfu2pXL5TabPlRyV7hHbnnRt+ivcHsNYM3F
         7mhjiZNCF+J4do1mdIz7uo6yCi5kmwPd7fhxig/ZSO8lgNpYNnwQYrIFUgw8VFJztN
         s5j9T44Y5YIOW6T9eTxAwRFog9S06Ldi09/bY8mk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/22] pNFS: Add a helper to allocate the array of buckets
Date:   Tue, 24 Mar 2020 19:47:09 -0400
Message-Id: <20200324234728.8997-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-3-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.h           |  3 +++
 fs/nfs/pnfs_nfs.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h | 15 ++++++++++++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 7bfb6970134a..f6b1099aa151 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -366,6 +366,9 @@ bool nfs4_test_deviceid_unavailable(struct nfs4_deviceid_node *node);
 void nfs4_deviceid_purge_client(const struct nfs_client *);
 
 /* pnfs_nfs.c */
+struct pnfs_commit_array *pnfs_alloc_commit_array(size_t n, gfp_t gfp_flags);
+void pnfs_free_commit_array(struct pnfs_commit_array *p);
+
 void pnfs_generic_clear_request_commit(struct nfs_page *req,
 				       struct nfs_commit_info *cinfo);
 void pnfs_generic_commit_release(void *calldata);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 3d0942541618..c8518ce3a4ef 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -87,6 +87,37 @@ pnfs_generic_clear_request_commit(struct nfs_page *req,
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_clear_request_commit);
 
+struct pnfs_commit_array *
+pnfs_alloc_commit_array(size_t n, gfp_t gfp_flags)
+{
+	struct pnfs_commit_array *p;
+	struct pnfs_commit_bucket *b;
+
+	p = kmalloc(struct_size(p, buckets, n), gfp_flags);
+	if (!p)
+		return NULL;
+	p->nbuckets = n;
+	INIT_LIST_HEAD(&p->cinfo_list);
+	INIT_LIST_HEAD(&p->lseg_list);
+	p->lseg = NULL;
+	for (b = &p->buckets[0]; n != 0; b++, n--) {
+		INIT_LIST_HEAD(&b->written);
+		INIT_LIST_HEAD(&b->committing);
+		b->wlseg = NULL;
+		b->clseg = NULL;
+		b->direct_verf.committed = NFS_INVALID_STABLE_HOW;
+	}
+	return p;
+}
+EXPORT_SYMBOL_GPL(pnfs_alloc_commit_array);
+
+void
+pnfs_free_commit_array(struct pnfs_commit_array *p)
+{
+	kfree_rcu(p, rcu);
+}
+EXPORT_SYMBOL_GPL(pnfs_free_commit_array);
+
 static int
 pnfs_generic_scan_ds_commit_list(struct pnfs_commit_bucket *bucket,
 				 struct nfs_commit_info *cinfo,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 94c77ed55ce1..e91c917c9c1c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1270,10 +1270,19 @@ struct pnfs_commit_bucket {
 	struct nfs_writeverf direct_verf;
 };
 
+struct pnfs_commit_array {
+	struct list_head cinfo_list;
+	struct list_head lseg_list;
+	struct pnfs_layout_segment *lseg;
+	struct rcu_head rcu;
+	unsigned int nbuckets;
+	struct pnfs_commit_bucket buckets[];
+};
+
 struct pnfs_ds_commit_info {
-	int nwritten;
-	int ncommitting;
-	int nbuckets;
+	unsigned int nwritten;
+	unsigned int ncommitting;
+	unsigned int nbuckets;
 	struct pnfs_commit_bucket *buckets;
 };
 
-- 
2.25.1

