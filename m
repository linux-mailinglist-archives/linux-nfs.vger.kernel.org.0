Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3118BAEC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCSPVR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42954 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgCSPVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:21:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so2088028qtp.9;
        Thu, 19 Mar 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+dY/ASI5FAtYHOJqm4kl9v3500pCo4QwYF3AcBfoFAM=;
        b=ULJgzB2k4lSrNNmm4f725ILiCv/cmifwT8nbIh0s4viC/at8sgDmeLgWZPncUmoGHE
         X3DtztJFk4H4AKC7HCD9y4OHjNnPa9tQJYk5bwHrTgCaJh2nVafSGRnyd5hj0mjSZO9t
         uh0GRCRteHpgeiLzMplAyEM/8kQjpD5I8WeXPcrTCOI6hTae+D0KAj29LBygMFQYcxCY
         2ZvexHpp5qGXg9XGlLSV9LtaiTksU2eg1MU+DqBnWwmoTfIxqDpbR4XNgtXRF8xT/Opo
         Ku2wcYI6OcQyh4rsTXG6nvw+NqnrpGaHJ/PssIJZWfYFA9zOkyD+LYEYkUOdyfqkXT41
         Vscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+dY/ASI5FAtYHOJqm4kl9v3500pCo4QwYF3AcBfoFAM=;
        b=PvcRi8VftHZoGmEIqFhkHx6meViD4ulrUcreMgpGC4hXwSHCKHKdQLzRMjMOUMK+Ly
         rfyp6QDwf3mkSMkS4ikDYVTvFSyvp3z8XaO5t7NhZ4k4/2JL0tLqv1fKFVQIkIP8aH/M
         Fkuf4oB7TkOZcIa20Fb7RQjpg/t+4cDj/lMW9TAeOStwOsV+WgIu8YCEiQSeeWKZxbB+
         mpFJWS75NSvPkbYcxr7ashIRNZNbJEaZcumkA2cI5x6vPeCWRNysJp7jZTnCAfnXlaon
         oyzeaJK18oWN/ZEAVCHU4RZD30sKf7x3JdJdceMsqPiqZ1w/Jkd/3eNx1+sUnmz1sHuo
         Hk9g==
X-Gm-Message-State: ANhLgQ1tlUE0PrFMgNVXvOIywijpZzaPx63bDpbMzbVr4Cz0xY2ZFuM4
        beMHYwlo8MdElHXzR7eHLDQBIMK0DRo=
X-Google-Smtp-Source: ADFU+vuK+axvGwramevkSPh8FDtz5Glnuj4/Fc5CM0poA69a+ox7/MmM39cl8jTvQ18bzMh8RLheqg==
X-Received: by 2002:ac8:4785:: with SMTP id k5mr3373960qtq.256.1584631272949;
        Thu, 19 Mar 2020 08:21:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e66sm1714343qkd.129.2020.03.19.08.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:12 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFLAEH011172;
        Thu, 19 Mar 2020 15:21:10 GMT
Subject: [PATCH RFC 09/11] svcrdma: Support multiple READ payloads when
 pulling up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:21:10 -0400
Message-ID: <20200319152110.16298.9209.stgit@klimt.1015granger.net>
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

When counting the number of SGEs needed to construct a Send request,
do not count READ payloads. And, when copying the Reply message into
the pull-up buffer, READ payloads are not to be copied to the Send
buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   15 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  186 ++++++++++++++++++++-------------
 2 files changed, 121 insertions(+), 80 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9238d233f8cf..ff2d943d1540 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1641,20 +1641,25 @@ TRACE_EVENT(svcrdma_dma_map_rwctx,
 
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
-		unsigned int len
+		unsigned int hdrlen,
+		unsigned int msglen
 	),
 
-	TP_ARGS(len),
+	TP_ARGS(hdrlen, msglen),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, len)
+		__field(unsigned int, hdrlen)
+		__field(unsigned int, msglen)
 	),
 
 	TP_fast_assign(
-		__entry->len = len;
+		__entry->hdrlen = hdrlen;
+		__entry->msglen = msglen;
 	),
 
-	TP_printk("len=%u", __entry->len)
+	TP_printk("hdr=%u msg=%u (total %u)",
+		__entry->hdrlen, __entry->msglen,
+		__entry->hdrlen + __entry->msglen)
 );
 
 TRACE_EVENT(svcrdma_send_failed,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 85c91d0debb4..037be0bdb557 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -622,6 +622,45 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
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
@@ -630,50 +669,70 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
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
-	bool read_payload_present = rctxt && rctxt->rc_cur_payload;
-	int elements;
+	/* Resources needed for the transport header */
+	struct svc_rdma_pullup_data args = {
+		.pd_length	= sctxt->sc_hdrbuf.len,
+		.pd_num_sges	= 1,
+	};
+	int ret;
 
-	/* For small messages, copying bytes is cheaper than DMA mapping.
-	 */
-	if (!read_payload_present &&
-	    sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
+	ret = svc_rdma_skip_payloads(xdr, rctxt, svc_rdma_xb_count_sges,
+				     &args);
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
-	if (!read_payload_present) {
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
+		memcpy(args->pd_dest, page_address(*ppages), len);
+		remaining -= len;
+		args->pd_dest += len;
+		pageoff = 0;
+	}
+
+	if (xdr->tail[0].iov_len) {
+		memcpy(args->pd_dest, xdr->tail[0].iov_base, xdr->tail[0].iov_len);
+		args->pd_dest += xdr->tail[0].iov_len;
+	}
 
-	/* assume 1 SGE is needed for the transport header */
-	return elements >= rdma->sc_max_send_sges;
+	args->pd_length += xdr->len;
+	return 0;
 }
 
 /**
@@ -686,53 +745,30 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
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
-	if (rctxt && rctxt->rc_cur_payload) {
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
-			memcpy(dst, page_address(*ppages), len);
-			remaining -= len;
-			dst += len;
-			pageoff = 0;
-		}
-	}
+	struct svc_rdma_pullup_data args = {
+		.pd_dest	= sctxt->sc_xprt_buf + sctxt->sc_hdrbuf.len,
+	};
+	int ret;
 
-	if (taillen)
-		memcpy(dst, tailbase, taillen);
+	ret = svc_rdma_skip_payloads(xdr, rctxt, svc_rdma_xb_linearize,
+				     &args);
+	if (ret < 0)
+		return ret;
 
-	sctxt->sc_sges[0].length += xdr->len;
-	trace_svcrdma_send_pullup(sctxt->sc_sges[0].length);
+	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len + args.pd_length;
+	trace_svcrdma_send_pullup(sctxt->sc_hdrbuf.len, args.pd_length);
 	return 0;
 }
 

