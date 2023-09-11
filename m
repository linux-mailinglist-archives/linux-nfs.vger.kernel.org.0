Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1679B3F8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbjIKV7M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjIKOk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD240E40
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D8C433C8;
        Mon, 11 Sep 2023 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443223;
        bh=R/obyASdWhu87BNi9NoFertrYVgNqd7RwvWdkJTdagk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W2Q3E7zjUWRrrFtqMKYaM6oSGZ7ppQnrWDV43DyHB1TtCqPL+P1AUQ3/qFUfP/G/f
         2+TAnT2fha+Wl8Tz/+f0e+N96zy8VaieUC/6ApxnCqW6ukEkGkhmf5iIcvd7JvY8zC
         HpLZ8wIzuNsvMo+/Qd3OZHvakKUNDIYGVju88dYa27ryvkWUkFlHECgbDg4DFNqpTk
         GUdoutzgya4KK2pG0le5+9O4imfMd5QPC1xfmffhGmjrXj8u/BWq27W6bkwe98s3AF
         V+dzjL+EGls0tJUlC3rG6wOZ4KBgziQzkHqIdt1/OuEJehijSZTbeWT5fNtgkKDbfQ
         TILE99Uy7ksVg==
Subject: [PATCH v1 17/17] SUNRPC: change the back-channel queue to lwq
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:40:22 -0400
Message-ID: <169444322208.4327.3984958398787234357.stgit@bazille.1015granger.net>
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

This removes the need to store and update back-links in the list.
It also remove the need for the _bh version of spin_lock().

Signed-off-by: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |    3 +--
 include/linux/sunrpc/xprt.h       |    3 ++-
 net/sunrpc/backchannel_rqst.c     |    5 +----
 net/sunrpc/svc.c                  |    3 +--
 net/sunrpc/svc_xprt.c             |   12 +++---------
 net/sunrpc/xprtrdma/backchannel.c |    4 +---
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
index 4ecc89301eb7..f85d3a0daca2 100644
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
index efe7a58ccbdc..7d4c10e609dc 100644
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
index 28ca7db55da1..fee83d1024bc 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -705,7 +705,7 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	if (svc_is_backchannel(rqstp)) {
-		if (!list_empty(&rqstp->rq_server->sv_cb_list))
+		if (!lwq_empty(&rqstp->rq_server->sv_cb_list))
 			return false;
 	}
 #endif
@@ -878,18 +878,12 @@ void svc_recv(struct svc_rqst *rqstp)
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
 			svc_thread_wake_next(rqstp);
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
 


