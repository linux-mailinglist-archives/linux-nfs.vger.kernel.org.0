Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEDBDB62D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392111AbfJQSbW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 14:31:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39489 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 14:31:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so2815285qki.6;
        Thu, 17 Oct 2019 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=osoCTJXMINvNwg2jj7tYRSSlZ5yCfx+CAfcFhP304Yc=;
        b=uvDpYsZ7IGv6VQOxWVjQXKilSc2qV/EVTo0cvJvPKUvYMRGeOivFVasQe80HX0FNJ8
         KAMfR3tsUJvk0o8ZpfaoCmXgd3WYPlTowoiHSwbnJaNlzYX9AFhnZHNtJeok43obrEwJ
         3sD6Rg3a/E6pA7OnvbZ2esHZ10Ba2GVIiSwKNZhoBbzNjjndck6CVMCGarns+z/nPF7p
         F4TD7Vq9/jenpEkCmlKTjKTL0ow6q6Mo9Z74u6FwOcHkMyzIuDj0uobhWeYdAAJ5UAjq
         pkdqDlkrus0Zhyz5FWzT7KfzLedbJXldjo8qMaRaaa4mTuUefZGGmEWSzSXfhEF/ARog
         bzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=osoCTJXMINvNwg2jj7tYRSSlZ5yCfx+CAfcFhP304Yc=;
        b=dTdnnVooz0bXJ4CSTBJlVT2HjevNeYOxnWUisRlfJn0h2rqbBgvqtLPVToC+vjyZP+
         glBDrQ6HDM+GVH4+1qwSwBQQvuCnNC2vhdLlorqxt1TlQlaQnk8Q2DgnrLrZZ289LkJE
         PfpOXRWJj7D9+wFsmcnglu2ZIh6wwtXuljbcS3ScvSzo1s8/+x0tKjy3lFqCi8nmpNQb
         Ivr44GMtWPnkC4C+JA5SZDrTXU1pY85FauVuZdl7fFf6DOCTVq3V+V+vLeLTqKSZO1M5
         LzyEdCqtrsiLnhLrq2zWirIKDRn/3auM46MbjvMR8jG/9WuMHNCLqj7/EYG6YRRy7f8N
         RY1w==
X-Gm-Message-State: APjAAAXPl4SdBRgl/A36S252CMnUbBxP0XmcMVTrb9ZXX99M1Dcp8fmG
        qk80PQINmODJZdLtjr7JDlcB1Lhr
X-Google-Smtp-Source: APXvYqyNQuVikiOkm3HCSYatck+pMKUuRzslKKnTyiAsn584+BeOoZLln0mEGW4BM2jGV1hfdp/F6w==
X-Received: by 2002:a37:9642:: with SMTP id y63mr4465868qkd.387.1571337080629;
        Thu, 17 Oct 2019 11:31:20 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id u17sm1689319qkj.71.2019.10.17.11.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:18 -0700 (PDT)
Subject: [PATCH v1 2/6] xprtrdma: Remove rpcrdma_sendctx::sc_xprt
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:18 -0400
Message-ID: <20191017183118.2517.45660.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: Save eight bytes in a frequently allocated
structure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   19 ++++++++++---------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 --
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c79d862..3ab086a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -74,7 +74,8 @@
 /*
  * internal functions
  */
-static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
+static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
+				       struct rpcrdma_sendctx *sc);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
@@ -124,7 +125,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 
 /**
  * rpcrdma_wc_send - Invoked by RDMA provider for each polled Send WC
- * @cq:	completion queue (ignored)
+ * @cq:	completion queue
  * @wc:	completed WR
  *
  */
@@ -137,7 +138,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_send(sc, wc);
-	rpcrdma_sendctx_put_locked(sc);
+	rpcrdma_sendctx_put_locked((struct rpcrdma_xprt *)cq->cq_context, sc);
 }
 
 /**
@@ -518,7 +519,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	init_waitqueue_head(&ep->rep_connect_wait);
 	ep->rep_receive_count = 0;
 
-	sendcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
+	sendcq = ib_alloc_cq_any(ia->ri_id->device, r_xprt,
 				 ep->rep_attr.cap.max_send_wr + 1,
 				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(sendcq)) {
@@ -840,7 +841,6 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 		if (!sc)
 			return -ENOMEM;
 
-		sc->sc_xprt = r_xprt;
 		buf->rb_sc_ctxs[i] = sc;
 	}
 
@@ -903,6 +903,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 
 /**
  * rpcrdma_sendctx_put_locked - Release a send context
+ * @r_xprt: controlling transport instance
  * @sc: send context to release
  *
  * Usage: Called from Send completion to return a sendctxt
@@ -910,10 +911,10 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
  *
  * The caller serializes calls to this function (per transport).
  */
-static void
-rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc)
+static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
+				       struct rpcrdma_sendctx *sc)
 {
-	struct rpcrdma_buffer *buf = &sc->sc_xprt->rx_buf;
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	unsigned long next_tail;
 
 	/* Unmap SGEs of previously completed but unsignaled
@@ -931,7 +932,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	/* Paired with READ_ONCE */
 	smp_store_release(&buf->rb_sc_tail, next_tail);
 
-	xprt_write_space(&sc->sc_xprt->rx_xprt);
+	xprt_write_space(&r_xprt->rx_xprt);
 }
 
 static void
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index b8e768d..4897c09 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -218,12 +218,10 @@ enum {
 /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
  */
 struct rpcrdma_req;
-struct rpcrdma_xprt;
 struct rpcrdma_sendctx {
 	struct ib_send_wr	sc_wr;
 	struct ib_cqe		sc_cqe;
 	struct ib_device	*sc_device;
-	struct rpcrdma_xprt	*sc_xprt;
 	struct rpcrdma_req	*sc_req;
 	unsigned int		sc_unmap_count;
 	struct ib_sge		sc_sges[];

