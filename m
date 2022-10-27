Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D36104CB
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiJ0VwY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiJ0VwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:52:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11F5F7E8
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 14:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F36DDCE28B8
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EBBC433C1;
        Thu, 27 Oct 2022 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907536;
        bh=LF/mMuVne9YyFnpkdxQM+OwDmE1rBStMIveYjr74xkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgzonFeup5i+korEOyglRXoBXg1DmTA1YMibjFiBLwMtcTE2k5K9vQ1GYD8v7N22J
         RVp6g9+kZSMH3WlrkUPm/7HpG1+ddgdpKu7x0h2HOW2CblQSibHmjgKiWjM7jHYDtX
         kcVhpWSl8X1k4WJsBqf8pKPuqrXX0Sd4V0hl+SUrZzQVTOh1uOJw17qzbKJYC8y/R1
         dAYoEfUaJPGuvyEHpGa12c6WcFFdq2ktMmPp1H4f9tpqwqCo0FpS1qQZ3Zf1Go1KpN
         UwJkpHe6BB9V8K26R/jcuLX5HSpjxj6lMAjVnLRLtsav15AGJcnNVmNiFguFgA5tH2
         99235FCBcQMSA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v2 1/3] nfsd: rework refcounting in filecache
Date:   Thu, 27 Oct 2022 17:52:11 -0400
Message-Id: <20221027215213.138304-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027215213.138304-1-jlayton@kernel.org>
References: <20221027215213.138304-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The filecache refcounting is a bit non-standard for something searchable
by RCU, in that we maintain a sentinel reference while it's hashed. This
in turn requires that we have to do things differently in the "put"
depending on whether its hashed, which we believe to have led to races.

There are other problems in here too. nfsd_file_close_inode_sync can end
up freeing an nfsd_file while there are still outstanding references to
it, and the handling

Rework the code so that the refcount is what drives the lifecycle. When
the refcount goes to zero, then unhash and rcu free the object.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 291 +++++++++++++++++++++-----------------------
 fs/nfsd/trace.h     |   5 +-
 2 files changed, 144 insertions(+), 152 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 98c6b5f51bc8..e63534f4b9f8 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * The NFSD open file cache.
+ *
+ * Each nfsd_file is created in response to client activity -- either regular
+ * file I/O for v2/v3, or opening a file for v4. Files opened via v4 are
+ * cleaned up as soon as their refcount goes to 0.  Entries for v2/v3 are
+ * flagged with NFSD_FILE_GC. On their last put, they are added to the LRU for
+ * eventual disposal if they aren't used again within a short time period.
  */
 
 #include <linux/hash.h>
@@ -302,31 +308,43 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 		if (key->gc)
 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
 		nf->nf_inode = key->inode;
-		/* nf_ref is pre-incremented for hash table */
-		refcount_set(&nf->nf_ref, 2);
+		refcount_set(&nf->nf_ref, 1);
 		nf->nf_may = key->need;
 		nf->nf_mark = NULL;
 	}
 	return nf;
 }
 
-static bool
+static void
+nfsd_file_flush(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return;
+	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
+	if (vfs_fsync(file, 1) != 0)
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
+}
+
+static void
 nfsd_file_free(struct nfsd_file *nf)
 {
 	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
-	bool flush = false;
+
+	trace_nfsd_file_free(nf);
 
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
-	trace_nfsd_file_put_final(nf);
+	nfsd_file_flush(nf);
+
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
 		get_file(nf->nf_file);
 		filp_close(nf->nf_file, NULL);
 		fput(nf->nf_file);
-		flush = true;
 	}
 
 	/*
@@ -334,10 +352,9 @@ nfsd_file_free(struct nfsd_file *nf)
 	 * WARN and leak it to preserve system stability.
 	 */
 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
-		return flush;
+		return;
 
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
-	return flush;
 }
 
 static bool
@@ -363,29 +380,23 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
 }
 
-static void
-nfsd_file_flush(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return;
-	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
-	if (vfs_fsync(file, 1) != 0)
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-}
-
-static void nfsd_file_lru_add(struct nfsd_file *nf)
+static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
+	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_add(nf);
+		return true;
+	}
+	return false;
 }
 
-static void nfsd_file_lru_remove(struct nfsd_file *nf)
+static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
+	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_del(nf);
+		return true;
+	}
+	return false;
 }
 
 static void
@@ -409,94 +420,89 @@ nfsd_file_unhash(struct nfsd_file *nf)
 	return false;
 }
 
-static void
-nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispose)
+struct nfsd_file *
+nfsd_file_get(struct nfsd_file *nf)
 {
-	trace_nfsd_file_unhash_and_dispose(nf);
+	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
+		return nf;
+	return NULL;
+}
+
+/**
+ * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose list
+ * @nf: nfsd_file to be unhashed and queued
+ * @dispose: list to which it should be queued
+ *
+ * Attempt to unhash a nfsd_file and queue it to the given list. Each file
+ * will have a reference held on behalf of the list. That reference may come
+ * from the LRU, or we may need to take one. If we can't get a reference,
+ * ignore it altogether.
+ */
+static bool
+nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
+{
+	trace_nfsd_file_unhash_and_queue(nf);
 	if (nfsd_file_unhash(nf)) {
-		/* caller must call nfsd_file_dispose_list() later */
-		nfsd_file_lru_remove(nf);
+		/*
+		 * If we remove it from the LRU, then just use that
+		 * reference for the dispose list. Otherwise, we need
+		 * to take a reference. If that fails, just ignore
+		 * the file altogether.
+		 */
+		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
+			return false;
 		list_add(&nf->nf_lru, dispose);
+		return true;
 	}
+	return false;
 }
 
-static void
-nfsd_file_put_noref(struct nfsd_file *nf)
+static bool
+__nfsd_file_put(struct nfsd_file *nf)
 {
-	trace_nfsd_file_put(nf);
-
 	if (refcount_dec_and_test(&nf->nf_ref)) {
-		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
-		nfsd_file_lru_remove(nf);
+		nfsd_file_unhash(nf);
 		nfsd_file_free(nf);
+		return true;
 	}
+	return false;
 }
 
-static void
-nfsd_file_unhash_and_put(struct nfsd_file *nf)
-{
-	if (nfsd_file_unhash(nf))
-		nfsd_file_put_noref(nf);
-}
-
+/**
+ * nfsd_file_put - put the reference to a nfsd_file
+ * @nf: nfsd_file of which to put the reference
+ *
+ * Put a reference to a nfsd_file. In the v4 case, we just put the
+ * reference immediately. In the v2/3 case, if the reference would be
+ * the last one, the put it on the LRU instead to be cleaned up later.
+ */
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
-	might_sleep();
-
-	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
-		nfsd_file_lru_add(nf);
-	else if (refcount_read(&nf->nf_ref) == 2)
-		nfsd_file_unhash_and_put(nf);
-
-	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_flush(nf);
-		nfsd_file_put_noref(nf);
-	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
-		nfsd_file_put_noref(nf);
-		nfsd_file_schedule_laundrette();
-	} else
-		nfsd_file_put_noref(nf);
-}
-
-struct nfsd_file *
-nfsd_file_get(struct nfsd_file *nf)
-{
-	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
-		return nf;
-	return NULL;
-}
-
-static void
-nfsd_file_dispose_list(struct list_head *dispose)
-{
-	struct nfsd_file *nf;
+	trace_nfsd_file_put(nf);
 
-	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
-		nfsd_file_put_noref(nf);
+	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
+		/*
+		 * If this is the last reference (nf_ref == 1), then transfer
+		 * it to the LRU. If the add to the LRU fails, just put it as
+		 * usual.
+		 */
+		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
+			return;
 	}
+	__nfsd_file_put(nf);
 }
 
 static void
-nfsd_file_dispose_list_sync(struct list_head *dispose)
+nfsd_file_dispose_list(struct list_head *dispose)
 {
-	bool flush = false;
 	struct nfsd_file *nf;
 
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
-		if (!refcount_dec_and_test(&nf->nf_ref))
-			continue;
-		if (nfsd_file_free(nf))
-			flush = true;
+		nfsd_file_free(nf);
 	}
-	if (flush)
-		flush_delayed_fput();
 }
 
 static void
@@ -566,21 +572,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	struct list_head *head = arg;
 	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
 
-	/*
-	 * Do a lockless refcount check. The hashtable holds one reference, so
-	 * we look to see if anything else has a reference, or if any have
-	 * been put since the shrinker last ran. Those don't get unhashed and
-	 * released.
-	 *
-	 * Note that in the put path, we set the flag and then decrement the
-	 * counter. Here we check the counter and then test and clear the flag.
-	 * That order is deliberate to ensure that we can do this locklessly.
-	 */
-	if (refcount_read(&nf->nf_ref) > 1) {
-		list_lru_isolate(lru, &nf->nf_lru);
-		trace_nfsd_file_gc_in_use(nf);
-		return LRU_REMOVED;
-	}
+	/* We should only be dealing with v2/3 entries here */
+	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
 
 	/*
 	 * Don't throw out files that are still undergoing I/O or
@@ -591,40 +584,30 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 		return LRU_SKIP;
 	}
 
+	/* If it was recently added to the list, skip it */
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
 		trace_nfsd_file_gc_referenced(nf);
 		return LRU_ROTATE;
 	}
 
-	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		trace_nfsd_file_gc_hashed(nf);
-		return LRU_SKIP;
+	/*
+	 * Put the reference held on behalf of the LRU. If it wasn't the last
+	 * one, then just remove it from the LRU and ignore it.
+	 */
+	if (!refcount_dec_and_test(&nf->nf_ref)) {
+		trace_nfsd_file_gc_in_use(nf);
+		list_lru_isolate(lru, &nf->nf_lru);
+		return LRU_REMOVED;
 	}
 
+	/* Refcount went to zero. Unhash it and queue it to the dispose list */
+	nfsd_file_unhash(nf);
 	list_lru_isolate_move(lru, &nf->nf_lru, head);
 	this_cpu_inc(nfsd_file_evictions);
 	trace_nfsd_file_gc_disposed(nf);
 	return LRU_REMOVED;
 }
 
-/*
- * Unhash items on @dispose immediately, then queue them on the
- * disposal workqueue to finish releasing them in the background.
- *
- * cel: Note that between the time list_lru_shrink_walk runs and
- * now, these items are in the hash table but marked unhashed.
- * Why release these outside of lru_cb ? There's no lock ordering
- * problem since lru_cb currently takes no lock.
- */
-static void nfsd_file_gc_dispose_list(struct list_head *dispose)
-{
-	struct nfsd_file *nf;
-
-	list_for_each_entry(nf, dispose, nf_lru)
-		nfsd_file_hash_remove(nf);
-	nfsd_file_dispose_list_delayed(dispose);
-}
-
 static void
 nfsd_file_gc(void)
 {
@@ -634,7 +617,7 @@ nfsd_file_gc(void)
 	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
 			    &dispose, list_lru_count(&nfsd_file_lru));
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -659,7 +642,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -670,8 +653,11 @@ static struct shrinker	nfsd_file_shrinker = {
 };
 
 /*
- * Find all cache items across all net namespaces that match @inode and
- * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
+ * Find all cache items across all net namespaces that match @inode, unhash
+ * them, take references and then put them on @dispose if that was successful.
+ *
+ * The nfsd_file objects on the list will be unhashed, and each will have a
+ * reference taken.
  */
 static unsigned int
 __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
@@ -689,52 +675,58 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
-		nfsd_file_unhash_and_dispose(nf, dispose);
-		count++;
+
+		if (nfsd_file_unhash_and_queue(nf, dispose))
+			count++;
 	} while (1);
 	rcu_read_unlock();
 	return count;
 }
 
 /**
- * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put, then flush and fput all cache items associated with @inode.
+ * Unhash and put all cache item associated with @inode.
  */
-void
-nfsd_file_close_inode_sync(struct inode *inode)
+static unsigned int
+nfsd_file_close_inode(struct inode *inode)
 {
-	LIST_HEAD(dispose);
+	struct nfsd_file *nf;
 	unsigned int count;
+	LIST_HEAD(dispose);
 
 	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode_sync(inode, count);
-	nfsd_file_dispose_list_sync(&dispose);
+	trace_nfsd_file_close_inode(inode, count);
+	if (count) {
+		while(!list_empty(&dispose)) {
+			nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
+			list_del_init(&nf->nf_lru);
+			trace_nfsd_file_closing(nf);
+			__nfsd_file_put(nf);
+		}
+	}
+	return count;
 }
 
 /**
- * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
+ * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put all cache item associated with @inode.
+ * Unhash and put, then flush and fput all cache items associated with @inode.
  */
-static void
-nfsd_file_close_inode(struct inode *inode)
+void
+nfsd_file_close_inode_sync(struct inode *inode)
 {
-	LIST_HEAD(dispose);
-	unsigned int count;
-
-	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode(inode, count);
-	nfsd_file_dispose_list_delayed(&dispose);
+	if (nfsd_file_close_inode(inode))
+		flush_delayed_fput();
 }
 
 /**
  * nfsd_file_delayed_close - close unused nfsd_files
  * @work: dummy
  *
- * Walk the LRU list and close any entries that have not been used since
+ * Walk the LRU list and destroy any entries that have not been used since
  * the last scan.
  */
 static void
@@ -892,7 +884,7 @@ __nfsd_file_cache_purge(struct net *net)
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (net && nf->nf_net != net)
 				continue;
-			nfsd_file_unhash_and_dispose(nf, &dispose);
+			nfsd_file_unhash_and_queue(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
@@ -1093,11 +1085,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 		}
 		open_retry = false;
-		nfsd_file_put_noref(nf);
+		__nfsd_file_put(nf);
 		goto retry;
 	}
 
-	nfsd_file_lru_remove(nf);
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
@@ -1107,7 +1098,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	} else {
-		nfsd_file_put(nf);
+		__nfsd_file_put(nf);
 		nf = NULL;
 	}
 
@@ -1134,7 +1125,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * then unhash.
 	 */
 	if (status != nfs_ok || key.inode->i_nlink == 0)
-		nfsd_file_unhash_and_put(nf);
+		nfsd_file_unhash(nf);
 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b09ab4f92d43..a44ded06af87 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -903,10 +903,11 @@ DEFINE_EVENT(nfsd_file_class, name, \
 	TP_PROTO(struct nfsd_file *nf), \
 	TP_ARGS(nf))
 
-DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
-DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
 
 TRACE_EVENT(nfsd_file_alloc,
 	TP_PROTO(
-- 
2.37.3

