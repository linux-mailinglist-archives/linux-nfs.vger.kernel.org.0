Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB15746658
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGDAIG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAIF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C65189
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9476101C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 00:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA8C433C7;
        Tue,  4 Jul 2023 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429283;
        bh=8Ajmxa2wT4fPesgmRnmvkKnHxqn/kb+9NNZidM0+W4o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pywrwgvv4j5tY0kd5D2+HfFbLnuhn8kAR7weUkNiZXLLpugdY7W/zEPcWkSbz9QQu
         e8LXtIwr0KDSTkFRa10uMxPUYPFtzols1PGzRL4Bk53FihB3ngtDdPoUg5JjVIwXO6
         LxXaTUwzMBxapJ1Kuplh4dG6Uv9buPb3z8jzaHp8PtiFFyaJGD6Bt5swvO3+QMdWht
         H+zKV70HNlvmRc1m3Z9t+AvPDrQ9ZV7LAB9QbO7DjrA0F7mMUZ/wt6ukei/SFc+1yn
         AP0QzXP6Vljlp4B2kJpjv5Q3Gy5b2N01YRJ4DKH48BhafPemoioZXFnSp6d8399ozh
         REVMP2bQuSt8g==
Subject: [PATCH v2 5/9] SUNRPC: Clean up svc_set_num_threads
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 03 Jul 2023 20:08:02 -0400
Message-ID: <168842928247.139194.9631504614280555265.stgit@manet.1015granger.net>
In-Reply-To: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Document the API contract and remove stale or obvious comments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   60 +++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ccc7ff3142dd..42d38cd99f29 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -726,23 +726,14 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
 	return NULL;
 }
 
-/*
- * Choose a pool in which to create a new thread, for svc_set_num_threads
- */
-static inline struct svc_pool *
-choose_pool(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
+static struct svc_pool *
+svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 {
-	if (pool != NULL)
-		return pool;
-
-	return &serv->sv_pools[(*state)++ % serv->sv_nrpools];
+	return pool ? pool : &serv->sv_pools[(*state)++ % serv->sv_nrpools];
 }
 
-/*
- * Choose a thread to kill, for svc_set_num_threads
- */
-static inline struct task_struct *
-choose_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
+static struct task_struct *
+svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 {
 	unsigned int i;
 	struct task_struct *task = NULL;
@@ -750,7 +741,6 @@ choose_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 	if (pool != NULL) {
 		spin_lock_bh(&pool->sp_lock);
 	} else {
-		/* choose a pool in round-robin fashion */
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
 			spin_lock_bh(&pool->sp_lock);
@@ -765,21 +755,15 @@ choose_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 	if (!list_empty(&pool->sp_all_threads)) {
 		struct svc_rqst *rqstp;
 
-		/*
-		 * Remove from the pool->sp_all_threads list
-		 * so we don't try to kill it again.
-		 */
 		rqstp = list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_all);
 		set_bit(RQ_VICTIM, &rqstp->rq_flags);
 		list_del_rcu(&rqstp->rq_all);
 		task = rqstp->rq_task;
 	}
 	spin_unlock_bh(&pool->sp_lock);
-
 	return task;
 }
 
-/* create new threads */
 static int
 svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
@@ -791,13 +775,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 
 	do {
 		nrservs--;
-		chosen_pool = choose_pool(serv, pool, &state);
-
+		chosen_pool = svc_pool_next(serv, pool, &state);
 		node = svc_pool_map_get_node(chosen_pool->sp_id);
+
 		rqstp = svc_prepare_thread(serv, chosen_pool, node);
 		if (IS_ERR(rqstp))
 			return PTR_ERR(rqstp);
-
 		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
 					      node, "%s", serv->sv_name);
 		if (IS_ERR(task)) {
@@ -816,15 +799,6 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	return 0;
 }
 
-/*
- * Create or destroy enough new threads to make the number
- * of threads the given number.  If `pool' is non-NULL, applies
- * only to threads in that pool, otherwise round-robins between
- * all pools.  Caller must ensure that mutual exclusion between this and
- * server startup or shutdown.
- */
-
-/* destroy old threads */
 static int
 svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
@@ -832,9 +806,8 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	struct task_struct *task;
 	unsigned int state = serv->sv_nrthreads-1;
 
-	/* destroy old threads */
 	do {
-		task = choose_victim(serv, pool, &state);
+		task = svc_pool_victim(serv, pool, &state);
 		if (task == NULL)
 			break;
 		rqstp = kthread_data(task);
@@ -846,6 +819,23 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	return 0;
 }
 
+/**
+ * svc_set_num_threads - adjust number of threads per RPC service
+ * @serv: RPC service to adjust
+ * @pool: Specific pool from which to choose threads, or NULL
+ * @nrservs: New number of threads for @serv (0 or less means kill all threads)
+ *
+ * Create or destroy threads to make the number of threads for @serv the
+ * given number. If @pool is non-NULL, change only threads in that pool;
+ * otherwise, round-robin between all pools for @serv. @serv's
+ * sv_nrthreads is adjusted for each thread created or destroyed.
+ *
+ * Caller must ensure mutual exclusion between this and server startup or
+ * shutdown.
+ *
+ * Returns zero on success or a negative errno if an error occurred while
+ * starting a thread.
+ */
 int
 svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {


