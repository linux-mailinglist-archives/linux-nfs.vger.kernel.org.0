Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177B5835E1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfHFPym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34612 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPym (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so6654503oil.1;
        Tue, 06 Aug 2019 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/n4fF/rwBeYoOhsSkfgsGJuK3doa6tbLd5wCrWLndgs=;
        b=Lj5ZpQ7yFMKRDGVgLRy89vIRVPNwYgo7AH5otrrCb1EhoPSGey0ArQ4/L4g9R+ZAN3
         /hzGSmEzLzectpURgi0TwaD3F6y6y4A/AV0Cq7mewFpHpqcZdVhxWfklAAI6rTLNjYqP
         99NdnTZVvBw3AQ93yuXmsUvNQgaRkoyCyhjFCXX8hNRxvXC7iKeCC/o6qgrp2LxxytOB
         g2nMONJXXFv5iZdh+gX0CdQxhhJyJvi7ns6+NcGY1EeAiuwD8Jd5Y3X/2BHFBTWrLZrC
         UOegH9Jp/vjYgF4lO+v3Gha0rBR8JwX7GGz0rjvkWE8osIJA1WxiyvHmu7bYzztL41Az
         Yplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/n4fF/rwBeYoOhsSkfgsGJuK3doa6tbLd5wCrWLndgs=;
        b=pkrOEnzNSbwKE3HX+24FTNTC+Iug0mqWNxylZDBHeIXcOSXdMLmNordyiodpDxyu/c
         znztGrqFb9jwKFMyaClUe8fnbQznIrXxhd5nWB4r4P5m0nEJZYQp0pssY41zhMxd+Rd1
         mPxcErH7yR1dKGKaK86OLu/cLFLbiDIRSRyUO4IYqyozgWz5EgBtY3XDiNVaXU4UBzLB
         Q4k6hyjwpnhvXlTs6XV3UU9IOk04ft3gEcYUB0emEWCJijUiK7qidkFKdLrgmC3zw4I3
         3MpxebssVK9NTbmGj3LQBQctuNU7yiIqtCmbpOFpzMuRC67Wpnu9LvlOxbBHH/JRqMuN
         JklA==
X-Gm-Message-State: APjAAAWMsMESJGgy5SSrlorOT97da8Ytrd75LgS9SW84kF52WHPWk1dU
        Y+evzBj+nnPpKeNqUzJN9/QEd34r
X-Google-Smtp-Source: APXvYqwiA/tKCM0ov0tHPf1BQ5cPBIql/1dqNU6EHPr9aIRW69SYFsz1XWGiRc9De5JW7yiYOHwBZA==
X-Received: by 2002:a02:b88b:: with SMTP id p11mr4895447jam.144.1565106880696;
        Tue, 06 Aug 2019 08:54:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c17sm65830513ioo.82.2019.08.06.08.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:40 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fsd7V011541;
        Tue, 6 Aug 2019 15:54:39 GMT
Subject: [PATCH v1 10/18] xprtrdma: Move rpcrdma_mr_get out of frwr_map
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:39 -0400
Message-ID: <20190806155439.9529.42333.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Retrieve an MR and handle error recovery entirely in
rpc_rdma.c, as this is not a device-specific function.

Note that since commit 89f90fe1ad8b ("SUNRPC: Allow calls to
xprt_transmit() to drain the entire transmit queue"), the
xprt_transmit function handles the cond_resched. The transport no
longer has to do this itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   29 ++++++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/frwr_ops.c  |   23 +++++------------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |   30 ++++++++++++++++++++++++------
 net/sunrpc/xprtrdma/verbs.c     |   21 ++++-----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    4 ++--
 5 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 6e6055e..83c4dfd 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -464,7 +464,34 @@
 	)
 );
 
-DEFINE_RXPRT_EVENT(xprtrdma_nomrs);
+TRACE_EVENT(xprtrdma_nomrs,
+	TP_PROTO(
+		const struct rpcrdma_req *req
+	),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__field(const void *, req)
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+	),
+
+	TP_fast_assign(
+		const struct rpc_rqst *rqst = &req->rl_slot;
+
+		__entry->req = req;
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x req=%p",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__entry->req
+	)
+);
 
 DEFINE_RDCH_EVENT(read);
 DEFINE_WRCH_EVENT(write);
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 97e1804..362056f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -291,31 +291,25 @@ size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt)
  * @nsegs: number of segments remaining
  * @writing: true when RDMA Write will be used
  * @xid: XID of RPC using the registered memory
- * @out: initialized MR
+ * @mr: MR to fill in
  *
  * Prepare a REG_MR Work Request to register a memory region
  * for remote access via RDMA READ or RDMA WRITE.
  *
  * Returns the next segment or a negative errno pointer.
- * On success, the prepared MR is planted in @out.
+ * On success, @mr is filled in.
  */
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
-				struct rpcrdma_mr **out)
+				struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	bool holes_ok = ia->ri_mrtype == IB_MR_TYPE_SG_GAPS;
-	struct rpcrdma_mr *mr;
-	struct ib_mr *ibmr;
 	struct ib_reg_wr *reg_wr;
+	struct ib_mr *ibmr;
 	int i, n;
 	u8 key;
 
-	mr = rpcrdma_mr_get(r_xprt);
-	if (!mr)
-		goto out_getmr_err;
-
 	if (nsegs > ia->ri_max_frwr_depth)
 		nsegs = ia->ri_max_frwr_depth;
 	for (i = 0; i < nsegs;) {
@@ -330,7 +324,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 
 		++seg;
 		++i;
-		if (holes_ok)
+		if (ia->ri_mrtype == IB_MR_TYPE_SG_GAPS)
 			continue;
 		if ((i < nsegs && offset_in_page(seg->mr_offset)) ||
 		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
@@ -365,22 +359,15 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	mr->mr_offset = ibmr->iova;
 	trace_xprtrdma_mr_map(mr);
 
-	*out = mr;
 	return seg;
 
-out_getmr_err:
-	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
-	return ERR_PTR(-EAGAIN);
-
 out_dmamap_err:
 	mr->mr_dir = DMA_NONE;
 	trace_xprtrdma_frwr_sgerr(mr, i);
-	rpcrdma_mr_put(mr);
 	return ERR_PTR(-EIO);
 
 out_mapmr_err:
 	trace_xprtrdma_frwr_maperr(mr, n);
-	rpcrdma_mr_recycle(mr);
 	return ERR_PTR(-EIO);
 }
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0ac096a..34772cb1 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -342,6 +342,27 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	return 0;
 }
 
+static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
+						 struct rpcrdma_req *req,
+						 struct rpcrdma_mr_seg *seg,
+						 int nsegs, bool writing,
+						 struct rpcrdma_mr **mr)
+{
+	*mr = rpcrdma_mr_get(r_xprt);
+	if (!*mr)
+		goto out_getmr_err;
+
+	rpcrdma_mr_push(*mr, &req->rl_registered);
+	return frwr_map(r_xprt, seg, nsegs, writing, req->rl_slot.rq_xid, *mr);
+
+out_getmr_err:
+	trace_xprtrdma_nomrs(req);
+	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
+	if (r_xprt->rx_ep.rep_connected != -ENODEV)
+		schedule_work(&r_xprt->rx_buf.rb_refresh_worker);
+	return ERR_PTR(-EAGAIN);
+}
+
 /* Register and XDR encode the Read list. Supports encoding a list of read
  * segments that belong to a single read chunk.
  *
@@ -379,10 +400,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 		return nsegs;
 
 	do {
-		seg = frwr_map(r_xprt, seg, nsegs, false, rqst->rq_xid, &mr);
+		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, false, &mr);
 		if (IS_ERR(seg))
 			return PTR_ERR(seg);
-		rpcrdma_mr_push(mr, &req->rl_registered);
 
 		if (encode_read_segment(xdr, mr, pos) < 0)
 			return -EMSGSIZE;
@@ -440,10 +460,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 
 	nchunks = 0;
 	do {
-		seg = frwr_map(r_xprt, seg, nsegs, true, rqst->rq_xid, &mr);
+		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, true, &mr);
 		if (IS_ERR(seg))
 			return PTR_ERR(seg);
-		rpcrdma_mr_push(mr, &req->rl_registered);
 
 		if (encode_rdma_segment(xdr, mr) < 0)
 			return -EMSGSIZE;
@@ -501,10 +520,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 
 	nchunks = 0;
 	do {
-		seg = frwr_map(r_xprt, seg, nsegs, true, rqst->rq_xid, &mr);
+		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, true, &mr);
 		if (IS_ERR(seg))
 			return PTR_ERR(seg);
-		rpcrdma_mr_push(mr, &req->rl_registered);
 
 		if (encode_rdma_segment(xdr, mr) < 0)
 			return -EMSGSIZE;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 107116b..0d6c3b6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -407,7 +407,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_req *req;
 	struct rpcrdma_rep *rep;
 
-	cancel_delayed_work_sync(&buf->rb_refresh_worker);
+	cancel_work_sync(&buf->rb_refresh_worker);
 
 	/* This is similar to rpcrdma_ep_destroy, but:
 	 * - Don't cancel the connect worker.
@@ -973,7 +973,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 rpcrdma_mr_refresh_worker(struct work_struct *work)
 {
 	struct rpcrdma_buffer *buf = container_of(work, struct rpcrdma_buffer,
-						  rb_refresh_worker.work);
+						  rb_refresh_worker);
 	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
 						   rx_buf);
 
@@ -1078,8 +1078,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
 	INIT_LIST_HEAD(&buf->rb_all_mrs);
-	INIT_DELAYED_WORK(&buf->rb_refresh_worker,
-			  rpcrdma_mr_refresh_worker);
+	INIT_WORK(&buf->rb_refresh_worker, rpcrdma_mr_refresh_worker);
 
 	rpcrdma_mrs_create(r_xprt);
 
@@ -1169,7 +1168,7 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
 void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
-	cancel_delayed_work_sync(&buf->rb_refresh_worker);
+	cancel_work_sync(&buf->rb_refresh_worker);
 
 	rpcrdma_sendctxs_destroy(buf);
 
@@ -1210,19 +1209,7 @@ struct rpcrdma_mr *
 	spin_lock(&buf->rb_mrlock);
 	mr = rpcrdma_mr_pop(&buf->rb_mrs);
 	spin_unlock(&buf->rb_mrlock);
-	if (!mr)
-		goto out_nomrs;
 	return mr;
-
-out_nomrs:
-	trace_xprtrdma_nomrs(r_xprt);
-	if (r_xprt->rx_ep.rep_connected != -ENODEV)
-		schedule_delayed_work(&buf->rb_refresh_worker, 0);
-
-	/* Allow the reply handler and refresh worker to run */
-	cond_resched();
-
-	return NULL;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 345158b..1f76fa34 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -384,7 +384,7 @@ struct rpcrdma_buffer {
 	u32			rb_bc_srv_max_requests;
 	u32			rb_bc_max_requests;
 
-	struct delayed_work	rb_refresh_worker;
+	struct work_struct	rb_refresh_worker;
 };
 
 /*
@@ -553,7 +553,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
-				struct rpcrdma_mr **mr);
+				struct rpcrdma_mr *mr);
 int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);

