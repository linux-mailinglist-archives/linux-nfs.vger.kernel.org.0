Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E282F4873B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfFQPcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40603 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPcO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:14 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so22071894ioc.7;
        Mon, 17 Jun 2019 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xvkSAEfX7ykhOB5RXdckhFWDVOtl62r6HPs3mMZQF9w=;
        b=d8CKz/kgpLFhy661SOTiSLedPdluPitUJq/XZOhgmpNS2nMx9Ku0zr0bz3gYxh2+0v
         DIHjiq2B6BdOdVIL3uJug+BqJDUPVE0E7SIivPgstgVCGAcMbmjIjEhW4bRuqn05e9Oq
         3V/gg6Q/BdzACF3jP0Dkg1OcBTb+cne+kI8k1kKAuREm8jVIz3V51kdacCOkreAvw1Ft
         +6pQBG0Ho9tykiRzF9rQJsA4DW1qLN0EFEebkZ0ttoLuuaoNyktcPEPwirpht9UFONAW
         YlkEenUJG4Ll/Iq6GoDwZ+jdLxubuRHFKE5JNPBPuFw7rQ52v0zPcyzyA3/CNTmNwpct
         9hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xvkSAEfX7ykhOB5RXdckhFWDVOtl62r6HPs3mMZQF9w=;
        b=hTID9dDvdE2a42PeUfvimnukQrmR+ZaJ0SksHZlnlohyOthVAA5Q50c1AW4AyL8cOT
         ijEDoHWioX0QWdHyTFfOZwBcMflrty3AFpKbtZplqKvg9J1NrEvGX5z25tvlfbjTNQAr
         ThzCVXiwlZjn/BduE8CD+RTFDG7eLEoLbHUGfq3tAb2NENQbws6LZUxoeb3/LvF69LSq
         C5pQ38zOtPQq1EKV2hl2WbBNcChW0q2sxZWw6VxQfDWQkQo0w/HUUzD9eZb+WaXDKm4V
         4XzO7kTC7zTJ22W5YkwLonZL8sLFi6AvoYSyb0/pQQI6WBGQjj18vIZ9FJi/CO+axmM3
         pDYA==
X-Gm-Message-State: APjAAAVoX5wfElosoa0oBStVYxCXcCtLjxcMbGMospjlOVe9Q3XHJi7k
        hahiJj2MNsMcLNwsxF0/oIdeeFEy
X-Google-Smtp-Source: APXvYqwqD3uwxV+xfbVKauYccccRCAWAMjbHNTbBRmMuE5QuG0Ck4XQHmAQtsY7xosyOl7ZGllqMlg==
X-Received: by 2002:a6b:b257:: with SMTP id b84mr62363251iof.137.1560785533468;
        Mon, 17 Jun 2019 08:32:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n17sm9957750iog.63.2019.06.17.08.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWC4E031209;
        Mon, 17 Jun 2019 15:32:12 GMT
Subject: [PATCH v3 08/19] xprtrdma: Reduce context switching due to Local
 Invalidation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:12 -0400
Message-ID: <20190617153212.12090.56726.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit ba69cd122ece ("xprtrdma: Remove support for FMR memory
registration"), FRWR is the only supported memory registration mode.

We can take advantage of the asynchronous nature of FRWR's LOCAL_INV
Work Requests to get rid of the completion wait by having the
LOCAL_INV completion handler take care of DMA unmapping MRs and
waking the upper layer RPC waiter.

This eliminates two context switches when local invalidation is
necessary. As a side benefit, we will no longer need the per-xprt
deferred completion work queue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    1 
 net/sunrpc/xprtrdma/frwr_ops.c  |  103 +++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |   61 +++++++++++------------
 net/sunrpc/xprtrdma/verbs.c     |   17 ------
 net/sunrpc/xprtrdma/xprt_rdma.h |    8 ++-
 5 files changed, 137 insertions(+), 53 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 1d25470..98023d9 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -712,6 +712,7 @@
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_fastreg);
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li);
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li_wake);
+DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li_done);
 
 TRACE_EVENT(xprtrdma_frwr_alloc,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 5b7ff75..d009cb2 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -542,7 +542,10 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
  * @req: rpcrdma_req with a non-empty list of MRs to process
  *
  * Sleeps until it is safe for the host CPU to access the previously mapped
- * memory regions.
+ * memory regions. This guarantees that registered MRs are properly fenced
+ * from the server before the RPC consumer accesses the data in them. It
+ * also ensures proper Send flow control: waking the next RPC waits until
+ * this RPC has relinquished all its Send Queue entries.
  */
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
@@ -616,3 +619,101 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		rpcrdma_mr_recycle(mr);
 	}
 }
+
+/**
+ * frwr_wc_localinv_done - Invoked by RDMA provider for a signaled LOCAL_INV WC
+ * @cq:	completion queue (ignored)
+ * @wc:	completed WR
+ *
+ */
+static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct ib_cqe *cqe = wc->wr_cqe;
+	struct rpcrdma_frwr *frwr =
+		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
+	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+
+	/* WARNING: Only wr_cqe and status are reliable at this point */
+	__frwr_release_mr(wc, mr);
+	trace_xprtrdma_wc_li_done(wc, frwr);
+	rpcrdma_complete_rqst(frwr->fr_req->rl_reply);
+}
+
+/**
+ * frwr_unmap_async - invalidate memory regions that were registered for @req
+ * @r_xprt: controlling transport instance
+ * @req: rpcrdma_req with a non-empty list of MRs to process
+ *
+ * This guarantees that registered MRs are properly fenced from the
+ * server before the RPC consumer accesses the data in them. It also
+ * ensures proper Send flow control: waking the next RPC waits until
+ * this RPC has relinquished all its Send Queue entries.
+ */
+void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
+{
+	struct ib_send_wr *first, *last, **prev;
+	const struct ib_send_wr *bad_wr;
+	struct rpcrdma_frwr *frwr;
+	struct rpcrdma_mr *mr;
+	int rc;
+
+	/* Chain the LOCAL_INV Work Requests and post them with
+	 * a single ib_post_send() call.
+	 */
+	frwr = NULL;
+	prev = &first;
+	while (!list_empty(&req->rl_registered)) {
+		mr = rpcrdma_mr_pop(&req->rl_registered);
+
+		trace_xprtrdma_mr_localinv(mr);
+		r_xprt->rx_stats.local_inv_needed++;
+
+		frwr = &mr->frwr;
+		frwr->fr_cqe.done = frwr_wc_localinv;
+		frwr->fr_req = req;
+		last = &frwr->fr_invwr;
+		last->next = NULL;
+		last->wr_cqe = &frwr->fr_cqe;
+		last->sg_list = NULL;
+		last->num_sge = 0;
+		last->opcode = IB_WR_LOCAL_INV;
+		last->send_flags = IB_SEND_SIGNALED;
+		last->ex.invalidate_rkey = mr->mr_handle;
+
+		*prev = last;
+		prev = &last->next;
+	}
+
+	/* Strong send queue ordering guarantees that when the
+	 * last WR in the chain completes, all WRs in the chain
+	 * are complete. The last completion will wake up the
+	 * RPC waiter.
+	 */
+	frwr->fr_cqe.done = frwr_wc_localinv_done;
+
+	/* Transport disconnect drains the receive CQ before it
+	 * replaces the QP. The RPC reply handler won't call us
+	 * unless ri_id->qp is a valid pointer.
+	 */
+	bad_wr = NULL;
+	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
+	trace_xprtrdma_post_send(req, rc);
+	if (!rc)
+		return;
+
+	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
+	 */
+	while (bad_wr) {
+		frwr = container_of(bad_wr, struct rpcrdma_frwr, fr_invwr);
+		mr = container_of(frwr, struct rpcrdma_mr, frwr);
+		bad_wr = bad_wr->next;
+
+		rpcrdma_mr_recycle(mr);
+	}
+
+	/* The final LOCAL_INV WR in the chain is supposed to
+	 * do the wake. If it was never posted, the wake will
+	 * not happen, so wake here in that case.
+	 */
+	rpcrdma_complete_rqst(req->rl_reply);
+}
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 67d72d6..33b6e6a 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1268,24 +1268,15 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	goto out;
 }
 
-void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
+/* Ensure that any DMA mapped pages associated with
+ * the Send of the RPC Call have been unmapped before
+ * allowing the RPC to complete. This protects argument
+ * memory not controlled by the RPC client from being
+ * re-used before we're done with it.
+ */
+static void rpcrdma_release_tx(struct rpcrdma_xprt *r_xprt,
+			       struct rpcrdma_req *req)
 {
-	/* Invalidate and unmap the data payloads before waking
-	 * the waiting application. This guarantees the memory
-	 * regions are properly fenced from the server before the
-	 * application accesses the data. It also ensures proper
-	 * send flow control: waking the next RPC waits until this
-	 * RPC has relinquished all its Send Queue entries.
-	 */
-	if (!list_empty(&req->rl_registered))
-		frwr_unmap_sync(r_xprt, req);
-
-	/* Ensure that any DMA mapped pages associated with
-	 * the Send of the RPC Call have been unmapped before
-	 * allowing the RPC to complete. This protects argument
-	 * memory not controlled by the RPC client from being
-	 * re-used before we're done with it.
-	 */
 	if (test_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags)) {
 		r_xprt->rx_stats.reply_waits_for_send++;
 		out_of_line_wait_on_bit(&req->rl_flags,
@@ -1295,24 +1286,23 @@ void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	}
 }
 
-/* Reply handling runs in the poll worker thread. Anything that
- * might wait is deferred to a separate workqueue.
+/**
+ * rpcrdma_release_rqst - Release hardware resources
+ * @r_xprt: controlling transport instance
+ * @req: request with resources to release
+ *
  */
-void rpcrdma_deferred_completion(struct work_struct *work)
+void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
-	struct rpcrdma_rep *rep =
-			container_of(work, struct rpcrdma_rep, rr_work);
-	struct rpcrdma_req *req = rpcr_to_rdmar(rep->rr_rqst);
-	struct rpcrdma_xprt *r_xprt = rep->rr_rxprt;
+	if (!list_empty(&req->rl_registered))
+		frwr_unmap_sync(r_xprt, req);
 
-	trace_xprtrdma_defer_cmp(rep);
-	if (rep->rr_wc_flags & IB_WC_WITH_INVALIDATE)
-		frwr_reminv(rep, &req->rl_registered);
-	rpcrdma_release_rqst(r_xprt, req);
-	rpcrdma_complete_rqst(rep);
+	rpcrdma_release_tx(r_xprt, req);
 }
 
-/* Process received RPC/RDMA messages.
+/**
+ * rpcrdma_reply_handler - Process received RPC/RDMA messages
+ * @rep: Incoming rpcrdma_rep object to process
  *
  * Errors must result in the RPC task either being awakened, or
  * allowed to timeout, to discover the errors at that time.
@@ -1374,7 +1364,16 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	rep->rr_rqst = rqst;
 
 	trace_xprtrdma_reply(rqst->rq_task, rep, req, credits);
-	queue_work(buf->rb_completion_wq, &rep->rr_work);
+
+	if (rep->rr_wc_flags & IB_WC_WITH_INVALIDATE)
+		frwr_reminv(rep, &req->rl_registered);
+	if (!list_empty(&req->rl_registered)) {
+		frwr_unmap_async(r_xprt, req);
+		/* LocalInv completion will complete the RPC */
+	} else {
+		rpcrdma_release_tx(r_xprt, req);
+		rpcrdma_complete_rqst(rep);
+	}
 	return;
 
 out_badversion:
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 0be5a36..c50a4b2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -89,14 +89,12 @@
  */
 static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
 	 */
 	ib_drain_rq(ia->ri_id->qp);
-	drain_workqueue(buf->rb_completion_wq);
 
 	/* Deferred Reply processing might have scheduled
 	 * local invalidations.
@@ -1056,7 +1054,6 @@ static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
 
 	rep->rr_cqe.done = rpcrdma_wc_receive;
 	rep->rr_rxprt = r_xprt;
-	INIT_WORK(&rep->rr_work, rpcrdma_deferred_completion);
 	rep->rr_recv_wr.next = NULL;
 	rep->rr_recv_wr.wr_cqe = &rep->rr_cqe;
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
@@ -1117,15 +1114,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 
-	buf->rb_completion_wq = alloc_workqueue("rpcrdma-%s",
-						WQ_MEM_RECLAIM | WQ_HIGHPRI,
-						0,
-			r_xprt->rx_xprt.address_strings[RPC_DISPLAY_ADDR]);
-	if (!buf->rb_completion_wq) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	return 0;
 out:
 	rpcrdma_buffer_destroy(buf);
@@ -1199,11 +1187,6 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
 {
 	cancel_delayed_work_sync(&buf->rb_refresh_worker);
 
-	if (buf->rb_completion_wq) {
-		destroy_workqueue(buf->rb_completion_wq);
-		buf->rb_completion_wq = NULL;
-	}
-
 	rpcrdma_sendctxs_destroy(buf);
 
 	while (!list_empty(&buf->rb_recv_bufs)) {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index a396528..e465221 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -202,10 +202,9 @@ struct rpcrdma_rep {
 	bool			rr_temp;
 	struct rpcrdma_regbuf	*rr_rdmabuf;
 	struct rpcrdma_xprt	*rr_rxprt;
-	struct work_struct	rr_work;
+	struct rpc_rqst		*rr_rqst;
 	struct xdr_buf		rr_hdrbuf;
 	struct xdr_stream	rr_stream;
-	struct rpc_rqst		*rr_rqst;
 	struct list_head	rr_list;
 	struct ib_recv_wr	rr_recv_wr;
 };
@@ -240,10 +239,12 @@ struct rpcrdma_sendctx {
  * An external memory region is any buffer or page that is registered
  * on the fly (ie, not pre-registered).
  */
+struct rpcrdma_req;
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
 	struct ib_cqe			fr_cqe;
 	struct completion		fr_linv_done;
+	struct rpcrdma_req		*fr_req;
 	union {
 		struct ib_reg_wr	fr_regwr;
 		struct ib_send_wr	fr_invwr;
@@ -388,7 +389,6 @@ struct rpcrdma_buffer {
 	u32			rb_bc_srv_max_requests;
 	u32			rb_bc_max_requests;
 
-	struct workqueue_struct *rb_completion_wq;
 	struct delayed_work	rb_refresh_worker;
 };
 
@@ -561,6 +561,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
+void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 
 /*
  * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c
@@ -585,7 +586,6 @@ int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 void rpcrdma_reply_handler(struct rpcrdma_rep *rep);
 void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt,
 			  struct rpcrdma_req *req);
-void rpcrdma_deferred_completion(struct work_struct *work);
 
 static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
 {

