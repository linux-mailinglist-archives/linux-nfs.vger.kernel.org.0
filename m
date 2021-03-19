Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F202341F77
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhCSOcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhCSObt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 10:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB89964F1F;
        Fri, 19 Mar 2021 14:31:48 +0000 (UTC)
Subject: [PATCH v1 6/6] svcrdma: Maintain a Receive water mark
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 19 Mar 2021 10:31:48 -0400
Message-ID: <161616430811.173092.1562692181119108782.stgit@klimt.1015granger.net>
In-Reply-To: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Post more Receives when the number of pending Receives drops below
a water mark. The batch mechanism is disabled if the underlying
device cannot support a reasonably-sized Receive Queue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   10 ++++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 1e76ed688044..722fc7c48725 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -94,6 +94,8 @@ struct svcxprt_rdma {
 	spinlock_t	     sc_rw_ctxt_lock;
 	struct list_head     sc_rw_ctxts;
 
+	u32		     sc_pending_recvs;
+	u32		     sc_recv_batch;
 	struct list_head     sc_rq_dto_q;
 	spinlock_t	     sc_rq_dto_lock;
 	struct ib_qp         *sc_qp;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 1e7381ff948b..2571188ef7f2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -285,6 +285,7 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 		ctxt->rc_temp = temp;
 		ctxt->rc_recv_wr.next = recv_chain;
 		recv_chain = &ctxt->rc_recv_wr;
+		rdma->sc_pending_recvs++;
 	}
 	if (!recv_chain)
 		return false;
@@ -302,6 +303,8 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 		bad_wr = bad_wr->next;
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 	}
+	/* Since we're destroying the xprt, no need to reset
+	 * sc_pending_recvs. */
 	return false;
 }
 
@@ -328,6 +331,8 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	rdma->sc_pending_recvs--;
+
 	/* WARNING: Only wc->wr_cqe and wc->status are reliable */
 	ctxt = container_of(cqe, struct svc_rdma_recv_ctxt, rc_cqe);
 
@@ -344,8 +349,9 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	 * to reduce the likelihood of replayed requests once the
 	 * client reconnects.
 	 */
-	if (!svc_rdma_refresh_recvs(rdma, 1, false))
-		goto flushed;
+	if (rdma->sc_pending_recvs < rdma->sc_max_requests)
+		if (!svc_rdma_refresh_recvs(rdma, rdma->sc_recv_batch, false))
+			goto flushed;
 
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 046a07da5cf9..e629eacfedfc 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -407,11 +407,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests;
+	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
+	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
+		   newxprt->sc_recv_batch;
 	if (rq_depth > dev->attrs.max_qp_wr) {
 		pr_warn("svcrdma: reducing receive depth to %d\n",
 			dev->attrs.max_qp_wr);
 		rq_depth = dev->attrs.max_qp_wr;
+		newxprt->sc_recv_batch = 1;
 		newxprt->sc_max_requests = rq_depth - 2;
 		newxprt->sc_max_bc_requests = 2;
 	}


