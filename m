Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1296742C06
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjF2SnS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2SnR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60732681
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D53B5615E2
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71EEC433C0;
        Thu, 29 Jun 2023 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064191;
        bh=eVPnCR2LLHYXWqkpa3VekDVPIf7iShqKQ2Na5GMgkmI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gliwww1XCqj6Am+PKPVuRg+XsRhad3cTZVB2OogvO4PA9W1XoaZRzcJpeqa0bS/WU
         IDiaOZyUkTULbE7lwr1MXW7jXsYCuRM9GE49hTNzhbZGWagP5DLNKqoO/qaJ51xA0h
         /hbx+Gy7dQzoM2lw2D6msgzQb4l1hAius0BCMHjf3WwX3j65/KkG1plOQNlqxbOL+u
         UrgpOxnASWn/M694Yu5rFijgY4RAMCJekG8lKoHydKXTXnr+n1A/4Qli2juiO4M6To
         qDJgdS/eCwuVfuW48dCGe3X+DhUDup2MkExyYrUH27n5et6KZ97LE+yieVmcemE2zf
         V8mOj/E3YEGpw==
Subject: [PATCH RFC 7/8] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:43:09 -0400
Message-ID: <168806418985.1034990.14686512686720974159.stgit@morisot.1015granger.net>
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

I've noticed that server request latency goes up simply when the
nfsd thread count is increased.

List walking is known to be memory-inefficient. On a busy server
with many threads, enqueuing a transport will walk the "all threads"
list quite frequently. This also pulls in the cache lines for some
hot fields in each svc_rqst.

The svc_xprt_enqueue() call that concerns me most is the one in
svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
down completion handling will limit the total throughput per
RDMA connection.

So, avoid walking the "all threads" list to find an idle thread to
wake. Instead, set up an idle bitmap and use find_next_bit, which
should work the same way as RQ_BUSY but it will touch only the
cacheline that the bitmap is in. I think we can stick with atomic
bit operations here to avoid taking the pool lock.

The server can keep track of up to 64 threads in just one unsigned
long, and the bitmap can be multiple words long to handle even more
threads.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h    |    6 ++++--
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/svc.c              |   38 ++++++++++++++++++++++++++------------
 net/sunrpc/svc_xprt.c         |   23 +++++++++++++++++++----
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 45aa7648dca6..ffa58a7a689d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -35,6 +35,7 @@ struct svc_pool {
 	spinlock_t		sp_lock;	/* protects sp_sockets */
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
+	unsigned long		*sp_idle_map;	/* idle threads */
 	struct xarray		sp_thread_xa;
 
 	/* statistics on pool operation */
@@ -189,6 +190,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+#define RPCSVC_MAXPOOLTHREADS	(256)
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
@@ -238,8 +241,7 @@ struct svc_rqst {
 #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
 						 * to prevent encrypting page
 						 * cache pages */
-#define	RQ_BUSY		(5)			/* request is busy */
-#define	RQ_DATA		(6)			/* request has data */
+#define	RQ_DATA		(5)			/* request has data */
 	unsigned long		rq_flags;	/* flags field */
 	u32			rq_thread_id;	/* xarray index */
 	ktime_t			rq_qtime;	/* enqueue time */
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 4ec746048f15..f64c255975ab 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1600,7 +1600,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
 	svc_rqst_flag(USEDEFERRAL)					\
 	svc_rqst_flag(DROPME)						\
 	svc_rqst_flag(SPLICE_OK)					\
-	svc_rqst_flag(BUSY)						\
 	svc_rqst_flag_end(DATA)
 
 #undef svc_rqst_flag
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 18fbb98895ea..c2cba61a890c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		spin_lock_init(&pool->sp_lock);
 		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
+		/* All threads initially marked "busy" */
+		pool->sp_idle_map =
+			bitmap_zalloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
+					   svc_pool_map_get_node(i));
+		if (!pool->sp_idle_map)
+			return NULL;
 
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
@@ -594,6 +600,8 @@ svc_destroy(struct kref *ref)
 		percpu_counter_destroy(&pool->sp_threads_starved);
 
 		xa_destroy(&pool->sp_thread_xa);
+		bitmap_free(pool->sp_idle_map);
+		pool->sp_idle_map = NULL;
 	}
 	kfree(serv->sv_pools);
 	kfree(serv);
@@ -645,7 +653,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	__set_bit(RQ_BUSY, &rqstp->rq_flags);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -675,7 +682,7 @@ static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	static const struct xa_limit limit = {
-		.max = UINT_MAX,
+		.max = RPCSVC_MAXPOOLTHREADS,
 	};
 	struct svc_rqst	*rqstp;
 	int ret;
@@ -720,18 +727,24 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
 					   struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
-	unsigned long index;
+	unsigned long bit;
 
-	xa_for_each(&pool->sp_thread_xa, index, rqstp) {
-		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
-			continue;
+	bit = 0;
+	do {
+		bit = find_next_bit(pool->sp_idle_map, pool->sp_nrthreads, bit);
+		if (bit == pool->sp_nrthreads)
+			goto out_starved;
+	} while (!test_and_clear_bit(bit, pool->sp_idle_map));
 
-		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
-		wake_up_process(rqstp->rq_task);
-		percpu_counter_inc(&pool->sp_threads_woken);
-		return rqstp;
-	}
+	rqstp = xa_find(&pool->sp_thread_xa, &bit, bit, XA_PRESENT);
+	if (!rqstp)
+		goto out_starved;
+	WRITE_ONCE(rqstp->rq_qtime, ktime_get());
+	wake_up_process(rqstp->rq_task);
+	percpu_counter_inc(&pool->sp_threads_woken);
+	return rqstp;
 
+out_starved:
 	trace_svc_pool_starved(serv, pool);
 	percpu_counter_inc(&pool->sp_threads_starved);
 	return NULL;
@@ -765,7 +778,8 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
 	}
 
 found_pool:
-	rqstp = xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
+	rqstp = xa_find(&pool->sp_thread_xa, &zero, RPCSVC_MAXPOOLTHREADS,
+			XA_PRESENT);
 	if (rqstp) {
 		__xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
 		task = rqstp->rq_task;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 77fc20b2181d..e22f1432aabb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -734,6 +734,18 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
+static void svc_rqst_mark_idle(struct svc_rqst *rqstp)
+{
+	set_bit(rqstp->rq_thread_id, rqstp->rq_pool->sp_idle_map);
+	smp_mb__after_atomic();
+}
+
+static void svc_rqst_mark_busy(struct svc_rqst *rqstp)
+{
+	clear_bit(rqstp->rq_thread_id, rqstp->rq_pool->sp_idle_map);
+	smp_mb__after_atomic();
+}
+
 static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
@@ -755,8 +767,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	set_current_state(TASK_INTERRUPTIBLE);
 	smp_mb__before_atomic();
 	clear_bit(SP_CONGESTED, &pool->sp_flags);
-	clear_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
+	svc_rqst_mark_idle(rqstp);
 
 	if (likely(rqst_should_sleep(rqstp)))
 		time_left = schedule_timeout(timeout);
@@ -765,8 +776,12 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 
 	try_to_freeze();
 
-	set_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
+	/* Post-sleep: look for more work.
+	 *
+	 * Note: If we were awoken, then this rqstp has already
+	 * been marked busy.
+	 */
+	svc_rqst_mark_busy(rqstp);
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
 		trace_svc_pool_awoken(pool, rqstp);


