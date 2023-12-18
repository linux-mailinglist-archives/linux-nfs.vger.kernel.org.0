Return-Path: <linux-nfs+bounces-701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666EC817D46
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877671C22B16
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78B1D141;
	Mon, 18 Dec 2023 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Aig6W7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30574E23;
	Mon, 18 Dec 2023 22:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED9C433C9;
	Mon, 18 Dec 2023 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938715;
	bh=5OczCUEXbmz+CueDQ8PjXd5RL0ZcFxhuPaTEcoCLFH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M9Aig6W7m0QPmN06VSTvE/SKI6DWlZOvQAT/R9MhT/+DzMBX1VeSb5glLSKpfjp8u
	 tQc49cjhcdhZHbTEKoydm8BSozxsye8rci/qT+u86Xrktycn77u5Yb/9IGkFi7sSri
	 QzlWZ4pvH4Ni/BH1IH+XgpLNOMLSt/1rM0RkrFZczn5qgPiW0Sp1JyUCRjRoBGUtAq
	 Tg0TYDs91YKgcW936cMvvgfPual81eK8FK0y97Bq+NwdALLJWi127bEx4iy5fwTiQ1
	 oomSQE02pWMS1/Bev385+pqsOi6y4a2Nj/EeIyokUhhtQmFWFmOlsjYxsX21Om1SLv
	 6YYnhyE/Ttjgg==
Subject: [PATCH v1 2/4] svcrdma: Add back svcxprt_rdma::sc_read_complete_q
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 18 Dec 2023 17:31:54 -0500
Message-ID: 
 <170293871455.4604.10661587001070835855.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
References: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
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

Having an nfsd thread waiting for an RDMA Read completion is
problematic if the Read responder (ie, the client) stops responding.
We need to go back to handling RDMA Reads by allowing the nfsd
thread to return to the svc scheduler, then waking a second thread
finish the RPC message once the Read completion fires.

As a next step, add a list_head upon which completed Reads are queued.
A subsequent patch will make use of this queue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   37 +++++++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 0f2d7f68ef5d..c98d29e51b9c 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -98,6 +98,7 @@ struct svcxprt_rdma {
 	u32		     sc_pending_recvs;
 	u32		     sc_recv_batch;
 	struct list_head     sc_rq_dto_q;
+	struct list_head     sc_read_complete_q;
 	spinlock_t	     sc_rq_dto_lock;
 	struct ib_qp         *sc_qp;
 	struct ib_cq         *sc_rq_cq;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e363cb1bdbc4..2de947183a7a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -382,6 +382,10 @@ void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
+		list_del(&ctxt->rc_list);
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+	}
 	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_rq_dto_q))) {
 		list_del(&ctxt->rc_list);
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
@@ -763,6 +767,30 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
 	return true;
 }
 
+static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
+					    struct svc_rdma_recv_ctxt *ctxt)
+{
+	int i;
+
+	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
+	 * the rq_pages that were already allocated for this rqstp.
+	 */
+	release_pages(rqstp->rq_respages, ctxt->rc_page_count);
+	for (i = 0; i < ctxt->rc_page_count; i++)
+		rqstp->rq_pages[i] = ctxt->rc_pages[i];
+
+	/* Update @rqstp's result send buffer to start after the
+	 * last page in the RDMA Read payload.
+	 */
+	rqstp->rq_respages = &rqstp->rq_pages[ctxt->rc_page_count];
+	rqstp->rq_next_page = rqstp->rq_respages + 1;
+
+	/* Prevent svc_rdma_recv_ctxt_put() from releasing the
+	 * pages in ctxt::rc_pages a second time.
+	 */
+	ctxt->rc_page_count = 0;
+}
+
 /**
  * svc_rdma_recvfrom - Receive an RPC call
  * @rqstp: request structure into which to receive an RPC Call
@@ -807,8 +835,14 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
-	ctxt = NULL;
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
+	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
+	if (ctxt) {
+		list_del(&ctxt->rc_list);
+		spin_unlock_bh(&rdma_xprt->sc_rq_dto_lock);
+		svc_rdma_read_complete(rqstp, ctxt);
+		goto complete;
+	}
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
 	if (ctxt)
 		list_del(&ctxt->rc_list);
@@ -846,6 +880,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 			goto out_readfail;
 	}
 
+complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 0ceb2817ca4d..10f01f4bdac6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -137,6 +137,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
+	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);



