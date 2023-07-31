Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A03768C5A
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGaGwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGaGwN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:52:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BA10CA
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:52:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86DE722427;
        Mon, 31 Jul 2023 06:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQgQJSRc2CCkM0dN63vIqD+yShPtjyvWxE+ziqGK80k=;
        b=DsQEP77D8guozOLeJyN9IyO+uhg0QyGv/Sa0rUzyfRLhQjaOQ7xkunx+MnXNGWMQTYE9rx
        eNKjnsHb/wJQUl+Wve0Hxzj3RSz2+Fxgqd39vqm5opiOy1XiQo/gaKiQpuh5urwKaujCop
        DsbWdWKQXDw7eohJcrir1eNxWCTqf+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQgQJSRc2CCkM0dN63vIqD+yShPtjyvWxE+ziqGK80k=;
        b=DVQ5oBjJ8leZp3f2Rvi6jxqwpKj/YPIPZgRrs9SRdZPKPXYw/7+28RRorkxUHoykNrCBns
        AJmaGkFyG3ukdVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4476E1322C;
        Mon, 31 Jul 2023 06:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0d28ORdax2QDcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:52:07 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/12] SUNRPC: integrate back-channel processing with svc_recv()
Date:   Mon, 31 Jul 2023 16:48:36 +1000
Message-Id: <20230731064839.7729-10-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using svc_recv() for (NFSv4.1) back-channel handling means we have just
one mechanism for waking threads.

Also change kthread_freezable_should_stop() in nfs4_callback_svc() to
kthread_should_stop() as used elsewhere.
kthread_freezable_should_stop() effectively adds a try_to_freeze() call,
and svc_recv() already contains that at an appropriate place.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c                 | 46 ++-----------------------------
 include/linux/sunrpc/svc.h        |  2 --
 net/sunrpc/backchannel_rqst.c     |  8 ++----
 net/sunrpc/svc.c                  |  2 +-
 net/sunrpc/svc_xprt.c             | 32 +++++++++++++++++++++
 net/sunrpc/xprtrdma/backchannel.c |  2 +-
 6 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 466ebf1d41b2..42a0c2f1e785 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
 
 	set_freezable();
 
-	while (!kthread_freezable_should_stop(NULL))
+	while (!kthread_should_stop())
 		svc_recv(rqstp);
 
 	svc_exit_thread(rqstp);
@@ -86,45 +86,6 @@ nfs4_callback_svc(void *vrqstp)
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
-	int error;
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
-			dprintk("Invoking bc_svc_process()\n");
-			error = bc_svc_process(serv, req, rqstp);
-			dprintk("bc_svc_process() returned w/ error code= %d\n",
-				error);
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
@@ -237,10 +198,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
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
index db3de4ea33f9..a3f1916937b4 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -93,8 +93,6 @@ struct svc_serv {
 						 * that arrive over the same
 						 * connection */
 	spinlock_t		sv_cb_lock;	/* protects the svc_cb_list */
-	wait_queue_head_t	sv_cb_waitq;	/* sleep here if there are no
-						 * entries in the svc_cb_list */
 	bool			sv_bc_enabled;	/* service uses backchannel */
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 65a6c6429a53..60b8d310bb27 100644
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
+	svc_pool_wake_idle_thread(bc_serv, &bc_serv->sv_pools[0]);
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f2971d94b4aa..bdb64651679f 100644
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
@@ -724,6 +723,7 @@ void svc_pool_wake_idle_thread(struct svc_serv *serv, struct svc_pool *pool)
 	percpu_counter_inc(&pool->sp_threads_starved);
 	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
+EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
 static struct svc_pool *
 svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 45a76313b7e1..6543e7fac264 100644
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
 
@@ -871,6 +879,30 @@ void svc_recv(struct svc_rqst *rqstp)
 		return;
 	}
 
+#if defined(CONFIG_SUNRPC_BACKCHANNEL)
+	if (svc_is_backchannel(rqstp)) {
+		struct svc_serv *serv = rqstp->rq_server;
+		struct rpc_rqst *req;
+
+		spin_lock_bh(&serv->sv_cb_lock);
+		req = list_first_entry_or_null(&serv->sv_cb_list,
+					       struct rpc_rqst, rq_bc_list);
+		if (req) {
+			int error;
+
+			list_del(&req->rq_bc_list);
+			spin_unlock_bh(&serv->sv_cb_lock);
+
+			dprintk("Invoking bc_svc_process()\n");
+			error = bc_svc_process(rqstp->rq_server, req, rqstp);
+			dprintk("bc_svc_process() returned w/ error code= %d\n",
+				error);
+			return;
+		}
+		spin_unlock_bh(&serv->sv_cb_lock);
+	}
+#endif
+
 	if (slept)
 		percpu_counter_inc(&pool->sp_threads_no_work);
 }
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index e4d84a13c566..f1e1d4909434 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -267,7 +267,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
 	spin_unlock(&bc_serv->sv_cb_lock);
 
-	wake_up(&bc_serv->sv_cb_waitq);
+	svc_pool_wake_idle_thread(bc_serv, &bc_serv->sv_pools[0]);
 
 	r_xprt->rx_stats.bcall_count++;
 	return;
-- 
2.40.1

