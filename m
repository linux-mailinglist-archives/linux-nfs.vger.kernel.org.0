Return-Path: <linux-nfs+bounces-9826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08944A24BB8
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B75A7A2463
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72D1CB518;
	Sat,  1 Feb 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI2NqKYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E41CC881
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440004; cv=none; b=TzeutieY5OP1gq8A25VDNY+vyRRFGkLrpJApcfmSLz0Oy87ZRvPpZX/JdIfmvIoTR0FhCZJEfl+j8abPLKY4NcHJ5nL8mVlfnb/LtNnlYTbwsWbtlvJHV9063NIIPM4v5/HE0VVei/IezWVf/3gIprzLs5HGuEQeEOVMh6Ba51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440004; c=relaxed/simple;
	bh=3BrkU+X0syuLjt/C4NGrcOc925m1K8QX+KwESIksBew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zjno76SaVqhil48aCgUtr8wVBKTVwxL71BZUO7lrn5S2Q5c4xQYfyyyyhrbiJ7oSsqv0e2BYMDoC12AvVOvwEoyz4kA6D2iCS4vG6dAWaZKbzNlAl37sV3Gay5Nj2TOW73P8PHF8x2mWbG18PQGiYIhUAVg5/PgwTXbdAzkAumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI2NqKYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C008C4CED3;
	Sat,  1 Feb 2025 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738440003;
	bh=3BrkU+X0syuLjt/C4NGrcOc925m1K8QX+KwESIksBew=;
	h=From:To:Cc:Subject:Date:From;
	b=QI2NqKYta0QkyorYpnfifV68NGeWyVuGHgauZAfK1QJHx2crjnEoPA2gZe3hSIDDI
	 +hYUBm2IEX0gMgeCYlxan5bVrzB37vl0J4sb/9Adu5hNZL1vA+5G5KEwAjVrjPFCYS
	 ZKK9wnQMgzXW6kybi/YOaVVQAOh+abWHvARVQVdx9cRosmFcZK11nuREcB19/Sy3lf
	 XPI2/YvVUA0T3r6lyc+lMu62nDelNUwSPFsNniQEtFrXnhAP+epSfktev/QkiG62Mz
	 AyHkTK4DFgqw5Kp2VffVrAAJd9f1wdEnFxbem/jgG+c8+be5mX1+1VwzpTRy5fJk0B
	 1IYr1mdzxRlzg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH] SUNRPC: Prevent looping due to rpc_signal_task() races
Date: Sat,  1 Feb 2025 15:00:02 -0500
Message-ID: <69b6cd8f9689e84e1db8eb7e5da46946015dd1b5.1738439878.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If rpc_signal_task() is called while a task is in an rpc_call_done()
callback function, and the latter calls rpc_restart_call(), the task can
end up looping due to the RPC_TASK_SIGNALLED flag being set without the
tk_rpc_status being set.
Removing the redundant mechanism for signalling the task fixes the
looping behaviour.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 39494194f93b ("SUNRPC: Fix races with rpc_killall_tasks()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h  | 3 +--
 include/trace/events/sunrpc.h | 3 +--
 net/sunrpc/sched.c            | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index fec1e8a1570c..eac57914dcf3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -158,7 +158,6 @@ enum {
 	RPC_TASK_NEED_XMIT,
 	RPC_TASK_NEED_RECV,
 	RPC_TASK_MSG_PIN_WAIT,
-	RPC_TASK_SIGNALLED,
 };
 
 #define rpc_test_and_set_running(t) \
@@ -171,7 +170,7 @@ enum {
 
 #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
 
-#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
+#define RPC_SIGNALLED(t)	(READ_ONCE(task->tk_rpc_status) == -ERESTARTSYS)
 
 /*
  * Task priorities.
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b13dc275ef4a..851841336ee6 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -360,8 +360,7 @@ TRACE_EVENT(rpc_request,
 		{ (1UL << RPC_TASK_ACTIVE), "ACTIVE" },			\
 		{ (1UL << RPC_TASK_NEED_XMIT), "NEED_XMIT" },		\
 		{ (1UL << RPC_TASK_NEED_RECV), "NEED_RECV" },		\
-		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" },	\
-		{ (1UL << RPC_TASK_SIGNALLED), "SIGNALLED" })
+		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" })
 
 DECLARE_EVENT_CLASS(rpc_task_running,
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cef623ea1506..9b45fbdc90ca 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -864,8 +864,6 @@ void rpc_signal_task(struct rpc_task *task)
 	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
 		return;
 	trace_rpc_task_signalled(task, task->tk_action);
-	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
-	smp_mb__after_atomic();
 	queue = READ_ONCE(task->tk_waitqueue);
 	if (queue)
 		rpc_wake_up_queued_task(queue, task);
-- 
2.48.1


