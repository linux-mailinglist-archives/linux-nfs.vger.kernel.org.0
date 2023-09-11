Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3179B54C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbjIKV72 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbjIKOkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:40:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A0F2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:40:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D203C433C8;
        Mon, 11 Sep 2023 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443216;
        bh=Ai480t/3SwwLNBnhSvyapM3a6jL9nKabKQKqcJjSK4Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jhVAX4qEm7lkK1AfFvXov6IV+sLi2bbidA+HPDJJfHK2jj6jxIrRHoMIhGlE8gtp5
         AHihJdJzc7MD93+rjtuLMGQKHeex2+fn4Fj9HHrzBKRUIDdHBjiETJvtB2ITSHKaDJ
         KatOqhUcpbLgoBR2WLrncckO0WiO7OVrunmJVNlG8YNb019vy0SMNukdlTTOxjdyE1
         LdA1beVNfqZOP8ytcF1uVzZBq5d2dSs4OadoLeR9bZ6TXM9aq4NrDmL6KW45Ms1ulO
         zj6UMvuhlun55Yl6UV2Dd5QHGtsuzlyb3HLC1hM83skTr2l57XJHsOGLfXSWTmOdrp
         H3WO1IIoiFtVw==
Subject: [PATCH v1 16/17] SUNRPC: discard sp_lock
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:40:15 -0400
Message-ID: <169444321574.4327.17665916502497811650.stgit@bazille.1015granger.net>
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

sp_lock is now only used to protect sp_all_threads.  This isn't needed
as sp_all_threads is only manipulated through svc_set_num_threads(),
which is already serialized.  Read-acccess only requires rcu_read_lock().
So no more locking is needed.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 -
 net/sunrpc/svc.c           |   10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 9d0fcd6148ae..8ce1392c1a35 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -34,7 +34,6 @@
  */
 struct svc_pool {
 	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
-	spinlock_t		sp_lock;	/* protects all fields */
 	struct lwq		sp_xprts;	/* pending transports */
 	atomic_t		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0928d3f918b0..efe7a58ccbdc 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -511,7 +511,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		lwq_init(&pool->sp_xprts);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		init_llist_head(&pool->sp_idle_threads);
-		spin_lock_init(&pool->sp_lock);
 
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
@@ -682,9 +681,12 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	spin_unlock_bh(&serv->sv_lock);
 
 	atomic_inc(&pool->sp_nrthreads);
-	spin_lock_bh(&pool->sp_lock);
+
+	/* Protected by whatever lock the service uses when calling
+	 * svc_set_num_threads()
+	 */
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
-	spin_unlock_bh(&pool->sp_lock);
+
 	return rqstp;
 }
 
@@ -922,9 +924,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	struct svc_serv	*serv = rqstp->rq_server;
 	struct svc_pool	*pool = rqstp->rq_pool;
 
-	spin_lock_bh(&pool->sp_lock);
 	list_del_rcu(&rqstp->rq_all);
-	spin_unlock_bh(&pool->sp_lock);
 
 	atomic_dec(&pool->sp_nrthreads);
 


