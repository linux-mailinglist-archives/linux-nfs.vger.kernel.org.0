Return-Path: <linux-nfs+bounces-17513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A10CFA6D1
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6998300EE55
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1D311979;
	Tue,  6 Jan 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSnB+vsI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AC35503D;
	Tue,  6 Jan 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726013; cv=none; b=hqgAk8vAm9YNMjloI5mxXZofLszB/bghw/Qu9z35+1l82raR5OW6ohh3RPdEM7QUXz/Dvl3fo0KwAY6hctqkR9DIBsL4IH9eRZhX7Op72rauHNJgF5JgTGGJ4boeKtsO4VQL/6lyLdT9qohAxofdJKGo6TkmZAnRr1nla3zCL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726013; c=relaxed/simple;
	bh=hiX+bkSdi2uINKKWz6B9r7w+t+Ck41tRQRxUbAeY3jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gP1rVbOiuxtDuYlTSS/wsHXGR3tZpiIYc2S5sIwIukHWpb2Lwr7Ot2mNS1hSuHDF4qdyESpvuWoK5ff+REV/CvfgaT0OjLR1sGJvIOBxlT2CJwY7lQM7mV4iDhf0BDq6I+z4HshsoSx0q7ViLNG72QUXfkthEiX665Mx6OoweN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSnB+vsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70393C116C6;
	Tue,  6 Jan 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726013;
	bh=hiX+bkSdi2uINKKWz6B9r7w+t+Ck41tRQRxUbAeY3jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mSnB+vsI5nVoeW6PkxKsMKzCCH0Pl8tO47IpZIx+MkGC2OXqRSM2ovFMKo9enl+aP
	 YcBd8+ktOZLlGI8fWmD1rpz+NeymPsIgVsTHburun+tLWBYwvynHu2qeH7rKf3LmuY
	 GZxhfe/wDom52g583g+Tt4qvPcBtQDJ+bf78aMg8kT7fRqQBFnshgPOdC0HakGm52E
	 LEqj0InBSRYJnR9QHFqbODelsKdycvbrOpS7EoQ25z2/as9GaHoExOy4HlnqJlYAYK
	 T17ha1kVrH45AE0wloHk+yBLU9YIccqrRjbNhWB7xJtOtRVpiC/qZajbY6SYjH6SSE
	 uryTL7TYPIyCA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:48 -0500
Subject: [PATCH v2 6/8] sunrpc: allow svc_recv() to return -ETIMEDOUT and
 -EBUSY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-6-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7011; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hiX+bkSdi2uINKKWz6B9r7w+t+Ck41tRQRxUbAeY3jg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVu0BR1fdIpVJNeG7M/MErbCXhW3vw1hYnKY6
 JX//i8TZLSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1btAAKCRAADmhBGVaC
 FVk2EADEJ90PReaZT5p7kRCfu4kun3UQIgZwdrstfSkL/FSZv4gb5eUV22/CE0aZefchNpRFg7t
 p49CeEXT58byG3TcGeI7jOl1wHZYDC2d9A7d+kABJi9gMlhMQtQnj1Yps8yl5Wah7tV0LxlwDVJ
 U0vNP4Mz4V3Ol4KqikfhJzXgg3jYKnm8Pmf0XTw3F3sc1uXSaIurRMzVRF/UQzyRFOwKSfSdqLC
 Y2eDyJjuNEy6BLnYAgDOlwVDWE3r06efeHBU/gU0CXHyuxa0x+r3fAtbBll1THEtUA65gPPB92d
 PiUrTLQKWc6OTrN4SWC5KGCAUevnZD3X8vprZcOwMkCwdkcR/prPXyOXJTpdbetVegLhKRFoo6B
 vDxPB0QNcywSJhqjqSMdE+0bgDw0P56d0cpTYQQP7Lnn/R8utiuwGcxU4PhJsaidootrXpS+KEp
 Y9sbDQt/5XMs+YeZMtjbAQSSruN6n7NO5FosnzcfNAsWqg9W1O0siALBGgalsxv36CN4nX9zn4t
 EWHfXZcl+1Ldja8QDbRBAPZTwOT91Pohf40QXj+F9v3AGx2qT00joeJuURPWektkv0x9L8BGP9t
 k4Gq6Mx5VZJ03VHVVIxEXwF9ybbGkIMvN4LOldXTTl7vJi0e4guLk7SQuVHhpMEff/2VKIPJOrL
 +2XFA6niWSDKkgA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

To dynamically adjust the thread count, nfsd requires some information
about how busy things are.

Change svc_recv() to take a timeout value, and then allow the wait for
work to time out if it's set. If a timeout is not defined, then the
schedule will be set to MAX_SCHEDULE_TIMEOUT. If the task waits for the
full timeout, then have it return -ETIMEDOUT to the caller.

If it wakes up, finds that there is more work and that no threads are
available, then attempt to set SP_TASK_STARTING. If wasn't already set,
have the task return -EBUSY to cue to the caller that the service could
use more threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc.c                 |  2 +-
 fs/nfs/callback.c              |  2 +-
 fs/nfsd/nfssvc.c               |  2 +-
 include/linux/sunrpc/svc.h     |  1 +
 include/linux/sunrpc/svcsock.h |  2 +-
 net/sunrpc/svc_xprt.c          | 44 +++++++++++++++++++++++++++++++++---------
 6 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index e2a1b12272f564392bf8d5379e6a25852ca1431b..dcd80c4e74c94564f0ab7b74df4d37a802ac414c 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -141,7 +141,7 @@ lockd(void *vrqstp)
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
 		nlmsvc_retry_blocked(rqstp);
-		svc_recv(rqstp);
+		svc_recv(rqstp, 0);
 	}
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 6889818138e3a553ab55ce22293a8c87541d042d..701a9ac7363ec7699b46394ef809972c62f75680 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -81,7 +81,7 @@ nfs4_callback_svc(void *vrqstp)
 	set_freezable();
 
 	while (!svc_thread_should_stop(rqstp))
-		svc_recv(rqstp);
+		svc_recv(rqstp, 0);
 
 	svc_exit_thread(rqstp);
 	return 0;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1b3a143e0b29603e594f8dbb1f88a20b99b67e8c..e3f647efc4c7b7b329bbd88899090ce070539aa7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -902,7 +902,7 @@ nfsd(void *vrqstp)
 	 * The main request loop
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
-		svc_recv(rqstp);
+		svc_recv(rqstp, 0);
 		nfsd_file_net_dispose(nn);
 	}
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b55ed8404a9e9863cecfe1f29d79fcc426d6f31c..4dc14c7a711b010473bf03fc401df0e66d9aa4bd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -55,6 +55,7 @@ enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
+	SP_TASK_STARTING,	/* Task has started but not added to idle yet */
 };
 
 
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index de37069aba90899be19b1090e6e90e509a3cf530..372a00882ca62e106a1cc6f8199d2957c5e1c21e 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -61,7 +61,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
 /*
  * Function prototypes.
  */
-void		svc_recv(struct svc_rqst *rqstp);
+int		svc_recv(struct svc_rqst *rqstp, long timeo);
 void		svc_send(struct svc_rqst *rqstp);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6973184ff6675211b4338fac80105894e9c8d4df..e504f12100890583a79ac56577df1189b4ac213e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -714,15 +714,21 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
+static bool svc_schedule_timeout(long timeo)
+{
+	return schedule_timeout(timeo ? timeo : MAX_SCHEDULE_TIMEOUT) == 0;
+}
+
+static bool svc_thread_wait_for_work(struct svc_rqst *rqstp, long timeo)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_timeout = false;
 
 	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 		if (likely(svc_thread_should_sleep(rqstp)))
-			schedule();
+			did_timeout = svc_schedule_timeout(timeo);
 
 		while (!llist_del_first_this(&pool->sp_idle_threads,
 					     &rqstp->rq_idle)) {
@@ -734,7 +740,7 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 			 * for this new work.  This thread can safely sleep
 			 * until woken again.
 			 */
-			schedule();
+			did_timeout = svc_schedule_timeout(timeo);
 			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
 		__set_current_state(TASK_RUNNING);
@@ -742,6 +748,7 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 		cond_resched();
 	}
 	try_to_freeze();
+	return did_timeout;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -835,25 +842,38 @@ static void svc_thread_wake_next(struct svc_rqst *rqstp)
 /**
  * svc_recv - Receive and process the next request on any transport
  * @rqstp: an idle RPC service thread
+ * @timeo: timeout (in jiffies) (0 means infinite timeout)
  *
  * This code is carefully organised not to touch any cachelines in
  * the shared svc_serv structure, only cachelines in the local
  * svc_pool.
+ *
+ * If the timeout is 0, then the sleep will never time out.
+ *
+ * Returns -ETIMEDOUT if idle for an extended period
+ *         -EBUSY is there is more work to do than available threads
+ *         0 otherwise.
  */
-void svc_recv(struct svc_rqst *rqstp)
+int svc_recv(struct svc_rqst *rqstp, long timeo)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_timeout;
+	int ret = 0;
 
 	if (!svc_alloc_arg(rqstp))
-		return;
+		return ret;
 
-	svc_thread_wait_for_work(rqstp);
+	did_timeout = svc_thread_wait_for_work(rqstp, timeo);
+
+	if (did_timeout && svc_thread_should_sleep(rqstp) &&
+	    pool->sp_nrthrmin && pool->sp_nrthreads > pool->sp_nrthrmin)
+		ret = -ETIMEDOUT;
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
 	if (svc_thread_should_stop(rqstp)) {
 		svc_thread_wake_next(rqstp);
-		return;
+		return ret;
 	}
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
@@ -865,10 +885,15 @@ void svc_recv(struct svc_rqst *rqstp)
 		 * cache information to be provided.  When there are no
 		 * idle threads, we reduce the wait time.
 		 */
-		if (pool->sp_idle_threads.first)
+		if (pool->sp_idle_threads.first) {
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
-		else
+		} else {
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
+			if (!did_timeout && timeo &&
+			    !test_and_set_bit(SP_TASK_STARTING,
+					      &pool->sp_flags))
+				ret = -EBUSY;
+		}
 
 		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
@@ -887,6 +912,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		}
 	}
 #endif
+	return ret;
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 

-- 
2.52.0


