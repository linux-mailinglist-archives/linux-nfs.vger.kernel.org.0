Return-Path: <linux-nfs+bounces-98-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C80B7FA693
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29102281A66
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC3364D0;
	Mon, 27 Nov 2023 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JafuWhO9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E632374D9;
	Mon, 27 Nov 2023 16:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2327BC433C8;
	Mon, 27 Nov 2023 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102831;
	bh=0xwrsVsqBTI3G+nXyOC3xn+wjwZZsJXyDBKhcdM8ygk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JafuWhO9elbsU5TZ7bD8awq/xNudOE7+OWZctpq4k+utlLGpJ5g5jsJ+5tqiV11yU
	 XSd8IdCRvC8MLODOaclC+zCxLlqDmprKcPlLfzL18JBCBHSTc33dAnVlPOCjtpKG4Y
	 mJhPZrZEHIvfMwfgmrZ9wliO0dQ2QqwM9X9ND596S7lfUagtSR3zX32WgM4uG1EQH5
	 VGk7HOrUt41D1Xzxh9qVuRKtFBpyiRXWqsvkwYDUe9rcap9/6c2C/DshNx+37bZ6Z+
	 ugl/UWtT02TI9RQYCOjG8AwBDOeNSHzLBFG6HzG97yOBAbK6eQCx3GCWaNS3nAM3bR
	 nR70nrTHtpSuw==
Subject: [PATCH v1 5/5] svcrdma: Update some svcrdma DMA-related tracepoints
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:50 -0500
Message-ID: 
 <170110283021.49524.4951369507516981349.stgit@bazille.1015granger.net>
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

A send/recv_ctxt already records transport-related information
in the cq.id, thus there is no need to record the IP addresses of
the transport endpoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   21 +++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   10 +++++-----
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bba758e5fb1d..9a3fc6eb09a8 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1762,29 +1762,29 @@ DEFINE_ERROR_EVENT(chunk);
 
 DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 	TP_PROTO(
-		const struct svcxprt_rdma *rdma,
+		const struct rpc_rdma_cid *cid,
 		u64 dma_addr,
 		u32 length
 	),
 
-	TP_ARGS(rdma, dma_addr, length),
+	TP_ARGS(cid, dma_addr, length),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(u64, dma_addr)
 		__field(u32, length)
-		__string(device, rdma->sc_cm_id->device->name)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->dma_addr = dma_addr;
 		__entry->length = length;
-		__assign_str(device, rdma->sc_cm_id->device->name);
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s dma_addr=%llu length=%u",
-		__get_str(addr), __get_str(device),
+	TP_printk("cq.id=%u cid=%d dma_addr=%llu length=%u",
+		__entry->cq_id, __entry->completion_id,
 		__entry->dma_addr, __entry->length
 	)
 );
@@ -1792,11 +1792,12 @@ DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 #define DEFINE_SVC_DMA_EVENT(name)					\
 		DEFINE_EVENT(svcrdma_dma_map_class, svcrdma_##name,	\
 				TP_PROTO(				\
-					const struct svcxprt_rdma *rdma,\
+					const struct rpc_rdma_cid *cid, \
 					u64 dma_addr,			\
 					u32 length			\
 				),					\
-				TP_ARGS(rdma, dma_addr, length))
+				TP_ARGS(cid, dma_addr, length)		\
+		)
 
 DEFINE_SVC_DMA_EVENT(dma_map_page);
 DEFINE_SVC_DMA_EVENT(dma_map_err);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 2ee691c45b85..9571ed4a74d4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -237,13 +237,13 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	 * remains mapped until @ctxt is destroyed.
 	 */
 	for (i = 1; i < ctxt->sc_send_wr.num_sge; i++) {
+		trace_svcrdma_dma_unmap_page(&ctxt->sc_cid,
+					     ctxt->sc_sges[i].addr,
+					     ctxt->sc_sges[i].length);
 		ib_dma_unmap_page(device,
 				  ctxt->sc_sges[i].addr,
 				  ctxt->sc_sges[i].length,
 				  DMA_TO_DEVICE);
-		trace_svcrdma_dma_unmap_page(rdma,
-					     ctxt->sc_sges[i].addr,
-					     ctxt->sc_sges[i].length);
 	}
 
 	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
@@ -550,14 +550,14 @@ static int svc_rdma_page_dma_map(void *data, struct page *page,
 	if (ib_dma_mapping_error(dev, dma_addr))
 		goto out_maperr;
 
-	trace_svcrdma_dma_map_page(rdma, dma_addr, len);
+	trace_svcrdma_dma_map_page(&ctxt->sc_cid, dma_addr, len);
 	ctxt->sc_sges[ctxt->sc_cur_sge_no].addr = dma_addr;
 	ctxt->sc_sges[ctxt->sc_cur_sge_no].length = len;
 	ctxt->sc_send_wr.num_sge++;
 	return 0;
 
 out_maperr:
-	trace_svcrdma_dma_map_err(rdma, dma_addr, len);
+	trace_svcrdma_dma_map_err(&ctxt->sc_cid, dma_addr, len);
 	return -EIO;
 }
 



