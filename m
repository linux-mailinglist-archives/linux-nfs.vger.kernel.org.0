Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713312AC534
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgKITkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgKITkT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:40:19 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78815C0613CF;
        Mon,  9 Nov 2020 11:40:17 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so3149160qtq.13;
        Mon, 09 Nov 2020 11:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DHosaL+Sb7Y6JLGNhniF+42tH/ap+5Vpv6yh3Hr18Ao=;
        b=Ux0ivgNPHixR1GTpJcwhYreYuK0wa7mg67fSFDsw41K8xObWukFvjyNWq6PbmY9PmS
         z8+90T9oD9PM5ClV+QRJcwXz/P37wKgq/4XbFqMJPg5BRhTlDo9y3LYLe9HBHMv6kWV5
         UK6+/PS2nXAukYC5KVFlbw9VhJYxwXfBT2Hlo17Ac9JFOmYVGkbbNl6PWIVa92Jduq/C
         fzh5lKEp0iWziXmLM8H+jc0u0MyzXqPv7ih37Xk845yGSDzqgMlxdzGA5H9SvuNI+Jxu
         G5xMGMsnuCgBYW3hFFToz9cyiKbILrrh5/+Ynu2nN4VRzmbYjVu8lf03Ale8LUD/aqxR
         s9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DHosaL+Sb7Y6JLGNhniF+42tH/ap+5Vpv6yh3Hr18Ao=;
        b=RvhQYESTvEfw113SVcuT5wLgGPNw4sRlUI5ufylX7jvSnAq6l4u98cdF1mhdHy76S8
         gvYk2z3he4eqVUxAeCUAkltwNn+YjGLo9/y4xsUlLKaHH0rqtXP0rlRCaOYGjdZNmF09
         iYrtEr+48qDEkcoEIZLXeswVSm4M0FFAVoVYUFmtA2umj07M89MwshlvAVZ6fcKVcOWI
         c94xPsLtbpXZ2fngZ+EGzyTKcGc4/j3YvPjWWT6wwhkHpt+M7VoFdxC8Xyoajss7e/Qe
         Ppnw78Gp8u/fgMVKpv/RC79rdNMZjjiFwCpK8hShpthc4d16umuSti1WrfoT0Vk87dyb
         k6mA==
X-Gm-Message-State: AOAM533/WklBgbsoJlLSfAsAm+NaCui3FE9y/Ks2zd3KVmhtSFRXU4EA
        CoOSH8a8JnvHCiOGYQ1ye0F7ZYwJTAM=
X-Google-Smtp-Source: ABdhPJyPOkq+Mw/Dgx75znVt9HFVVR2ETvhoLFtahLFGWcgswi/yu6PFXqeYJupoPc0KhP+dnv4qTA==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr14389134qtw.151.1604950816334;
        Mon, 09 Nov 2020 11:40:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y14sm5070643qkj.56.2020.11.09.11.40.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JeEbW021835;
        Mon, 9 Nov 2020 19:40:14 GMT
Subject: [PATCH v1 12/13] xprtrdma: Move rpcrdma_mr_put()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:40:14 -0500
Message-ID: <160495081430.2072548.9094524166781301258.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: This function is now invoked only in frwr_ops.c. The move
enables deduplication of the trace_xprtrdma_mr_unmap() call site.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   41 +++++++++++++++++++++++++++------------
 net/sunrpc/xprtrdma/verbs.c     |   19 ------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 3 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index cb2f92409c2f..e93b3457b958 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -65,18 +65,23 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	kfree(mr);
 }
 
-static void frwr_mr_recycle(struct rpcrdma_mr *mr)
+static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-
-	trace_xprtrdma_mr_recycle(mr);
-
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
 		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
+}
+
+static void frwr_mr_recycle(struct rpcrdma_mr *mr)
+{
+	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+
+	trace_xprtrdma_mr_recycle(mr);
+
+	frwr_mr_unmap(r_xprt, mr);
 
 	spin_lock(&r_xprt->rx_buf.rb_lock);
 	list_del(&mr->mr_all);
@@ -86,6 +91,16 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 	frwr_release_mr(mr);
 }
 
+static void frwr_mr_put(struct rpcrdma_mr *mr)
+{
+	frwr_mr_unmap(mr->mr_xprt, mr);
+
+	/* The MR is returned to the req's MR free list instead
+	 * of to the xprt's MR free list. No spinlock is needed.
+	 */
+	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
+}
+
 /* frwr_reset - Place MRs back on the free list
  * @req: request to reset
  *
@@ -101,7 +116,7 @@ void frwr_reset(struct rpcrdma_req *req)
 	struct rpcrdma_mr *mr;
 
 	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
-		rpcrdma_mr_put(mr);
+		frwr_mr_put(mr);
 }
 
 /**
@@ -431,17 +446,17 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 	list_for_each_entry(mr, mrs, mr_list)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
-			rpcrdma_mr_put(mr);
+			frwr_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}
 }
 
-static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
+static void frwr_mr_done(struct ib_wc *wc, struct rpcrdma_mr *mr)
 {
 	if (wc->status != IB_WC_SUCCESS)
 		frwr_mr_recycle(mr);
 	else
-		rpcrdma_mr_put(mr);
+		frwr_mr_put(mr);
 }
 
 /**
@@ -459,7 +474,7 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li(wc, &frwr->fr_cid);
-	__frwr_release_mr(wc, mr);
+	frwr_mr_done(wc, mr);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
@@ -480,7 +495,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_wake(wc, &frwr->fr_cid);
-	__frwr_release_mr(wc, mr);
+	frwr_mr_done(wc, mr);
 	complete(&frwr->fr_linv_done);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
@@ -587,9 +602,9 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_done(wc, &frwr->fr_cid);
-	__frwr_release_mr(wc, mr);
+	frwr_mr_done(wc, mr);
 
-	/* Ensure @rep is generated before __frwr_release_mr */
+	/* Ensure @rep is generated before frwr_mr_done */
 	smp_rmb();
 	rpcrdma_complete_rqst(rep);
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 63837b5d14e5..ec912cf9c618 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1184,25 +1184,6 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 	return mr;
 }
 
-/**
- * rpcrdma_mr_put - DMA unmap an MR and release it
- * @mr: MR to release
- *
- */
-void rpcrdma_mr_put(struct rpcrdma_mr *mr)
-{
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-
-	if (mr->mr_dir != DMA_NONE) {
-		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
-				mr->mr_sg, mr->mr_nents, mr->mr_dir);
-		mr->mr_dir = DMA_NONE;
-	}
-
-	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
-}
-
 /**
  * rpcrdma_buffer_get - Get a request buffer
  * @buffers: Buffer pool from which to obtain a buffer
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index cef9d0f2e2c8..6a45bf241ec0 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -473,7 +473,6 @@ void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);
 struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt);
 
 struct rpcrdma_mr *rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt);
-void rpcrdma_mr_put(struct rpcrdma_mr *mr);
 void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt);
 
 struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);


