Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BC5E7B4F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIWNGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWNGb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4966F13A38C
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1CE6B8163A
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73587C433C1;
        Fri, 23 Sep 2022 13:06:25 +0000 (UTC)
Subject: [PATCH v1 4/6] xprtrdma: MR-related memory allocation should be
 allowed to fail
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:24 -0400
Message-ID: <166393838446.1029362.10749628895167867941.stgit@morisot.1015granger.net>
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

xprtrdma always drives a retry of MR allocation if it should fail.
It should be safe to not use GFP_KERNEL for this purpose rather
than sleeping in the memory allocator.

In theory, if these weaker allocations are attempted first, memory
exhaustion is likely to cause xprtrdma to fail fast and not then
invoke the RDMA core APIs, which still might use GFP_KERNEL.

Also note that rpc_task_gfp_mask() always sets __GFP_NORETRY and
__GFP_NOWARN when an RPC-related allocation is being done in a
worker thread. MR allocation is already always done in worker
threads.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   17 +++++++----------
 net/sunrpc/xprtrdma/verbs.c     |    5 ++++-
 net/sunrpc/xprtrdma/xprt_rdma.h |    6 ++++++
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index de0bdb6b729f..ce55361a822f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -126,14 +126,15 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	struct ib_mr *frmr;
 	int rc;
 
+	sg = kcalloc_node(depth, sizeof(*sg), XPRTRDMA_GFP_FLAGS,
+			  ibdev_to_node(ep->re_id->device));
+	if (!sg)
+		return -ENOMEM;
+
 	frmr = ib_alloc_mr(ep->re_pd, ep->re_mrtype, depth);
 	if (IS_ERR(frmr))
 		goto out_mr_err;
 
-	sg = kmalloc_array(depth, sizeof(*sg), GFP_KERNEL);
-	if (!sg)
-		goto out_list_err;
-
 	mr->mr_xprt = r_xprt;
 	mr->mr_ibmr = frmr;
 	mr->mr_device = NULL;
@@ -146,13 +147,9 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	return 0;
 
 out_mr_err:
-	rc = PTR_ERR(frmr);
+	kfree(sg);
 	trace_xprtrdma_frwr_alloc(mr, rc);
-	return rc;
-
-out_list_err:
-	ib_dereg_mr(frmr);
-	return -ENOMEM;
+	return PTR_ERR(frmr);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 8fb10fc72f69..4a7b87e9e47c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -739,13 +739,16 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct ib_device *device = ep->re_id->device;
 	unsigned int count;
 
+	/* Try to allocate enough to perform one full-sized I/O */
 	for (count = 0; count < ep->re_max_rdma_segs; count++) {
 		struct rpcrdma_mr *mr;
 		int rc;
 
-		mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+		mr = kzalloc_node(sizeof(*mr), XPRTRDMA_GFP_FLAGS,
+				  ibdev_to_node(device));
 		if (!mr)
 			break;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 227dce50cc4b..5e5ff6784ef5 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -149,6 +149,12 @@ static inline void *rdmab_data(const struct rpcrdma_regbuf *rb)
 	return rb->rg_data;
 }
 
+/* Do not use emergency memory reserves, and fail quickly if memory
+ * cannot be allocated easily. These flags may be used wherever there
+ * is robust logic to handle a failure to allocate.
+ */
+#define XPRTRDMA_GFP_FLAGS  (__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN)
+
 /* To ensure a transport can always make forward progress,
  * the number of RDMA segments allowed in header chunk lists
  * is capped at 16. This prevents less-capable devices from


