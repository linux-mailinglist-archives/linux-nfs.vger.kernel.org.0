Return-Path: <linux-nfs+bounces-96-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9347FA68B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ACE1F20F36
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D29364DB;
	Mon, 27 Nov 2023 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrNQby2T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F036B0A;
	Mon, 27 Nov 2023 16:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E0C433CA;
	Mon, 27 Nov 2023 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102818;
	bh=5YOVMxDLVsAZTaK+Wm4nPQTpbOkeewHjzw0Q0J8RWy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IrNQby2TFsWjVTVNb9g19mauh+jZuEpaU+TzP0vgaP3GzQquvBrUI0Z/91+HCXpQs
	 RwWe0ujfLaDSKelrC93PiQSAcoxYUuztewM3yCNqR3lfEOc2kktpkbPLApuDiJjdN5
	 RX9IaKh8SaGloOhqmUculPQkiSdVmgXOFKgEkdk1RZdzoDeCzhNYQt+jmaDFPu+cB1
	 OAIZtzYrSwGREuP46js8602/GHWay7TZ9BYEAAvSSR1wlqtmKMZfEDBcg8x8SLoLJs
	 7V/xsa4QOMJu2Sh4dZfUNQyCy7pM5Jv2m4qEfIO9/HBWjpEt09HK48osmXwb3zL+D0
	 RsVixEogXo5vA==
Subject: [PATCH v1 3/5] svcrdma: SQ error tracepoints should report completion
 IDs
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:37 -0500
Message-ID: 
 <170110281706.49524.12668997627474561777.stgit@bazille.1015granger.net>
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

Update the Send Queue's error flow tracepoints to report the
completion ID of the waiting or failing context. This ties the
wait/failure to a particular operation or request, which is a little
more useful than knowing only the transport that is about to close.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   49 ++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    6 ++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    6 ++--
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index b3445e07c151..f1c2022d39ca 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2143,65 +2143,74 @@ TRACE_EVENT(svcrdma_qp_error,
 	)
 );
 
-DECLARE_EVENT_CLASS(svcrdma_sendqueue_event,
+DECLARE_EVENT_CLASS(svcrdma_sendqueue_class,
 	TP_PROTO(
-		const struct svcxprt_rdma *rdma
+		const struct svcxprt_rdma *rdma,
+		const struct rpc_rdma_cid *cid
 	),
 
-	TP_ARGS(rdma),
+	TP_ARGS(rdma, cid),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(int, avail)
 		__field(int, depth)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->avail = atomic_read(&rdma->sc_sq_avail);
 		__entry->depth = rdma->sc_sq_depth;
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s sc_sq_avail=%d/%d",
-		__get_str(addr), __entry->avail, __entry->depth
+	TP_printk("cq.id=%u cid=%d sc_sq_avail=%d/%d",
+		__entry->cq_id, __entry->completion_id,
+		__entry->avail, __entry->depth
 	)
 );
 
 #define DEFINE_SQ_EVENT(name)						\
-		DEFINE_EVENT(svcrdma_sendqueue_event, svcrdma_sq_##name,\
-				TP_PROTO(				\
-					const struct svcxprt_rdma *rdma \
-				),					\
-				TP_ARGS(rdma))
+		DEFINE_EVENT(svcrdma_sendqueue_class, name,		\
+			TP_PROTO(					\
+				const struct svcxprt_rdma *rdma,	\
+				const struct rpc_rdma_cid *cid		\
+			),						\
+			TP_ARGS(rdma, cid)				\
+		)
 
-DEFINE_SQ_EVENT(full);
-DEFINE_SQ_EVENT(retry);
+DEFINE_SQ_EVENT(svcrdma_sq_full);
+DEFINE_SQ_EVENT(svcrdma_sq_retry);
 
 TRACE_EVENT(svcrdma_sq_post_err,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
+		const struct rpc_rdma_cid *cid,
 		int status
 	),
 
-	TP_ARGS(rdma, status),
+	TP_ARGS(rdma, cid, status),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(int, avail)
 		__field(int, depth)
 		__field(int, status)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->avail = atomic_read(&rdma->sc_sq_avail);
 		__entry->depth = rdma->sc_sq_depth;
 		__entry->status = status;
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s sc_sq_avail=%d/%d status=%d",
-		__get_str(addr), __entry->avail, __entry->depth,
-		__entry->status
+	TP_printk("cq.id=%u cid=%d sc_sq_avail=%d/%d status=%d",
+		__entry->cq_id, __entry->completion_id,
+		__entry->avail, __entry->depth, __entry->status
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index db2a4bd2f7ad..b06e49cc55fb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -406,14 +406,14 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 		}
 
 		percpu_counter_inc(&svcrdma_stat_sq_starve);
-		trace_svcrdma_sq_full(rdma);
+		trace_svcrdma_sq_full(rdma, &cc->cc_cid);
 		atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
 		wait_event(rdma->sc_send_wait,
 			   atomic_read(&rdma->sc_sq_avail) > cc->cc_sqecount);
-		trace_svcrdma_sq_retry(rdma);
+		trace_svcrdma_sq_retry(rdma, &cc->cc_cid);
 	} while (1);
 
-	trace_svcrdma_sq_post_err(rdma, ret);
+	trace_svcrdma_sq_post_err(rdma, &cc->cc_cid, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 
 	/* If even one was posted, there will be a completion. */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 31b711deab5e..2ee691c45b85 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -343,13 +343,13 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	while (1) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
-			trace_svcrdma_sq_full(rdma);
+			trace_svcrdma_sq_full(rdma, &ctxt->sc_cid);
 			atomic_inc(&rdma->sc_sq_avail);
 			wait_event(rdma->sc_send_wait,
 				   atomic_read(&rdma->sc_sq_avail) > 1);
 			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
 				return -ENOTCONN;
-			trace_svcrdma_sq_retry(rdma);
+			trace_svcrdma_sq_retry(rdma, &ctxt->sc_cid);
 			continue;
 		}
 
@@ -360,7 +360,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		return 0;
 	}
 
-	trace_svcrdma_sq_post_err(rdma, ret);
+	trace_svcrdma_sq_post_err(rdma, &ctxt->sc_cid, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 	wake_up(&rdma->sc_send_wait);
 	return ret;



