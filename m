Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883479BD1A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbjIKV66 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbjIKOjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100BBCF0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE2BC433CB;
        Mon, 11 Sep 2023 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443139;
        bh=7WU6i0lHeQzb20klg8dvOfKEisbErnRK/CDZLxLX6gw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dQ1QGq4NYjMbmbsdp1UFCIt7VsdoWuFW35IBX+EVv0myxwznZ1cAXWxoOw3JLNzap
         gX3X7b1UPX+wP0ildSJD9kOZsIu/pzI5qDNMprp7ETRqnC6suJqrlENeBZ0kPw0QcX
         ssz7phWyelVHRj1KRG5EO5/Mj45XbJ1O4XuI5OdA0CHSvpqQrCmquyidu98Wq2PECF
         NV0KZM7/6xZ35RPvML78s+7zwYOKtdA01pT1kuP5dV6aQWh360aQRr8bh8f8HEjj7K
         uKPmP8JdOWhISauhOJfr5vs0k1zKPGPOQLRCDWAEtioPWJt2/l1K3t7yxlCS5/41GH
         NDfrcRU11CfeA==
Subject: [PATCH v1 04/17] SUNRPC: integrate back-channel processing with
 svc_recv()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:38:58 -0400
Message-ID: <169444313840.4327.16112579899380992132.stgit@bazille.1015granger.net>
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

Using svc_recv() for (NFSv4.1) back-channel handling means we have just
one mechanism for waking threads.

Also change kthread_freezable_should_stop() in nfs4_callback_svc() to
kthread_should_stop() as used elsewhere.
kthread_freezable_should_stop() effectively adds a try_to_freeze() call,
and svc_recv() already contains that at an appropriate place.

Signed-off-by: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback.c                 |   42 ++-----------------------------------
 include/linux/sunrpc/svc.h        |    2 --
 net/sunrpc/backchannel_rqst.c     |    8 +++----
 net/sunrpc/svc.c                  |    2 +-
 net/sunrpc/svc_xprt.c             |   27 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/backchannel.c |    2 +-
 6 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 272e6d2bb478..42a0c2f1e785 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
 
 	set_freezable();
 
-	while (!kthread_freezable_should_stop(NULL))
+	while (!kthread_should_stop())
 		svc_recv(rqstp);
 
 	svc_exit_thread(rqstp);
@@ -86,41 +86,6 @@ nfs4_callback_svc(void *vrqstp)
 }
 
 #if defined(CONFIG_NFS_V4_1)
-/*
- * The callback service for NFSv4.1 callbacks
- */
-static int
-nfs41_callback_svc(void *vrqstp)
-{
-	struct svc_rqst *rqstp = vrqstp;
-	struct svc_serv *serv = rqstp->rq_server;
-	struct rpc_rqst *req;
-	DEFINE_WAIT(wq);
-
-	set_freezable();
-
-	while (!kthread_freezable_should_stop(NULL)) {
-		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
-		spin_lock_bh(&serv->sv_cb_lock);
-		if (!list_empty(&serv->sv_cb_list)) {
-			req = list_first_entry(&serv->sv_cb_list,
-					struct rpc_rqst, rq_bc_list);
-			list_del(&req->rq_bc_list);
-			spin_unlock_bh(&serv->sv_cb_lock);
-			finish_wait(&serv->sv_cb_waitq, &wq);
-			svc_process_bc(req, rqstp);
-		} else {
-			spin_unlock_bh(&serv->sv_cb_lock);
-			if (!kthread_should_stop())
-				schedule();
-			finish_wait(&serv->sv_cb_waitq, &wq);
-		}
-	}
-
-	svc_exit_thread(rqstp);
-	return 0;
-}
-
 static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xprt *xprt,
 		struct svc_serv *serv)
 {
@@ -233,10 +198,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 			cb_info->users);
 
 	threadfn = nfs4_callback_svc;
-#if defined(CONFIG_NFS_V4_1)
-	if (minorversion)
-		threadfn = nfs41_callback_svc;
-#else
+#if !defined(CONFIG_NFS_V4_1)
 	if (minorversion)
 		return ERR_PTR(-ENOTSUPP);
 #endif
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0cdca5960171..acbe1314febd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -92,8 +92,6 @@ struct svc_serv {
 						 * that arrive over the same
 						 * connection */
 	spinlock_t		sv_cb_lock;	/* protects the svc_cb_list */
-	wait_queue_head_t	sv_cb_waitq;	/* sleep here if there are no
-						 * entries in the svc_cb_list */
 	bool			sv_bc_enabled;	/* service uses backchannel */
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 65a6c6429a53..44b7c89a635f 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -349,10 +349,8 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
 }
 
 /*
- * Add callback request to callback list.  The callback
- * service sleeps on the sv_cb_waitq waiting for new
- * requests.  Wake it up after adding enqueing the
- * request.
+ * Add callback request to callback list.  Wake a thread
+ * on the first pool (usually the only pool) to handle it.
  */
 void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 {
@@ -371,6 +369,6 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 	xprt_get(xprt);
 	spin_lock(&bc_serv->sv_cb_lock);
 	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
-	wake_up(&bc_serv->sv_cb_waitq);
 	spin_unlock(&bc_serv->sv_cb_lock);
+	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a3d031deb1ec..b98a159eb17f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -440,7 +440,6 @@ __svc_init_bc(struct svc_serv *serv)
 {
 	INIT_LIST_HEAD(&serv->sv_cb_list);
 	spin_lock_init(&serv->sv_cb_lock);
-	init_waitqueue_head(&serv->sv_cb_waitq);
 }
 #else
 static void
@@ -718,6 +717,7 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 
 	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
+EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
 static struct svc_pool *
 svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 835160da3ad4..b057f1cbe7a1 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/sunrpc/bc_xprt.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <trace/events/sunrpc.h>
@@ -719,6 +720,13 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	if (freezing(current))
 		return false;
 
+#if defined(CONFIG_SUNRPC_BACKCHANNEL)
+	if (svc_is_backchannel(rqstp)) {
+		if (!list_empty(&rqstp->rq_server->sv_cb_list))
+			return false;
+	}
+#endif
+
 	return true;
 }
 
@@ -868,6 +876,25 @@ void svc_recv(struct svc_rqst *rqstp)
 		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
 	}
+
+#if defined(CONFIG_SUNRPC_BACKCHANNEL)
+	if (svc_is_backchannel(rqstp)) {
+		struct svc_serv *serv = rqstp->rq_server;
+		struct rpc_rqst *req;
+
+		spin_lock_bh(&serv->sv_cb_lock);
+		req = list_first_entry_or_null(&serv->sv_cb_list,
+					       struct rpc_rqst, rq_bc_list);
+		if (req) {
+			list_del(&req->rq_bc_list);
+			spin_unlock_bh(&serv->sv_cb_lock);
+
+			svc_process_bc(req, rqstp);
+			return;
+		}
+		spin_unlock_bh(&serv->sv_cb_lock);
+	}
+#endif
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index e4d84a13c566..bfc434ec52a7 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -267,7 +267,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
 	spin_unlock(&bc_serv->sv_cb_lock);
 
-	wake_up(&bc_serv->sv_cb_waitq);
+	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
 
 	r_xprt->rx_stats.bcall_count++;
 	return;


