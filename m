Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5703572C6FE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjFLOKV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbjFLOKU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40A10C4;
        Mon, 12 Jun 2023 07:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 117C8629A1;
        Mon, 12 Jun 2023 14:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28271C433EF;
        Mon, 12 Jun 2023 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579015;
        bh=AfTZqjleRnP/Mi+DwkW3OxBl5qEOliwMKT65wBpbHk4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MknqHRi9yrMVxgByalC57smUPP9814JnieiOqEREjhVIqwCGtvLEVEA0aUs5aia3K
         rLQ7kmNj0eAYFOgTCffjITQbjpi3laGQvkJhBzVuAzBkI+RoH25QsZjqSko1kbcZdl
         5Mmt7tLeXbG3gpEQFmQAato1FVbaCoGHgy0JUJoslEygGjh+wR3+TUo40boaK0B3fE
         LQGlMuOMggCnE4Y+bzhoyeZAqhTRNNGUWnW0VSDnBoAe9bbfgwdu2U7ML59lMceCQd
         4Luff6neHPMVxMCJvGVB03cAn/kGOX7JXaG0ZeuJ1wRQh/ak+Lq7xKDdfIwBrmgCHI
         NnFfzWrLXrWYA==
Subject: [PATCH v2 3/5] svcrdma: Revert 2a1e4f21d841 ("svcrdma: Normalize Send
 page handling")
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 12 Jun 2023 10:10:14 -0400
Message-ID: <168657901418.5619.12840449463788983763.stgit@manet.1015granger.net>
In-Reply-To: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Get rid of the completion wait in svc_rdma_sendto(), and release
pages in the send completion handler again. A subsequent patch will
handle releasing those pages more efficiently.

Reverted by hand: patch -R would not apply cleanly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    1 -
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    8 +-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   27 ++++++++++++---------------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8e654da55170..a5ee0af2a310 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -154,7 +154,6 @@ struct svc_rdma_send_ctxt {
 
 	struct ib_send_wr	sc_send_wr;
 	struct ib_cqe		sc_cqe;
-	struct completion	sc_done;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
 	void			*sc_xprt_buf;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index aa2227a7e552..7420a2c990c7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -93,13 +93,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	 */
 	get_page(virt_to_page(rqst->rq_buffer));
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
-	ret = svc_rdma_send(rdma, sctxt);
-	if (ret < 0)
-		return ret;
-
-	ret = wait_for_completion_killable(&sctxt->sc_done);
-	svc_rdma_send_ctxt_put(rdma, sctxt);
-	return ret;
+	return svc_rdma_send(rdma, sctxt);
 }
 
 /* Server-side transport endpoint wants a whole page for its send
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 4c62bc41ea40..1ae4236d04a3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -147,7 +147,6 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.wr_cqe = &ctxt->sc_cqe;
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
-	init_completion(&ctxt->sc_done);
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
@@ -286,12 +285,12 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(cqe, struct svc_rdma_send_ctxt, sc_cqe);
 
 	svc_rdma_wake_send_waiters(rdma, 1);
-	complete(&ctxt->sc_done);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		goto flushed;
 
 	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
+	svc_rdma_send_ctxt_put(rdma, ctxt);
 	return;
 
 flushed:
@@ -299,6 +298,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_send_err(wc, &ctxt->sc_cid);
 	else
 		trace_svcrdma_wc_send_flush(wc, &ctxt->sc_cid);
+	svc_rdma_send_ctxt_put(rdma, ctxt);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
@@ -315,8 +315,6 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	struct ib_send_wr *wr = &ctxt->sc_send_wr;
 	int ret;
 
-	reinit_completion(&ctxt->sc_done);
-
 	/* Sync the transport header buffer */
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
 				      wr->sg_list[0].addr,
@@ -808,8 +806,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
  * svc_rdma_sendto returns. Transfer pages under I/O to the ctxt
  * so they are released by the Send completion handler.
  */
-static inline void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
-					  struct svc_rdma_send_ctxt *ctxt)
+static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
+				   struct svc_rdma_send_ctxt *ctxt)
 {
 	int i, pages = rqstp->rq_next_page - rqstp->rq_respages;
 
@@ -852,6 +850,8 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
+	svc_rdma_save_io_pages(rqstp, sctxt);
+
 	if (rctxt->rc_inv_rkey) {
 		sctxt->sc_send_wr.opcode = IB_WR_SEND_WITH_INV;
 		sctxt->sc_send_wr.ex.invalidate_rkey = rctxt->rc_inv_rkey;
@@ -859,13 +859,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 		sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	}
 
-	ret = svc_rdma_send(rdma, sctxt);
-	if (ret < 0)
-		return ret;
-
-	ret = wait_for_completion_killable(&sctxt->sc_done);
-	svc_rdma_send_ctxt_put(rdma, sctxt);
-	return ret;
+	return svc_rdma_send(rdma, sctxt);
 }
 
 /**
@@ -931,8 +925,7 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
 	if (svc_rdma_send(rdma, sctxt))
 		goto put_ctxt;
-
-	wait_for_completion_killable(&sctxt->sc_done);
+	return;
 
 put_ctxt:
 	svc_rdma_send_ctxt_put(rdma, sctxt);
@@ -1006,6 +999,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (ret != -E2BIG && ret != -EINVAL)
 		goto put_ctxt;
 
+	/* Send completion releases payload pages that were part
+	 * of previously posted RDMA Writes.
+	 */
+	svc_rdma_save_io_pages(rqstp, sctxt);
 	svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	return 0;
 


