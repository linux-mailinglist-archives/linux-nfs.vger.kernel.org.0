Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7C299603
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781894AbgJZSy4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45801 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781766AbgJZSy4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id 188so9382846qkk.12;
        Mon, 26 Oct 2020 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AzHrdzOL6+tZZI5Fvarus5ZZbYzgkG0ucE2JWb53Ag0=;
        b=CmBqgRXj+Gjwwgmk81TsNFStGzqgjEEdjj+IJAH1Jr8WjqUCwIi8QaWmO38+8T28jY
         sBOjqwIYJaliLXLo+6fAST5dUt3A0058IedyHFf8MezOrkO1cOomgHpH6DN9W4aaAtvE
         zEsdcdYwRHQDfqylPfO0P4h47rWQeCE6oV9/JaBu6FCdiKZ9hEGsAW6KBX6F2wAwuObL
         1NOZuBRdbH4nEbjN01SWnS/1vMMTjlCt0S3GWNnF3dNjWPSrW4KrKBwV8lWZRZatZhBw
         wEG1rLpXPSjGHr/NGcNCwsWkDl3Y+ol4pq1rzbxZTlliIP7Q6K6sgv6KmtloEWbaDGf/
         e+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AzHrdzOL6+tZZI5Fvarus5ZZbYzgkG0ucE2JWb53Ag0=;
        b=ATO1N3k0rHPpZK8ou9bUrxWkDOd/7zlhhLZsStZklyHZ2kJdvJPJfZMYSKrWFaOj+C
         Xj7lqzaeDa8dJuK512ycJBAbjeyC2JiNJCbfNofYHhd+tR9ExeoC0zp5sSDJjocGBDGM
         tLS54OgURdZg7GRsZEmCmLvxSCHxpCPiNapra/tMT/MknW0QbGHl5mj5eJJcg9cl6xBp
         nrBiaNbqitp3miMMGrDHj0GZsPBuVXhjk46Wo3HwJH/0f2RauqQt0JoRXWFWljeVYxUK
         1WA0tHn+GQj4byfJMNsaD3B3c+d6rpCG3Hrsz5RigsXOWAb2uw1yvN26qlDfv+IlL1Wd
         HBTA==
X-Gm-Message-State: AOAM5300ihHh8fNwZzgvxYzcyXVigPtA0yeelEPzXYI+r9owoYGJYxiB
        zZmt7vrLVW9ER+QQ6cpX7/pJwqdaZ8Y=
X-Google-Smtp-Source: ABdhPJyRSDJhPM7eU17hC1cxNfcTA/TKnL8IR0pvv7InAx0gsAPpMM3GFw1GS7BnZ95ekC97RLpAog==
X-Received: by 2002:a05:620a:150b:: with SMTP id i11mr2319980qkk.46.1603738493184;
        Mon, 26 Oct 2020 11:54:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m12sm4419666qtu.52.2020.10.26.11.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:52 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIspaN013646;
        Mon, 26 Oct 2020 18:54:51 GMT
Subject: [PATCH 11/20] svcrdma: Use parsed chunk lists to construct RDMA
 Writes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:51 -0400
Message-ID: <160373849146.1886.1814463689751473091.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Instead of re-parsing the ingress RPC Call transport
header when constructing RDMA Writes, use the new parsed chunk lists
for the Write list and Reply chunk, which are version-agnostic and
already XDR-decoded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    5 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    1 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   47 +++++++++++++++----------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   22 +++++++++------
 4 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 74247a33b6c6..d9148787efff 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -157,8 +157,6 @@ struct svc_rdma_recv_ctxt {
 	__be32			*rc_reply_chunk;
 	struct svc_rdma_pcl	rc_reply_pcl;
 
-	unsigned int		rc_read_payload_offset;
-	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
@@ -196,7 +194,8 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
 				    struct svc_rqst *rqstp,
 				    struct svc_rdma_recv_ctxt *head, __be32 *p);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *wr_ch, const struct xdr_buf *xdr);
+				     const struct svc_rdma_chunk *chunk,
+				     const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
 				     struct xdr_buf *xdr);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 72b07e8aa3c9..7d44e9d2e7a3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -207,7 +207,6 @@ svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
-	ctxt->rc_read_payload_length = 0;
 	return ctxt;
 
 out_empty:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 5f667d964cd6..05dd0896860f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -190,11 +190,11 @@ static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
  *  - Stores arguments for the SGL constructor functions
  */
 struct svc_rdma_write_info {
+	const struct svc_rdma_chunk	*wi_chunk;
+
 	/* write state of this chunk */
 	unsigned int		wi_seg_off;
 	unsigned int		wi_seg_no;
-	unsigned int		wi_nsegs;
-	__be32			*wi_segs;
 
 	/* SGL constructor arguments */
 	const struct xdr_buf	*wi_xdr;
@@ -205,7 +205,8 @@ struct svc_rdma_write_info {
 };
 
 static struct svc_rdma_write_info *
-svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma, __be32 *chunk)
+svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
+			  const struct svc_rdma_chunk *chunk)
 {
 	struct svc_rdma_write_info *info;
 
@@ -213,10 +214,9 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma, __be32 *chunk)
 	if (!info)
 		return info;
 
+	info->wi_chunk = chunk;
 	info->wi_seg_off = 0;
 	info->wi_seg_no = 0;
-	info->wi_nsegs = be32_to_cpup(++chunk);
-	info->wi_segs = ++chunk;
 	svc_rdma_cc_init(rdma, &info->wi_cc);
 	info->wi_cc.cc_cqe.done = svc_rdma_write_done;
 	return info;
@@ -443,40 +443,36 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 {
 	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
 	struct svcxprt_rdma *rdma = cc->cc_rdma;
+	const struct svc_rdma_segment *seg;
 	struct svc_rdma_rw_ctxt *ctxt;
-	__be32 *seg;
 	int ret;
 
-	seg = info->wi_segs + info->wi_seg_no * rpcrdma_segment_maxsz;
 	do {
 		unsigned int write_len;
-		u32 handle, length;
 		u64 offset;
 
-		if (info->wi_seg_no >= info->wi_nsegs)
+		seg = &info->wi_chunk->ch_segments[info->wi_seg_no];
+		if (!seg)
 			goto out_overflow;
 
-		xdr_decode_rdma_segment(seg, &handle, &length, &offset);
-		offset += info->wi_seg_off;
-
-		write_len = min(remaining, length - info->wi_seg_off);
+		write_len = min(remaining, seg->rs_length - info->wi_seg_off);
 		ctxt = svc_rdma_get_rw_ctxt(rdma,
 					    (write_len >> PAGE_SHIFT) + 2);
 		if (!ctxt)
 			return -ENOMEM;
 
 		constructor(info, write_len, ctxt);
-		ret = svc_rdma_rw_ctx_init(rdma, ctxt, offset, handle,
+		offset = seg->rs_offset + info->wi_seg_off;
+		ret = svc_rdma_rw_ctx_init(rdma, ctxt, offset, seg->rs_handle,
 					   DMA_TO_DEVICE);
 		if (ret < 0)
 			return -EIO;
 
-		trace_svcrdma_send_wseg(handle, write_len, offset);
+		trace_svcrdma_send_wseg(seg->rs_handle, write_len, offset);
 
 		list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 		cc->cc_sqecount += ret;
-		if (write_len == length - info->wi_seg_off) {
-			seg += 4;
+		if (write_len == seg->rs_length - info->wi_seg_off) {
 			info->wi_seg_no++;
 			info->wi_seg_off = 0;
 		} else {
@@ -489,7 +485,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 
 out_overflow:
 	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
-				     info->wi_nsegs);
+				     info->wi_chunk->ch_segcount);
 	return -E2BIG;
 }
 
@@ -577,7 +573,7 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr,
 /**
  * svc_rdma_send_write_chunk - Write all segments in a Write chunk
  * @rdma: controlling RDMA transport
- * @wr_ch: Write chunk provided by client
+ * @chunk: Write chunk provided by the client
  * @xdr: xdr_buf containing the data payload
  *
  * Returns a non-negative number of bytes the chunk consumed, or
@@ -587,13 +583,14 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr,
  *	%-ENOTCONN if posting failed (connection is lost),
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
-int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
+int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
+			      const struct svc_rdma_chunk *chunk,
 			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	int ret;
 
-	info = svc_rdma_write_info_alloc(rdma, wr_ch);
+	info = svc_rdma_write_info_alloc(rdma, chunk);
 	if (!info)
 		return -ENOMEM;
 
@@ -631,12 +628,14 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 			      struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
+	struct svc_rdma_chunk *chunk;
 	int consumed, ret;
 
-	if (!rctxt->rc_reply_chunk)
+	if (pcl_is_empty(&rctxt->rc_reply_pcl))
 		return 0;
 
-	info = svc_rdma_write_info_alloc(rdma, rctxt->rc_reply_chunk);
+	chunk = pcl_first_chunk(&rctxt->rc_reply_pcl);
+	info = svc_rdma_write_info_alloc(rdma, chunk);
 	if (!info)
 		return -ENOMEM;
 
@@ -648,7 +647,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!rctxt->rc_write_list && xdr->page_len) {
+	if (pcl_is_empty(&rctxt->rc_write_pcl) && xdr->page_len) {
 		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
 					   xdr->page_len);
 		if (ret < 0)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 3e7ba06788b0..f697e79757a6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -466,12 +466,14 @@ static ssize_t
 svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
 			   struct svc_rdma_send_ctxt *sctxt)
 {
+	struct svc_rdma_chunk *chunk;
 	ssize_t len, ret;
 
 	len = 0;
 	if (rctxt->rc_write_list) {
+		chunk = pcl_first_chunk(&rctxt->rc_write_pcl);
 		ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
-						  rctxt->rc_read_payload_length);
+						  chunk->ch_payload_length);
 		if (ret < 0)
 			return ret;
 		len = ret;
@@ -979,22 +981,24 @@ int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 			    unsigned int length)
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+	struct svc_rdma_chunk *chunk;
 	struct svcxprt_rdma *rdma;
 	struct xdr_buf subbuf;
 
-	if (!rctxt->rc_write_list || !length)
+	chunk = rctxt->rc_cur_result_payload;
+	if (!length || !chunk)
 		return 0;
+	rctxt->rc_cur_result_payload =
+		pcl_next_chunk(&rctxt->rc_write_pcl, chunk);
+	if (length > chunk->ch_length)
+		return -E2BIG;
 
-	/* XXX: Just one READ payload slot for now, since our
-	 * transport implementation currently supports only one
-	 * Write chunk.
-	 */
-	rctxt->rc_read_payload_offset = offset;
-	rctxt->rc_read_payload_length = length;
+	chunk->ch_position = offset;
+	chunk->ch_payload_length = length;
 
 	if (xdr_buf_subsegment(&rqstp->rq_res, &subbuf, offset, length))
 		return -EMSGSIZE;
 
 	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
-	return svc_rdma_send_write_chunk(rdma, rctxt->rc_write_list, &subbuf);
+	return svc_rdma_send_write_chunk(rdma, chunk, &subbuf);
 }


