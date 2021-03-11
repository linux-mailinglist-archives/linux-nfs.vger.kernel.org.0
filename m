Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CE337CB0
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhCKScm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 13:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhCKScj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Mar 2021 13:32:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BED564FEF;
        Thu, 11 Mar 2021 18:32:32 +0000 (UTC)
Subject: [PATCH] svcrdma: Revert "svcrdma: Reduce Receive doorbell rate"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 11 Mar 2021 13:32:31 -0500
Message-ID: <161548755089.1565.6879184359338461328.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I tested commit 43042b90cae1 ("svcrdma: Reduce Receive doorbell
rate") with mlx4 (IB) and software iWARP and didn't find any
issues. However, I recently got my hardware iWARP setup back on
line (FastLinQ) and it's crashing hard on this commit (confirmed
via bisect).

The failure mode is complex.
 - After a connection is established, the first Receive completes
   normally.
 - But the second and third Receives have garbage in their Receive
   buffers. The server responds with ERR_VERS as a result.
 - When the client tears down the connection to retry, a couple
   of posted Receives flush twice, and that corrupts the recv_ctxt
   free list.
 - __svc_rdma_free then faults or loops infinitely while destroying
   the xprt's recv_ctxts.

Since 43042b90cae1 ("svcrdma: Reduce Receive doorbell rate") does
not fix a bug but is a scalability enhancement, it's safe and
appropriate to revert it while working on a replacement.

Fixes: 43042b90cae1 ("svcrdma: Reduce Receive doorbell rate")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    1 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   82 +++++++++++++++----------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 7c693b31965e..1e76ed688044 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -104,7 +104,6 @@ struct svcxprt_rdma {
 
 	wait_queue_head_t    sc_send_wait;	/* SQ exhaustion waitlist */
 	unsigned long	     sc_flags;
-	u32		     sc_pending_recvs;
 	struct list_head     sc_read_complete_q;
 	struct work_struct   sc_work;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 6d28f23ceb35..7d34290e2ff8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -266,46 +266,33 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 }
 
-static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
-				   unsigned int wanted, bool temp)
+static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
+				struct svc_rdma_recv_ctxt *ctxt)
 {
-	const struct ib_recv_wr *bad_wr = NULL;
-	struct svc_rdma_recv_ctxt *ctxt;
-	struct ib_recv_wr *recv_chain;
 	int ret;
 
-	recv_chain = NULL;
-	while (wanted--) {
-		ctxt = svc_rdma_recv_ctxt_get(rdma);
-		if (!ctxt)
-			break;
-
-		trace_svcrdma_post_recv(ctxt);
-		ctxt->rc_temp = temp;
-		ctxt->rc_recv_wr.next = recv_chain;
-		recv_chain = &ctxt->rc_recv_wr;
-		rdma->sc_pending_recvs++;
-	}
-	if (!recv_chain)
-		return false;
-
-	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
+	trace_svcrdma_post_recv(ctxt);
+	ret = ib_post_recv(rdma->sc_qp, &ctxt->rc_recv_wr, NULL);
 	if (ret)
 		goto err_post;
-	return true;
+	return 0;
 
 err_post:
-	while (bad_wr) {
-		ctxt = container_of(bad_wr, struct svc_rdma_recv_ctxt,
-				    rc_recv_wr);
-		bad_wr = bad_wr->next;
-		svc_rdma_recv_ctxt_put(rdma, ctxt);
-	}
-
 	trace_svcrdma_rq_post_err(rdma, ret);
-	/* Since we're destroying the xprt, no need to reset
-	 * sc_pending_recvs. */
-	return false;
+	svc_rdma_recv_ctxt_put(rdma, ctxt);
+	return ret;
+}
+
+static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
+{
+	struct svc_rdma_recv_ctxt *ctxt;
+
+	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+		return 0;
+	ctxt = svc_rdma_recv_ctxt_get(rdma);
+	if (!ctxt)
+		return -ENOMEM;
+	return __svc_rdma_post_recv(rdma, ctxt);
 }
 
 /**
@@ -316,7 +303,20 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
-	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
+	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < rdma->sc_max_requests; i++) {
+		ctxt = svc_rdma_recv_ctxt_get(rdma);
+		if (!ctxt)
+			return false;
+		ctxt->rc_temp = true;
+		ret = __svc_rdma_post_recv(rdma, ctxt);
+		if (ret)
+			return false;
+	}
+	return true;
 }
 
 /**
@@ -324,6 +324,8 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
  * @cq: Completion Queue context
  * @wc: Work Completion object
  *
+ * NB: The svc_xprt/svcxprt_rdma is pinned whenever it's possible that
+ * the Receive completion handler could be running.
  */
 static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 {
@@ -331,8 +333,6 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_recv_ctxt *ctxt;
 
-	rdma->sc_pending_recvs--;
-
 	/* WARNING: Only wc->wr_cqe and wc->status are reliable */
 	ctxt = container_of(cqe, struct svc_rdma_recv_ctxt, rc_cqe);
 
@@ -340,6 +340,9 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto flushed;
 
+	if (svc_rdma_post_recv(rdma))
+		goto post_err;
+
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
 
@@ -350,18 +353,11 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	spin_unlock(&rdma->sc_rq_dto_lock);
 	if (!test_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags))
 		svc_xprt_enqueue(&rdma->sc_xprt);
-
-	if (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags) &&
-	    rdma->sc_pending_recvs < rdma->sc_max_requests)
-		if (!svc_rdma_refresh_recvs(rdma, RPCRDMA_MAX_RECV_BATCH,
-					    false))
-			goto post_err;
-
 	return;
 
 flushed:
-	svc_rdma_recv_ctxt_put(rdma, ctxt);
 post_err:
+	svc_rdma_recv_ctxt_put(rdma, ctxt);
 	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&rdma->sc_xprt);
 }


