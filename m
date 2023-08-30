Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF478D248
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbjH3C7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbjH3C7G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:59:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC0185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:59:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3B5C1F45F;
        Wed, 30 Aug 2023 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMkCPWkxuyCtogIQr+wijd8g7517SUjyBJmL+548GBc=;
        b=l70nyySbtZIZLb9V718u56AHXcjShGliVMWoB+pvr7v8I72+uMtrphlZmTToxHr4IiyC/e
        AQUnq/a/bYk7eMLHkLa4qzFPvHaZDwSTKPScqatqXFpr8zUIca+49LdepNRkk814B4qos7
        ZXdCFCfkmgmy2Ddnp2EnsBfpRYnix3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMkCPWkxuyCtogIQr+wijd8g7517SUjyBJmL+548GBc=;
        b=Fcp3OBM9goNgnjh9a7AInZBEuRPeh9d4KaIo7auBiZk4yazU5TtF6WL+U3YOgdX3PAMIlD
        Ofa99dfxDkg/agDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6233913301;
        Wed, 30 Aug 2023 02:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id axaCBXWw7mQuZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:59:01 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] SUNRPC: change the back-channel queue to lwq
Date:   Wed, 30 Aug 2023 12:54:53 +1000
Message-ID: <20230830025755.21292-11-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This removes the need to store and update back-links in the list.
It also remove the need for the _bh version of spin_lock().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h        |  3 +--
 include/linux/sunrpc/xprt.h       |  3 ++-
 net/sunrpc/backchannel_rqst.c     |  5 +----
 net/sunrpc/svc.c                  |  3 +--
 net/sunrpc/svc_xprt.c             | 12 +++---------
 net/sunrpc/xprtrdma/backchannel.c |  4 +---
 6 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 8ce1392c1a35..c1feaf0d1542 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -90,10 +90,9 @@ struct svc_serv {
 	int			(*sv_threadfn)(void *data);
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
-	struct list_head	sv_cb_list;	/* queue for callback requests
+	struct lwq		sv_cb_list;	/* queue for callback requests
 						 * that arrive over the same
 						 * connection */
-	spinlock_t		sv_cb_lock;	/* protects the svc_cb_list */
 	bool			sv_bc_enabled;	/* service uses backchannel */
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b52411bcfe4e..5413bf694b18 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -57,6 +57,7 @@ struct xprt_class;
 struct seq_file;
 struct svc_serv;
 struct net;
+#include <linux/lwq.h>
 
 /*
  * This describes a complete RPC request
@@ -121,7 +122,7 @@ struct rpc_rqst {
 	int			rq_ntrans;
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
-	struct list_head	rq_bc_list;	/* Callback service list */
+	struct lwq_node		rq_bc_list;	/* Callback service list */
 	unsigned long		rq_bc_pa_state;	/* Backchannel prealloc state */
 	struct list_head	rq_bc_pa_list;	/* Backchannel prealloc list */
 #endif /* CONFIG_SUNRPC_BACKCHANEL */
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 44b7c89a635f..caa94cf57123 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -83,7 +83,6 @@ static struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt *xprt)
 		return NULL;
 
 	req->rq_xprt = xprt;
-	INIT_LIST_HEAD(&req->rq_bc_list);
 
 	/* Preallocate one XDR receive buffer */
 	if (xprt_alloc_xdr_buf(&req->rq_rcv_buf, gfp_flags) < 0) {
@@ -367,8 +366,6 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 
 	dprintk("RPC:       add callback request to list\n");
 	xprt_get(xprt);
-	spin_lock(&bc_serv->sv_cb_lock);
-	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
-	spin_unlock(&bc_serv->sv_cb_lock);
+	lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
 	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 61ea8ce7975f..3d3aaed8311c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -438,8 +438,7 @@ EXPORT_SYMBOL_GPL(svc_bind);
 static void
 __svc_init_bc(struct svc_serv *serv)
 {
-	INIT_LIST_HEAD(&serv->sv_cb_list);
-	spin_lock_init(&serv->sv_cb_lock);
+	lwq_init(&serv->sv_cb_list);
 }
 #else
 static void
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2399811582cc..b4beb38152ab 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -705,7 +705,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	if (svc_is_backchannel(rqstp)) {
-		if (!list_empty(&rqstp->rq_server->sv_cb_list))
+		if (!lwq_empty(&rqstp->rq_server->sv_cb_list))
 			return false;
 	}
 #endif
@@ -875,18 +875,12 @@ void svc_recv(struct svc_rqst *rqstp)
 		struct svc_serv *serv = rqstp->rq_server;
 		struct rpc_rqst *req;
 
-		spin_lock_bh(&serv->sv_cb_lock);
-		req = list_first_entry_or_null(&serv->sv_cb_list,
-					       struct rpc_rqst, rq_bc_list);
+		req = lwq_dequeue(&serv->sv_cb_list,
+				  struct rpc_rqst, rq_bc_list);
 		if (req) {
-			list_del(&req->rq_bc_list);
-			spin_unlock_bh(&serv->sv_cb_lock);
 			wake_next(rqstp);
-
 			svc_process_bc(req, rqstp);
-			return;
 		}
-		spin_unlock_bh(&serv->sv_cb_lock);
 	}
 #endif
 }
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index bfc434ec52a7..8c817e755262 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -263,9 +263,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	/* Queue rqst for ULP's callback service */
 	bc_serv = xprt->bc_serv;
 	xprt_get(xprt);
-	spin_lock(&bc_serv->sv_cb_lock);
-	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
-	spin_unlock(&bc_serv->sv_cb_lock);
+	lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
 
 	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
 
-- 
2.41.0

