Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9F40095D
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Sep 2021 04:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbhIDCuf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Sep 2021 22:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhIDCuf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Sep 2021 22:50:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F338B60FE6;
        Sat,  4 Sep 2021 02:49:33 +0000 (UTC)
Subject: [PATCH RFC] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Sep 2021 22:49:33 -0400
Message-ID: <163072372272.1404.10422729715219338943.stgit@morisot.1015granger.net>
User-Agent: StGit/1.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a buffer to be left persistently registered while a
connection is up. Connection tear-down will automatically DMA-unmap,
invalidate, and dereg the MR. A persistently registered buffer makes
it no-cost to provide it, and it can never be elided into the RDMA
segment that backs the data payload.

An RPC that provisions a Write chunk with a non-aligned length
uses this MR rather than the tail buffer of the RPC's rq_rcv_buf.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   13 ++++++++++---
 net/sunrpc/xprtrdma/frwr_ops.c  |   35 +++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |   36 +++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/verbs.c     |    1 +
 net/sunrpc/xprtrdma/xprt_rdma.h |    5 +++++
 5 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bd55908c1bef..c71e106c9cd4 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -375,10 +375,16 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 
 	TP_fast_assign(
 		const struct rpcrdma_req *req = mr->mr_req;
-		const struct rpc_task *task = req->rl_slot.rq_task;
 
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		if (req) {
+			const struct rpc_task *task = req->rl_slot.rq_task;
+
+			__entry->task_id = task->tk_pid;
+			__entry->client_id = task->tk_client->cl_clid;
+		} else {
+			__entry->task_id = 0;
+			__entry->client_id = -1;
+		}
 		__entry->mr_id  = mr->mr_ibmr->res.id;
 		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
@@ -639,6 +645,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 DEFINE_RDCH_EVENT(read);
 DEFINE_WRCH_EVENT(write);
 DEFINE_WRCH_EVENT(reply);
+DEFINE_WRCH_EVENT(wp);
 
 TRACE_DEFINE_ENUM(rpcrdma_noch);
 TRACE_DEFINE_ENUM(rpcrdma_noch_pullup);
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 229fcc9a9064..6726fbbdd4a3 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -654,3 +654,38 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 */
 	rpcrdma_unpin_rqst(req->rl_reply);
 }
+
+/**
+ * frwr_wp_create - Create an MR for padding Write chunks
+ * @r_xprt: transport resources to use
+ *
+ * Return 0 on success, negative errno on failure.
+ */
+int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rpcrdma_mr_seg seg;
+	struct rpcrdma_mr *mr;
+
+	mr = rpcrdma_mr_get(r_xprt);
+	if (!mr)
+		return -EAGAIN;
+	mr->mr_req = NULL;
+	ep->re_write_pad_mr = mr;
+
+	seg.mr_len = XDR_UNIT;
+	seg.mr_page = virt_to_page(ep->re_write_pad);
+	seg.mr_offset = offset_in_page(ep->re_write_pad);
+	if (IS_ERR(frwr_map(r_xprt, &seg, 1, true, xdr_zero, mr)))
+		return -EIO;
+	trace_xprtrdma_mr_fastreg(mr);
+
+	mr->mr_cqe.done = frwr_wc_fastreg;
+	mr->mr_regwr.wr.next = NULL;
+	mr->mr_regwr.wr.wr_cqe = &mr->mr_cqe;
+	mr->mr_regwr.wr.num_sge = 0;
+	mr->mr_regwr.wr.opcode = IB_WR_REG_MR;
+	mr->mr_regwr.wr.send_flags = 0;
+
+	return ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
+}
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index c335c1361564..66fbfdc0c79f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -255,21 +255,9 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 		page_base = 0;
 	}
 
-	if (type == rpcrdma_readch)
-		goto out;
-
-	/* When encoding a Write chunk, some servers need to see an
-	 * extra segment for non-XDR-aligned Write chunks. The upper
-	 * layer provides space in the tail iovec that may be used
-	 * for this purpose.
-	 */
-	if (type == rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
-		goto out;
-
-	if (xdrbuf->tail[0].iov_len)
+	if (pos == 0 && xdrbuf->tail[0].iov_len)
 		rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
 
-out:
 	if (unlikely(n > RPCRDMA_MAX_SEGS))
 		return -EIO;
 	return n;
@@ -405,6 +393,7 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 				     enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct rpcrdma_mr_seg *seg;
 	struct rpcrdma_mr *mr;
 	int nsegs, nchunks;
@@ -443,6 +432,27 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 		nsegs -= mr->mr_nents;
 	} while (nsegs);
 
+	/* The pad MR is already registered, and is not chained on
+	 * rl_registered. Thus the Reply handler does not invalidate it.
+	 *
+	 * To avoid accidental remote invalidation of this MR, it is
+	 * not used when remote invalidation is enabled. Servers that
+	 * support remote invalidation are known not to write into
+	 * Write chunk pad segments.
+	 */
+	if (ep->re_implicit_roundup &&
+	    xdr_pad_size(rqst->rq_rcv_buf.page_len)) {
+		if (encode_rdma_segment(xdr, ep->re_write_pad_mr) < 0)
+			return -EMSGSIZE;
+
+		trace_xprtrdma_chunk_wp(rqst->rq_task, ep->re_write_pad_mr,
+					nsegs);
+		r_xprt->rx_stats.write_chunk_count++;
+		r_xprt->rx_stats.total_rdma_request += mr->mr_length;
+		nchunks++;
+		nsegs -= mr->mr_nents;
+	}
+
 	/* Update count of segments in this Write chunk */
 	*segcount = cpu_to_be32(nchunks);
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 649c23518ec0..7fa55f219638 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -551,6 +551,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 		goto out;
 	}
 	rpcrdma_mrs_create(r_xprt);
+	frwr_wp_create(r_xprt);
 
 out:
 	trace_xprtrdma_connect(r_xprt, rc);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5d231d94e944..c71e6e1b82b9 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -68,12 +68,14 @@
 /*
  * RDMA Endpoint -- connection endpoint details
  */
+struct rpcrdma_mr;
 struct rpcrdma_ep {
 	struct kref		re_kref;
 	struct rdma_cm_id 	*re_id;
 	struct ib_pd		*re_pd;
 	unsigned int		re_max_rdma_segs;
 	unsigned int		re_max_fr_depth;
+	struct rpcrdma_mr	*re_write_pad_mr;
 	bool			re_implicit_roundup;
 	enum ib_mr_type		re_mrtype;
 	struct completion	re_done;
@@ -97,6 +99,8 @@ struct rpcrdma_ep {
 	unsigned int		re_inline_recv;	/* negotiated */
 
 	atomic_t		re_completion_ids;
+
+	char			re_write_pad[XDR_UNIT];
 };
 
 /* Pre-allocate extra Work Requests for handling reverse-direction
@@ -535,6 +539,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
+int frwr_wp_create(struct rpcrdma_xprt *r_xprt);
 
 /*
  * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c


