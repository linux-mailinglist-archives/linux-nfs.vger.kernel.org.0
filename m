Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD676C6F9
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjHBHfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjHBHfp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 03:35:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B830EF
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 00:35:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9352B1F88C;
        Wed,  2 Aug 2023 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690961713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2yLhtAFSnGmHPOvkGgtVZO+JJdQ6nGGsyqHiT3HMG0=;
        b=JYvJrCYmYMJGa5fbIAZ+bD/tIpkco7d6gPAMw60+GWDhypLfMC3ZpV9Y/cX9YwoWLghFu7
        aKdatDSICytQiwBi/7AQXTgkL8N3JK3OnKlhpEcxVvJNVJYlI+Tv2WeSNAx8TE7Eeg6vd6
        uICXuEhSvcz/u1FYK3QsYyNALQG2kLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690961713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2yLhtAFSnGmHPOvkGgtVZO+JJdQ6nGGsyqHiT3HMG0=;
        b=UJJzS9nwb2Bf8E2DL9boFg98wfkJL/otb1kMuxERyOiH0EGzIvYp8lwT6m4Av6qofD/OnB
        UDMvmSAOULEjnSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5599F13909;
        Wed,  2 Aug 2023 07:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63q6AjAHymQKJAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 02 Aug 2023 07:35:12 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] SUNRPC: integrate back-channel processing with svc_recv()
Date:   Wed,  2 Aug 2023 17:34:40 +1000
Message-Id: <20230802073443.17965-4-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802073443.17965-1-neilb@suse.de>
References: <20230802073443.17965-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index dbf5b21feafe..5e2d3b83999e 100644
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
index dc21e6c732db..0c3272f1b3b6 100644
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
index f1d64ded89fb..39582ac33cbd 100644
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
 
@@ -867,6 +875,30 @@ void svc_recv(struct svc_rqst *rqstp)
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
-- 
2.40.1

