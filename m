Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE4611A8F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJ1S5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJ1S5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:57:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C6A1D2B54
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44DF0B82C8F
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 18:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C37C433B5;
        Fri, 28 Oct 2022 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666983436;
        bh=qOT8H5RpLfKLLrfR6El2eT1QdYz3jtsg++rTNoL3JDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3RQG6O1CqVlD4Khjr8x9CBCBWfffwtd+e5A/vWK7f1PC4tHoxFY7rroo4bAEcdJW
         VU3FMiOmhxYY7Gmg8oFLTnqqAkjpVwvW5EuL21gUUYC4T+NMAVogKN/PGxcjnyiC46
         HdxUIerxshJM829n4JN36BUmzcRC95tc9ZveXboeYFBsQve0eb8p1vEUZ+vFwhfpwA
         6slJOL1aHR/4VO7u+SzfdkIvCXV99KTVNIJLz2+pfoYyXud9Cg9l7Adya7mHQOb6I+
         bXM/Y0b6XA8sTz03jHq3C1n2eMvCsooIQU3pgaBgwq7TQM4JKEDYgMqOV/12UjpAeD
         tlL6t+CmdGuSQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Date:   Fri, 28 Oct 2022 14:57:10 -0400
Message-Id: <20221028185712.79863-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028185712.79863-1-jlayton@kernel.org>
References: <20221028185712.79863-1-jlayton@kernel.org>
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
it, and there are a number of subtle ToC/ToU races.

Rework the code so that the refcount is what drives the lifecycle. When
the refcount goes to zero, then unhash and rcu free the object.

With this change, the LRU carries a reference. Take special care to
deal with it when removing an entry from the list.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 357 ++++++++++++++++++++++----------------------
 fs/nfsd/trace.h     |   5 +-
 2 files changed, 178 insertions(+), 184 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f8ebbf7daa18..d928c5e38eeb 100644
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
@@ -301,55 +307,22 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
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
-nfsd_file_free(struct nfsd_file *nf)
-{
-	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
-	bool flush = false;
-
-	this_cpu_inc(nfsd_file_releases);
-	this_cpu_add(nfsd_file_total_age, age);
-
-	trace_nfsd_file_put_final(nf);
-	if (nf->nf_mark)
-		nfsd_file_mark_put(nf->nf_mark);
-	if (nf->nf_file) {
-		get_file(nf->nf_file);
-		filp_close(nf->nf_file, NULL);
-		fput(nf->nf_file);
-		flush = true;
-	}
-
-	/*
-	 * If this item is still linked via nf_lru, that's a bug.
-	 * WARN and leak it to preserve system stability.
-	 */
-	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
-		return flush;
-
-	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
-	return flush;
-}
-
-static bool
-nfsd_file_check_writeback(struct nfsd_file *nf)
+static void
+nfsd_file_fsync(struct nfsd_file *nf)
 {
 	struct file *file = nf->nf_file;
-	struct address_space *mapping;
 
 	if (!file || !(file->f_mode & FMODE_WRITE))
-		return false;
-	mapping = file->f_mapping;
-	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
-		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
+		return;
+	if (vfs_fsync(file, 1) != 0)
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
 static int
@@ -362,30 +335,6 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
 }
 
-static void
-nfsd_file_flush(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return;
-	if (vfs_fsync(file, 1) != 0)
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-}
-
-static void nfsd_file_lru_add(struct nfsd_file *nf)
-{
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
-		trace_nfsd_file_lru_add(nf);
-}
-
-static void nfsd_file_lru_remove(struct nfsd_file *nf)
-{
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
-		trace_nfsd_file_lru_del(nf);
-}
-
 static void
 nfsd_file_hash_remove(struct nfsd_file *nf)
 {
@@ -408,53 +357,66 @@ nfsd_file_unhash(struct nfsd_file *nf)
 }
 
 static void
-nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispose)
+nfsd_file_free(struct nfsd_file *nf)
 {
-	trace_nfsd_file_unhash_and_dispose(nf);
-	if (nfsd_file_unhash(nf)) {
-		/* caller must call nfsd_file_dispose_list() later */
-		nfsd_file_lru_remove(nf);
-		list_add(&nf->nf_lru, dispose);
+	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
+
+	trace_nfsd_file_free(nf);
+
+	this_cpu_inc(nfsd_file_releases);
+	this_cpu_add(nfsd_file_total_age, age);
+
+	nfsd_file_unhash(nf);
+	nfsd_file_fsync(nf);
+
+	if (nf->nf_mark)
+		nfsd_file_mark_put(nf->nf_mark);
+	if (nf->nf_file) {
+		get_file(nf->nf_file);
+		filp_close(nf->nf_file, NULL);
+		fput(nf->nf_file);
 	}
+
+	/*
+	 * If this item is still linked via nf_lru, that's a bug.
+	 * WARN and leak it to preserve system stability.
+	 */
+	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
+		return;
+
+	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
 }
 
-static void
-nfsd_file_put_noref(struct nfsd_file *nf)
+static bool
+nfsd_file_check_writeback(struct nfsd_file *nf)
 {
-	trace_nfsd_file_put(nf);
+	struct file *file = nf->nf_file;
+	struct address_space *mapping;
 
-	if (refcount_dec_and_test(&nf->nf_ref)) {
-		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
-		nfsd_file_lru_remove(nf);
-		nfsd_file_free(nf);
-	}
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return false;
+	mapping = file->f_mapping;
+	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
+		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static void
-nfsd_file_unhash_and_put(struct nfsd_file *nf)
+static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
-	if (nfsd_file_unhash(nf))
-		nfsd_file_put_noref(nf);
+	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
+		trace_nfsd_file_lru_add(nf);
+		return true;
+	}
+	return false;
 }
 
-void
-nfsd_file_put(struct nfsd_file *nf)
+static bool nfsd_file_lru_remove(struct nfsd_file *nf)
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
+	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
+		trace_nfsd_file_lru_del(nf);
+		return true;
+	}
+	return false;
 }
 
 struct nfsd_file *
@@ -465,36 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
 	return NULL;
 }
 
-static void
-nfsd_file_dispose_list(struct list_head *dispose)
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
 {
-	struct nfsd_file *nf;
+	trace_nfsd_file_unhash_and_queue(nf);
+	if (nfsd_file_unhash(nf)) {
+		/*
+		 * If we remove it from the LRU, then just use that
+		 * reference for the dispose list. Otherwise, we need
+		 * to take a reference. If that fails, just ignore
+		 * the file altogether.
+		 */
+		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
+			return false;
+		list_add(&nf->nf_lru, dispose);
+		return true;
+	}
+	return false;
+}
 
-	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
-		nfsd_file_put_noref(nf);
+/**
+ * nfsd_file_put - put the reference to a nfsd_file
+ * @nf: nfsd_file of which to put the reference
+ *
+ * Put a reference to a nfsd_file. In the v4 case, we just put the
+ * reference immediately. In the v2/3 case, if the reference would be
+ * the last one, the put it on the LRU instead to be cleaned up later.
+ */
+void
+nfsd_file_put(struct nfsd_file *nf)
+{
+	trace_nfsd_file_put(nf);
+
+	/*
+	 * The HASHED check is racy. We may end up with the occasional
+	 * unhashed entry on the LRU, but they should get cleaned up
+	 * like any other.
+	 */
+	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		/*
+		 * If this is the last reference (nf_ref == 1), then transfer
+		 * it to the LRU. If the add to the LRU fails, just put it as
+		 * usual.
+		 */
+		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
+			return;
 	}
+	if (refcount_dec_and_test(&nf->nf_ref))
+		nfsd_file_free(nf);
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
@@ -564,21 +567,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
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
@@ -589,40 +579,30 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
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
@@ -632,7 +612,7 @@ nfsd_file_gc(void)
 	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
 			    &dispose, list_lru_count(&nfsd_file_lru));
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -657,7 +637,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -668,8 +648,11 @@ static struct shrinker	nfsd_file_shrinker = {
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
@@ -687,52 +670,59 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
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
+			if (refcount_dec_and_test(&nf->nf_ref))
+				nfsd_file_free(nf);
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
@@ -890,7 +880,7 @@ __nfsd_file_cache_purge(struct net *net)
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (net && nf->nf_net != net)
 				continue;
-			nfsd_file_unhash_and_dispose(nf, &dispose);
+			nfsd_file_unhash_and_queue(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
@@ -1054,8 +1044,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	rcu_read_lock();
 	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 			       nfsd_file_rhash_params);
-	if (nf)
-		nf = nfsd_file_get(nf);
+	if (nf) {
+		if (!nfsd_file_lru_remove(nf))
+			nf = nfsd_file_get(nf);
+	}
 	rcu_read_unlock();
 	if (nf)
 		goto wait_for_construction;
@@ -1090,11 +1082,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 		}
 		open_retry = false;
-		nfsd_file_put_noref(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
 		goto retry;
 	}
 
-	nfsd_file_lru_remove(nf);
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
@@ -1104,7 +1096,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	} else {
-		nfsd_file_put(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
 		nf = NULL;
 	}
 
@@ -1131,7 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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

