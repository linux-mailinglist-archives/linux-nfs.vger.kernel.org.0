Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D92AC51F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgKITjf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgKITjf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:35 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7BC0613CF;
        Mon,  9 Nov 2020 11:39:35 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so6882954qtp.2;
        Mon, 09 Nov 2020 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dlaNl8psgDveUmc9otkF1XnarLugqrJ7ajs/WgVC65s=;
        b=rdfatSjtsDEoFMoy8KEt1MRlRjaJkIWUd3fmOcwAvN/97dhdgcjEKMNqMVRn+tVcgp
         6Waa04oida43VWPuEMREeBD5TSSqKEignxQ3EwM/EDfK9q13Sbd/XfgIdoKIP1aJQMN9
         sMJ5YgnhKiKmBvQ/oEP/1jUD1X0IEJAijrjaCdgh5KAI4YcIa6ogf0KD7SIsxvhBegO4
         lTp72zWxKMmR0O4XHGvaini3B2PnApI4sUku5oXgyMGIM6kIn815q3Li1WwJqkHUQLIQ
         LZGRNxtuxTu3deKLnHh18/jInq/MOoNH67AqCbPOsDZ0nPOp9V55OTpLll67etKoEiip
         dqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dlaNl8psgDveUmc9otkF1XnarLugqrJ7ajs/WgVC65s=;
        b=JNrTk0HEEcM11NZ+obuaNfSNCgMD/wjjGK3XHeTD66UzsuKA/eYaPjeidiNetVGulf
         /DVJsnTubN7SMnDs+7XcBI+vXTFxx4KlOJVsryg9XIp3rEMulBEQCnJIoZl5rz8IVHiC
         HWYaVLBSqFXcz+5bBeTnVczYCHDbuXzkttkmYiWHuIY424lZ9sivX8l8wRXD5OtQjz5G
         2IQTZRSXop8oyTSWvlr9RmOTM6KtZ1xutFluEFXw660KYMAce6fldDK8V+x4OjAm1Gd/
         k1yP63ln+fNJpIVSRJNfCIrWEA2Ejsn0cVcZ/weHV0f8lMpja67l+PrEadf1rLOhVNeX
         Qirg==
X-Gm-Message-State: AOAM532XbGEzcQeyC5l8zFV5N8WQFn0Tcx/bsPUYCCT+p8qnTHCcBqQh
        X9vDfoKJkUXVnFqIkoybsW19zYhMj7U=
X-Google-Smtp-Source: ABdhPJxzwK+Bnqv3ZkQ4W0+d5LPrJKilFhmRRfEzPw0jrXyzwyChxQvMPCn8wJ8y0xNv/UOnmHIb9Q==
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr14014439qtf.85.1604950773967;
        Mon, 09 Nov 2020 11:39:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h16sm6722130qka.47.2020.11.09.11.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:33 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdV5B021800;
        Mon, 9 Nov 2020 19:39:31 GMT
Subject: [PATCH v1 04/13] xprtrdma: Introduce FRWR completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:31 -0500
Message-ID: <160495077182.2072548.2905105620059977472.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set up a completion ID in each rpcrdma_frwr. The ID is used to match
an incoming completion to a transport (CQ) and other MR-related
activity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   44 ++++-----------------------------------
 net/sunrpc/xprtrdma/frwr_ops.c  |   29 ++++++++++++++++++++------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ab239f4f924e..9e30f8aa3562 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -261,41 +261,6 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 				),					\
 				TP_ARGS(task, mr, nsegs))
 
-DECLARE_EVENT_CLASS(xprtrdma_frwr_done,
-	TP_PROTO(
-		const struct ib_wc *wc,
-		const struct rpcrdma_frwr *frwr
-	),
-
-	TP_ARGS(wc, frwr),
-
-	TP_STRUCT__entry(
-		__field(u32, mr_id)
-		__field(unsigned int, status)
-		__field(unsigned int, vendor_err)
-	),
-
-	TP_fast_assign(
-		__entry->mr_id = frwr->fr_mr->res.id;
-		__entry->status = wc->status;
-		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
-	),
-
-	TP_printk(
-		"mr.id=%u: %s (%u/0x%x)",
-		__entry->mr_id, rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
-	)
-);
-
-#define DEFINE_FRWR_DONE_EVENT(name)					\
-		DEFINE_EVENT(xprtrdma_frwr_done, name,			\
-				TP_PROTO(				\
-					const struct ib_wc *wc,		\
-					const struct rpcrdma_frwr *frwr	\
-				),					\
-				TP_ARGS(wc, frwr))
-
 TRACE_DEFINE_ENUM(DMA_BIDIRECTIONAL);
 TRACE_DEFINE_ENUM(DMA_TO_DEVICE);
 TRACE_DEFINE_ENUM(DMA_FROM_DEVICE);
@@ -850,11 +815,10 @@ TRACE_EVENT(xprtrdma_post_linv,
 
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
-
-DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_fastreg);
-DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li);
-DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li_wake);
-DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li_done);
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_fastreg);
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_li);
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_li_wake);
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_li_done);
 
 TRACE_EVENT(xprtrdma_frwr_alloc,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 44888f5badef..2cc6862a52dc 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -363,12 +363,21 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_fastreg(wc, frwr);
+	trace_xprtrdma_wc_fastreg(wc, &frwr->fr_cid);
 	/* The MR will get recycled when the associated req is retransmitted */
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
+static void frwr_cid_init(struct rpcrdma_ep *ep,
+			  struct rpcrdma_frwr *frwr)
+{
+	struct rpc_rdma_cid *cid = &frwr->fr_cid;
+
+	cid->ci_queue_id = ep->re_attr.send_cq->res.id;
+	cid->ci_completion_id = frwr->fr_mr->res.id;
+}
+
 /**
  * frwr_send - post Send WRs containing the RPC Call message
  * @r_xprt: controlling transport instance
@@ -385,6 +394,7 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
  */
 int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
 
@@ -395,6 +405,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		frwr = &mr->frwr;
 
 		frwr->fr_cqe.done = frwr_wc_fastreg;
+		frwr_cid_init(ep, frwr);
 		frwr->fr_regwr.wr.next = post_wr;
 		frwr->fr_regwr.wr.wr_cqe = &frwr->fr_cqe;
 		frwr->fr_regwr.wr.num_sge = 0;
@@ -404,7 +415,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		post_wr = &frwr->fr_regwr.wr;
 	}
 
-	return ib_post_send(r_xprt->rx_ep->re_id->qp, post_wr, NULL);
+	return ib_post_send(ep->re_id->qp, post_wr, NULL);
 }
 
 /**
@@ -448,7 +459,7 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li(wc, frwr);
+	trace_xprtrdma_wc_li(wc, &frwr->fr_cid);
 	__frwr_release_mr(wc, mr);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
@@ -469,7 +480,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li_wake(wc, frwr);
+	trace_xprtrdma_wc_li_wake(wc, &frwr->fr_cid);
 	__frwr_release_mr(wc, mr);
 	complete(&frwr->fr_linv_done);
 
@@ -490,6 +501,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, **prev, *last;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
 	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
@@ -509,6 +521,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
+		frwr_cid_init(ep, frwr);
 		last = &frwr->fr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
@@ -534,7 +547,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ep->re_id->qp, first, &bad_wr);
+	rc = ib_post_send(ep->re_id->qp, first, &bad_wr);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
@@ -574,7 +587,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_rep *rep = mr->mr_req->rl_reply;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li_done(wc, frwr);
+	trace_xprtrdma_wc_li_done(wc, &frwr->fr_cid);
 	__frwr_release_mr(wc, mr);
 
 	/* Ensure @rep is generated before __frwr_release_mr */
@@ -597,6 +610,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, *last, **prev;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
 	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
@@ -614,6 +628,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
+		frwr_cid_init(ep, frwr);
 		last = &frwr->fr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
@@ -639,7 +654,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ep->re_id->qp, first, &bad_wr);
+	rc = ib_post_send(ep->re_id->qp, first, &bad_wr);
 	if (!rc)
 		return;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 4eb8e32b9f4a..cef9d0f2e2c8 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -231,6 +231,7 @@ struct rpcrdma_sendctx {
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
 	struct ib_cqe			fr_cqe;
+	struct rpc_rdma_cid		fr_cid;
 	struct completion		fr_linv_done;
 	union {
 		struct ib_reg_wr	fr_regwr;


