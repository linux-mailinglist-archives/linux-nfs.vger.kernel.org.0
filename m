Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6232FF705
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbhAUVSj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 16:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbhAUUyt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 15:54:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0834323A5E;
        Thu, 21 Jan 2021 20:53:06 +0000 (UTC)
Subject: [PATCH v1 1/2] svcrdma: Reduce Receive doorbell rate
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 Jan 2021 15:53:06 -0500
Message-ID: <161126238612.8979.2073990353982116611.stgit@klimt.1015granger.net>
In-Reply-To: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
References: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is similar to commit e340c2d6ef2a ("xprtrdma: Reduce the
doorbell rate (Receive)") which added Receive batching to the
client.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    1 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   82 ++++++++++++++++---------------
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 1e76ed688044..7c693b31965e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -104,6 +104,7 @@ struct svcxprt_rdma {
 
 	wait_queue_head_t    sc_send_wait;	/* SQ exhaustion waitlist */
 	unsigned long	     sc_flags;
+	u32		     sc_pending_recvs;
 	struct list_head     sc_read_complete_q;
 	struct work_struct   sc_work;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 7d14a74df716..ab0b7e9777bc 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -266,33 +266,46 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 }
 
-static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
-				struct svc_rdma_recv_ctxt *ctxt)
+static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
+				   unsigned int wanted, bool temp)
 {
+	const struct ib_recv_wr *bad_wr = NULL;
+	struct svc_rdma_recv_ctxt *ctxt;
+	struct ib_recv_wr *recv_chain;
 	int ret;
 
-	trace_svcrdma_post_recv(ctxt);
-	ret = ib_post_recv(rdma->sc_qp, &ctxt->rc_recv_wr, NULL);
+	recv_chain = NULL;
+	while (wanted--) {
+		ctxt = svc_rdma_recv_ctxt_get(rdma);
+		if (!ctxt)
+			break;
+
+		trace_svcrdma_post_recv(ctxt);
+		ctxt->rc_temp = temp;
+		ctxt->rc_recv_wr.next = recv_chain;
+		recv_chain = &ctxt->rc_recv_wr;
+		rdma->sc_pending_recvs++;
+	}
+	if (!recv_chain)
+		return false;
+
+	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
 	if (ret)
 		goto err_post;
-	return 0;
+	return true;
 
 err_post:
-	trace_svcrdma_rq_post_err(rdma, ret);
-	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	return ret;
-}
-
-static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
-{
-	struct svc_rdma_recv_ctxt *ctxt;
+	while (bad_wr) {
+		ctxt = container_of(bad_wr, struct svc_rdma_recv_ctxt,
+				    rc_recv_wr);
+		bad_wr = bad_wr->next;
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+	}
 
-	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
-		return 0;
-	ctxt = svc_rdma_recv_ctxt_get(rdma);
-	if (!ctxt)
-		return -ENOMEM;
-	return __svc_rdma_post_recv(rdma, ctxt);
+	trace_svcrdma_rq_post_err(rdma, ret);
+	/* Since we're destroying the xprt, no need to reset
+	 * sc_pending_recvs. */
+	return false;
 }
 
 /**
@@ -303,20 +316,7 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
-	struct svc_rdma_recv_ctxt *ctxt;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < rdma->sc_max_requests; i++) {
-		ctxt = svc_rdma_recv_ctxt_get(rdma);
-		if (!ctxt)
-			return false;
-		ctxt->rc_temp = true;
-		ret = __svc_rdma_post_recv(rdma, ctxt);
-		if (ret)
-			return false;
-	}
-	return true;
+	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
 }
 
 /**
@@ -324,8 +324,6 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
  * @cq: Completion Queue context
  * @wc: Work Completion object
  *
- * NB: The svc_xprt/svcxprt_rdma is pinned whenever it's possible that
- * the Receive completion handler could be running.
  */
 static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 {
@@ -333,6 +331,8 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	rdma->sc_pending_recvs--;
+
 	/* WARNING: Only wc->wr_cqe and wc->status are reliable */
 	ctxt = container_of(cqe, struct svc_rdma_recv_ctxt, rc_cqe);
 
@@ -340,9 +340,6 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto flushed;
 
-	if (svc_rdma_post_recv(rdma))
-		goto post_err;
-
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
 	ib_dma_sync_single_for_cpu(rdma->sc_pd->device,
@@ -356,11 +353,18 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	spin_unlock(&rdma->sc_rq_dto_lock);
 	if (!test_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags))
 		svc_xprt_enqueue(&rdma->sc_xprt);
+
+	if (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags) &&
+	    rdma->sc_pending_recvs < rdma->sc_max_requests)
+		if (!svc_rdma_refresh_recvs(rdma, RPCRDMA_MAX_RECV_BATCH,
+					    false))
+			goto post_err;
+
 	return;
 
 flushed:
-post_err:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
+post_err:
 	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&rdma->sc_xprt);
 }


