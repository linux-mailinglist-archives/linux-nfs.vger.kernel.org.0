Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1E1966F5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1Pef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgC1Pee (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:34 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E50E20748
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409674;
        bh=Ihi7Dit/Q8Thk1RIhBwaphJ7XIANwUrtk7jMQv7GX8s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aNOQ9tILkQ/oEkBVY6VXe856OcKX38U27IQr7HqlgcH9uE6Vygmfwy/VOvqfn3lLV
         zSYyQUxWVh1pask+ro2R2dxuRO0a9kmPgXsSR3JRHpqdX63O8WWKA1/tOz2L+L9Kss
         MTo8BH3oTVOhLk8ZEzfeEpHFHCxozCyfvjcSXcLk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/22] NFS/pNFS: Refactor pnfs_generic_commit_pagelist()
Date:   Sat, 28 Mar 2020 11:32:00 -0400
Message-Id: <20200328153220.1352010-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-2-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Refactor pnfs_generic_commit_pagelist() to simplify the conversion
to layout segment based commit lists.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 164 +++++++++++++++++++---------------------------
 fs/nfs/write.c    |  13 ++--
 2 files changed, 76 insertions(+), 101 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 8b37e7f8e789..3d0942541618 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -156,103 +156,86 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
-static void pnfs_generic_retry_commit(struct nfs_commit_info *cinfo, int idx)
+static struct pnfs_layout_segment *
+pnfs_bucket_get_committing(struct list_head *head,
+			   struct pnfs_commit_bucket *bucket,
+			   struct nfs_commit_info *cinfo)
 {
-	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
-	struct pnfs_commit_bucket *bucket;
 	struct pnfs_layout_segment *freeme;
 	struct list_head *pos;
+
+	list_for_each(pos, &bucket->committing)
+		cinfo->ds->ncommitting--;
+	list_splice_init(&bucket->committing, head);
+	freeme = bucket->clseg;
+	bucket->clseg = NULL;
+	return freeme;
+}
+
+static struct nfs_commit_data *
+pnfs_bucket_fetch_commitdata(struct pnfs_commit_bucket *bucket,
+			     struct nfs_commit_info *cinfo)
+{
+	struct nfs_commit_data *data = nfs_commitdata_alloc(false);
+
+	if (!data)
+		return NULL;
+	data->lseg = pnfs_bucket_get_committing(&data->pages, bucket, cinfo);
+	return data;
+}
+
+static void pnfs_generic_retry_commit(struct pnfs_commit_bucket *buckets,
+				      unsigned int nbuckets,
+				      struct nfs_commit_info *cinfo,
+				      unsigned int idx)
+{
+	struct pnfs_commit_bucket *bucket;
+	struct pnfs_layout_segment *freeme;
 	LIST_HEAD(pages);
-	int i;
 
-	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
-	for (i = idx; i < fl_cinfo->nbuckets; i++) {
-		bucket = &fl_cinfo->buckets[i];
+	for (bucket = buckets; idx < nbuckets; bucket++, idx++) {
 		if (list_empty(&bucket->committing))
 			continue;
-		freeme = bucket->clseg;
-		bucket->clseg = NULL;
-		list_for_each(pos, &bucket->committing)
-			cinfo->ds->ncommitting--;
-		list_splice_init(&bucket->committing, &pages);
+		mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
+		freeme = pnfs_bucket_get_committing(&pages, bucket, cinfo);
 		mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-		nfs_retry_commit(&pages, freeme, cinfo, i);
+		nfs_retry_commit(&pages, freeme, cinfo, idx);
 		pnfs_put_lseg(freeme);
-		mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	}
-	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 }
 
 static unsigned int
-pnfs_generic_alloc_ds_commits(struct nfs_commit_info *cinfo,
-			      struct list_head *list)
+pnfs_bucket_alloc_ds_commits(struct list_head *list,
+			     struct pnfs_commit_bucket *buckets,
+			     unsigned int nbuckets,
+			     struct nfs_commit_info *cinfo)
 {
-	struct pnfs_ds_commit_info *fl_cinfo;
 	struct pnfs_commit_bucket *bucket;
 	struct nfs_commit_data *data;
-	int i;
+	unsigned int i;
 	unsigned int nreq = 0;
 
-	fl_cinfo = cinfo->ds;
-	bucket = fl_cinfo->buckets;
-	for (i = 0; i < fl_cinfo->nbuckets; i++, bucket++) {
+	for (i = 0, bucket = buckets; i < nbuckets; i++, bucket++) {
 		if (list_empty(&bucket->committing))
 			continue;
-		data = nfs_commitdata_alloc(false);
-		if (!data)
-			break;
-		data->ds_commit_index = i;
-		list_add(&data->pages, list);
-		nreq++;
+		mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
+		if (!list_empty(&bucket->committing)) {
+			data = pnfs_bucket_fetch_commitdata(bucket, cinfo);
+			if (!data)
+				goto out_error;
+			data->ds_commit_index = i;
+			list_add_tail(&data->list, list);
+			atomic_inc(&cinfo->mds->rpcs_out);
+			nreq++;
+		}
+		mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 	}
-
-	/* Clean up on error */
-	pnfs_generic_retry_commit(cinfo, i);
 	return nreq;
-}
-
-static inline
-void pnfs_fetch_commit_bucket_list(struct list_head *pages,
-		struct nfs_commit_data *data,
-		struct nfs_commit_info *cinfo)
-{
-	struct pnfs_commit_bucket *bucket;
-	struct list_head *pos;
-
-	bucket = &cinfo->ds->buckets[data->ds_commit_index];
-	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
-	list_for_each(pos, &bucket->committing)
-		cinfo->ds->ncommitting--;
-	list_splice_init(&bucket->committing, pages);
-	data->lseg = bucket->clseg;
-	bucket->clseg = NULL;
+out_error:
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-
-}
-
-/* Helper function for pnfs_generic_commit_pagelist to catch an empty
- * page list. This can happen when two commits race.
- *
- * This must be called instead of nfs_init_commit - call one or the other, but
- * not both!
- */
-static bool
-pnfs_generic_commit_cancel_empty_pagelist(struct list_head *pages,
-					  struct nfs_commit_data *data,
-					  struct nfs_commit_info *cinfo)
-{
-	if (list_empty(pages)) {
-		if (atomic_dec_and_test(&cinfo->mds->rpcs_out))
-			wake_up_var(&cinfo->mds->rpcs_out);
-		/* don't call nfs_commitdata_release - it tries to put
-		 * the open_context which is not acquired until nfs_init_commit
-		 * which has not been called on @data */
-		WARN_ON_ONCE(data->context);
-		nfs_commit_free(data);
-		return true;
-	}
-
-	return false;
+	/* Clean up on error */
+	pnfs_generic_retry_commit(buckets, nbuckets, cinfo, i);
+	return nreq;
 }
 
 /* This follows nfs_commit_list pretty closely */
@@ -262,6 +245,7 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 			     int (*initiate_commit)(struct nfs_commit_data *data,
 						    int how))
 {
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 	struct nfs_commit_data *data, *tmp;
 	LIST_HEAD(list);
 	unsigned int nreq = 0;
@@ -269,40 +253,26 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 	if (!list_empty(mds_pages)) {
 		data = nfs_commitdata_alloc(true);
 		data->ds_commit_index = -1;
-		list_add(&data->pages, &list);
+		list_splice_init(mds_pages, &data->pages);
+		list_add_tail(&data->list, &list);
+		atomic_inc(&cinfo->mds->rpcs_out);
 		nreq++;
 	}
 
-	nreq += pnfs_generic_alloc_ds_commits(cinfo, &list);
-
+	nreq += pnfs_bucket_alloc_ds_commits(&list, fl_cinfo->buckets,
+			fl_cinfo->nbuckets, cinfo);
 	if (nreq == 0)
 		goto out;
 
-	atomic_add(nreq, &cinfo->mds->rpcs_out);
-
-	list_for_each_entry_safe(data, tmp, &list, pages) {
-		list_del_init(&data->pages);
+	list_for_each_entry_safe(data, tmp, &list, list) {
+		list_del(&data->list);
 		if (data->ds_commit_index < 0) {
-			/* another commit raced with us */
-			if (pnfs_generic_commit_cancel_empty_pagelist(mds_pages,
-				data, cinfo))
-				continue;
-
-			nfs_init_commit(data, mds_pages, NULL, cinfo);
+			nfs_init_commit(data, NULL, NULL, cinfo);
 			nfs_initiate_commit(NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
 					    data->mds_ops, how, 0);
 		} else {
-			LIST_HEAD(pages);
-
-			pnfs_fetch_commit_bucket_list(&pages, data, cinfo);
-
-			/* another commit raced with us */
-			if (pnfs_generic_commit_cancel_empty_pagelist(&pages,
-				data, cinfo))
-				continue;
-
-			nfs_init_commit(data, &pages, data->lseg, cinfo);
+			nfs_init_commit(data, NULL, data->lseg, cinfo);
 			initiate_commit(data, how);
 		}
 	}
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5544ee6cfda8..1f8108f5a041 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1746,14 +1746,19 @@ void nfs_init_commit(struct nfs_commit_data *data,
 		     struct pnfs_layout_segment *lseg,
 		     struct nfs_commit_info *cinfo)
 {
-	struct nfs_page *first = nfs_list_entry(head->next);
-	struct nfs_open_context *ctx = nfs_req_openctx(first);
-	struct inode *inode = d_inode(ctx->dentry);
+	struct nfs_page *first;
+	struct nfs_open_context *ctx;
+	struct inode *inode;
 
 	/* Set up the RPC argument and reply structs
 	 * NB: take care not to mess about with data->commit et al. */
 
-	list_splice_init(head, &data->pages);
+	if (head)
+		list_splice_init(head, &data->pages);
+
+	first = nfs_list_entry(data->pages.next);
+	ctx = nfs_req_openctx(first);
+	inode = d_inode(ctx->dentry);
 
 	data->inode	  = inode;
 	data->cred	  = ctx->cred;
-- 
2.25.1

