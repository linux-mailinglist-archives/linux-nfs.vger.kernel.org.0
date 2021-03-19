Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDB341F71
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCSOcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCSObn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 10:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC6A64F1F;
        Fri, 19 Mar 2021 14:31:42 +0000 (UTC)
Subject: [PATCH v1 5/6] svcrdma: Use svc_rdma_refresh_recvs() in wc_receive
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 19 Mar 2021 10:31:42 -0400
Message-ID: <161616430202.173092.9774953105592702082.stgit@klimt.1015granger.net>
In-Reply-To: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace svc_rdma_post_recv() with the new batch receive mechanism.
For the moment it is posting just a single Receive WR at a time,
so no change in behavior is expected.

Since svc_rdma_wc_receive() was the last call site for
svc_rdma_post_recv(), it is removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   43 ++++++++-----------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 0c6aa8693f20..1e7381ff948b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -305,35 +305,6 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 	return false;
 }
 
-static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
-				struct svc_rdma_recv_ctxt *ctxt)
-{
-	int ret;
-
-	trace_svcrdma_post_recv(ctxt);
-	ret = ib_post_recv(rdma->sc_qp, &ctxt->rc_recv_wr, NULL);
-	if (ret)
-		goto err_post;
-	return 0;
-
-err_post:
-	trace_svcrdma_rq_post_err(rdma, ret);
-	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	return ret;
-}
-
-static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
-{
-	struct svc_rdma_recv_ctxt *ctxt;
-
-	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
-		return 0;
-	ctxt = svc_rdma_recv_ctxt_get(rdma);
-	if (!ctxt)
-		return -ENOMEM;
-	return __svc_rdma_post_recv(rdma, ctxt);
-}
-
 /**
  * svc_rdma_post_recvs - Post initial set of Recv WRs
  * @rdma: fresh svcxprt_rdma
@@ -364,8 +335,17 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto flushed;
 
-	if (svc_rdma_post_recv(rdma))
-		goto post_err;
+	/* If receive posting fails, the connection is about to be
+	 * lost anyway. The server will not be able to send a reply
+	 * for this RPC, and the client will retransmit this RPC
+	 * anyway when it reconnects.
+	 *
+	 * Therefore we drop the Receive, even if status was SUCCESS
+	 * to reduce the likelihood of replayed requests once the
+	 * client reconnects.
+	 */
+	if (!svc_rdma_refresh_recvs(rdma, 1, false))
+		goto flushed;
 
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
@@ -380,7 +360,6 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	return;
 
 flushed:
-post_err:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
 	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&rdma->sc_xprt);


