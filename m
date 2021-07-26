Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB72D3D5C0F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhGZOGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 10:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhGZOGm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35F9860EB2;
        Mon, 26 Jul 2021 14:47:11 +0000 (UTC)
Subject: [PATCH v1 3/3] svcrdma: Convert rdma->sc_rw_ctxts to llist
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Jul 2021 10:47:10 -0400
Message-ID: <162731083051.13580.14827164285152793745.stgit@klimt.1015granger.net>
In-Reply-To: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Relieve contention on sc_rw_ctxt_lock by converting rdma->sc_rw_ctxts
to an llist.

The goal is to reduce the average overhead of Send completions,
because a transport's completion handlers are single-threaded on
one CPU core. This change reduces CPU utilization of each Send
completion by 2-3% on my server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    2 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |   49 +++++++++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 5f8d5af6556c..24aa159d29a7 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -92,7 +92,7 @@ struct svcxprt_rdma {
 	spinlock_t	     sc_send_lock;
 	struct llist_head    sc_send_ctxts;
 	spinlock_t	     sc_rw_ctxt_lock;
-	struct list_head     sc_rw_ctxts;
+	struct llist_head    sc_rw_ctxts;
 
 	u32		     sc_pending_recvs;
 	u32		     sc_recv_batch;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 3d1b119f6e3e..e27433f08ca7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -35,6 +35,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
  * controlling svcxprt_rdma is destroyed.
  */
 struct svc_rdma_rw_ctxt {
+	struct llist_node	rw_node;
 	struct list_head	rw_list;
 	struct rdma_rw_ctx	rw_ctx;
 	unsigned int		rw_nents;
@@ -53,19 +54,19 @@ static struct svc_rdma_rw_ctxt *
 svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 {
 	struct svc_rdma_rw_ctxt *ctxt;
+	struct llist_node *node;
 
 	spin_lock(&rdma->sc_rw_ctxt_lock);
-
-	ctxt = svc_rdma_next_ctxt(&rdma->sc_rw_ctxts);
-	if (ctxt) {
-		list_del(&ctxt->rw_list);
-		spin_unlock(&rdma->sc_rw_ctxt_lock);
+	node = llist_del_first(&rdma->sc_rw_ctxts);
+	spin_unlock(&rdma->sc_rw_ctxt_lock);
+	if (node) {
+		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
-		spin_unlock(&rdma->sc_rw_ctxt_lock);
 		ctxt = kmalloc(struct_size(ctxt, rw_first_sgl, SG_CHUNK_SIZE),
 			       GFP_KERNEL);
 		if (!ctxt)
 			goto out_noctx;
+
 		INIT_LIST_HEAD(&ctxt->rw_list);
 	}
 
@@ -83,14 +84,18 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	return NULL;
 }
 
-static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
-				 struct svc_rdma_rw_ctxt *ctxt)
+static void __svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
+				   struct svc_rdma_rw_ctxt *ctxt,
+				   struct llist_head *list)
 {
 	sg_free_table_chained(&ctxt->rw_sg_table, SG_CHUNK_SIZE);
+	llist_add(&ctxt->rw_node, list);
+}
 
-	spin_lock(&rdma->sc_rw_ctxt_lock);
-	list_add(&ctxt->rw_list, &rdma->sc_rw_ctxts);
-	spin_unlock(&rdma->sc_rw_ctxt_lock);
+static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
+				 struct svc_rdma_rw_ctxt *ctxt)
+{
+	__svc_rdma_put_rw_ctxt(rdma, ctxt, &rdma->sc_rw_ctxts);
 }
 
 /**
@@ -101,9 +106,10 @@ static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
 void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_rw_ctxt *ctxt;
+	struct llist_node *node;
 
-	while ((ctxt = svc_rdma_next_ctxt(&rdma->sc_rw_ctxts)) != NULL) {
-		list_del(&ctxt->rw_list);
+	while ((node = llist_del_first(&rdma->sc_rw_ctxts)) != NULL) {
+		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 		kfree(ctxt);
 	}
 }
@@ -171,20 +177,35 @@ static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 	cc->cc_sqecount = 0;
 }
 
+/*
+ * The consumed rw_ctx's are cleaned and placed on a local llist so
+ * that only one atomic llist operation is needed to put them all
+ * back on the free list.
+ */
 static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir)
 {
 	struct svcxprt_rdma *rdma = cc->cc_rdma;
+	struct llist_node *first, *last;
 	struct svc_rdma_rw_ctxt *ctxt;
+	LLIST_HEAD(free);
 
+	first = last = NULL;
 	while ((ctxt = svc_rdma_next_ctxt(&cc->cc_rwctxts)) != NULL) {
 		list_del(&ctxt->rw_list);
 
 		rdma_rw_ctx_destroy(&ctxt->rw_ctx, rdma->sc_qp,
 				    rdma->sc_port_num, ctxt->rw_sg_table.sgl,
 				    ctxt->rw_nents, dir);
-		svc_rdma_put_rw_ctxt(rdma, ctxt);
+		__svc_rdma_put_rw_ctxt(rdma, ctxt, &free);
+
+		ctxt->rw_node.next = first;
+		first = &ctxt->rw_node;
+		if (!last)
+			last = first;
 	}
+	if (first)
+		llist_add_batch(first, last, &rdma->sc_rw_ctxts);
 }
 
 /* State for sending a Write or Reply chunk.
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 99474078c304..d1faa522c3dd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -138,7 +138,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
-	INIT_LIST_HEAD(&cma_xprt->sc_rw_ctxts);
+	init_llist_head(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);


