Return-Path: <linux-nfs+bounces-290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C83128037DE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA831F2109B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8669428E16;
	Mon,  4 Dec 2023 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQWUTDZl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103D28E07;
	Mon,  4 Dec 2023 14:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA133C433C8;
	Mon,  4 Dec 2023 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701875;
	bh=S//QebyXq63Q3wfSqLgsO86x/iD4dK/oGX7kMMCPE3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MQWUTDZlREulJDq4LCEvJ1PtphjsaimrAGOcrsCd95QaCLTa3IdUq7fSncs9q8RfA
	 nnnj8xx1Wh6fy9Ucn3sW0a8jyobWzH8pYuQ9PYWSFYNzIhMv7DZjR8vDkUleW1iXk1
	 EAkHsAabD/LSGhZ+MIW6ugY8ufQMrRwiUptkYg9cZrIB2pX+rx+Lq6Zc4uk1fJQ9nB
	 FBmq7+X2WtZpL2u6R1i++PnxT2xnkO0UQrcB89HHDCa7JUZ1pErWZsEASsvotbT/1w
	 u5a5iEuLsh0l4hYaU/60dTEoh4Lk0/VS50CPgffZU1N/vGjl6pBVxks1jFY6VytUxw
	 GERnAhWbK9+RA==
Subject: [PATCH v1 15/21] svcrdma: Update the synopsis of
 svc_rdma_read_data_item()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:54 -0500
Message-ID: 
 <170170187471.54779.6812868392919776920.stgit@bazille.1015granger.net>
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
svc_rdma_build_read_data_item() can use that recv_ctxt to derive
that information rather than the other way around. This removes
another usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 63546e495cb3..1953f3983695 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -892,8 +892,8 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 
 /**
  * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Read chunks
- * @rdma: controlling transport
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The chunk data lands in the page list of rqstp->rq_arg.pages.
  *
@@ -908,17 +908,16 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
-				   struct svc_rdma_read_info *info)
+static int svc_rdma_read_data_item(struct svc_rqst *rqstp,
+				   struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
+	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct svc_rdma_chunk *chunk;
 	unsigned int length;
 	int ret;
 
 	chunk = pcl_first_chunk(&head->rc_read_pcl);
-	ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
+	ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
 	if (ret < 0)
 		goto out;
 
@@ -940,7 +939,7 @@ static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
 	 * Currently these chunks always start at page offset 0,
 	 * thus the rounded-up length never crosses a page boundary.
 	 */
-	buf->pages = &info->ri_rqst->rq_pages[0];
+	buf->pages = &rqstp->rq_pages[0];
 	length = xdr_align_size(chunk->ch_length);
 	buf->page_len = length;
 	buf->len += length;
@@ -1141,7 +1140,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {
 		if (head->rc_read_pcl.cl_count == 1)
-			ret = svc_rdma_read_data_item(rdma, info);
+			ret = svc_rdma_read_data_item(rqstp, head);
 		else
 			ret = svc_rdma_read_multiple_chunks(rdma, info);
 	} else



