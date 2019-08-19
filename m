Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462E69511C
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSWrd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:47:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32823 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWrd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:47:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so3261320otl.0;
        Mon, 19 Aug 2019 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OHp3dI4bNSLqfi7jMEsyKOlcekkjcDgj+SJCxIQrhWU=;
        b=DeSVbJGWXYaPORN2UCo0rskzIABFZEOIJBnqt5wNp/xSDq1fXC49T7IR0ZWctcP4O9
         qC9kzaYdr4KALHsujN/hYthPxCRd2ceI35ML2ZQPWWpkgZ2Kg+M7v+gkVRrimXOCqxde
         HFf5SO6vIR1qS3GyepkSZ9DVu4WxQnmFnGY7xD2mYZn3YKy5gKonYLt6Eikne32XUYaR
         zfMF6ov/pUCvvi9dDcP0Ydc4qvR1++eYIM4O7he6Zh//SSLr8Jq8EokrbuUHEgGbosZU
         S/OjLFqvEKWpKOyt4TLDdfyjBTKrxC/W0AuufAHJU+ATneShB8IqUdBRKpL/sVeoV1nz
         Tl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OHp3dI4bNSLqfi7jMEsyKOlcekkjcDgj+SJCxIQrhWU=;
        b=L7lkcH2/xia9/Bw2volKBFqhywzAZzbWvFoG8Yp2FmQoEOo0k7Bvp4Y4+Kz6cOdHS0
         SEW623AVVcGG1Kt4kKYU0qYJnrsbuZFzjiECts47F4g4yH+yVjcAHjY3GeQ3E4490W0e
         tRsz5MvtTQKL7gb10Njl/z0B30hqU0TQr6/5Y4qkVpkUTTOWUi8+Px5YbI4Ni6lD5akO
         GwJ2jdwxcsHy/kgjdaEpIZIqWpc30lSfJlN2Kfx6BnkjIL+JBMbeTMzn3Sgx43/VNgmH
         yQVnPbzKj056MFk6UACDilDHmc3GN/XfuhCZWHjou+9pWi1vbcglI/iUWa6gjC5PnHin
         eqrA==
X-Gm-Message-State: APjAAAW+ATIoiYiaSV2t8gRlXa2YDaB6XpEOFdW7mLamHoZzCvRLymZB
        QNEFKW5tsEF4/zAS5Bg7JAp78awQ
X-Google-Smtp-Source: APXvYqy3lrPcPZT3WdyqFbEvfIq2rshVtyMV/lHMeepQXxz7DIqMK8o7GwmWr1X2HFtDqP+2a5FT6w==
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr3758247otk.107.1566254851884;
        Mon, 19 Aug 2019 15:47:31 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id 20sm5997463oth.43.2019.08.19.15.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:47:31 -0700 (PDT)
Subject: [PATCH v2 15/21] xprtrdma: Cache free MRs in each rpcrdma_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:47:10 -0400
Message-ID: <156625481040.8161.13621119408884656142.stgit@seurat29.1015granger.net>
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
index 83c4dfd7feea..a13830616107 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -451,16 +451,50 @@ TRACE_EVENT(xprtrdma_createmrs,
 
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
index 1f2e3dda7401..0e740bae2d80 100644
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
index 34772cb19286..ffeb4dfebd46 100644
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
index cb6df58488bb..69753ec73c36 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -77,6 +77,7 @@
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
+static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -1022,6 +1023,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	if (!req->rl_recvbuf)
 		goto out4;
 
+	INIT_LIST_HEAD(&req->rl_free_mrs);
 	INIT_LIST_HEAD(&req->rl_registered);
 	spin_lock(&buffer->rb_lock);
 	list_add(&req->rl_all, &buffer->rb_allreqs);
@@ -1130,11 +1132,13 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
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
@@ -1228,7 +1232,6 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -1237,6 +1240,15 @@ void rpcrdma_mr_put(struct rpcrdma_mr *mr)
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
index 9573587ca602..c375b0e434ac 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -234,20 +234,20 @@ struct rpcrdma_sendctx {
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
@@ -325,7 +325,8 @@ struct rpcrdma_req {
 	struct list_head	rl_all;
 	struct kref		rl_kref;
 
-	struct list_head	rl_registered;	/* registered segments */
+	struct list_head	rl_free_mrs;
+	struct list_head	rl_registered;
 	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 };
 

