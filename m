Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0D4BBA2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFSOdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37845 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfFSOdR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:17 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so38714472iok.4;
        Wed, 19 Jun 2019 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zzY6Uptd3ROAV+z9NkiuZ2yWpDluKKpERs4bvf+KRLA=;
        b=RkLEBYrDat+N2CL5JDvm9+UvoXwYFU2TWWDjg7uk6kdAsq3kMR0mGJa/ih/9IsSK75
         8Z8saGigiRrlOQ4IyIRFYBjPNSS17IkParGdnEpRLFb14qoJu50Aolt+TJx+K7ekhPDW
         Ef2MTO5t2eQbjkSYIJK9Ot8oDN/CBNZUeyk3/MnGm6DwxXZZCLgWtKsaISg8dfmOKFMz
         0k3a0NQG0ScTpWcDFdrQzSravCBm/pLLc8nDI3EsC9oVd6EUsVDxe5hrN2BiW6KZjLlc
         Rh0FIlzBn92pw/qy5n+xVoLXSWFmnJ18XqWbOQQXUibxxxJCkD73o+iZOupl8+P2Odfe
         7p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zzY6Uptd3ROAV+z9NkiuZ2yWpDluKKpERs4bvf+KRLA=;
        b=llIo9zzw9w4yDZ65HFdM3BNKsnYhxoCfoplVE+3Qj6zappHWrHRkKNpCfZX9hbI1eD
         +F9ZMOO4Ce8mX8sW9Rl61/r7izt202ma+3IycuaBfrTBjWCKv/MOVm+VoGsAeeB5Jkg/
         DlSsrCDDNizZqO392KUJh5ZvoE9AbyoGUv0lyeIr94FGhZNYqk332PWsBheU9o2omnrh
         aKnd2xnnNkn7JkuVSUeSf46VBSTAjb4SKD/y2cHk4o80HNW8Q3jkNTl/XS3sQ3uTMuGa
         DRLwrYh+Oa5Y7Ot3exJ8ycV0vulRGRVTm/kJZLDobeXUvULzSbbk/DdqvbsyHa1BWb1u
         6G/g==
X-Gm-Message-State: APjAAAVtEo4p0idTk+Km2HPhSjSmU/isadeKni4UBxB9cYesxlY4iVx5
        hFWl4HQcTWLj6VCgt22iLMw=
X-Google-Smtp-Source: APXvYqyQSjUBn6mPkIzJuPm+aFMewp8oxeSkZnCbBU+aQpQoyIeerLUjhFCXdzPfPjShB0tEEnpq+A==
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr9080721ion.238.1560954796852;
        Wed, 19 Jun 2019 07:33:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k3sm10415992iog.76.2019.06.19.07.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:16 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXFVo004518;
        Wed, 19 Jun 2019 14:33:15 GMT
Subject: [PATCH v4 09/19] xprtrdma: Wake RPCs directly in rpcrdma_wc_send
 path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:15 -0400
Message-ID: <20190619143315.3826.18506.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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
 net/sunrpc/xprtrdma/transport.c |   10 ++++++
 net/sunrpc/xprtrdma/verbs.c     |    3 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |   12 ++------
 4 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 33b6e6a..caf0b19 100644
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
index f84375d..9575f1d 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -618,8 +618,16 @@ static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
 
-	rpcrdma_release_rqst(r_xprt, req);
 	trace_xprtrdma_op_free(task, req);
+
+	if (!list_empty(&req->rl_registered))
+		frwr_unmap_sync(r_xprt, req);
+
+	/* XXX: If the RPC is completing because of a signal and
+	 * not because a reply was received, we ought to ensure
+	 * that the Send completion has fired, so that memory
+	 * involved with the Send is not still visible to the NIC.
+	 */
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c50a4b2..4e22cc2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1462,8 +1462,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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

