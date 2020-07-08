Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E921913C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGHUKs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHUKr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B341C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:47 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m9so21124472qvx.5
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OqH0yu2xM2MQXSlls3Xuz9r1lbkDWWgka8P/83kPWa0=;
        b=OmkPCdwaiMPSPuIPLsQGsedJyh2ggcKosCwOwl1Tyy+WhYdix5gXBobHXSUiygsjmk
         5b19mdIpni+LLHVy/zC2PebOMIjAHd+0Au+D97N1jVkGIkudLF6ZflzuksG5YOeJi+07
         tceRiFZhvOfebZF69dw0vE7Iw6BMt9B2ZKlA7v2DPHa6MrXmQIamV6E6Ub/oA5tbS6N2
         udh6QnZyUNVNoZtQM4nv9NX84gDUXHSJ9jvlYuq1pB3YCK/1NI7pPno7AlFBpS3WLKa6
         Xb0GECJTw31zeJ+NMxqus1JfyW24SLIUCHp1iCxmQW4T/i/2B8gLK4QQGImj9tV44HLe
         TScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OqH0yu2xM2MQXSlls3Xuz9r1lbkDWWgka8P/83kPWa0=;
        b=WGdfQ+CeLIsqf6uwc7+jA6m4Ybn3ChumJTQveRsWzxoPx7ZdfKkbZSeKcpYXaIbm5B
         roy66YiTgEmUuFd6keFDpaxrshDiWWgvRK4B0CPpph5YcRv0CHEsjlPhSygZlcLxbuem
         GjYVZjRfVRyWzLfIhSyOkvcNaOU8/IiA/ExacQd54hvyuIgT5fTUR+t04LuoI2lzCEH1
         beaBbrDOuHrbVooRDmdv6ykW2RXCCkkdIsUCLYj7r6hhTWA68JxY27rl3mNhOzD22bZL
         S8YNqMvqB8Bx7N4PcixHZEpcZXvBvToLIDJAw4m+lmajgmuP/BPg5q3FUOV2QgrKQ3hx
         FdIA==
X-Gm-Message-State: AOAM532GHd1OhJxqHO+idIE+Dv8bwXNc4QnjVoPZJphiu4EbP9iQ/kev
        2/hlQ9VTt8Up1ZtoXx0ukXqrKK4g
X-Google-Smtp-Source: ABdhPJwJizEWx6uVN2XAcRuI/1DQEJXoCuMP3jma85YYC9XsXlXWz2vpZlyRbQvlsTrZ3tW+9wFnow==
X-Received: by 2002:a0c:e551:: with SMTP id n17mr55495938qvm.151.1594239046718;
        Wed, 08 Jul 2020 13:10:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m26sm852602qtc.83.2020.07.08.13.10.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:46 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAjoR006134
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:45 GMT
Subject: [PATCH v1 20/22] SUNRPC: Clean up RPC scheduler tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:45 -0400
Message-ID: <20200708201045.22129.93054.stgit@manet.1015granger.net>
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

Remove several redundant dprintk call sites, and replace a couple of
potentially useful ones with tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    2 ++
 net/sunrpc/sched.c            |   15 +++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 9177520b55a8..abd55e88440d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -387,6 +387,8 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 
 DEFINE_RPC_RUNNING_EVENT(begin);
 DEFINE_RPC_RUNNING_EVENT(run_action);
+DEFINE_RPC_RUNNING_EVENT(sync_sleep);
+DEFINE_RPC_RUNNING_EVENT(sync_wake);
 DEFINE_RPC_RUNNING_EVENT(complete);
 DEFINE_RPC_RUNNING_EVENT(signalled);
 DEFINE_RPC_RUNNING_EVENT(end);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 402b1c8869fd..a0d5a98fbf32 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -885,9 +885,6 @@ static void __rpc_execute(struct rpc_task *task)
 	int task_is_async = RPC_IS_ASYNC(task);
 	int status = 0;
 
-	dprintk("RPC: %5u __rpc_execute flags=0x%x\n",
-			task->tk_pid, task->tk_flags);
-
 	WARN_ON_ONCE(RPC_IS_QUEUED(task));
 	if (RPC_IS_QUEUED(task))
 		return;
@@ -947,7 +944,7 @@ static void __rpc_execute(struct rpc_task *task)
 			return;
 
 		/* sync task: sleep here */
-		dprintk("RPC: %5u sync task going to sleep\n", task->tk_pid);
+		trace_rpc_task_sync_sleep(task, task->tk_action);
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_killable,
 				TASK_KILLABLE);
@@ -963,11 +960,9 @@ static void __rpc_execute(struct rpc_task *task)
 			task->tk_rpc_status = -ERESTARTSYS;
 			rpc_exit(task, -ERESTARTSYS);
 		}
-		dprintk("RPC: %5u sync task resuming\n", task->tk_pid);
+		trace_rpc_task_sync_wake(task, task->tk_action);
 	}
 
-	dprintk("RPC: %5u return %d, status %d\n", task->tk_pid, status,
-			task->tk_status);
 	/* Release all resources associated with the task */
 	rpc_release_task(task);
 }
@@ -1146,10 +1141,8 @@ static void rpc_free_task(struct rpc_task *task)
 	put_rpccred(task->tk_op_cred);
 	rpc_release_calldata(task->tk_ops, task->tk_calldata);
 
-	if (tk_flags & RPC_TASK_DYNAMIC) {
-		dprintk("RPC: %5u freeing task\n", task->tk_pid);
+	if (tk_flags & RPC_TASK_DYNAMIC)
 		mempool_free(task, rpc_task_mempool);
-	}
 }
 
 static void rpc_async_release(struct work_struct *work)
@@ -1203,8 +1196,6 @@ EXPORT_SYMBOL_GPL(rpc_put_task_async);
 
 static void rpc_release_task(struct rpc_task *task)
 {
-	dprintk("RPC: %5u release task\n", task->tk_pid);
-
 	WARN_ON_ONCE(RPC_IS_QUEUED(task));
 
 	rpc_release_resources_task(task);

