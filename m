Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F870196704
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgC1Pel (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgC1Pej (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:39 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE3F20748
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409678;
        bh=kgJwq8VPMwifyd0KwkcA6eKekrxmSxwH7DFb8y8BizM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cnRBdHQ/YDDFPzYq3GaGFXyXQTUTsU9JcG6NaRsFOCv7yzf9qzRRValUhcA3R/Qis
         1ekZB/ZM2cwoxcOHX5tXrUHrfp/OpGtFiqbZU0GW4lFXc07xKMXjfG+h+pvgOquCY9
         K4JTnAyEL53+l2+spnb4bdXgntlW4QgIGFjSJTK8=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/22] pNFS: Add infrastructure for cleaning up per-layout commit structures
Date:   Sat, 28 Mar 2020 11:32:10 -0400
Message-Id: <20200328153220.1352010-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-12-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that both the file and flexfiles layout types clean up when
freeing the layout segments.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/filelayout/filelayout.c         | 16 +++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 ++++
 fs/nfs/internal.h                      |  4 +-
 fs/nfs/pnfs.c                          |  1 +
 fs/nfs/pnfs.h                          |  4 ++
 fs/nfs/pnfs_nfs.c                      | 88 +++++++++++++++++++++++++-
 include/linux/nfs_xdr.h                |  1 +
 7 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index b051d5d320ba..ffc5e2af1776 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -750,11 +750,16 @@ filelayout_free_lseg(struct pnfs_layout_segment *lseg)
 	/* This assumes a single RW lseg */
 	if (lseg->pls_range.iomode == IOMODE_RW) {
 		struct nfs4_filelayout *flo;
+		struct inode *inode;
 
 		flo = FILELAYOUT_FROM_HDR(lseg->pls_layout);
+		inode = flo->generic_hdr.plh_inode;
+		spin_lock(&inode->i_lock);
 		flo->commit_info.nbuckets = 0;
 		kfree(flo->commit_info.buckets);
 		flo->commit_info.buckets = NULL;
+		pnfs_generic_ds_cinfo_release_lseg(&flo->commit_info, lseg);
+		spin_unlock(&inode->i_lock);
 	}
 	_filelayout_free_lseg(fl);
 }
@@ -1163,6 +1168,16 @@ filelayout_get_ds_info(struct inode *inode)
 		return &FILELAYOUT_FROM_HDR(layout)->commit_info;
 }
 
+static void
+filelayout_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
+		struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	pnfs_generic_ds_cinfo_destroy(fl_cinfo);
+	spin_unlock(&inode->i_lock);
+}
+
+
 static struct pnfs_layoutdriver_type filelayout_type = {
 	.id			= LAYOUT_NFSV4_1_FILES,
 	.name			= "LAYOUT_NFSV4_1_FILES",
@@ -1176,6 +1191,7 @@ static struct pnfs_layoutdriver_type filelayout_type = {
 	.pg_read_ops		= &filelayout_pg_read_ops,
 	.pg_write_ops		= &filelayout_pg_write_ops,
 	.get_ds_info		= &filelayout_get_ds_info,
+	.release_ds_info	= filelayout_release_ds_info,
 	.mark_request_commit	= filelayout_mark_request_commit,
 	.clear_request_commit	= pnfs_generic_clear_request_commit,
 	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index c9e79c8e62cd..8e1393d75cbc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -580,6 +580,7 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 			kfree(ffl->commit_info.buckets);
 			ffl->commit_info.buckets = NULL;
 		}
+		pnfs_generic_ds_cinfo_release_lseg(&ffl->commit_info, lseg);
 		spin_unlock(&inode->i_lock);
 	}
 	_ff_layout_free_lseg(fls);
@@ -2003,6 +2004,15 @@ ff_layout_get_ds_info(struct inode *inode)
 	return &FF_LAYOUT_FROM_HDR(layout)->commit_info;
 }
 
+static void
+ff_layout_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
+		struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	pnfs_generic_ds_cinfo_destroy(fl_cinfo);
+	spin_unlock(&inode->i_lock);
+}
+
 static void
 ff_layout_free_deviceid_node(struct nfs4_deviceid_node *d)
 {
@@ -2503,6 +2513,7 @@ static struct pnfs_layoutdriver_type flexfilelayout_type = {
 	.pg_read_ops		= &ff_layout_pg_read_ops,
 	.pg_write_ops		= &ff_layout_pg_write_ops,
 	.get_ds_info		= ff_layout_get_ds_info,
+	.release_ds_info	= ff_layout_release_ds_info,
 	.free_deviceid_node	= ff_layout_free_deviceid_node,
 	.mark_request_commit	= pnfs_layout_mark_request_commit,
 	.clear_request_commit	= pnfs_generic_clear_request_commit,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 4a1adad3740f..683146a51599 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -534,9 +534,11 @@ void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 	pnfs_bucket_clear_pnfs_ds_commit_verifiers(cinfo->buckets,
 			cinfo->nbuckets);
 
-	list_for_each_entry(array, &cinfo->commits, cinfo_list)
+	rcu_read_lock();
+	list_for_each_entry_rcu(array, &cinfo->commits, cinfo_list)
 		pnfs_bucket_clear_pnfs_ds_commit_verifiers(array->buckets,
 				array->nbuckets);
+	rcu_read_unlock();
 }
 #else
 static inline
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 6b25117fca5f..eba18f137fb0 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -506,6 +506,7 @@ pnfs_init_lseg(struct pnfs_layout_hdr *lo, struct pnfs_layout_segment *lseg,
 {
 	INIT_LIST_HEAD(&lseg->pls_list);
 	INIT_LIST_HEAD(&lseg->pls_lc_list);
+	INIT_LIST_HEAD(&lseg->pls_commits);
 	refcount_set(&lseg->pls_refcount, 1);
 	set_bit(NFS_LSEG_VALID, &lseg->pls_flags);
 	lseg->pls_layout = lo;
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 2ec97b419b56..6c48bd7b4640 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -66,6 +66,7 @@ struct nfs4_pnfs_ds {
 struct pnfs_layout_segment {
 	struct list_head pls_list;
 	struct list_head pls_lc_list;
+	struct list_head pls_commits;
 	struct pnfs_layout_range pls_range;
 	refcount_t pls_refcount;
 	u32 pls_seq;
@@ -370,6 +371,9 @@ void nfs4_deviceid_purge_client(const struct nfs_client *);
 /* pnfs_nfs.c */
 struct pnfs_commit_array *pnfs_alloc_commit_array(size_t n, gfp_t gfp_flags);
 void pnfs_free_commit_array(struct pnfs_commit_array *p);
+void pnfs_generic_ds_cinfo_release_lseg(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg);
+void pnfs_generic_ds_cinfo_destroy(struct pnfs_ds_commit_info *fl_cinfo);
 
 void pnfs_generic_clear_request_commit(struct nfs_page *req,
 				       struct nfs_commit_info *cinfo);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index f895a28b1e26..edad251a6a48 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -118,6 +118,67 @@ pnfs_free_commit_array(struct pnfs_commit_array *p)
 }
 EXPORT_SYMBOL_GPL(pnfs_free_commit_array);
 
+static void
+pnfs_release_commit_array_locked(struct pnfs_commit_array *array)
+{
+	list_del_rcu(&array->cinfo_list);
+	list_del(&array->lseg_list);
+	pnfs_free_commit_array(array);
+}
+
+static void
+pnfs_put_commit_array_locked(struct pnfs_commit_array *array)
+{
+	if (refcount_dec_and_test(&array->refcount))
+		pnfs_release_commit_array_locked(array);
+}
+
+static void
+pnfs_put_commit_array(struct pnfs_commit_array *array, struct inode *inode)
+{
+	if (refcount_dec_and_lock(&array->refcount, &inode->i_lock)) {
+		pnfs_release_commit_array_locked(array);
+		spin_unlock(&inode->i_lock);
+	}
+}
+
+static struct pnfs_commit_array *
+pnfs_get_commit_array(struct pnfs_commit_array *array)
+{
+	if (refcount_inc_not_zero(&array->refcount))
+		return array;
+	return NULL;
+}
+
+static void
+pnfs_remove_and_free_commit_array(struct pnfs_commit_array *array)
+{
+	array->lseg = NULL;
+	list_del_init(&array->lseg_list);
+	pnfs_put_commit_array_locked(array);
+}
+
+void
+pnfs_generic_ds_cinfo_release_lseg(struct pnfs_ds_commit_info *fl_cinfo,
+		struct pnfs_layout_segment *lseg)
+{
+	struct pnfs_commit_array *array, *tmp;
+
+	list_for_each_entry_safe(array, tmp, &lseg->pls_commits, lseg_list)
+		pnfs_remove_and_free_commit_array(array);
+}
+EXPORT_SYMBOL_GPL(pnfs_generic_ds_cinfo_release_lseg);
+
+void
+pnfs_generic_ds_cinfo_destroy(struct pnfs_ds_commit_info *fl_cinfo)
+{
+	struct pnfs_commit_array *array, *tmp;
+
+	list_for_each_entry_safe(array, tmp, &fl_cinfo->commits, cinfo_list)
+		pnfs_remove_and_free_commit_array(array);
+}
+EXPORT_SYMBOL_GPL(pnfs_generic_ds_cinfo_destroy);
+
 /*
  * Locks the nfs_page requests for commit and moves them to
  * @bucket->committing.
@@ -177,14 +238,21 @@ int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max)
 	max -= cnt;
 	if (!max)
 		return rv;
-	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
+		if (!array->lseg || !pnfs_get_commit_array(array))
+			continue;
+		rcu_read_unlock();
 		cnt = pnfs_bucket_scan_array(cinfo, array->buckets,
 				array->nbuckets, max);
+		rcu_read_lock();
+		pnfs_put_commit_array(array, cinfo->inode);
 		rv += cnt;
 		max -= cnt;
 		if (!max)
 			break;
 	}
+	rcu_read_unlock();
 	return rv;
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_scan_commit_lists);
@@ -230,13 +298,20 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 						   fl_cinfo->nbuckets,
 						   cinfo);
 	fl_cinfo->nwritten -= nwritten;
-	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
+		if (!array->lseg || !pnfs_get_commit_array(array))
+			continue;
+		rcu_read_unlock();
 		nwritten = pnfs_bucket_recover_commit_reqs(dst,
 							   array->buckets,
 							   array->nbuckets,
 							   cinfo);
+		rcu_read_lock();
+		pnfs_put_commit_array(array, cinfo->inode);
 		fl_cinfo->nwritten -= nwritten;
 	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
@@ -330,9 +405,16 @@ pnfs_alloc_ds_commits_list(struct list_head *list,
 	struct pnfs_commit_array *array;
 	unsigned int ret = 0;
 
-	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list)
+	rcu_read_lock();
+	list_for_each_entry_rcu(array, &fl_cinfo->commits, cinfo_list) {
+		if (!array->lseg || !pnfs_get_commit_array(array))
+			continue;
+		rcu_read_unlock();
 		ret += pnfs_bucket_alloc_ds_commits(list, array->buckets,
 				array->nbuckets, cinfo);
+		rcu_read_lock();
+		pnfs_put_commit_array(array, cinfo->inode);
+	}
 	return ret;
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9946787eda72..33be2ee2a248 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1275,6 +1275,7 @@ struct pnfs_commit_array {
 	struct list_head lseg_list;
 	struct pnfs_layout_segment *lseg;
 	struct rcu_head rcu;
+	refcount_t refcount;
 	unsigned int nbuckets;
 	struct pnfs_commit_bucket buckets[];
 };
-- 
2.25.1

