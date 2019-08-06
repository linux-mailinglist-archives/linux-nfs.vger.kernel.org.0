Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03781835E6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfHFPyw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43828 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbfHFPyw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so67348990oif.10;
        Tue, 06 Aug 2019 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sBsikdEOoMNybEfujZtlex3Gfy7kx+MR7MnfzesFRgg=;
        b=u0fJ5ykP5GZ92SmwU6iu8fOVx3/1kTWt0oLHDL56V2CIKOG47SBX7g9+7F7I2E4R58
         D4AlBzZ4vSpFQZqbs8A8EOLSQYuzw6H4BXB3UL8kwaDowqayscyM/VnDsgtfbZvDNjMR
         q4HvdKRAc5jTCBSXJtvIZvY627FUJzGfSy9E80GJbePaqMKN+AZFYtK/8t8TgfxF7bTp
         sTcRL2DkqgohNPABPrfwI0SNJpr+/eIeBknINIjq0uFfzMr+RK3JPmwPfyFzdr8MBNNo
         pa4etUssxs0Savgh87MLBZL/TWZ0Osy44Aiuou4sErPvtuUYx0EXxLqM2NF47lzB7Wkl
         w1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sBsikdEOoMNybEfujZtlex3Gfy7kx+MR7MnfzesFRgg=;
        b=Thw83feEQuSGXp4wRx5sqcXJaYsStlhwx17KmZVR5vGVt2Lelq4DQxPp8GiVPrFOfl
         beabMvfm5ifeZyLfVRwLV72dZkU7KOGhoeFFudIQ0J7xUxoXDtn7RQajL0RIBt8t8aFW
         is6M4kLJGB6ehmpcpmQSrR4x4Wpmcsmec/1JxLQHmTObIi8Z+CAev5itME01OtwP4SXZ
         mXYGZKnqUW4YJ7TouiO6i3Pl4dLGKrmHAC8ezH0+pPA8xkynDRm3RangyWiNIi+VPqhP
         48cqGKxobL9o3aUn62RwzSVEuA3iNK+qSxkFxmb4JmfyOM17mqp3gJxbvnvFqOiUPjGK
         paUQ==
X-Gm-Message-State: APjAAAUVwq3t8yPvujbOxzI6CZfc0Q2PwUM4a3JMn4Aa57UIZRZIHPzx
        tJPEZjp4eD4b4QRns8wqbOYN8nHW
X-Google-Smtp-Source: APXvYqzpAZvMPfMlbMq147/0TbrsL3YifobUo/VmealNlTq979fLliZbTi7jaOipWRVflvvp8QBYfA==
X-Received: by 2002:a02:340d:: with SMTP id x13mr4903186jae.125.1565106891214;
        Tue, 06 Aug 2019 08:54:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q22sm69356816ioj.56.2019.08.06.08.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:50 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fso19011547;
        Tue, 6 Aug 2019 15:54:50 GMT
Subject: [PATCH v1 12/18] xprtrdma: Cache free MRs in each rpcrdma_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:50 -0400
Message-ID: <20190806155450.9529.66387.stgit@manet.1015granger.net>
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

Instead of a globally-contended MR free list, cache MRs in each
rpcrdma_req as they are released. This means acquiring and releasing
an MR will be lock-free in the common case, even outside the
transport send lock.

The original idea of per-rpcrdma_req MR free lists was suggested by
Shirley Ma <shirley.ma@oracle.com> several years ago. I just now
figured out how to make that idea work with on-demand MR allocation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   38 ++++++++++++++++++++++++++++++++++++--
 net/sunrpc/xprtrdma/frwr_ops.c  |    9 ++++++---
 net/sunrpc/xprtrdma/rpc_rdma.c  |   11 ++++++++---
 net/sunrpc/xprtrdma/verbs.c     |   18 +++++++++++++++---
 net/sunrpc/xprtrdma/xprt_rdma.h |    7 ++++---
 5 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 83c4dfd..a138306 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -451,16 +451,50 @@
 
 	TP_STRUCT__entry(
 		__field(const void *, r_xprt)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
 		__field(unsigned int, count)
 	),
 
 	TP_fast_assign(
 		__entry->r_xprt = r_xprt;
 		__entry->count = count;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("r_xprt=%p: created %u MRs",
-		__entry->r_xprt, __entry->count
+	TP_printk("peer=[%s]:%s r_xprt=%p: created %u MRs",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->count
+	)
+);
+
+TRACE_EVENT(xprtrdma_mr_get,
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
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 1f2e3dd..0e740ba 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -488,8 +488,8 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_wake(wc, frwr);
-	complete(&frwr->fr_linv_done);
 	__frwr_release_mr(wc, mr);
+	complete(&frwr->fr_linv_done);
 }
 
 /**
@@ -587,11 +587,15 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_frwr *frwr =
 		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+	struct rpcrdma_rep *rep = mr->mr_req->rl_reply;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_done(wc, frwr);
-	rpcrdma_complete_rqst(frwr->fr_req->rl_reply);
 	__frwr_release_mr(wc, mr);
+
+	/* Ensure @rep is generated before __frwr_release_mr */
+	smp_rmb();
+	rpcrdma_complete_rqst(rep);
 }
 
 /**
@@ -624,7 +628,6 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
-		frwr->fr_req = req;
 		last = &frwr->fr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 34772cb1..ffeb4df 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -348,9 +348,14 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
 						 int nsegs, bool writing,
 						 struct rpcrdma_mr **mr)
 {
-	*mr = rpcrdma_mr_get(r_xprt);
-	if (!*mr)
-		goto out_getmr_err;
+	*mr = rpcrdma_mr_pop(&req->rl_free_mrs);
+	if (!*mr) {
+		*mr = rpcrdma_mr_get(r_xprt);
+		if (!*mr)
+			goto out_getmr_err;
+		trace_xprtrdma_mr_get(req);
+		(*mr)->mr_req = req;
+	}
 
 	rpcrdma_mr_push(*mr, &req->rl_registered);
 	return frwr_map(r_xprt, seg, nsegs, writing, req->rl_slot.rq_xid, *mr);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1fcbe92..1940ffc 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -76,6 +76,7 @@
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
+static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -1014,6 +1015,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	if (!req->rl_recvbuf)
 		goto out4;
 
+	INIT_LIST_HEAD(&req->rl_free_mrs);
 	INIT_LIST_HEAD(&req->rl_registered);
 	spin_lock(&buffer->rb_lock);
 	list_add(&req->rl_all, &buffer->rb_allreqs);
@@ -1122,11 +1124,13 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
  * This function assumes that the caller prevents concurrent device
  * unload and transport tear-down.
  */
-void
-rpcrdma_req_destroy(struct rpcrdma_req *req)
+void rpcrdma_req_destroy(struct rpcrdma_req *req)
 {
 	list_del(&req->rl_all);
 
+	while (!list_empty(&req->rl_free_mrs))
+		rpcrdma_mr_free(rpcrdma_mr_pop(&req->rl_free_mrs));
+
 	rpcrdma_regbuf_free(req->rl_recvbuf);
 	rpcrdma_regbuf_free(req->rl_sendbuf);
 	rpcrdma_regbuf_free(req->rl_rdmabuf);
@@ -1220,7 +1224,6 @@ struct rpcrdma_mr *
 void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -1229,6 +1232,15 @@ void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 		mr->mr_dir = DMA_NONE;
 	}
 
+	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
+}
+
+static void rpcrdma_mr_free(struct rpcrdma_mr *mr)
+{
+	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+
+	mr->mr_req = NULL;
 	spin_lock(&buf->rb_mrlock);
 	rpcrdma_mr_push(mr, &buf->rb_mrs);
 	spin_unlock(&buf->rb_mrlock);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 1f76fa34..6c9830a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -239,20 +239,20 @@ struct rpcrdma_sendctx {
  * An external memory region is any buffer or page that is registered
  * on the fly (ie, not pre-registered).
  */
-struct rpcrdma_req;
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
 	struct ib_cqe			fr_cqe;
 	struct completion		fr_linv_done;
-	struct rpcrdma_req		*fr_req;
 	union {
 		struct ib_reg_wr	fr_regwr;
 		struct ib_send_wr	fr_invwr;
 	};
 };
 
+struct rpcrdma_req;
 struct rpcrdma_mr {
 	struct list_head	mr_list;
+	struct rpcrdma_req	*mr_req;
 	struct scatterlist	*mr_sg;
 	int			mr_nents;
 	enum dma_data_direction	mr_dir;
@@ -330,7 +330,8 @@ struct rpcrdma_req {
 	struct list_head	rl_all;
 	struct kref		rl_kref;
 
-	struct list_head	rl_registered;	/* registered segments */
+	struct list_head	rl_free_mrs;
+	struct list_head	rl_registered;
 	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 };
 

