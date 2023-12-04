Return-Path: <linux-nfs+bounces-291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC528037E0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2959F2811AD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C228E1B;
	Mon,  4 Dec 2023 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Yz6U4F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901F28E07;
	Mon,  4 Dec 2023 14:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CF4C433C7;
	Mon,  4 Dec 2023 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701882;
	bh=Ifs1b4D+12H3+Xq1PAoVTzN+h3kpmD+g2y42gQChy20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S6Yz6U4FDnczDBvs+JWKwhddlLw3Ima2HA/1W5WGcX9+8m+Dck5FCUf2I8yd66zpg
	 ardZGXYCRFgr1gvud7/rS/0OcjVLZsvdt0PXNdtGO3gk2MtnqCqkhRZjEpFjjzKPNU
	 eBRVUT9k9PPfNR29jUgWPWGHqfOUvScx6lS6KwfQlxhU8T6wArMw/ZjWlrm3YlA++U
	 PN4HUOHFmP8YfUJIis9dV874IihyUQkQt5tNuEwbRMj+W0xzFt7BK9bTc7Bo/1vmWF
	 jo4HHqX+DSRTAoISw5d/kyb/guFqXuFEaAmCdEcFAxZoYId1AKV2vUW7JBcvxrWQXx
	 uif43/kolt7Dg==
Subject: [PATCH v1 16/21] svcrdma: Update synopsis of
 svc_rdma_copy_inline_range()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:01 -0500
Message-ID: 
 <170170188115.54779.13782774908081053344.stgit@bazille.1015granger.net>
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
svc_rdma_copy_inline_range() can use that recv_ctxt to derive the
read_info rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 1953f3983695..ec546fe094e8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -778,7 +778,8 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 
 /**
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @offset: offset into the Receive buffer of region to copy
  * @remaining: length of region to copy
  *
@@ -791,13 +792,12 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
  *   %0: Inline content was successfully copied
  *   %-EINVAL: offset or length was incorrect
  */
-static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
+static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
+				      struct svc_rdma_recv_ctxt *head,
 				      unsigned int offset,
 				      unsigned int remaining)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	unsigned char *dst, *src = head->rc_recv_buf;
-	struct svc_rqst *rqstp = info->ri_rqst;
 	unsigned int page_no, numpages;
 
 	numpages = PAGE_ALIGN(head->rc_pageoff + remaining) >> PAGE_SHIFT;
@@ -846,7 +846,8 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
+	struct svc_rqst *rqstp = info->ri_rqst;
+	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct svc_rdma_chunk *chunk, *next;
 	unsigned int start, length;
 	int ret;
@@ -854,7 +855,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_copy_inline_range(info, start, length);
+	ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 	if (ret < 0)
 		return ret;
 
@@ -869,14 +870,14 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 
 		start += length;
 		length = next->ch_position - head->rc_readbytes;
-		ret = svc_rdma_copy_inline_range(info, start, length);
+		ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 		if (ret < 0)
 			return ret;
 	}
 
 	start += length;
 	length = head->rc_byte_len - start;
-	ret = svc_rdma_copy_inline_range(info, start, length);
+	ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 	if (ret < 0)
 		return ret;
 



