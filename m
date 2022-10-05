Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FED5F5ACB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJEUEb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJEUE3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:04:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6787C2DA88
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04961B81F2C
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 20:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62589C433C1;
        Wed,  5 Oct 2022 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665000265;
        bh=n8cyou3Moz/zqNh4bF1IMy6QDRDomQcsIi+5tZibh5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5ezJ51n+wTdwAVei4fkRLDc2F57FluGcRfeiFAhX5k2sNRxa0qtUiJK2lrFjCg+1
         S0uEbpHgORJY7fuC5TxGrP8cIaSnqEsvAi9rDqvu3WwA7X22OptVfxZWuVjYGPso2d
         TXpyc5tkVB0D6Pu3d0aFKfHwDl6x1+/Mc1JQoY5aLOkGFwD2EaaWP4uFExufMWEo2w
         gy/8HDXX88zHtVvep1GTKfN7LUUlt+/msyj/ODSMyJEl2h2DTzknTqnfLq00n9wfXb
         yZeP8kzqAO6LIkBRcoVQsbyhzX84PynTW/6JqWxAlh2WuKd74lhrm+TaB5kow4NXaT
         /STZ9SF61NApw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] SUNRPC: Fix races with rpc_killall_tasks()
Date:   Wed,  5 Oct 2022 15:57:35 -0400
Message-Id: <20221005195738.4552-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005195738.4552-1-trondmy@kernel.org>
References: <20221005195738.4552-1-trondmy@kernel.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we immediately call rpc_exit_task() after waking up, and
that the tk_rpc_status cannot get clobbered by some other function.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/clnt.c            |  6 ++----
 net/sunrpc/sched.c           | 40 ++++++++++++++++++++++--------------
 net/sunrpc/xprtsock.c        |  3 +--
 4 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index acc62647317c..647247040ef9 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -209,6 +209,7 @@ struct rpc_task *rpc_run_task(const struct rpc_task_setup *);
 struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
 void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
+bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
 void		rpc_signal_task(struct rpc_task *);
 void		rpc_exit_task(struct rpc_task *);
 void		rpc_exit(struct rpc_task *, int);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c284efa3d1ef..77a44118c0da 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1642,7 +1642,7 @@ static void
 __rpc_call_rpcerror(struct rpc_task *task, int tk_status, int rpc_status)
 {
 	trace_rpc_call_rpcerror(task, tk_status, rpc_status);
-	task->tk_rpc_status = rpc_status;
+	rpc_task_set_rpc_status(task, rpc_status);
 	rpc_exit(task, tk_status);
 }
 
@@ -2435,10 +2435,8 @@ rpc_check_timeout(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
-	if (RPC_SIGNALLED(task)) {
-		rpc_call_rpcerror(task, -ERESTARTSYS);
+	if (RPC_SIGNALLED(task))
 		return;
-	}
 
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 25b9221950ff..f388bfaf6ff0 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -65,6 +65,13 @@ gfp_t rpc_task_gfp_mask(void)
 }
 EXPORT_SYMBOL_GPL(rpc_task_gfp_mask);
 
+bool rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status)
+{
+	if (cmpxchg(&task->tk_rpc_status, 0, rpc_status) == 0)
+		return true;
+	return false;
+}
+
 unsigned long
 rpc_task_timeout(const struct rpc_task *task)
 {
@@ -855,12 +862,14 @@ void rpc_signal_task(struct rpc_task *task)
 	if (!RPC_IS_ACTIVATED(task))
 		return;
 
+	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
+		return;
 	trace_rpc_task_signalled(task, task->tk_action);
 	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
 	smp_mb__after_atomic();
 	queue = READ_ONCE(task->tk_waitqueue);
 	if (queue)
-		rpc_wake_up_queued_task_set_status(queue, task, -ERESTARTSYS);
+		rpc_wake_up_queued_task(queue, task);
 }
 
 void rpc_exit(struct rpc_task *task, int status)
@@ -907,10 +916,16 @@ static void __rpc_execute(struct rpc_task *task)
 		 * Perform the next FSM step or a pending callback.
 		 *
 		 * tk_action may be NULL if the task has been killed.
-		 * In particular, note that rpc_killall_tasks may
-		 * do this at any time, so beware when dereferencing.
 		 */
 		do_action = task->tk_action;
+		/* Tasks with an RPC error status should exit */
+		if (do_action != rpc_exit_task &&
+		    (status = READ_ONCE(task->tk_rpc_status)) != 0) {
+			task->tk_status = status;
+			if (do_action != NULL)
+				do_action = rpc_exit_task;
+		}
+		/* Callbacks override all actions */
 		if (task->tk_callback) {
 			do_action = task->tk_callback;
 			task->tk_callback = NULL;
@@ -932,14 +947,6 @@ static void __rpc_execute(struct rpc_task *task)
 			continue;
 		}
 
-		/*
-		 * Signalled tasks should exit rather than sleep.
-		 */
-		if (RPC_SIGNALLED(task)) {
-			task->tk_rpc_status = -ERESTARTSYS;
-			rpc_exit(task, -ERESTARTSYS);
-		}
-
 		/*
 		 * The queue->lock protects against races with
 		 * rpc_make_runnable().
@@ -955,6 +962,12 @@ static void __rpc_execute(struct rpc_task *task)
 			spin_unlock(&queue->lock);
 			continue;
 		}
+		/* Wake up any task that has an exit status */
+		if (READ_ONCE(task->tk_rpc_status) != 0) {
+			rpc_wake_up_task_queue_locked(queue, task);
+			spin_unlock(&queue->lock);
+			continue;
+		}
 		rpc_clear_running(task);
 		spin_unlock(&queue->lock);
 		if (task_is_async)
@@ -972,10 +985,7 @@ static void __rpc_execute(struct rpc_task *task)
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-			trace_rpc_task_signalled(task, task->tk_action);
-			set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
-			task->tk_rpc_status = -ERESTARTSYS;
-			rpc_exit(task, -ERESTARTSYS);
+			rpc_signal_task(task);
 		}
 		trace_rpc_task_sync_wake(task, task->tk_action);
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e976007f4fd0..d4750caa773a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1978,8 +1978,7 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		 * we'll need to figure out how to pass a namespace to
 		 * connect.
 		 */
-		task->tk_rpc_status = -ENOTCONN;
-		rpc_exit(task, -ENOTCONN);
+		rpc_task_set_rpc_status(task, -ENOTCONN);
 		goto out_wake;
 	}
 	ret = xs_local_setup_socket(transport);
-- 
2.37.3

