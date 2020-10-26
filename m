Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E993E299609
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781766AbgJZSzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:06 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40478 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781712AbgJZSzG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:06 -0400
Received: by mail-qv1-f67.google.com with SMTP id 63so2947090qva.7;
        Mon, 26 Oct 2020 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vWL+cDt2Y6NkYEnEYS+ArN4PXs78b+qtMN6zVKDF8iA=;
        b=gY2e3wgJQP703ZlbsgliHpxkhLZ2q/WmGvwJMhOlub0gCZyWeeYlf9U84ECHLb7udK
         wnsQjRuhff9H+sZ7ok6UGN5NScKZF3SHFTFT4e9OlXo87UP3ZiVd6HRZ3ZS11ccINmki
         REG6zDsSdwgOTVvICW+KBcZSn8ypC1txOEmE3vVGM3XOw98UdBo/a3hkuiEJcO06IHIu
         bzO3lKM40UsctgMbiiehJVVMp2ieaUhNa1JTQ3DBolmONnvhx+TW4omPylKe4L9ZK/Jr
         Qec3pidANl2sal0ZxnN1cSTfeX8Orj7tvsNXxGlugM5rWgyxiKHZjpVuEr5ruaEa7J5H
         DtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vWL+cDt2Y6NkYEnEYS+ArN4PXs78b+qtMN6zVKDF8iA=;
        b=ng/umUVxucd7d54XcCx1Zj/1IAeHzZSG/v3W8Jc3Xxyy1sPhjZtPh0diZtY9TOE+PG
         SAgkdvO88j6Oy0zEMKKaIAvHwEBCAsVdXnqllmGbXFk1excCE/fqhO5+1pgvBahXuni5
         gCxKxwM9jbKtvYEBSMzcXCtn1tAqocLfIHZRO6Y+ibMblE+rDf7PNXVYD5sit+Y9/7V4
         cAiqW8OmI3+aXQ++hml0JuNL9liwXl6BZAX9atco9tHwTCz5tLL2Ucygc/Pc8Ol5Gq/b
         GvmHZxBHELKLDoVdAMQG6OH7j5erOPOOqO5cvINOB3Xa4ik5T0QjymFzbyoDvMfgn+YW
         5CLg==
X-Gm-Message-State: AOAM533a+AyUKrneA2j2WbpcErw+q4FsvP01MmJS70VK3IPo7tPlGdzN
        U9iMw7cNfRiSDtxLiBfySO28ApIcBHc=
X-Google-Smtp-Source: ABdhPJw0iIE6SRk66jTUS6IHSkT1b4m4ekqSX9jrl/Fu2jci4L5ovrBvbNk/nAK/9coczgN/NWUliQ==
X-Received: by 2002:a05:6214:4af:: with SMTP id w15mr18231885qvz.51.1603738503654;
        Mon, 26 Oct 2020 11:55:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s11sm6961635qks.64.2020.10.26.11.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:02 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIt212013652;
        Mon, 26 Oct 2020 18:55:02 GMT
Subject: [PATCH 13/20] svcrdma: Support multiple write chunks when pulling up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:02 -0400
Message-ID: <160373850208.1886.1587096744698083631.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When counting the number of SGEs needed to construct a Send request,
do not count result payloads. And, when copying the Reply message
into the pull-up buffer, result payloads are not to be copied to the
Send buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    2 
 include/trace/events/rpcrdma.h             |   20 ++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   14 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |    9 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  188 +++++++++++++++++-----------
 5 files changed, 146 insertions(+), 87 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d9148787efff..7090af1a9791 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -182,6 +182,8 @@ extern void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
 /* svc_rdma_recvfrom.c */
 extern void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma);
 extern bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma);
+extern struct svc_rdma_recv_ctxt *
+		svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_recv_ctxt *ctxt);
 extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 5218e0f9596a..afc58accb9cf 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1805,20 +1805,30 @@ TRACE_EVENT(svcrdma_small_wrch_err,
 
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
-		unsigned int len
+		const struct svc_rdma_send_ctxt *ctxt,
+		unsigned int msglen
 	),
 
-	TP_ARGS(len),
+	TP_ARGS(ctxt, msglen),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, len)
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(unsigned int, hdrlen)
+		__field(unsigned int, msglen)
 	),
 
 	TP_fast_assign(
-		__entry->len = len;
+		__entry->cq_id = ctxt->sc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->sc_cid.ci_completion_id;
+		__entry->hdrlen = ctxt->sc_hdrbuf.len,
+		__entry->msglen = msglen;
 	),
 
-	TP_printk("len=%u", __entry->len)
+	TP_printk("cq_id=%u cid=%d hdr=%u msg=%u (total %u)",
+		__entry->cq_id, __entry->completion_id,
+		__entry->hdrlen, __entry->msglen,
+		__entry->hdrlen + __entry->msglen)
 );
 
 TRACE_EVENT(svcrdma_send_err,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 5e7c4ba9e147..63f8be974df2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -74,11 +74,17 @@ void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
  */
 static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 			      struct rpc_rqst *rqst,
-			      struct svc_rdma_send_ctxt *ctxt)
+			      struct svc_rdma_send_ctxt *sctxt)
 {
+	struct svc_rdma_recv_ctxt *rctxt;
 	int ret;
 
-	ret = svc_rdma_map_reply_msg(rdma, ctxt, NULL, &rqst->rq_snd_buf);
+	rctxt = svc_rdma_recv_ctxt_get(rdma);
+	if (!rctxt)
+		return -EIO;
+
+	ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt, &rqst->rq_snd_buf);
+	svc_rdma_recv_ctxt_put(rdma, rctxt);
 	if (ret < 0)
 		return -EIO;
 
@@ -86,8 +92,8 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	 * the rq_buffer before all retransmits are complete.
 	 */
 	get_page(virt_to_page(rqst->rq_buffer));
-	ctxt->sc_send_wr.opcode = IB_WR_SEND;
-	return svc_rdma_send(rdma, ctxt);
+	sctxt->sc_send_wr.opcode = IB_WR_SEND;
+	return svc_rdma_send(rdma, sctxt);
 }
 
 /* Server-side transport endpoint wants a whole page for its send
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 7d44e9d2e7a3..af32c3ad45a6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -194,8 +194,13 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 	}
 }
 
-static struct svc_rdma_recv_ctxt *
-svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
+/**
+ * svc_rdma_recv_ctxt_get - Allocate a recv_ctxt
+ * @rdma: controlling svcxprt_rdma
+ *
+ * Returns a recv_ctxt or (rarely) NULL if none are available.
+ */
+struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 	struct llist_node *node;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index fd8d62b1e640..b21beaa0114e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -531,6 +531,45 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
 				     offset_in_page(base), len);
 }
 
+struct svc_rdma_pullup_data {
+	u8		*pd_dest;
+	unsigned int	pd_length;
+	unsigned int	pd_num_sges;
+};
+
+/**
+ * svc_rdma_xb_count_sges - Count how many SGEs will be needed
+ * @xdr: xdr_buf containing portion of an RPC message to transmit
+ * @data: pointer to arguments
+ *
+ * Returns:
+ *   Number of SGEs needed to Send the contents of @xdr inline
+ */
+static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
+				  void *data)
+{
+	struct svc_rdma_pullup_data *args = data;
+	unsigned int remaining;
+	unsigned long offset;
+
+	if (xdr->head[0].iov_len)
+		++args->pd_num_sges;
+
+	offset = offset_in_page(xdr->page_base);
+	remaining = xdr->page_len;
+	while (remaining) {
+		++args->pd_num_sges;
+		remaining -= min_t(u32, PAGE_SIZE - offset, remaining);
+		offset = 0;
+	}
+
+	if (xdr->tail[0].iov_len)
+		++args->pd_num_sges;
+
+	args->pd_length += xdr->len;
+	return 0;
+}
+
 /**
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
@@ -539,50 +578,71 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
- *	%true if pull-up must be used
- *	%false otherwise
+ *   %true if pull-up must be used
+ *   %false otherwise
  */
-static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_send_ctxt *sctxt,
+static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
+				    const struct svc_rdma_send_ctxt *sctxt,
 				    const struct svc_rdma_recv_ctxt *rctxt,
-				    struct xdr_buf *xdr)
+				    const struct xdr_buf *xdr)
 {
-	bool write_chunk_present = rctxt && rctxt->rc_write_list;
-	int elements;
+	/* Resources needed for the transport header */
+	struct svc_rdma_pullup_data args = {
+		.pd_length	= sctxt->sc_hdrbuf.len,
+		.pd_num_sges	= 1,
+	};
+	int ret;
 
-	/* For small messages, copying bytes is cheaper than DMA mapping.
-	 */
-	if (!write_chunk_present &&
-	    sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
+	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+				      svc_rdma_xb_count_sges, &args);
+	if (ret < 0)
+		return false;
+
+	if (args.pd_length < RPCRDMA_PULLUP_THRESH)
 		return true;
+	return args.pd_num_sges >= rdma->sc_max_send_sges;
+}
 
-	/* Check whether the xdr_buf has more elements than can
-	 * fit in a single RDMA Send.
-	 */
-	/* xdr->head */
-	elements = 1;
-
-	/* xdr->pages */
-	if (!rctxt || !rctxt->rc_write_list) {
-		unsigned int remaining;
-		unsigned long pageoff;
-
-		pageoff = xdr->page_base & ~PAGE_MASK;
-		remaining = xdr->page_len;
-		while (remaining) {
-			++elements;
-			remaining -= min_t(u32, PAGE_SIZE - pageoff,
-					   remaining);
-			pageoff = 0;
-		}
+/**
+ * svc_rdma_xb_linearize - Copy region of xdr_buf to flat buffer
+ * @xdr: xdr_buf containing portion of an RPC message to copy
+ * @data: pointer to arguments
+ *
+ * Returns:
+ *   Always zero.
+ */
+static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
+				 void *data)
+{
+	struct svc_rdma_pullup_data *args = data;
+	unsigned int len, remaining;
+	unsigned long pageoff;
+	struct page **ppages;
+
+	if (xdr->head[0].iov_len) {
+		memcpy(args->pd_dest, xdr->head[0].iov_base, xdr->head[0].iov_len);
+		args->pd_dest += xdr->head[0].iov_len;
 	}
 
-	/* xdr->tail */
-	if (xdr->tail[0].iov_len)
-		++elements;
+	ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
+	pageoff = offset_in_page(xdr->page_base);
+	remaining = xdr->page_len;
+	while (remaining) {
+		len = min_t(u32, PAGE_SIZE - pageoff, remaining);
+		memcpy(args->pd_dest, page_address(*ppages) + pageoff, len);
+		remaining -= len;
+		args->pd_dest += len;
+		pageoff = 0;
+		ppages++;
+	}
 
-	/* assume 1 SGE is needed for the transport header */
-	return elements >= rdma->sc_max_send_sges;
+	if (xdr->tail[0].iov_len) {
+		memcpy(args->pd_dest, xdr->tail[0].iov_base, xdr->tail[0].iov_len);
+		args->pd_dest += xdr->tail[0].iov_len;
+	}
+
+	args->pd_length += xdr->len;
+	return 0;
 }
 
 /**
@@ -595,54 +655,30 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
  * The device is not capable of sending the reply directly.
  * Assemble the elements of @xdr into the transport header buffer.
  *
- * Returns zero on success, or a negative errno on failure.
+ * Assumptions:
+ *  pull_up_needed has determined that @xdr will fit in the buffer.
+ *
+ * Returns:
+ *   %0 if pull-up was successful
+ *   %-EMSGSIZE if a buffer manipulation problem occurred
  */
-static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
+static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 				      struct svc_rdma_send_ctxt *sctxt,
 				      const struct svc_rdma_recv_ctxt *rctxt,
 				      const struct xdr_buf *xdr)
 {
-	unsigned char *dst, *tailbase;
-	unsigned int taillen;
-
-	dst = sctxt->sc_xprt_buf + sctxt->sc_hdrbuf.len;
-	memcpy(dst, xdr->head[0].iov_base, xdr->head[0].iov_len);
-	dst += xdr->head[0].iov_len;
-
-	tailbase = xdr->tail[0].iov_base;
-	taillen = xdr->tail[0].iov_len;
-	if (rctxt && rctxt->rc_write_list) {
-		u32 xdrpad;
-
-		xdrpad = xdr_pad_size(xdr->page_len);
-		if (taillen && xdrpad) {
-			tailbase += xdrpad;
-			taillen -= xdrpad;
-		}
-	} else {
-		unsigned int len, remaining;
-		unsigned long pageoff;
-		struct page **ppages;
-
-		ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
-		pageoff = xdr->page_base & ~PAGE_MASK;
-		remaining = xdr->page_len;
-		while (remaining) {
-			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
-
-			memcpy(dst, page_address(*ppages) + pageoff, len);
-			remaining -= len;
-			dst += len;
-			pageoff = 0;
-			ppages++;
-		}
-	}
+	struct svc_rdma_pullup_data args = {
+		.pd_dest	= sctxt->sc_xprt_buf + sctxt->sc_hdrbuf.len,
+	};
+	int ret;
 
-	if (taillen)
-		memcpy(dst, tailbase, taillen);
+	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+				      svc_rdma_xb_linearize, &args);
+	if (ret < 0)
+		return ret;
 
-	sctxt->sc_sges[0].length += xdr->len;
-	trace_svcrdma_send_pullup(sctxt->sc_sges[0].length);
+	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len + args.pd_length;
+	trace_svcrdma_send_pullup(sctxt, args.pd_length);
 	return 0;
 }
 


