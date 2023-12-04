Return-Path: <linux-nfs+bounces-279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1788037BC
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43FA28118B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD128E07;
	Mon,  4 Dec 2023 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZIhmkhE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636528DB6;
	Mon,  4 Dec 2023 14:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C71AC433C8;
	Mon,  4 Dec 2023 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701805;
	bh=OgxhiV6P9E3V+VCH1ztRduwpyc8kJqsYco7mhx4iJU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pZIhmkhEX6jOupnBCzDEPl9PNfGN7lhdOws5v8J0k3RvlMLW+pBqPtVphkRxX88aq
	 Q//yp60RJO4MGu5SHUmfOa+5qQcfelpg1xqsSuHNVKm0szKO7NqqI0wEyjJHV0mNKS
	 VsozFKiDEXXxBAGOy5WkBmM0cRtrIntC/yAN6mu3262OxFwaluqK/avuSFcnW7DIL6
	 f8X3QwFE1FlibCmwcPOzWms/sPeVwuM0sFr4BowxF24PCU+H3GEEgBqNVrElRNxWht
	 pw/9oQ3av42ILxisb8NbyauMybA8fKQw2HYS2AEmYCUkoR4pQxlKeJ7Geia+WRU+ZU
	 cCdnHNw/fPW+w==
Subject: [PATCH v1 04/21] svcrdma: Explicitly pass the transport into Read
 chunk I/O paths
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:44 -0500
Message-ID: 
 <170170180418.54779.17658853478664431036.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
References: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
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

Enable the eventual removal of the svc_rdma_chunk_ctxt::cc_rdma
field.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   58 +++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index ef2579141c33..cda57a5f8ba0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -712,6 +712,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
+ * @rdma: controlling transport
  * @info: context for ongoing I/O
  * @segment: co-ordinates of remote memory to be read
  *
@@ -721,7 +722,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
+				       struct svc_rdma_read_info *info,
 				       const struct svc_rdma_segment *segment)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
@@ -734,7 +736,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 
 	len = segment->rs_length;
 	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
-	ctxt = svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
+	ctxt = svc_rdma_get_rw_ctxt(rdma, sge_no);
 	if (!ctxt)
 		return -ENOMEM;
 	ctxt->rw_nents = sge_no;
@@ -764,7 +766,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 			goto out_overrun;
 	}
 
-	ret = svc_rdma_rw_ctx_init(cc->cc_rdma, ctxt, segment->rs_offset,
+	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
 				   segment->rs_handle, DMA_FROM_DEVICE);
 	if (ret < 0)
 		return -EIO;
@@ -781,6 +783,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_build_read_chunk - Build RDMA Read WQEs to pull one RDMA chunk
+ * @rdma: controlling transport
  * @info: context for ongoing I/O
  * @chunk: Read chunk to pull
  *
@@ -790,7 +793,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
+				     struct svc_rdma_read_info *info,
 				     const struct svc_rdma_chunk *chunk)
 {
 	const struct svc_rdma_segment *segment;
@@ -798,7 +802,7 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
 
 	ret = -EINVAL;
 	pcl_for_each_segment(segment, chunk) {
-		ret = svc_rdma_build_read_segment(info, segment);
+		ret = svc_rdma_build_read_segment(rdma, info, segment);
 		if (ret < 0)
 			break;
 		info->ri_totalbytes += segment->rs_length;
@@ -858,6 +862,7 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
+ * @rdma: controlling transport
  * @info: context for RDMA Reads
  *
  * The chunk data lands in rqstp->rq_arg as a series of contiguous pages,
@@ -870,7 +875,8 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *info)
+static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
+						  struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
@@ -887,7 +893,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info, chunk);
+		ret = svc_rdma_build_read_chunk(rdma, info, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -920,6 +926,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 
 /**
  * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Read chunks
+ * @rdma: controlling transport
  * @info: context for RDMA Reads
  *
  * The chunk data lands in the page list of rqstp->rq_arg.pages.
@@ -935,7 +942,8 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
+static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
+				   struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
@@ -944,7 +952,7 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
 	int ret;
 
 	chunk = pcl_first_chunk(&head->rc_read_pcl);
-	ret = svc_rdma_build_read_chunk(info, chunk);
+	ret = svc_rdma_build_read_chunk(rdma, info, chunk);
 	if (ret < 0)
 		goto out;
 
@@ -978,6 +986,7 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
 
 /**
  * svc_rdma_read_chunk_range - Build RDMA Read WQEs for portion of a chunk
+ * @rdma: controlling transport
  * @info: context for RDMA Reads
  * @chunk: parsed Call chunk to pull
  * @offset: offset of region to pull
@@ -990,7 +999,8 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
+static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
+				     struct svc_rdma_read_info *info,
 				     const struct svc_rdma_chunk *chunk,
 				     unsigned int offset, unsigned int length)
 {
@@ -1010,7 +1020,7 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
 		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
 		dummy.rs_offset = segment->rs_offset + offset;
 
-		ret = svc_rdma_build_read_segment(info, &dummy);
+		ret = svc_rdma_build_read_segment(rdma, info, &dummy);
 		if (ret < 0)
 			break;
 
@@ -1023,6 +1033,7 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_call_chunk - Build RDMA Read WQEs to pull a Long Message
+ * @rdma: controlling transport
  * @info: context for RDMA Reads
  *
  * Return values:
@@ -1032,7 +1043,8 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
+static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_chunk *call_chunk =
@@ -1043,17 +1055,17 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 	int ret;
 
 	if (pcl_is_empty(pcl))
-		return svc_rdma_build_read_chunk(info, call_chunk);
+		return svc_rdma_build_read_chunk(rdma, info, call_chunk);
 
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	ret = svc_rdma_read_chunk_range(rdma, info, call_chunk, start, length);
 	if (ret < 0)
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info, chunk);
+		ret = svc_rdma_build_read_chunk(rdma, info, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -1063,7 +1075,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 
 		start += length;
 		length = next->ch_position - info->ri_totalbytes;
-		ret = svc_rdma_read_chunk_range(info, call_chunk,
+		ret = svc_rdma_read_chunk_range(rdma, info, call_chunk,
 						start, length);
 		if (ret < 0)
 			return ret;
@@ -1071,11 +1083,12 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 
 	start += length;
 	length = call_chunk->ch_length - start;
-	return svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	return svc_rdma_read_chunk_range(rdma, info, call_chunk, start, length);
 }
 
 /**
  * svc_rdma_read_special - Build RDMA Read WQEs to pull a Long Message
+ * @rdma: controlling transport
  * @info: context for RDMA Reads
  *
  * The start of the data lands in the first page just after the
@@ -1092,12 +1105,13 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
+static noinline int svc_rdma_read_special(struct svcxprt_rdma *rdma,
+					  struct svc_rdma_read_info *info)
 {
 	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
 	int ret;
 
-	ret = svc_rdma_read_call_chunk(info);
+	ret = svc_rdma_read_call_chunk(rdma, info);
 	if (ret < 0)
 		goto out;
 
@@ -1156,11 +1170,11 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {
 		if (head->rc_read_pcl.cl_count == 1)
-			ret = svc_rdma_read_data_item(info);
+			ret = svc_rdma_read_data_item(rdma, info);
 		else
-			ret = svc_rdma_read_multiple_chunks(info);
+			ret = svc_rdma_read_multiple_chunks(rdma, info);
 	} else
-		ret = svc_rdma_read_special(info);
+		ret = svc_rdma_read_special(rdma, info);
 	if (ret < 0)
 		goto out_err;
 



