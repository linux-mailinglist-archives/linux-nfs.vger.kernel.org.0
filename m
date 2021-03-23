Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8D3469F5
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCWUht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhCWUhQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 16:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7AE4619CB;
        Tue, 23 Mar 2021 20:37:15 +0000 (UTC)
Subject: [PATCH 1 2/4] svcrdma: Normalize Send page handling
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Mar 2021 16:37:14 -0400
Message-ID: <161653183489.1499.6777906026281095138.stgit@klimt.1015granger.net>
In-Reply-To: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
References: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently svc_rdma_sendto() migrates xdr_buf pages into a separate
page list and NULLs out a bunch of entries in rq_pages while the
pages are under I/O. The Send completion handler then frees those
pages later.

Instead, let's wait for the Send completion, then handle page
releasing in the nfsd thread. I'd like to avoid the cost of 250+
put_page() calls in the Send completion handler, which is single-
threaded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    1 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    8 +++++++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   29 +++++++++++++++-------------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 722fc7c48725..5841978550c6 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -160,6 +160,7 @@ struct svc_rdma_send_ctxt {
 
 	struct ib_send_wr	sc_send_wr;
 	struct ib_cqe		sc_cqe;
+	struct completion	sc_done;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
 	void			*sc_xprt_buf;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 9150df35fb6f..16897fcb659c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -93,7 +93,13 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	 */
 	get_page(virt_to_page(rqst->rq_buffer));
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
-	return svc_rdma_send(rdma, sctxt);
+	ret = svc_rdma_send(rdma, sctxt);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_killable(&sctxt->sc_done);
+	svc_rdma_send_ctxt_put(rdma, sctxt);
+	return ret;
 }
 
 /* Server-side transport endpoint wants a whole page for its send
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 4471a0fcd3a3..62d55850ca54 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -155,6 +155,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.wr_cqe = &ctxt->sc_cqe;
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
+	init_completion(&ctxt->sc_done);
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
@@ -280,11 +281,11 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 
 	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
 
+	complete(&ctxt->sc_done);
+
 	atomic_inc(&rdma->sc_sq_avail);
 	wake_up(&rdma->sc_send_wait);
 
-	svc_rdma_send_ctxt_put(rdma, ctxt);
-
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		svc_xprt_deferred_close(&rdma->sc_xprt);
 }
@@ -294,7 +295,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * @rdma: transport on which to post the WR
  * @ctxt: send ctxt with a Send WR ready to post
  *
- * Returns zero the Send WR was posted successfully. Otherwise, a
+ * Returns zero if the Send WR was posted successfully. Otherwise, a
  * negative errno is returned.
  */
 int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
@@ -302,7 +303,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	struct ib_send_wr *wr = &ctxt->sc_send_wr;
 	int ret;
 
-	might_sleep();
+	reinit_completion(&ctxt->sc_done);
 
 	/* Sync the transport header buffer */
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
@@ -795,7 +796,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
  * svc_rdma_sendto returns. Transfer pages under I/O to the ctxt
  * so they are released by the Send completion handler.
  */
-static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
+static inline void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
 				   struct svc_rdma_send_ctxt *ctxt)
 {
 	int i, pages = rqstp->rq_next_page - rqstp->rq_respages;
@@ -839,15 +840,20 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
-	svc_rdma_save_io_pages(rqstp, sctxt);
-
 	if (rctxt->rc_inv_rkey) {
 		sctxt->sc_send_wr.opcode = IB_WR_SEND_WITH_INV;
 		sctxt->sc_send_wr.ex.invalidate_rkey = rctxt->rc_inv_rkey;
 	} else {
 		sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	}
-	return svc_rdma_send(rdma, sctxt);
+
+	ret = svc_rdma_send(rdma, sctxt);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_killable(&sctxt->sc_done);
+	svc_rdma_send_ctxt_put(rdma, sctxt);
+	return ret;
 }
 
 /**
@@ -913,7 +919,8 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
 	if (svc_rdma_send(rdma, sctxt))
 		goto put_ctxt;
-	return;
+
+	wait_for_completion_killable(&sctxt->sc_done);
 
 put_ctxt:
 	svc_rdma_send_ctxt_put(rdma, sctxt);
@@ -981,10 +988,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (ret != -E2BIG && ret != -EINVAL)
 		goto err1;
 
-	/* Send completion releases payload pages that were part
-	 * of previously posted RDMA Writes.
-	 */
-	svc_rdma_save_io_pages(rqstp, sctxt);
 	svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	return 0;
 


