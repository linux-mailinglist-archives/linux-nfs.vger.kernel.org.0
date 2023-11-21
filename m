Return-Path: <linux-nfs+bounces-13-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E27F33FF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160D9282F6E
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E556749;
	Tue, 21 Nov 2023 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvNwwyZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E944A9A7;
	Tue, 21 Nov 2023 16:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3531EC433C8;
	Tue, 21 Nov 2023 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584821;
	bh=ZWiLYS5U8SaKvzumKQPMXDyabz+9Snq1UcacUrpx9M4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PvNwwyZPklIe8HWOnz+Lj6a1B4J+UZR0ipINE38UNTMyl2y87oavCJJgvd267kqw6
	 9GHBmUGDCCLRs75EwLVUHyhPdHBqaALIw+45y6DfukEN2AWIYrJiYO4KAb3FYJzbQ9
	 qeuZ5QrDkC6wT1JsbFMILLr6u3QIhcyyPeMupQm116cKIhboj1UURBGPwp+Ao501Ul
	 7QwLTSz0zYmjGCmW6sa0WhTzlQcVJwGeK4yG3AK3IYw9Ow5S6l8U76rx8nS5yoyEU1
	 VJEb8u6r6/ZzJlq6epyGKx1u2vCVq9B5NFu0P7WNaUgMhKt1e18L+5vA0B+7fZSDja
	 cOMdU2mn+0jrw==
Subject: [PATCH v2 2/6] svcrdma: Pre-allocate svc_rdma_recv_ctxt objects
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:20 -0500
Message-ID: 
 <170058482030.4504.11755101484955896125.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
References: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

The original reason for allocating svc_rdma_recv_ctxt objects during
Receive completion was to ensure the objects were allocated on the
NUMA node closest to the underlying IB device.

Since commit c5d68d25bd6b ("svcrdma: Clean up allocation of
svc_rdma_recv_ctxt"), however, the device's favored node is
explicitly passed to the memory allocator.

To enable switching Receive completion to soft IRQ context, move
memory allocation out of completion handling, since it can be
costly, and it can sleep.

A limited number of objects is now allocated at "accept" time.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   32 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 3b05f90a3e50..c8c1c534070b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -204,18 +204,11 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 
 	node = llist_del_first(&rdma->sc_recv_ctxts);
 	if (!node)
-		goto out_empty;
-	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+		return NULL;
 
-out:
+	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 	ctxt->rc_page_count = 0;
 	return ctxt;
-
-out_empty:
-	ctxt = svc_rdma_recv_ctxt_alloc(rdma);
-	if (!ctxt)
-		return NULL;
-	goto out;
 }
 
 /**
@@ -277,7 +270,7 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 		rdma->sc_pending_recvs++;
 	}
 	if (!recv_chain)
-		return false;
+		return true;
 
 	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
 	if (ret)
@@ -301,10 +294,27 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
  * svc_rdma_post_recvs - Post initial set of Recv WRs
  * @rdma: fresh svcxprt_rdma
  *
- * Returns true if successful, otherwise false.
+ * Return values:
+ *   %true: Receive Queue initialization successful
+ *   %false: memory allocation or DMA error
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
+	unsigned int total;
+
+	/* For each credit, allocate enough recv_ctxts for one
+	 * posted Receive and one RPC in process.
+	 */
+	total = (rdma->sc_max_requests * 2) + rdma->sc_recv_batch;
+	while (total--) {
+		struct svc_rdma_recv_ctxt *ctxt;
+
+		ctxt = svc_rdma_recv_ctxt_alloc(rdma);
+		if (!ctxt)
+			return false;
+		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
+	}
+
 	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests);
 }
 



