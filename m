Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2D12FAE6
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgACQ4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:46 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41110 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ4q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:46 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so18749088ywc.8;
        Fri, 03 Jan 2020 08:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cRJRoQcIJ5xui/uZWNETubw9otNoq/moRTgYVs7gtO8=;
        b=upmqYuB4wOOjD8PxywTnCZKWCpLmHJnw/3Ht0iF/sspncxazSITgbg8eJPBr//eiiv
         rFqHauvmnnlfvk9dZsrcK4v+TwLe8eOoKVj2MzaFPAYQvVkKNCjqY6cJ4uyW53TwyK46
         WVkIiH84zp0yEka9DHRYWmdqmrwJpBw46fFM0SJOzwX65yrgjguF4/rXi70quW8sCZkC
         QS68dfIqEKPTae2rjpBmX2QygeahC/j/7Us762C7av3E/gZV6zlWrMHWxsCelqZozpCW
         l/zB0ap4JmnxbUBrz2s6cmJbzeeslyKixkJhcS8w+AD8tMApA8DM5w8Bl1KnqwDL3Dg8
         RPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cRJRoQcIJ5xui/uZWNETubw9otNoq/moRTgYVs7gtO8=;
        b=aybRq7GiZKoSZR06t1lBi9eN7hEIkuxQlbeUFYMa78zMZAm4Q0iwZXXDq1OwC7p2Dl
         1xZSSAb8BX+KoXuKfNn+8OUFZ67NzavE02hK2GsqW4n3fScSrmnoT6Bs7i3gCxBRZPJp
         d8e2Ry+CBqr5BsMdpBoq1spZMTHh9w/MVuydCI4XSWrlNGhKLWNSi+vp9Ds1HHCzvnSl
         vKOOk3jPyyh0RM2qFzNjqEYKtQKFxCoAx4UMuC17Xwq+DqhxRR4XENF/9rhnl62sugpB
         erPizhkjd3ggl7PDoYCG2R1jmeCrvf3V5TL0e4fVJoPk7pib0IWZJf0JL1Lv2Vl/GwPY
         xvfA==
X-Gm-Message-State: APjAAAUN0+n0MHqI+uA9WTeg6rRTvYrf2D72lS/MdN6Eupz1O7PkRQhL
        IoLQn1E6mxWxx5e843xI3IuBHXmV
X-Google-Smtp-Source: APXvYqy5u48wmQ0t4muthCLxzMLBVL2DpyZZ6/FB2IecIY/GukRXhGssgAQOGHZAYf+J3auUnBDpeA==
X-Received: by 2002:a81:de53:: with SMTP id o19mr68676539ywl.62.1578070604348;
        Fri, 03 Jan 2020 08:56:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g5sm23627694ywk.46.2020.01.03.08.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:44 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GuhfZ016392;
        Fri, 3 Jan 2020 16:56:43 GMT
Subject: [PATCH v1 4/9] xprtrdma: Eliminate per-transport "max pages"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:43 -0500
Message-ID: <157807060307.4606.13026227190289178598.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To support device hotplug and migrating a connection between devices
of different capabilities, we have to guarantee that all in-kernel
devices can support the same max NFS payload size (1 megabyte).

This means that possibly one or two in-tree devices are no longer
supported for NFS/RDMA because they cannot support 1MB rsize/wsize.
The only one I confirmed was cxgb3, but it has already been removed
from the kernel.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   40 +++++++++++++++------------------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
 net/sunrpc/xprtrdma/transport.c |   14 ++++----------
 net/sunrpc/xprtrdma/verbs.c     |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h |    3 +--
 5 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 24b8b75d0d49..f31ff54bb266 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -171,7 +171,7 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
  *	ep->rep_attr.cap.max_send_wr
  *	ep->rep_attr.cap.max_recv_wr
  *	ep->rep_max_requests
- *	ia->ri_max_segs
+ *	ia->ri_max_rdma_segs
  *
  * And these FRWR-related fields:
  *	ia->ri_max_frwr_depth
@@ -202,14 +202,12 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 	 * capability, but perform optimally when the MRs are not larger
 	 * than a page.
 	 */
-	if (attrs->max_sge_rd > 1)
+	if (attrs->max_sge_rd > RPCRDMA_MAX_HDR_SEGS)
 		ia->ri_max_frwr_depth = attrs->max_sge_rd;
 	else
 		ia->ri_max_frwr_depth = attrs->max_fast_reg_page_list_len;
 	if (ia->ri_max_frwr_depth > RPCRDMA_MAX_DATA_SEGS)
 		ia->ri_max_frwr_depth = RPCRDMA_MAX_DATA_SEGS;
-	dprintk("RPC:       %s: max FR page list depth = %u\n",
-		__func__, ia->ri_max_frwr_depth);
 
 	/* Add room for frwr register and invalidate WRs.
 	 * 1. FRWR reg WR for head
@@ -253,30 +251,22 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 	ep->rep_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
 	ep->rep_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
-	ia->ri_max_segs =
+	ia->ri_max_rdma_segs =
 		DIV_ROUND_UP(RPCRDMA_MAX_DATA_SEGS, ia->ri_max_frwr_depth);
 	/* Reply chunks require segments for head and tail buffers */
-	ia->ri_max_segs += 2;
-	if (ia->ri_max_segs > RPCRDMA_MAX_HDR_SEGS)
-		ia->ri_max_segs = RPCRDMA_MAX_HDR_SEGS;
-	return 0;
-}
-
-/**
- * frwr_maxpages - Compute size of largest payload
- * @r_xprt: transport
- *
- * Returns maximum size of an RPC message, in pages.
- *
- * FRWR mode conveys a list of pages per chunk segment. The
- * maximum length of that list is the FRWR page list depth.
- */
-size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt)
-{
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	ia->ri_max_rdma_segs += 2;
+	if (ia->ri_max_rdma_segs > RPCRDMA_MAX_HDR_SEGS)
+		ia->ri_max_rdma_segs = RPCRDMA_MAX_HDR_SEGS;
+
+	/* Ensure the underlying device is capable of conveying the
+	 * largest r/wsize NFS will ask for. This guarantees that
+	 * failing over from one RDMA device to another will not
+	 * break NFS I/O.
+	 */
+	if ((ia->ri_max_rdma_segs * ia->ri_max_frwr_depth) < RPCRDMA_MAX_SEGS)
+		return -ENOMEM;
 
-	return min_t(unsigned int, RPCRDMA_MAX_DATA_SEGS,
-		     (ia->ri_max_segs - 2) * ia->ri_max_frwr_depth);
+	return 0;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 520323ddc930..c6dcea06c754 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -111,7 +111,7 @@ static unsigned int rpcrdma_max_reply_header_size(unsigned int maxsegs)
  */
 void rpcrdma_set_max_header_sizes(struct rpcrdma_xprt *r_xprt)
 {
-	unsigned int maxsegs = r_xprt->rx_ia.ri_max_segs;
+	unsigned int maxsegs = r_xprt->rx_ia.ri_max_rdma_segs;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 
 	ep->rep_max_inline_send =
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index f868a75057ad..3cfeba68ee9a 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -359,19 +359,13 @@ xprt_setup_rdma(struct xprt_create *args)
 	if (rc)
 		goto out3;
 
-	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
-			  xprt_rdma_connect_worker);
-
-	xprt->max_payload = frwr_maxpages(new_xprt);
-	if (xprt->max_payload == 0)
-		goto out4;
-	xprt->max_payload <<= PAGE_SHIFT;
-	dprintk("RPC:       %s: transport data payload maximum: %zu bytes\n",
-		__func__, xprt->max_payload);
-
 	if (!try_module_get(THIS_MODULE))
 		goto out4;
 
+	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
+			  xprt_rdma_connect_worker);
+	xprt->max_payload = RPCRDMA_MAX_DATA_SEGS << PAGE_SHIFT;
+
 	dprintk("RPC:       %s: %s:%s\n", __func__,
 		xprt->address_strings[RPC_DISPLAY_ADDR],
 		xprt->address_strings[RPC_DISPLAY_PORT]);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f9595b72888..601a1bd56260 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -935,7 +935,7 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	unsigned int count;
 
-	for (count = 0; count < ia->ri_max_segs; count++) {
+	for (count = 0; count < ia->ri_max_rdma_segs; count++) {
 		struct rpcrdma_mr *mr;
 		int rc;
 
@@ -1017,7 +1017,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 
 	/* Compute maximum header buffer size in bytes */
 	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
-		     r_xprt->rx_ia.ri_max_segs * rpcrdma_readchunk_maxsz;
+		     r_xprt->rx_ia.ri_max_rdma_segs * rpcrdma_readchunk_maxsz;
 	maxhdrsize *= sizeof(__be32);
 	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
 				  DMA_TO_DEVICE, flags);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0fde694144f5..aac4cf959c3a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -71,7 +71,7 @@ struct rpcrdma_ia {
 	struct rdma_cm_id 	*ri_id;
 	struct ib_pd		*ri_pd;
 	int			ri_async_rc;
-	unsigned int		ri_max_segs;
+	unsigned int		ri_max_rdma_segs;
 	unsigned int		ri_max_frwr_depth;
 	bool			ri_implicit_roundup;
 	enum ib_mr_type		ri_mrtype;
@@ -539,7 +539,6 @@ void frwr_reset(struct rpcrdma_req *req);
 int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);
-size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,


