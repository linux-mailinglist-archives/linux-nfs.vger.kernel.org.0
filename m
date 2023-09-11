Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB879BE68
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbjIKWAG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbjIKOjg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029DF2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE0C433C8;
        Mon, 11 Sep 2023 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443171;
        bh=5kjDFhbjhzqvwd9YDft0J01WrY1BorbEvP3KP8uZe1A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fzpEX3IykoQeRLxt+UfJdbE4YhrPkFYs6px2GSMc2Ky8MiOMYW0wFZD8wXbihwpds
         JwcyYp2eQfnYP9DI9lNjLkB3qtpMjFYpnG4eRldy1weKjJt1PooCrLRI5cgaz+fsJw
         6sdF/ys5FEt+Z8cHb69wuvuhLgtE+Ubw0Bp2GDIjyDHvuiEjcSnzzfumIOYAVjqJIb
         iIfy9qCnnAnJI+7WzyDGdX+ugLlOcvr7E2RuMyNRP2nl2Hh4vKoq/w/yY3CVNydj9L
         2hzzZTjlubkm4Ouy6fy7Frfjs6iRqIeO+EN1W/BA50HiJBXZD+W3uhmAZF8BRZkW6b
         rHj+Ds4IkX0KQ==
Subject: [PATCH v1 09/17] SUNRPC: change service idle list to be an llist
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:30 -0400
Message-ID: <169444317053.4327.12359904937982412236.stgit@bazille.1015granger.net>
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

With an llist we don't need to take a lock to add a thread to the list,
though we still need a lock to remove it.  That will go in the next
patch.

Unlike double-linked lists, a thread cannot reliably remove itself from
the list.  Only the first thread can be removed, and that can change
asynchronously.  So some care is needed.

We already check if there is pending work to do, so we are unlikely to
add ourselves to the idle list and then want to remove ourselves again.

If we DO find something needs to be done after adding ourselves to the
list, we simply wake up the first thread on the list.  If that was us,
we successfully removed ourselves and can continue.  If it was some
other thread, they will do the work that needs to be done.  We can
safely sleep until woken.

We also remove the test on freezing() from rqst_should_sleep().  Instead
we set TASK_FREEZABLE before scheduling.  This makes is safe to
schedule() when a freeze is pending.  As we now loop waiting to be
removed from the idle queue, this is a cleaner way to handle freezing.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   21 +++++----------------
 net/sunrpc/svc.c           |   14 +++++++-------
 net/sunrpc/svc_xprt.c      |   45 +++++++++++++++++++-------------------------
 3 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 22b3018ebf62..ad4572630335 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -37,7 +37,7 @@ struct svc_pool {
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
-	struct list_head	sp_idle_threads; /* idle server threads */
+	struct llist_head	sp_idle_threads; /* idle server threads */
 
 	/* statistics on pool operation */
 	struct percpu_counter	sp_messages_arrived;
@@ -186,7 +186,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  */
 struct svc_rqst {
 	struct list_head	rq_all;		/* all threads list */
-	struct list_head	rq_idle;	/* On the idle list */
+	struct llist_node	rq_idle;	/* On the idle list */
 	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
 	struct svc_xprt *	rq_xprt;	/* transport ptr */
 
@@ -266,26 +266,15 @@ enum {
 	RQ_DATA,		/* request has data */
 };
 
-/**
- * svc_thread_set_busy - mark a thread as busy
- * @rqstp: the thread which is now busy
- *
- * If rq_idle is "empty", the thread must be busy.
- */
-static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
-{
-	INIT_LIST_HEAD(&rqstp->rq_idle);
-}
-
 /**
  * svc_thread_busy - check if a thread as busy
  * @rqstp: the thread which might be busy
  *
- * If rq_idle is "empty", the thread must be busy.
+ * A thread is only busy when it is not an the idle list.
  */
-static inline bool svc_thread_busy(struct svc_rqst *rqstp)
+static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
 {
-	return list_empty(&rqstp->rq_idle);
+	return !llist_on_list(&rqstp->rq_idle);
 }
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index db4674211f36..54ae6a569f6a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -510,7 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		pool->sp_id = i;
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
-		INIT_LIST_HEAD(&pool->sp_idle_threads);
+		init_llist_head(&pool->sp_idle_threads);
 		spin_lock_init(&pool->sp_lock);
 
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
@@ -642,7 +642,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	svc_thread_set_busy(rqstp);
+	init_llist_node(&rqstp->rq_idle);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -701,15 +701,15 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 void svc_pool_wake_idle_thread(struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
+	struct llist_node *ln;
 
 	rcu_read_lock();
 	spin_lock_bh(&pool->sp_lock);
-	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
-					 struct svc_rqst, rq_idle);
-	if (rqstp)
-		list_del_init(&rqstp->rq_idle);
+	ln = llist_del_first_init(&pool->sp_idle_threads);
 	spin_unlock_bh(&pool->sp_lock);
-	if (rqstp) {
+	if (ln) {
+		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
+
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		wake_up_process(rqstp->rq_task);
 		rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index fa0d854a5596..17c43bde35c9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -715,10 +715,6 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	if (svc_thread_should_stop(rqstp))
 		return false;
 
-	/* are we freezing? */
-	if (freezing(current))
-		return false;
-
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	if (svc_is_backchannel(rqstp)) {
 		if (!list_empty(&rqstp->rq_server->sv_cb_list))
@@ -734,30 +730,26 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 	struct svc_pool *pool = rqstp->rq_pool;
 
 	if (rqst_should_sleep(rqstp)) {
-		set_current_state(TASK_IDLE);
-		spin_lock_bh(&pool->sp_lock);
-		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
-		spin_unlock_bh(&pool->sp_lock);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
+		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+
+		if (unlikely(!rqst_should_sleep(rqstp)))
+			/* Work just became available.  This thread cannot simply
+			 * choose not to sleep as it *must* wait until removed.
+			 * So wake the first waiter - whether it is this
+			 * thread or some other, it will get the work done.
+			 */
+			svc_pool_wake_idle_thread(pool);
 
-		/* Need to check should_sleep() again after
-		 * setting task state in case a wakeup happened
-		 * between testing and setting.
+		/* Since a thread cannot remove itself from an llist,
+		 * schedule until someone else removes @rqstp from
+		 * the idle list.
 		 */
-		if (rqst_should_sleep(rqstp)) {
+		while (!svc_thread_busy(rqstp)) {
 			schedule();
-		} else {
-			__set_current_state(TASK_RUNNING);
-			cond_resched();
-		}
-
-		/* We *must* be removed from the list before we can continue.
-		 * If we were woken, this is already done
-		 */
-		if (!svc_thread_busy(rqstp)) {
-			spin_lock_bh(&pool->sp_lock);
-			list_del_init(&rqstp->rq_idle);
-			spin_unlock_bh(&pool->sp_lock);
+			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
+		__set_current_state(TASK_RUNNING);
 	} else {
 		cond_resched();
 	}
@@ -870,9 +862,10 @@ void svc_recv(struct svc_rqst *rqstp)
 		struct svc_xprt *xprt = rqstp->rq_xprt;
 
 		/* Normally we will wait up to 5 seconds for any required
-		 * cache information to be provided.
+		 * cache information to be provided.  When there are no
+		 * idle threads, we reduce the wait time.
 		 */
-		if (!list_empty(&pool->sp_idle_threads))
+		if (pool->sp_idle_threads.first)
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
 		else
 			rqstp->rq_chandle.thread_wait = 1 * HZ;


