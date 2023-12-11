Return-Path: <linux-nfs+bounces-487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941780CF6A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9921C20D94
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4A4AF83;
	Mon, 11 Dec 2023 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESO03ZZ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03553B184;
	Mon, 11 Dec 2023 15:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B35FC433C8;
	Mon, 11 Dec 2023 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308275;
	bh=UOMQmlHeinTdme3rkZK7IDBvn6sh8SWXyRioXF5go7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ESO03ZZ3Hs6b5B5KTwlpcEkc8g/EfuGhfMVTJKYNiJCFlIi+CIy9CvucqW4EqN9zJ
	 Uef6YxtaYpe8+ZmGgKWSWS6B8zUmFiNwzflh2XDbjyzwNqOoDwiiDZOjUt3DfBqLr6
	 RJVkLSz7vWy17viSQ+4S8+mx9NBS3lHaxmC3AUCpN+hnbgI0j/s248meFs5auu8LY7
	 gQ3yc09q3pz9iQBABWw/cG2X8bmBDgCjQqADlyYMYT5MbL42kmxbWhp6mE+/KhGubo
	 dad5gYtQicdDVx51Fwi8HFs8qoWn5GnCP+pG6QAHIPoPKEbKMSUi1cOsFqZkJWIluI
	 yHyeE3eim4blg==
Subject: [PATCH v1 5/8] svcrdma: Clean up comment in svc_rdma_accept()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:34 -0500
Message-ID: 
 <170230827445.90242.4868169879235583897.stgit@bazille.1015granger.net>
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

The comment that starts "Qualify ..." applies to only some of the
following code paragraph. Re-arrange the lines so the comment makes
more sense.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 040d2ef6400c..8127c711fa3b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -397,18 +397,22 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	dev = newxprt->sc_cm_id->device;
 	newxprt->sc_port_num = newxprt->sc_cm_id->port_num;
 
-	/* Qualify the transport resource defaults with the
-	 * capabilities of this particular device */
+	newxprt->sc_max_req_size = svcrdma_max_req_size;
+	newxprt->sc_max_requests = svcrdma_max_requests;
+	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
+	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
+	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
+
+	/* Qualify the transport's resource defaults with the
+	 * capabilities of this particular device.
+	 */
+
 	/* Transport header, head iovec, tail iovec */
 	newxprt->sc_max_send_sges = 3;
 	/* Add one SGE per page list entry */
 	newxprt->sc_max_send_sges += (svcrdma_max_req_size / PAGE_SIZE) + 1;
 	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
 		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
-	newxprt->sc_max_req_size = svcrdma_max_req_size;
-	newxprt->sc_max_requests = svcrdma_max_requests;
-	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
 	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
 		   newxprt->sc_recv_batch;
 	if (rq_depth > dev->attrs.max_qp_wr) {
@@ -417,7 +421,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_requests = rq_depth - 2;
 		newxprt->sc_max_bc_requests = 2;
 	}
-	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
 	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
 	ctxts *= newxprt->sc_max_requests;
 	newxprt->sc_sq_depth = rq_depth + ctxts;



