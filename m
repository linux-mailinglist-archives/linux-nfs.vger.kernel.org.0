Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB48B1F9842
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgFONVF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgFONVE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:21:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB9C061A0E;
        Mon, 15 Jun 2020 06:21:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so17729420iow.8;
        Mon, 15 Jun 2020 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HizMT9Lgi2Uu04lsSCxN6oFeFJPre5YnAUaTvLWnAk8=;
        b=NW+9OE/UvSrmnchJI1tXUu8VBYi22WZTSDJdro29qRNoAXD3spMviMIqiI7av4Elij
         V2VqE645V+jQjkZqFYkvZfylspdkG78ARnP6z839mtFs7+RfHPAQ46ztaR4t3r2A907J
         zsaaAmjd10zGrAEf+XHKjny65MwyMOLF8+Vup54UVEhKmnvyappWs9zBsWolq1pVMlWD
         8XSFCSGpclgAqrJcazC1igTmdjtuhrytNJ/aEmf/YEchxPzxlfAY3L6ornJSKI0f6I2U
         OMsXe5vdWrMusxnXsugnw3610uCWm8sTmWUX0GAxTx7UtCpK7t+u0vpbgN+BtGtI3+gl
         L16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HizMT9Lgi2Uu04lsSCxN6oFeFJPre5YnAUaTvLWnAk8=;
        b=cTQj8Uf18Qsh6gjruXYQTwAMBMkjt2DdiyquoS8+4aF7e+DOuPWQioTqW9v6ozcvVd
         aQsWtGHLJtF4TWo8yUUZaXN7yKHu2ml3ZXwdzd+Ov+DSKkl6n4y+8V/0iVevZbxxt5ah
         c+XNtr3B4Rh+C+xpSgpHCzcfgs9w3r/pi2nwo6EubFXQDRHZ733Q87uzM4lLvglqBxc4
         70dJ0NCU2drwVu1qNGFZ3E0F5yXFnZ78+Rw2B7VrhfwPB9AieqJDnzpLeGF28LGO73D7
         A73yNyaHPeHZiXe35Et4lwC1PT5Gzkdmc+bbqNmkYhFQcKIif53RZwOZAQgMK1ypD61w
         T6YA==
X-Gm-Message-State: AOAM530icsDs9qBSEJBUQc28UJi9SY5XWyShrmQP5Yh1YabkHevP4m2C
        mINcNHEdjyc3Lcm1CWoRI6PNuJzQ
X-Google-Smtp-Source: ABdhPJwAhoIyPEp3u021VwWKU+Ej0+Vq4o0cmuvYlirrHv1toB1GVQ7Vv7oQyY0fYJPTX0Pjowt8Sg==
X-Received: by 2002:a5e:8e47:: with SMTP id r7mr27640479ioo.204.1592227263879;
        Mon, 15 Jun 2020 06:21:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b8sm8001924ior.35.2020.06.15.06.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:21:03 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDL25O018438;
        Mon, 15 Jun 2020 13:21:02 GMT
Subject: [PATCH v1 3/5] xprtrdma: Clean up synopsis of
 rpcrdma_flush_disconnect()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:21:02 -0400
Message-ID: <20200615132102.11800.39700.stgit@manet.1015granger.net>
In-Reply-To: <20200615131642.11800.27486.stgit@manet.1015granger.net>
References: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Pass struct rpcrdma_xprt instead of an IB layer object.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    8 ++++----
 net/sunrpc/xprtrdma/verbs.c     |   12 ++++++------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ef997880e17a..b647562a26dd 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -367,7 +367,7 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 	trace_xprtrdma_wc_fastreg(wc, frwr);
 	/* The MR will get recycled when the associated req is retransmitted */
 
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
@@ -452,7 +452,7 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 	trace_xprtrdma_wc_li(wc, frwr);
 	__frwr_release_mr(wc, mr);
 
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
@@ -474,7 +474,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 	__frwr_release_mr(wc, mr);
 	complete(&frwr->fr_linv_done);
 
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
@@ -582,7 +582,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	smp_rmb();
 	rpcrdma_complete_rqst(rep);
 
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index b172e43cb204..7a112612fc8f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -132,14 +132,13 @@ static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
 
 /**
  * rpcrdma_flush_disconnect - Disconnect on flushed completion
- * @cq: completion queue
+ * @r_xprt: transport to disconnect
  * @wc: work completion entry
  *
  * Must be called in process context.
  */
-void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc)
+void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc)
 {
-	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 
 	if (wc->status != IB_WC_SUCCESS &&
@@ -160,11 +159,12 @@ static void rpcrdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_sendctx *sc =
 		container_of(cqe, struct rpcrdma_sendctx, sc_cqe);
+	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_send(sc, wc);
-	rpcrdma_sendctx_put_locked((struct rpcrdma_xprt *)cq->cq_context, sc);
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_sendctx_put_locked(r_xprt, sc);
+	rpcrdma_flush_disconnect(r_xprt, wc);
 }
 
 /**
@@ -199,7 +199,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	return;
 
 out_flushed:
-	rpcrdma_flush_disconnect(cq, wc);
+	rpcrdma_flush_disconnect(r_xprt, wc);
 	rpcrdma_rep_destroy(rep);
 }
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0a16fdb09b2c..098d05a62ead 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -446,7 +446,7 @@ extern unsigned int xprt_rdma_memreg_strategy;
 /*
  * Endpoint calls - xprtrdma/verbs.c
  */
-void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc);
+void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 

