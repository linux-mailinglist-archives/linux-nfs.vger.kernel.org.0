Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3755729960A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782250AbgJZSzL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42940 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781712AbgJZSzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id h12so2461137qtc.9;
        Mon, 26 Oct 2020 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d+l+CZoRjizN0kcs9YlZbmHpHnFcD+aEO5hzRa2NF5k=;
        b=NNdNmzL758T/bcUOfKSiggNKjF9VkYkI5w7jNCOhZXWG8oryLYCBQbfmYawR0g65+H
         2pMlfJDS3DTFNhPa5uQYKFfun9jmslAYVgQh9sN/Zw176JbKXKz3sXCmqILVcUEsXgnM
         f9xQ82k0BDEBqP63C5Y/ehV392/RvV8yZTyC0a2zMTr0UUgIMaZqQ1bqjRNlUVn3gpz5
         ZxOCawoCvMMtvNJq7V15f6XeofHtYXrig+gurjcJEfhitvJp3bdlL9nlIaLa5mJlrzJ4
         fjjawSFOY2jgDxyms29pZBI4TJqaMou8iMO0wYCc4AsAkNbw0K+Woa0Plg7cDK/2UkuO
         /mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d+l+CZoRjizN0kcs9YlZbmHpHnFcD+aEO5hzRa2NF5k=;
        b=mrPX656vaRLNltba/dbO46UtXdkLjuh3HnVg4r+V+pnHSkgn2ZqkqjnA4PKOxRwBb9
         K28zJB4tWuJOg9T+3Wxc9605qrqYSVKVdRtE6otlq5L39xPvZZw6aWJQsfHxm6ayOiYw
         bP2IbUFKHSK4B4qkl6W4hO4bFd3LlvIaULWqkm5umYys9v5Xu7fHJl5gNX960J+RU8vd
         QpK/ZTQFBCYfW3nfWfIv6T1w9SqsPnNTxY4W2qkAt2VfTRva8hj9OvDZQcDOelJKvHT1
         0lQs7evNNkLILRMiHjtJ2e0wDGpC44EucW00HtibPSNC764Kzwr+5J5t7eMQYE2o2i1U
         Tcgw==
X-Gm-Message-State: AOAM530wutR19yKaiEESF3aKsgWWc7qOfn1MJROGukrRLahF0LhaDjXk
        8D3kzH4gMjpIGQHylwXFWxqq7WKayzk=
X-Google-Smtp-Source: ABdhPJwmBcRQUD4547itHdhlOYL0OQRcWBhrikvXNC06f9OumN9/efIrQ9j5g6QzcbrosvNEIEBXew==
X-Received: by 2002:ac8:6f6f:: with SMTP id u15mr18983244qtv.115.1603738508885;
        Mon, 26 Oct 2020 11:55:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c12sm7348333qtp.14.2020.10.26.11.55.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:08 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIt7t4013655;
        Mon, 26 Oct 2020 18:55:07 GMT
Subject: [PATCH 14/20] svcrdma: Support multiple Write chunks in
 svc_rdma_map_reply_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:07 -0400
Message-ID: <160373850716.1886.4046562444210479073.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: svc_rdma_map_reply_msg() is restructured to DMA map only
the parts of rq_res that do not contain a result payload.

This change has been tested to confirm that it does not cause a
regression in the no Write chunk and single Write chunk cases.
Multiple Write chunks have not been tested.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 
 include/trace/events/rpcrdma.h        |    1 
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  174 +++++++++++++++++++--------------
 3 files changed, 100 insertions(+), 77 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 7090af1a9791..e09fafba00d7 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -213,7 +213,7 @@ extern int svc_rdma_send(struct svcxprt_rdma *rdma,
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_recv_ctxt *rctxt,
-				  struct xdr_buf *xdr);
+				  const struct xdr_buf *xdr);
 extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_send_ctxt *sctxt,
 				    struct svc_rdma_recv_ctxt *rctxt,
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index afc58accb9cf..054dedd0280c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1687,6 +1687,7 @@ DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 				TP_ARGS(rdma, dma_addr, length))
 
 DEFINE_SVC_DMA_EVENT(dma_map_page);
+DEFINE_SVC_DMA_EVENT(dma_map_err);
 DEFINE_SVC_DMA_EVENT(dma_unmap_page);
 
 TRACE_EVENT(svcrdma_dma_map_rw_err,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index b21beaa0114e..7d35bd6224ea 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -496,39 +496,111 @@ svc_rdma_encode_reply_chunk(struct svc_rdma_recv_ctxt *rctxt,
 	return svc_rdma_encode_write_chunk(sctxt, chunk);
 }
 
-static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
-				 struct svc_rdma_send_ctxt *ctxt,
-				 struct page *page,
-				 unsigned long offset,
-				 unsigned int len)
+struct svc_rdma_map_data {
+	struct svcxprt_rdma		*md_rdma;
+	struct svc_rdma_send_ctxt	*md_ctxt;
+};
+
+/**
+ * svc_rdma_page_dma_map - DMA map one page
+ * @data: pointer to arguments
+ * @page: struct page to DMA map
+ * @offset: offset into the page
+ * @len: number of bytes to map
+ *
+ * Returns:
+ *   %0 if DMA mapping was successful
+ *   %-EIO if the page cannot be DMA mapped
+ */
+static int svc_rdma_page_dma_map(void *data, struct page *page,
+				 unsigned long offset, unsigned int len)
 {
+	struct svc_rdma_map_data *args = data;
+	struct svcxprt_rdma *rdma = args->md_rdma;
+	struct svc_rdma_send_ctxt *ctxt = args->md_ctxt;
 	struct ib_device *dev = rdma->sc_cm_id->device;
 	dma_addr_t dma_addr;
 
+	++ctxt->sc_cur_sge_no;
+
 	dma_addr = ib_dma_map_page(dev, page, offset, len, DMA_TO_DEVICE);
-	trace_svcrdma_dma_map_page(rdma, dma_addr, len);
 	if (ib_dma_mapping_error(dev, dma_addr))
 		goto out_maperr;
 
+	trace_svcrdma_dma_map_page(rdma, dma_addr, len);
 	ctxt->sc_sges[ctxt->sc_cur_sge_no].addr = dma_addr;
 	ctxt->sc_sges[ctxt->sc_cur_sge_no].length = len;
 	ctxt->sc_send_wr.num_sge++;
 	return 0;
 
 out_maperr:
+	trace_svcrdma_dma_map_err(rdma, dma_addr, len);
 	return -EIO;
 }
 
-/* ib_dma_map_page() is used here because svc_rdma_dma_unmap()
+/**
+ * svc_rdma_iov_dma_map - DMA map an iovec
+ * @data: pointer to arguments
+ * @iov: kvec to DMA map
+ *
+ * ib_dma_map_page() is used here because svc_rdma_dma_unmap()
  * handles DMA-unmap and it uses ib_dma_unmap_page() exclusively.
+ *
+ * Returns:
+ *   %0 if DMA mapping was successful
+ *   %-EIO if the iovec cannot be DMA mapped
  */
-static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
-				struct svc_rdma_send_ctxt *ctxt,
-				unsigned char *base,
-				unsigned int len)
+static int svc_rdma_iov_dma_map(void *data, const struct kvec *iov)
 {
-	return svc_rdma_dma_map_page(rdma, ctxt, virt_to_page(base),
-				     offset_in_page(base), len);
+	if (!iov->iov_len)
+		return 0;
+	return svc_rdma_page_dma_map(data, virt_to_page(iov->iov_base),
+				     offset_in_page(iov->iov_base),
+				     iov->iov_len);
+}
+
+/**
+ * svc_rdma_xb_dma_map - DMA map all segments of an xdr_buf
+ * @xdr: xdr_buf containing portion of an RPC message to transmit
+ * @data: pointer to arguments
+ *
+ * Returns:
+ *   %0 if DMA mapping was successful
+ *   %-EIO if DMA mapping failed
+ *
+ * On failure, any DMA mappings that have been already done must be
+ * unmapped by the caller.
+ */
+static int svc_rdma_xb_dma_map(const struct xdr_buf *xdr, void *data)
+{
+	unsigned int len, remaining;
+	unsigned long pageoff;
+	struct page **ppages;
+	int ret;
+
+	ret = svc_rdma_iov_dma_map(data, &xdr->head[0]);
+	if (ret < 0)
+		return ret;
+
+	ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
+	pageoff = offset_in_page(xdr->page_base);
+	remaining = xdr->page_len;
+	while (remaining) {
+		len = min_t(u32, PAGE_SIZE - pageoff, remaining);
+
+		ret = svc_rdma_page_dma_map(data, *ppages++, pageoff, len);
+		if (ret < 0)
+			return ret;
+
+		remaining -= len;
+		pageoff = 0;
+	}
+
+	ret = svc_rdma_iov_dma_map(data, &xdr->tail[0]);
+	if (ret < 0)
+		return ret;
+
+	return xdr->len;
 }
 
 struct svc_rdma_pullup_data {
@@ -688,22 +760,22 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
  * @rctxt: Write and Reply chunks provided by client
  * @xdr: prepared xdr_buf containing RPC message
  *
- * Load the xdr_buf into the ctxt's sge array, and DMA map each
- * element as it is added. The Send WR's num_sge field is set.
+ * Returns:
+ *   %0 if DMA mapping was successful.
+ *   %-EMSGSIZE if a buffer manipulation problem occurred
+ *   %-EIO if DMA mapping failed
  *
- * Returns zero on success, or a negative errno on failure.
+ * The Send WR's num_sge field is set in all cases.
  */
 int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   struct svc_rdma_send_ctxt *sctxt,
 			   const struct svc_rdma_recv_ctxt *rctxt,
-			   struct xdr_buf *xdr)
+			   const struct xdr_buf *xdr)
 {
-	unsigned int len, remaining;
-	unsigned long page_off;
-	struct page **ppages;
-	unsigned char *base;
-	u32 xdr_pad;
-	int ret;
+	struct svc_rdma_map_data args = {
+		.md_rdma	= rdma,
+		.md_ctxt	= sctxt,
+	};
 
 	/* Set up the (persistently-mapped) transport header SGE. */
 	sctxt->sc_send_wr.num_sge = 1;
@@ -712,7 +784,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	/* If there is a Reply chunk, nothing follows the transport
 	 * header, and we're done here.
 	 */
-	if (rctxt && rctxt->rc_reply_chunk)
+	if (!pcl_is_empty(&rctxt->rc_reply_pcl))
 		return 0;
 
 	/* For pull-up, svc_rdma_send() will sync the transport header.
@@ -721,58 +793,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
-	++sctxt->sc_cur_sge_no;
-	ret = svc_rdma_dma_map_buf(rdma, sctxt,
-				   xdr->head[0].iov_base,
-				   xdr->head[0].iov_len);
-	if (ret < 0)
-		return ret;
-
-	/* If a Write chunk is present, the xdr_buf's page list
-	 * is not included inline. However the Upper Layer may
-	 * have added XDR padding in the tail buffer, and that
-	 * should not be included inline.
-	 */
-	if (rctxt && rctxt->rc_write_list) {
-		base = xdr->tail[0].iov_base;
-		len = xdr->tail[0].iov_len;
-		xdr_pad = xdr_pad_size(xdr->page_len);
-
-		if (len && xdr_pad) {
-			base += xdr_pad;
-			len -= xdr_pad;
-		}
-
-		goto tail;
-	}
-
-	ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
-	page_off = xdr->page_base & ~PAGE_MASK;
-	remaining = xdr->page_len;
-	while (remaining) {
-		len = min_t(u32, PAGE_SIZE - page_off, remaining);
-
-		++sctxt->sc_cur_sge_no;
-		ret = svc_rdma_dma_map_page(rdma, sctxt, *ppages++,
-					    page_off, len);
-		if (ret < 0)
-			return ret;
-
-		remaining -= len;
-		page_off = 0;
-	}
-
-	base = xdr->tail[0].iov_base;
-	len = xdr->tail[0].iov_len;
-tail:
-	if (len) {
-		++sctxt->sc_cur_sge_no;
-		ret = svc_rdma_dma_map_buf(rdma, sctxt, base, len);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
+	return pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+				       svc_rdma_xb_dma_map, &args);
 }
 
 /* The svc_rqst and all resources it owns are released as soon as


