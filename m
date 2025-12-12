Return-Path: <linux-nfs+bounces-17063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5448CCB9F88
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE4D30E67D9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832B2DC765;
	Fri, 12 Dec 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC5cu3Xq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05B2D9496;
	Fri, 12 Dec 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579192; cv=none; b=X21JTm8IIXJIQcq7hLea7mwo33B2O8hUS61eG6HRJHe7gcigUhfFVHRgK74nfvRyUer0dZaHiDlD1TsDrxTpuqBRxni5coExltwYEEFuIdIpoz0hj/FPPJoTU/POmVN/9EbbUKwj3nDMow4hSYAoI3xjT5nkatYqOVFVPpVIy+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579192; c=relaxed/simple;
	bh=X1FzereqmkvvyyWDhOqhN108ue/fvWDPvdFvAdVnD88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSjdzg/JmOH9jShuo2b+PPxTJ+tJmpHRBN+49XXTyqM+zB1Yy1ZaWiSFdwXxyojuyPLKlOpBFLyg4ruzKRmAjfO6zx7viL9y525k0wsyr97V/epf5AvUvMrKDAQYQ+YOUNa4WDVb0b//uA1h0micGVQp0z+7TdvPjzu0ztcXhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC5cu3Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09617C4CEF1;
	Fri, 12 Dec 2025 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579192;
	bh=X1FzereqmkvvyyWDhOqhN108ue/fvWDPvdFvAdVnD88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vC5cu3XqX2Hs6WtMCl72r7to39Yl99kQUbwLA5+tJdu5ymE9srf4YLOcmK/e7lUKf
	 Gi5x2HiFjLPt6mBS6o4lej+/A/l7rdG9s4LH88fpk331sv/nl5CvCsXvEmGFPQ6Tar
	 ap1KfwJ5soQsKaFjwHt2lZ+yhzMA0fPpbf1GwsETwip5K4yBVo0U90Hzl2Cz+iflvh
	 u8jdphj7yOygFVHxaBk29OOKQMyFwiklizOGxOPUg/fBjm6ocP4EyK5qLiJoGqKDWN
	 EwD4UtScXkmaqA+pMiP5uo4zqHBPGnderXwbPlWG0ldPLwoa+KLq5r658Q7dPgA+a3
	 svJWNq2Nq8n1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 13 Dec 2025 07:39:17 +0900
Subject: [PATCH RFC 5/6] nfsd: adjust number of running nfsd threads based
 on activity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-nfsd-dynathread-v1-5-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
In-Reply-To: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13016; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X1FzereqmkvvyyWDhOqhN108ue/fvWDPvdFvAdVnD88=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPJmoayEQidBV0q+/kqx27IdjWfbzX+0u8wwkv
 /yMVlrXxUmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTyZqAAKCRAADmhBGVaC
 FcrbEACLIHbFz/A8b3rQtJ7Ftw9qDnz7hrRkT/wS+UIFwDP9u6oeOesz3aHqYCD/4AB0cR/aRy6
 Lc/1z5FBdGHEwkmeVT0J05zOCe4sPtXwRO/k7/XZfwH2LwG0l0JTNLGkkMLw4z+ohQZVRuaaJDp
 /7Sw4EJ9TouvaHMOKQnM9iLB9D8hzRVavHahu6LuMMs0GoUwvvaaUqUgS/JBPQzc3MoIByZF1ki
 xKsIJAgMxzTC+JLxgj0w+aCf2Iadqg/R4lHhgbX19RFwFPs7t5RMbK6uF9PzG97h7LuKchx9hX9
 pUYbWNhSpLTMufPxqTDFDZN5JWyCHJS2NhpqPmEg8bmpYHWlT0dJUki6FOa604A/Zs7vvCFBnzo
 elzZIGKIril/L3P5B5ljqGlaaQHIhyY6LaStmQ+YCiJc/L9zFH0sqdhckFl1deCEEyCLXGko3un
 vTUmh1T8lLAduWB8SyTbCXHh4Jd1Mes0r/aJ1a7hwElgloSC+XVnbsgYXZQwdJA8mYAKQg04DsX
 3eRBIqp/BmHrw3ymdkxrV51fweRqP9mmYvyl/8HmjJgOM/Gu23rzFgzlu5bEQW4vE0ub5wxHEsH
 RpWYiCAOYn4cJYfpvVO4G6snAmJlaEDquVA4qLxk+evHMv24mRznRPxiaEmFm0qzg3rlIZyNljE
 PWRHf55XU5aOOXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch is based on a draft patch by Neil:

svc_recv() is changed to return a status.  This can be:

 -ETIMEDOUT - waited for 5 seconds and found nothing to do.  This is
          boring.  Also there are more actual threads than really
          needed.
 -EBUSY - I did something, but there is more stuff to do and no one
          idle who I can wake up to do it.
          BTW I successful set a flag: SP_TASK_STARTING.  You better
          clear it.
 0 - just minding my own business, nothing to see here.

nfsd() is changed to pay attention to this status.  In the case of
-ETIMEDOUT, if the service mutex can be taken (trylock), the thread
becomes and RQ_VICTIM so that it will exit.  In the case of -EBUSY, if
the actual number of threads is below the calculated maximum, a new
thread is started.  SP_TASK_STARTING is cleared.

To support the above, some code is split out of svc_start_kthreads()
into svc_new_thread().

I think we want memory pressure to be able to push a thread into
returning -ETIMEDOUT.  That can come later.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c               | 35 ++++++++++++++++++++-
 fs/nfsd/trace.h                | 35 +++++++++++++++++++++
 include/linux/sunrpc/svc.h     |  2 ++
 include/linux/sunrpc/svcsock.h |  2 +-
 net/sunrpc/svc.c               | 69 ++++++++++++++++++++++++------------------
 net/sunrpc/svc_xprt.c          | 45 ++++++++++++++++++++++-----
 6 files changed, 148 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 993ed338764b0ccd7bdfb76bd6fbb5dc6ab4022d..26c3a6cb1f400f1b757d26f6ba77e27deb7e8ee2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -896,9 +896,11 @@ static int
 nfsd(void *vrqstp)
 {
 	struct svc_rqst *rqstp = (struct svc_rqst *) vrqstp;
+	struct svc_pool *pool = rqstp->rq_pool;
 	struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
 	struct net *net = perm_sock->xpt_net;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool have_mutex = false;
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
@@ -916,7 +918,36 @@ nfsd(void *vrqstp)
 	 * The main request loop
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
-		svc_recv(rqstp);
+		switch (svc_recv(rqstp)) {
+		case -ETIMEDOUT: /* Nothing to do */
+			if (mutex_trylock(&nfsd_mutex)) {
+				if (pool->sp_nrthreads > pool->sp_nrthrmin) {
+					trace_nfsd_dynthread_kill(net, pool);
+					set_bit(RQ_VICTIM, &rqstp->rq_flags);
+					have_mutex = true;
+				} else
+					mutex_unlock(&nfsd_mutex);
+			} else {
+				trace_nfsd_dynthread_trylock_fail(net, pool);
+			}
+			break;
+		case -EBUSY: /* Too much to do */
+			if (pool->sp_nrthreads < pool->sp_nrthrmax &&
+			    mutex_trylock(&nfsd_mutex)) {
+				// check no idle threads?
+				if (pool->sp_nrthreads < pool->sp_nrthrmax) {
+					trace_nfsd_dynthread_start(net, pool);
+					svc_new_thread(rqstp->rq_server, pool);
+				}
+				mutex_unlock(&nfsd_mutex);
+			} else {
+				trace_nfsd_dynthread_trylock_fail(net, pool);
+			}
+			clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+			break;
+		default:
+			break;
+		}
 		nfsd_file_net_dispose(nn);
 	}
 
@@ -924,6 +955,8 @@ nfsd(void *vrqstp)
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
+	if (have_mutex)
+		mutex_unlock(&nfsd_mutex);
 	return 0;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ae2a611e57f4b4e51a4d9eb6e0fccb66ad8d288..8885fd9bead98ebf55379d68ab9c3701981a5150 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -91,6 +91,41 @@ DEFINE_EVENT(nfsd_xdr_err_class, nfsd_##name##_err, \
 DEFINE_NFSD_XDR_ERR_EVENT(garbage_args);
 DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 
+DECLARE_EVENT_CLASS(nfsd_dynthread_class,
+	TP_PROTO(
+		const struct net *net,
+		const struct svc_pool *pool
+	),
+	TP_ARGS(net, pool),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(unsigned int, pool_id)
+		__field(unsigned int, nrthreads)
+		__field(unsigned int, nrthrmin)
+		__field(unsigned int, nrthrmax)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->pool_id = pool->sp_id;
+		__entry->nrthreads = pool->sp_nrthreads;
+		__entry->nrthrmin = pool->sp_nrthrmin;
+		__entry->nrthrmax = pool->sp_nrthrmax;
+	),
+	TP_printk("pool=%u nrthreads=%u nrthrmin=%u nrthrmax=%u",
+		__entry->pool_id, __entry->nrthreads,
+		__entry->nrthrmin, __entry->nrthrmax
+	)
+);
+
+#define DEFINE_NFSD_DYNTHREAD_EVENT(name) \
+DEFINE_EVENT(nfsd_dynthread_class, nfsd_dynthread_##name, \
+	TP_PROTO(const struct net *net, const struct svc_pool *pool), \
+	TP_ARGS(net, pool))
+
+DEFINE_NFSD_DYNTHREAD_EVENT(start);
+DEFINE_NFSD_DYNTHREAD_EVENT(kill);
+DEFINE_NFSD_DYNTHREAD_EVENT(trylock_fail);
+
 #define show_nfsd_may_flags(x)						\
 	__print_flags(x, "|",						\
 		{ NFSD_MAY_EXEC,		"EXEC" },		\
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 35bd3247764ae8dc5dcdfffeea36f7cfefd13372..f47e19c9bd9466986438766e9ab7b4c71cda1ba6 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -55,6 +55,7 @@ enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
+	SP_TASK_STARTING,	/* Task has started but not added to idle yet */
 };
 
 
@@ -442,6 +443,7 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
+int		   svc_new_thread(struct svc_serv *serv, struct svc_pool *pool);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     unsigned int nprog,
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index de37069aba90899be19b1090e6e90e509a3cf530..5c87d3fedd33e7edf5ade32e60523cae7e9ebaba 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -61,7 +61,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
 /*
  * Function prototypes.
  */
-void		svc_recv(struct svc_rqst *rqstp);
+int		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dc818158f8529b62dcf96c91bd9a9d4ab21df91f..9fca2dd340037f82baa4936766ebe0e38c3f0d85 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -714,9 +714,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
-	serv->sv_nrthreads += 1;
-	pool->sp_nrthreads += 1;
-
 	/* Protected by whatever lock the service uses when calling
 	 * svc_set_num_threads()
 	 */
@@ -763,45 +760,57 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
-static int
-svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 	struct task_struct *task;
 	int node;
 	int err;
 
-	do {
-		nrservs--;
-		node = svc_pool_map_get_node(pool->sp_id);
-
-		rqstp = svc_prepare_thread(serv, pool, node);
-		if (!rqstp)
-			return -ENOMEM;
-		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
-					      node, "%s", serv->sv_name);
-		if (IS_ERR(task)) {
-			svc_exit_thread(rqstp);
-			return PTR_ERR(task);
-		}
+	node = svc_pool_map_get_node(pool->sp_id);
 
-		rqstp->rq_task = task;
-		if (serv->sv_nrpools > 1)
-			svc_pool_map_set_cpumask(task, pool->sp_id);
+	rqstp = svc_prepare_thread(serv, pool, node);
+	if (!rqstp)
+		return -ENOMEM;
+	set_bit(SP_TASK_STARTING, &pool->sp_flags);
+	task = kthread_create_on_node(serv->sv_threadfn, rqstp,
+				      node, "%s", serv->sv_name);
+	if (IS_ERR(task)) {
+		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+		svc_exit_thread(rqstp);
+		return PTR_ERR(task);
+	}
 
-		svc_sock_update_bufs(serv);
-		wake_up_process(task);
+	serv->sv_nrthreads += 1;
+	pool->sp_nrthreads += 1;
 
-		wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
-		err = rqstp->rq_err;
-		if (err) {
-			svc_exit_thread(rqstp);
-			return err;
-		}
-	} while (nrservs > 0);
+	rqstp->rq_task = task;
+	if (serv->sv_nrpools > 1)
+		svc_pool_map_set_cpumask(task, pool->sp_id);
 
+	svc_sock_update_bufs(serv);
+	wake_up_process(task);
+
+	wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
+	err = rqstp->rq_err;
+	if (err) {
+		svc_exit_thread(rqstp);
+		return err;
+	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(svc_new_thread);
+
+static int
+svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+{
+	int err = 0;
+
+	while (!err && nrservs--)
+		err = svc_new_thread(serv, pool);
+
+	return err;
+}
 
 static int
 svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6973184ff6675211b4338fac80105894e9c8d4df..9612334300c8dae38720a0f5c61c0f505432ec2f 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -714,15 +714,22 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
+static bool nfsd_schedule_timeout(long timeout)
+{
+	return schedule_timeout(timeout) == 0;
+}
+
+static bool svc_thread_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_timeout = false;
 
 	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
 		if (likely(svc_thread_should_sleep(rqstp)))
-			schedule();
+			did_timeout = nfsd_schedule_timeout(5 * HZ);
 
 		while (!llist_del_first_this(&pool->sp_idle_threads,
 					     &rqstp->rq_idle)) {
@@ -734,7 +741,10 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 			 * for this new work.  This thread can safely sleep
 			 * until woken again.
 			 */
-			schedule();
+			if (did_timeout)
+				did_timeout = nfsd_schedule_timeout(HZ);
+			else
+				did_timeout = nfsd_schedule_timeout(5 * HZ);
 			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
 		__set_current_state(TASK_RUNNING);
@@ -742,6 +752,7 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 		cond_resched();
 	}
 	try_to_freeze();
+	return did_timeout;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -825,6 +836,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 
 static void svc_thread_wake_next(struct svc_rqst *rqstp)
 {
+	clear_bit(SP_TASK_STARTING, &rqstp->rq_pool->sp_flags);
+
 	if (!svc_thread_should_sleep(rqstp))
 		/* More work pending after I dequeued some,
 		 * wake another worker
@@ -839,21 +852,31 @@ static void svc_thread_wake_next(struct svc_rqst *rqstp)
  * This code is carefully organised not to touch any cachelines in
  * the shared svc_serv structure, only cachelines in the local
  * svc_pool.
+ *
+ * Returns -ETIMEDOUT if idle for an extended period
+ *         -EBUSY is there is more work to do than available threads
+ *         0 otherwise.
  */
-void svc_recv(struct svc_rqst *rqstp)
+int svc_recv(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_wait;
+	int ret = 0;
 
 	if (!svc_alloc_arg(rqstp))
-		return;
+		return ret;
+
+	did_wait = svc_thread_wait_for_work(rqstp);
 
-	svc_thread_wait_for_work(rqstp);
+	if (did_wait && svc_thread_should_sleep(rqstp) &&
+	    pool->sp_nrthrmin && (pool->sp_nrthreads > pool->sp_nrthrmin))
+		ret = -ETIMEDOUT;
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
 	if (svc_thread_should_stop(rqstp)) {
 		svc_thread_wake_next(rqstp);
-		return;
+		return ret;
 	}
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
@@ -867,8 +890,13 @@ void svc_recv(struct svc_rqst *rqstp)
 		 */
 		if (pool->sp_idle_threads.first)
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
-		else
+		else {
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
+			if (!did_wait &&
+			    !test_and_set_bit(SP_TASK_STARTING,
+					      &pool->sp_flags))
+				ret = -EBUSY;
+		}
 
 		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
@@ -887,6 +915,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		}
 	}
 #endif
+	return ret;
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 

-- 
2.52.0


