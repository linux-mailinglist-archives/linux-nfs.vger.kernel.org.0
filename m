Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E974DB58
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGJQmk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGJQmj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3981180
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 502066101E
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CCC433C7;
        Mon, 10 Jul 2023 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007354;
        bh=xe3T/z5HwAy1RnUi4f9GXor1QkLrb5tcWJETBoFq88I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lcgXl0lHYX2Ue8rvjO8Re1erqlxLNZrsGRkMRyvFRYV4ZpOHjTgBV6AASl6t7+md0
         9RLxkA0RFImwDfkbBpfEv8TIncFv/bNU4O85ie+eaNC3kbP9okwVeKRtLnHcn6mfbD
         gl5aT0fwRLynRtjY5AN+99ReLPHQaKgBWooh4Zq+HOvaaun7hLOAYNFdvz22Qfbzu6
         hb38d7PonlINBBtFEWIu/WfFIoJG051KLemvztB2RGVcQ8JiGi+yq17OLICnFv5Oqc
         DqPZfXqh/RmC+zIaKPBgEq06sW8fJv0AW8qqXc+nzhr9oAK3TNf7mUAvVhXKb7wpTs
         JAstn15YH22iA==
Subject: [PATCH v3 6/9] SUNRPC: Clean up svc_set_num_threads
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 10 Jul 2023 12:42:33 -0400
Message-ID: <168900735334.7514.10614943419985083955.stgit@manet.1015granger.net>
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

Document the API contract and remove stale or obvious comments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   60 +++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b7a02309ecb1..b02a672aaada 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -728,23 +728,14 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
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
@@ -752,7 +743,6 @@ choose_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 	if (pool != NULL) {
 		spin_lock_bh(&pool->sp_lock);
 	} else {
-		/* choose a pool in round-robin fashion */
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
 			spin_lock_bh(&pool->sp_lock);
@@ -767,21 +757,15 @@ choose_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
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
@@ -793,13 +777,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 
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
@@ -818,15 +801,6 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
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
@@ -834,9 +808,8 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	struct task_struct *task;
 	unsigned int state = serv->sv_nrthreads-1;
 
-	/* destroy old threads */
 	do {
-		task = choose_victim(serv, pool, &state);
+		task = svc_pool_victim(serv, pool, &state);
 		if (task == NULL)
 			break;
 		rqstp = kthread_data(task);
@@ -848,6 +821,23 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
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


