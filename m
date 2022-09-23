Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010585E7B4E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIWNGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWNGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE613A38C
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D22CF621AA
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8DC433D6;
        Fri, 23 Sep 2022 13:06:19 +0000 (UTC)
Subject: [PATCH v1 3/6] xprtrdma: Clean up synopsis of rpcrdma_regbuf_alloc()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:18 -0400
Message-ID: <166393837818.1029362.13970325893095864130.stgit@morisot.1015granger.net>
In-Reply-To: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
References: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently all rpcrdma_regbuf_alloc() call sites pass the same value
as their third argument. That argument can therefore be eliminated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 89f5444f4d41..8fb10fc72f69 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -76,8 +76,7 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_ep_get(struct rpcrdma_ep *ep);
 static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
-rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
-		     gfp_t flags);
+rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction);
 static void rpcrdma_regbuf_dma_unmap(struct rpcrdma_regbuf *rb);
 static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb);
 
@@ -813,12 +812,11 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
 	if (req == NULL)
 		goto out1;
 
-	req->rl_sendbuf = rpcrdma_regbuf_alloc(size, DMA_TO_DEVICE,
-					       GFP_KERNEL);
+	req->rl_sendbuf = rpcrdma_regbuf_alloc(size, DMA_TO_DEVICE);
 	if (!req->rl_sendbuf)
 		goto out2;
 
-	req->rl_recvbuf = rpcrdma_regbuf_alloc(size, DMA_NONE, GFP_KERNEL);
+	req->rl_recvbuf = rpcrdma_regbuf_alloc(size, DMA_NONE);
 	if (!req->rl_recvbuf)
 		goto out3;
 
@@ -854,7 +852,7 @@ int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		     r_xprt->rx_ep->re_max_rdma_segs * rpcrdma_readchunk_maxsz;
 	maxhdrsize *= sizeof(__be32);
 	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
-				  DMA_TO_DEVICE, GFP_KERNEL);
+				  DMA_TO_DEVICE);
 	if (!rb)
 		goto out;
 
@@ -930,7 +928,7 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 		goto out;
 
 	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep->re_inline_recv,
-					       DMA_FROM_DEVICE, GFP_KERNEL);
+					       DMA_FROM_DEVICE);
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
@@ -1231,15 +1229,14 @@ void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
  * or Replies they may be registered externally via frwr_map.
  */
 static struct rpcrdma_regbuf *
-rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
-		     gfp_t flags)
+rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
 {
 	struct rpcrdma_regbuf *rb;
 
-	rb = kmalloc(sizeof(*rb), flags);
+	rb = kmalloc(sizeof(*rb), GFP_KERNEL);
 	if (!rb)
 		return NULL;
-	rb->rg_data = kmalloc(size, flags);
+	rb->rg_data = kmalloc(size, GFP_KERNEL);
 	if (!rb->rg_data) {
 		kfree(rb);
 		return NULL;


