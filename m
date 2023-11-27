Return-Path: <linux-nfs+bounces-95-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD37FA688
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034711C20AD9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E9364D0;
	Mon, 27 Nov 2023 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4bgn5xJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08926381B8;
	Mon, 27 Nov 2023 16:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82869C433C9;
	Mon, 27 Nov 2023 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102811;
	bh=juU6fnl4PfxG24GSF7q6GNBCMl+rBTJajn8+8aZpaCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k4bgn5xJv6TRuHOTEstdMEkySE+eI2Paa6k34C0410c3NKHN9QAcE53dMZ5UrV/SY
	 s0Nl+iFoHgoiF2+2x6uy3O6ue2ovJQ0u0RsBPZE5TZt7OzZGhqjlgr9VB26vyViNTn
	 wsZ2hJoEtM07YP2uY44sXU0ixi/BZiti3ePCtly45cZPFi/c5m/mG3b2cLL5NdgxbT
	 Jon4UM29FdqQlcj5JyaRo90DhCe0x7yadyf0p1RTb3zjM8Q9ozQsNv5NKPnUqHkCpO
	 G+dQn3RQAFvhWAhn5JIBr+O/IZ7pxd4uEsZx/rsVO0/vBIA9B87ilSm2Nh3CyBeu8g
	 I+/wMpKsOgDGw==
Subject: [PATCH v1 2/5] rpcrdma: Introduce a simple cid tracepoint class
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:30 -0500
Message-ID: 
 <170110281051.49524.8827985545385062428.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170110267835.49524.14512830016966273991.stgit@bazille.1015granger.net>
References: 
 <170110267835.49524.14512830016966273991.stgit@bazille.1015granger.net>
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

De-duplicate some code, making it easier to add new tracepoints that
report only a completion ID.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |   93 +++++++++----------------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    2 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |    2 -
 net/sunrpc/xprtrdma/verbs.c             |    2 -
 5 files changed, 30 insertions(+), 71 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 718df1d9b834..b3445e07c151 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -22,47 +22,37 @@
  ** Event classes
  **/
 
-DECLARE_EVENT_CLASS(rpcrdma_completion_class,
+DECLARE_EVENT_CLASS(rpcrdma_simple_cid_class,
 	TP_PROTO(
-		const struct ib_wc *wc,
 		const struct rpc_rdma_cid *cid
 	),
 
-	TP_ARGS(wc, cid),
+	TP_ARGS(cid),
 
 	TP_STRUCT__entry(
 		__field(u32, cq_id)
 		__field(int, completion_id)
-		__field(unsigned long, status)
-		__field(unsigned int, vendor_err)
 	),
 
 	TP_fast_assign(
 		__entry->cq_id = cid->ci_queue_id;
 		__entry->completion_id = cid->ci_completion_id;
-		__entry->status = wc->status;
-		if (wc->status)
-			__entry->vendor_err = wc->vendor_err;
-		else
-			__entry->vendor_err = 0;
 	),
 
-	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x)",
-		__entry->cq_id, __entry->completion_id,
-		rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
+	TP_printk("cq.id=%d cid=%d",
+		__entry->cq_id, __entry->completion_id
 	)
 );
 
-#define DEFINE_COMPLETION_EVENT(name)					\
-		DEFINE_EVENT(rpcrdma_completion_class, name,		\
+#define DEFINE_SIMPLE_CID_EVENT(name)					\
+		DEFINE_EVENT(rpcrdma_simple_cid_class, name,		\
 				TP_PROTO(				\
-					const struct ib_wc *wc,		\
 					const struct rpc_rdma_cid *cid	\
 				),					\
-				TP_ARGS(wc, cid))
+				TP_ARGS(cid)				\
+		)
 
-DECLARE_EVENT_CLASS(rpcrdma_send_completion_class,
+DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 	TP_PROTO(
 		const struct ib_wc *wc,
 		const struct rpc_rdma_cid *cid
@@ -73,20 +63,29 @@ DECLARE_EVENT_CLASS(rpcrdma_send_completion_class,
 	TP_STRUCT__entry(
 		__field(u32, cq_id)
 		__field(int, completion_id)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
 	),
 
 	TP_fast_assign(
 		__entry->cq_id = cid->ci_queue_id;
 		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		if (wc->status)
+			__entry->vendor_err = wc->vendor_err;
+		else
+			__entry->vendor_err = 0;
 	),
 
-	TP_printk("cq.id=%u cid=%d",
-		__entry->cq_id, __entry->completion_id
+	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x)",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err
 	)
 );
 
-#define DEFINE_SEND_COMPLETION_EVENT(name)				\
-		DEFINE_EVENT(rpcrdma_send_completion_class, name,	\
+#define DEFINE_COMPLETION_EVENT(name)					\
+		DEFINE_EVENT(rpcrdma_completion_class, name,		\
 				TP_PROTO(				\
 					const struct ib_wc *wc,		\
 					const struct rpc_rdma_cid *cid	\
@@ -978,27 +977,7 @@ TRACE_EVENT(xprtrdma_post_send_err,
 	)
 );
 
-TRACE_EVENT(xprtrdma_post_recv,
-	TP_PROTO(
-		const struct rpcrdma_rep *rep
-	),
-
-	TP_ARGS(rep),
-
-	TP_STRUCT__entry(
-		__field(u32, cq_id)
-		__field(int, completion_id)
-	),
-
-	TP_fast_assign(
-		__entry->cq_id = rep->rr_cid.ci_queue_id;
-		__entry->completion_id = rep->rr_cid.ci_completion_id;
-	),
-
-	TP_printk("cq.id=%d cid=%d",
-		__entry->cq_id, __entry->completion_id
-	)
-);
+DEFINE_SIMPLE_CID_EVENT(xprtrdma_post_recv);
 
 TRACE_EVENT(xprtrdma_post_recvs,
 	TP_PROTO(
@@ -2020,31 +1999,11 @@ TRACE_EVENT(svcrdma_post_send,
 	)
 );
 
-DEFINE_SEND_COMPLETION_EVENT(svcrdma_wc_send);
+DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_send);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_err);
 
-TRACE_EVENT(svcrdma_post_recv,
-	TP_PROTO(
-		const struct svc_rdma_recv_ctxt *ctxt
-	),
-
-	TP_ARGS(ctxt),
-
-	TP_STRUCT__entry(
-		__field(u32, cq_id)
-		__field(int, completion_id)
-	),
-
-	TP_fast_assign(
-		__entry->cq_id = ctxt->rc_cid.ci_queue_id;
-		__entry->completion_id = ctxt->rc_cid.ci_completion_id;
-	),
-
-	TP_printk("cq.id=%d cid=%d",
-		__entry->cq_id, __entry->completion_id
-	)
-);
+DEFINE_SIMPLE_CID_EVENT(svcrdma_post_recv);
 
 DEFINE_RECEIVE_SUCCESS_EVENT(svcrdma_wc_recv);
 DEFINE_RECEIVE_FLUSH_EVENT(svcrdma_wc_recv_flush);
@@ -2153,7 +2112,7 @@ TRACE_EVENT(svcrdma_wc_read,
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_err);
 
-DEFINE_SEND_COMPLETION_EVENT(svcrdma_wc_write);
+DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_write);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_err);
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index c8c1c534070b..72374033bb2b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -264,7 +264,7 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 		if (!ctxt)
 			break;
 
-		trace_svcrdma_post_recv(ctxt);
+		trace_svcrdma_post_recv(&ctxt->rc_cid);
 		ctxt->rc_recv_wr.next = recv_chain;
 		recv_chain = &ctxt->rc_recv_wr;
 		rdma->sc_pending_recvs++;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index de1ec3220aab..db2a4bd2f7ad 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -282,7 +282,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
-		trace_svcrdma_wc_write(wc, &cc->cc_cid);
+		trace_svcrdma_wc_write(&cc->cc_cid);
 		break;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 09f5d0570bc9..31b711deab5e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -305,7 +305,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		goto flushed;
 
-	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
+	trace_svcrdma_wc_send(&ctxt->sc_cid);
 	svc_rdma_send_ctxt_put(rdma, ctxt);
 	return;
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 28c0771c4e8c..4f8d7efa469f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1364,7 +1364,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 		}
 
 		rep->rr_cid.ci_queue_id = ep->re_attr.recv_cq->res.id;
-		trace_xprtrdma_post_recv(rep);
+		trace_xprtrdma_post_recv(&rep->rr_cid);
 		rep->rr_recv_wr.next = wr;
 		wr = &rep->rr_recv_wr;
 		--needed;



