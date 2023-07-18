Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1809375747B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGRGkK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGRGkJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:40:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223FB18B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:40:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D0731FDBC;
        Tue, 18 Jul 2023 06:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1/4gT7LMd1Y2NHFUexFp26CiG8lpSWxUIeJR9tPvB4=;
        b=Jt/19zwB1l16thGbuVGbPYLmda/YrwoiZ5+deiaxvQwt/F6jZIJ5j8cpsLuLGXVdfkY7px
        5ocn4F75aau0mywYK0JGx75Wthejjkfen7kz9ePijwVw1yxILaD2SBv9zz2UC0iPnSQUsh
        rY3BfZriYZiYi8xHRKRyvRzWL2IBQVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1/4gT7LMd1Y2NHFUexFp26CiG8lpSWxUIeJR9tPvB4=;
        b=TZizD6vdNq9S38Nsk6OeA8mwSrymgJ3RWjvsg01WZ4dDpuuFybY8n3OO1Vs/nWp8UP+Fso
        ArOvZA2J5CPZRZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F14813494;
        Tue, 18 Jul 2023 06:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e0XNNMIztmTTDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:40:02 +0000
Subject: [PATCH 13/14] SUNRPC: change service idle list to be an llist
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228868.11075.13775072041089806843.stgit@noble.brown>
In-Reply-To: <168966227838.11075.2974227708495338626.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With an llist we don't need to take a lock to add a thread to the list,
though we still need a lock to remove it.  That will go in the next
patch.

Unlike double-linked lists, a thread cannot remove itself from the list.
Only the first thread can be removed, and that can change
asynchronously. So some care is needed.

Firstly, we don't add ourselves to the list of there is more work to do
- we just go ahead and do it.  So we remain in the busy state.  That
already applied to xprts being ready, it now applies to all possible
triggers.  We DON'T keep the likely annotation on this test for "more
work to do".  It isn't particularly likely that there is no work to do,
and there is definitely no need to optimise for that case.

Secondly if we do find something needs to be done after adding ourselves
to the list, we simply wake up the first thread on the list.  If that
was us, we have been removed and can continue.  If it was some other
thread, they will do the work that needs to be done.  We can safely
sleep until woken.

With this a thread could call rqst_should_sleep() without actually
proceeding to do work if told not to sleep.  So that function mustn't
clear SP_TASK_PENDING.  The flag must stay set until some thread commits
to not sleeping.

We also remove the test on freezing() from rqst_should_sleep().  Instead
we always try_to_freeze() before scheduling, which is needed as we now
schedule() in a loop waiting to be removed from the idle queue.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |   14 +++++++-----
 net/sunrpc/svc.c           |   11 +++++----
 net/sunrpc/svc_xprt.c      |   51 ++++++++++++++++++++++++++------------------
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f5b69e6da0f8..5941b8a8e754 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,7 +36,7 @@ struct svc_pool {
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
-	struct list_head	sp_idle_threads; /* idle server threads */
+	struct llist_head	sp_idle_threads; /* idle server threads */
 
 	/* statistics on pool operation */
 	struct percpu_counter	sp_messages_arrived;
@@ -199,7 +199,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  */
 struct svc_rqst {
 	struct list_head	rq_all;		/* all threads list */
-	struct list_head	rq_idle;	/* On the idle list */
+	struct llist_node	rq_idle;	/* On the idle list */
 	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
 	struct svc_xprt *	rq_xprt;	/* transport ptr */
 
@@ -286,22 +286,24 @@ enum {
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
+	smp_store_release(&rqstp->rq_idle.next, &rqstp->rq_idle);
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
+	return smp_load_acquire(&rqstp->rq_idle.next) == &rqstp->rq_idle;
 }
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f6da390932cd..9287a08250b2 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -702,15 +702,16 @@ void svc_pool_wake_idle_thread(struct svc_serv *serv,
 			       struct svc_pool *pool)
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
index b82a66f68f17..eb8d345641b2 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	struct svc_pool		*pool = rqstp->rq_pool;
 
 	/* did someone call svc_wake_up? */
-	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
+	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
 		return false;
 
 	/* was a socket queued? */
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
@@ -733,27 +729,40 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
 
-	set_current_state(TASK_IDLE);
-	spin_lock_bh(&pool->sp_lock);
-	list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
-	spin_unlock_bh(&pool->sp_lock);
+	if (rqst_should_sleep(rqstp)) {
+		set_current_state(TASK_IDLE);
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
+			svc_pool_wake_idle_thread(rqstp->rq_server, pool);
 
-	if (likely(rqst_should_sleep(rqstp)))
-		schedule();
-	else
+		/* We mustn't continue while on the idle list, and we
+		 * cannot remove outselves reliably.  The only "work"
+		 * we can do while on the idle list is to freeze.
+		 * So loop until someone removes us
+		 */
+		while (!svc_thread_busy(rqstp)) {
+			try_to_freeze();
+			schedule();
+			set_current_state(TASK_IDLE);
+		}
 		__set_current_state(TASK_RUNNING);
-
-	/* We *must* be removed from the list before we can continue.
-	 * If we were woken, this is already done
-	 */
-	if (!svc_thread_busy(rqstp)) {
-		spin_lock_bh(&pool->sp_lock);
-		list_del_init(&rqstp->rq_idle);
-		spin_unlock_bh(&pool->sp_lock);
 	}
 
 	try_to_freeze();
 
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
+
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
 		trace_svc_pool_awoken(rqstp);
@@ -785,7 +794,7 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
 	 */
-	if (!list_empty(&pool->sp_idle_threads))
+	if (pool->sp_idle_threads.first != NULL)
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;


