Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039021966FC
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgC1Pep (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgC1Pel (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:41 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3615A207FF
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409680;
        bh=diUewrALk/h96nTmDtd1aZ+xD4ZCPnwl8rF5Aeil590=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aa8GF51eu/8d0by35iETbBv0CjkYCCU00M0xjJm5DABUEO41BKdo3wMa5tiV9weHI
         t23kywOg5MejDYHC7QLvP6kRqyNZj6MhjXOPo+BAwTMZw0bXy9n2gPZSyBVviVzJBI
         sOshd3OomS29qk4JnupZbNkmII5ysP2b6kKedqAU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/22] NFS/pNFS: Clean up pNFS commit operations
Date:   Sat, 28 Mar 2020 11:32:14 -0400
Message-Id: <20200328153220.1352010-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-16-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
 <20200328153220.1352010-10-trondmy@kernel.org>
 <20200328153220.1352010-11-trondmy@kernel.org>
 <20200328153220.1352010-12-trondmy@kernel.org>
 <20200328153220.1352010-13-trondmy@kernel.org>
 <20200328153220.1352010-14-trondmy@kernel.org>
 <20200328153220.1352010-15-trondmy@kernel.org>
 <20200328153220.1352010-16-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Move the pNFS commit related operations into a separate structure
that can be carried by the pnfs_ds_commit_info.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c                        |   6 +-
 fs/nfs/filelayout/filelayout.c         |  20 +++--
 fs/nfs/flexfilelayout/flexfilelayout.c |  19 +++--
 fs/nfs/pnfs.h                          | 110 ++++++++++++++++---------
 fs/nfs/pnfs_nfs.c                      |  13 +--
 include/linux/nfs_xdr.h                |   1 +
 6 files changed, 98 insertions(+), 71 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 61f93a0fb0e0..51ab4627c4d6 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -511,10 +511,7 @@ nfs_direct_write_scan_commit_list(struct inode *inode,
 				  struct nfs_commit_info *cinfo)
 {
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
-#ifdef CONFIG_NFS_V4_1
-	if (cinfo->ds != NULL && cinfo->ds->nwritten != 0)
-		NFS_SERVER(inode)->pnfs_curr_ld->recover_commit_reqs(list, cinfo);
-#endif
+	pnfs_recover_commit_reqs(list, cinfo);
 	nfs_scan_commit_list(&cinfo->mds->list, list, cinfo, 0);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 }
@@ -917,6 +914,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dreq->l_ctx = l_ctx;
 	if (!is_sync_kiocb(iocb))
 		dreq->iocb = iocb;
+	pnfs_init_ds_commit_info_ops(&dreq->ds_cinfo, inode);
 
 	nfs_start_io_direct(inode);
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 854f350e2599..a13e69009f19 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -49,6 +49,7 @@ MODULE_AUTHOR("Dean Hildebrand <dhildebz@umich.edu>");
 MODULE_DESCRIPTION("The NFSv4 file layout driver");
 
 #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
+static const struct pnfs_commit_ops filelayout_commit_ops;
 
 static loff_t
 filelayout_get_dense_offset(struct nfs4_filelayout_segment *flseg,
@@ -1045,6 +1046,7 @@ filelayout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 	if (flo == NULL)
 		return NULL;
 	pnfs_init_ds_commit_info(&flo->commit_info);
+	flo->commit_info.ops = &filelayout_commit_ops;
 	return &flo->generic_hdr;
 }
 
@@ -1094,6 +1096,16 @@ filelayout_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 	spin_unlock(&inode->i_lock);
 }
 
+static const struct pnfs_commit_ops filelayout_commit_ops = {
+	.setup_ds_info		= filelayout_setup_ds_info,
+	.release_ds_info	= filelayout_release_ds_info,
+	.mark_request_commit	= filelayout_mark_request_commit,
+	.clear_request_commit	= pnfs_generic_clear_request_commit,
+	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
+	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
+	.search_commit_reqs	= pnfs_generic_search_commit_reqs,
+	.commit_pagelist	= filelayout_commit_pagelist,
+};
 
 static struct pnfs_layoutdriver_type filelayout_type = {
 	.id			= LAYOUT_NFSV4_1_FILES,
@@ -1108,14 +1120,6 @@ static struct pnfs_layoutdriver_type filelayout_type = {
 	.pg_read_ops		= &filelayout_pg_read_ops,
 	.pg_write_ops		= &filelayout_pg_write_ops,
 	.get_ds_info		= &filelayout_get_ds_info,
-	.setup_ds_info		= filelayout_setup_ds_info,
-	.release_ds_info	= filelayout_release_ds_info,
-	.mark_request_commit	= filelayout_mark_request_commit,
-	.clear_request_commit	= pnfs_generic_clear_request_commit,
-	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
-	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
-	.search_commit_reqs	= pnfs_generic_search_commit_reqs,
-	.commit_pagelist	= filelayout_commit_pagelist,
 	.read_pagelist		= filelayout_read_pagelist,
 	.write_pagelist		= filelayout_write_pagelist,
 	.alloc_deviceid_node	= filelayout_alloc_deviceid_node,
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1a4e36d07eab..d37883a2b51f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -32,6 +32,7 @@
 
 static unsigned short io_maxretrans;
 
+static const struct pnfs_commit_ops ff_layout_commit_ops;
 static void ff_layout_read_record_layoutstats_done(struct rpc_task *task,
 		struct nfs_pgio_header *hdr);
 static int ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
@@ -52,6 +53,7 @@ ff_layout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 		INIT_LIST_HEAD(&ffl->error_list);
 		INIT_LIST_HEAD(&ffl->mirrors);
 		ffl->last_report_time = ktime_get();
+		ffl->commit_info.ops = &ff_layout_commit_ops;
 		return &ffl->generic_hdr;
 	} else
 		return NULL;
@@ -2440,6 +2442,16 @@ ff_layout_set_layoutdriver(struct nfs_server *server,
 	return 0;
 }
 
+static const struct pnfs_commit_ops ff_layout_commit_ops = {
+	.setup_ds_info		= ff_layout_setup_ds_info,
+	.release_ds_info	= ff_layout_release_ds_info,
+	.mark_request_commit	= pnfs_layout_mark_request_commit,
+	.clear_request_commit	= pnfs_generic_clear_request_commit,
+	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
+	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
+	.commit_pagelist	= ff_layout_commit_pagelist,
+};
+
 static struct pnfs_layoutdriver_type flexfilelayout_type = {
 	.id			= LAYOUT_FLEX_FILES,
 	.name			= "LAYOUT_FLEX_FILES",
@@ -2455,14 +2467,7 @@ static struct pnfs_layoutdriver_type flexfilelayout_type = {
 	.pg_read_ops		= &ff_layout_pg_read_ops,
 	.pg_write_ops		= &ff_layout_pg_write_ops,
 	.get_ds_info		= ff_layout_get_ds_info,
-	.setup_ds_info		= ff_layout_setup_ds_info,
-	.release_ds_info	= ff_layout_release_ds_info,
 	.free_deviceid_node	= ff_layout_free_deviceid_node,
-	.mark_request_commit	= pnfs_layout_mark_request_commit,
-	.clear_request_commit	= pnfs_generic_clear_request_commit,
-	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
-	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
-	.commit_pagelist	= ff_layout_commit_pagelist,
 	.read_pagelist		= ff_layout_read_pagelist,
 	.write_pagelist		= ff_layout_write_pagelist,
 	.alloc_deviceid_node    = ff_layout_alloc_deviceid_node,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index faed9be6e479..b32025553f26 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -150,26 +150,6 @@ struct pnfs_layoutdriver_type {
 	const struct nfs_pageio_ops *pg_write_ops;
 
 	struct pnfs_ds_commit_info *(*get_ds_info) (struct inode *inode);
-	void (*setup_ds_info)(struct pnfs_ds_commit_info *,
-			      struct pnfs_layout_segment *);
-	void (*release_ds_info)(struct pnfs_ds_commit_info *,
-				struct inode *inode);
-	void (*mark_request_commit) (struct nfs_page *req,
-				     struct pnfs_layout_segment *lseg,
-				     struct nfs_commit_info *cinfo,
-				     u32 ds_commit_idx);
-	void (*clear_request_commit) (struct nfs_page *req,
-				      struct nfs_commit_info *cinfo);
-	int (*scan_commit_lists) (struct nfs_commit_info *cinfo,
-				  int max);
-	void (*recover_commit_reqs) (struct list_head *list,
-				     struct nfs_commit_info *cinfo);
-	struct nfs_page * (*search_commit_reqs)(struct nfs_commit_info *cinfo,
-						struct page *page);
-	int (*commit_pagelist)(struct inode *inode,
-			       struct list_head *mds_pages,
-			       int how,
-			       struct nfs_commit_info *cinfo);
 
 	int (*sync)(struct inode *inode, bool datasync);
 
@@ -192,6 +172,29 @@ struct pnfs_layoutdriver_type {
 	int (*prepare_layoutstats) (struct nfs42_layoutstat_args *args);
 };
 
+struct pnfs_commit_ops {
+	void (*setup_ds_info)(struct pnfs_ds_commit_info *,
+			      struct pnfs_layout_segment *);
+	void (*release_ds_info)(struct pnfs_ds_commit_info *,
+				struct inode *inode);
+	int (*commit_pagelist)(struct inode *inode,
+			       struct list_head *mds_pages,
+			       int how,
+			       struct nfs_commit_info *cinfo);
+	void (*mark_request_commit) (struct nfs_page *req,
+				     struct pnfs_layout_segment *lseg,
+				     struct nfs_commit_info *cinfo,
+				     u32 ds_commit_idx);
+	void (*clear_request_commit) (struct nfs_page *req,
+				      struct nfs_commit_info *cinfo);
+	int (*scan_commit_lists) (struct nfs_commit_info *cinfo,
+				  int max);
+	void (*recover_commit_reqs) (struct list_head *list,
+				     struct nfs_commit_info *cinfo);
+	struct nfs_page * (*search_commit_reqs)(struct nfs_commit_info *cinfo,
+						struct page *page);
+};
+
 struct pnfs_layout_hdr {
 	refcount_t		plh_refcount;
 	atomic_t		plh_outstanding; /* number of RPCs out */
@@ -461,9 +464,11 @@ static inline int
 pnfs_commit_list(struct inode *inode, struct list_head *mds_pages, int how,
 		 struct nfs_commit_info *cinfo)
 {
-	if (cinfo->ds == NULL || cinfo->ds->ncommitting == 0)
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+
+	if (fl_cinfo == NULL || fl_cinfo->ncommitting == 0)
 		return PNFS_NOT_ATTEMPTED;
-	return NFS_SERVER(inode)->pnfs_curr_ld->commit_pagelist(inode, mds_pages, how, cinfo);
+	return fl_cinfo->ops->commit_pagelist(inode, mds_pages, how, cinfo);
 }
 
 static inline struct pnfs_ds_commit_info *
@@ -476,19 +481,26 @@ pnfs_get_ds_info(struct inode *inode)
 	return ld->get_ds_info(inode);
 }
 
+static inline void
+pnfs_init_ds_commit_info_ops(struct pnfs_ds_commit_info *fl_cinfo, struct inode *inode)
+{
+	struct pnfs_ds_commit_info *inode_cinfo = pnfs_get_ds_info(inode);
+	if (inode_cinfo != NULL)
+		fl_cinfo->ops = inode_cinfo->ops;
+}
+
 static inline void
 pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
 {
 	INIT_LIST_HEAD(&fl_cinfo->commits);
+	fl_cinfo->ops = NULL;
 }
 
 static inline void
 pnfs_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo, struct inode *inode)
 {
-	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
-
-	if (ld != NULL && ld->release_ds_info != NULL)
-		ld->release_ds_info(fl_cinfo, inode);
+	if (fl_cinfo->ops != NULL && fl_cinfo->ops->release_ds_info != NULL)
+		fl_cinfo->ops->release_ds_info(fl_cinfo, inode);
 }
 
 static inline void
@@ -501,24 +513,22 @@ static inline bool
 pnfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 			 struct nfs_commit_info *cinfo, u32 ds_commit_idx)
 {
-	struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
-	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 
-	if (lseg == NULL || ld->mark_request_commit == NULL)
+	if (!lseg || !fl_cinfo->ops->mark_request_commit)
 		return false;
-	ld->mark_request_commit(req, lseg, cinfo, ds_commit_idx);
+	fl_cinfo->ops->mark_request_commit(req, lseg, cinfo, ds_commit_idx);
 	return true;
 }
 
 static inline bool
 pnfs_clear_request_commit(struct nfs_page *req, struct nfs_commit_info *cinfo)
 {
-	struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
-	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 
-	if (ld == NULL || ld->clear_request_commit == NULL)
+	if (!fl_cinfo || !fl_cinfo->ops || !fl_cinfo->ops->clear_request_commit)
 		return false;
-	ld->clear_request_commit(req, cinfo);
+	fl_cinfo->ops->clear_request_commit(req, cinfo);
 	return true;
 }
 
@@ -526,21 +536,31 @@ static inline int
 pnfs_scan_commit_lists(struct inode *inode, struct nfs_commit_info *cinfo,
 		       int max)
 {
-	if (cinfo->ds == NULL || cinfo->ds->nwritten == 0)
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+
+	if (!fl_cinfo || fl_cinfo->nwritten == 0)
 		return 0;
-	else
-		return NFS_SERVER(inode)->pnfs_curr_ld->scan_commit_lists(cinfo, max);
+	return fl_cinfo->ops->scan_commit_lists(cinfo, max);
+}
+
+static inline void
+pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
+{
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+
+	if (fl_cinfo && fl_cinfo->nwritten != 0)
+		fl_cinfo->ops->recover_commit_reqs(head, cinfo);
 }
 
 static inline struct nfs_page *
 pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
 			struct page *page)
 {
-	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 
-	if (ld == NULL || ld->search_commit_reqs == NULL)
+	if (!fl_cinfo->ops || !fl_cinfo->ops->search_commit_reqs)
 		return NULL;
-	return ld->search_commit_reqs(cinfo, page);
+	return fl_cinfo->ops->search_commit_reqs(cinfo, page);
 }
 
 /* Should the pNFS client commit and return the layout upon a setattr */
@@ -788,6 +808,11 @@ pnfs_get_ds_info(struct inode *inode)
 	return NULL;
 }
 
+static inline void
+pnfs_init_ds_commit_info_ops(struct pnfs_ds_commit_info *fl_cinfo, struct inode *inode)
+{
+}
+
 static inline void
 pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
 {
@@ -818,6 +843,11 @@ pnfs_scan_commit_lists(struct inode *inode, struct nfs_commit_info *cinfo,
 	return 0;
 }
 
+static inline void
+pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
+{
+}
+
 static inline struct nfs_page *
 pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
 			struct page *page)
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 20f12f3cbe38..06df2e6663dc 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -149,17 +149,6 @@ pnfs_add_commit_array(struct pnfs_ds_commit_info *fl_cinfo,
 }
 EXPORT_SYMBOL_GPL(pnfs_add_commit_array);
 
-static void
-pnfs_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
-		struct pnfs_layout_segment *lseg)
-{
-	struct inode *inode = lseg->pls_layout->plh_inode;
-	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
-
-	if (ld->setup_ds_info != NULL)
-		ld->setup_ds_info(fl_cinfo, lseg);
-}
-
 static struct pnfs_commit_array *
 pnfs_lookup_commit_array(struct pnfs_ds_commit_info *fl_cinfo,
 		struct pnfs_layout_segment *lseg)
@@ -170,7 +159,7 @@ pnfs_lookup_commit_array(struct pnfs_ds_commit_info *fl_cinfo,
 	array = pnfs_find_commit_array_by_lseg(fl_cinfo, lseg);
 	if (!array) {
 		rcu_read_unlock();
-		pnfs_setup_ds_info(fl_cinfo, lseg);
+		fl_cinfo->ops->setup_ds_info(fl_cinfo, lseg);
 		rcu_read_lock();
 		array = pnfs_find_commit_array_by_lseg(fl_cinfo, lseg);
 	}
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2903597ec88c..adbbeae9ce5b 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1284,6 +1284,7 @@ struct pnfs_ds_commit_info {
 	struct list_head commits;
 	unsigned int nwritten;
 	unsigned int ncommitting;
+	const struct pnfs_commit_ops *ops;
 };
 
 struct nfs41_state_protection {
-- 
2.25.1

