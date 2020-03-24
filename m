Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F64191DB8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCXXtq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgCXXtq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:46 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730CF2073C
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093784;
        bh=b2erwZpS9u5QnDIOFBwu7m0SzDEOCF4A88kdglAtMZE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oO7mItZo0g1l9SLLdiX/4iuiYyowaUty02tXcBfp1zFICeqa4JDiIk1orO6kQfS4D
         0sQ2rtd20Dn7SZd7O6YhpG3Rfk+zRhIt4100AKDXGeldVVwV8KLOR+h6ElIzwaxl8y
         zRI94dQZXVA4FE2BurHIyIsXMSemu+PDHgJwjFJE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 15/22] NFS: Remove bucket array from struct pnfs_ds_commit_info
Date:   Tue, 24 Mar 2020 19:47:21 -0400
Message-Id: <20200324234728.8997-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-15-trondmy@kernel.org>
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
 <20200324234728.8997-14-trondmy@kernel.org>
 <20200324234728.8997-15-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the unused bucket array in struct pnfs_ds_commit_info.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c                        |  1 -
 fs/nfs/filelayout/filelayout.c         | 75 +------------------------
 fs/nfs/flexfilelayout/flexfilelayout.c | 76 --------------------------
 fs/nfs/internal.h                      |  3 -
 fs/nfs/pnfs_nfs.c                      | 18 ------
 include/linux/nfs_xdr.h                | 13 -----
 6 files changed, 1 insertion(+), 185 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0f970ef2f026..a76c2160f5e5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -217,7 +217,6 @@ static void nfs_direct_req_free(struct kref *kref)
 	struct nfs_direct_req *dreq = container_of(kref, struct nfs_direct_req, kref);
 
 	pnfs_release_ds_info(&dreq->ds_cinfo, dreq->inode);
-	nfs_free_pnfs_ds_cinfo(&dreq->ds_cinfo);
 	if (dreq->l_ctx != NULL)
 		nfs_put_lock_context(dreq->l_ctx);
 	if (dreq->ctx != NULL)
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 05c97b6ba15d..0bb4f0e0a4ba 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -755,72 +755,12 @@ filelayout_free_lseg(struct pnfs_layout_segment *lseg)
 		flo = FILELAYOUT_FROM_HDR(lseg->pls_layout);
 		inode = flo->generic_hdr.plh_inode;
 		spin_lock(&inode->i_lock);
-		flo->commit_info.nbuckets = 0;
-		kfree(flo->commit_info.buckets);
-		flo->commit_info.buckets = NULL;
 		pnfs_generic_ds_cinfo_release_lseg(&flo->commit_info, lseg);
 		spin_unlock(&inode->i_lock);
 	}
 	_filelayout_free_lseg(fl);
 }
 
-static int
-filelayout_alloc_commit_info(struct pnfs_layout_segment *lseg,
-			     struct nfs_commit_info *cinfo,
-			     gfp_t gfp_flags)
-{
-	struct nfs4_filelayout_segment *fl = FILELAYOUT_LSEG(lseg);
-	struct pnfs_commit_bucket *buckets;
-	int size, i;
-
-	if (fl->commit_through_mds)
-		return 0;
-
-	size = (fl->stripe_type == STRIPE_SPARSE) ?
-		fl->dsaddr->ds_num : fl->dsaddr->stripe_count;
-
-	if (cinfo->ds->nbuckets >= size) {
-		/* This assumes there is only one IOMODE_RW lseg.  What
-		 * we really want to do is have a layout_hdr level
-		 * dictionary of <multipath_list4, fh> keys, each
-		 * associated with a struct list_head, populated by calls
-		 * to filelayout_write_pagelist().
-		 * */
-		return 0;
-	}
-
-	buckets = kcalloc(size, sizeof(struct pnfs_commit_bucket),
-			  gfp_flags);
-	if (!buckets)
-		return -ENOMEM;
-	for (i = 0; i < size; i++) {
-		INIT_LIST_HEAD(&buckets[i].written);
-		INIT_LIST_HEAD(&buckets[i].committing);
-		/* mark direct verifier as unset */
-		buckets[i].direct_verf.committed = NFS_INVALID_STABLE_HOW;
-	}
-
-	spin_lock(&cinfo->inode->i_lock);
-	if (cinfo->ds->nbuckets >= size)
-		goto out;
-	for (i = 0; i < cinfo->ds->nbuckets; i++) {
-		list_splice(&cinfo->ds->buckets[i].written,
-			    &buckets[i].written);
-		list_splice(&cinfo->ds->buckets[i].committing,
-			    &buckets[i].committing);
-		buckets[i].direct_verf.committed =
-			cinfo->ds->buckets[i].direct_verf.committed;
-		buckets[i].wlseg = cinfo->ds->buckets[i].wlseg;
-		buckets[i].clseg = cinfo->ds->buckets[i].clseg;
-	}
-	swap(cinfo->ds->buckets, buckets);
-	cinfo->ds->nbuckets = size;
-out:
-	spin_unlock(&cinfo->inode->i_lock);
-	kfree(buckets);
-	return 0;
-}
-
 static struct pnfs_layout_segment *
 filelayout_alloc_lseg(struct pnfs_layout_hdr *layoutid,
 		      struct nfs4_layoutget_res *lgr,
@@ -943,9 +883,6 @@ static void
 filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			 struct nfs_page *req)
 {
-	struct nfs_commit_info cinfo;
-	int status;
-
 	pnfs_generic_pg_check_layout(pgio);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
@@ -964,17 +901,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 
 	/* If no lseg, fall back to write through mds */
 	if (pgio->pg_lseg == NULL)
-		goto out_mds;
-	nfs_init_cinfo(&cinfo, pgio->pg_inode, pgio->pg_dreq);
-	status = filelayout_alloc_commit_info(pgio->pg_lseg, &cinfo, GFP_NOFS);
-	if (status < 0) {
-		pnfs_put_lseg(pgio->pg_lseg);
-		pgio->pg_lseg = NULL;
-		goto out_mds;
-	}
-	return;
-out_mds:
-	nfs_pageio_reset_write_mds(pgio);
+		nfs_pageio_reset_write_mds(pgio);
 }
 
 static const struct nfs_pageio_ops filelayout_pg_read_ops = {
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index e4db8510ef5f..8fed7bae70b3 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -550,17 +550,6 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	goto out_free_page;
 }
 
-static bool ff_layout_has_rw_segments(struct pnfs_layout_hdr *layout)
-{
-	struct pnfs_layout_segment *lseg;
-
-	list_for_each_entry(lseg, &layout->plh_segs, pls_list)
-		if (lseg->pls_range.iomode == IOMODE_RW)
-			return true;
-
-	return false;
-}
-
 static void
 ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 {
@@ -575,24 +564,12 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 		ffl = FF_LAYOUT_FROM_HDR(lseg->pls_layout);
 		inode = ffl->generic_hdr.plh_inode;
 		spin_lock(&inode->i_lock);
-		if (!ff_layout_has_rw_segments(lseg->pls_layout)) {
-			ffl->commit_info.nbuckets = 0;
-			kfree(ffl->commit_info.buckets);
-			ffl->commit_info.buckets = NULL;
-		}
 		pnfs_generic_ds_cinfo_release_lseg(&ffl->commit_info, lseg);
 		spin_unlock(&inode->i_lock);
 	}
 	_ff_layout_free_lseg(fls);
 }
 
-/* Return 1 until we have multiple lsegs support */
-static int
-ff_layout_get_lseg_count(struct nfs4_ff_layout_segment *fls)
-{
-	return 1;
-}
-
 static void
 nfs4_ff_start_busy_timer(struct nfs4_ff_busy_timer *timer, ktime_t now)
 {
@@ -737,52 +714,6 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 	spin_unlock(&mirror->lock);
 }
 
-static int
-ff_layout_alloc_commit_info(struct pnfs_layout_segment *lseg,
-			    struct nfs_commit_info *cinfo,
-			    gfp_t gfp_flags)
-{
-	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
-	struct pnfs_commit_bucket *buckets;
-	int size;
-
-	if (cinfo->ds->nbuckets != 0) {
-		/* This assumes there is only one RW lseg per file.
-		 * To support multiple lseg per file, we need to
-		 * change struct pnfs_commit_bucket to allow dynamic
-		 * increasing nbuckets.
-		 */
-		return 0;
-	}
-
-	size = ff_layout_get_lseg_count(fls) * FF_LAYOUT_MIRROR_COUNT(lseg);
-
-	buckets = kcalloc(size, sizeof(struct pnfs_commit_bucket),
-			  gfp_flags);
-	if (!buckets)
-		return -ENOMEM;
-	else {
-		int i;
-
-		spin_lock(&cinfo->inode->i_lock);
-		if (cinfo->ds->nbuckets != 0)
-			kfree(buckets);
-		else {
-			cinfo->ds->buckets = buckets;
-			cinfo->ds->nbuckets = size;
-			for (i = 0; i < size; i++) {
-				INIT_LIST_HEAD(&buckets[i].written);
-				INIT_LIST_HEAD(&buckets[i].committing);
-				/* mark direct verifier as unset */
-				buckets[i].direct_verf.committed =
-					NFS_INVALID_STABLE_HOW;
-			}
-		}
-		spin_unlock(&cinfo->inode->i_lock);
-		return 0;
-	}
-}
-
 static void
 ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, int idx)
 {
@@ -944,10 +875,8 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs_pgio_mirror *pgm;
-	struct nfs_commit_info cinfo;
 	struct nfs4_pnfs_ds *ds;
 	int i;
-	int status;
 
 retry:
 	pnfs_generic_pg_check_layout(pgio);
@@ -969,11 +898,6 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	if (pgio->pg_lseg == NULL)
 		goto out_mds;
 
-	nfs_init_cinfo(&cinfo, pgio->pg_inode, pgio->pg_dreq);
-	status = ff_layout_alloc_commit_info(pgio->pg_lseg, &cinfo, GFP_NOFS);
-	if (status < 0)
-		goto out_mds;
-
 	/* Use a direct mapping of ds_idx to pgio mirror_idx */
 	if (WARN_ON_ONCE(pgio->pg_mirror_count !=
 	    FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg)))
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 683146a51599..78f317fac940 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -531,9 +531,6 @@ void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 {
 	struct pnfs_commit_array *array;
 
-	pnfs_bucket_clear_pnfs_ds_commit_verifiers(cinfo->buckets,
-			cinfo->nbuckets);
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(array, &cinfo->commits, cinfo_list)
 		pnfs_bucket_clear_pnfs_ds_commit_verifiers(array->buckets,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 9b55919e64ac..20f12f3cbe38 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -292,12 +292,6 @@ int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max)
 	struct pnfs_commit_array *array;
 	int rv = 0, cnt;
 
-	cnt = pnfs_bucket_scan_array(cinfo, fl_cinfo->buckets,
-			fl_cinfo->nbuckets, max);
-	rv += cnt;
-	max -= cnt;
-	if (!max)
-		return rv;
 	rcu_read_lock();
 	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
 		if (!array->lseg || !pnfs_get_commit_array(array))
@@ -353,11 +347,6 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 	unsigned int nwritten;
 
 	lockdep_assert_held(&NFS_I(cinfo->inode)->commit_mutex);
-	nwritten = pnfs_bucket_recover_commit_reqs(dst,
-						   fl_cinfo->buckets,
-						   fl_cinfo->nbuckets,
-						   cinfo);
-	fl_cinfo->nwritten -= nwritten;
 	rcu_read_lock();
 	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
 		if (!array->lseg || !pnfs_get_commit_array(array))
@@ -412,10 +401,6 @@ pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page
 	struct pnfs_commit_array *array;
 	struct nfs_page *req;
 
-	req = pnfs_bucket_search_commit_reqs(fl_cinfo->buckets,
-			fl_cinfo->nbuckets, page);
-	if (req)
-		return req;
 	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
 		req = pnfs_bucket_search_commit_reqs(array->buckets,
 				array->nbuckets, page);
@@ -550,9 +535,6 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 		nreq++;
 	}
 
-	nreq += pnfs_bucket_alloc_ds_commits(&list, fl_cinfo->buckets,
-			fl_cinfo->nbuckets, cinfo);
-
 	nreq += pnfs_alloc_ds_commits_list(&list, fl_cinfo, cinfo);
 	if (nreq == 0)
 		goto out;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 33be2ee2a248..2903597ec88c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1284,8 +1284,6 @@ struct pnfs_ds_commit_info {
 	struct list_head commits;
 	unsigned int nwritten;
 	unsigned int ncommitting;
-	unsigned int nbuckets;
-	struct pnfs_commit_bucket *buckets;
 };
 
 struct nfs41_state_protection {
@@ -1396,22 +1394,11 @@ struct nfs41_free_stateid_res {
 	unsigned int			status;
 };
 
-static inline void
-nfs_free_pnfs_ds_cinfo(struct pnfs_ds_commit_info *cinfo)
-{
-	kfree(cinfo->buckets);
-}
-
 #else
 
 struct pnfs_ds_commit_info {
 };
 
-static inline void
-nfs_free_pnfs_ds_cinfo(struct pnfs_ds_commit_info *cinfo)
-{
-}
-
 #endif /* CONFIG_NFS_V4_1 */
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.25.1

