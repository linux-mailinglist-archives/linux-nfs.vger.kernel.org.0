Return-Path: <linux-nfs+bounces-1553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B908408F2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051DD1F279CA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F15152DF8;
	Mon, 29 Jan 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEk9ZxuM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1941487DA;
	Mon, 29 Jan 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539845; cv=none; b=JFNmTCnWom1XFXbg+nwaMpjtzM8EK9qXdpriL3UttGyJz/SmvQxezsc6PlHxpqMjfsZi7c2ciVMgIS1paix/ds9z2TGV2MTOdxKtGCuaYkfatfFvl0pypq/QKtDeTN5x0TpYNL8S+v0Gz/WeDk0yDc4hxGT5wADfGzSyRiWY9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539845; c=relaxed/simple;
	bh=L2ZeHEQXAskqSLFktz0METTAHNAUfChhuJZ2tCckukk=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngr35JXHs3qrg3lHSw86is+6IcDxzFwlaN6OZKfS5YKt69V/CWMZ+kSeF838o0mvbzi9XssK0BYc2NHvnODFj51UPyC1shvDuQVgRcg/2z3IAXeawBd8GzqU4DPCXwcgVXjPKiePHau2mhXBEbuehfSy5+b1frxcvYAj4CLX4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEk9ZxuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4B3C433F1;
	Mon, 29 Jan 2024 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539844;
	bh=L2ZeHEQXAskqSLFktz0METTAHNAUfChhuJZ2tCckukk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=vEk9ZxuMTqnu1at2EkIKgyK4Knan3JIKlpGhcT6XhmlYPvyWjXdcO6FJyQZxNVAMQ
	 KENvCUd4OafRgIuBpyqQgxYoR+wKObuhJ14otJ4yadU/K9bBv6KdtdF1wvSFMDkJmr
	 RxypgNxPF3KPt1RXOrYSCkAX/NRkYzNwASumAqxtqu2N1pqnmVVsw4MJocyHVSwdFc
	 cePTce7GAY/ihuGvE7zjBpGtEOvUD59/8tCzApoQKy0/6AES8L8aYpt6VKmBQdnBZ6
	 cPRsFJHnNQHku3B+0cmgms5WPs9ajDFOwdKL0uOE9XyxOytuFYFkgKiEv118qT4Z2u
	 +9JS3na7zQhjg==
Subject: [PATCH v1 02/11] svcrdma: Use all allocated Send Queue entries
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:50:43 -0500
Message-ID: 
 <170653984365.24162.652127313173673494.stgit@manet.1015granger.net>
In-Reply-To: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
References: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
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
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   36 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 4a038c7e86f9..75f1481fbca0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -370,12 +370,12 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
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
@@ -422,24 +422,29 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_requests = rq_depth - 2;
 		newxprt->sc_max_bc_requests = 2;
 	}
+	sq_depth = rq_depth;
+
 	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
 	ctxts *= newxprt->sc_max_requests;
-	newxprt->sc_sq_depth = rq_depth + ctxts;
-	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
-		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
-	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
 
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
 
@@ -448,7 +453,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.qp_context = &newxprt->sc_xprt;
 	qp_attr.port_num = newxprt->sc_port_num;
 	qp_attr.cap.max_rdma_ctxs = ctxts;
-	qp_attr.cap.max_send_wr = newxprt->sc_sq_depth - ctxts;
+	qp_attr.cap.max_send_wr = sq_depth;
 	qp_attr.cap.max_recv_wr = rq_depth;
 	qp_attr.cap.max_send_sge = newxprt->sc_max_send_sges;
 	qp_attr.cap.max_recv_sge = 1;
@@ -456,17 +461,20 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
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
+	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
 
 	if (!(dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
 		newxprt->sc_snd_w_inv = false;



