Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB71966F7
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgC1Pef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Pef (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:35 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB1A207FF
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409674;
        bh=ogmst/gQoqoMT45GiaXzThYRPK322Tm06zT3I5HCDIU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z6v5ysbpMoGb4+Dmcl9OrrhJnhyXQh4Z8u1m0L/BmF/w7P1xK/iS6die9B7iC6FqM
         wd9XopnC5uXuShXVNw3I2pbOiobPcPpMbIKhiNM8yNUCFgODjhjmhgsYsV+cUE6EKD
         AT3cnhN15113I0sn9CKWbSXO6eYCD3mALm62o/tA=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/22] pNFS: Add a helper to allocate the array of buckets
Date:   Sat, 28 Mar 2020 11:32:01 -0400
Message-Id: <20200328153220.1352010-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-3-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
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

