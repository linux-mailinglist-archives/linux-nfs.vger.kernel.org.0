Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A2835C1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfHFPwE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:52:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39274 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:52:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so87671414otq.6
        for <linux-nfs@vger.kernel.org>; Tue, 06 Aug 2019 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=A+lQe1GuITUZVTYazD+FwAbt11v5MPouMADftBzkWps=;
        b=ie33OyTvex5IsvMwwWF3AlRmwGn1tbCrbeVXQf12EzFFzbRi/CYoz8FJVS/Hkv7fVO
         Qx4W8NRJABtn44e7SpwtYT9kALn1XOJofITtQNdCcsAc0Q/ReO5zjcAthr47vvt1DP32
         oC++r/CQinHNiIdhU3qBtO18++8Q6NG7DHuUz4mK6wFCAIGoKN3FTH8GJQJ3nH5eH3Lj
         EOuotr+oJ0+hD2tUOr+s5J3F7jWMv01fmBjQy3Tv14J7OCc9vOq+Lp6md3qVx7T2fKtB
         dAlAqty9I9SKq1KZn6Wn3bT1Nu+rkjoy1TyN6HW7YjGz4Ut89x7eJJ2jhQXejEwmW70A
         IIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=A+lQe1GuITUZVTYazD+FwAbt11v5MPouMADftBzkWps=;
        b=TfT6u8Ttc4qrh+/FtlSacr+Kb/FJxA5hM0k72QKYfvi9c5kaUtXKyTHM359NNIagUQ
         YY02FKXeL2adDO0P9QiWhgWBO2uzXRPqVMUejf/8k/5Y1TkDOTICJbZbKjRmuIYaivYX
         aVTZJCXEfRKO2+qcUmneZwlG2HbpGZHjc+Vj4jlfGhgQp6UxS3GpvkqrQ2lWBWEuhZR9
         4y6Vs6AqRRYkYle+dgnfppyz9M/CLl0SFKmVKUMMM7Zx7PyARtcx82PtqKDA2rW/uy2Y
         X5vEkvOmydMgDXlqRNMajTx5w5PU6DL7BVVOn6/cJPYUqwi0GyGjAoZzRzXGbJ+dgOsD
         DB0g==
X-Gm-Message-State: APjAAAX/+f91Koi5ycIgQESB6cpAMTvJgLQHWkU38P2MdUwpXY2FZMpP
        UmQrncMpxsXTz54eZCW3W1E3B1e8
X-Google-Smtp-Source: APXvYqy0dt0Rr3Rc6kwWR2AkqWQ+hbwqIZgBwcoCksl0xxuXTZ0lmcCCBqMrc3Mum+sBjBeRdtTojQ==
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr3908549ior.123.1565106722026;
        Tue, 06 Aug 2019 08:52:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j23sm70990999ioo.6.2019.08.06.08.52.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:52:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fq0BH011505
        for <linux-nfs@vger.kernel.org>; Tue, 6 Aug 2019 15:52:00 GMT
Subject: [PATCH v1 1/2] SUNRPC: Remove rpc_wake_up_queued_task_on_wq()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:52:00 -0400
Message-ID: <20190806155200.9332.67391.stgit@manet.1015granger.net>
In-Reply-To: <20190806155055.9332.19343.stgit@manet.1015granger.net>
References: <20190806155055.9332.19343.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
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
index baa3ecd..d1283bd 100644
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
index 1f275ab..f25c4b9b 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -541,33 +541,14 @@ static void __rpc_do_wake_up_task_on_wq(struct workqueue_struct *wq,
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

