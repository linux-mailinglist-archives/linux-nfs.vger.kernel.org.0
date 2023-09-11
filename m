Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5C79B678
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355454AbjIKV7l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjIKOjR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2194CF0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFF6C433C8;
        Mon, 11 Sep 2023 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443152;
        bh=tUrYlYpwHMmRYuThBMq9hwTd0RzPf0BWZ7rU/Fj95/g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H2vSyNQFgAP7BP4NvqUZghALWdr97Blf9wkKopIKSG2bOiQQWfXQxKRVDAIHnzNYY
         4RZBg0fGuuehJL9OZZLlM/MRLf9vSIzJCgeHMcXMrpzZ71/yw218OAUx0c43+xkm1i
         ClogaoOjveMOz5xWnZP0yyf6SZfovr+AZ6a2Po9qWSSfIcGv9ubaE1MYGNX+oC/cr5
         P//L1WK/5NXI0R6Cv3Wan0Tww7y3ZhuiXf9vX3I0YdXDJrH49n5i5qEZNiL5HbzAnm
         3B6k9TYqpr5351JBTaZ78VeVRDempoEneGqEQU5eVTQR27KewaHunGeDTzA5wxxeLe
         +mbnlprprWLUA==
Subject: [PATCH v1 06/17] SUNRPC: add list of idle threads
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:11 -0400
Message-ID: <169444315130.4327.68487008717136528.stgit@bazille.1015granger.net>
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

Rather than searching a list of threads to find an idle one, having a
list of idle threads allows an idle thread to be found immediately.

This adds some spin_lock calls which is not ideal, but as the hold-time
is tiny it is still faster than searching a list.  A future patch will
remove them using llist.h.  This involves some subtlety and so is left
to a separate patch.

This removes the need for the RQ_BUSY flag.  The rqst is "busy"
precisely when it is not on the "idle" list.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h    |   25 ++++++++++++++++++++++++-
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/svc.c              |   14 +++++++++-----
 net/sunrpc/svc_xprt.c         |   15 +++++++++++----
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0ec691070e27..e9c34e99bc88 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -37,6 +37,7 @@ struct svc_pool {
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
+	struct list_head	sp_idle_threads; /* idle server threads */
 
 	/* statistics on pool operation */
 	struct percpu_counter	sp_messages_arrived;
@@ -186,6 +187,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  */
 struct svc_rqst {
 	struct list_head	rq_all;		/* all threads list */
+	struct list_head	rq_idle;	/* On the idle list */
 	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
 	struct svc_xprt *	rq_xprt;	/* transport ptr */
 
@@ -262,10 +264,31 @@ enum {
 	RQ_SPLICE_OK,		/* turned off in gss privacy to prevent
 				 * encrypting page cache pages */
 	RQ_VICTIM,		/* Have agreed to shut down */
-	RQ_BUSY,		/* request is busy */
 	RQ_DATA,		/* request has data */
 };
 
+/**
+ * svc_thread_set_busy - mark a thread as busy
+ * @rqstp: the thread which is now busy
+ *
+ * If rq_idle is "empty", the thread must be busy.
+ */
+static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
+{
+	INIT_LIST_HEAD(&rqstp->rq_idle);
+}
+
+/**
+ * svc_thread_busy - check if a thread as busy
+ * @rqstp: the thread which might be busy
+ *
+ * If rq_idle is "empty", the thread must be busy.
+ */
+static inline bool svc_thread_busy(struct svc_rqst *rqstp)
+{
+	return list_empty(&rqstp->rq_idle);
+}
+
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6beb38c1dcb5..337c90787fb1 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1677,7 +1677,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
 	svc_rqst_flag(DROPME)						\
 	svc_rqst_flag(SPLICE_OK)					\
 	svc_rqst_flag(VICTIM)						\
-	svc_rqst_flag(BUSY)						\
 	svc_rqst_flag_end(DATA)
 
 #undef svc_rqst_flag
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index db579bbc0a0a..9d080fe2dcdf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -510,6 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		pool->sp_id = i;
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
+		INIT_LIST_HEAD(&pool->sp_idle_threads);
 		spin_lock_init(&pool->sp_lock);
 
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
@@ -641,7 +642,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	__set_bit(RQ_BUSY, &rqstp->rq_flags);
+	svc_thread_set_busy(rqstp);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -702,10 +703,13 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	struct svc_rqst	*rqstp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
-		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
-			continue;
-
+	spin_lock_bh(&pool->sp_lock);
+	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
+					 struct svc_rqst, rq_idle);
+	if (rqstp)
+		list_del_init(&rqstp->rq_idle);
+	spin_unlock_bh(&pool->sp_lock);
+	if (rqstp) {
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		wake_up_process(rqstp->rq_task);
 		rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b8539545fefd..ebfeeb504a79 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -737,8 +737,9 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 		set_current_state(TASK_IDLE);
 		smp_mb__before_atomic();
 		clear_bit(SP_CONGESTED, &pool->sp_flags);
-		clear_bit(RQ_BUSY, &rqstp->rq_flags);
-		smp_mb__after_atomic();
+		spin_lock_bh(&pool->sp_lock);
+		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		spin_unlock_bh(&pool->sp_lock);
 
 		/* Need to check should_sleep() again after
 		 * setting task state in case a wakeup happened
@@ -751,8 +752,14 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 			cond_resched();
 		}
 
-		set_bit(RQ_BUSY, &rqstp->rq_flags);
-		smp_mb__after_atomic();
+		/* We *must* be removed from the list before we can continue.
+		 * If we were woken, this is already done
+		 */
+		if (!svc_thread_busy(rqstp)) {
+			spin_lock_bh(&pool->sp_lock);
+			list_del_init(&rqstp->rq_idle);
+			spin_unlock_bh(&pool->sp_lock);
+		}
 	} else {
 		cond_resched();
 	}


