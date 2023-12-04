Return-Path: <linux-nfs+bounces-288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F98037D5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EBC281222
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4728E09;
	Mon,  4 Dec 2023 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In1gW7AR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6128DB6;
	Mon,  4 Dec 2023 14:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3576C433C7;
	Mon,  4 Dec 2023 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701863;
	bh=n3wHz5aWOpAAj05ahKkKr3/Se57U7uxMXD0fu4BCDmw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=In1gW7AR+reaepxVt5PCGYJp2vLL8+Rf5Wew+f3nZd7PAUe6ydww2rD6tHLFFp0Ys
	 it8WK0dCEiIRwy9a1kQnjr76qEgw3kChG1yeHwaeiHBPX8wbaI/nLBzKTEiWbiNZu2
	 pr21b2CDkh4rovekwSE+lpgoiQw+A5t4wdWX22INa18dfMAXi+cSSQXurWf3cLnRH+
	 B+AncJxGcEt3bbLERLHJyv9otaCR/i58fK4/ePOM4YmgVaC6ZRtqfnLg0IwYrJt+Ni
	 8BGFOjHMbW1sbZsbOPQKKiO94uwBH3SXH5yZ2KtoJZ6C+xTybSZuo5fqc55ouo8hiy
	 CA0mqwiwZHRjA==
Subject: [PATCH v1 13/21] svcrdma: Update synopsis of
 svc_rdma_build_read_chunk()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:41 -0500
Message-ID: 
 <170170186189.54779.4397249414679111475.stgit@bazille.1015granger.net>
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
svc_rdma_build_read_chunk() can use that recv_ctxt to derive that
information rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c2d0e4bb454e..b10341cd1df2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -749,8 +749,8 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 
 /**
  * svc_rdma_build_read_chunk - Build RDMA Read WQEs to pull one RDMA chunk
- * @rdma: controlling transport
- * @info: context for ongoing I/O
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @chunk: Read chunk to pull
  *
  * Return values:
@@ -759,18 +759,16 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
-				     struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_segment *segment;
 	int ret;
 
 	ret = -EINVAL;
 	pcl_for_each_segment(segment, chunk) {
-		ret = svc_rdma_build_read_segment(info->ri_rqst,
-						  info->ri_readctxt, segment);
+		ret = svc_rdma_build_read_segment(rqstp, head, segment);
 		if (ret < 0)
 			break;
 		head->rc_readbytes += segment->rs_length;
@@ -861,7 +859,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(rdma, info, chunk);
+		ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -920,7 +918,7 @@ static int svc_rdma_read_data_item(struct svcxprt_rdma *rdma,
 	int ret;
 
 	chunk = pcl_first_chunk(&head->rc_read_pcl);
-	ret = svc_rdma_build_read_chunk(rdma, info, chunk);
+	ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
 	if (ret < 0)
 		goto out;
 
@@ -1025,7 +1023,8 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 	int ret;
 
 	if (pcl_is_empty(pcl))
-		return svc_rdma_build_read_chunk(rdma, info, call_chunk);
+		return svc_rdma_build_read_chunk(info->ri_rqst, head,
+						 call_chunk);
 
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
@@ -1035,7 +1034,7 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(rdma, info, chunk);
+		ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
 		if (ret < 0)
 			return ret;
 



