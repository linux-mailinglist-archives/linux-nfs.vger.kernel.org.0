Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB72CE7D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfE1SVg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56007 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SVg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:36 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so5950881iti.5;
        Tue, 28 May 2019 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aL7FW6mmLTyhjWDMwg6TWQ+5TITczlqjWNyicyO6aZY=;
        b=E+nMtPUQdGvT1SqiAO098Vb+8EbjIUpXaiULZ7fFbeHGOxqVDGNShzJfBY+Ik1CZqN
         lh5Rrjxw8qH+CSor4TnvMAhWQ/QlbuMiS2PraAghp2lqkRbZXSnrUbBMC53rJV+g/UIb
         MHqLwr2jQVSMBOdvg0PGxu43TNnNo1+qGezUdvKaKEQGTSyxh28LoOCnIhc7eGQsRtZE
         x/vwdk3TXMx2dQwn2SxxRYCf6zBUpUguWN3dUfcwLyld7GXXmLFjDO1SbqoEhas/k+mt
         KgbQvh2R8Y+P4oWbG5XPwoKSx6RrHBXpLQ4+6T+TgKSzNQq4NGLD8uLxS+55s2FzS17d
         HLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aL7FW6mmLTyhjWDMwg6TWQ+5TITczlqjWNyicyO6aZY=;
        b=H1b0Fc51UnVTe5nxk2bIL6TzKuEuJf6J/2ByQuR2QIHMtF0GMG1M7sFYwdeKMFxiof
         YGTg8frhsz7rSr1pXmupSn2f9XYLEq9bsoeNZ1RQATbRuf+TQ6CVNr6N0dB0ncsaoqFk
         Q8tj+tRBV58VCmJf4G9N++w7kuPXXUg+YEqhBqogQHkNm3odQEeeLJg6GUqij9DffwFp
         J9BJ2G1W3sABZYDAANxrg7yz5gXVBXiia5+51YRVo8/TwR1yH8RKwvq0faJS+dIMcrXx
         QffCYAd9Q9jQkagz46fR96f9A6IQH71TuwJ/WjdLQP60WhiM9QtHNplXao4lFRx2qelZ
         VT+Q==
X-Gm-Message-State: APjAAAW5ib0Yx0dJycybYOSr3Xx4t6+DhjlPWjiuV2UioZtN1tWw363h
        hLEPDiAa/fx7/Moh+5XY6Dlqny3M
X-Google-Smtp-Source: APXvYqy7DgF9ttdF91EXLiOFLCogCwpQsyGdIP7d6m+UuL2sMhOEXeLSuY2ndeY4i7VuQeQ8MDfzQQ==
X-Received: by 2002:a02:228f:: with SMTP id o137mr82822449jao.39.1559067695009;
        Tue, 28 May 2019 11:21:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e2sm1446810ith.39.2019.05.28.11.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:33 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILWcc014537;
        Tue, 28 May 2019 18:21:32 GMT
Subject: [PATCH RFC 08/12] xprtrdma: Wake RPCs directly in rpcrdma_wc_send
 path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:32 -0400
Message-ID: <20190528182132.19012.55642.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Eliminate a context switch in the path that handles RPC wake-ups
when a Receive completion has to wait for a Send completion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |   61 +++++++++++++++------------------------
 net/sunrpc/xprtrdma/transport.c |    9 +++++-
 net/sunrpc/xprtrdma/verbs.c     |    3 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |   12 ++------
 4 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index ea39f74..6de90d4 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -511,6 +511,16 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	return 0;
 }
 
+static void rpcrdma_sendctx_done(struct kref *kref)
+{
+	struct rpcrdma_req *req =
+		container_of(kref, struct rpcrdma_req, rl_kref);
+	struct rpcrdma_rep *rep = req->rl_reply;
+
+	rpcrdma_complete_rqst(rep);
+	rep->rr_rxprt->rx_stats.reply_waits_for_send++;
+}
+
 /**
  * rpcrdma_sendctx_unmap - DMA-unmap Send buffer
  * @sc: sendctx containing SGEs to unmap
@@ -520,6 +530,9 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 {
 	struct ib_sge *sge;
 
+	if (!sc->sc_unmap_count)
+		return;
+
 	/* The first two SGEs contain the transport header and
 	 * the inline buffer. These are always left mapped so
 	 * they can be cheaply re-used.
@@ -529,9 +542,7 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 		ib_dma_unmap_page(sc->sc_device, sge->addr, sge->length,
 				  DMA_TO_DEVICE);
 
-	if (test_and_clear_bit(RPCRDMA_REQ_F_TX_RESOURCES,
-			       &sc->sc_req->rl_flags))
-		wake_up_bit(&sc->sc_req->rl_flags, RPCRDMA_REQ_F_TX_RESOURCES);
+	kref_put(&sc->sc_req->rl_kref, rpcrdma_sendctx_done);
 }
 
 /* Prepare an SGE for the RPC-over-RDMA transport header.
@@ -666,7 +677,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 out:
 	sc->sc_wr.num_sge += sge_no;
 	if (sc->sc_unmap_count)
-		__set_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags);
+		kref_get(&req->rl_kref);
 	return true;
 
 out_regbuf:
@@ -708,7 +719,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	req->rl_sendctx->sc_wr.num_sge = 0;
 	req->rl_sendctx->sc_unmap_count = 0;
 	req->rl_sendctx->sc_req = req;
-	__clear_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags);
+	kref_init(&req->rl_kref);
 
 	ret = -EIO;
 	if (!rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen))
@@ -1268,36 +1279,12 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	goto out;
 }
 
-/* Ensure that any DMA mapped pages associated with
- * the Send of the RPC Call have been unmapped before
- * allowing the RPC to complete. This protects argument
- * memory not controlled by the RPC client from being
- * re-used before we're done with it.
- */
-static void rpcrdma_release_tx(struct rpcrdma_xprt *r_xprt,
-			       struct rpcrdma_req *req)
+static void rpcrdma_reply_done(struct kref *kref)
 {
-	if (test_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags)) {
-		r_xprt->rx_stats.reply_waits_for_send++;
-		out_of_line_wait_on_bit(&req->rl_flags,
-					RPCRDMA_REQ_F_TX_RESOURCES,
-					bit_wait,
-					TASK_UNINTERRUPTIBLE);
-	}
-}
+	struct rpcrdma_req *req =
+		container_of(kref, struct rpcrdma_req, rl_kref);
 
-/**
- * rpcrdma_release_rqst - Release hardware resources
- * @r_xprt: controlling transport instance
- * @req: request with resources to release
- *
- */
-void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
-{
-	if (!list_empty(&req->rl_registered))
-		frwr_unmap_sync(r_xprt, req);
-
-	rpcrdma_release_tx(r_xprt, req);
+	rpcrdma_complete_rqst(req->rl_reply);
 }
 
 /**
@@ -1367,13 +1354,11 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 	if (rep->rr_wc_flags & IB_WC_WITH_INVALIDATE)
 		frwr_reminv(rep, &req->rl_registered);
-	if (!list_empty(&req->rl_registered)) {
+	if (!list_empty(&req->rl_registered))
 		frwr_unmap_async(r_xprt, req);
 		/* LocalInv completion will complete the RPC */
-	} else {
-		rpcrdma_release_tx(r_xprt, req);
-		rpcrdma_complete_rqst(rep);
-	}
+	else
+		kref_put(&req->rl_kref, rpcrdma_reply_done);
 	return;
 
 out_badversion:
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index f84375d..5b1d5d7 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -618,8 +618,15 @@ static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
 
-	rpcrdma_release_rqst(r_xprt, req);
 	trace_xprtrdma_op_free(task, req);
+
+	if (!list_empty(&req->rl_registered))
+		frwr_unmap_sync(r_xprt, req);
+
+	/* XXX: We should wait for the Send completion here,
+	 * although it's very likely it's already fired in
+	 * this case.
+	 */
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 0be455b..729266e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1463,8 +1463,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	struct ib_send_wr *send_wr = &req->rl_sendctx->sc_wr;
 	int rc;
 
-	if (!ep->rep_send_count ||
-	    test_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags)) {
+	if (!ep->rep_send_count || kref_read(&req->rl_kref) > 1) {
 		send_wr->send_flags |= IB_SEND_SIGNALED;
 		ep->rep_send_count = ep->rep_send_batch;
 	} else {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index e465221..5475f0d 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -44,7 +44,8 @@
 
 #include <linux/wait.h> 		/* wait_queue_head_t, etc */
 #include <linux/spinlock.h> 		/* spinlock_t, etc */
-#include <linux/atomic.h>			/* atomic_t, etc */
+#include <linux/atomic.h>		/* atomic_t, etc */
+#include <linux/kref.h>			/* struct kref */
 #include <linux/workqueue.h>		/* struct work_struct */
 
 #include <rdma/rdma_cm.h>		/* RDMA connection api */
@@ -329,17 +330,12 @@ struct rpcrdma_req {
 	struct rpcrdma_regbuf	*rl_recvbuf;	/* rq_rcv_buf */
 
 	struct list_head	rl_all;
-	unsigned long		rl_flags;
+	struct kref		rl_kref;
 
 	struct list_head	rl_registered;	/* registered segments */
 	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 };
 
-/* rl_flags */
-enum {
-	RPCRDMA_REQ_F_TX_RESOURCES,
-};
-
 static inline struct rpcrdma_req *
 rpcr_to_rdmar(const struct rpc_rqst *rqst)
 {
@@ -584,8 +580,6 @@ int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 void rpcrdma_set_max_header_sizes(struct rpcrdma_xprt *);
 void rpcrdma_complete_rqst(struct rpcrdma_rep *rep);
 void rpcrdma_reply_handler(struct rpcrdma_rep *rep);
-void rpcrdma_release_rqst(struct rpcrdma_xprt *r_xprt,
-			  struct rpcrdma_req *req);
 
 static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
 {

