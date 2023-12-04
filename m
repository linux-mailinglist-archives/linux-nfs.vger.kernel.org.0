Return-Path: <linux-nfs+bounces-292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E420C8037E2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AE91C20BAB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98428E17;
	Mon,  4 Dec 2023 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHlaSo4b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141A28DD7;
	Mon,  4 Dec 2023 14:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EEEC433C8;
	Mon,  4 Dec 2023 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701888;
	bh=946CeXARQLqXfsTMLhO5FktvMW01Gz0FAfGnvmr/SZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fHlaSo4bxsE1K1kOkiCjrS5r1IciVaQ5WrDFr2iEgp6lZtqFt79Om/KaBBxszZpDJ
	 3rKFNUw3ZbXAit54NqQQqg5XDh2DEW+hXoFCNb92XcCBAX00twKn2Tr5pHcXKMlg+B
	 89fAkaV4Etrpb/Oiw4MjuzJrwubbkgaDBX5ccOVveJFlnO4QBSHdpvIuC6fXorF4H+
	 XszwEvdLn4zMU0vTJpcavZUhM4Wtk4vzhZ3LKCqvAxbujDgr99AtqZWcHTTAq7er4k
	 UWTPzZgJsowy3yIsOLO3ToNKP7ljG179liOyTXFxdx+dh0fwNN6fxwdKHBYm+Xh9xf
	 nNPXdX24rNR9Q==
Subject: [PATCH v1 17/21] svcrdma: Update synopsis of
 svc_rdma_read_multiple_chunks()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:07 -0500
Message-ID: 
 <170170188752.54779.18431371210563356783.stgit@bazille.1015granger.net>
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
svc_rdma_read_multiple_chunks() can use that recv_ctxt to derive the
read_info rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index ec546fe094e8..56a8e602706a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -828,8 +828,8 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 
 /**
  * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
- * @rdma: controlling transport
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The chunk data lands in rqstp->rq_arg as a series of contiguous pages,
  * like an incoming TCP call.
@@ -841,12 +841,11 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
-						  struct svc_rdma_read_info *info)
+static noinline int
+svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
+			      struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
-	struct svc_rqst *rqstp = info->ri_rqst;
 	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct svc_rdma_chunk *chunk, *next;
 	unsigned int start, length;
@@ -860,7 +859,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info->ri_rqst, head, chunk);
+		ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -884,9 +883,9 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 	buf->len += head->rc_readbytes;
 	buf->buflen += head->rc_readbytes;
 
-	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
+	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
 	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
-	buf->pages = &info->ri_rqst->rq_pages[1];
+	buf->pages = &rqstp->rq_pages[1];
 	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
 	return 0;
 }
@@ -1143,7 +1142,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 		if (head->rc_read_pcl.cl_count == 1)
 			ret = svc_rdma_read_data_item(rqstp, head);
 		else
-			ret = svc_rdma_read_multiple_chunks(rdma, info);
+			ret = svc_rdma_read_multiple_chunks(rqstp, head);
 	} else
 		ret = svc_rdma_read_special(rdma, info);
 	if (ret < 0)



