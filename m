Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CA1689BC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgBUWBA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:01:00 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37000 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgBUWBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:01:00 -0500
Received: by mail-yb1-f194.google.com with SMTP id b196so1440037yba.4;
        Fri, 21 Feb 2020 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XEaRlIINcfgXjLpXXn/5ieoZbMFnZYRvjyzuUK5n8XU=;
        b=MtHz/1piS+TxBTjpqhUCLekY9XnsvK1TM9QN0iemgazLN+m3IOzPTGlsdgLTxf7YWL
         /7PPj4sDjo8h5uWoIaPpXXqOubcndNhy5cWhdCAE1eNNzg+yHoAvcO9z8s/cdfNvOKjM
         qSeRJJN1CHg8KWB9KorR28QHucFVG5/UyDs8RRM6lsuxr/NrDxPMJuuQ3T/0OGYQ+lDI
         tJQNRrZYlYvvS5Oa77m+k6Plqu7U4/v9HlRdjXVO7acDdPD0bnTjeItjcao5QmBjiwtu
         PwNcVVV3/hdyXatvsUWwBnv1IZ95gTRM7108fSJd07X1NKqByfWGL9U0RFoN5wRrLqfr
         othA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XEaRlIINcfgXjLpXXn/5ieoZbMFnZYRvjyzuUK5n8XU=;
        b=htvxy7J3OlQC+n3X8XLH6+dYinr1LnqAki3JRNcTmAcVK1wmRdsBzi4VljPNaYnuAo
         LH7pVWzK3vhs1QOswbH7obhOVdTSwTu5BuRHb4uJ3wk+BV7MnkWJ58N7p40W2SOBhKkU
         aTwYeL6LYRhMZDRB3UlzbFbnqXAM8+nrN6/OMNnOVjHWydwVNsoIFe6ePrtavAGTIvfc
         o5fOzHV1qIJkPpkUG+X1dHtDU/Zv5khiXB3MrhIhJx25m/FZ46X18qRh9p5Xs1KmZsFT
         FfapM3b4no+3BHaoabD/rpoCWkUwR+igxKcmgVIY1bLz9/3VnDQevfKmBBKpH9d3gRA7
         gf8g==
X-Gm-Message-State: APjAAAWlC6MuqsF26ZQOa8w/N9VOSMgwBJYFR/kT/v7RmhJJKAcC6Qpg
        TCKey4PeD3sCakp2I9SZ9P6dclXy
X-Google-Smtp-Source: APXvYqwRWnbF/BTxbQFx8krqPSWlt8XfFhLpQAQcGhLOrGt5chU0IMl3kDkJdCPr0A+33r8Q5EbipQ==
X-Received: by 2002:a05:6902:70e:: with SMTP id k14mr38145273ybt.304.1582322456537;
        Fri, 21 Feb 2020 14:00:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m15sm1821141ywh.78.2020.02.21.14.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:56 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0s2N019003;
        Fri, 21 Feb 2020 22:00:54 GMT
Subject: [PATCH v1 09/11] xprtrdma: Merge struct rpcrdma_ia into struct
 rpcrdma_ep
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:54 -0500
Message-ID: <20200221220054.2072.80440.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I eventually want to allocate rpcrdma_ep separately from struct
rpcrdma_xprt so that on occasion there can be more than one ep per
xprt.

The new struct rpcrdma_ep will contain all the fields currently in
rpcrdma_ia and in rpcrdma_ep. This is all the device and CM settings
for the connection, in addition to per-connection settings
negotiated with the remote.

Take this opportunity to rename the existing ep fields from rep_* to
re_* to disambiguate these from struct rpcrdma_rep.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   12 +-
 net/sunrpc/xprtrdma/backchannel.c |    4 -
 net/sunrpc/xprtrdma/frwr_ops.c    |  108 +++++++-------
 net/sunrpc/xprtrdma/rpc_rdma.c    |   31 ++--
 net/sunrpc/xprtrdma/transport.c   |    9 +
 net/sunrpc/xprtrdma/verbs.c       |  283 ++++++++++++++++++-------------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |   60 +++-----
 7 files changed, 246 insertions(+), 261 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 18369943da61..bebc45f7c570 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -104,7 +104,7 @@
 	TP_fast_assign(
 		__entry->r_xprt = r_xprt;
 		__entry->rc = rc;
-		__entry->connect_status = r_xprt->rx_ep.rep_connected;
+		__entry->connect_status = r_xprt->rx_ep.re_connect_status;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
@@ -392,10 +392,10 @@
 		const struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 
 		__entry->r_xprt = r_xprt;
-		__entry->inline_send = ep->rep_inline_send;
-		__entry->inline_recv = ep->rep_inline_recv;
-		__entry->max_send = ep->rep_max_inline_send;
-		__entry->max_recv = ep->rep_max_inline_recv;
+		__entry->inline_send = ep->re_inline_send;
+		__entry->inline_recv = ep->re_inline_recv;
+		__entry->max_send = ep->re_max_inline_send;
+		__entry->max_recv = ep->re_max_inline_recv;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
@@ -801,7 +801,7 @@
 		__entry->r_xprt = r_xprt;
 		__entry->count = count;
 		__entry->status = status;
-		__entry->posted = r_xprt->rx_ep.rep_receive_count;
+		__entry->posted = r_xprt->rx_ep.re_receive_count;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 4b43910a6ed2..4b20102cf060 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -47,7 +47,7 @@ size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *xprt)
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	size_t maxmsg;
 
-	maxmsg = min_t(unsigned int, ep->rep_inline_send, ep->rep_inline_recv);
+	maxmsg = min_t(unsigned int, ep->re_inline_send, ep->re_inline_recv);
 	maxmsg = min_t(unsigned int, maxmsg, PAGE_SIZE);
 	return maxmsg - RPCRDMA_HDRLEN_MIN;
 }
@@ -190,7 +190,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 	if (xprt->bc_alloc_count >= RPCRDMA_BACKWARD_WRS)
 		return NULL;
 
-	size = min_t(size_t, r_xprt->rx_ep.rep_inline_recv, PAGE_SIZE);
+	size = min_t(size_t, r_xprt->rx_ep.re_inline_recv, PAGE_SIZE);
 	req = rpcrdma_req_create(r_xprt, size, GFP_KERNEL);
 	if (!req)
 		return NULL;
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 69d5910f04a0..c48f3f2dacde 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -74,7 +74,7 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ia.ri_id->device,
+		ib_dma_unmap_sg(r_xprt->rx_ep.re_id->device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
@@ -115,13 +115,13 @@ void frwr_reset(struct rpcrdma_req *req)
  */
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	unsigned int depth = ia->ri_max_frwr_depth;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	unsigned int depth = ep->re_max_fr_depth;
 	struct scatterlist *sg;
 	struct ib_mr *frmr;
 	int rc;
 
-	frmr = ib_alloc_mr(ia->ri_pd, ia->ri_mrtype, depth);
+	frmr = ib_alloc_mr(ep->re_pd, ep->re_mrtype, depth);
 	if (IS_ERR(frmr))
 		goto out_mr_err;
 
@@ -151,29 +151,24 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 
 /**
  * frwr_query_device - Prepare a transport for use with FRWR
- * @r_xprt: controlling transport instance
+ * @ep: endpoint to fill in
  * @device: RDMA device to query
  *
  * On success, sets:
- *	ep->rep_attr
- *	ep->rep_max_requests
- *	ia->ri_max_rdma_segs
- *
- * And these FRWR-related fields:
- *	ia->ri_max_frwr_depth
- *	ia->ri_mrtype
+ *	ep->re_attr
+ *	ep->re_max_requests
+ *	ep->re_max_rdma_segs
+ *	ep->re_max_fr_depth
+ *	ep->re_mrtype
  *
  * Return values:
  *   On success, returns zero.
  *   %-EINVAL - the device does not support FRWR memory registration
  *   %-ENOMEM - the device is not sufficiently capable for NFS/RDMA
  */
-int frwr_query_device(struct rpcrdma_xprt *r_xprt,
-		      const struct ib_device *device)
+int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 {
 	const struct ib_device_attr *attrs = &device->attrs;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int max_qp_wr, depth, delta;
 	unsigned int max_sge;
 
@@ -190,23 +185,23 @@ int frwr_query_device(struct rpcrdma_xprt *r_xprt,
 		pr_err("rpcrdma: HCA provides only %u send SGEs\n", max_sge);
 		return -ENOMEM;
 	}
-	ep->rep_attr.cap.max_send_sge = max_sge;
-	ep->rep_attr.cap.max_recv_sge = 1;
+	ep->re_attr.cap.max_send_sge = max_sge;
+	ep->re_attr.cap.max_recv_sge = 1;
 
-	ia->ri_mrtype = IB_MR_TYPE_MEM_REG;
+	ep->re_mrtype = IB_MR_TYPE_MEM_REG;
 	if (attrs->device_cap_flags & IB_DEVICE_SG_GAPS_REG)
-		ia->ri_mrtype = IB_MR_TYPE_SG_GAPS;
+		ep->re_mrtype = IB_MR_TYPE_SG_GAPS;
 
 	/* Quirk: Some devices advertise a large max_fast_reg_page_list_len
 	 * capability, but perform optimally when the MRs are not larger
 	 * than a page.
 	 */
 	if (attrs->max_sge_rd > RPCRDMA_MAX_HDR_SEGS)
-		ia->ri_max_frwr_depth = attrs->max_sge_rd;
+		ep->re_max_fr_depth = attrs->max_sge_rd;
 	else
-		ia->ri_max_frwr_depth = attrs->max_fast_reg_page_list_len;
-	if (ia->ri_max_frwr_depth > RPCRDMA_MAX_DATA_SEGS)
-		ia->ri_max_frwr_depth = RPCRDMA_MAX_DATA_SEGS;
+		ep->re_max_fr_depth = attrs->max_fast_reg_page_list_len;
+	if (ep->re_max_fr_depth > RPCRDMA_MAX_DATA_SEGS)
+		ep->re_max_fr_depth = RPCRDMA_MAX_DATA_SEGS;
 
 	/* Add room for frwr register and invalidate WRs.
 	 * 1. FRWR reg WR for head
@@ -222,11 +217,11 @@ int frwr_query_device(struct rpcrdma_xprt *r_xprt,
 	/* Calculate N if the device max FRWR depth is smaller than
 	 * RPCRDMA_MAX_DATA_SEGS.
 	 */
-	if (ia->ri_max_frwr_depth < RPCRDMA_MAX_DATA_SEGS) {
-		delta = RPCRDMA_MAX_DATA_SEGS - ia->ri_max_frwr_depth;
+	if (ep->re_max_fr_depth < RPCRDMA_MAX_DATA_SEGS) {
+		delta = RPCRDMA_MAX_DATA_SEGS - ep->re_max_fr_depth;
 		do {
 			depth += 2; /* FRWR reg + invalidate */
-			delta -= ia->ri_max_frwr_depth;
+			delta -= ep->re_max_fr_depth;
 		} while (delta > 0);
 	}
 
@@ -235,34 +230,34 @@ int frwr_query_device(struct rpcrdma_xprt *r_xprt,
 	max_qp_wr -= 1;
 	if (max_qp_wr < RPCRDMA_MIN_SLOT_TABLE)
 		return -ENOMEM;
-	if (ep->rep_max_requests > max_qp_wr)
-		ep->rep_max_requests = max_qp_wr;
-	ep->rep_attr.cap.max_send_wr = ep->rep_max_requests * depth;
-	if (ep->rep_attr.cap.max_send_wr > max_qp_wr) {
-		ep->rep_max_requests = max_qp_wr / depth;
-		if (!ep->rep_max_requests)
+	if (ep->re_max_requests > max_qp_wr)
+		ep->re_max_requests = max_qp_wr;
+	ep->re_attr.cap.max_send_wr = ep->re_max_requests * depth;
+	if (ep->re_attr.cap.max_send_wr > max_qp_wr) {
+		ep->re_max_requests = max_qp_wr / depth;
+		if (!ep->re_max_requests)
 			return -ENOMEM;
-		ep->rep_attr.cap.max_send_wr = ep->rep_max_requests * depth;
+		ep->re_attr.cap.max_send_wr = ep->re_max_requests * depth;
 	}
-	ep->rep_attr.cap.max_send_wr += RPCRDMA_BACKWARD_WRS;
-	ep->rep_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
-	ep->rep_attr.cap.max_recv_wr = ep->rep_max_requests;
-	ep->rep_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
-	ep->rep_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
-
-	ia->ri_max_rdma_segs =
-		DIV_ROUND_UP(RPCRDMA_MAX_DATA_SEGS, ia->ri_max_frwr_depth);
+	ep->re_attr.cap.max_send_wr += RPCRDMA_BACKWARD_WRS;
+	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
+	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
+	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
+	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
+
+	ep->re_max_rdma_segs =
+		DIV_ROUND_UP(RPCRDMA_MAX_DATA_SEGS, ep->re_max_fr_depth);
 	/* Reply chunks require segments for head and tail buffers */
-	ia->ri_max_rdma_segs += 2;
-	if (ia->ri_max_rdma_segs > RPCRDMA_MAX_HDR_SEGS)
-		ia->ri_max_rdma_segs = RPCRDMA_MAX_HDR_SEGS;
+	ep->re_max_rdma_segs += 2;
+	if (ep->re_max_rdma_segs > RPCRDMA_MAX_HDR_SEGS)
+		ep->re_max_rdma_segs = RPCRDMA_MAX_HDR_SEGS;
 
 	/* Ensure the underlying device is capable of conveying the
 	 * largest r/wsize NFS will ask for. This guarantees that
 	 * failing over from one RDMA device to another will not
 	 * break NFS I/O.
 	 */
-	if ((ia->ri_max_rdma_segs * ia->ri_max_frwr_depth) < RPCRDMA_MAX_SEGS)
+	if ((ep->re_max_rdma_segs * ep->re_max_fr_depth) < RPCRDMA_MAX_SEGS)
 		return -ENOMEM;
 
 	return 0;
@@ -288,14 +283,14 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				int nsegs, bool writing, __be32 xid,
 				struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct ib_reg_wr *reg_wr;
 	int i, n, dma_nents;
 	struct ib_mr *ibmr;
 	u8 key;
 
-	if (nsegs > ia->ri_max_frwr_depth)
-		nsegs = ia->ri_max_frwr_depth;
+	if (nsegs > ep->re_max_fr_depth)
+		nsegs = ep->re_max_fr_depth;
 	for (i = 0; i < nsegs;) {
 		if (seg->mr_page)
 			sg_set_page(&mr->mr_sg[i],
@@ -308,7 +303,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 
 		++seg;
 		++i;
-		if (ia->ri_mrtype == IB_MR_TYPE_SG_GAPS)
+		if (ep->re_mrtype == IB_MR_TYPE_SG_GAPS)
 			continue;
 		if ((i < nsegs && offset_in_page(seg->mr_offset)) ||
 		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
@@ -317,7 +312,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	mr->mr_dir = rpcrdma_data_dir(writing);
 	mr->mr_nents = i;
 
-	dma_nents = ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, mr->mr_nents,
+	dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg, mr->mr_nents,
 				  mr->mr_dir);
 	if (!dma_nents)
 		goto out_dmamap_err;
@@ -391,7 +386,6 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
  */
 int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
 
@@ -411,7 +405,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		post_wr = &frwr->fr_regwr.wr;
 	}
 
-	return ib_post_send(ia->ri_id->qp, post_wr, NULL);
+	return ib_post_send(r_xprt->rx_ep.re_id->qp, post_wr, NULL);
 }
 
 /**
@@ -538,10 +532,10 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Transport disconnect drains the receive CQ before it
 	 * replaces the QP. The RPC reply handler won't call us
-	 * unless ri_id->qp is a valid pointer.
+	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
+	rc = ib_post_send(r_xprt->rx_ep.re_id->qp, first, &bad_wr);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
@@ -643,10 +637,10 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Transport disconnect drains the receive CQ before it
 	 * replaces the QP. The RPC reply handler won't call us
-	 * unless ri_id->qp is a valid pointer.
+	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
+	rc = ib_post_send(r_xprt->rx_ep.re_id->qp, first, &bad_wr);
 	if (!rc)
 		return;
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 28020ec104d4..ad7e6b0187bd 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -103,21 +103,20 @@ static unsigned int rpcrdma_max_reply_header_size(unsigned int maxsegs)
 
 /**
  * rpcrdma_set_max_header_sizes - Initialize inline payload sizes
- * @r_xprt: transport instance to initialize
+ * @ep: endpoint to initialize
  *
  * The max_inline fields contain the maximum size of an RPC message
  * so the marshaling code doesn't have to repeat this calculation
  * for every RPC.
  */
-void rpcrdma_set_max_header_sizes(struct rpcrdma_xprt *r_xprt)
+void rpcrdma_set_max_header_sizes(struct rpcrdma_ep *ep)
 {
-	unsigned int maxsegs = r_xprt->rx_ia.ri_max_rdma_segs;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	unsigned int maxsegs = ep->re_max_rdma_segs;
 
-	ep->rep_max_inline_send =
-		ep->rep_inline_send - rpcrdma_max_call_header_size(maxsegs);
-	ep->rep_max_inline_recv =
-		ep->rep_inline_recv - rpcrdma_max_reply_header_size(maxsegs);
+	ep->re_max_inline_send =
+		ep->re_inline_send - rpcrdma_max_call_header_size(maxsegs);
+	ep->re_max_inline_recv =
+		ep->re_inline_recv - rpcrdma_max_reply_header_size(maxsegs);
 }
 
 /* The client can send a request inline as long as the RPCRDMA header
@@ -134,7 +133,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 	struct xdr_buf *xdr = &rqst->rq_snd_buf;
 	unsigned int count, remaining, offset;
 
-	if (xdr->len > r_xprt->rx_ep.rep_max_inline_send)
+	if (xdr->len > r_xprt->rx_ep.re_max_inline_send)
 		return false;
 
 	if (xdr->page_len) {
@@ -145,7 +144,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 			remaining -= min_t(unsigned int,
 					   PAGE_SIZE - offset, remaining);
 			offset = 0;
-			if (++count > r_xprt->rx_ep.rep_attr.cap.max_send_sge)
+			if (++count > r_xprt->rx_ep.re_attr.cap.max_send_sge)
 				return false;
 		}
 	}
@@ -162,7 +161,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 				   struct rpc_rqst *rqst)
 {
-	return rqst->rq_rcv_buf.buflen <= r_xprt->rx_ep.rep_max_inline_recv;
+	return rqst->rq_rcv_buf.buflen <= r_xprt->rx_ep.re_max_inline_recv;
 }
 
 /* The client is required to provide a Reply chunk if the maximum
@@ -176,7 +175,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	const struct xdr_buf *buf = &rqst->rq_rcv_buf;
 
 	return (buf->head[0].iov_len + buf->tail[0].iov_len) <
-		r_xprt->rx_ep.rep_max_inline_recv;
+		r_xprt->rx_ep.re_max_inline_recv;
 }
 
 /* Split @vec on page boundaries into SGEs. FMR registers pages, not
@@ -255,7 +254,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	/* When encoding a Read chunk, the tail iovec contains an
 	 * XDR pad and may be omitted.
 	 */
-	if (type == rpcrdma_readch && r_xprt->rx_ia.ri_implicit_roundup)
+	if (type == rpcrdma_readch && r_xprt->rx_ep.re_implicit_roundup)
 		goto out;
 
 	/* When encoding a Write chunk, some servers need to see an
@@ -263,7 +262,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	 * layer provides space in the tail iovec that may be used
 	 * for this purpose.
 	 */
-	if (type == rpcrdma_writech && r_xprt->rx_ia.ri_implicit_roundup)
+	if (type == rpcrdma_writech && r_xprt->rx_ep.re_implicit_roundup)
 		goto out;
 
 	if (xdrbuf->tail[0].iov_len)
@@ -1476,8 +1475,8 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 	if (credits == 0)
 		credits = 1;	/* don't deadlock */
-	else if (credits > r_xprt->rx_ep.rep_max_requests)
-		credits = r_xprt->rx_ep.rep_max_requests;
+	else if (credits > r_xprt->rx_ep.re_max_requests)
+		credits = r_xprt->rx_ep.re_max_requests;
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 	rpcrdma_post_recvs(r_xprt, false);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index d7b7dab0aeb6..4352fd6e9817 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -238,11 +238,12 @@
 	struct rpcrdma_xprt *r_xprt = container_of(work, struct rpcrdma_xprt,
 						   rx_connect_worker.work);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc;
 
 	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
-	if (r_xprt->rx_ep.rep_connected > 0) {
+	if (ep->re_connect_status > 0) {
 		xprt->stat.connect_count++;
 		xprt->stat.connect_time += (long)jiffies -
 					   xprt->stat.connect_start;
@@ -265,7 +266,7 @@
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
 	trace_xprtrdma_op_inject_dsc(r_xprt);
-	rdma_disconnect(r_xprt->rx_ia.ri_id);
+	rdma_disconnect(r_xprt->rx_ep.re_id);
 }
 
 /**
@@ -355,6 +356,7 @@
 
 	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
 			  xprt_rdma_connect_worker);
+
 	xprt->max_payload = RPCRDMA_MAX_DATA_SEGS << PAGE_SHIFT;
 
 	dprintk("RPC:       %s: %s:%s\n", __func__,
@@ -489,10 +491,11 @@ static void xprt_rdma_set_connect_timeout(struct rpc_xprt *xprt,
 xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	unsigned long delay;
 
 	delay = 0;
-	if (r_xprt->rx_ep.rep_connected != 0) {
+	if (ep->re_connect_status != 0) {
 		delay = xprt_reconnect_delay(xprt);
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index dfe680e3234a..10826982ddf8 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -97,17 +97,17 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
  */
 static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	struct rdma_cm_id *id = r_xprt->rx_ep.re_id;
 
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
 	 */
-	ib_drain_rq(ia->ri_id->qp);
+	ib_drain_rq(id->qp);
 
 	/* Deferred Reply processing might have scheduled
 	 * local invalidations.
 	 */
-	ib_drain_sq(ia->ri_id->qp);
+	ib_drain_sq(id->qp);
 }
 
 /**
@@ -140,8 +140,9 @@ void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 
-	if (wc->status != IB_WC_SUCCESS && r_xprt->rx_ep.rep_connected == 1) {
-		r_xprt->rx_ep.rep_connected = -ECONNABORTED;
+	if (wc->status != IB_WC_SUCCESS &&
+	    r_xprt->rx_ep.re_connect_status == 1) {
+		r_xprt->rx_ep.re_connect_status = -ECONNABORTED;
 		trace_xprtrdma_flush_dct(r_xprt, wc->status);
 		xprt_force_disconnect(xprt);
 	}
@@ -180,7 +181,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_receive(wc);
-	--r_xprt->rx_ep.rep_receive_count;
+	--r_xprt->rx_ep.re_receive_count;
 	if (wc->status != IB_WC_SUCCESS)
 		goto out_flushed;
 
@@ -209,24 +210,24 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	unsigned int rsize, wsize;
 
 	/* Default settings for RPC-over-RDMA Version One */
-	r_xprt->rx_ia.ri_implicit_roundup = xprt_rdma_pad_optimize;
+	ep->re_implicit_roundup = xprt_rdma_pad_optimize;
 	rsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 	wsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 
 	if (pmsg &&
 	    pmsg->cp_magic == rpcrdma_cmp_magic &&
 	    pmsg->cp_version == RPCRDMA_CMP_VERSION) {
-		r_xprt->rx_ia.ri_implicit_roundup = true;
+		ep->re_implicit_roundup = true;
 		rsize = rpcrdma_decode_buffer_size(pmsg->cp_send_size);
 		wsize = rpcrdma_decode_buffer_size(pmsg->cp_recv_size);
 	}
 
-	if (rsize < ep->rep_inline_recv)
-		ep->rep_inline_recv = rsize;
-	if (wsize < ep->rep_inline_send)
-		ep->rep_inline_send = wsize;
+	if (rsize < ep->re_inline_recv)
+		ep->re_inline_recv = rsize;
+	if (wsize < ep->re_inline_send)
+		ep->re_inline_send = wsize;
 
-	rpcrdma_set_max_header_sizes(r_xprt);
+	rpcrdma_set_max_header_sizes(ep);
 }
 
 /**
@@ -241,7 +242,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
 	struct rpcrdma_xprt *r_xprt = id->context;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 
@@ -251,57 +251,57 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	switch (event->event) {
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
-		ia->ri_async_rc = 0;
-		complete(&ia->ri_done);
+		ep->re_async_rc = 0;
+		complete(&ep->re_done);
 		return 0;
 	case RDMA_CM_EVENT_ADDR_ERROR:
-		ia->ri_async_rc = -EPROTO;
-		complete(&ia->ri_done);
+		ep->re_async_rc = -EPROTO;
+		complete(&ep->re_done);
 		return 0;
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		ia->ri_async_rc = -ENETUNREACH;
-		complete(&ia->ri_done);
+		ep->re_async_rc = -ENETUNREACH;
+		complete(&ep->re_done);
 		return 0;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 		pr_info("rpcrdma: removing device %s for %s:%s\n",
-			ia->ri_id->device->name,
+			ep->re_id->device->name,
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
 #endif
-		init_completion(&ia->ri_remove_done);
-		ep->rep_connected = -ENODEV;
+		init_completion(&ep->re_remove_done);
+		ep->re_connect_status = -ENODEV;
 		xprt_force_disconnect(xprt);
-		wait_for_completion(&ia->ri_remove_done);
+		wait_for_completion(&ep->re_remove_done);
 		trace_xprtrdma_remove(r_xprt);
 
 		/* Return 1 to ensure the core destroys the id. */
 		return 1;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		++xprt->connect_cookie;
-		ep->rep_connected = 1;
+		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(r_xprt, &event->param.conn);
 		trace_xprtrdma_inline_thresh(r_xprt);
-		wake_up_all(&ep->rep_connect_wait);
+		wake_up_all(&ep->re_connect_wait);
 		break;
 	case RDMA_CM_EVENT_CONNECT_ERROR:
-		ep->rep_connected = -ENOTCONN;
+		ep->re_connect_status = -ENOTCONN;
 		goto disconnected;
 	case RDMA_CM_EVENT_UNREACHABLE:
-		ep->rep_connected = -ENETUNREACH;
+		ep->re_connect_status = -ENETUNREACH;
 		goto disconnected;
 	case RDMA_CM_EVENT_REJECTED:
 		dprintk("rpcrdma: connection to %s:%s rejected: %s\n",
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
 			rdma_reject_msg(id, event->status));
-		ep->rep_connected = -ECONNREFUSED;
+		ep->re_connect_status = -ECONNREFUSED;
 		if (event->status == IB_CM_REJ_STALE_CONN)
-			ep->rep_connected = -EAGAIN;
+			ep->re_connect_status = -EAGAIN;
 		goto disconnected;
 	case RDMA_CM_EVENT_DISCONNECTED:
-		ep->rep_connected = -ECONNABORTED;
+		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		xprt_force_disconnect(xprt);
-		wake_up_all(&ep->rep_connect_wait);
+		wake_up_all(&ep->re_connect_wait);
 		break;
 	default:
 		break;
@@ -309,46 +309,46 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 
 	dprintk("RPC:       %s: %s:%s on %s/frwr: %s\n", __func__,
 		rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
-		ia->ri_id->device->name, rdma_event_msg(event->event));
+		ep->re_id->device->name, rdma_event_msg(event->event));
 	return 0;
 }
 
-static struct rdma_cm_id *
-rpcrdma_create_id(struct rpcrdma_xprt *xprt, struct rpcrdma_ia *ia)
+static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
+					    struct rpcrdma_ep *ep)
 {
 	unsigned long wtimeout = msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT) + 1;
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 	struct rdma_cm_id *id;
 	int rc;
 
-	init_completion(&ia->ri_done);
+	init_completion(&ep->re_done);
 
-	id = rdma_create_id(xprt->rx_xprt.xprt_net, rpcrdma_cm_event_handler,
-			    xprt, RDMA_PS_TCP, IB_QPT_RC);
+	id = rdma_create_id(xprt->xprt_net, rpcrdma_cm_event_handler, r_xprt,
+			    RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(id))
 		return id;
 
-	ia->ri_async_rc = -ETIMEDOUT;
-	rc = rdma_resolve_addr(id, NULL,
-			       (struct sockaddr *)&xprt->rx_xprt.addr,
+	ep->re_async_rc = -ETIMEDOUT;
+	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
 			       RDMA_RESOLVE_TIMEOUT);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible_timeout(&ia->ri_done, wtimeout);
+	rc = wait_for_completion_interruptible_timeout(&ep->re_done, wtimeout);
 	if (rc < 0)
 		goto out;
 
-	rc = ia->ri_async_rc;
+	rc = ep->re_async_rc;
 	if (rc)
 		goto out;
 
-	ia->ri_async_rc = -ETIMEDOUT;
+	ep->re_async_rc = -ETIMEDOUT;
 	rc = rdma_resolve_route(id, RDMA_RESOLVE_TIMEOUT);
 	if (rc)
 		goto out;
-	rc = wait_for_completion_interruptible_timeout(&ia->ri_done, wtimeout);
+	rc = wait_for_completion_interruptible_timeout(&ep->re_done, wtimeout);
 	if (rc < 0)
 		goto out;
-	rc = ia->ri_async_rc;
+	rc = ep->re_async_rc;
 	if (rc)
 		goto out;
 
@@ -366,102 +366,101 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	struct rpcrdma_connect_private *pmsg = &ep->rep_cm_private;
+	struct rpcrdma_connect_private *pmsg = &ep->re_cm_private;
 	struct rdma_cm_id *id;
 	int rc;
 
-	id = rpcrdma_create_id(r_xprt, ia);
+	id = rpcrdma_create_id(r_xprt, ep);
 	if (IS_ERR(id))
 		return PTR_ERR(id);
 
-	ep->rep_max_requests = r_xprt->rx_xprt.max_reqs;
-	ep->rep_inline_send = xprt_rdma_max_inline_write;
-	ep->rep_inline_recv = xprt_rdma_max_inline_read;
-
-	rc = frwr_query_device(r_xprt, id->device);
+	ep->re_max_requests = r_xprt->rx_xprt.max_reqs;
+	ep->re_inline_send = xprt_rdma_max_inline_write;
+	ep->re_inline_recv = xprt_rdma_max_inline_read;
+	rc = frwr_query_device(ep, id->device);
 	if (rc)
 		goto out_destroy;
 
-	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->rep_max_requests);
+	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->re_max_requests);
 
-	ep->rep_attr.event_handler = rpcrdma_qp_event_handler;
-	ep->rep_attr.qp_context = ep;
-	ep->rep_attr.srq = NULL;
-	ep->rep_attr.cap.max_inline_data = 0;
-	ep->rep_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
-	ep->rep_attr.qp_type = IB_QPT_RC;
-	ep->rep_attr.port_num = ~0;
+	ep->re_attr.event_handler = rpcrdma_qp_event_handler;
+	ep->re_attr.qp_context = ep;
+	ep->re_attr.srq = NULL;
+	ep->re_attr.cap.max_inline_data = 0;
+	ep->re_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	ep->re_attr.qp_type = IB_QPT_RC;
+	ep->re_attr.port_num = ~0;
 
 	dprintk("RPC:       %s: requested max: dtos: send %d recv %d; "
 		"iovs: send %d recv %d\n",
 		__func__,
-		ep->rep_attr.cap.max_send_wr,
-		ep->rep_attr.cap.max_recv_wr,
-		ep->rep_attr.cap.max_send_sge,
-		ep->rep_attr.cap.max_recv_sge);
-
-	ep->rep_send_batch = ep->rep_max_requests >> 3;
-	ep->rep_send_count = ep->rep_send_batch;
-	init_waitqueue_head(&ep->rep_connect_wait);
-	ep->rep_receive_count = 0;
-
-	ep->rep_attr.send_cq = ib_alloc_cq_any(id->device, r_xprt,
-					       ep->rep_attr.cap.max_send_wr,
-					       IB_POLL_WORKQUEUE);
-	if (IS_ERR(ep->rep_attr.send_cq)) {
-		rc = PTR_ERR(ep->rep_attr.send_cq);
+		ep->re_attr.cap.max_send_wr,
+		ep->re_attr.cap.max_recv_wr,
+		ep->re_attr.cap.max_send_sge,
+		ep->re_attr.cap.max_recv_sge);
+
+	ep->re_send_batch = ep->re_max_requests >> 3;
+	ep->re_send_count = ep->re_send_batch;
+	init_waitqueue_head(&ep->re_connect_wait);
+
+	ep->re_attr.send_cq = ib_alloc_cq_any(id->device, r_xprt,
+					      ep->re_attr.cap.max_send_wr,
+					      IB_POLL_WORKQUEUE);
+	if (IS_ERR(ep->re_attr.send_cq)) {
+		rc = PTR_ERR(ep->re_attr.send_cq);
 		goto out_destroy;
 	}
 
-	ep->rep_attr.recv_cq = ib_alloc_cq_any(id->device, r_xprt,
-					       ep->rep_attr.cap.max_recv_wr,
-					       IB_POLL_WORKQUEUE);
-	if (IS_ERR(ep->rep_attr.recv_cq)) {
-		rc = PTR_ERR(ep->rep_attr.recv_cq);
+	ep->re_attr.recv_cq = ib_alloc_cq_any(id->device, r_xprt,
+					      ep->re_attr.cap.max_recv_wr,
+					      IB_POLL_WORKQUEUE);
+	if (IS_ERR(ep->re_attr.recv_cq)) {
+		rc = PTR_ERR(ep->re_attr.recv_cq);
 		goto out_destroy;
 	}
+	ep->re_receive_count = 0;
 
 	/* Initialize cma parameters */
-	memset(&ep->rep_remote_cma, 0, sizeof(ep->rep_remote_cma));
+	memset(&ep->re_remote_cma, 0, sizeof(ep->re_remote_cma));
 
 	/* Prepare RDMA-CM private message */
 	pmsg->cp_magic = rpcrdma_cmp_magic;
 	pmsg->cp_version = RPCRDMA_CMP_VERSION;
 	pmsg->cp_flags |= RPCRDMA_CMP_F_SND_W_INV_OK;
-	pmsg->cp_send_size = rpcrdma_encode_buffer_size(ep->rep_inline_send);
-	pmsg->cp_recv_size = rpcrdma_encode_buffer_size(ep->rep_inline_recv);
-	ep->rep_remote_cma.private_data = pmsg;
-	ep->rep_remote_cma.private_data_len = sizeof(*pmsg);
+	pmsg->cp_send_size = rpcrdma_encode_buffer_size(ep->re_inline_send);
+	pmsg->cp_recv_size = rpcrdma_encode_buffer_size(ep->re_inline_recv);
+	ep->re_remote_cma.private_data = pmsg;
+	ep->re_remote_cma.private_data_len = sizeof(*pmsg);
 
 	/* Client offers RDMA Read but does not initiate */
-	ep->rep_remote_cma.initiator_depth = 0;
-	ep->rep_remote_cma.responder_resources =
+	ep->re_remote_cma.initiator_depth = 0;
+	ep->re_remote_cma.responder_resources =
 		min_t(int, U8_MAX, id->device->attrs.max_qp_rd_atom);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
 	 * transport connection and retransmission.
 	 */
-	ep->rep_remote_cma.retry_count = 6;
+	ep->re_remote_cma.retry_count = 6;
 
 	/* RPC-over-RDMA handles its own flow control. In addition,
 	 * make all RNR NAKs visible so we know that RPC-over-RDMA
 	 * flow control is working correctly (no NAKs should be seen).
 	 */
-	ep->rep_remote_cma.flow_control = 0;
-	ep->rep_remote_cma.rnr_retry_count = 0;
+	ep->re_remote_cma.flow_control = 0;
+	ep->re_remote_cma.rnr_retry_count = 0;
 
-	ia->ri_pd = ib_alloc_pd(id->device, 0);
-	if (IS_ERR(ia->ri_pd)) {
-		rc = PTR_ERR(ia->ri_pd);
+	ep->re_pd = ib_alloc_pd(id->device, 0);
+	if (IS_ERR(ep->re_pd)) {
+		rc = PTR_ERR(ep->re_pd);
 		goto out_destroy;
 	}
 
-	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
+	rc = rdma_create_qp(id, ep->re_pd, &ep->re_attr);
 	if (rc)
 		goto out_destroy;
-	ia->ri_id = id;
+
+	ep->re_id = id;
 	return 0;
 
 out_destroy:
@@ -473,23 +472,22 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 
-	if (ia->ri_id && ia->ri_id->qp) {
-		rdma_destroy_qp(ia->ri_id);
-		ia->ri_id->qp = NULL;
+	if (ep->re_id && ep->re_id->qp) {
+		rdma_destroy_qp(ep->re_id);
+		ep->re_id->qp = NULL;
 	}
 
-	if (ep->rep_attr.recv_cq)
-		ib_free_cq(ep->rep_attr.recv_cq);
-	ep->rep_attr.recv_cq = NULL;
-	if (ep->rep_attr.send_cq)
-		ib_free_cq(ep->rep_attr.send_cq);
-	ep->rep_attr.send_cq = NULL;
+	if (ep->re_attr.recv_cq)
+		ib_free_cq(ep->re_attr.recv_cq);
+	ep->re_attr.recv_cq = NULL;
+	if (ep->re_attr.send_cq)
+		ib_free_cq(ep->re_attr.send_cq);
+	ep->re_attr.send_cq = NULL;
 
-	if (ia->ri_pd)
-		ib_dealloc_pd(ia->ri_pd);
-	ia->ri_pd = NULL;
+	if (ep->re_pd)
+		ib_dealloc_pd(ep->re_pd);
+	ep->re_pd = NULL;
 }
 
 /*
@@ -499,7 +497,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	int rc;
 
 retry:
@@ -508,7 +505,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out_noupdate;
 
-	ep->rep_connected = 0;
+	ep->re_connect_status = 0;
 	xprt_clear_connected(xprt);
 
 	rpcrdma_reset_cwnd(r_xprt);
@@ -518,17 +515,18 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 
-	rc = rdma_connect(ia->ri_id, &ep->rep_remote_cma);
+	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
 		goto out;
 
 	if (xprt->reestablish_timeout < RPCRDMA_INIT_REEST_TO)
 		xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
-	wait_event_interruptible(ep->rep_connect_wait, ep->rep_connected != 0);
-	if (ep->rep_connected <= 0) {
-		if (ep->rep_connected == -EAGAIN)
+	wait_event_interruptible(ep->re_connect_wait,
+				 ep->re_connect_status != 0);
+	if (ep->re_connect_status <= 0) {
+		if (ep->re_connect_status == -EAGAIN)
 			goto retry;
-		rc = ep->rep_connected;
+		rc = ep->re_connect_status;
 		goto out;
 	}
 
@@ -541,7 +539,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 
 out:
 	if (rc)
-		ep->rep_connected = rc;
+		ep->re_connect_status = rc;
 
 out_noupdate:
 	trace_xprtrdma_connect(r_xprt, rc);
@@ -558,9 +556,8 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	struct rdma_cm_id *id = ia->ri_id;
-	int rc, status = ep->rep_connected;
+	struct rdma_cm_id *id = ep->re_id;
+	int rc, status = ep->re_connect_status;
 
 	might_sleep();
 
@@ -569,10 +566,10 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 
 	rc = rdma_disconnect(id);
 	if (!rc)
-		wait_event_interruptible(ep->rep_connect_wait,
-							ep->rep_connected != 1);
+		wait_event_interruptible(ep->re_connect_wait,
+					 ep->re_connect_status != 1);
 	else
-		ep->rep_connected = rc;
+		ep->re_connect_status = rc;
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
 	if (id->qp)
@@ -585,10 +582,10 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_ep_destroy(r_xprt);
 
 	if (status == -ENODEV)
-		complete(&ia->ri_remove_done);
+		complete(&ep->re_remove_done);
 	else
 		rdma_destroy_id(id);
-	ia->ri_id = NULL;
+	ep->re_id = NULL;
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -625,7 +622,7 @@ static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ep *ep)
 {
 	struct rpcrdma_sendctx *sc;
 
-	sc = kzalloc(struct_size(sc, sc_sges, ep->rep_attr.cap.max_send_sge),
+	sc = kzalloc(struct_size(sc, sc_sges, ep->re_attr.cap.max_send_sge),
 		     GFP_KERNEL);
 	if (!sc)
 		return NULL;
@@ -645,7 +642,7 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 	 * the ->send_request call to fail temporarily before too many
 	 * Sends are posted.
 	 */
-	i = r_xprt->rx_ep.rep_max_requests + RPCRDMA_MAX_BC_REQUESTS;
+	i = r_xprt->rx_ep.re_max_requests + RPCRDMA_MAX_BC_REQUESTS;
 	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), GFP_KERNEL);
 	if (!buf->rb_sc_ctxs)
 		return -ENOMEM;
@@ -756,10 +753,10 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	unsigned int count;
 
-	for (count = 0; count < ia->ri_max_rdma_segs; count++) {
+	for (count = 0; count < ep->re_max_rdma_segs; count++) {
 		struct rpcrdma_mr *mr;
 		int rc;
 
@@ -808,7 +805,7 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 	/* If there is no underlying connection, it's no use
 	 * to wake the refresh worker.
 	 */
-	if (ep->rep_connected == 1) {
+	if (ep->re_connect_status == 1) {
 		/* The work is scheduled on a WQ_MEM_RECLAIM
 		 * workqueue in order to prevent MR allocation
 		 * from recursing into NFS during direct reclaim.
@@ -872,7 +869,7 @@ int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Compute maximum header buffer size in bytes */
 	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
-		     r_xprt->rx_ia.ri_max_rdma_segs * rpcrdma_readchunk_maxsz;
+		     r_xprt->rx_ep.re_max_rdma_segs * rpcrdma_readchunk_maxsz;
 	maxhdrsize *= sizeof(__be32);
 	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
 				  DMA_TO_DEVICE, GFP_KERNEL);
@@ -950,7 +947,7 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (rep == NULL)
 		goto out;
 
-	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep.rep_inline_recv,
+	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep.re_inline_recv,
 					       DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!rep->rr_rdmabuf)
 		goto out_free;
@@ -1175,7 +1172,7 @@ void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ia.ri_id->device,
+		ib_dma_unmap_sg(r_xprt->rx_ep.re_id->device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
@@ -1293,7 +1290,7 @@ bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size, gfp_t flags)
 bool __rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 			      struct rpcrdma_regbuf *rb)
 {
-	struct ib_device *device = r_xprt->rx_ia.ri_id->device;
+	struct ib_device *device = r_xprt->rx_ep.re_id->device;
 
 	if (rb->rg_direction == DMA_NONE)
 		return false;
@@ -1306,7 +1303,7 @@ bool __rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 	}
 
 	rb->rg_device = device;
-	rb->rg_iov.lkey = r_xprt->rx_ia.ri_pd->local_dma_lkey;
+	rb->rg_iov.lkey = r_xprt->rx_ep.re_pd->local_dma_lkey;
 	return true;
 }
 
@@ -1345,12 +1342,12 @@ int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc;
 
-	if (!ep->rep_send_count || kref_read(&req->rl_kref) > 1) {
+	if (!ep->re_send_count || kref_read(&req->rl_kref) > 1) {
 		send_wr->send_flags |= IB_SEND_SIGNALED;
-		ep->rep_send_count = ep->rep_send_batch;
+		ep->re_send_count = ep->re_send_batch;
 	} else {
 		send_wr->send_flags &= ~IB_SEND_SIGNALED;
-		--ep->rep_send_count;
+		--ep->re_send_count;
 	}
 
 	rc = frwr_send(r_xprt, req);
@@ -1378,9 +1375,9 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	count = 0;
 
 	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
-	if (likely(ep->rep_receive_count > needed))
+	if (likely(ep->re_receive_count > needed))
 		goto out;
-	needed -= ep->rep_receive_count;
+	needed -= ep->re_receive_count;
 	if (!temp)
 		needed += RPCRDMA_MAX_RECV_BATCH;
 
@@ -1406,7 +1403,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	if (!wr)
 		goto out;
 
-	rc = ib_post_recv(r_xprt->rx_ia.ri_id->qp, wr,
+	rc = ib_post_recv(r_xprt->rx_ep.re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count, rc);
@@ -1420,6 +1417,6 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 			--count;
 		}
 	}
-	ep->rep_receive_count += count;
+	ep->re_receive_count += count;
 	return;
 }
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8a3ac9d7ee81..f3c0b826c9ed 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -65,38 +65,32 @@
 #define RPCRDMA_IDLE_DISC_TO	(5U * 60 * HZ)
 
 /*
- * Interface Adapter -- one per transport instance
+ * RDMA Endpoint -- connection endpoint details
  */
-struct rpcrdma_ia {
-	struct rdma_cm_id 	*ri_id;
-	struct ib_pd		*ri_pd;
-	int			ri_async_rc;
-	unsigned int		ri_max_rdma_segs;
-	unsigned int		ri_max_frwr_depth;
-	bool			ri_implicit_roundup;
-	enum ib_mr_type		ri_mrtype;
-	struct completion	ri_done;
-	struct completion	ri_remove_done;
-};
-
-/*
- * RDMA Endpoint -- one per transport instance
- */
-
 struct rpcrdma_ep {
-	unsigned int		rep_send_count;
-	unsigned int		rep_send_batch;
-	unsigned int		rep_max_inline_send;
-	unsigned int		rep_max_inline_recv;
-	int			rep_connected;
-	struct ib_qp_init_attr	rep_attr;
-	wait_queue_head_t 	rep_connect_wait;
-	struct rpcrdma_connect_private	rep_cm_private;
-	struct rdma_conn_param	rep_remote_cma;
-	unsigned int		rep_max_requests;	/* depends on device */
-	unsigned int		rep_inline_send;	/* negotiated */
-	unsigned int		rep_inline_recv;	/* negotiated */
-	int			rep_receive_count;
+	struct rdma_cm_id 	*re_id;
+	struct ib_pd		*re_pd;
+	unsigned int		re_max_rdma_segs;
+	unsigned int		re_max_fr_depth;
+	bool			re_implicit_roundup;
+	enum ib_mr_type		re_mrtype;
+	struct completion	re_done;
+	struct completion	re_remove_done;
+	unsigned int		re_send_count;
+	unsigned int		re_send_batch;
+	unsigned int		re_max_inline_send;
+	unsigned int		re_max_inline_recv;
+	int			re_async_rc;
+	int			re_connect_status;
+	struct ib_qp_init_attr	re_attr;
+	wait_queue_head_t	re_connect_wait;
+	struct rpcrdma_connect_private
+				re_cm_private;
+	struct rdma_conn_param	re_remote_cma;
+	int			re_receive_count;
+	unsigned int		re_max_requests; /* depends on device */
+	unsigned int		re_inline_send;	/* negotiated */
+	unsigned int		re_inline_recv;	/* negotiated */
 };
 
 /* Pre-allocate extra Work Requests for handling backward receives
@@ -417,7 +411,6 @@ struct rpcrdma_stats {
  */
 struct rpcrdma_xprt {
 	struct rpc_xprt		rx_xprt;
-	struct rpcrdma_ia	rx_ia;
 	struct rpcrdma_ep	rx_ep;
 	struct rpcrdma_buffer	rx_buf;
 	struct delayed_work	rx_connect_worker;
@@ -522,8 +515,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
 void frwr_reset(struct rpcrdma_req *req);
-int frwr_query_device(struct rpcrdma_xprt *r_xprt,
-		      const struct ib_device *device);
+int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device);
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
@@ -555,7 +547,7 @@ int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 			      enum rpcrdma_chunktype rtype);
 void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc);
 int rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst);
-void rpcrdma_set_max_header_sizes(struct rpcrdma_xprt *);
+void rpcrdma_set_max_header_sizes(struct rpcrdma_ep *ep);
 void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_complete_rqst(struct rpcrdma_rep *rep);
 void rpcrdma_reply_handler(struct rpcrdma_rep *rep);

