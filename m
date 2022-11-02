Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E5616CE0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiKBSo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKBSo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6892CE27
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28D561B0C
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FACC433D7;
        Wed,  2 Nov 2022 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414694;
        bh=PCOQ4p4/A3+nQ5Tbnr2FTs/a8wZYyFvGY/MQ3160LGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rY0ON8Rcia2vNpG/N2gyIzEH/SgemvovW2cZBHhdcxc+g6eO3ae5ZDZ8jAZLwBr0k
         UR8V+vkCtPoGitkr+aQPcw/+xcbZhhTCkKJ62+lmSCXRR1j4JYKMx9OCES78oOxvC0
         bQrJpo9UoWc6whoDFDI8Rt6GWxkB1XY9HZ3mb9j8LK7f4x5yLq0qL7ah8QxjLo6405
         U1Xdsy+QChl4sa4EqOIhKcH7AgTPyvZkWRax9teaVCoLt8h9BZ4NrfYyFs+5Vp+gxl
         yiJoCy4ESUgiaQicbhKItkLzQe6XOE1+iMe9DEIt2roX1VPzF8IJ2SsT5ArGN5knVQ
         N1f91tjpyO4Sw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v6 3/4] nfsd: rework refcounting in filecache
Date:   Wed,  2 Nov 2022 14:44:49 -0400
Message-Id: <20221102184450.130397-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184450.130397-1-jlayton@kernel.org>
References: <20221102184450.130397-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
the refcount goes to zero, then unhash and rcu free the object. With
this change, the LRU carries a reference. Take special care to deal with
it when removing an entry from the list.

The list_lru_add and list_lru_del functions use list_empty checks to see
whether the object is already on the LRU. That's fine in most cases, but
we occasionally repurpose nf_lru after unhashing. It's possible for an
LRU removal to remove it from a different list altogether if we lose a
race.

Add a new NFSD_FILE_LRU flag, which indicates that the object actually
resides on the LRU and not some other list. Use that when adding and
removing it from the LRU instead of just relying on list_empty checks.

Add an extra HASHED check after adding the entry to the LRU. If it's now
clear, just remove it from the LRU again and put the reference if that
remove is successful.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 290 ++++++++++++++++++++++++--------------------
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/trace.h     |   7 +-
 3 files changed, 165 insertions(+), 133 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c52c273df054..d8f9430d29e4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -327,8 +327,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 		if (key->gc)
 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
 		nf->nf_inode = key->inode;
-		/* nf_ref is pre-incremented for hash table */
-		refcount_set(&nf->nf_ref, 2);
+		refcount_set(&nf->nf_ref, 1);
 		nf->nf_may = key->need;
 		nf->nf_mark = NULL;
 	}
@@ -377,24 +376,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
 	return false;
 }
 
-static bool
+static void
 nfsd_file_free(struct nfsd_file *nf)
 {
 	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
-	bool flush = false;
 
 	trace_nfsd_file_free(nf);
 
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
+	nfsd_file_unhash(nf);
+
+	/*
+	 * We call fsync here in order to catch writeback errors. It's not
+	 * strictly required by the protocol, but an nfsd_file could get
+	 * evicted from the cache before a COMMIT comes in. If another
+	 * task were to open that file in the interim and scrape the error,
+	 * then the client may never see it. By calling fsync here, we ensure
+	 * that writeback happens before the entry is freed, and that any
+	 * errors reported result in the write verifier changing.
+	 */
+	nfsd_file_fsync(nf);
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
@@ -402,10 +412,9 @@ nfsd_file_free(struct nfsd_file *nf)
 	 * WARN and leak it to preserve system stability.
 	 */
 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
-		return flush;
+		return;
 
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
-	return flush;
 }
 
 static bool
@@ -421,17 +430,27 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static void nfsd_file_lru_add(struct nfsd_file *nf)
+static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
-		trace_nfsd_file_lru_add(nf);
+	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
+		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
+			trace_nfsd_file_lru_add(nf);
+			return true;
+		}
+	}
+	return false;
 }
 
-static void nfsd_file_lru_remove(struct nfsd_file *nf)
+static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
-		trace_nfsd_file_lru_del(nf);
+	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
+		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
+			trace_nfsd_file_lru_del(nf);
+			return true;
+		}
+	}
+	return false;
 }
 
 struct nfsd_file *
@@ -442,86 +461,89 @@ nfsd_file_get(struct nfsd_file *nf)
 	return NULL;
 }
 
-static void
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
 nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
 {
 	trace_nfsd_file_unhash_and_queue(nf);
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
-{
-	trace_nfsd_file_put(nf);
-
-	if (refcount_dec_and_test(&nf->nf_ref)) {
-		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
-		nfsd_file_lru_remove(nf);
-		nfsd_file_free(nf);
-	}
-}
-
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
+ * reference immediately. In the GC case, if the reference would be
+ * the last one, the put it on the LRU instead to be cleaned up later.
+ */
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
 	might_sleep();
+	trace_nfsd_file_put(nf);
 
-	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
-		nfsd_file_lru_add(nf);
-	else if (refcount_read(&nf->nf_ref) == 2)
-		nfsd_file_unhash_and_put(nf);
-
-	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_fsync(nf);
-		nfsd_file_put_noref(nf);
-	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
-		nfsd_file_put_noref(nf);
-		nfsd_file_schedule_laundrette();
-	} else
-		nfsd_file_put_noref(nf);
-}
-
-static void
-nfsd_file_dispose_list(struct list_head *dispose)
-{
-	struct nfsd_file *nf;
+	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		/*
+		 * If this is the last reference (nf_ref == 1), then try to
+		 * transfer it to the LRU.
+		 */
+		if (refcount_dec_not_one(&nf->nf_ref))
+			return;
+
+		/* Try to add it to the LRU.  If that fails, decrement. */
+		if (nfsd_file_lru_add(nf)) {
+			/* If it's still hashed, we're done */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+				nfsd_file_schedule_laundrette();
+				return;
+			}
 
-	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
-		nfsd_file_fsync(nf);
-		nfsd_file_put_noref(nf);
+			/*
+			 * We're racing with unhashing, so try to remove it from
+			 * the LRU. If removal fails, then someone else already
+			 * has our reference.
+			 */
+			if (!nfsd_file_lru_remove(nf))
+				return;
+		}
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
 
-	while(!list_empty(dispose)) {
+	while (!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_fsync(nf);
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
@@ -591,21 +613,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
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
+	/* We should only be dealing with GC entries here */
+	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
 
 	/*
 	 * Don't throw out files that are still undergoing I/O or
@@ -616,40 +625,36 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 		return LRU_SKIP;
 	}
 
+	/* If it was recently added to the list, skip it */
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
 		trace_nfsd_file_gc_referenced(nf);
 		return LRU_ROTATE;
 	}
 
-	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		trace_nfsd_file_gc_hashed(nf);
+	/* Make sure we're not racing with another removal. */
+	if (!test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
+		trace_nfsd_file_gc_removing(nf);
 		return LRU_SKIP;
 	}
 
+	/*
+	 * Put the reference held on behalf of the LRU. If it wasn't the last
+	 * one, then just remove it from the LRU and ignore it.
+	 */
+	if (!refcount_dec_and_test(&nf->nf_ref)) {
+		trace_nfsd_file_gc_in_use(nf);
+		list_lru_isolate(lru, &nf->nf_lru);
+		return LRU_REMOVED;
+	}
+
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
@@ -659,7 +664,7 @@ nfsd_file_gc(void)
 	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
 			    &dispose, list_lru_count(&nfsd_file_lru));
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -684,7 +689,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -695,8 +700,11 @@ static struct shrinker	nfsd_file_shrinker = {
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
@@ -714,52 +722,69 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
-		nfsd_file_unhash_and_queue(nf, dispose);
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
+ * Unhash and put all cache item associated with @inode. Queue any that have
+ * refcounts that go to zero to the dispose_list_delayed infrastructure for
+ * eventual cleanup.
  */
-void
-nfsd_file_close_inode_sync(struct inode *inode)
+static void
+nfsd_file_close_inode(struct inode *inode)
 {
-	LIST_HEAD(dispose);
+	struct nfsd_file *nf, *tmp;
 	unsigned int count;
+	LIST_HEAD(dispose);
 
 	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode_sync(inode, count);
-	nfsd_file_dispose_list_sync(&dispose);
+	trace_nfsd_file_close_inode(inode, count);
+	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
+		trace_nfsd_file_closing(nf);
+		if (!refcount_dec_and_test(&nf->nf_ref))
+			list_del_init(&nf->nf_lru);
+	}
+	nfsd_file_dispose_list_delayed(&dispose);
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
+	struct nfsd_file *nf;
 	unsigned int count;
+	LIST_HEAD(dispose);
 
 	count = __nfsd_file_close_inode(inode, &dispose);
 	trace_nfsd_file_close_inode(inode, count);
-	nfsd_file_dispose_list_delayed(&dispose);
+	while (!list_empty(&dispose)) {
+		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
+		list_del_init(&nf->nf_lru);
+		trace_nfsd_file_closing(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
+	}
+	flush_delayed_fput();
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
@@ -781,7 +806,7 @@ nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 
 	/* Only close files for F_SETLEASE leases */
 	if (fl->fl_flags & FL_LEASE)
-		nfsd_file_close_inode_sync(file_inode(fl->fl_file));
+		nfsd_file_close_inode(file_inode(fl->fl_file));
 	return 0;
 }
 
@@ -1080,8 +1105,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1116,11 +1143,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1130,7 +1157,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	} else {
-		nfsd_file_put(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
 		nf = NULL;
 	}
 
@@ -1157,7 +1185,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * then unhash.
 	 */
 	if (status != nfs_ok || key.inode->i_nlink == 0)
-		nfsd_file_unhash_and_put(nf);
+		nfsd_file_unhash(nf);
 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b7efb2c3ddb1..e52ab7d5a44c 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -39,6 +39,7 @@ struct nfsd_file {
 #define NFSD_FILE_PENDING	(1)
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
+#define NFSD_FILE_LRU		(4)	/* file is on LRU */
 	unsigned long		nf_flags;
 	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 940252482fd4..736a99448d66 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -870,8 +870,9 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
-		{ 1 << NFSD_FILE_GC,		"GC"})
+		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
+		{ 1 << NFSD_FILE_GC,		"GC" },			\
+		{ 1 << NFSD_FILE_LRU,		"LRU" })
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_PROTO(struct nfsd_file *nf),
@@ -906,6 +907,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
 DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
 
 TRACE_EVENT(nfsd_file_alloc,
@@ -1203,6 +1205,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
+DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_removing);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_hashed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
 
-- 
2.38.1

