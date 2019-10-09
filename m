Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864F3D14EA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfJIRHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44723 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:40 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so6585326iol.11;
        Wed, 09 Oct 2019 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AMNLq7xDZcAcz1zxL24cAbXH24gbHtJzkdtcWX5wkwk=;
        b=otVlT0Wgqh717GMZ3JzErGI7RZrbUFSC+JDy+PIwvQTz/TZzsxItXFkQPrYGjJtVxe
         p4WTwbzbOQUj8dz/sAckqukzLCxZmplFvcYDwt1tuXkOfNJODeqyYlGmZW0W8bTQzvTg
         qO0lmY54WVE0azEdS/g+YJd4UnOb7Bkx3x534Dz9DW2KiOoTxjjAJ/ttk1L5IJZuqCfc
         mWrQHQu966gDr0lElDipGJPONwtkonr74mZFvtnUAFTjpEyzDKZOUKr5cBjqYkSpTcO7
         dKKPFREJf1a1TOPXTf9S40hJED6j3hsuAD7N0aCB/miyv+106ZfnvNYaFK5QRN5ee6dB
         9ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AMNLq7xDZcAcz1zxL24cAbXH24gbHtJzkdtcWX5wkwk=;
        b=ZO+kN/nQuM0K/NGEBuFoVvFGU3J+4DJp9DoSQFTy3gixbvLOgYk0ZHMT1jd8AMzrKy
         THVhk2o2lneddrV6ZEQRi4DdQxw/DzrWkRBNKAT6fhulJZDJzwBGRlJPEVVKccIdtcxy
         DYKEF1DGHTboL9B0bWqj2wDUQglYOBNIuwc+H/JtJ/y5i0op81HamuBJs0MknPwUIWLh
         K+5Y2Ftc3yiUcHjxfaTXOj8ojItC93doi6SU0plzrM6D883JAa5k6TWMCwwONHQH6K3V
         k3jl4oM+dPOyo/QXqyXKtYmJRLCpUeq82Mkyim7o3ETD8Cq+fy+0cSofxxUiuiaBkMll
         GuWg==
X-Gm-Message-State: APjAAAWfI5PNYOydl/ytxbJbFmKNTjDfMPajoWU8pIYBjPGR1+gSbGPU
        Qy/2CvUaByIt8PJxFexMjwT1+LHi
X-Google-Smtp-Source: APXvYqwKfSl7HszFNYPsHuySKtiitMXcfbVEAasUUYIdpTzaPFOPTvBIqKR+72bgg6dtCP/NmMGcWQ==
X-Received: by 2002:a5e:9410:: with SMTP id q16mr59429ioj.302.1570640859216;
        Wed, 09 Oct 2019 10:07:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q3sm1229051ioi.68.2019.10.09.10.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:38 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7ccM001498;
        Wed, 9 Oct 2019 17:07:38 GMT
Subject: [PATCH v1 4/6] xprtrdma: Close window between waking RPC senders
 and posting Receives
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:38 -0400
Message-ID: <20191009170737.2978.4060.stgit@manet.1015granger.net>
In-Reply-To: <20191009170721.2978.128.stgit@manet.1015granger.net>
References: <20191009170721.2978.128.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A recent clean up attempted to separate Receive handling and RPC
Reply processing, in the name of clean layering.

Unfortunately, we can't do this because the Receive Queue has to be
refilled _after_ the most recent credit update from the responder
is parsed from the transport header, but _before_ we wake up the
next RPC sender. That is right in the middle of
rpcrdma_reply_handler().

Usually this isn't a problem because current responder
implementations don't vary their credit grant. The one exception is
when a connection is established: the grant goes from one to a much
larger number on the first Receive. The requester MUST post enough
Receives right then so that any outstanding requests can be sent
without risking RNR and connection loss.

Fixes: 6ceea36890a0 ("xprtrdma: Refactor Receive accounting")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    1 +
 net/sunrpc/xprtrdma/verbs.c     |   11 +++++++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index f1e3639..7c125e6 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1392,6 +1392,7 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = buf->rb_max_requests;
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
+	rpcrdma_post_recvs(r_xprt, false);
 
 	req = rpcr_to_rdmar(rqst);
 	if (req->rl_reply) {
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 97bc15e..3a1a31c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -85,7 +85,6 @@
 		     gfp_t flags);
 static void rpcrdma_regbuf_dma_unmap(struct rpcrdma_regbuf *rb);
 static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb);
-static void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
 
 /* Wait for outstanding transport work to finish. ib_drain_qp
  * handles the drains in the wrong order for us, so open code
@@ -171,7 +170,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 				   rdmab_addr(rep->rr_rdmabuf),
 				   wc->byte_len, DMA_FROM_DEVICE);
 
-	rpcrdma_post_recvs(r_xprt, false);
 	rpcrdma_reply_handler(rep);
 	return;
 
@@ -1477,8 +1475,13 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	return 0;
 }
 
-static void
-rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
+/**
+ * rpcrdma_post_recvs - Refill the Receive Queue
+ * @r_xprt: controlling transport instance
+ * @temp: mark Receive buffers to be deleted after use
+ *
+ */
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index b170cf5..2f89cfc 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -474,6 +474,7 @@ struct rpcrdma_xprt {
 
 int rpcrdma_ep_post(struct rpcrdma_ia *, struct rpcrdma_ep *,
 				struct rpcrdma_req *);
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
 
 /*
  * Buffer calls - xprtrdma/verbs.c

