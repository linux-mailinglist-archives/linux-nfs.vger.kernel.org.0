Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC918BAE7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCSPVF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36562 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgCSPVF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:21:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so2115165qtb.3;
        Thu, 19 Mar 2020 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W9QWgCM9scAQEaigd59+7hUo52ALMqQBWZHV5srqb3k=;
        b=eoTb5E0seQ3eah8dggxawhozbIdszjT66gVpKwMY6zbcovZvDqwdtidoiFpsa35LUx
         /nw5zTuBoydg6246v+wd9HUbRI3yzAwU+3qIqhXhZ64vEt6G7xkOkmE7fUtpOTwg7tFc
         PVlKoUg51+XN0lacfDdjMSkhtmHn3xu6q7qZwSNi5jSE8XxPTB8PcWK8fZSaR+YPGfGv
         BsWOv+vV6/iXSa5vmj14jk5CvKVfuX6JWa6yV1b6xOwJhzNnOQgXhnrYbmZW/ut8A5OM
         ILm6aTUexnDpL20aBpUNUa36kh+yOPLEcKeUPNYxYzeE6cJ0tG3WDm6ejCYVrq2QQFWY
         IsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=W9QWgCM9scAQEaigd59+7hUo52ALMqQBWZHV5srqb3k=;
        b=dxmdtXBJUbJYto0HK8bxqZ9J1NY/zNOpqRRw2rYy95jyO7Jo5dx6Bt1fiBVVl1mSBY
         Mt5ZQNvHryfhYDVKKgciU7a7Y1kySra1wlVNPy7b9KK3nxiBTHfa5b3YZ61Tw0rGWBh+
         +3v4TrgjfaaKLbkv7shMw8IvsOn4MfuKNhAZxn5Rha62p9rV/yZ3ak/KDHbBicL2R5QQ
         +JIDTXtpC0WVeltPUB08/8QrG6s+q7L2762IT/Xfucks4HFY6jgdJBIzp1YLoiK7UVMJ
         h5XrFK15H6mQQoVJl96Bs19SLV42ge2/DuKqnfGpCa6Fo3K5xX2Ix1uXycTrCzvjnc/O
         pTOA==
X-Gm-Message-State: ANhLgQ12Cn+7PGl7mUn3Iyt7QLS4qegQYlQ3agBNvfohmLLM+6lsBstl
        BaonnCEqausJuvzwqIWnIUxWJOYIXQo=
X-Google-Smtp-Source: ADFU+vu5T+YGFnVdse+uvroAiLF0fN2UCEA8uhPhTmtv593N0OAGullZYl8nCqebUQy/1SMdJKvwAA==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr3439654qth.231.1584631262002;
        Thu, 19 Mar 2020 08:21:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k13sm1720470qtm.11.2020.03.19.08.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFL0sU011166;
        Thu, 19 Mar 2020 15:21:00 GMT
Subject: [PATCH RFC 07/11] svcrdma: Add a data structure to track READ
 payloads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:21:00 -0400
Message-ID: <20200319152100.16298.44517.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
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
 include/linux/sunrpc/svc_rdma.h         |    3 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   30 +++++++++++++++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   38 +++++++++++++++++--------------
 4 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 9af9d4dff330..37e4c597dc71 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -145,9 +145,10 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
-	struct svc_rdma_payload rc_read_payload;
+	struct svc_rdma_payload	*rc_read_payloads;
 	__be32			*rc_reply_chunk;
 	unsigned int		rc_num_write_chunks;
+	unsigned int		rc_cur_payload;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 95b88f68f8ca..2c3ab554c6ec 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -193,8 +193,9 @@ svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
-	ctxt->rc_read_payload.rp_length = 0;
 	ctxt->rc_num_write_chunks = 0;
+	ctxt->rc_cur_payload = 0;
+	ctxt->rc_read_payloads = NULL;
 	return ctxt;
 
 out_empty:
@@ -217,7 +218,8 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		put_page(ctxt->rc_pages[i]);
-
+	kfree(ctxt->rc_read_payloads);
+	ctxt->rc_read_payloads = NULL;
 	if (!ctxt->rc_temp)
 		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 	else
@@ -474,13 +476,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt, u32 maxlen)
  */
 static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 {
-	u32 chcount = 0;
-	__be32 *p;
+	u32 i, segcount, chcount = 0;
+	__be32 *p, *saved;
 
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	rctxt->rc_read_payload.rp_chunk = p;
+	saved = p;
 	while (*p != xdr_zero) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
 			return false;
@@ -491,8 +493,22 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 	}
 	rctxt->rc_num_write_chunks = chcount;
 	if (!chcount)
-		rctxt->rc_read_payload.rp_chunk = NULL;
-	return chcount < 2;
+		return true;
+
+	rctxt->rc_read_payloads = kcalloc(chcount,
+					  sizeof(struct svc_rdma_payload),
+					  GFP_KERNEL);
+	if (!rctxt->rc_read_payloads)
+		return false;
+
+	i = 0;
+	p = saved;
+	while (*p != xdr_zero) {
+		rctxt->rc_read_payloads[i++].rp_chunk = p++;
+		segcount = be32_to_cpup(p++);
+		p += segcount * rpcrdma_segment_maxsz;
+	}
+	return true;
 }
 
 /* Sanity check the Reply chunk.
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 8ad137c7e6a0..5f326c18b47c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -625,7 +625,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!rctxt->rc_num_write_chunks && xdr->page_len) {
+	if (!rctxt->rc_cur_payload && xdr->page_len) {
 		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
 					   xdr->page_len);
 		if (ret < 0)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index b6dd5ae2ad76..9fe7b0d1e335 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -447,10 +447,11 @@ static ssize_t svc_rdma_encode_write_chunk(struct svc_rdma_send_ctxt *sctxt,
  * @rctxt: Reply context with information about the RPC Call
  * @sctxt: Send context for the RPC Reply
  *
- * The client provides a Write chunk list in the Call message. Fill
- * in the segments in the first Write chunk in the Reply's transport
- * header with the number of bytes consumed in each segment.
- * Remaining chunks are returned unused.
+ * The client provided a Write list in the Call message. For each
+ * READ payload, fill in the segments in the Write chunks in the
+ * Reply's transport header with the number of bytes consumed
+ * in each segment. Any remaining Write chunks are returned to
+ * the client unused.
  *
  * Assumptions:
  *  - Client has provided only one Write chunk
@@ -465,11 +466,12 @@ svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
 			   struct svc_rdma_send_ctxt *sctxt)
 {
 	ssize_t len, ret;
+	unsigned int i;
 
 	len = 0;
-	if (rctxt->rc_num_write_chunks) {
+	for (i = 0; i < rctxt->rc_num_write_chunks; i++) {
 		ret = svc_rdma_encode_write_chunk(sctxt,
-						  &rctxt->rc_read_payload);
+						  &rctxt->rc_read_payloads[i]);
 		if (ret < 0)
 			return ret;
 		len += ret;
@@ -564,7 +566,7 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_recv_ctxt *rctxt,
 				    struct xdr_buf *xdr)
 {
-	bool read_payload_present = rctxt && rctxt->rc_num_write_chunks;
+	bool read_payload_present = rctxt && rctxt->rc_cur_payload;
 	int elements;
 
 	/* For small messages, copying bytes is cheaper than DMA mapping.
@@ -628,7 +630,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 
 	tailbase = xdr->tail[0].iov_base;
 	taillen = xdr->tail[0].iov_len;
-	if (rctxt && rctxt->rc_num_write_chunks) {
+	if (rctxt && rctxt->rc_cur_payload) {
 		u32 xdrpad;
 
 		xdrpad = xdr_pad_size(xdr->page_len);
@@ -708,12 +710,12 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
-	/* If a Write chunk is present, the xdr_buf's page list
+	/* If Write chunks are present, the xdr_buf's page list
 	 * is not included inline. However the Upper Layer may
 	 * have added XDR padding in the tail buffer, and that
 	 * should not be included inline.
 	 */
-	if (rctxt && rctxt->rc_num_write_chunks) {
+	if (rctxt && rctxt->rc_cur_payload) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
 		xdr_pad = xdr_pad_size(xdr->page_len);
@@ -951,21 +953,23 @@ int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	struct xdr_buf uninitialized_var(subbuf);
 	struct svcxprt_rdma *rdma;
+	unsigned int i;
 
 	if (!rctxt->rc_num_write_chunks || !length)
 		return 0;
 
-	/* XXX: Just one READ payload slot for now, since our
-	 * transport implementation currently supports only one
-	 * Write chunk.
-	 */
-	rctxt->rc_read_payload.rp_offset = offset;
-	rctxt->rc_read_payload.rp_length = length;
+	if (rctxt->rc_cur_payload > rctxt->rc_num_write_chunks)
+		return -ENOENT;
+	i = rctxt->rc_cur_payload++;
+
+	rctxt->rc_read_payloads[i].rp_offset = offset;
+	rctxt->rc_read_payloads[i].rp_length = length;
 
 	if (xdr_buf_subsegment(&rqstp->rq_res, &subbuf, offset, length))
 		return -EMSGSIZE;
 
 	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
-	return svc_rdma_send_write_chunk(rdma, rctxt->rc_read_payload.rp_chunk,
+	return svc_rdma_send_write_chunk(rdma,
+					 rctxt->rc_read_payloads[i].rp_chunk,
 					 &subbuf);
 }

