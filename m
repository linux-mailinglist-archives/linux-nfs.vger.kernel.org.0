Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162FD95117
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHSWqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:46:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33915 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfHSWqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:46:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so3248744otp.1;
        Mon, 19 Aug 2019 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K76ockKaA/dKCETBDEOaS16txechlXh3Dbav1CV2dDY=;
        b=kO1RYwjkQhokuEPBEw3TrOzPrpB8qX6r9gvwRBMwLqo1hOolFiBqtsuhZ8APSD5Iln
         kq/BzCzXi/2nOaOpAGqBLVhUkcwLdRegdaZ9JgS93FvFP6+Rhme1OsWpZH7XMHmrEtlR
         RjOf7E5DyndzjGwQCBoJ9/s7O9oWGbe7HZEClpyt1qI9b6c1iSes2xV7QLg9gSsHSE/u
         Tr0TvX1f2GlZGK5W9XV3C+XWLyvYhUYKiLhPE6xhnpWz1LBbcZ5zbKPEetUDvT9lGzLs
         VOwaTF+9RO53l8OwTdLpwf9Igmyp8HPXJb0o+i/llskygk5x+YP4OuRiqbgTjD0gc6gM
         aTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=K76ockKaA/dKCETBDEOaS16txechlXh3Dbav1CV2dDY=;
        b=q3YTkLt71uCtY+/Wr2Wvo8C4cfT8LQOP+4sqgvMDaW5pEojwRKUIGhjQHJQN0Izrlu
         qLqy/ATWu/h9qfrTTXf+3VGmqFlW+DwFm8VrRW7fazen9kfgqVOxkUeJdkfwgPgV3i4C
         fjYlSKkbmu/eRpunsXbwHPMI9X++x7eu8jAv7Z8aOjyFrQh3HNrdXN3EhbV9zDvftwTn
         HPAM1Wh2q80R4fgmjBjIvOTQcC/0lNfAblrBD6AnXGPafNrnWVYiPA6GVOZFc5jX0opr
         L/uvo35eGoCHC+Mg0mcSO6b0BBJ9EjAnVOKc0Mmu6IOjvigQxBCah6RfuPDUSrre8uz7
         2Muw==
X-Gm-Message-State: APjAAAWcHXd1ay2HNO7INuHKWUQILH41KFH3Six2DvGUrF797i1zqP2a
        uDaHHIkBSj/opBnq0rlqmnaGC/rb
X-Google-Smtp-Source: APXvYqxLcJqeCCm+4/iGTm1ZuW5zWD0Qtzf2FH6FQkS12RagFdWAguHW7A6jrargiYmb0+Eh+2QjMQ==
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr19043049oth.167.1566254758861;
        Mon, 19 Aug 2019 15:45:58 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id g7sm5922208otp.20.2019.08.19.15.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:45:58 -0700 (PDT)
Subject: [PATCH v2 13/21] xprtrdma: Move rpcrdma_mr_get out of frwr_map
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:45:37 -0400
Message-ID: <156625471731.8161.15138263031991137209.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
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
index 6e6055eb67e7..83c4dfd7feea 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -464,7 +464,34 @@ TRACE_EVENT(xprtrdma_createmrs,
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
index 97e1804139b8..362056f4f48d 100644
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
index 0ac096a6348a..34772cb19286 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -342,6 +342,27 @@ encode_read_segment(struct xdr_stream *xdr, struct rpcrdma_mr *mr,
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
@@ -379,10 +400,9 @@ rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
 		return nsegs;
 
 	do {
-		seg = frwr_map(r_xprt, seg, nsegs, false, rqst->rq_xid, &mr);
+		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, false, &mr);
 		if (IS_ERR(seg))
 			return PTR_ERR(seg);
-		rpcrdma_mr_push(mr, &req->rl_registered);
 
 		if (encode_read_segment(xdr, mr, pos) < 0)
 			return -EMSGSIZE;
@@ -440,10 +460,9 @@ rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
 
 	nchunks = 0;
 	do {
-		seg = frwr_map(r_xprt, seg, nsegs, true, rqst->rq_xid, &mr);
+		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, true, &mr);
 		if (IS_ERR(seg))
 			return PTR_ERR(seg);
-		rpcrdma_mr_push(mr, &req->rl_registered);
 
 		if (encode_rdma_segment(xdr, mr) < 0)
 			return -EMSGSIZE;
@@ -501,10 +520,9 @@ rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
 
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
index 5e0b774ed522..c9fa0f27b10a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -408,7 +408,7 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	struct rpcrdma_req *req;
 	struct rpcrdma_rep *rep;
 
-	cancel_delayed_work_sync(&buf->rb_refresh_worker);
+	cancel_work_sync(&buf->rb_refresh_worker);
 
 	/* This is similar to rpcrdma_ep_destroy, but:
 	 * - Don't cancel the connect worker.
@@ -975,7 +975,7 @@ static void
 rpcrdma_mr_refresh_worker(struct work_struct *work)
 {
 	struct rpcrdma_buffer *buf = container_of(work, struct rpcrdma_buffer,
-						  rb_refresh_worker.work);
+						  rb_refresh_worker);
 	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
 						   rx_buf);
 
@@ -1086,8 +1086,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
 	INIT_LIST_HEAD(&buf->rb_all_mrs);
-	INIT_DELAYED_WORK(&buf->rb_refresh_worker,
-			  rpcrdma_mr_refresh_worker);
+	INIT_WORK(&buf->rb_refresh_worker, rpcrdma_mr_refresh_worker);
 
 	rpcrdma_mrs_create(r_xprt);
 
@@ -1177,7 +1176,7 @@ rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
-	cancel_delayed_work_sync(&buf->rb_refresh_worker);
+	cancel_work_sync(&buf->rb_refresh_worker);
 
 	rpcrdma_sendctxs_destroy(buf);
 
@@ -1218,19 +1217,7 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
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
index 3e0839c2cda2..9573587ca602 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -379,7 +379,7 @@ struct rpcrdma_buffer {
 	u32			rb_bc_srv_max_requests;
 	u32			rb_bc_max_requests;
 
-	struct delayed_work	rb_refresh_worker;
+	struct work_struct	rb_refresh_worker;
 };
 
 /*
@@ -548,7 +548,7 @@ size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
-				struct rpcrdma_mr **mr);
+				struct rpcrdma_mr *mr);
 int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);

