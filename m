Return-Path: <linux-nfs+bounces-289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5788037D8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52FE1F21083
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1628E09;
	Mon,  4 Dec 2023 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOcRet1B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685928E07;
	Mon,  4 Dec 2023 14:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED97C433C8;
	Mon,  4 Dec 2023 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701869;
	bh=IID4zfcbPIJWxSv88yoWkRmLa0L46Atu/uJUexAMjTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LOcRet1BHXWHN4COE1vO5s4ukbRB46r/QABoVeDkAkadw5JIl+ervM5NmjjuSIhxn
	 sdLvSTIJVO1KJzttoi4enU+ciQAAHVSMw5KTrwkOCs8CX/7dBoVQmd3bF+udKO/srv
	 DyqybD/qgO6EadaUpuEaGovPbXfjBJJWWbMP0Kx2CTTx1MbhswaH7iXcvvur2shDif
	 ANJg51UUZZclNFe15vA3aaqPqvbugJseytKj4YUcSokQqBeacI/OJNkqMEaOE+RcLi
	 c9UixWEoIV6iHVkHVAj3EjeeCYVBc28KPYnxAbiyo/UDKRbJG9uFzhn8J68glVc6Rk
	 zVvBkT47Od+7Q==
Subject: [PATCH v1 14/21] svcrdma: Update synopsis of
 svc_rdma_read_chunk_range()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:48 -0500
Message-ID: 
 <170170186831.54779.16050871298354878197.stgit@bazille.1015granger.net>
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

Since the RDMA Read I/O state is now contained in the recv_ctxt,
svc_rdma_build_read_chunk_range() can use that recv_ctxt to derive
that information rather than the other way around. This removes
another usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b10341cd1df2..63546e495cb3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -951,9 +951,9 @@ static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_read_chunk_range - Build RDMA Read WQEs for portion of a chunk
- * @rdma: controlling transport
- * @info: context for RDMA Reads
+ * svc_rdma_read_chunk_range - Build RDMA Read WRs for portion of a chunk
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @chunk: parsed Call chunk to pull
  * @offset: offset of region to pull
  * @length: length of region to pull
@@ -965,12 +965,11 @@ static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
-				     struct svc_rdma_read_info *info,
+static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk,
 				     unsigned int offset, unsigned int length)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_segment *segment;
 	int ret;
 
@@ -987,8 +986,7 @@ static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
 		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
 		dummy.rs_offset = segment->rs_offset + offset;
 
-		ret = svc_rdma_build_read_segment(info->ri_rqst,
-						  info->ri_readctxt, &dummy);
+		ret = svc_rdma_build_read_segment(rqstp, head, &dummy);
 		if (ret < 0)
 			break;
 
@@ -1029,7 +1027,8 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_read_chunk_range(rdma, info, call_chunk, start, length);
+	ret = svc_rdma_read_chunk_range(info->ri_rqst, head, call_chunk,
+					start, length);
 	if (ret < 0)
 		return ret;
 
@@ -1044,15 +1043,16 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 
 		start += length;
 		length = next->ch_position - head->rc_readbytes;
-		ret = svc_rdma_read_chunk_range(rdma, info, call_chunk,
-						start, length);
+		ret = svc_rdma_read_chunk_range(info->ri_rqst, head,
+						call_chunk, start, length);
 		if (ret < 0)
 			return ret;
 	}
 
 	start += length;
 	length = call_chunk->ch_length - start;
-	return svc_rdma_read_chunk_range(rdma, info, call_chunk, start, length);
+	return svc_rdma_read_chunk_range(info->ri_rqst, head, call_chunk,
+					 start, length);
 }
 
 /**



