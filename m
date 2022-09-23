Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD55E7B4D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIWNGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiIWNGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4A13A393
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42889B8163A
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C16C433D6;
        Fri, 23 Sep 2022 13:06:12 +0000 (UTC)
Subject: [PATCH v1 2/6] xprtrdma: Clean up synopsis of rpcrdma_req_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:11 -0400
Message-ID: <166393837193.1029362.16124168147738029400.stgit@morisot.1015granger.net>
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

Commit 1769e6a816df ("xprtrdma: Clean up rpcrdma_create_req()")
added rpcrdma_req_create() with a GFP flags argument in case a
caller might want to avoid waiting for memory.

There has never been a caller that does not pass GFP_KERNEL as
the third argument. That argument can therefore be eliminated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    2 +-
 net/sunrpc/xprtrdma/verbs.c       |   16 ++++++++--------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index faba7136dd9a..e4d84a13c566 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -189,7 +189,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 		return NULL;
 
 	size = min_t(size_t, r_xprt->rx_ep->re_inline_recv, PAGE_SIZE);
-	req = rpcrdma_req_create(r_xprt, size, GFP_KERNEL);
+	req = rpcrdma_req_create(r_xprt, size);
 	if (!req)
 		return NULL;
 	if (rpcrdma_req_setup(r_xprt, req)) {
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 049c854b7b37..89f5444f4d41 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -800,25 +800,25 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
  * rpcrdma_req_create - Allocate an rpcrdma_req object
  * @r_xprt: controlling r_xprt
  * @size: initial size, in bytes, of send and receive buffers
- * @flags: GFP flags passed to memory allocators
  *
  * Returns an allocated and fully initialized rpcrdma_req or NULL.
  */
-struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
-				       gfp_t flags)
+struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
+				       size_t size)
 {
 	struct rpcrdma_buffer *buffer = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
 
-	req = kzalloc(sizeof(*req), flags);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (req == NULL)
 		goto out1;
 
-	req->rl_sendbuf = rpcrdma_regbuf_alloc(size, DMA_TO_DEVICE, flags);
+	req->rl_sendbuf = rpcrdma_regbuf_alloc(size, DMA_TO_DEVICE,
+					       GFP_KERNEL);
 	if (!req->rl_sendbuf)
 		goto out2;
 
-	req->rl_recvbuf = rpcrdma_regbuf_alloc(size, DMA_NONE, flags);
+	req->rl_recvbuf = rpcrdma_regbuf_alloc(size, DMA_NONE, GFP_KERNEL);
 	if (!req->rl_recvbuf)
 		goto out3;
 
@@ -1060,8 +1060,8 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	for (i = 0; i < r_xprt->rx_xprt.max_reqs; i++) {
 		struct rpcrdma_req *req;
 
-		req = rpcrdma_req_create(r_xprt, RPCRDMA_V1_DEF_INLINE_SIZE * 2,
-					 GFP_KERNEL);
+		req = rpcrdma_req_create(r_xprt,
+					 RPCRDMA_V1_DEF_INLINE_SIZE * 2);
 		if (!req)
 			goto out;
 		list_add(&req->rl_list, &buf->rb_send_bufs);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 84b685c45555..227dce50cc4b 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -465,8 +465,8 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
 /*
  * Buffer calls - xprtrdma/verbs.c
  */
-struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
-				       gfp_t flags);
+struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
+				       size_t size);
 int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_req_destroy(struct rpcrdma_req *req);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);


