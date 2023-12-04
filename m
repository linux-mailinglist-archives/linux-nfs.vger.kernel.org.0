Return-Path: <linux-nfs+bounces-284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB098037CD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1980228117D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D528DDB;
	Mon,  4 Dec 2023 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqTvAKok"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C228DB6;
	Mon,  4 Dec 2023 14:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A935C433C8;
	Mon,  4 Dec 2023 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701837;
	bh=3OscxjM9Iue/ZbE3TErjuUmZybYdKkPtNPFu300MfLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nqTvAKokFnYf2bX6s6o4IIYuhatTWU3kA6j+O6YJk2kdfq0vrsiUtgGqV0cgjWj2Z
	 aG0KqABivMlQsJSN/IgfOksNeqS+C0s58jhF4/k3hrltWzxbM2GnCY+SqL4L8P42Vj
	 fUFw03zHmM7i7DxQFgO9Nj1GFajkpFec5SGB8zpF9HDodul3krQvqK20VfW7oZhlMA
	 6nHe/xBN0eVjMaTUWq7jKs2qsN5r51BRwieOTbNDQ/ctV7+ENsUs2Qu15UIjY3IkGn
	 yQ47LQULIJwHLroTBtNnoJhjd28TgZZAIclTFDGoStrhW8D8zO26GBtWoPGM/RZ3Ag
	 s3OgERlPIdjsA==
Subject: [PATCH v1 09/21] svcrdma: Start moving fields out of struct
 svc_rdma_read_info
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:16 -0500
Message-ID: 
 <170170183617.54779.9252463863441572188.stgit@bazille.1015granger.net>
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

Since the request's svc_rdma_recv_ctxt will stay around for the
duration of the RDMA Read operation, the contents of struct
svc_rdma_read_info can reside in the request's svc_rdma_recv_ctxt
rather than being allocated separately. This will eventually save a
call to kmalloc() in a hot path.

Start this clean-up by moving the Read chunk's svc_rdma_chunk_ctxt.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    4 +++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   57 +++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 50c4f18a9b7f..6c7501ae4e29 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -156,6 +156,10 @@ struct svc_rdma_recv_ctxt {
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
+	/* State for pulling a Read chunk */
+	unsigned int		rc_readbytes;
+	struct svc_rdma_chunk_ctxt	rc_cc;
+
 	struct svc_rdma_pcl	rc_call_pcl;
 
 	struct svc_rdma_pcl	rc_read_pcl;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 1de56e9fea91..a27b8f338ae5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -294,9 +294,6 @@ struct svc_rdma_read_info {
 	struct svc_rdma_recv_ctxt	*ri_readctxt;
 	unsigned int			ri_pageno;
 	unsigned int			ri_pageoff;
-	unsigned int			ri_totalbytes;
-
-	struct svc_rdma_chunk_ctxt	ri_cc;
 };
 
 static struct svc_rdma_read_info *
@@ -304,20 +301,13 @@ svc_rdma_read_info_alloc(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_read_info *info;
 
-	info = kmalloc_node(sizeof(*info), GFP_KERNEL,
+	return kmalloc_node(sizeof(*info), GFP_KERNEL,
 			    ibdev_to_node(rdma->sc_cm_id->device));
-	if (!info)
-		return info;
-
-	svc_rdma_cc_init(rdma, &info->ri_cc);
-	info->ri_cc.cc_cqe.done = svc_rdma_wc_read_done;
-	return info;
 }
 
 static void svc_rdma_read_info_free(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_read_info *info)
 {
-	svc_rdma_cc_release(rdma, &info->ri_cc, DMA_FROM_DEVICE);
 	kfree(info);
 }
 
@@ -333,12 +323,12 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svc_rdma_read_info *info;
+	struct svc_rdma_recv_ctxt *ctxt;
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
-		info = container_of(cc, struct svc_rdma_read_info, ri_cc);
-		trace_svcrdma_wc_read(wc, &cc->cc_cid, info->ri_totalbytes,
+		ctxt = container_of(cc, struct svc_rdma_recv_ctxt, rc_cc);
+		trace_svcrdma_wc_read(wc, &cc->cc_cid, ctxt->rc_readbytes,
 				      cc->cc_posttime);
 		break;
 	case IB_WC_WR_FLUSH_ERR:
@@ -708,7 +698,7 @@ static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
 				       const struct svc_rdma_segment *segment)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	struct svc_rdma_chunk_ctxt *cc = &info->ri_cc;
+	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
 	struct svc_rqst *rqstp = info->ri_rqst;
 	unsigned int sge_no, seg_len, len;
 	struct svc_rdma_rw_ctxt *ctxt;
@@ -778,6 +768,7 @@ static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
 				     struct svc_rdma_read_info *info,
 				     const struct svc_rdma_chunk *chunk)
 {
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_segment *segment;
 	int ret;
 
@@ -786,7 +777,7 @@ static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
 		ret = svc_rdma_build_read_segment(rdma, info, segment);
 		if (ret < 0)
 			break;
-		info->ri_totalbytes += segment->rs_length;
+		head->rc_readbytes += segment->rs_length;
 	}
 	return ret;
 }
@@ -828,7 +819,7 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 		dst = page_address(rqstp->rq_pages[info->ri_pageno]);
 		memcpy(dst + info->ri_pageno, src + offset, page_len);
 
-		info->ri_totalbytes += page_len;
+		head->rc_readbytes += page_len;
 		info->ri_pageoff += page_len;
 		if (info->ri_pageoff == PAGE_SIZE) {
 			info->ri_pageno++;
@@ -883,7 +874,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 			break;
 
 		start += length;
-		length = next->ch_position - info->ri_totalbytes;
+		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_copy_inline_range(info, start, length);
 		if (ret < 0)
 			return ret;
@@ -895,13 +886,13 @@ static noinline int svc_rdma_read_multiple_chunks(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
-	buf->len += info->ri_totalbytes;
-	buf->buflen += info->ri_totalbytes;
+	buf->len += head->rc_readbytes;
+	buf->buflen += head->rc_readbytes;
 
 	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
 	buf->pages = &info->ri_rqst->rq_pages[1];
-	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
+	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
 	return 0;
 }
 
@@ -985,6 +976,7 @@ static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     unsigned int offset, unsigned int length)
 {
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_segment *segment;
 	int ret;
 
@@ -1005,7 +997,7 @@ static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
 		if (ret < 0)
 			break;
 
-		info->ri_totalbytes += dummy.rs_length;
+		head->rc_readbytes += dummy.rs_length;
 		length -= dummy.rs_length;
 		offset = 0;
 	}
@@ -1055,7 +1047,7 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 			break;
 
 		start += length;
-		length = next->ch_position - info->ri_totalbytes;
+		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_read_chunk_range(rdma, info, call_chunk,
 						start, length);
 		if (ret < 0)
@@ -1089,6 +1081,7 @@ static int svc_rdma_read_call_chunk(struct svcxprt_rdma *rdma,
 static noinline int svc_rdma_read_special(struct svcxprt_rdma *rdma,
 					  struct svc_rdma_read_info *info)
 {
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
 	int ret;
 
@@ -1096,13 +1089,13 @@ static noinline int svc_rdma_read_special(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		goto out;
 
-	buf->len += info->ri_totalbytes;
-	buf->buflen += info->ri_totalbytes;
+	buf->len += head->rc_readbytes;
+	buf->buflen += head->rc_readbytes;
 
 	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
 	buf->pages = &info->ri_rqst->rq_pages[1];
-	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
+	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
 
 out:
 	return ret;
@@ -1135,19 +1128,20 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 			       struct svc_rqst *rqstp,
 			       struct svc_rdma_recv_ctxt *head)
 {
+	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
 	struct svc_rdma_read_info *info;
-	struct svc_rdma_chunk_ctxt *cc;
 	int ret;
 
 	info = svc_rdma_read_info_alloc(rdma);
 	if (!info)
 		return -ENOMEM;
-	cc = &info->ri_cc;
 	info->ri_rqst = rqstp;
 	info->ri_readctxt = head;
 	info->ri_pageno = 0;
 	info->ri_pageoff = 0;
-	info->ri_totalbytes = 0;
+	svc_rdma_cc_init(rdma, cc);
+	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	head->rc_readbytes = 0;
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {
 		if (head->rc_read_pcl.cl_count == 1)
@@ -1178,6 +1172,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	head->rc_page_count = 0;
 
 out_err:
+	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
 	svc_rdma_read_info_free(rdma, info);
 	return ret;
 }



