Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB577C580
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHOBzm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjHOBzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:55:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B90C3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:55:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5F2A2190B;
        Tue, 15 Aug 2023 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCG8afn88a6PqcmPKn6Ql52AAg6Gczjg4vfrCCYs1MU=;
        b=OeLH2d6W5aKDWFMSiZUg7P8U1e238eykB3FbmmA6YK1f+I1+LFdejcHG1qTU7t4W1IY7RA
        AT2exUlwiP8P5bQIjfmUorYZ0UweZPe/G4KygT8MUkHFtSba8pwcUew31iaK9jZeSNfZrL
        t+YHT8RloqHCnTjnYHmlbqURgBhDF5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCG8afn88a6PqcmPKn6Ql52AAg6Gczjg4vfrCCYs1MU=;
        b=Fo6fJJQePnW3RTBtWqoS3bz9WYo9TyZILluLiE7z5uhaDZvGi6DwEaDt4QtJx1drdkHBOB
        9Ig3lCExS06bs0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32EA21353E;
        Tue, 15 Aug 2023 01:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FTP5Nfna2mTOCgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:55:05 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/10] SUNRPC: only have one thread waking up at a time
Date:   Tue, 15 Aug 2023 11:54:21 +1000
Message-Id: <20230815015426.5091-6-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815015426.5091-1-neilb@suse.de>
References: <20230815015426.5091-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently if several items of work become available in quick succession,
that number of threads (if available) will be woken.  By the time some
of them wake up another thread that was already cache-warm might have
come along and completed the work.  Anecdotal evidence suggests as many
as 15% of wakes find nothing to do once they get to the point of
looking.

This patch changes svc_pool_wake_idle_thread() to wake the first thread
on the queue but NOT remove it.  Subsequent calls will wake the same
thread.  Once that thread starts it will dequeue itself and after
dequeueing some work to do, it will wake the next thread if there is more
work ready.  This results in a more orderly increase in the number of
busy threads.

As a bonus, this allows us to reduce locking around the idle queue.
svc_pool_wake_idle_thread() no longer needs to take a lock (beyond
rcu_read_lock()) as it doesn't manipulate the queue, it just looks at
the first item.

The thread itself can avoid locking by using the new
llist_del_first_this() interface.  This will safely remove the thread
itself if it is the head.  If it isn't the head, it will do nothing.
If multiple threads call this concurrently only one will succeed.  The
others will do nothing, so no corruption can result.

If a thread wakes up and finds that it cannot dequeue itself that means
either
- that it wasn't woken because it was the head of the queue.  Maybe the
  freezer woke it.  In that case it can go back to sleep (after trying
  to freeze of course).
- some other thread found there was nothing to do very recently, and
  placed itself on the head of the queue in front of this thread.
  It must check again after placing itself there, so it can be deemed to
  be responsible for any pending work, and this thread can go back to
  sleep until woken.

No code ever tests for busy threads any more.  Only each thread itself
cares if it is busy.  So functions to set and test the busy status are
no longer needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/llist.h      |  2 ++
 include/linux/sunrpc/svc.h | 24 -------------------
 lib/llist.c                | 27 +++++++++++++++++++++
 net/sunrpc/svc.c           | 15 +++++-------
 net/sunrpc/svc_xprt.c      | 48 +++++++++++++++++++++++---------------
 5 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..d8b1b73f3df0 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -248,6 +248,8 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
 }
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
+extern struct llist_node *llist_del_first_this(struct llist_head *head,
+					       struct llist_node *this);
 
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5216f95411e3..dafa362b4fdd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -266,30 +266,6 @@ enum {
 	RQ_DATA,		/* request has data */
 };
 
-/**
- * svc_thread_set_busy - mark a thread as busy
- * @rqstp: the thread which is now busy
- *
- * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This ensures it is not on the idle list.
- */
-static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
-{
-	rqstp->rq_idle.next = &rqstp->rq_idle;
-}
-
-/**
- * svc_thread_busy - check if a thread as busy
- * @rqstp: the thread which might be busy
- *
- * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This ensures it is not on the idle list.
- */
-static inline bool svc_thread_busy(struct svc_rqst *rqstp)
-{
-	return rqstp->rq_idle.next == &rqstp->rq_idle;
-}
-
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
diff --git a/lib/llist.c b/lib/llist.c
index 6e668fa5a2c6..7e8a13a13586 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -65,6 +65,33 @@ struct llist_node *llist_del_first(struct llist_head *head)
 }
 EXPORT_SYMBOL_GPL(llist_del_first);
 
+/**
+ * llist_del_first_this - delete given entry of lock-less list if it is first
+ * @head:	the head for your lock-less list
+ * @this:	a list entry.
+ *
+ * If head of the list is given entry, delete and return it, else
+ * return %NULL.
+ *
+ * Providing the caller has exclusive access to @this, multiple callers can
+ * safely call this concurrently with multiple llist_add() callers.
+ */
+struct llist_node *llist_del_first_this(struct llist_head *head,
+					struct llist_node *this)
+{
+	struct llist_node *entry, *next;
+
+	entry = smp_load_acquire(&head->first);
+	do {
+		if (entry != this)
+			return NULL;
+		next = READ_ONCE(entry->next);
+	} while (!try_cmpxchg(&head->first, &entry, next));
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(llist_del_first_this);
+
 /**
  * llist_reverse_order - reverse order of a llist chain
  * @head:	first item of the list to be reversed
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index addbf28ea50a..3267d740235e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -642,7 +642,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	svc_thread_set_busy(rqstp);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -704,18 +703,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	struct llist_node *ln;
 
 	rcu_read_lock();
-	spin_lock_bh(&pool->sp_lock);
-	ln = llist_del_first(&pool->sp_idle_threads);
-	spin_unlock_bh(&pool->sp_lock);
+	ln = READ_ONCE(pool->sp_idle_threads.first);
 	if (ln) {
 		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
-		svc_thread_set_busy(rqstp);
-
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
-		wake_up_process(rqstp->rq_task);
+		if (!task_is_running(rqstp->rq_task)) {
+			wake_up_process(rqstp->rq_task);
+			trace_svc_wake_up(rqstp->rq_task->pid);
+			percpu_counter_inc(&pool->sp_threads_woken);
+		}
 		rcu_read_unlock();
-		percpu_counter_inc(&pool->sp_threads_woken);
-		trace_svc_wake_up(rqstp->rq_task->pid);
 		return;
 	}
 	rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 7cb71effda0b..b0c5677f7f81 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -732,26 +732,23 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		/* Maybe there were no idle threads when some work
+		 * became ready and so nothing was woken.  We've just
+		 * become idle so someone can do the work - maybe us.
+		 * So check again for work to do.
+		 */
+		if (likely(rqst_should_sleep(rqstp))) {
+			try_to_freeze();
+			schedule();
+		}
 
-		if (unlikely(!rqst_should_sleep(rqstp)))
-			/* maybe there were no idle threads when some work
-			 * became ready and so nothing was woken.  We've just
-			 * become idle so someone can to the work - maybe us.
-			 * But we cannot reliably remove ourselves from the
-			 * idle list - we can only remove the first task which
-			 * might be us, and might not.
-			 * So remove and wake it, then schedule().  If it was
-			 * us, we won't sleep.  If it is some other thread, they
-			 * will do the work.
+		while (llist_del_first_this(&pool->sp_idle_threads,
+					    &rqstp->rq_idle) == NULL) {
+			/* Cannot remove myself, so some other thread
+			 * must have queued themselves after finding
+			 * no work to do, so they have taken responsibility
+			 * for any outstanding work.
 			 */
-			svc_pool_wake_idle_thread(pool);
-
-		/* We mustn't continue while on the idle list, and we
-		 * cannot remove outselves reliably.  The only "work"
-		 * we can do while on the idle list is to freeze.
-		 * So loop until someone removes us
-		 */
-		while (!svc_thread_busy(rqstp)) {
 			try_to_freeze();
 			schedule();
 			set_current_state(TASK_IDLE);
@@ -842,6 +839,15 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 	svc_xprt_release(rqstp);
 }
 
+static void wake_next(struct svc_rqst *rqstp)
+{
+	if (!rqst_should_sleep(rqstp))
+		/* More work pending after I dequeued some,
+		 * wake another worker
+		 */
+		svc_pool_wake_idle_thread(rqstp->rq_pool);
+}
+
 /**
  * svc_recv - Receive and process the next request on any transport
  * @rqstp: an idle RPC service thread
@@ -861,13 +867,16 @@ void svc_recv(struct svc_rqst *rqstp)
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
-	if (svc_thread_should_stop(rqstp))
+	if (svc_thread_should_stop(rqstp)) {
+		wake_next(rqstp);
 		return;
+	}
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
 		struct svc_xprt *xprt = rqstp->rq_xprt;
 
+		wake_next(rqstp);
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.  When there are no
 		 * idle threads, we reduce the wait time.
@@ -892,6 +901,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		if (req) {
 			list_del(&req->rq_bc_list);
 			spin_unlock_bh(&serv->sv_cb_lock);
+			wake_next(rqstp);
 
 			svc_process_bc(req, rqstp);
 			return;
-- 
2.40.1

