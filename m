Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21F646385
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Dec 2022 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLGV6i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 16:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLGV6g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 16:58:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354C7B4DD
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 13:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9C4B8212F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 21:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F0C433D6;
        Wed,  7 Dec 2022 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670450312;
        bh=iV5vceWDjUmfKLqC4pO1uZRiDzn7pZzPDnxCoKc27HA=;
        h=From:To:Cc:Subject:Date:From;
        b=U5KIqWvqtXtJhDUzjSt+jS4TcnyjfkwLjSsc+hWTn5H8s0Xy2cDLnwtlV4QoErDFv
         SvI7pfjEBvbMq1S3fNkeIxC6FxPMiRFEUXbRP05wCzfd9afRO3x6bzMO+/98+ltc0w
         6u37D8o4rh/ZH+bMX9o/KF6D9CBLqVGjUEj9O6vTmMeAvoMKH83PKwnU+LtFwQzEA3
         M0DkwZHR0jfU+0g5K5djPgsijRCJy3tspJKoUzjmsIznnymd9suhd8KfFwAj3kiGC0
         ULLbmh6/XHm+9sURFF6jPCX3EBCvzem24DJbIOW1jvvzi2MEQ/bysWe6gKR5GbYeD2
         KcCyDwqj7US/A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: don't repurpose nf_lru while there are other references outstanding
Date:   Wed,  7 Dec 2022 16:58:30 -0500
Message-Id: <20221207215830.221147-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When testing with a backport of the latest nfsd_file overhaul patches
this week, I hit some list corruption with the nf->nf_lru list_head.
Analysis of the vmcore suggested that a nf_lru had been reinitialized
while it was sitting on the LRU.

It's not safe to use the nf_lru list_head for anything but the LRU
unless you can be sure that no other references can be taken, ensuring
that you have exclusive access to it.

In practical terms, this means that we can't queue objects to a dispose
list until their refcounts have gone to zero. nfsd_unhash_and_queue
currently violates this rule, as it queues nfsd_files to the dispose
list with active references held.

This function is called both during server shutdown and when there is
conflicting access to an inode; two situations that have little to do
with one another. Remove nfsd_file_unhash_and_queue altogether, as its
callers need different things, and just open code what its callers need.

Rename __nfsd_file_close_inode and rework the loop in it to put the
reference(s) earlier and only queue the nf to the dispose list if its
refcount went to zero.

__nfsd_file_cache_purge is called during server shutdown. At that point,
we don't care about the refcount since we know we have exclusive access.
Just unhash the objects, dequeue them from the LRU and then free them.

Finally, update the comments over nfsd_file_close_inode_sync,
nfsd_file_close_inode and __nfsd_file_cache_purge to better describe
their intended purpose.

Fixes: d2cdf429693a ("nfsd: rework refcounting in filecache")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 111 +++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e76b0d3b83a..8bf2fcb0f580 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -461,35 +461,6 @@ nfsd_file_get(struct nfsd_file *nf)
 	return NULL;
 }
 
-/**
- * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose list
- * @nf: nfsd_file to be unhashed and queued
- * @dispose: list to which it should be queued
- *
- * Attempt to unhash a nfsd_file and queue it to the given list. Each file
- * will have a reference held on behalf of the list. That reference may come
- * from the LRU, or we may need to take one. If we can't get a reference,
- * ignore it altogether.
- */
-static bool
-nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
-{
-	trace_nfsd_file_unhash_and_queue(nf);
-	if (nfsd_file_unhash(nf)) {
-		/*
-		 * If we remove it from the LRU, then just use that
-		 * reference for the dispose list. Otherwise, we need
-		 * to take a reference. If that fails, just ignore
-		 * the file altogether.
-		 */
-		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
-			return false;
-		list_add(&nf->nf_lru, dispose);
-		return true;
-	}
-	return false;
-}
-
 /**
  * nfsd_file_put - put the reference to a nfsd_file
  * @nf: nfsd_file of which to put the reference
@@ -700,15 +671,24 @@ static struct shrinker	nfsd_file_shrinker = {
 	.seeks = 1,
 };
 
-/*
- * Find all cache items across all net namespaces that match @inode, unhash
- * them, take references and then put them on @dispose if that was successful.
+/**
+ * nfsd_file_queue_for_close: try to close out any open nfsd_files for an inode
+ * @inode:   inode on which to close out nfsd_files
+ * @dispose: list on which to gather nfsd_files to close out
+ *
+ * An nfsd_file represents a struct file being held open on behalf of nfsd. An
+ * open file however can block other activity (such as leases), or cause
+ * undesirable behavior (e.g. spurious silly-renames when reexporting NFS).
+ *
+ * This function is intended to find open nfsd_files when this sort of
+ * conflicting access occurs and then attempt to close those files out.
  *
- * The nfsd_file objects on the list will be unhashed, and each will have a
- * reference taken.
+ * Populates the dispose list with entries that have already had their
+ * refcounts go to zero. The actual free of an nfsd_file can be expensive,
+ * so we leave it up to the caller whether it wants to wait or not.
  */
 static void
-__nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
+nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
@@ -718,12 +698,30 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 
 	rcu_read_lock();
 	do {
+		int decrement = 1;
+
 		nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
 
-		nfsd_file_unhash_and_queue(nf, dispose);
+		/* If we raced with someone else unhashing, ignore it */
+		if (!nfsd_file_unhash(nf))
+			continue;
+
+		/* If we can't get a reference, ignore it */
+		if (!nfsd_file_get(nf))
+			continue;
+
+		/* Extra decrement if we remove from the LRU */
+		if (nfsd_file_lru_remove(nf))
+			++decrement;
+
+		/* If refcount goes to 0, then put on the dispose list */
+		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
+			list_add(&nf->nf_lru, dispose);
+			trace_nfsd_file_closing(nf);
+		}
 	} while (1);
 	rcu_read_unlock();
 }
@@ -732,22 +730,17 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
  * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put all cache item associated with @inode. Queue any that have
- * refcounts that go to zero to the dispose_list_delayed infrastructure for
- * eventual cleanup.
+ * Close out any open nfsd_files that can be reaped for @inode. The
+ * actual freeing is deferred to the dispose_list_delayed infrastructure.
+ *
+ * This is used by the fsnotify callbacks and setlease notifier.
  */
 static void
 nfsd_file_close_inode(struct inode *inode)
 {
-	struct nfsd_file *nf, *tmp;
 	LIST_HEAD(dispose);
 
-	__nfsd_file_close_inode(inode, &dispose);
-	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
-		trace_nfsd_file_closing(nf);
-		if (!refcount_dec_and_test(&nf->nf_ref))
-			list_del_init(&nf->nf_lru);
-	}
+	nfsd_file_queue_for_close(inode, &dispose);
 	nfsd_file_dispose_list_delayed(&dispose);
 }
 
@@ -755,7 +748,11 @@ nfsd_file_close_inode(struct inode *inode)
  * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put, then flush and fput all cache items associated with @inode.
+ * Close out any open nfsd_files that can be reaped for @inode. The
+ * nfsd_files are closed out synchronously.
+ *
+ * This is called from nfsd_rename and nfsd_unlink to avoid silly-renames
+ * when reexporting NFS.
  */
 void
 nfsd_file_close_inode_sync(struct inode *inode)
@@ -765,13 +762,11 @@ nfsd_file_close_inode_sync(struct inode *inode)
 
 	trace_nfsd_file_close(inode);
 
-	__nfsd_file_close_inode(inode, &dispose);
+	nfsd_file_queue_for_close(inode, &dispose);
 	while (!list_empty(&dispose)) {
 		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		trace_nfsd_file_closing(nf);
-		if (refcount_dec_and_test(&nf->nf_ref))
-			nfsd_file_free(nf);
+		nfsd_file_free(nf);
 	}
 	flush_delayed_fput();
 }
@@ -923,6 +918,13 @@ nfsd_file_cache_init(void)
 	goto out;
 }
 
+/**
+ * __nfsd_file_cache_purge: clean out the cache for shutdown
+ * @net: net-namespace to shut down the cache (may be NULL)
+ *
+ * Walk the nfsd_file cache and close out any that match @net. If @net is NULL,
+ * then close out everything. Called when an nfsd instance is being shut down.
+ */
 static void
 __nfsd_file_cache_purge(struct net *net)
 {
@@ -936,8 +938,11 @@ __nfsd_file_cache_purge(struct net *net)
 
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
-			if (!net || nf->nf_net == net)
-				nfsd_file_unhash_and_queue(nf, &dispose);
+			if (!net || nf->nf_net == net) {
+				nfsd_file_unhash(nf);
+				nfsd_file_lru_remove(nf);
+				list_add(&nf->nf_lru, &dispose);
+			}
 			nf = rhashtable_walk_next(&iter);
 		}
 
-- 
2.38.1

