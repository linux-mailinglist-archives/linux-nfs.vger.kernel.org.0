Return-Path: <linux-nfs+bounces-293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49C8037E5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05086B20901
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4D28E17;
	Mon,  4 Dec 2023 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7lAqI56"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CD28DD7;
	Mon,  4 Dec 2023 14:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A8C433C7;
	Mon,  4 Dec 2023 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701895;
	bh=4G/2aNFMLvMJ1fx8NONlwzYuGwF2Gbt7y0yFWcIea24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k7lAqI566pV1zz0YnJkZYYqCMnS2AkI1LRXd7PpqriQUtHQlqo2yF7VHS1C2Cl/W1
	 nutpzjVs/f7rMNgW7ucP46rAlma/9UPWFYQXT52ZhO/ewdSmFhz/IYTgyLpOhFXyR3
	 BLh73lV2aVnvr6xem4j2Hhn6UoZOtYG5OXuOettdYuxPjJ91GBq4c1pYVANkzuasju
	 SN0ZCXCHefhwwvUQqbbp250VjBq6J+A7dVIHpDegw1TwbkgSJtTOxQGLc455YUJpMX
	 yBKDwKFQfOEP0YUIPB1kYXJXWno0iBz8nb7PUkyJiZG/ETNaakDhRiN1api7XSLLDa
	 ogRO1eR84E+DA==
Subject: [PATCH v1 18/21] svcrdma: Update the synopsis of
 svc_rdma_read_call_chunk()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:13 -0500
Message-ID: 
 <170170189394.54779.8978743190987906689.stgit@bazille.1015granger.net>
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
svc_rdma_read_call_chunk() can use that recv_ctxt to derive the
read_info rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 56a8e602706a..f9d1b0463282 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -998,8 +998,8 @@ static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
 
 /**
  * svc_rdma_read_call_chunk - Build RDMA Read WQEs to pull a Long Message
- * @rdma: controlling transport
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * Return values:
  *   %0: RDMA Read WQEs were successfully built
@@ -1008,10 +1008,9 @@ static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_read_info *info)
+static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
+				    struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_chunk *call_chunk =
 			pcl_first_chunk(&head->rc_call_pcl);
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
@@ -1020,19 +1019,18 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 	int ret;
 
 	if (pcl_is_empty(pcl))
-		return svc_rdma_build_read_chunk(info->ri_rqst, head,
-						 call_chunk);
+		return svc_rdma_build_read_chunk(rqstp, head, call_chunk);
 
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_read_chunk_range(info->ri_rqst, head, call_chunk,
+	ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					start, length);
 	if (ret < 0)
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
+		ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -1042,15 +1040,15 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 
 		start += length;
 		length = next->ch_position - head->rc_readbytes;
-		ret = svc_rdma_read_chunk_range(info->ri_rqst, head,
-						call_chunk, start, length);
+		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
+						start, length);
 		if (ret < 0)
 			return ret;
 	}
 
 	start += length;
 	length = call_chunk->ch_length - start;
-	return svc_rdma_read_chunk_range(info->ri_rqst, head, call_chunk,
+	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					 start, length);
 }
 
@@ -1080,7 +1078,7 @@ static noinline int svc_rdma_read_special(struct svcxprt_rdma *rdma,
 	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
 	int ret;
 
-	ret = svc_rdma_read_call_chunk(rdma, info);
+	ret = svc_rdma_read_call_chunk(info->ri_rqst, info->ri_readctxt);
 	if (ret < 0)
 		goto out;
 



