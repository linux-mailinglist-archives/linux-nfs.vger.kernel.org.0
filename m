Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F03D049
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbfFKPId (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55061 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfFKPIc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:32 -0400
Received: by mail-it1-f195.google.com with SMTP id m138so5474014ita.4;
        Tue, 11 Jun 2019 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TboVYYJ7gpLnPWE7yhB96d17/zIyA0dQJDTD77A5A+8=;
        b=dzG6wWY3UXuCu24OVA7EGFoAF7kI7B5poGYSjSZT9r/3LArWsOavjg+pwTvmocGTKd
         ou1jSwyARdE6OmpCAOYhp6T+sUv+FbquSEP0NyURg1bPXxtbi+do9+ci3ECdcz/4xRlY
         2XDu1vzdPuYPy+6ap2+CxW+Vyic0SzH3vfSRwlRYnJU//SsiFJhOC58mTIzCNgLhY93z
         IgWiF2kwElEZHvrXomc3qBIt82f7H1C7tEdRB5oKmiqpJ5g3N0ueUjaXhVBdB2o+vvJB
         eDKw+zdftmuzU7qfDM5YrVUa12ZATo+8ilvxoByXRRQJudagLfBlPaR2wkM0dDQKlauu
         A76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TboVYYJ7gpLnPWE7yhB96d17/zIyA0dQJDTD77A5A+8=;
        b=qCylQzbyj9h7nDTkusvnUWCBISlzF19OmdVW4odPZ1iS7Q03wXZWKCWDWO+gLJ0z5U
         rgyfO3MEsDDKQTm4Nz4e/XILz4ufss6jpQzqa3wp7YB64usSokcONwg4NB/HMYiD+kqZ
         MRn00SRAkAVFGDIHMMgZ81PksmvJnxru55reMqsCSXERfXVq9N0ykDapqp2IPgIBtLio
         YsyA6A7Two1iptgzqmA4OYECMHxQZPcp+4WRyoywJfd2Z9Zeq4M/OQucBAm/VIXgLuVa
         ImaSN3RDHeDOMCId6VClo39h2jMtH+/BgxBnNkqzlYPqL3kmHu4MWO4jhWNtwVM+MdSL
         7M7g==
X-Gm-Message-State: APjAAAU/n6sRZVrS8qt0FSOIh27vXYzt9+G8FWw5iVvCXi7xzj0gfnXP
        nmizeikx7ATaOOVum0vRnCe/G6zB
X-Google-Smtp-Source: APXvYqw/lc1prazMsdp56SsJNCvezIstGWsLMfXk+1f7iM+D+a6rdPMf1QAAConQ7hqVLjchaBuiuA==
X-Received: by 2002:a05:660c:a48:: with SMTP id j8mr16126175itl.80.1560265711312;
        Tue, 11 Jun 2019 08:08:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d7sm4414139iob.67.2019.06.11.08.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:30 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8UIe021743;
        Tue, 11 Jun 2019 15:08:30 GMT
Subject: [PATCH v2 06/19] xprtrdma: Remove fr_state
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:30 -0400
Message-ID: <20190611150830.2877.36107.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that both the Send and Receive completions are handled in
process context, it is safe to DMA unmap and return MRs to the
free or recycle lists directly in the completion handlers.

Doing this means rpcrdma_frwr no longer needs to track the state of
each MR, meaning that a VALID or FLUSHED MR can no longer appear on
an xprt's MR free list. Thus there is no longer a need to track the
MR's registration state in rpcrdma_frwr.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   19 ----
 net/sunrpc/xprtrdma/frwr_ops.c  |  204 ++++++++++++++++++---------------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 
 net/sunrpc/xprtrdma/xprt_rdma.h |   11 --
 4 files changed, 96 insertions(+), 140 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 2fb4151..1d25470 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -181,18 +181,6 @@
 				),					\
 				TP_ARGS(task, mr, nsegs))
 
-TRACE_DEFINE_ENUM(FRWR_IS_INVALID);
-TRACE_DEFINE_ENUM(FRWR_IS_VALID);
-TRACE_DEFINE_ENUM(FRWR_FLUSHED_FR);
-TRACE_DEFINE_ENUM(FRWR_FLUSHED_LI);
-
-#define xprtrdma_show_frwr_state(x)					\
-		__print_symbolic(x,					\
-				{ FRWR_IS_INVALID, "INVALID" },		\
-				{ FRWR_IS_VALID, "VALID" },		\
-				{ FRWR_FLUSHED_FR, "FLUSHED_FR" },	\
-				{ FRWR_FLUSHED_LI, "FLUSHED_LI" })
-
 DECLARE_EVENT_CLASS(xprtrdma_frwr_done,
 	TP_PROTO(
 		const struct ib_wc *wc,
@@ -203,22 +191,19 @@
 
 	TP_STRUCT__entry(
 		__field(const void *, mr)
-		__field(unsigned int, state)
 		__field(unsigned int, status)
 		__field(unsigned int, vendor_err)
 	),
 
 	TP_fast_assign(
 		__entry->mr = container_of(frwr, struct rpcrdma_mr, frwr);
-		__entry->state = frwr->fr_state;
 		__entry->status = wc->status;
 		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
 	),
 
 	TP_printk(
-		"mr=%p state=%s: %s (%u/0x%x)",
-		__entry->mr, xprtrdma_show_frwr_state(__entry->state),
-		rdma_show_wc_status(__entry->status),
+		"mr=%p: %s (%u/0x%x)",
+		__entry->mr, rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
 	)
 );
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ac47314..dae2caa 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -168,7 +168,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 		goto out_list_err;
 
 	mr->frwr.fr_mr = frmr;
-	mr->frwr.fr_state = FRWR_IS_INVALID;
 	mr->mr_dir = DMA_NONE;
 	INIT_LIST_HEAD(&mr->mr_list);
 	INIT_WORK(&mr->mr_recycle, frwr_mr_recycle_worker);
@@ -298,65 +297,6 @@ size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt)
 }
 
 /**
- * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
- *
- */
-static void
-frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
-{
-	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr =
-			container_of(cqe, struct rpcrdma_frwr, fr_cqe);
-
-	/* WARNING: Only wr_cqe and status are reliable at this point */
-	if (wc->status != IB_WC_SUCCESS)
-		frwr->fr_state = FRWR_FLUSHED_FR;
-	trace_xprtrdma_wc_fastreg(wc, frwr);
-}
-
-/**
- * frwr_wc_localinv - Invoked by RDMA provider for a flushed LocalInv WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
- *
- */
-static void
-frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
-{
-	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr = container_of(cqe, struct rpcrdma_frwr,
-						 fr_cqe);
-
-	/* WARNING: Only wr_cqe and status are reliable at this point */
-	if (wc->status != IB_WC_SUCCESS)
-		frwr->fr_state = FRWR_FLUSHED_LI;
-	trace_xprtrdma_wc_li(wc, frwr);
-}
-
-/**
- * frwr_wc_localinv_wake - Invoked by RDMA provider for a signaled LocalInv WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
- *
- * Awaken anyone waiting for an MR to finish being fenced.
- */
-static void
-frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
-{
-	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr = container_of(cqe, struct rpcrdma_frwr,
-						 fr_cqe);
-
-	/* WARNING: Only wr_cqe and status are reliable at this point */
-	if (wc->status != IB_WC_SUCCESS)
-		frwr->fr_state = FRWR_FLUSHED_LI;
-	trace_xprtrdma_wc_li_wake(wc, frwr);
-	complete(&frwr->fr_linv_done);
-}
-
-/**
  * frwr_map - Register a memory region
  * @r_xprt: controlling transport
  * @seg: memory region co-ordinates
@@ -378,23 +318,15 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	bool holes_ok = ia->ri_mrtype == IB_MR_TYPE_SG_GAPS;
-	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
 	struct ib_mr *ibmr;
 	struct ib_reg_wr *reg_wr;
 	int i, n;
 	u8 key;
 
-	mr = NULL;
-	do {
-		if (mr)
-			rpcrdma_mr_recycle(mr);
-		mr = rpcrdma_mr_get(r_xprt);
-		if (!mr)
-			goto out_getmr_err;
-	} while (mr->frwr.fr_state != FRWR_IS_INVALID);
-	frwr = &mr->frwr;
-	frwr->fr_state = FRWR_IS_VALID;
+	mr = rpcrdma_mr_get(r_xprt);
+	if (!mr)
+		goto out_getmr_err;
 
 	if (nsegs > ia->ri_max_frwr_depth)
 		nsegs = ia->ri_max_frwr_depth;
@@ -423,7 +355,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	if (!mr->mr_nents)
 		goto out_dmamap_err;
 
-	ibmr = frwr->fr_mr;
+	ibmr = mr->frwr.fr_mr;
 	n = ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, PAGE_SIZE);
 	if (unlikely(n != mr->mr_nents))
 		goto out_mapmr_err;
@@ -433,7 +365,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	key = (u8)(ibmr->rkey & 0x000000FF);
 	ib_update_fast_reg_key(ibmr, ++key);
 
-	reg_wr = &frwr->fr_regwr;
+	reg_wr = &mr->frwr.fr_regwr;
 	reg_wr->mr = ibmr;
 	reg_wr->key = ibmr->rkey;
 	reg_wr->access = writing ?
@@ -465,6 +397,23 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 }
 
 /**
+ * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg WC
+ * @cq:	completion queue (ignored)
+ * @wc:	completed WR
+ *
+ */
+static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct ib_cqe *cqe = wc->wr_cqe;
+	struct rpcrdma_frwr *frwr =
+		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
+
+	/* WARNING: Only wr_cqe and status are reliable at this point */
+	trace_xprtrdma_wc_fastreg(wc, frwr);
+	/* The MR will get recycled when the associated req is retransmitted */
+}
+
+/**
  * frwr_send - post Send WR containing the RPC Call message
  * @ia: interface adapter
  * @req: Prepared RPC Call
@@ -516,31 +465,72 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
 			trace_xprtrdma_mr_remoteinv(mr);
-			mr->frwr.fr_state = FRWR_IS_INVALID;
 			rpcrdma_mr_unmap_and_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}
 }
 
+static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
+{
+	if (wc->status != IB_WC_SUCCESS)
+		rpcrdma_mr_recycle(mr);
+	else
+		rpcrdma_mr_unmap_and_put(mr);
+}
+
 /**
- * frwr_unmap_sync - invalidate memory regions that were registered for @req
- * @r_xprt: controlling transport
- * @mrs: list of MRs to process
+ * frwr_wc_localinv - Invoked by RDMA provider for a LOCAL_INV WC
+ * @cq:	completion queue (ignored)
+ * @wc:	completed WR
  *
- * Sleeps until it is safe for the host CPU to access the
- * previously mapped memory regions.
+ */
+static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct ib_cqe *cqe = wc->wr_cqe;
+	struct rpcrdma_frwr *frwr =
+		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
+	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+
+	/* WARNING: Only wr_cqe and status are reliable at this point */
+	__frwr_release_mr(wc, mr);
+	trace_xprtrdma_wc_li(wc, frwr);
+}
+
+/**
+ * frwr_wc_localinv_wake - Invoked by RDMA provider for a LOCAL_INV WC
+ * @cq:	completion queue (ignored)
+ * @wc:	completed WR
  *
- * Caller ensures that @mrs is not empty before the call. This
- * function empties the list.
+ * Awaken anyone waiting for an MR to finish being fenced.
  */
-void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct list_head *mrs)
+static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct ib_cqe *cqe = wc->wr_cqe;
+	struct rpcrdma_frwr *frwr =
+		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
+	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+
+	/* WARNING: Only wr_cqe and status are reliable at this point */
+	__frwr_release_mr(wc, mr);
+	trace_xprtrdma_wc_li_wake(wc, frwr);
+	complete(&frwr->fr_linv_done);
+}
+
+/**
+ * frwr_unmap_sync - invalidate memory regions that were registered for @req
+ * @r_xprt: controlling transport instance
+ * @req: rpcrdma_req with a non-empty list of MRs to process
+ *
+ * Sleeps until it is safe for the host CPU to access the previously mapped
+ * memory regions.
+ */
+void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, **prev, *last;
 	const struct ib_send_wr *bad_wr;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
-	int count, rc;
+	int rc;
 
 	/* ORDER: Invalidate all of the MRs first
 	 *
@@ -548,33 +538,32 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct list_head *mrs)
 	 * a single ib_post_send() call.
 	 */
 	frwr = NULL;
-	count = 0;
 	prev = &first;
-	list_for_each_entry(mr, mrs, mr_list) {
-		mr->frwr.fr_state = FRWR_IS_INVALID;
+	while (!list_empty(&req->rl_registered)) {
+		mr = rpcrdma_mr_pop(&req->rl_registered);
 
-		frwr = &mr->frwr;
 		trace_xprtrdma_mr_localinv(mr);
+		r_xprt->rx_stats.local_inv_needed++;
 
+		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
 		last = &frwr->fr_invwr;
-		memset(last, 0, sizeof(*last));
+		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
+		last->sg_list = NULL;
+		last->num_sge = 0;
 		last->opcode = IB_WR_LOCAL_INV;
+		last->send_flags = IB_SEND_SIGNALED;
 		last->ex.invalidate_rkey = mr->mr_handle;
-		count++;
 
 		*prev = last;
 		prev = &last->next;
 	}
-	if (!frwr)
-		goto unmap;
 
 	/* Strong send queue ordering guarantees that when the
 	 * last WR in the chain completes, all WRs in the chain
 	 * are complete.
 	 */
-	last->send_flags = IB_SEND_SIGNALED;
 	frwr->fr_cqe.done = frwr_wc_localinv_wake;
 	reinit_completion(&frwr->fr_linv_done);
 
@@ -582,29 +571,20 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct list_head *mrs)
 	 * replaces the QP. The RPC reply handler won't call us
 	 * unless ri_id->qp is a valid pointer.
 	 */
-	r_xprt->rx_stats.local_inv_needed++;
 	bad_wr = NULL;
-	rc = ib_post_send(ia->ri_id->qp, first, &bad_wr);
-	if (bad_wr != first)
-		wait_for_completion(&frwr->fr_linv_done);
-	if (rc)
-		goto out_release;
+	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
+	trace_xprtrdma_post_send(req, rc);
 
-	/* ORDER: Now DMA unmap all of the MRs, and return
-	 * them to the free MR list.
+	/* The final LOCAL_INV WR in the chain is supposed to
+	 * do the wake. If it was never posted, the wake will
+	 * not happen, so don't wait in that case.
 	 */
-unmap:
-	while (!list_empty(mrs)) {
-		mr = rpcrdma_mr_pop(mrs);
-		rpcrdma_mr_unmap_and_put(mr);
-	}
-	return;
-
-out_release:
-	pr_err("rpcrdma: FRWR invalidate ib_post_send returned %i\n", rc);
+	if (bad_wr != first)
+		wait_for_completion(&frwr->fr_linv_done);
+	if (!rc)
+		return;
 
-	/* Unmap and release the MRs in the LOCAL_INV WRs that did not
-	 * get posted.
+	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
 	 */
 	while (bad_wr) {
 		frwr = container_of(bad_wr, struct rpcrdma_frwr,
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index fbc0a9f..f23450b 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1277,7 +1277,7 @@ void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * RPC has relinquished all its Send Queue entries.
 	 */
 	if (!list_empty(&req->rl_registered))
-		frwr_unmap_sync(r_xprt, &req->rl_registered);
+		frwr_unmap_sync(r_xprt, req);
 
 	/* Ensure that any DMA mapped pages associated with
 	 * the Send of the RPC Call have been unmapped before
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 3c39aa3..a9de116 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -240,17 +240,9 @@ struct rpcrdma_sendctx {
  * An external memory region is any buffer or page that is registered
  * on the fly (ie, not pre-registered).
  */
-enum rpcrdma_frwr_state {
-	FRWR_IS_INVALID,	/* ready to be used */
-	FRWR_IS_VALID,		/* in use */
-	FRWR_FLUSHED_FR,	/* flushed FASTREG WR */
-	FRWR_FLUSHED_LI,	/* flushed LOCALINV WR */
-};
-
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
 	struct ib_cqe			fr_cqe;
-	enum rpcrdma_frwr_state		fr_state;
 	struct completion		fr_linv_done;
 	union {
 		struct ib_reg_wr	fr_regwr;
@@ -567,8 +559,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr **mr);
 int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
-void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt,
-		     struct list_head *mrs);
+void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 
 /*
  * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c

