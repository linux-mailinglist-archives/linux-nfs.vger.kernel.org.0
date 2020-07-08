Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38E021913D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGHUKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHUKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2714C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so35563462qtr.9
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ow2ayKcdAl1ByfRQ6W0ZVzyNcM0r2qXggwvghg/TTx0=;
        b=MabB9/kUbWC/9IhlTTkUPhPQkzuVUMdwNRrJKAdj6iD5fO2Ho24EveYtcnIbx5NAZV
         /m9KJlpyLlUsQXQgMZldS/17sNt5sa2YiZLnK2KlzDLDm5Qb8pa0xDO0rWVBlA+Hj2Op
         PN2MeHRdqE6a1G1V3IoTEx4xZ2dsxQjZhc7n7r8ArQMUD6gsZ2KTX0TKjs3ZPmXJqYHq
         BmDNrVyO97FsXkY/0m7eL1SufX6tNWWNBPBzG6HG9cQbjyLWPslBgru6VlXy0HVM+Cr5
         PiCE2XSLB8rBKJtBtMulIW2WMXDl0REC04nswLyp5HyyV5t0tFLgFKFrPfclJCHkxGhw
         Vc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ow2ayKcdAl1ByfRQ6W0ZVzyNcM0r2qXggwvghg/TTx0=;
        b=QgzNWP6opDn2/W6jFuJgpW3N4wQhuQtQWfbmc8lx8dj1cv94EBrAJxGkrZqY6229qV
         5dgMmVyNT1rB5M19nMzjaZ1EpsC5SYw4i+CNN1o78ztTvjgzFyB05ebJp//ViOyu2Jbd
         26/sM2Q4JPwMb2xk2R+trcm1W4QrL5vSk1Jfui6yajsgvUGHQsUTzDieVuMRQRGo3oKG
         x2thTtQ0ZxBuygRuUE/TFvjFHbJdPCPf68CZARTl8+7XBujDzGZkHaOPm040CEYlRIz+
         Fyw7YVyCnBAMgpeA2vQfs+zvHAFFUTvdO5+NW1IywWySrR/2ddmPBYXLfkHF+cNWbPQL
         bBeQ==
X-Gm-Message-State: AOAM531xp2UcP6NhEZw3nSFbYAjkTshf1RrXCvY00GbFiwFQLT3xLR42
        6rsgEuKy9xEICzoLwXXwZhKpQfdk
X-Google-Smtp-Source: ABdhPJwd4+77Ox+1EAq9qgUua6zRRDLSjG4azbmtDcR2CvLooKQryeH5ErGrupf5G8rEzQrWiBIm9A==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr62483938qtq.193.1594239051994;
        Wed, 08 Jul 2020 13:10:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c27sm1016961qka.23.2020.07.08.13.10.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:51 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAoGH006137
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:50 GMT
Subject: [PATCH v1 21/22] SUNRPC: Remove dprintk call sites in RPC queuing
 functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:50 -0400
Message-ID: <20200708201050.22129.61710.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove redundant call sites or call sites that are already covered
by tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/sched.c            |   22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index abd55e88440d..843f85b2a611 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -390,6 +390,7 @@ DEFINE_RPC_RUNNING_EVENT(run_action);
 DEFINE_RPC_RUNNING_EVENT(sync_sleep);
 DEFINE_RPC_RUNNING_EVENT(sync_wake);
 DEFINE_RPC_RUNNING_EVENT(complete);
+DEFINE_RPC_RUNNING_EVENT(timeout);
 DEFINE_RPC_RUNNING_EVENT(signalled);
 DEFINE_RPC_RUNNING_EVENT(end);
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index a0d5a98fbf32..116b3abaed3f 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -85,7 +85,6 @@ __rpc_disable_timer(struct rpc_wait_queue *queue, struct rpc_task *task)
 {
 	if (list_empty(&task->u.tk_wait.timer_list))
 		return;
-	dprintk("RPC: %5u disabling timer\n", task->tk_pid);
 	task->tk_timeout = 0;
 	list_del(&task->u.tk_wait.timer_list);
 	if (list_empty(&queue->timer_list.list))
@@ -111,9 +110,6 @@ static void
 __rpc_add_timer(struct rpc_wait_queue *queue, struct rpc_task *task,
 		unsigned long timeout)
 {
-	dprintk("RPC: %5u setting alarm for %u ms\n",
-		task->tk_pid, jiffies_to_msecs(timeout - jiffies));
-
 	task->tk_timeout = timeout;
 	if (list_empty(&queue->timer_list.list) || time_before(timeout, queue->timer_list.expires))
 		rpc_set_queue_timer(queue, timeout);
@@ -216,9 +212,6 @@ static void __rpc_add_wait_queue(struct rpc_wait_queue *queue,
 	/* barrier matches the read in rpc_wake_up_task_queue_locked() */
 	smp_wmb();
 	rpc_set_queued(task);
-
-	dprintk("RPC: %5u added to queue %p \"%s\"\n",
-			task->tk_pid, queue, rpc_qname(queue));
 }
 
 /*
@@ -241,8 +234,6 @@ static void __rpc_remove_wait_queue(struct rpc_wait_queue *queue, struct rpc_tas
 	else
 		list_del(&task->u.tk_wait.list);
 	queue->qlen--;
-	dprintk("RPC: %5u removed from queue %p \"%s\"\n",
-			task->tk_pid, queue, rpc_qname(queue));
 }
 
 static void __rpc_init_priority_wait_queue(struct rpc_wait_queue *queue, const char *qname, unsigned char nr_queues)
@@ -382,13 +373,9 @@ static void __rpc_do_sleep_on_priority(struct rpc_wait_queue *q,
 		struct rpc_task *task,
 		unsigned char queue_priority)
 {
-	dprintk("RPC: %5u sleep_on(queue \"%s\" time %lu)\n",
-			task->tk_pid, rpc_qname(q), jiffies);
-
 	trace_rpc_task_sleep(task, q);
 
 	__rpc_add_wait_queue(q, task, queue_priority);
-
 }
 
 static void __rpc_sleep_on_priority(struct rpc_wait_queue *q,
@@ -510,9 +497,6 @@ static void __rpc_do_wake_up_task_on_wq(struct workqueue_struct *wq,
 		struct rpc_wait_queue *queue,
 		struct rpc_task *task)
 {
-	dprintk("RPC: %5u __rpc_wake_up_task (now %lu)\n",
-			task->tk_pid, jiffies);
-
 	/* Has the task been executed yet? If not, we cannot wake it up! */
 	if (!RPC_IS_ACTIVATED(task)) {
 		printk(KERN_ERR "RPC: Inactive task (%p) being woken up!\n", task);
@@ -524,8 +508,6 @@ static void __rpc_do_wake_up_task_on_wq(struct workqueue_struct *wq,
 	__rpc_remove_wait_queue(queue, task);
 
 	rpc_make_runnable(wq, task);
-
-	dprintk("RPC:       __rpc_wake_up_task done\n");
 }
 
 /*
@@ -663,8 +645,6 @@ struct rpc_task *rpc_wake_up_first_on_wq(struct workqueue_struct *wq,
 {
 	struct rpc_task	*task = NULL;
 
-	dprintk("RPC:       wake_up_first(%p \"%s\")\n",
-			queue, rpc_qname(queue));
 	spin_lock(&queue->lock);
 	task = __rpc_find_next_queued(queue);
 	if (task != NULL)
@@ -770,7 +750,7 @@ static void __rpc_queue_timer_fn(struct work_struct *work)
 	list_for_each_entry_safe(task, n, &queue->timer_list.list, u.tk_wait.timer_list) {
 		timeo = task->tk_timeout;
 		if (time_after_eq(now, timeo)) {
-			dprintk("RPC: %5u timeout\n", task->tk_pid);
+			trace_rpc_task_timeout(task, task->tk_action);
 			task->tk_status = -ETIMEDOUT;
 			rpc_wake_up_task_queue_locked(queue, task);
 			continue;

