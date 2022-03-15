Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA64DA12A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349378AbiCORbf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiCORbe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 13:31:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CB5677D
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 10:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE046CE1B73
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 17:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2AC340F5
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 17:30:18 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] xprtrdma: Allocate regbufs with GPF_KERNEL
Date:   Tue, 15 Mar 2022 13:30:16 -0400
Message-Id:  <164736541009.2241669.16368625440881516236.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4780; h=from:subject:message-id; bh=tUQugJmDdrgpPkTEolcLPQWOyarCn0BkXIHIFEz6QfM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiMM0iB/rtI4funYkdYung0BbvcPP3NeAZ/odQKYoQ 5AewFAiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYjDNIgAKCRAzarMzb2Z/l7JlEA C0TLgfF5MIyXVk40d6hvnIYw3DHzV/FUZTtukclV8obf4SpEFE8rwQhfAtRAB0ZNp2CtHZWtUy/V8e rioDWFGsHyegQJKMcGgg1+geWlYAeTHKxa9NgiYrYKCyI2QwBUTdlMhYa23g85lr42AqVDw1oe4aaQ fGfff7y34Aa+QFvr3UFtg8gK0+FNSsGVrVQLJSVb5bOvw3zbEdmOq/pQA8xHOTpI3O7eUlmHLcUeOU cLAHZl4uZB6+GamzjCbdXK/pfPT1qusoaMXon5U8dwn3V+rhOq3u9RuQsElHGy2VP8GGeu8bCesY/e XmbA0f+ZBFW7p5mKQ8zrkVMSoOQDbsaE/kDv1mODl5UtqlO9ogsqArFkxHp/QRkPT+ekc5ag1xLw0Q 6T91+Pm0GMYiy2HpqUNbZFIvfCN/++DV3cjm59pcD28+XcHg2YOMpgI0knlvooK1OYaP/VUlj1ZFO7 zqubcQMtBwqvJqg2uzMgN0/Zy/dI558gQi9nq9KPyvoqaUBa4IRbgbtkj0isqE+L1A7wgtuBtl18BO D+PNIk7ovCt4LBwbsxCDbz4+3FOpk1sVfYMVMHyC2FgEU27CqyNB7iEEb5253DBERfT/BB0qf2gOZ7 ASgRO2kTp8WH0rjN3QQ4aiBL0Er+32J+H3KT9Sf2oNqvRyK5TLW2Gdr5qjqQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When allocating memory, it should be safe to always use GFP_KERNEL,
since both swap tasks and asynchronous tasks will regulate the
allocation mode through the struct task flags. A similar change was
recently made for RPC socket transports.

Since the @flags argument to rpcrdma_regbuf_realloc() is now
invariant, remove it.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    4 ++--
 net/sunrpc/xprtrdma/transport.c            |   16 ++++------------
 net/sunrpc/xprtrdma/verbs.c                |    5 ++---
 net/sunrpc/xprtrdma/xprt_rdma.h            |    5 +----
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 16897fcb659c..36d8a297a8c5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -119,12 +119,12 @@ xprt_rdma_bc_allocate(struct rpc_task *task)
 		return -EINVAL;
 	}
 
-	page = alloc_page(RPCRDMA_DEF_GFP);
+	page = alloc_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	rqst->rq_buffer = page_address(page);
 
-	rqst->rq_rbuffer = kmalloc(rqst->rq_rcvsize, RPCRDMA_DEF_GFP);
+	rqst->rq_rbuffer = kmalloc(rqst->rq_rcvsize, GFP_KERNEL);
 	if (!rqst->rq_rbuffer) {
 		put_page(page);
 		return -ENOMEM;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 42e375dbdadb..e50824a30d41 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -541,11 +541,10 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
-				 struct rpcrdma_regbuf *rb, size_t size,
-				 gfp_t flags)
+				 struct rpcrdma_regbuf *rb, size_t size)
 {
 	if (unlikely(rdmab_length(rb) < size)) {
-		if (!rpcrdma_regbuf_realloc(rb, size, flags))
+		if (!rpcrdma_regbuf_realloc(rb, size))
 			return false;
 		r_xprt->rx_stats.hardway_register_count += size;
 	}
@@ -567,17 +566,10 @@ xprt_rdma_allocate(struct rpc_task *task)
 	struct rpc_rqst *rqst = task->tk_rqstp;
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
-	gfp_t flags;
 
-	flags = RPCRDMA_DEF_GFP;
-	if (RPC_IS_SWAPPER(task))
-		flags = __GFP_MEMALLOC | GFP_NOWAIT | __GFP_NOWARN;
-
-	if (!rpcrdma_check_regbuf(r_xprt, req->rl_sendbuf, rqst->rq_callsize,
-				  flags))
+	if (!rpcrdma_check_regbuf(r_xprt, req->rl_sendbuf, rqst->rq_callsize))
 		goto out_fail;
-	if (!rpcrdma_check_regbuf(r_xprt, req->rl_recvbuf, rqst->rq_rcvsize,
-				  flags))
+	if (!rpcrdma_check_regbuf(r_xprt, req->rl_recvbuf, rqst->rq_rcvsize))
 		goto out_fail;
 
 	rqst->rq_buffer = rdmab_data(req->rl_sendbuf);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 7b5fce2faa10..c368b4165fa0 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1259,16 +1259,15 @@ rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
  * rpcrdma_regbuf_realloc - re-allocate a SEND/RECV buffer
  * @rb: regbuf to reallocate
  * @size: size of buffer to be allocated, in bytes
- * @flags: GFP flags
  *
  * Returns true if reallocation was successful. If false is
  * returned, @rb is left untouched.
  */
-bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size, gfp_t flags)
+bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size)
 {
 	void *buf;
 
-	buf = kmalloc(size, flags);
+	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return false;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index c79f92eeda76..b81620c90061 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -149,8 +149,6 @@ static inline void *rdmab_data(const struct rpcrdma_regbuf *rb)
 	return rb->rg_data;
 }
 
-#define RPCRDMA_DEF_GFP		(GFP_NOIO | __GFP_NOWARN)
-
 /* To ensure a transport can always make forward progress,
  * the number of RDMA segments allowed in header chunk lists
  * is capped at 16. This prevents less-capable devices from
@@ -484,8 +482,7 @@ void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
 void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep);
 void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req);
 
-bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,
-			    gfp_t flags);
+bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size);
 bool __rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 			      struct rpcrdma_regbuf *rb);
 

