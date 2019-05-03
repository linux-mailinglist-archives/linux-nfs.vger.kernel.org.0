Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E912C3C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfECLW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 07:22:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36777 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECLW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 07:22:28 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so4890132ioc.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUm52Uoi2prhST+XQVxbf5gBg5QgU8w/LLJ8uHs0lgw=;
        b=uoNYHQQqmgXPnpgrFJiOVUxwmK81A/yxK5HBlRJGhK3Cuueao3g3HRs3ZzTrwig3+b
         bnF4SeoRzf0dtugOccPeqh9DfV4RYSj87w3arRAWlakYUUoNaM2Brncwkb8Ns6LKO+4w
         u1np+lFLDRdrgMCnqPC48P8JSdfrjiJ12l2ETcFn2lbkCrxkH5dexy+RK4hvfLxcXus1
         kao6Czwg+25wWMH8dGPt7dzk9IV6fsOLZg+PiRzwh4oJVcmmCEUWW3RX6+A4Aolqovkh
         y2fevumdT6zZu4qx/ghEmV9sdWoNd6j+lWhQ8WL2Xe5hihEcQZ9NPhEzCFd9mnnDZiF/
         d/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUm52Uoi2prhST+XQVxbf5gBg5QgU8w/LLJ8uHs0lgw=;
        b=d2CkbyyCRfgckanca6xn1A2MGF+sUHZnRSyMbr59dMj3E/zIPQzu8pj8ZUwZRxYxXg
         GHvmNdIN+dWYtQwldzl2cDijuYwX+rquuL7JqRY0+kaH9DfRsdSBzJYWYDbPUOLDO7zz
         CQtac2PTNsm/XdOrRfBzSAynMBNk0XBgAyQSiNht8iKI1uysrAMhcXtR3B7cChQ10/1j
         3d+gWjIzgNDem0F5QNIWL+OD+3Rw+IAmKxPBguvHbgZxeui+nzXq/cfYDSgoDycHn8Ae
         ugSZXZMf+AtI9POBPmAWf16O3iAR7WOcqKDw7vT4O4lrkkWaInyDKmPso/Psd74cZudf
         rx+w==
X-Gm-Message-State: APjAAAWqQ5zR+/HPmlBx5/oehn5Xte/ik7k704CNeU/rAraiHnj5SsB7
        nF1TaZEJsOPJLRynuPX26Q==
X-Google-Smtp-Source: APXvYqyos+tRYKWfGfUklpLJb535MCHpLv6F0JC582aukYcf963aPBCTuQEAYvKGA6Vp1kGX6hjZMQ==
X-Received: by 2002:a5e:d503:: with SMTP id e3mr6452781iom.46.1556882546770;
        Fri, 03 May 2019 04:22:26 -0700 (PDT)
Received: from localhost.localdomain ([8.46.76.65])
        by smtp.gmail.com with ESMTPSA id d193sm737325iog.34.2019.05.03.04.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:22:25 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/5] SUNRPC: Replace the queue timer with a delayed work function
Date:   Fri,  3 May 2019 06:18:37 -0500
Message-Id: <20190503111841.4391-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The queue timer function, which walks the RPC queue in order to locate
candidates for waking up is one of the current constraints against
removing the bh-safe queue spin locks. Replace it with a delayed
work queue, so that we can do the actual rpc task wake ups from an
ordinary process context.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h |  3 ++-
 net/sunrpc/sched.c           | 32 ++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index d0e451868f02..7d8db5dcac04 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -183,8 +183,9 @@ struct rpc_task_setup {
 #define RPC_NR_PRIORITY		(1 + RPC_PRIORITY_PRIVILEGED - RPC_PRIORITY_LOW)
 
 struct rpc_timer {
-	struct timer_list timer;
 	struct list_head list;
+	unsigned long expires;
+	struct delayed_work dwork;
 };
 
 /*
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 1a12fb03e611..e7723c2c1b1c 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -45,7 +45,7 @@ static mempool_t	*rpc_buffer_mempool __read_mostly;
 
 static void			rpc_async_schedule(struct work_struct *);
 static void			 rpc_release_task(struct rpc_task *task);
-static void __rpc_queue_timer_fn(struct timer_list *t);
+static void __rpc_queue_timer_fn(struct work_struct *);
 
 /*
  * RPC tasks sit here while waiting for conditions to improve.
@@ -86,13 +86,19 @@ __rpc_disable_timer(struct rpc_wait_queue *queue, struct rpc_task *task)
 	task->tk_timeout = 0;
 	list_del(&task->u.tk_wait.timer_list);
 	if (list_empty(&queue->timer_list.list))
-		del_timer(&queue->timer_list.timer);
+		cancel_delayed_work(&queue->timer_list.dwork);
 }
 
 static void
 rpc_set_queue_timer(struct rpc_wait_queue *queue, unsigned long expires)
 {
-	timer_reduce(&queue->timer_list.timer, expires);
+	unsigned long now = jiffies;
+	queue->timer_list.expires = expires;
+	if (time_before_eq(expires, now))
+		expires = 0;
+	else
+		expires -= now;
+	mod_delayed_work(rpciod_workqueue, &queue->timer_list.dwork, expires);
 }
 
 /*
@@ -106,7 +112,8 @@ __rpc_add_timer(struct rpc_wait_queue *queue, struct rpc_task *task,
 		task->tk_pid, jiffies_to_msecs(timeout - jiffies));
 
 	task->tk_timeout = timeout;
-	rpc_set_queue_timer(queue, timeout);
+	if (list_empty(&queue->timer_list.list) || time_before(timeout, queue->timer_list.expires))
+		rpc_set_queue_timer(queue, timeout);
 	list_add(&task->u.tk_wait.timer_list, &queue->timer_list.list);
 }
 
@@ -249,9 +256,8 @@ static void __rpc_init_priority_wait_queue(struct rpc_wait_queue *queue, const c
 	queue->maxpriority = nr_queues - 1;
 	rpc_reset_waitqueue_priority(queue);
 	queue->qlen = 0;
-	timer_setup(&queue->timer_list.timer,
-			__rpc_queue_timer_fn,
-			TIMER_DEFERRABLE);
+	queue->timer_list.expires = 0;
+	INIT_DEFERRABLE_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
 	INIT_LIST_HEAD(&queue->timer_list.list);
 	rpc_assign_waitqueue_name(queue, qname);
 }
@@ -270,7 +276,7 @@ EXPORT_SYMBOL_GPL(rpc_init_wait_queue);
 
 void rpc_destroy_wait_queue(struct rpc_wait_queue *queue)
 {
-	del_timer_sync(&queue->timer_list.timer);
+	cancel_delayed_work_sync(&queue->timer_list.dwork);
 }
 EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
@@ -760,13 +766,15 @@ void rpc_wake_up_status(struct rpc_wait_queue *queue, int status)
 }
 EXPORT_SYMBOL_GPL(rpc_wake_up_status);
 
-static void __rpc_queue_timer_fn(struct timer_list *t)
+static void __rpc_queue_timer_fn(struct work_struct *work)
 {
-	struct rpc_wait_queue *queue = from_timer(queue, t, timer_list.timer);
+	struct rpc_wait_queue *queue = container_of(work,
+			struct rpc_wait_queue,
+			timer_list.dwork.work);
 	struct rpc_task *task, *n;
 	unsigned long expires, now, timeo;
 
-	spin_lock(&queue->lock);
+	spin_lock_bh(&queue->lock);
 	expires = now = jiffies;
 	list_for_each_entry_safe(task, n, &queue->timer_list.list, u.tk_wait.timer_list) {
 		timeo = task->tk_timeout;
@@ -781,7 +789,7 @@ static void __rpc_queue_timer_fn(struct timer_list *t)
 	}
 	if (!list_empty(&queue->timer_list.list))
 		rpc_set_queue_timer(queue, expires);
-	spin_unlock(&queue->lock);
+	spin_unlock_bh(&queue->lock);
 }
 
 static void __rpc_atrun(struct rpc_task *task)
-- 
2.21.0

