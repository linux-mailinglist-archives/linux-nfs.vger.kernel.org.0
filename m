Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65B51AC4B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 May 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbiEDSJl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376540AbiEDSIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 14:08:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020C728EB
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 10:24:14 -0700 (PDT)
Date:   Wed, 4 May 2022 19:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651685052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=b42BHq6iN5FP/ilq5bCMnXAimKtyonLO0OYG/TFLC6Y=;
        b=YJ7uwzCnsH+YgQ/EY/nywdC+u04vvoK25SOhU7RqKigcACoNDt59sFUFQ2B5Y7WiyirBfF
        TpWwSGePlDFIvle6C0KNU66n4lGBpLLNNfWLTkO6STmvS19Ici1N7JSyANCAVd7wGC0kDu
        drBsN0hahglqCsvP9tajhznJsiiUDh5VKQYWKhWdMALuHUH+vrIHn7ZdabPxGJ0TWCcfdS
        UAiqcl5QMjNU6pTDF871CMAYDqz955fwj2tRGedcyqIaRmQ1C8pd6Gm0mLTPQq1hA9B+y/
        LjPOaQ/6hA0L7YkEl57WlJlBSMtcgavwyHIZMiL7k/R3FIu2HhT9yjLUG1xE0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651685052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=b42BHq6iN5FP/ilq5bCMnXAimKtyonLO0OYG/TFLC6Y=;
        b=TylMcOQKhgJ7HiUnkkHjU25jXq/phVigrWEzpoQc+FTfquXoMZkiuKluFV9/idqmDFOs1C
        aOSdIBB5l5+98aBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Message-ID: <YnK2ujabd2+oCrT/@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_xprt_enqueue() disables preemption via get_cpu() and then asks for a
pool of a specific CPU (current) via svc_pool_for_cpu().
With disabled preemption it acquires svc_pool::sp_lock, a spinlock_t,
which is a sleeping lock on PREEMPT_RT and can't be acquired with
disabled preemption.

Disabling preemption is not required here. The pool is protected with a
lock so the following list access is safe even cross-CPU. The following
iteration through svc_pool::sp_all_threads is under RCU-readlock and
remaining operations within the loop are atomic and do not rely on
disabled-preemption.

Use raw_smp_processor_id() as the argument for the requested CPU in
svc_pool_for_cpu().

Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/sunrpc/svc_xprt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5b59e2103526e..79965deec5b12 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -448,7 +448,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
 	struct svc_pool *pool;
 	struct svc_rqst	*rqstp = NULL;
-	int cpu;
 
 	if (!svc_xprt_ready(xprt))
 		return;
@@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
 		return;
 
-	cpu = get_cpu();
-	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
+	pool = svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());
 
 	atomic_long_inc(&pool->sp_stats.packets);
 
@@ -485,7 +483,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	rqstp = NULL;
 out_unlock:
 	rcu_read_unlock();
-	put_cpu();
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
-- 
2.36.0

