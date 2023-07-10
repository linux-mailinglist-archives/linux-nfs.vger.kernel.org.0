Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C174DB52
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGJQmR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGJQmQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B99AD
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89BD761124
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DFDC433C8;
        Mon, 10 Jul 2023 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007335;
        bh=6tgxkoGwbdPWA2kjPEvno7uq9F/lgC1ObR+QkLawEUc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ecKq7pFKDiFwIPqhhEETrV2RGneR7uRkLs3apDVw4XI343XTOPtW+PfX52pSKL6da
         EuDFxX1ZPiViJFifA+c0qBu1Dh9+qOPF3Pz2H5/xxHYNSP7GxzbezifAh8FAAVNsaC
         gpZ7cm6vmiXouooj/JxjSEqkbMT5sHyFF8I1Wl7HS9zHrRzlbMi70kQ3wCLOyFdUlK
         Fn2rz2urEKJ4lF0VGvfvpImzSGAADeSVebfqKDEQfY1bX9P2pnwJx0zKMfK/hQaN28
         3Tij76G9os9MPoQDlT6CdV2RvLERizJXAVtzG0sE9JQ3u3koZZ9AmBIA1kUWsfFBTP
         5nBxiT3Nssbsg==
Subject: [PATCH v3 3/9] SUNRPC: Split the svc_xprt_dequeue tracepoint
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 10 Jul 2023 12:42:13 -0400
Message-ID: <168900733359.7514.13132763975249250052.stgit@manet.1015granger.net>
In-Reply-To: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Distinguish between the case where new work was picked up just by
looking at the transport queue versus when the thread was awoken.
This gives us better visibility about how well-utilized the thread
pool is.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   47 +++++++++++++++++++++++++++++++----------
 net/sunrpc/svc_xprt.c         |    9 +++++---
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 9b70fc1c698a..2e83887b58cd 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2015,34 +2015,57 @@ TRACE_EVENT(svc_xprt_enqueue,
 		SVC_XPRT_ENDPOINT_VARARGS, __entry->pid)
 );
 
-TRACE_EVENT(svc_xprt_dequeue,
+#define show_svc_pool_flags(x)						\
+	__print_flags(x, "|",						\
+		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
+		{ BIT(SP_CONGESTED),		"CONGESTED" })
+
+DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
 	TP_PROTO(
-		const struct svc_rqst *rqst
+		const struct svc_rqst *rqstp
 	),
 
-	TP_ARGS(rqst),
+	TP_ARGS(rqstp),
 
 	TP_STRUCT__entry(
-		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
+		SVC_XPRT_ENDPOINT_FIELDS(rqstp->rq_xprt)
 
+		__string(name, rqstp->rq_server->sv_name)
+		__field(int, pool_id)
+		__field(unsigned int, nrthreads)
+		__field(unsigned long, pool_flags)
 		__field(unsigned long, wakeup)
 	),
 
 	TP_fast_assign(
-		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
+		struct svc_pool *pool = rqstp->rq_pool;
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqstp->rq_xprt);
 
+		__assign_str(name, rqstp->rq_server->sv_name);
+		__entry->pool_id = pool->sp_id;
+		__entry->nrthreads = pool->sp_nrthreads;
+		__entry->pool_flags = pool->sp_flags;
 		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
-							rqst->rq_qtime));
+							rqstp->rq_qtime));
 	),
 
-	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu",
-		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT
+		" service=%s pool=%d pool_flags=%s nrthreads=%u wakeup-us=%lu",
+		SVC_XPRT_ENDPOINT_VARARGS, __get_str(name), __entry->pool_id,
+		show_svc_pool_flags(__entry->pool_flags), __entry->nrthreads,
+		__entry->wakeup
+	)
 );
 
-#define show_svc_pool_flags(x)						\
-	__print_flags(x, "|",						\
-		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
-		{ BIT(SP_CONGESTED),		"CONGESTED" })
+#define DEFINE_SVC_POOL_SCHEDULER_EVENT(name) \
+	DEFINE_EVENT(svc_pool_scheduler_class, svc_pool_##name, \
+			TP_PROTO( \
+				const struct svc_rqst *rqstp \
+			), \
+			TP_ARGS(rqstp))
+
+DEFINE_SVC_POOL_SCHEDULER_EVENT(polled);
+DEFINE_SVC_POOL_SCHEDULER_EVENT(awoken);
 
 TRACE_EVENT(svc_pool_starved,
 	TP_PROTO(
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index a1ed6fb69793..7ee095d03996 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -744,8 +744,10 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	WARN_ON_ONCE(rqstp->rq_xprt);
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
+	if (rqstp->rq_xprt) {
+		trace_svc_pool_polled(rqstp);
 		goto out_found;
+	}
 
 	/*
 	 * We have to be able to interrupt this wait
@@ -767,8 +769,10 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	set_bit(RQ_BUSY, &rqstp->rq_flags);
 	smp_mb__after_atomic();
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
+	if (rqstp->rq_xprt) {
+		trace_svc_pool_awoken(rqstp);
 		goto out_found;
+	}
 
 	if (!time_left)
 		percpu_counter_inc(&pool->sp_threads_timedout);
@@ -784,7 +788,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;
-	trace_svc_xprt_dequeue(rqstp);
 	return rqstp->rq_xprt;
 }
 


