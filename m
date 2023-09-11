Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B179B20C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbjIKV7e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbjIKOkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:40:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2CF2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DFC433C7;
        Mon, 11 Sep 2023 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443197;
        bh=Z7MmMYgNbejaJMs2nVbnLwMNYWKE8dTTw2qV3lkYHEA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cZ3Vya8TwoBbErn72NwwN2ktlTpn2Y61ZyEXBOScB20HqpnVcKDV0zImKJeMgSx4T
         a0YSuY2RAMKKPAnWFIyIuZv1YDR9cjtrc2Mrskyr3XTJP8YCvB16wbn1/6R1+sc517
         vMiyHUsBtYjKRByxoilHwRdqe+6s/Pzp657pNOxQGZ/TmPCQwGcEpjkMuzkF43Dm2k
         VM/IzU9Xv8nQ17qtI3gLxCC6kP60P59u455MeeqhcpSByXPcLd4Xq4Sei0Gm8GKGWp
         0rpoakyNnciXUEYD9olE56v87Agk763ZFpOQ+uqgmecNI3xQHuSkrTOtyQQhYM531n
         9lI9uottiBXVQ==
Subject: [PATCH v1 13/17] SUNRPC: only have one thread waking up at a time
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:56 -0400
Message-ID: <169444319659.4327.14189708269231562829.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

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
cares if it is busy.  So svc_thread_busy() is no longer needed.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   11 -----------
 net/sunrpc/svc.c           |   14 ++++++--------
 net/sunrpc/svc_xprt.c      |   38 +++++++++++++++++++++++++-------------
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ad4572630335..dafa362b4fdd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -266,17 +266,6 @@ enum {
 	RQ_DATA,		/* request has data */
 };
 
-/**
- * svc_thread_busy - check if a thread as busy
- * @rqstp: the thread which might be busy
- *
- * A thread is only busy when it is not an the idle list.
- */
-static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
-{
-	return !llist_on_list(&rqstp->rq_idle);
-}
-
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 54ae6a569f6a..326592162af1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -642,7 +642,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	init_llist_node(&rqstp->rq_idle);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -704,17 +703,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	struct llist_node *ln;
 
 	rcu_read_lock();
-	spin_lock_bh(&pool->sp_lock);
-	ln = llist_del_first_init(&pool->sp_idle_threads);
-	spin_unlock_bh(&pool->sp_lock);
+	ln = READ_ONCE(pool->sp_idle_threads.first);
 	if (ln) {
 		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
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
index 1b300a7889eb..75f66714e3a7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -732,20 +732,19 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		if (likely(svc_thread_should_sleep(rqstp)))
+			schedule();
 
-		if (unlikely(!svc_thread_should_sleep(rqstp)))
-			/* Work just became available.  This thread cannot simply
-			 * choose not to sleep as it *must* wait until removed.
-			 * So wake the first waiter - whether it is this
-			 * thread or some other, it will get the work done.
+		while (!llist_del_first_this(&pool->sp_idle_threads,
+					     &rqstp->rq_idle)) {
+			/* Work just became available.  This thread can only
+			 * handle it after removing rqstp from the idle
+			 * list. If that attempt failed, some other thread
+			 * must have queued itself after finding no
+			 * work to do, so that thread has taken responsibly
+			 * for this new work.  This thread can safely sleep
+			 * until woken again.
 			 */
-			svc_pool_wake_idle_thread(pool);
-
-		/* Since a thread cannot remove itself from an llist,
-		 * schedule until someone else removes @rqstp from
-		 * the idle list.
-		 */
-		while (!svc_thread_busy(rqstp)) {
 			schedule();
 			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
@@ -835,6 +834,15 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 	svc_xprt_release(rqstp);
 }
 
+static void svc_thread_wake_next(struct svc_rqst *rqstp)
+{
+	if (!svc_thread_should_sleep(rqstp))
+		/* More work pending after I dequeued some,
+		 * wake another worker
+		 */
+		svc_pool_wake_idle_thread(rqstp->rq_pool);
+}
+
 /**
  * svc_recv - Receive and process the next request on any transport
  * @rqstp: an idle RPC service thread
@@ -854,13 +862,16 @@ void svc_recv(struct svc_rqst *rqstp)
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
-	if (svc_thread_should_stop(rqstp))
+	if (svc_thread_should_stop(rqstp)) {
+		svc_thread_wake_next(rqstp);
 		return;
+	}
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
 		struct svc_xprt *xprt = rqstp->rq_xprt;
 
+		svc_thread_wake_next(rqstp);
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.  When there are no
 		 * idle threads, we reduce the wait time.
@@ -885,6 +896,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		if (req) {
 			list_del(&req->rq_bc_list);
 			spin_unlock_bh(&serv->sv_cb_lock);
+			svc_thread_wake_next(rqstp);
 
 			svc_process_bc(req, rqstp);
 			return;


