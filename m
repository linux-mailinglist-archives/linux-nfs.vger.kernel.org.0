Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7678D245
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbjH3C6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbjH3C6q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C89185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB08F1F45F;
        Wed, 30 Aug 2023 02:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9BZBFi3a/8MiWUA1dYlaushegUfXjp4xF87chH87zE=;
        b=doD1el3brmioiH6s0S+vsos0Iu+I7RyLPuzMTY46t5qwvSUTXu9eGhFthpKjX8Yw9F2ZUc
        bS4yvq4FZzXniBsXm68xEON+JJz+klqZSujLDpNy+6+o6rMwkF/j0UnyfvKHVJBWauWWfR
        ScVo6cNpKcKUS6TCoqWTD+pzhoISEI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364322;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9BZBFi3a/8MiWUA1dYlaushegUfXjp4xF87chH87zE=;
        b=nhKz3BAjoEDCoxw+oU0RI95m7kXbDOxsswyR35+f8kHQ/aEq7O4j1RuQFcy1ZwpEbllFfH
        D5ssVE+vrpUfmgCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9DF013301;
        Wed, 30 Aug 2023 02:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZDQOF2Gw7mQHZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:41 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/10] SUNRPC: only have one thread waking up at a time
Date:   Wed, 30 Aug 2023 12:54:49 +1000
Message-ID: <20230830025755.21292-7-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
cares if it is busy.  So svc_thread_busy() is no longer needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 11 -----------
 net/sunrpc/svc.c           | 14 ++++++--------
 net/sunrpc/svc_xprt.c      | 35 ++++++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 32 deletions(-)

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
index 5673f30db295..3267d740235e 100644
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
index 17c43bde35c9..a51570a4cbf2 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -732,20 +732,16 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		if (likely(rqst_should_sleep(rqstp)))
+			schedule();
 
-		if (unlikely(!rqst_should_sleep(rqstp)))
-			/* Work just became available.  This thread cannot simply
-			 * choose not to sleep as it *must* wait until removed.
-			 * So wake the first waiter - whether it is this
-			 * thread or some other, it will get the work done.
+		while (!llist_del_first_this(&pool->sp_idle_threads,
+					     &rqstp->rq_idle)) {
+			/* Cannot @rqstp from idle list, so some other thread
+			 * must have queued itself after finding
+			 * no work to do, so they have taken responsibility
+			 * for any outstanding work.
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
@@ -835,6 +831,15 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
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
@@ -854,13 +859,16 @@ void svc_recv(struct svc_rqst *rqstp)
 
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
@@ -885,6 +893,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		if (req) {
 			list_del(&req->rq_bc_list);
 			spin_unlock_bh(&serv->sv_cb_lock);
+			wake_next(rqstp);
 
 			svc_process_bc(req, rqstp);
 			return;
-- 
2.41.0

