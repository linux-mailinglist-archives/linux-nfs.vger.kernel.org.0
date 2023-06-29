Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16690742BFD
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjF2Smp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjF2Smo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF32681
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED19D615E7
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9180C433C8;
        Thu, 29 Jun 2023 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064158;
        bh=1MpJ/jMmBL286yDmYlTszKW+QVO8O2BNdW6hS36K63c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QYDbOAHHhH+EpmQuihg4rM80Tb5w3Ykf9BdJZMWDKcVYOKi+IJnacyiG9q61qHiuM
         r7St13pIjvsImAhy2yHT5diaiemECp7e0LaKHw2ZWhqyWxIcAxEGHJ1DoAQd9ySmas
         w+NKFW8Fu0Z+KPGSc/npTYh3yxqF0bFtaqYJnzrxtwZqYCb6WgLFF/c6aC1ca3WbK8
         aWivujr/q4f8SKhXmJ+GgLzka1kXA/vZa5kqNVnBdAfBto9phfKokjDhvG8Ar1dJCw
         f7TzHbTBBCy7dpkUAW13DGIUNdi4y0L/1Q3w38XxAf29a09IXkpNShEENJac2dcF5i
         0EBUKGGkqf7lg==
Subject: [PATCH RFC 2/8] SUNRPC: Report when no service thread is available.
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:42:37 -0400
Message-ID: <168806415706.1034990.3299102237393518473.stgit@morisot.1015granger.net>
In-Reply-To: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Count and record thread starvation. Administrators can take action
by increasing thread count or decreasing workload.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h    |    5 +++-
 include/trace/events/sunrpc.h |   49 ++++++++++++++++++++++++++++++++++-------
 net/sunrpc/svc.c              |    9 +++++++-
 net/sunrpc/svc_xprt.c         |   21 ++++++++++--------
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dc2d90a655e2..fbfe6ea737c8 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -22,7 +22,6 @@
 #include <linux/pagevec.h>
 
 /*
- *
  * RPC service thread pool.
  *
  * Pool of threads and temporary sockets.  Generally there is only
@@ -42,6 +41,7 @@ struct svc_pool {
 	struct percpu_counter	sp_sockets_queued;
 	struct percpu_counter	sp_threads_woken;
 	struct percpu_counter	sp_threads_timedout;
+	struct percpu_counter	sp_threads_starved;
 
 #define	SP_TASK_PENDING		(0)		/* still work to do even if no
 						 * xprt is queued. */
@@ -427,7 +427,8 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
-struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_pool *pool);
+struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_serv *serv,
+					     struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
 const char *	   svc_proc_name(const struct svc_rqst *rqstp);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 69e42ef30979..9813f4560eef 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1918,21 +1918,21 @@ TRACE_EVENT(svc_xprt_create_err,
 TRACE_EVENT(svc_xprt_enqueue,
 	TP_PROTO(
 		const struct svc_xprt *xprt,
-		const struct svc_rqst *rqst
+		const struct svc_rqst *wakee
 	),
 
-	TP_ARGS(xprt, rqst),
+	TP_ARGS(xprt, wakee),
 
 	TP_STRUCT__entry(
 		SVC_XPRT_ENDPOINT_FIELDS(xprt)
 
-		__field(int, pid)
+		__field(pid_t, pid)
 	),
 
 	TP_fast_assign(
 		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
 
-		__entry->pid = rqst? rqst->rq_task->pid : 0;
+		__entry->pid = wakee->rq_task->pid;
 	),
 
 	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " pid=%d",
@@ -1963,6 +1963,39 @@ TRACE_EVENT(svc_xprt_dequeue,
 		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
 );
 
+#define show_svc_pool_flags(x)						\
+	__print_flags(x, "|",						\
+		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
+		{ BIT(SP_CONGESTED),		"CONGESTED" })
+
+TRACE_EVENT(svc_pool_starved,
+	TP_PROTO(
+		const struct svc_serv *serv,
+		const struct svc_pool *pool
+	),
+
+	TP_ARGS(serv, pool),
+
+	TP_STRUCT__entry(
+		__string(name, serv->sv_name)
+		__field(int, pool_id)
+		__field(unsigned int, nrthreads)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, serv->sv_name);
+		__entry->pool_id = pool->sp_id;
+		__entry->nrthreads = pool->sp_nrthreads;
+		__entry->flags = pool->sp_flags;
+	),
+
+	TP_printk("service=%s pool=%d flags=%s nrthreads=%u",
+		__get_str(name), __entry->pool_id,
+		show_svc_pool_flags(__entry->flags), __entry->nrthreads
+	)
+);
+
 DECLARE_EVENT_CLASS(svc_xprt_event,
 	TP_PROTO(
 		const struct svc_xprt *xprt
@@ -2033,16 +2066,16 @@ TRACE_EVENT(svc_xprt_accept,
 );
 
 TRACE_EVENT(svc_wake_up,
-	TP_PROTO(int pid),
+	TP_PROTO(const struct svc_rqst *wakee),
 
-	TP_ARGS(pid),
+	TP_ARGS(wakee),
 
 	TP_STRUCT__entry(
-		__field(int, pid)
+		__field(pid_t, pid)
 	),
 
 	TP_fast_assign(
-		__entry->pid = pid;
+		__entry->pid = wakee->rq_task->pid;
 	),
 
 	TP_printk("pid=%d", __entry->pid)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e81ce5f76abd..04151e22ec44 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -516,6 +516,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
+		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
 	}
 
 	return serv;
@@ -591,6 +592,7 @@ svc_destroy(struct kref *ref)
 		percpu_counter_destroy(&pool->sp_sockets_queued);
 		percpu_counter_destroy(&pool->sp_threads_woken);
 		percpu_counter_destroy(&pool->sp_threads_timedout);
+		percpu_counter_destroy(&pool->sp_threads_starved);
 	}
 	kfree(serv->sv_pools);
 	kfree(serv);
@@ -691,6 +693,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 /**
  * svc_pool_wake_idle_thread - wake an idle thread in @pool
+ * @serv: RPC service
  * @pool: service thread pool
  *
  * Returns an idle service thread (now marked BUSY), or NULL
@@ -698,7 +701,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
  * thread and marking it BUSY is atomic with respect to other
  * calls to svc_pool_wake_idle_thread().
  */
-struct svc_rqst *svc_pool_wake_idle_thread(struct svc_pool *pool)
+struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
+					   struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 
@@ -714,6 +718,9 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_pool *pool)
 		return rqstp;
 	}
 	rcu_read_unlock();
+
+	trace_svc_pool_starved(serv, pool);
+	percpu_counter_inc(&pool->sp_threads_starved);
 	return NULL;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index f14476d11b67..859eecb7d52c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -455,7 +455,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
  */
 void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
-	struct svc_rqst	*rqstp;
+	struct svc_rqst *rqstp;
 	struct svc_pool *pool;
 
 	if (!svc_xprt_ready(xprt))
@@ -476,9 +476,11 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
 	spin_unlock_bh(&pool->sp_lock);
 
-	rqstp = svc_pool_wake_idle_thread(pool);
-	if (!rqstp)
+	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
+	if (!rqstp) {
 		set_bit(SP_CONGESTED, &pool->sp_flags);
+		return;
+	}
 
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
@@ -584,15 +586,15 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 void svc_wake_up(struct svc_serv *serv)
 {
 	struct svc_pool *pool = &serv->sv_pools[0];
-	struct svc_rqst	*rqstp;
+	struct svc_rqst *rqstp;
 
-	rqstp = svc_pool_wake_idle_thread(pool);
+	rqstp = svc_pool_wake_idle_thread(serv, pool);
 	if (!rqstp) {
 		set_bit(SP_TASK_PENDING, &pool->sp_flags);
 		return;
 	}
 
-	trace_svc_wake_up(rqstp->rq_task->pid);
+	trace_svc_wake_up(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_wake_up);
 
@@ -1434,16 +1436,17 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 	struct svc_pool *pool = p;
 
 	if (p == SEQ_START_TOKEN) {
-		seq_puts(m, "# pool packets-arrived sockets-enqueued threads-woken threads-timedout\n");
+		seq_puts(m, "# pool packets-arrived xprts-enqueued threads-woken threads-timedout starved\n");
 		return 0;
 	}
 
-	seq_printf(m, "%u %llu %llu %llu %llu\n",
+	seq_printf(m, "%u %llu %llu %llu %llu %llu\n",
 		pool->sp_id,
 		percpu_counter_sum_positive(&pool->sp_sockets_queued),
 		percpu_counter_sum_positive(&pool->sp_sockets_queued),
 		percpu_counter_sum_positive(&pool->sp_threads_woken),
-		percpu_counter_sum_positive(&pool->sp_threads_timedout));
+		percpu_counter_sum_positive(&pool->sp_threads_timedout),
+		percpu_counter_sum_positive(&pool->sp_threads_starved));
 
 	return 0;
 }


