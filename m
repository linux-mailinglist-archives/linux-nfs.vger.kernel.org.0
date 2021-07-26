Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9263D5C0E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhGZOGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 10:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhGZOGg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:06:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5FB60EB2;
        Mon, 26 Jul 2021 14:47:05 +0000 (UTC)
Subject: [PATCH v1 2/3] svcrdma: Relieve contention on sc_send_lock.
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Jul 2021 10:47:04 -0400
Message-ID: <162731082448.13580.10185534687433469045.stgit@klimt.1015granger.net>
In-Reply-To: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

/proc/lock_stat indicates the the sc_send_lock is heavily
contended when the server is under load from a single client.

To address this, convert the send_ctxt free list to an llist.
Returning an item to the send_ctxt cache is now waitless, which
reduces the instruction path length in the single-threaded Send
handler (svc_rdma_wc_send).

The goal is to enable the ib_comp_wq worker to handle a higher
RPC/RDMA Send completion rate given the same CPU resources. This
change reduces CPU utilization of Send completion by 2-3% on my
server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    4 ++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   23 ++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 57c60ffe76dd..5f8d5af6556c 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -90,7 +90,7 @@ struct svcxprt_rdma {
 	struct ib_pd         *sc_pd;
 
 	spinlock_t	     sc_send_lock;
-	struct list_head     sc_send_ctxts;
+	struct llist_head    sc_send_ctxts;
 	spinlock_t	     sc_rw_ctxt_lock;
 	struct list_head     sc_rw_ctxts;
 
@@ -150,7 +150,7 @@ struct svc_rdma_recv_ctxt {
 };
 
 struct svc_rdma_send_ctxt {
-	struct list_head	sc_list;
+	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
 
 	struct ib_send_wr	sc_send_wr;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index fba2ee4eb607..599021b2391d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -113,13 +113,6 @@
 
 static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc);
 
-static inline struct svc_rdma_send_ctxt *
-svc_rdma_next_send_ctxt(struct list_head *list)
-{
-	return list_first_entry_or_null(list, struct svc_rdma_send_ctxt,
-					sc_list);
-}
-
 static void svc_rdma_send_cid_init(struct svcxprt_rdma *rdma,
 				   struct rpc_rdma_cid *cid)
 {
@@ -182,9 +175,10 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_send_ctxt *ctxt;
+	struct llist_node *node;
 
-	while ((ctxt = svc_rdma_next_send_ctxt(&rdma->sc_send_ctxts))) {
-		list_del(&ctxt->sc_list);
+	while ((node = llist_del_first(&rdma->sc_send_ctxts)) != NULL) {
+		ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
 		ib_dma_unmap_single(rdma->sc_pd->device,
 				    ctxt->sc_sges[0].addr,
 				    rdma->sc_max_req_size,
@@ -204,12 +198,13 @@ void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_send_ctxt *ctxt;
+	struct llist_node *node;
 
 	spin_lock(&rdma->sc_send_lock);
-	ctxt = svc_rdma_next_send_ctxt(&rdma->sc_send_ctxts);
-	if (!ctxt)
+	node = llist_del_first(&rdma->sc_send_ctxts);
+	if (!node)
 		goto out_empty;
-	list_del(&ctxt->sc_list);
+	ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
 	spin_unlock(&rdma->sc_send_lock);
 
 out:
@@ -253,9 +248,7 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 					     ctxt->sc_sges[i].length);
 	}
 
-	spin_lock(&rdma->sc_send_lock);
-	list_add(&ctxt->sc_list, &rdma->sc_send_ctxts);
-	spin_unlock(&rdma->sc_send_lock);
+	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index d94b7759ada1..99474078c304 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -136,7 +136,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
-	INIT_LIST_HEAD(&cma_xprt->sc_send_ctxts);
+	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	INIT_LIST_HEAD(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);


