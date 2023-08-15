Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61277C581
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHOBzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjHOBze (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:55:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA8DE
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:55:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 215321F37C;
        Tue, 15 Aug 2023 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exE0itlRFTocCkWFJXzYRgfTWa4b14FBklYeo8noAUI=;
        b=JTCcJirn98n/Ua+5JNgFinfNOUu4QfkhaQWKTpy8lJCi2HazMy6I0GjflhoKL/xch6bB0j
        aqmsKnLcVQPO90AqvoU9Yz2MILkxsknJatNnyB9eJvBZvZy9oZgGRwa/vWf0XdCvUrZfuE
        6ZU6qDEYVeCIT8yjvpCpIyHAgYQVpdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exE0itlRFTocCkWFJXzYRgfTWa4b14FBklYeo8noAUI=;
        b=DroDOAkB2hiDPNUf875WcrTmGcmqfVSDwoU0zLaXKaF3zz7o6zFMblaWIYE2pMNYAo5CGw
        sQWU71TPsFUFjxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2BBC1353E;
        Tue, 15 Aug 2023 01:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vIpCIRLb2mT4CgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:55:30 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] SUNRPC: change the back-channel queue to lwq
Date:   Tue, 15 Aug 2023 11:54:26 +1000
Message-Id: <20230815015426.5091-11-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815015426.5091-1-neilb@suse.de>
References: <20230815015426.5091-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index b80b698b09c5..a05a2e1f77ec 100644
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
index b52411bcfe4e..0a77a6f1c32a 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -57,6 +57,7 @@ struct xprt_class;
 struct seq_file;
 struct svc_serv;
 struct net;
+#include <linux/sunrpc/svc_lwq.h>
 
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
index 0a0b61809451..bf52e9a37e9a 100644
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
@@ -883,18 +883,12 @@ void svc_recv(struct svc_rqst *rqstp)
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
2.40.1

