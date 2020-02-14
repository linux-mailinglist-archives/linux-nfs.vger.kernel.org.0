Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151A115F2B9
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgBNPud (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:50:33 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35378 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgBNPuc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:32 -0500
Received: by mail-yb1-f194.google.com with SMTP id p123so4963564ybp.2;
        Fri, 14 Feb 2020 07:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WNbd7mCfipl3ljyddNfjpm+YXZXCBhqAO3q8XYrPYfQ=;
        b=HVGNXM6pBokG7molyA8RlALBgVj4hmhu4fG6UdhfB+JMMAsgeUfZ/6r+nCiaDKfhzx
         33w9kTOiaPBMqR5RD0mTtl2X/+g1eHDsCzJwn+ayfCHN5A7qIw+VsYxMYKIJTIvTj1DO
         iDV6bo6o3nEtv6w+EHMJZfjtCf1rjmrX06wmw22m/VZp6zTQSobNWKDmPKaitt6d1oDZ
         nFpbv9KOJ+849WSKH1rWY5NEgK/Omu3HPyfNyJfWhMrRW2AoWSO9XtCMvmyO4li6tEEe
         jY7JPpX45xHBL8lp5ylmvQmJvb89mKUuJan3RztwuDsmI5mKeMLrt7y/Maqk0PxEsVuN
         syOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WNbd7mCfipl3ljyddNfjpm+YXZXCBhqAO3q8XYrPYfQ=;
        b=AYOHZbp0MWL3ReXtJgAO6oeMq/Z3eIHkFd34CqQZGnNyiXmrGNmAhIW5T8zZtw24Px
         bxWHs4fRVykB4oI6VKibc2jgVtZs8cUc3w9uxysdDQjtjMsOiV8bGzQflaKdyCgmGwDk
         EyBDINR9KmZkEnTj7LIYqDbaDYufgIsFvE6LooEeL7R0iqyQlrRrrOwpT74ej0UbCKoO
         NSTJUeV5El7tGXLvjQM75V9xKfnSICAqnb2MSVK2WUMXZ4dXEjBsfZdcT+fiLJDEa96n
         /jartpotHMO/3UVwDg+hCLek5R7I7j/Lvu8ejBOU5CrooSCDFtvKxj2Gfa4VkxzpLdCd
         1rww==
X-Gm-Message-State: APjAAAVshDuxGSQpvVt6nw5SkWH0F4twnwmPhk97o/2EwCPvWUI3E+fF
        GCqwk9DSlMnEmCJuZCI37HbQlTI5
X-Google-Smtp-Source: APXvYqxPW6r1UI/UdBv1hvs51Q2t3Zjk9GUIWwGKI/mEhnw6WgkRapKRAKL+xh/9HVBbQtRT75MdLA==
X-Received: by 2002:a25:e04a:: with SMTP id x71mr3148750ybg.211.1581695431327;
        Fri, 14 Feb 2020 07:50:31 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l37sm2711450ywa.103.2020.02.14.07.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:30 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFoTB6029184;
        Fri, 14 Feb 2020 15:50:29 GMT
Subject: [PATCH RFC 9/9] svcrdma: Add data structure to track READ payloads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:29 -0500
Message-ID: <20200214155029.3848.86626.stgit@klimt.1015granger.net>
In-Reply-To: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
References: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Linux NFS/RDMA server implementation currently supports only a
single Write chunk per RPC/RDMA request. Requests with more than one
are so rare there has never been a strong need to support more.
However we are aware of at least one existing NFS client
implementation that can generate such requests, so let's dig in.

Allocate a data structure at Receive time to keep track of the set
of READ payloads and the Write chunks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |   15 +++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 -
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |   31 +++++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |    2 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   94 +++++++++++++---------------
 5 files changed, 80 insertions(+), 64 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c1c4563066d9..85e6b281a39b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -124,6 +124,12 @@ enum {
 
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
+struct svc_rdma_payload {
+	__be32			*ra_chunk;
+	unsigned int		ra_offset;
+	unsigned int		ra_length;
+};
+
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
 	struct list_head	rc_list;
@@ -137,10 +143,10 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
-	__be32			*rc_write_list;
+	struct svc_rdma_payload	*rc_read_payloads;
 	__be32			*rc_reply_chunk;
-	unsigned int		rc_read_payload_offset;
-	unsigned int		rc_read_payload_length;
+	unsigned int		rc_num_write_chunks;
+	unsigned int		rc_cur_payload;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
@@ -193,7 +199,8 @@ extern void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
 				    unsigned int len);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *ctxt,
-				  struct xdr_buf *xdr, __be32 *wr_lst);
+				  struct xdr_buf *xdr,
+				  unsigned int num_read_payloads);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 				 unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 908e78bb87c6..3b1baf15a1b7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -117,7 +117,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	ret = svc_rdma_map_reply_msg(rdma, ctxt, &rqst->rq_snd_buf, NULL);
+	ret = svc_rdma_map_reply_msg(rdma, ctxt, &rqst->rq_snd_buf, 0);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 91abe08f7d75..85b8dd8ae772 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -193,7 +193,9 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
-	ctxt->rc_read_payload_length = 0;
+	ctxt->rc_num_write_chunks = 0;
+	ctxt->rc_cur_payload = 0;
+	ctxt->rc_read_payloads = NULL;
 	return ctxt;
 
 out_empty:
@@ -216,7 +218,8 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		put_page(ctxt->rc_pages[i]);
-
+	kfree(ctxt->rc_read_payloads);
+	ctxt->rc_read_payloads = NULL;
 	if (!ctxt->rc_temp)
 		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 	else
@@ -452,9 +455,10 @@ static __be32 *xdr_check_write_chunk(__be32 *p, const __be32 *end,
 static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end,
 				    struct svc_rdma_recv_ctxt *ctxt)
 {
-	u32 chcount;
+	u32 chcount, segcount;
+	__be32 *saved = p;
+	int i;
 
-	ctxt->rc_write_list = p;
 	chcount = 0;
 	while (*p++ != xdr_zero) {
 		p = xdr_check_write_chunk(p, end, MAX_BYTES_WRITE_SEG);
@@ -463,8 +467,22 @@ static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end,
 		if (chcount++ > 1)
 			return NULL;
 	}
+	ctxt->rc_num_write_chunks = chcount;
 	if (!chcount)
-		ctxt->rc_write_list = NULL;
+		return p;
+
+	ctxt->rc_read_payloads = kcalloc(sizeof(struct svc_rdma_payload),
+					 chcount, GFP_KERNEL);
+	if (!ctxt->rc_read_payloads)
+		return NULL;
+
+	i = 0;
+	p = saved;
+	while (*p++ != xdr_zero) {
+		ctxt->rc_read_payloads[i++].ra_chunk = p - 1;
+		segcount = be32_to_cpup(p++);
+		p += segcount * rpcrdma_segment_maxsz;
+	}
 	return p;
 }
 
@@ -484,8 +502,9 @@ static __be32 *xdr_check_reply_chunk(__be32 *p, const __be32 *end,
 		p = xdr_check_write_chunk(p, end, MAX_BYTES_SPECIAL_SEG);
 		if (!p)
 			return NULL;
-	} else
+	} else {
 		ctxt->rc_reply_chunk = NULL;
+	}
 	return p;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index ca9d414bef9d..740ea4ee251d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -574,7 +574,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!rctxt->rc_write_list && xdr->page_len) {
+	if (!rctxt->rc_num_write_chunks && xdr->page_len) {
 		ret = svc_rdma_send_xdr_pagelist(info, xdr,
 						 xdr->head[0].iov_len,
 						 xdr->page_len);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7349a3f9aa5d..378a24b666bb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -366,10 +366,10 @@ static __be32 *xdr_encode_read_list(__be32 *p)
  * transport header. Each segment's length field is updated to
  * reflect number of bytes consumed in the segment.
  *
- * Returns number of segments in this chunk.
+ * Returns a pointer to the position to encode the next chunk.
  */
-static unsigned int xdr_encode_write_chunk(__be32 *dst, __be32 *src,
-					   unsigned int remaining)
+static __be32 *xdr_encode_write_chunk(__be32 *dst, __be32 *src,
+				      unsigned int length)
 {
 	unsigned int i, nsegs;
 	u32 seg_len;
@@ -386,15 +386,15 @@ static unsigned int xdr_encode_write_chunk(__be32 *dst, __be32 *src,
 		*dst++ = *src++;
 
 		/* bytes returned in this segment */
-		seg_len = be32_to_cpu(*src);
-		if (remaining >= seg_len) {
+		seg_len = be32_to_cpup(src);
+		if (length >= seg_len) {
 			/* entire segment was consumed */
 			*dst = *src;
-			remaining -= seg_len;
+			length -= seg_len;
 		} else {
 			/* segment only partly filled */
-			*dst = cpu_to_be32(remaining);
-			remaining = 0;
+			*dst = cpu_to_be32(length);
+			length = 0;
 		}
 		dst++; src++;
 
@@ -403,38 +403,25 @@ static unsigned int xdr_encode_write_chunk(__be32 *dst, __be32 *src,
 		*dst++ = *src++;
 	}
 
-	return nsegs;
+	return dst;
 }
 
-/* The client provided a Write list in the Call message. Fill in
- * the segments in the first Write chunk in the Reply's transport
- * header with the number of bytes consumed in each segment.
- * Remaining chunks are returned unused.
- *
- * Assumptions:
- *  - Client has provided only one Write chunk
+/* The client provided a Write list in the Call message. For each
+ * READ payload, fill in the segments in the Write chunks in the
+ * Reply's transport header with the number of bytes consumed
+ * in each segment. Any remaining Write chunks are returned to
+ * the client unused.
  */
 static __be32 *xdr_encode_write_list(__be32 *p,
 				     const struct svc_rdma_recv_ctxt *rctxt)
 {
-	unsigned int consumed, nsegs;
-	__be32 *q;
-
-	q = rctxt->rc_write_list;
-	if (!q)
-		goto out;
-
-	consumed = rctxt->rc_read_payload_length;
-	while (*q != xdr_zero) {
-		nsegs = xdr_encode_write_chunk(p, q, consumed);
-		q += 2 + nsegs * rpcrdma_segment_maxsz;
-		p += 2 + nsegs * rpcrdma_segment_maxsz;
-		consumed = 0;
-	}
+	unsigned int i;
 
-	/* Terminate Write list */
-out:
-	*p++ = xdr_zero;
+	for (i = 0; i < rctxt->rc_num_write_chunks; i++)
+		p = xdr_encode_write_chunk(p,
+					rctxt->rc_read_payloads[i].ra_chunk,
+					rctxt->rc_read_payloads[i].ra_length);
+	*p++ = xdr_zero;	/* Terminate Write list */
 	return p;
 }
 
@@ -519,7 +506,7 @@ void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
 static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_send_ctxt *ctxt,
 				    struct xdr_buf *xdr,
-				    __be32 *wr_lst)
+				    unsigned int num_write_chunks)
 {
 	int elements;
 
@@ -535,7 +522,7 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 	elements = 1;
 
 	/* xdr->pages */
-	if (!wr_lst) {
+	if (!num_write_chunks) {
 		unsigned int remaining;
 		unsigned long pageoff;
 
@@ -563,7 +550,8 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
  */
 static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 				      struct svc_rdma_send_ctxt *ctxt,
-				      struct xdr_buf *xdr, __be32 *wr_lst)
+				      struct xdr_buf *xdr,
+				      unsigned int num_write_chunks)
 {
 	unsigned char *dst, *tailbase;
 	unsigned int taillen;
@@ -576,7 +564,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 
 	tailbase = xdr->tail[0].iov_base;
 	taillen = xdr->tail[0].iov_len;
-	if (wr_lst) {
+	if (num_write_chunks) {
 		u32 xdrpad;
 
 		xdrpad = xdr_padsize(xdr->page_len);
@@ -619,7 +607,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
  * @rdma: controlling transport
  * @ctxt: send_ctxt for the Send WR
  * @xdr: prepared xdr_buf containing RPC message
- * @wr_lst: pointer to Call header's Write list, or NULL
+ * @num_read_payloads: count of separate READ payloads to send
  *
  * Load the xdr_buf into the ctxt's sge array, and DMA map each
  * element as it is added.
@@ -628,7 +616,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
  */
 int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   struct svc_rdma_send_ctxt *ctxt,
-			   struct xdr_buf *xdr, __be32 *wr_lst)
+			   struct xdr_buf *xdr, unsigned int num_read_payloads)
 {
 	unsigned int len, remaining;
 	unsigned long page_off;
@@ -637,8 +625,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	u32 xdr_pad;
 	int ret;
 
-	if (svc_rdma_pull_up_needed(rdma, ctxt, xdr, wr_lst))
-		return svc_rdma_pull_up_reply_msg(rdma, ctxt, xdr, wr_lst);
+	if (svc_rdma_pull_up_needed(rdma, ctxt, xdr, num_read_payloads))
+		return svc_rdma_pull_up_reply_msg(rdma, ctxt, xdr, num_read_payloads);
 
 	++ctxt->sc_cur_sge_no;
 	ret = svc_rdma_dma_map_buf(rdma, ctxt,
@@ -647,12 +635,12 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
-	/* If a Write chunk is present, the xdr_buf's page list
+	/* If Write chunks are present, the xdr_buf's page list
 	 * is not included inline. However the Upper Layer may
 	 * have added XDR padding in the tail buffer, and that
 	 * should not be included inline.
 	 */
-	if (wr_lst) {
+	if (num_read_payloads) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
 		xdr_pad = xdr_padsize(xdr->page_len);
@@ -741,7 +729,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	if (!rctxt->rc_reply_chunk) {
 		ret = svc_rdma_map_reply_msg(rdma, sctxt,
 					     &rqstp->rq_res,
-					     rctxt->rc_write_list);
+					     rctxt->rc_cur_payload);
 		if (ret < 0)
 			return ret;
 	}
@@ -885,18 +873,20 @@ int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	struct svcxprt_rdma *rdma;
+	unsigned int i;
 
-	if (!rctxt->rc_write_list)
+	if (!rctxt->rc_num_write_chunks)
 		return 0;
 
-	/* XXX: Just one READ payload slot for now, since our
-	 * transport implementation currently supports only one
-	 * Write chunk.
-	 */
-	rctxt->rc_read_payload_offset = offset;
-	rctxt->rc_read_payload_length = length;
+	if (rctxt->rc_cur_payload > rctxt->rc_num_write_chunks)
+		return -ENOENT;
+	i = rctxt->rc_cur_payload++;
+
+	rctxt->rc_read_payloads[i].ra_offset = offset;
+	rctxt->rc_read_payloads[i].ra_length = length;
 
 	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
-	return svc_rdma_send_write_chunk(rdma, rctxt->rc_write_list,
+	return svc_rdma_send_write_chunk(rdma,
+					 rctxt->rc_read_payloads[i].ra_chunk,
 					 &rqstp->rq_res, offset, length);
 }

