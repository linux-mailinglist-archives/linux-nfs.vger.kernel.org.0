Return-Path: <linux-nfs+bounces-486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A5080CF69
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7119FB212DE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8134AF85;
	Mon, 11 Dec 2023 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1JkOejR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988E3B184;
	Mon, 11 Dec 2023 15:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F2EC433C7;
	Mon, 11 Dec 2023 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308269;
	bh=VWGn/gAnNfqZSoTmYXsQnuNZs6xC+143uzhJaMWYAGA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c1JkOejRicweqAXk6EPnGCzKPjG+xYCar4BmcucrEA2399l1Vyz/HfaoZww5YU+C+
	 ibMo78xVT4eNXmHj4R6cXr1Fp6QzolhQtzJhFG1hnh/iE+0MVrV8nPW+87Ebi7IKUm
	 a82NRywLfJPFrutkxWRtDQvOdQ+PnoUsbP6G0htnFxjqJOHGGcbtR58oHbpSBjsHWN
	 BarAq+91Pw5jPA10sC9rjygJGflfZF6VBsZqsk8t4Siz6UCxH21F8pm8ShFZXjAiRi
	 1qEiZZrMFglc8RTNYNn1n+ZNkA6nfVZf/5eZaFrojG0w7mPgycP4hhoEXFIztrZrXp
	 SaaP/5yFTereg==
Subject: [PATCH v1 4/8] svcrdma: Remove queue-shortening warnings
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:28 -0500
Message-ID: 
 <170230826804.90242.16823273103656314417.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
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

These won't have much diagnostic value for site administrators.
Since they can't be disabled, they become noise.

What's more, the subsequent rdma_create_qp() call adjusts the Send
Queue size (possibly downward) without warning, making the size
reported by these pr_warns inaccurate.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 451814eb12b9..040d2ef6400c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -412,8 +412,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
 		   newxprt->sc_recv_batch;
 	if (rq_depth > dev->attrs.max_qp_wr) {
-		pr_warn("svcrdma: reducing receive depth to %d\n",
-			dev->attrs.max_qp_wr);
 		rq_depth = dev->attrs.max_qp_wr;
 		newxprt->sc_recv_batch = 1;
 		newxprt->sc_max_requests = rq_depth - 2;
@@ -423,11 +421,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
 	ctxts *= newxprt->sc_max_requests;
 	newxprt->sc_sq_depth = rq_depth + ctxts;
-	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr) {
-		pr_warn("svcrdma: reducing send depth to %d\n",
-			dev->attrs.max_qp_wr);
+	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
-	}
 	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);



