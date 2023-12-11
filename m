Return-Path: <linux-nfs+bounces-489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95C80CF6F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41F1281C74
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90244AF87;
	Mon, 11 Dec 2023 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYy8RIrF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCB3B184;
	Mon, 11 Dec 2023 15:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AB2C433C7;
	Mon, 11 Dec 2023 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308288;
	bh=LM4GTHoqE1IG5KmsA8entz5JyxVhvYRQ9yYxKkHLBFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qYy8RIrFNtZ5B9KewsE61tPclABdOYVp/EI6e3r9Hl+ucarRACwdhOGJgVUN3P581
	 rgLWMih/HcUSiw6su9KAqtSitesF4IT1dlOUuxK3naC50qLn6KIO+kzr9oUNisWToG
	 PBLelnttY+/+uqNkG8panzKPtgdTF9DwrpAj2lIj+WK9CS2Q69MgP16lHygzxXNyTD
	 72Gx+G8wol6DsUsUFuk6Xmwisv6Vk8VZ/OmNXmgCFyoQtV+23h7jdanINuFtA8RM1X
	 IAofOIsJLUX+ZAo9J1lXmhfDjXo5AzKiCVy+OQ71zD7EqisMjkBz3ryWAafgT+KcZL
	 /slkZNYLu2udA==
Subject: [PATCH v1 7/8] svcrdma: Use all allocated Send Queue entries
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:47 -0500
Message-ID: 
 <170230828734.90242.8027061101409867750.stgit@bazille.1015granger.net>
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

For upper layer protocols that request rw_ctxs, ib_create_qp()
adjusts ib_qp_init_attr::max_send_wr to accommodate the WQEs those
rw_ctxs will consume. See rdma_rw_init_qp() for details.

To actually use those additional WQEs, svc_rdma_accept() needs to
retrieve the corrected SQ depth after calling rdma_create_qp() and
set newxprt->sc_sq_depth and  newxprt->sc_sq_avail so that
svc_rdma_send() and svc_rdma_post_chunk_ctxt() can utilize those
WQEs.

The NVMe target driver, for example, already does this properly.

Fixes: 26fb2254dd33 ("svcrdma: Estimate Send Queue depth properly")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 0541aa54674c..790841864153 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -369,12 +369,12 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
  */
 static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 {
+	unsigned int ctxts, rq_depth, sq_depth;
 	struct svcxprt_rdma *listen_rdma;
 	struct svcxprt_rdma *newxprt = NULL;
 	struct rdma_conn_param conn_param;
 	struct rpcrdma_connect_private pmsg;
 	struct ib_qp_init_attr qp_attr;
-	unsigned int ctxts, rq_depth;
 	struct ib_device *dev;
 	int ret = 0;
 	RPC_IFDEBUG(struct sockaddr *sap);
@@ -421,24 +421,32 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_requests = rq_depth - 2;
 		newxprt->sc_max_bc_requests = 2;
 	}
+
 	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
 	ctxts *= newxprt->sc_max_requests;
-	newxprt->sc_sq_depth = rq_depth + ctxts;
-	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
-		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
-	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
+
+	sq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests + 1;
+	if (sq_depth > dev->attrs.max_qp_wr)
+		sq_depth = dev->attrs.max_qp_wr;
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);
 	if (IS_ERR(newxprt->sc_pd)) {
 		trace_svcrdma_pd_err(newxprt, PTR_ERR(newxprt->sc_pd));
 		goto errout;
 	}
-	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
+
+	/* The Completion Queue depth is the maximum number of signaled
+	 * WRs expected to be in flight. Every Send WR is signaled, and
+	 * each rw_ctx has a chain of WRs, but only one WR in each chain
+	 * is signaled.
+	 */
+	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, sq_depth + ctxts,
 					    IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_sq_cq))
 		goto errout;
-	newxprt->sc_rq_cq =
-		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
+	/* Every Receive WR is signaled. */
+	newxprt->sc_rq_cq = ib_alloc_cq_any(dev, newxprt, rq_depth,
+					    IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_rq_cq))
 		goto errout;
 
@@ -447,7 +455,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.qp_context = &newxprt->sc_xprt;
 	qp_attr.port_num = newxprt->sc_port_num;
 	qp_attr.cap.max_rdma_ctxs = ctxts;
-	qp_attr.cap.max_send_wr = newxprt->sc_sq_depth - ctxts;
+	qp_attr.cap.max_send_wr = sq_depth;
 	qp_attr.cap.max_recv_wr = rq_depth;
 	qp_attr.cap.max_send_sge = newxprt->sc_max_send_sges;
 	qp_attr.cap.max_recv_sge = 1;
@@ -455,17 +463,20 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.qp_type = IB_QPT_RC;
 	qp_attr.send_cq = newxprt->sc_sq_cq;
 	qp_attr.recv_cq = newxprt->sc_rq_cq;
-	dprintk("    cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
-		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
-	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
-		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
-
 	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
 	if (ret) {
 		trace_svcrdma_qp_err(newxprt, ret);
 		goto errout;
 	}
+	dprintk("svcrdma: cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
+		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
+	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
+		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
+	dprintk("    send CQ depth = %d, recv CQ depth = %d\n",
+		sq_depth, rq_depth);
 	newxprt->sc_qp = newxprt->sc_cm_id->qp;
+	newxprt->sc_sq_depth = qp_attr.cap.max_send_wr;
+	atomic_set(&newxprt->sc_sq_avail, qp_attr.cap.max_send_wr);
 
 	if (!(dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
 		newxprt->sc_snd_w_inv = false;



