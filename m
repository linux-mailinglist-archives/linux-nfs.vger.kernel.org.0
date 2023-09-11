Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492879BAB4
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbjIKWAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbjIKOkP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:40:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1DF2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:40:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F14C433CA;
        Mon, 11 Sep 2023 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443210;
        bh=kNEf5h+FKaz30mccV4GhAxgjeiPK/ymMnsOA8BQjZlo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J8u2wmIMnS0yse4HXn+3PAE7chW71wfEDjcCOTI2C16mrsMVStsz2bt7c+QO6tfT+
         DKSRnsEb800MLAYnKTtP5E9UU72Ry3PGKnlVl728gwABvxxMV9vd6Ti4pIStgQQ17v
         /TFpJIad/5bXDwO2W81v8tyTODAyhDR9Ol4qdrWB1aXGtRTwM1arBYt5cQRHorjhJi
         5UAeNgFNcaWkdeRUzGlL/LrJhNLU+/aS6ROS1Nw6Gkl5bqFd0ftBopiF3gtSMQzeSK
         FpciGgjXk3j7+dkEJeSx7evSxXzZYccUP4uO1XRm6yVtPhaba8CZ6/+i1buE04yW0B
         xiLJN+bH7fg+w==
Subject: [PATCH v1 15/17] SUNRPC: change sp_nrthreads to atomic_t
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:40:09 -0400
Message-ID: <169444320932.4327.14002153670307589805.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

Using an atomic_t avoids the need to take a spinlock (which can soon be
removed).

Choosing a thread to kill needs to be careful as we cannot set the "die
now" bit atomically with the test on the count.  Instead we temporarily
increase the count.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           |   11 +++++------
 include/linux/sunrpc/svc.h |    2 +-
 net/sunrpc/svc.c           |   37 ++++++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 062f51fe4dfb..fafd2960dfaf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -713,14 +713,13 @@ int nfsd_nrpools(struct net *net)
 
 int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 {
-	int i = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+	int i;
 
-	if (nn->nfsd_serv != NULL) {
-		for (i = 0; i < nn->nfsd_serv->sv_nrpools && i < n; i++)
-			nthreads[i] = nn->nfsd_serv->sv_pools[i].sp_nrthreads;
-	}
-
+	if (serv)
+		for (i = 0; i < serv->sv_nrpools && i < n; i++)
+			nthreads[i] = atomic_read(&serv->sv_pools[i].sp_nrthreads);
 	return 0;
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 7ff9fe785e49..9d0fcd6148ae 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,7 +36,7 @@ struct svc_pool {
 	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
 	spinlock_t		sp_lock;	/* protects all fields */
 	struct lwq		sp_xprts;	/* pending transports */
-	unsigned int		sp_nrthreads;	/* # of threads in pool */
+	atomic_t		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 244b5b9eba4d..0928d3f918b0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -681,8 +681,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
 
+	atomic_inc(&pool->sp_nrthreads);
 	spin_lock_bh(&pool->sp_lock);
-	pool->sp_nrthreads++;
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
 	spin_unlock_bh(&pool->sp_lock);
 	return rqstp;
@@ -727,23 +727,24 @@ svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 }
 
 static struct svc_pool *
-svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
+svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
+		unsigned int *state)
 {
+	struct svc_pool *pool;
 	unsigned int i;
 
+retry:
+	pool = target_pool;
+
 	if (pool != NULL) {
-		spin_lock_bh(&pool->sp_lock);
-		if (pool->sp_nrthreads)
+		if (atomic_inc_not_zero(&pool->sp_nrthreads))
 			goto found_pool;
-		spin_unlock_bh(&pool->sp_lock);
 		return NULL;
 	} else {
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
-			spin_lock_bh(&pool->sp_lock);
-			if (pool->sp_nrthreads)
+			if (atomic_inc_not_zero(&pool->sp_nrthreads))
 				goto found_pool;
-			spin_unlock_bh(&pool->sp_lock);
 		}
 		return NULL;
 	}
@@ -751,8 +752,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
 found_pool:
 	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
 	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	spin_unlock_bh(&pool->sp_lock);
-	return pool;
+	if (!atomic_dec_and_test(&pool->sp_nrthreads))
+		return pool;
+	/* Nothing left in this pool any more */
+	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
+	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+	goto retry;
 }
 
 static int
@@ -828,13 +833,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 int
 svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
-	if (pool == NULL) {
+	if (!pool)
 		nrservs -= serv->sv_nrthreads;
-	} else {
-		spin_lock_bh(&pool->sp_lock);
-		nrservs -= pool->sp_nrthreads;
-		spin_unlock_bh(&pool->sp_lock);
-	}
+	else
+		nrservs -= atomic_read(&pool->sp_nrthreads);
 
 	if (nrservs > 0)
 		return svc_start_kthreads(serv, pool, nrservs);
@@ -921,10 +923,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	struct svc_pool	*pool = rqstp->rq_pool;
 
 	spin_lock_bh(&pool->sp_lock);
-	pool->sp_nrthreads--;
 	list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	atomic_dec(&pool->sp_nrthreads);
+
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
 	spin_unlock_bh(&serv->sv_lock);


