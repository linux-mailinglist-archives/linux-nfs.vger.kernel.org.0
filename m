Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7BC4E35EF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiCVBX7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiCVBX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3F2A257
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3B71B81AE8
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0091EC340E8;
        Tue, 22 Mar 2022 01:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912147;
        bh=WF9+St0w0R0Hgm0uZW4pnTk8xcPSORCvuqfeNaG3KzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6hIfT7506e0FypvH0ApTEpmG1I+EFojZrK/qjvQwYWo2KueOQpLel4izUqpYkKen
         BBp0tVfwFX2O3/5tYUTYKNpCkKkaOCG0gxRPRi7gxSHVtpta135I2HMAoQEQnOjX5A
         nENl+2VDLdosrRi+pJqmVOfQyliK3M898qKDMX6fpAMh5uhvwE8bqF2zPfvZf9FSNU
         fk5XMXOq+L65fOSrJG9ywgF6uYYhpEeTTG/hsjL9C21ULKc4o2ePd1y4yFvqHJ2LSu
         LRHzaC47GqPnAPElzVFALhfD1iAp/YTqGtH9Q/XL4LY8GxmPLgpz1iJ862hdSg7MXb
         D9FZCUrNKWsQg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 4/9] SUNRPC: Make the rpciod and xprtiod slab allocation modes consistent
Date:   Mon, 21 Mar 2022 21:16:13 -0400
Message-Id: <20220322011618.1052288-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-4-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
 <20220322011618.1052288-2-trondmy@kernel.org>
 <20220322011618.1052288-3-trondmy@kernel.org>
 <20220322011618.1052288-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Make sure that rpciod and xprtiod are always using the same slab
allocation modes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/backchannel_rqst.c |  8 ++++----
 net/sunrpc/rpcb_clnt.c        |  4 ++--
 net/sunrpc/socklib.c          |  3 ++-
 net/sunrpc/xprt.c             |  5 +----
 net/sunrpc/xprtsock.c         | 11 ++++++-----
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 22a2c235abf1..5a6b61dcdf2d 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -75,9 +75,9 @@ static int xprt_alloc_xdr_buf(struct xdr_buf *buf, gfp_t gfp_flags)
 	return 0;
 }
 
-static
-struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt *xprt, gfp_t gfp_flags)
+static struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt *xprt)
 {
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
 	struct rpc_rqst *req;
 
 	/* Pre-allocate one backchannel rpc_rqst */
@@ -154,7 +154,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 	INIT_LIST_HEAD(&tmp_list);
 	for (i = 0; i < min_reqs; i++) {
 		/* Pre-allocate one backchannel rpc_rqst */
-		req = xprt_alloc_bc_req(xprt, GFP_KERNEL);
+		req = xprt_alloc_bc_req(xprt);
 		if (req == NULL) {
 			printk(KERN_ERR "Failed to create bc rpc_rqst\n");
 			goto out_free;
@@ -343,7 +343,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
 			break;
 		} else if (req)
 			break;
-		new = xprt_alloc_bc_req(xprt, GFP_KERNEL);
+		new = xprt_alloc_bc_req(xprt);
 	} while (new);
 	return req;
 }
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 0fdeb8666bfd..5a8e6d46809a 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -714,7 +714,7 @@ void rpcb_getport_async(struct rpc_task *task)
 		goto bailout_nofree;
 	}
 
-	map = kzalloc(sizeof(struct rpcbind_args), GFP_KERNEL);
+	map = kzalloc(sizeof(struct rpcbind_args), rpc_task_gfp_mask());
 	if (!map) {
 		status = -ENOMEM;
 		goto bailout_release_client;
@@ -730,7 +730,7 @@ void rpcb_getport_async(struct rpc_task *task)
 	case RPCBVERS_4:
 	case RPCBVERS_3:
 		map->r_netid = xprt->address_strings[RPC_DISPLAY_NETID];
-		map->r_addr = rpc_sockaddr2uaddr(sap, GFP_KERNEL);
+		map->r_addr = rpc_sockaddr2uaddr(sap, rpc_task_gfp_mask());
 		if (!map->r_addr) {
 			status = -ENOMEM;
 			goto bailout_free_args;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index d52313af82bc..05b38bf68316 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/udp.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/export.h>
 
@@ -222,7 +223,7 @@ static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 {
 	int err;
 
-	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	err = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
 	if (err < 0)
 		return err;
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index bbe913121f43..744c6c1d536f 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1679,15 +1679,12 @@ static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_task *task
 static struct rpc_rqst *xprt_dynamic_alloc_slot(struct rpc_xprt *xprt)
 {
 	struct rpc_rqst *req = ERR_PTR(-EAGAIN);
-	gfp_t gfp_mask = GFP_KERNEL;
 
 	if (xprt->num_reqs >= xprt->max_reqs)
 		goto out;
 	++xprt->num_reqs;
 	spin_unlock(&xprt->reserve_lock);
-	if (current->flags & PF_WQ_WORKER)
-		gfp_mask |= __GFP_NORETRY | __GFP_NOWARN;
-	req = kzalloc(sizeof(*req), gfp_mask);
+	req = kzalloc(sizeof(*req), rpc_task_gfp_mask());
 	spin_lock(&xprt->reserve_lock);
 	if (req != NULL)
 		goto out;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 8909c768fe71..b52eaa8a0cda 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -428,9 +428,9 @@ xs_read_xdr_buf(struct socket *sock, struct msghdr *msg, int flags,
 		offset += want;
 	}
 
-	want = xs_alloc_sparse_pages(buf,
-			min_t(size_t, count - offset, buf->page_len),
-			GFP_KERNEL);
+	want = xs_alloc_sparse_pages(
+		buf, min_t(size_t, count - offset, buf->page_len),
+		GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
 	if (seek < want) {
 		ret = xs_read_bvec(sock, msg, flags, buf->bvec,
 				xdr_buf_pagecount(buf),
@@ -826,7 +826,8 @@ static void
 xs_stream_prepare_request(struct rpc_rqst *req)
 {
 	xdr_free_bvec(&req->rq_rcv_buf);
-	req->rq_task->tk_status = xdr_alloc_bvec(&req->rq_rcv_buf, GFP_KERNEL);
+	req->rq_task->tk_status = xdr_alloc_bvec(
+		&req->rq_rcv_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
 }
 
 /*
@@ -2487,7 +2488,7 @@ static int bc_malloc(struct rpc_task *task)
 		return -EINVAL;
 	}
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
 	if (!page)
 		return -ENOMEM;
 
-- 
2.35.1

