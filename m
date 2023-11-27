Return-Path: <linux-nfs+bounces-97-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9E7FA690
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624E6281AE5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C33716E;
	Mon, 27 Nov 2023 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhw3Rk0N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78536B18;
	Mon, 27 Nov 2023 16:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8FC433CB;
	Mon, 27 Nov 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102825;
	bh=NMAGBd18mICFtdZSaprt2tz+g9mcjLQh/meV0koSYYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zhw3Rk0NesaMmX6rVXZJmqemyNQKC4GgvGPw59ikolXGXiLdKb3E5J+Ajk/AkqPh9
	 jueXVLkdDo0dw/dpw/x/OeHeeBKmVXC/9dpEe8kK6h2YY1A0+KHJbqVwtXq2Mgc80i
	 8qWbGxQrMjWuLlqwIQk8TM6E2+6q7UUm4JdUmRdZZPOBOiTLkGj/k/Cr8ldOPiUHJW
	 W6L7qhz4z28CNJec8vHTCwQcbE2NoaJDtXWHeWQSzbOxvG0kLcKanoe7MrkJfq6Xt5
	 fk9SUldRn5LHl/IgDLH2h278KeP8oNTgEGDvJPcomYW3PRINGlUdfazV8Ut/icQM/X
	 iEsKLnbXKrU2Q==
Subject: [PATCH v1 4/5] svcrdma: DMA error tracepoints should report
 completion IDs
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:43 -0500
Message-ID: 
 <170110282361.49524.15995241363735316406.stgit@bazille.1015granger.net>
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

Update the DMA error flow tracepoints to report the completion ID of
the failing context. This ties the wait/failure to a particular
operation or request, which is more useful than knowing only the
failing transport.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   74 +++++++++++++++++++------------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    9 +++--
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f1c2022d39ca..bba758e5fb1d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1805,33 +1805,37 @@ DEFINE_SVC_DMA_EVENT(dma_unmap_page);
 TRACE_EVENT(svcrdma_dma_map_rw_err,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
+		u64 offset,
+		u32 handle,
 		unsigned int nents,
 		int status
 	),
 
-	TP_ARGS(rdma, nents, status),
+	TP_ARGS(rdma, offset, handle, nents, status),
 
 	TP_STRUCT__entry(
-		__field(int, status)
+		__field(u32, cq_id)
+		__field(u32, handle)
+		__field(u64, offset)
 		__field(unsigned int, nents)
-		__string(device, rdma->sc_cm_id->device->name)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+		__field(int, status)
 	),
 
 	TP_fast_assign(
-		__entry->status = status;
+		__entry->cq_id = rdma->sc_sq_cq->res.id;
+		__entry->handle = handle;
+		__entry->offset = offset;
 		__entry->nents = nents;
-		__assign_str(device, rdma->sc_cm_id->device->name);
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+		__entry->status = status;
 	),
 
-	TP_printk("addr=%s device=%s nents=%u status=%d",
-		__get_str(addr), __get_str(device), __entry->nents,
-		__entry->status
+	TP_printk("cq.id=%u 0x%016llx:0x%08x nents=%u status=%d",
+		__entry->cq_id, (unsigned long long)__entry->offset,
+		__entry->handle, __entry->nents, __entry->status
 	)
 );
 
-TRACE_EVENT(svcrdma_no_rwctx_err,
+TRACE_EVENT(svcrdma_rwctx_empty,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
 		unsigned int num_sges
@@ -1840,79 +1844,75 @@ TRACE_EVENT(svcrdma_no_rwctx_err,
 	TP_ARGS(rdma, num_sges),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
 		__field(unsigned int, num_sges)
-		__string(device, rdma->sc_cm_id->device->name)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = rdma->sc_sq_cq->res.id;
 		__entry->num_sges = num_sges;
-		__assign_str(device, rdma->sc_cm_id->device->name);
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s num_sges=%d",
-		__get_str(addr), __get_str(device), __entry->num_sges
+	TP_printk("cq.id=%u num_sges=%d",
+		__entry->cq_id, __entry->num_sges
 	)
 );
 
 TRACE_EVENT(svcrdma_page_overrun_err,
 	TP_PROTO(
-		const struct svcxprt_rdma *rdma,
-		const struct svc_rqst *rqst,
+		const struct rpc_rdma_cid *cid,
 		unsigned int pageno
 	),
 
-	TP_ARGS(rdma, rqst, pageno),
+	TP_ARGS(cid, pageno),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(unsigned int, pageno)
-		__field(u32, xid)
-		__string(device, rdma->sc_cm_id->device->name)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->pageno = pageno;
-		__entry->xid = __be32_to_cpu(rqst->rq_xid);
-		__assign_str(device, rdma->sc_cm_id->device->name);
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s xid=0x%08x pageno=%u", __get_str(addr),
-		__get_str(device), __entry->xid, __entry->pageno
+	TP_printk("cq.id=%u cid=%d pageno=%u",
+		__entry->cq_id, __entry->completion_id,
+		__entry->pageno
 	)
 );
 
 TRACE_EVENT(svcrdma_small_wrch_err,
 	TP_PROTO(
-		const struct svcxprt_rdma *rdma,
+		const struct rpc_rdma_cid *cid,
 		unsigned int remaining,
 		unsigned int seg_no,
 		unsigned int num_segs
 	),
 
-	TP_ARGS(rdma, remaining, seg_no, num_segs),
+	TP_ARGS(cid, remaining, seg_no, num_segs),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(unsigned int, remaining)
 		__field(unsigned int, seg_no)
 		__field(unsigned int, num_segs)
-		__string(device, rdma->sc_cm_id->device->name)
-		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->remaining = remaining;
 		__entry->seg_no = seg_no;
 		__entry->num_segs = num_segs;
-		__assign_str(device, rdma->sc_cm_id->device->name);
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s remaining=%u seg_no=%u num_segs=%u",
-		__get_str(addr), __get_str(device), __entry->remaining,
-		__entry->seg_no, __entry->num_segs
+	TP_printk("cq.id=%u cid=%d remaining=%u seg_no=%u num_segs=%u",
+		__entry->cq_id, __entry->completion_id,
+		__entry->remaining, __entry->seg_no, __entry->num_segs
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b06e49cc55fb..c06676714417 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -80,7 +80,7 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 out_free:
 	kfree(ctxt);
 out_noctx:
-	trace_svcrdma_no_rwctx_err(rdma, sges);
+	trace_svcrdma_rwctx_empty(rdma, sges);
 	return NULL;
 }
 
@@ -135,8 +135,9 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 			       ctxt->rw_sg_table.sgl, ctxt->rw_nents,
 			       0, offset, handle, direction);
 	if (unlikely(ret < 0)) {
+		trace_svcrdma_dma_map_rw_err(rdma, offset, handle,
+					     ctxt->rw_nents, ret);
 		svc_rdma_put_rw_ctxt(rdma, ctxt);
-		trace_svcrdma_dma_map_rw_err(rdma, ctxt->rw_nents, ret);
 	}
 	return ret;
 }
@@ -526,7 +527,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return 0;
 
 out_overflow:
-	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
+	trace_svcrdma_small_wrch_err(&cc->cc_cid, remaining, info->wi_seg_no,
 				     info->wi_chunk->ch_segcount);
 	return -E2BIG;
 }
@@ -766,7 +767,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return 0;
 
 out_overrun:
-	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, info->ri_pageno);
+	trace_svcrdma_page_overrun_err(&cc->cc_cid, info->ri_pageno);
 	return -EINVAL;
 }
 



