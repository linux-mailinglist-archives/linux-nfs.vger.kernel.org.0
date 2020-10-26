Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA90299617
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782281AbgJZSzi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39451 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbgJZSzi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id i7so6810722qti.6;
        Mon, 26 Oct 2020 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YOLkHLFkULxlBpNrbT9Jrbppk5noxw7p9O3VpLnTLPg=;
        b=C6cAJ68fAv0+VGD9HBI6j+3t1t1Y8jhJ3FB5RPjPPM3ra+zQ9fiD+ArcIGuDtSlVCx
         ai3yOzbT7Vzu5mXYtPIEEHZj33/jYE3DYWjICx0fr1Y3LA0QMmd4RehA8NZJvWDsvsEW
         JsTC0WHpXWZzhgg/6RvsLlgLF6yfUhEkHHeVKE+RGrzB33eQH37yux8R2Azvno891SDv
         CkmbrwrpGucwQLTPQd2SbqRiCcqifXCC8bdSErTvIrv7hw4zmoB7zXHKY4H5rRAgxWta
         CgcIu3OOIwqD3cVtnK9Jn4+onUAnMAw3zaKas9J+Lg6zA/nYPHoZMFy0Zw/fyETexOCR
         C8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YOLkHLFkULxlBpNrbT9Jrbppk5noxw7p9O3VpLnTLPg=;
        b=mq73XQ0jaE4K3F6xY8kzifNGtiQMQUW5lWAw8G0KFMVj64Vn0/6kamdNtuhQEZxi42
         Cvz63NX+ru4LnKvf6i93TjgOltnq6mP+7Xz9oGiKyF174eFFMjMgL65m9KEOA14GOSEp
         v0tLCGm1jYe1utc8tqE8med+zWLThqmzNWDpFdjoSPM4Dni6F/FGJ0r7od4Va2Qj5iZy
         j4Kg7CXr83Uhq9oe5yX/1sRo2wl4nv/R0uGwkVVfHN3/r2soCYfhoKyUeTj24nJnw9wA
         3riyP7nuPpr8VfAsRyt8LlJCerap9ddnH2OIpHiA8v5WNjtVCwv3c+xEUeKKqvB8Uaoj
         +RPQ==
X-Gm-Message-State: AOAM533Xew0VIy2e0iWzc+KuResvb9LLaOMBVzNAfYQ5VYXn08Xsp6yv
        HlP95m4kIGdLSpxn9bQJLbRuCKYi/qk=
X-Google-Smtp-Source: ABdhPJw7MnXKiV2jjskT7BF2DUKItyxxMimYeDaPhMPeVOt1Rzt345ycUWtaDBYMJPTFe+EcI7lItg==
X-Received: by 2002:ac8:734c:: with SMTP id q12mr8645521qtp.384.1603738535249;
        Mon, 26 Oct 2020 11:55:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u26sm7129705qkj.17.2020.10.26.11.55.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:34 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItXCF013670;
        Mon, 26 Oct 2020 18:55:33 GMT
Subject: [PATCH 19/20] svcrdma: Use the new parsed chunk list when pulling
 Read chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:33 -0400
Message-ID: <160373853368.1886.15667445822588290097.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As a pre-requisite for handling multiple Read chunks in each Read
list, convert svc_rdma_recv_read_chunk() to use the new parsed Read
chunk list.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    6 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   16 +--
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |  160 ++++++++++++++++++++-----------
 3 files changed, 111 insertions(+), 71 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 6f247d043731..294b56e61522 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -188,15 +188,15 @@ extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
-extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
-				    struct svc_rqst *rqstp,
-				    struct svc_rdma_recv_ctxt *head, __be32 *p);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
 				     const struct xdr_buf *xdr);
+extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
+				      struct svc_rqst *rqstp,
+				      struct svc_rdma_recv_ctxt *head);
 
 /* svc_rdma_sendto.c */
 extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index dd10b1de227d..cbdb71247755 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -824,7 +824,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svcxprt_rdma *rdma_xprt =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *ctxt;
-	__be32 *p;
 	int ret;
 
 	rqstp->rq_xprt_ctxt = NULL;
@@ -857,7 +856,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_respages = rqstp->rq_pages;
 	rqstp->rq_next_page = rqstp->rq_respages;
 
-	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
 	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;
@@ -870,9 +868,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
 
-	p += rpcrdma_fixed_maxsz;
-	if (*p != xdr_zero)
-		goto out_readchunk;
+	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
+	    !pcl_is_empty(&ctxt->rc_call_pcl))
+		goto out_readlist;
 
 complete:
 	rqstp->rq_xprt_ctxt = ctxt;
@@ -880,10 +878,10 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_xprt_copy_addrs(rqstp, xprt);
 	return rqstp->rq_arg.len;
 
-out_readchunk:
-	ret = svc_rdma_recv_read_chunk(rdma_xprt, rqstp, ctxt, p);
+out_readlist:
+	ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
 	if (ret < 0)
-		goto out_postfail;
+		goto out_readfail;
 	return 0;
 
 out_err:
@@ -891,7 +889,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return 0;
 
-out_postfail:
+out_readfail:
 	if (ret == -EINVAL)
 		svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 104b1d5a2203..6ec7bdc7b4d3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -258,8 +258,8 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 /* State for pulling a Read chunk.
  */
 struct svc_rdma_read_info {
+	struct svc_rqst			*ri_rqst;
 	struct svc_rdma_recv_ctxt	*ri_readctxt;
-	unsigned int			ri_position;
 	unsigned int			ri_pageno;
 	unsigned int			ri_pageoff;
 	unsigned int			ri_totalbytes;
@@ -656,17 +656,29 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	return ret;
 }
 
+/**
+ * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
+ * @info: context for ongoing I/O
+ * @segment: co-ordinates of remote memory to be read
+ *
+ * Returns:
+ *   %0: the Read WR chain was constructed successfully
+ *   %-EINVAL: there were not enough rq_pages to finish
+ *   %-ENOMEM: allocating a local resources failed
+ *   %-EIO: a DMA mapping error occurred
+ */
 static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
-				       struct svc_rqst *rqstp,
-				       u32 rkey, u32 len, u64 offset)
+				       const struct svc_rdma_segment *segment)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct svc_rdma_chunk_ctxt *cc = &info->ri_cc;
+	struct svc_rqst *rqstp = info->ri_rqst;
 	struct svc_rdma_rw_ctxt *ctxt;
-	unsigned int sge_no, seg_len;
+	unsigned int sge_no, seg_len, len;
 	struct scatterlist *sg;
 	int ret;
 
+	len = segment->rs_length;
 	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
 	ctxt = svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
 	if (!ctxt)
@@ -700,8 +712,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 			goto out_overrun;
 	}
 
-	ret = svc_rdma_rw_ctx_init(cc->cc_rdma, ctxt, offset, rkey,
-				   DMA_FROM_DEVICE);
+	ret = svc_rdma_rw_ctx_init(cc->cc_rdma, ctxt, segment->rs_offset,
+				   segment->rs_handle, DMA_FROM_DEVICE);
 	if (ret < 0)
 		return -EIO;
 
@@ -714,48 +726,63 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return -EINVAL;
 }
 
-/* Walk the segments in the Read chunk starting at @p and construct
- * RDMA Read operations to pull the chunk to the server.
+/**
+ * svc_rdma_build_read_chunk - Build RDMA Read WQEs to pull one RDMA chunk
+ * @info: context for ongoing I/O
+ * @chunk: Read chunk to pull
+ *
+ * Return values:
+ *   %0: the Read WR chain was constructed successfully
+ *   %-EINVAL: there were not enough resources to finish
+ *   %-ENOMEM: allocating a local resources failed
+ *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
-				     struct svc_rdma_read_info *info,
-				     __be32 *p)
+static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
+				     const struct svc_rdma_chunk *chunk)
 {
+	const struct svc_rdma_segment *segment;
 	int ret;
 
 	ret = -EINVAL;
-	while (*p++ != xdr_zero && be32_to_cpup(p++) == info->ri_position) {
-		u32 handle, length;
-		u64 offset;
-
-		p = xdr_decode_rdma_segment(p, &handle, &length, &offset);
-		ret = svc_rdma_build_read_segment(info, rqstp, handle, length,
-						  offset);
+	pcl_for_each_segment(segment, chunk) {
+		ret = svc_rdma_build_read_segment(info, segment);
 		if (ret < 0)
 			break;
-
-		info->ri_totalbytes += length;
+		info->ri_totalbytes += segment->rs_length;
 	}
 	return ret;
 }
 
-/* Construct RDMA Reads to pull over a normal Read chunk. The chunk
- * data lands in the page list of head->rc_arg.pages.
+/**
+ * svc_rdma_read_data_items - Construct RDMA Reads to pull data item Read chunks
+ * @info: context for RDMA Reads
+ *
+ * The chunk data lands in the page list of head->rc_arg.pages.
  *
  * Currently NFSD does not look at the head->rc_arg.tail[0] iovec.
  * Therefore, XDR round-up of the Read chunk and trailing
  * inline content must both be added at the end of the pagelist.
+ *
+ * Return values:
+ *   %0: RDMA Read WQEs were successfully built
+ *   %-EINVAL: client provided too many chunks or segments,
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
-					    struct svc_rdma_read_info *info,
-					    __be32 *p)
+static int svc_rdma_read_data_items(struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &head->rc_arg;
+	struct svc_rdma_chunk *chunk;
 	unsigned int length;
 	int ret;
 
-	ret = svc_rdma_build_read_chunk(rqstp, info, p);
+	if (head->rc_read_pcl.cl_count > 1)
+		return -EINVAL;
+
+	chunk = pcl_first_chunk(&head->rc_read_pcl);
+	ret = svc_rdma_build_read_chunk(info, chunk);
 	if (ret < 0)
 		goto out;
 
@@ -766,11 +793,9 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 	 * chunk is not included in either the pagelist or in
 	 * the tail.
 	 */
-	head->rc_arg.tail[0].iov_base =
-		head->rc_arg.head[0].iov_base + info->ri_position;
-	head->rc_arg.tail[0].iov_len =
-		head->rc_arg.head[0].iov_len - info->ri_position;
-	head->rc_arg.head[0].iov_len = info->ri_position;
+	buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
+	buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
+	buf->head[0].iov_len = chunk->ch_position;
 
 	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
 	 *
@@ -790,26 +815,36 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 	return ret;
 }
 
-/* Construct RDMA Reads to pull over a Position Zero Read chunk.
- * The start of the data lands in the first page just after
- * the Transport header, and the rest lands in the page list of
+/**
+ * svc_rdma_read_special - Build RDMA Read WQEs to pull a Long Message
+ * @info: context for RDMA Reads
+ *
+ * The start of the data lands in the first page just after the
+ * Transport header, and the rest lands in the page list of
  * head->rc_arg.pages.
  *
  * Assumptions:
- *	- A PZRC has an XDR-aligned length (no implicit round-up).
- *	- There can be no trailing inline content (IOW, we assume
- *	  a PZRC is never sent in an RDMA_MSG message, though it's
- *	  allowed by spec).
+ *	- A PZRC is never sent in an RDMA_MSG message, though it's
+ *	  allowed by spec.
+ *
+ * Return values:
+ *   %0: RDMA Read WQEs were successfully built
+ *   %-EINVAL: client provided too many chunks or segments,
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_build_pz_read_chunk(struct svc_rqst *rqstp,
-					struct svc_rdma_read_info *info,
-					__be32 *p)
+static int svc_rdma_read_special(struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &head->rc_arg;
 	int ret;
 
-	ret = svc_rdma_build_read_chunk(rqstp, info, p);
+	if (head->rc_call_pcl.cl_count > 1)
+		return -EINVAL;
+
+	ret = svc_rdma_build_read_chunk(info,
+					pcl_first_chunk(&head->rc_call_pcl));
 	if (ret < 0)
 		goto out;
 
@@ -846,24 +881,31 @@ static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
 }
 
 /**
- * svc_rdma_recv_read_chunk - Pull a Read chunk from the client
+ * svc_rdma_process_read_list - Pull list of Read chunks from the client
  * @rdma: controlling RDMA transport
  * @rqstp: set of pages to use as Read sink buffers
  * @head: pages under I/O collect here
- * @p: pointer to start of Read chunk
  *
- * Returns:
- *	%0 if all needed RDMA Reads were posted successfully,
- *	%-EINVAL if client provided too many segments,
- *	%-ENOMEM if rdma_rw context pool was exhausted,
- *	%-ENOTCONN if posting failed (connection is lost),
- *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
+ * The RPC/RDMA protocol assumes that the upper layer's XDR decoders
+ * pull each Read chunk as they decode an incoming RPC message.
  *
- * Assumptions:
- * - All Read segments in @p have the same Position value.
+ * On Linux, however, the server needs to have a fully-constructed RPC
+ * message in rqstp->rq_arg when there is a positive return code from
+ * ->xpo_recvfrom. So the Read list is safety-checked immediately when
+ * it is received, then here the whole Read list is pulled all at once.
+ * The ingress RPC message is fully reconstructed once all associated
+ * RDMA Reads have completed.
+ *
+ * Return values:
+ *   %1: all needed RDMA Reads were posted successfully,
+ *   %-EINVAL: client provided too many chunks or segments,
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
-			     struct svc_rdma_recv_ctxt *head, __be32 *p)
+int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
+			       struct svc_rqst *rqstp,
+			       struct svc_rdma_recv_ctxt *head)
 {
 	struct svc_rdma_read_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
@@ -885,16 +927,16 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	if (!info)
 		return -ENOMEM;
 	cc = &info->ri_cc;
+	info->ri_rqst = rqstp;
 	info->ri_readctxt = head;
 	info->ri_pageno = 0;
 	info->ri_pageoff = 0;
 	info->ri_totalbytes = 0;
 
-	info->ri_position = be32_to_cpup(p + 1);
-	if (info->ri_position)
-		ret = svc_rdma_build_normal_read_chunk(rqstp, info, p);
+	if (pcl_is_empty(&head->rc_call_pcl))
+		ret = svc_rdma_read_data_items(info);
 	else
-		ret = svc_rdma_build_pz_read_chunk(rqstp, info, p);
+		ret = svc_rdma_read_special(info);
 	if (ret < 0)
 		goto out_err;
 
@@ -903,7 +945,7 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out_err;
 	svc_rdma_save_io_pages(rqstp, 0, head->rc_page_count);
-	return 0;
+	return 1;
 
 out_err:
 	svc_rdma_read_info_free(info);


