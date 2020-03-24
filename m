Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1864191DB5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCXXto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgCXXto (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:44 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 840972073E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093783;
        bh=hhzKpP8c2GTIW7gqxW/CRy3p6bi3jL+mDtXSFO5Fn1s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h82gNB+b7NmlSIZWrH/0wJ4ANBUmvR0F71+j+49HX/Q7pYInYDqxEe8srEBloXNs2
         wzdoC9coRIaaI9KkbU6Ids2W+5rGH4IV9zJjBaJuo9NUncpqs3btbtO80bVx+BFu4r
         K3vS488Nh9bBlOo2I6KE5o2Li4CaD6ryI0RUUFj0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 13/22] pNFS: Enable per-layout segment commit structures
Date:   Tue, 24 Mar 2020 19:47:19 -0400
Message-Id: <20200324234728.8997-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-13-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
 <20200324234728.8997-9-trondmy@kernel.org>
 <20200324234728.8997-10-trondmy@kernel.org>
 <20200324234728.8997-11-trondmy@kernel.org>
 <20200324234728.8997-12-trondmy@kernel.org>
 <20200324234728.8997-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Enable adding and lookup of per-layout segment commits in filelayout
and flexfilelayout.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/filelayout/filelayout.c         | 21 +++++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 19 +++++++
 fs/nfs/pnfs.h                          |  6 ++
 fs/nfs/pnfs_nfs.c                      | 77 ++++++++++++++++++++++++--
 4 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 1cb043838b14..90c660aad337 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1168,6 +1168,26 @@ filelayout_get_ds_info(struct inode *inode)
 		return &FILELAYOUT_FROM_HDR(layout)->commit_info;
 }
 
+static void
+filelayout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct nfs4_filelayout_segment *fl = FILELAYOUT_LSEG(lseg);
+	struct inode *inode = lseg->pls_layout->plh_inode;
+	struct pnfs_commit_array *array, *new;
+	unsigned int size = (fl->stripe_type == STRIPE_SPARSE) ?
+		fl->dsaddr->ds_num : fl->dsaddr->stripe_count;
+
+	new = pnfs_alloc_commit_array(size, GFP_NOIO);
+	if (new) {
+		spin_lock(&inode->i_lock);
+		array = pnfs_add_commit_array(fl_cinfo, new, lseg);
+		spin_unlock(&inode->i_lock);
+		if (array != new)
+			pnfs_free_commit_array(new);
+	}
+}
+
 static void
 filelayout_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 		struct inode *inode)
@@ -1191,6 +1211,7 @@ static struct pnfs_layoutdriver_type filelayout_type = {
 	.pg_read_ops		= &filelayout_pg_read_ops,
 	.pg_write_ops		= &filelayout_pg_write_ops,
 	.get_ds_info		= &filelayout_get_ds_info,
+	.setup_ds_info		= filelayout_setup_ds_info,
 	.release_ds_info	= filelayout_release_ds_info,
 	.mark_request_commit	= filelayout_mark_request_commit,
 	.clear_request_commit	= pnfs_generic_clear_request_commit,
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3ddd8080f76d..e4db8510ef5f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2004,6 +2004,24 @@ ff_layout_get_ds_info(struct inode *inode)
 	return &FF_LAYOUT_FROM_HDR(layout)->commit_info;
 }
 
+static void
+ff_layout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+	struct inode *inode = lseg->pls_layout->plh_inode;
+	struct pnfs_commit_array *array, *new;
+
+	new = pnfs_alloc_commit_array(flseg->mirror_array_cnt, GFP_NOIO);
+	if (new) {
+		spin_lock(&inode->i_lock);
+		array = pnfs_add_commit_array(fl_cinfo, new, lseg);
+		spin_unlock(&inode->i_lock);
+		if (array != new)
+			pnfs_free_commit_array(new);
+	}
+}
+
 static void
 ff_layout_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 		struct inode *inode)
@@ -2513,6 +2531,7 @@ static struct pnfs_layoutdriver_type flexfilelayout_type = {
 	.pg_read_ops		= &ff_layout_pg_read_ops,
 	.pg_write_ops		= &ff_layout_pg_write_ops,
 	.get_ds_info		= ff_layout_get_ds_info,
+	.setup_ds_info		= ff_layout_setup_ds_info,
 	.release_ds_info	= ff_layout_release_ds_info,
 	.free_deviceid_node	= ff_layout_free_deviceid_node,
 	.mark_request_commit	= pnfs_layout_mark_request_commit,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 9742ab184960..434503875f7f 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -150,6 +150,8 @@ struct pnfs_layoutdriver_type {
 	const struct nfs_pageio_ops *pg_write_ops;
 
 	struct pnfs_ds_commit_info *(*get_ds_info) (struct inode *inode);
+	void (*setup_ds_info)(struct pnfs_ds_commit_info *,
+			      struct pnfs_layout_segment *);
 	void (*release_ds_info)(struct pnfs_ds_commit_info *,
 				struct inode *inode);
 	void (*mark_request_commit) (struct nfs_page *req,
@@ -371,6 +373,10 @@ void nfs4_deviceid_purge_client(const struct nfs_client *);
 /* pnfs_nfs.c */
 struct pnfs_commit_array *pnfs_alloc_commit_array(size_t n, gfp_t gfp_flags);
 void pnfs_free_commit_array(struct pnfs_commit_array *p);
+struct pnfs_commit_array *pnfs_add_commit_array(struct pnfs_ds_commit_info *,
+						struct pnfs_commit_array *,
+						struct pnfs_layout_segment *);
+
 void pnfs_generic_ds_cinfo_release_lseg(struct pnfs_ds_commit_info *fl_cinfo,
 		struct pnfs_layout_segment *lseg);
 void pnfs_generic_ds_cinfo_destroy(struct pnfs_ds_commit_info *fl_cinfo);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index edad251a6a48..5b426a090ee3 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -118,6 +118,66 @@ pnfs_free_commit_array(struct pnfs_commit_array *p)
 }
 EXPORT_SYMBOL_GPL(pnfs_free_commit_array);
 
+static struct pnfs_commit_array *
+pnfs_find_commit_array_by_lseg(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct pnfs_commit_array *array;
+
+	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
+		if (array->lseg == lseg)
+			return array;
+	}
+	return NULL;
+}
+
+struct pnfs_commit_array *
+pnfs_add_commit_array(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_commit_array *new,
+		struct pnfs_layout_segment *lseg)
+{
+	struct pnfs_commit_array *array;
+
+	array = pnfs_find_commit_array_by_lseg(fl_cinfo, lseg);
+	if (array)
+		return array;
+	new->lseg = lseg;
+	refcount_set(&new->refcount, 1);
+	list_add_rcu(&new->cinfo_list, &fl_cinfo->commits);
+	list_add(&new->lseg_list, &lseg->pls_commits);
+	return new;
+}
+EXPORT_SYMBOL_GPL(pnfs_add_commit_array);
+
+static void
+pnfs_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct inode *inode = lseg->pls_layout->plh_inode;
+	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
+
+	if (ld->setup_ds_info != NULL)
+		ld->setup_ds_info(fl_cinfo, lseg);
+}
+
+static struct pnfs_commit_array *
+pnfs_lookup_commit_array(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct pnfs_commit_array *array;
+
+	rcu_read_lock();
+	array = pnfs_find_commit_array_by_lseg(fl_cinfo, lseg);
+	if (!array) {
+		rcu_read_unlock();
+		pnfs_setup_ds_info(fl_cinfo, lseg);
+		rcu_read_lock();
+		array = pnfs_find_commit_array_by_lseg(fl_cinfo, lseg);
+	}
+	rcu_read_unlock();
+	return array;
+}
+
 static void
 pnfs_release_commit_array_locked(struct pnfs_commit_array *array)
 {
@@ -1082,17 +1142,18 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 				u32 ds_commit_idx)
 {
 	struct list_head *list;
+	struct pnfs_commit_array *array;
 	struct pnfs_commit_bucket *buckets;
 
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
-	buckets = cinfo->ds->buckets;
+	array = pnfs_lookup_commit_array(cinfo->ds, lseg);
+	if (!array)
+		goto out_resched;
+	buckets = array->buckets;
 	list = &buckets[ds_commit_idx].written;
 	if (list_empty(list)) {
-		if (!pnfs_is_valid_lseg(lseg)) {
-			mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-			cinfo->completion_ops->resched_write(cinfo, req);
-			return;
-		}
+		if (!pnfs_is_valid_lseg(lseg))
+			goto out_resched;
 		/* Non-empty buckets hold a reference on the lseg.  That ref
 		 * is normally transferred to the COMMIT call and released
 		 * there.  It could also be released if the last req is pulled
@@ -1108,6 +1169,10 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 	nfs_request_add_commit_list_locked(req, list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 	nfs_mark_page_unstable(req->wb_page, cinfo);
+	return;
+out_resched:
+	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
+	cinfo->completion_ops->resched_write(cinfo, req);
 }
 EXPORT_SYMBOL_GPL(pnfs_layout_mark_request_commit);
 
-- 
2.25.1

