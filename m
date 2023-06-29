Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24878742BFC
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjF2Smg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjF2Smf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CD2681
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB66615E4
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B0C433C8;
        Thu, 29 Jun 2023 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064151;
        bh=Y7Tjzr9QJE6XOLQMLihT+VYtx/00IbvTy/FXe+QmMww=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UQbJnh1MgCg3uc5vjuv0zgmej8LNCVyUl85eJrpI5Ces53K+OoaDBsFm2RROTndy4
         R1kNlEUdFQF/WK1qRlGTz5FBKFmma4bJ5phKmvo47onRad/Hx+Kp2yoLRJbP6kSBuF
         njIkBduyj2P7GhCRI1SIf5xvtmmgknI/ZEkLAKuvhj5GdxxZJBvhDK9ulKmr7xnRiC
         LF6ojoY3bbaaFkbMvD7Rpb+7SWORO4EPIeeM7J1hHKGu9Xy/aMGQrQw1rs6FpGUQOM
         /P7T8k1zyNr0Scl4KpITEVdMWamp2+6jL2SNBwqXjSGISLGPXdqBHFik6kmmP+JQ2m
         eEpOlJ855o2zw==
Subject: [PATCH RFC 1/8] SUNRPC: Deduplicate thread wake-up code
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:42:30 -0400
Message-ID: <168806415041.1034990.11822594910002824781.stgit@morisot.1015granger.net>
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

Refactor: Extract the loop that finds an idle service thread from
svc_xprt_enqueue() and svc_wake_up().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 +
 net/sunrpc/svc.c           |   28 +++++++++++++++++++++++++++
 net/sunrpc/svc_xprt.c      |   46 +++++++++++++-------------------------------
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f8751118c122..dc2d90a655e2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -427,6 +427,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
+struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
 const char *	   svc_proc_name(const struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 587811a002c9..e81ce5f76abd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -689,6 +689,34 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	return rqstp;
 }
 
+/**
+ * svc_pool_wake_idle_thread - wake an idle thread in @pool
+ * @pool: service thread pool
+ *
+ * Returns an idle service thread (now marked BUSY), or NULL
+ * if no service threads are available. Finding an idle service
+ * thread and marking it BUSY is atomic with respect to other
+ * calls to svc_pool_wake_idle_thread().
+ */
+struct svc_rqst *svc_pool_wake_idle_thread(struct svc_pool *pool)
+{
+	struct svc_rqst	*rqstp;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
+		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
+			continue;
+
+		rcu_read_unlock();
+		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
+		wake_up_process(rqstp->rq_task);
+		percpu_counter_inc(&pool->sp_threads_woken);
+		return rqstp;
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
 /*
  * Choose a pool in which to create a new thread, for svc_set_num_threads
  */
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 62c7919ea610..f14476d11b67 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -455,8 +455,8 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
  */
 void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
+	struct svc_rqst	*rqstp;
 	struct svc_pool *pool;
-	struct svc_rqst	*rqstp = NULL;
 
 	if (!svc_xprt_ready(xprt))
 		return;
@@ -476,20 +476,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
 	spin_unlock_bh(&pool->sp_lock);
 
-	/* find a thread for this xprt */
-	rcu_read_lock();
-	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
-		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
-			continue;
-		percpu_counter_inc(&pool->sp_threads_woken);
-		rqstp->rq_qtime = ktime_get();
-		wake_up_process(rqstp->rq_task);
-		goto out_unlock;
-	}
-	set_bit(SP_CONGESTED, &pool->sp_flags);
-	rqstp = NULL;
-out_unlock:
-	rcu_read_unlock();
+	rqstp = svc_pool_wake_idle_thread(pool);
+	if (!rqstp)
+		set_bit(SP_CONGESTED, &pool->sp_flags);
+
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
@@ -581,7 +571,10 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 	svc_xprt_put(xprt);
 }
 
-/*
+/**
+ * svc_wake_up - Wake up a service thread for non-transport work
+ * @serv: RPC service
+ *
  * Some svc_serv's will have occasional work to do, even when a xprt is not
  * waiting to be serviced. This function is there to "kick" a task in one of
  * those services so that it can wake up and do that work. Note that we only
@@ -590,27 +583,16 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
  */
 void svc_wake_up(struct svc_serv *serv)
 {
+	struct svc_pool *pool = &serv->sv_pools[0];
 	struct svc_rqst	*rqstp;
-	struct svc_pool *pool;
 
-	pool = &serv->sv_pools[0];
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
-		/* skip any that aren't queued */
-		if (test_bit(RQ_BUSY, &rqstp->rq_flags))
-			continue;
-		rcu_read_unlock();
-		wake_up_process(rqstp->rq_task);
-		trace_svc_wake_up(rqstp->rq_task->pid);
+	rqstp = svc_pool_wake_idle_thread(pool);
+	if (!rqstp) {
+		set_bit(SP_TASK_PENDING, &pool->sp_flags);
 		return;
 	}
-	rcu_read_unlock();
 
-	/* No free entries available */
-	set_bit(SP_TASK_PENDING, &pool->sp_flags);
-	smp_wmb();
-	trace_svc_wake_up(0);
+	trace_svc_wake_up(rqstp->rq_task->pid);
 }
 EXPORT_SYMBOL_GPL(svc_wake_up);
 


