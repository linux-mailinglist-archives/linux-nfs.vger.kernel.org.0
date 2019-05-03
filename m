Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2612C40
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfECLWp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 07:22:45 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37207 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECLWp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 07:22:45 -0400
Received: by mail-it1-f196.google.com with SMTP id r85so8458433itc.2
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6O605N1GEs6tFDYNttZlHB5qCMseHDTVIm6N+5Nj4g=;
        b=nhrAiAWK3b59G+DbyUsd/LEbwxu/t+W9VY1KYuKd7fmMF8QK74IlZKuLYbcDhltNTL
         Hs7E3Jx5uvkHDAHZW3DC0IcF9hh2KcIP5Jhk3bxrDAFdjNs117OssJ2GQDQmg5wG0g5G
         t2lRmpkUJNNFa7+L9yxfpaEIY/s/1Js45LHL9lUaSQP3/6cvKXq2zmTiGBVJ6Uj/blzV
         IkezpVUQTtDrJmeQ1VLhUG6y5J+DzRtW9tTr08tMSAvCA1iVRCwmeTHzbcTrNpbfW8Vv
         5AcUiR0L478IhSO1ZfQt3s2nFTns9fNWPWNlAl7+zmdkdToyOhb9GmFCFN9KouSrLFyE
         ZSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6O605N1GEs6tFDYNttZlHB5qCMseHDTVIm6N+5Nj4g=;
        b=sBcRFeC9IEr51acbIA07dAYcZMj37WRGWaxosTUQR6nhNb2LZTFRN2199FP7reFkfy
         k5zuAfL/SLcbTIhmwxIWIXb++tnF3Wb/Nzh2OkTRKcXpPreJIp6+XVY7Ehk9VwTwAkxl
         Eq0hsWGUnOnrFyWN21OP84hrl3ixMGDBCkX+j6qNqJcWdEYQcWudefRu/pVhQECATv4P
         JkChawh/Z8FkPe0l+rJs3vT4Ay7L1HqXjU7u3U2dKc7wLmxYI+V+PxazvOVNdBGTFLAW
         74YyXEkDxJ1WUuiteIzfADGqnJDsiNYoflN1WtecyETTfiW5tFCDGZeFqUMyJmzbb4OM
         hBzQ==
X-Gm-Message-State: APjAAAW3NnwrbfL82yAwy0+ghx1x9c0jS4cx/X9+C6Fnlgg2gldAT388
        sSiMXEell2P2lFtjOooIfUwepJJfJg==
X-Google-Smtp-Source: APXvYqzmfhZg5Gn4gokqoWxwTMTclP+MZgoYNZrqYZbGLR5viwE9Rz4j4mPpc+9kM2jVTQh3BAJC5A==
X-Received: by 2002:a24:68c3:: with SMTP id v186mr2433267itb.128.1556882564107;
        Fri, 03 May 2019 04:22:44 -0700 (PDT)
Received: from localhost.localdomain ([8.46.76.65])
        by smtp.gmail.com with ESMTPSA id d193sm737325iog.34.2019.05.03.04.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:22:43 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 4/5] SUNRPC: Remove the bh-safe lock requirement on the rpc_wait_queue->lock
Date:   Fri,  3 May 2019 06:18:40 -0500
Message-Id: <20190503111841.4391-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503111841.4391-4-trond.myklebust@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index e7723c2c1b1c..c7e81336620c 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -431,9 +431,9 @@ void rpc_sleep_on_timeout(struct rpc_wait_queue *q, struct rpc_task *task,
 	/*
 	 * Protect the queue operations.
 	 */
-	spin_lock_bh(&q->lock);
+	spin_lock(&q->lock);
 	__rpc_sleep_on_priority_timeout(q, task, timeout, task->tk_priority);
-	spin_unlock_bh(&q->lock);
+	spin_unlock(&q->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_sleep_on_timeout);
 
@@ -449,9 +449,9 @@ void rpc_sleep_on(struct rpc_wait_queue *q, struct rpc_task *task,
 	/*
 	 * Protect the queue operations.
 	 */
-	spin_lock_bh(&q->lock);
+	spin_lock(&q->lock);
 	__rpc_sleep_on_priority(q, task, task->tk_priority);
-	spin_unlock_bh(&q->lock);
+	spin_unlock(&q->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_sleep_on);
 
@@ -465,9 +465,9 @@ void rpc_sleep_on_priority_timeout(struct rpc_wait_queue *q,
 	/*
 	 * Protect the queue operations.
 	 */
-	spin_lock_bh(&q->lock);
+	spin_lock(&q->lock);
 	__rpc_sleep_on_priority_timeout(q, task, timeout, priority);
-	spin_unlock_bh(&q->lock);
+	spin_unlock(&q->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_sleep_on_priority_timeout);
 
@@ -482,9 +482,9 @@ void rpc_sleep_on_priority(struct rpc_wait_queue *q, struct rpc_task *task,
 	/*
 	 * Protect the queue operations.
 	 */
-	spin_lock_bh(&q->lock);
+	spin_lock(&q->lock);
 	__rpc_sleep_on_priority(q, task, priority);
-	spin_unlock_bh(&q->lock);
+	spin_unlock(&q->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_sleep_on_priority);
 
@@ -562,9 +562,9 @@ void rpc_wake_up_queued_task_on_wq(struct workqueue_struct *wq,
 {
 	if (!RPC_IS_QUEUED(task))
 		return;
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	rpc_wake_up_task_on_wq_queue_locked(wq, queue, task);
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 
 /*
@@ -574,9 +574,9 @@ void rpc_wake_up_queued_task(struct rpc_wait_queue *queue, struct rpc_task *task
 {
 	if (!RPC_IS_QUEUED(task))
 		return;
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	rpc_wake_up_task_queue_locked(queue, task);
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_wake_up_queued_task);
 
@@ -609,9 +609,9 @@ rpc_wake_up_queued_task_set_status(struct rpc_wait_queue *queue,
 {
 	if (!RPC_IS_QUEUED(task))
 		return;
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	rpc_wake_up_task_queue_set_status_locked(queue, task, status);
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 
 /*
@@ -674,12 +674,12 @@ struct rpc_task *rpc_wake_up_first_on_wq(struct workqueue_struct *wq,
 
 	dprintk("RPC:       wake_up_first(%p \"%s\")\n",
 			queue, rpc_qname(queue));
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	task = __rpc_find_next_queued(queue);
 	if (task != NULL)
 		task = rpc_wake_up_task_on_wq_queue_action_locked(wq, queue,
 				task, func, data);
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 
 	return task;
 }
@@ -718,7 +718,7 @@ void rpc_wake_up(struct rpc_wait_queue *queue)
 {
 	struct list_head *head;
 
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	head = &queue->tasks[queue->maxpriority];
 	for (;;) {
 		while (!list_empty(head)) {
@@ -732,7 +732,7 @@ void rpc_wake_up(struct rpc_wait_queue *queue)
 			break;
 		head--;
 	}
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_wake_up);
 
@@ -747,7 +747,7 @@ void rpc_wake_up_status(struct rpc_wait_queue *queue, int status)
 {
 	struct list_head *head;
 
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	head = &queue->tasks[queue->maxpriority];
 	for (;;) {
 		while (!list_empty(head)) {
@@ -762,7 +762,7 @@ void rpc_wake_up_status(struct rpc_wait_queue *queue, int status)
 			break;
 		head--;
 	}
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 EXPORT_SYMBOL_GPL(rpc_wake_up_status);
 
@@ -774,7 +774,7 @@ static void __rpc_queue_timer_fn(struct work_struct *work)
 	struct rpc_task *task, *n;
 	unsigned long expires, now, timeo;
 
-	spin_lock_bh(&queue->lock);
+	spin_lock(&queue->lock);
 	expires = now = jiffies;
 	list_for_each_entry_safe(task, n, &queue->timer_list.list, u.tk_wait.timer_list) {
 		timeo = task->tk_timeout;
@@ -789,7 +789,7 @@ static void __rpc_queue_timer_fn(struct work_struct *work)
 	}
 	if (!list_empty(&queue->timer_list.list))
 		rpc_set_queue_timer(queue, expires);
-	spin_unlock_bh(&queue->lock);
+	spin_unlock(&queue->lock);
 }
 
 static void __rpc_atrun(struct rpc_task *task)
@@ -936,13 +936,13 @@ static void __rpc_execute(struct rpc_task *task)
 		 * rpc_task pointer may still be dereferenced.
 		 */
 		queue = task->tk_waitqueue;
-		spin_lock_bh(&queue->lock);
+		spin_lock(&queue->lock);
 		if (!RPC_IS_QUEUED(task)) {
-			spin_unlock_bh(&queue->lock);
+			spin_unlock(&queue->lock);
 			continue;
 		}
 		rpc_clear_running(task);
-		spin_unlock_bh(&queue->lock);
+		spin_unlock(&queue->lock);
 		if (task_is_async)
 			return;
 
-- 
2.21.0

