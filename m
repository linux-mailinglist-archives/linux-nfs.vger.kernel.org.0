Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C719FE22
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDFTgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 15:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFTgH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 15:36:07 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1471C2072A
        for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2020 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586201767;
        bh=m3qhf/jCtUZ80xFjWrmB3/9BrzD7RXCFNmQJ0NYiCe8=;
        h=From:To:Subject:Date:From;
        b=Un7PsuVdSMMVJIGup4uYDEXEAftP2OZ8c7NH0uAEO8LHieUt4y08q/LHEgHS6SLFQ
         smu9InqTvWl38lJRX6XiRddnsqi7QSSgIJBaYaAC997+esSc7cxcTQhgIAPlwq/jAA
         msKkaMhwXxxH3Bp6A5bfeaEL4TqfHSVFJBfO22zk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Don't start a timer on an already queued rpc task
Date:   Mon,  6 Apr 2020 15:33:53 -0400
Message-Id: <20200406193353.101924-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Move the test for whether a task is already queued to prevent
corruption of the timer list in __rpc_sleep_on_priority_timeout().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6eff14119a88..7eba20a88438 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -204,10 +204,6 @@ static void __rpc_add_wait_queue(struct rpc_wait_queue *queue,
 		struct rpc_task *task,
 		unsigned char queue_priority)
 {
-	WARN_ON_ONCE(RPC_IS_QUEUED(task));
-	if (RPC_IS_QUEUED(task))
-		return;
-
 	INIT_LIST_HEAD(&task->u.tk_wait.timer_list);
 	if (RPC_IS_PRIORITY(queue))
 		__rpc_add_wait_queue_priority(queue, task, queue_priority);
@@ -382,7 +378,7 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
  * NB: An RPC task will only receive interrupt-driven events as long
  * as it's on a wait queue.
  */
-static void __rpc_sleep_on_priority(struct rpc_wait_queue *q,
+static void __rpc_do_sleep_on_priority(struct rpc_wait_queue *q,
 		struct rpc_task *task,
 		unsigned char queue_priority)
 {
@@ -395,12 +391,23 @@ static void __rpc_sleep_on_priority(struct rpc_wait_queue *q,
 
 }
 
+static void __rpc_sleep_on_priority(struct rpc_wait_queue *q,
+		struct rpc_task *task,
+		unsigned char queue_priority)
+{
+	if (WARN_ON_ONCE(RPC_IS_QUEUED(task)))
+		return;
+	__rpc_do_sleep_on_priority(q, task, queue_priority);
+}
+
 static void __rpc_sleep_on_priority_timeout(struct rpc_wait_queue *q,
 		struct rpc_task *task, unsigned long timeout,
 		unsigned char queue_priority)
 {
+	if (WARN_ON_ONCE(RPC_IS_QUEUED(task)))
+		return;
 	if (time_is_after_jiffies(timeout)) {
-		__rpc_sleep_on_priority(q, task, queue_priority);
+		__rpc_do_sleep_on_priority(q, task, queue_priority);
 		__rpc_add_timer(q, task, timeout);
 	} else
 		task->tk_status = -ETIMEDOUT;
-- 
2.25.2

