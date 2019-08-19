Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF21950DF
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfHSWgl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:36:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44864 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfHSWgl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:36:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so3209037ote.11;
        Mon, 19 Aug 2019 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=v/LwbD9loDDrhZ9x90qmsZdLimN0wXa2LzcUKgQfxQc=;
        b=EoDZczF5XYhNzKSOJKgZp4lVYMH6JteEpKYL23AgOlFpEt2C2Qg8DWoHCfMrhCKtgF
         m5EkayDhhIj81vaOqlT7gdwRsflgWI8deRMbWmGQAM8709SpBM6VzjZ4lfg9HIv2pGgZ
         pt655Gyb5tglMhXdqMxy0/COunKOq3Mk3AkV1Xcjl6Oh8GjhMaNZ/NX5DRqi15gd6t4q
         DT3/bR0rnvd76ZzmyoVa5z+6RL8gwqs0HD1uHzdQHfeZ9WGK4uTB5xyl6xxBziv81oJV
         owuL9bTO1SgBZnsLt+tEdpQukQt+ccv7zJU0NmR+FuuNjid3LRU6YvWgWj/1E0sDCZfE
         XdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=v/LwbD9loDDrhZ9x90qmsZdLimN0wXa2LzcUKgQfxQc=;
        b=g6TAqYdJCohfUK1mLuprB5lno/9lFUXktGbsama3oiqIXpHmbQCs+cEAAKLDMy/YcM
         xdcG42wkTGzrgBT9LPhBVnl3l1SKH1KgfZ458iBT/AE7esrcvDBw0VtZm1teLueJ++Yd
         bq1dEsaBRU/eov/4wyQgLQuO4xKhjC1f+CtzCBhvvV6MIuB85Fn3Ce5+ub4g8zUR5MYL
         VCcM1n3mPauCHqhB58cUqSCFg9ja84lgsrCFOqQ+m5nL4SlilRi24HugCOUKBKiExJFE
         0BsZmtwuBD9Rh7VQSdhaYQP3QE0yr8gpJzAzw/vwHzpS4vGDmPwZJsbEWz05xY8i88N0
         ftRQ==
X-Gm-Message-State: APjAAAWTL7drtdfi/VxZp5ZDRlfDLkV+6PxP3EAnDuqPiwpY1MeEyVmu
        GWqdRB0E0OWGjwk9Cheircd5fZao
X-Google-Smtp-Source: APXvYqzZTwKdznpHNOaf3S1X3ioDVgrnRrA/tU3eV2d/AsA5PY5eDzAEeQOHHScdn1UnDhbZPkZ3+g==
X-Received: by 2002:a9d:591a:: with SMTP id t26mr17062173oth.170.1566254200348;
        Mon, 19 Aug 2019 15:36:40 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id v17sm4713375oif.1.2019.08.19.15.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:36:40 -0700 (PDT)
Subject: [PATCH v2 01/21] SUNRPC: Remove rpc_wake_up_queued_task_on_wq()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:36:19 -0400
Message-ID: <156625415896.8161.6772555466035123844.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: commit c544577daddb ("SUNRPC: Clean up transport write
space handling") appears to have removed the last caller of
rpc_wake_up_queued_task_on_wq().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/sched.h |    3 ---
 net/sunrpc/sched.c           |   27 ++++-----------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index baa3ecdb882f..d1283bddd218 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -243,9 +243,6 @@ void		rpc_sleep_on_priority_timeout(struct rpc_wait_queue *queue,
 void		rpc_sleep_on_priority(struct rpc_wait_queue *,
 					struct rpc_task *,
 					int priority);
-void rpc_wake_up_queued_task_on_wq(struct workqueue_struct *wq,
-		struct rpc_wait_queue *queue,
-		struct rpc_task *task);
 void		rpc_wake_up_queued_task(struct rpc_wait_queue *,
 					struct rpc_task *);
 void		rpc_wake_up_queued_task_set_status(struct rpc_wait_queue *,
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 1f275aba786f..f25c4b9ba185 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -541,33 +541,14 @@ rpc_wake_up_task_on_wq_queue_action_locked(struct workqueue_struct *wq,
 	return NULL;
 }
 
-static void
-rpc_wake_up_task_on_wq_queue_locked(struct workqueue_struct *wq,
-		struct rpc_wait_queue *queue, struct rpc_task *task)
-{
-	rpc_wake_up_task_on_wq_queue_action_locked(wq, queue, task, NULL, NULL);
-}
-
 /*
  * Wake up a queued task while the queue lock is being held
  */
-static void rpc_wake_up_task_queue_locked(struct rpc_wait_queue *queue, struct rpc_task *task)
+static void rpc_wake_up_task_queue_locked(struct rpc_wait_queue *queue,
+					  struct rpc_task *task)
 {
-	rpc_wake_up_task_on_wq_queue_locked(rpciod_workqueue, queue, task);
-}
-
-/*
- * Wake up a task on a specific queue
- */
-void rpc_wake_up_queued_task_on_wq(struct workqueue_struct *wq,
-		struct rpc_wait_queue *queue,
-		struct rpc_task *task)
-{
-	if (!RPC_IS_QUEUED(task))
-		return;
-	spin_lock(&queue->lock);
-	rpc_wake_up_task_on_wq_queue_locked(wq, queue, task);
-	spin_unlock(&queue->lock);
+	rpc_wake_up_task_on_wq_queue_action_locked(rpciod_workqueue, queue,
+						   task, NULL, NULL);
 }
 
 /*

