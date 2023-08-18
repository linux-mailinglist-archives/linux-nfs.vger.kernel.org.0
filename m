Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93678780376
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357057AbjHRBpk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 21:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357116AbjHRBpe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 21:45:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D32713
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 18:45:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56A841F86B;
        Fri, 18 Aug 2023 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692323131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNhu+WGr8GNK7ZSXb46cTp7mCWElfnfXhjOejt78SNM=;
        b=H+66bKta5EeGHmWMhDRyEP/Ke6ds0AWllg3b1gcx6K8Qx4h3tLLTEHQZ6HlmUS3oL0uWzw
        aFbiMeq/aKP30C//gBPeagQWBw0wY2KAha14FxWhhYRsUIvdgOa/KNNE2Dmz0t8Ogr7aEM
        6P4kr+y4vaXP911jSN/AbPDu+B5r8zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692323131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNhu+WGr8GNK7ZSXb46cTp7mCWElfnfXhjOejt78SNM=;
        b=RoJr0wAfmz/L7qitNHwj74/DAPCT/8pi8X0hREpSM57tDVG0VvyvpYg6pxk700MXyQiuLf
        IHgtUJqTTcLtRkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18E1F1353E;
        Fri, 18 Aug 2023 01:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 88RSLznN3mRvZAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Aug 2023 01:45:29 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] SUNRPC: change service idle list to be an llist
Date:   Fri, 18 Aug 2023 11:45:06 +1000
Message-Id: <20230818014512.26880-2-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818014512.26880-1-neilb@suse.de>
References: <20230818014512.26880-1-neilb@suse.de>
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

task_state_index() incorrectly identifies a task with
   TASK_IDLE | TASK_FREEZABLE
as 'D'.  So fix __task_state_index to ignore extra flags on TASK_IDLE
just as it ignores extra flags on other states.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sched.h      |  4 +--
 include/linux/sunrpc/svc.h | 14 ++++++-----
 net/sunrpc/svc.c           | 13 +++++-----
 net/sunrpc/svc_xprt.c      | 51 +++++++++++++++++++-------------------
 4 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..a5f3badcb629 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1666,7 +1666,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
 
-	if (tsk_state == TASK_IDLE)
+	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
 	/*
@@ -1674,7 +1674,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
 	 */
-	if (tsk_state == TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT)
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 22b3018ebf62..5216f95411e3 100644
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
 
@@ -270,22 +270,24 @@ enum {
  * svc_thread_set_busy - mark a thread as busy
  * @rqstp: the thread which is now busy
  *
- * If rq_idle is "empty", the thread must be busy.
+ * By convention a thread is busy if rq_idle.next points to rq_idle.
+ * This ensures it is not on the idle list.
  */
 static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
 {
-	INIT_LIST_HEAD(&rqstp->rq_idle);
+	rqstp->rq_idle.next = &rqstp->rq_idle;
 }
 
 /**
  * svc_thread_busy - check if a thread as busy
  * @rqstp: the thread which might be busy
  *
- * If rq_idle is "empty", the thread must be busy.
+ * By convention a thread is busy if rq_idle.next points to rq_idle.
+ * This ensures it is not on the idle list.
  */
 static inline bool svc_thread_busy(struct svc_rqst *rqstp)
 {
-	return list_empty(&rqstp->rq_idle);
+	return rqstp->rq_idle.next == &rqstp->rq_idle;
 }
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 051f08c48418..addbf28ea50a 100644
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
@@ -701,15 +701,16 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
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
+	ln = llist_del_first(&pool->sp_idle_threads);
 	spin_unlock_bh(&pool->sp_lock);
-	if (rqstp) {
+	if (ln) {
+		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
+		svc_thread_set_busy(rqstp);
+
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		wake_up_process(rqstp->rq_task);
 		rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index fa0d854a5596..81327001e074 100644
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
@@ -734,30 +730,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
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
+			/* maybe there were no idle threads when some work
+			 * became ready and so nothing was woken.  We've just
+			 * become idle so someone can to the work - maybe us.
+			 * But we cannot reliably remove ourselves from the
+			 * idle list - we can only remove the first task which
+			 * might be us, and might not.
+			 * So remove and wake it, then schedule().  If it was
+			 * us, we won't sleep.  If it is some other thread, they
+			 * will do the work.
+			 */
+			svc_pool_wake_idle_thread(pool);
 
-		/* Need to check should_sleep() again after
-		 * setting task state in case a wakeup happened
-		 * between testing and setting.
+		/* We mustn't continue while on the idle list, and we
+		 * cannot remove outselves reliably.  The only "work"
+		 * we can do while on the idle list is to freeze.
+		 * So loop until someone removes us
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
@@ -870,9 +868,10 @@ void svc_recv(struct svc_rqst *rqstp)
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
-- 
2.40.1

