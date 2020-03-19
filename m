Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B967418BAEE
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCSPVU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34422 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgCSPVU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:21:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id 10so2124211qtp.1;
        Thu, 19 Mar 2020 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q1Li6OEH78mDk0zb58KdbS5Wq0GTDNIY6pmtCFwMNIE=;
        b=ePLs7D978F4rjdaRtx0HB0o1EoAz/5pmyqWirfHBu21Qb7ZINvdaV0K0sdlIfQYraB
         rC5zIHdXtF4RYuBgX6Hria/mnndL/2qrzx/B8/pQiZrIG67tJKGdR7eImmkQO6IsgqFr
         Py+NOMA+GMUbroLQTpJd9mn0A85qZ9tZ9qW1eXAty+9k6W19jH+Bs/cwLFiuUxdqamrx
         koppG3u9lkdvYnDrRIQm5aaxp4U70mguF37cZ+cLvP0K5H9VPS59vF+FX4qMvFRABFN0
         oEZu6mmTGF6ln0es1YpP5b3RNG6YtHsZHD71GwrzYibDvFmUCaP3uattBdIcNM0VlkE5
         RhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=q1Li6OEH78mDk0zb58KdbS5Wq0GTDNIY6pmtCFwMNIE=;
        b=HCDSM2drzfNUCeBE/Jvxhn7CMJrq4tYuSraBA3tDkwnI4CypRWOJ9gXB+9JKOh4H1U
         EueFqMvF3DUSTq0o9vvAU8XI8LGR4pw1lTTls2col5uCfU8TLxhF2QItEcy+jUi4gS57
         YHxpsZ0FpX2VMw+BQLZFDcKcqe5rdOq8q7vp0LQu7m+pXDDu36QSpp6yOrlNVAQJ3CBS
         eD+8ro8oWcATXTzOfRzdWdh6IrkKmlu8J25Z/c+jbCJsDeJMo7UMnFMGjDKHE+JkzYzK
         AdsJyD29e2BniSgApqJXMZxRZww1fOesVqsv9KS1FtXuFdKtGIXZ2k689bByu09xPYYL
         TqkQ==
X-Gm-Message-State: ANhLgQ3ilb2i3e+QQSwUqZaNZQe7UdjxQNAcUABSbVZfitmoyUbHC3mb
        kdcYyn1LzL8J9H+w4wHO6I2HK4zH2kc=
X-Google-Smtp-Source: ADFU+vtjAmehoL6Yu+AdUJNcWUd1NtFomwQdAQ1uWPENR/Q/qYWbkbuVBS7RyRDfLqbMEumVqb4flg==
X-Received: by 2002:ac8:c4f:: with SMTP id l15mr3455718qti.177.1584631277998;
        Thu, 19 Mar 2020 08:21:17 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f203sm1721777qke.100.2020.03.19.08.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:17 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFLG7A011175;
        Thu, 19 Mar 2020 15:21:16 GMT
Subject: [PATCH RFC 10/11] svcrdma: Support multiple READ payloads in
 svc_rdma_map_reply_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:21:16 -0400
Message-ID: <20200319152116.16298.94729.stgit@klimt.1015granger.net>
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

The function is restructured to DMA map only the parts of rq_res
that do not contain a READ payload.

This change has been tested to confirm that it does not cause a
regression in the no Write chunk and single Write chunk cases.
Multiple Write chunks have not been tested.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 
 include/trace/events/rpcrdma.h        |    1 
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  173 +++++++++++++++++++--------------
 3 files changed, 99 insertions(+), 77 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 93642a889535..6f235d66e6fc 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -203,7 +203,7 @@ extern int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_recv_ctxt *rctxt,
-				  struct xdr_buf *xdr);
+				  const struct xdr_buf *xdr);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 				 unsigned int length);
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ff2d943d1540..b270069c90a0 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1612,6 +1612,7 @@ DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 				TP_ARGS(rdma, dma_addr, length))
 
 DEFINE_SVC_DMA_EVENT(dma_map_page);
+DEFINE_SVC_DMA_EVENT(dma_map_failed);
 DEFINE_SVC_DMA_EVENT(dma_unmap_page);
 
 TRACE_EVENT(svcrdma_dma_map_rwctx,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 037be0bdb557..435b3c0f3b6e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -587,39 +587,111 @@ int svc_rdma_skip_payloads(const struct xdr_buf *xdr,
 	return 0;
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
+	trace_svcrdma_dma_map_failed(rdma, dma_addr, len);
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
@@ -720,7 +792,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
 	remaining = xdr->page_len;
 	while (remaining) {
 		len = min_t(u32, PAGE_SIZE - pageoff, remaining);
-		memcpy(args->pd_dest, page_address(*ppages), len);
+		memcpy(args->pd_dest, page_address(*ppages) + pageoff, len);
 		remaining -= len;
 		args->pd_dest += len;
 		pageoff = 0;
@@ -778,22 +850,22 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
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
@@ -811,58 +883,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
-	++sctxt->sc_cur_sge_no;
-	ret = svc_rdma_dma_map_buf(rdma, sctxt,
-				   xdr->head[0].iov_base,
-				   xdr->head[0].iov_len);
-	if (ret < 0)
-		return ret;
-
-	/* If Write chunks are present, the xdr_buf's page list
-	 * is not included inline. However the Upper Layer may
-	 * have added XDR padding in the tail buffer, and that
-	 * should not be included inline.
-	 */
-	if (rctxt && rctxt->rc_cur_payload) {
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
+	return svc_rdma_skip_payloads(xdr, rctxt, svc_rdma_xb_dma_map, &args);
 }
 
 /* The svc_rqst and all resources it owns are released as soon as

