Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A186815F459
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgBNPuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:50:01 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38944 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgBNPuA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:00 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so4434676ywc.6;
        Fri, 14 Feb 2020 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=C2EzsUQ6sOwcPkm43mfsKiml3ytIXdXhTWnUMmgpa+c=;
        b=kVwo744nPYAWu0G0gULhQX9WQ0OAfafy+dvtv8naun4SbZkTOWBFNKT4piAmAEdCs8
         nwa9NXDrDC0r4Pnb79h8HzVoog2/KnH0WhQU+Lrs/MjN1sqZb/PiCoC5WlvcTW8J/P3x
         5FrmB4NmG6roII37dzK5/LXK/6f1xByiQmScvsfXpFkG5nA1zrv2fB//0X+w/6cs5wCA
         6FPwQqO1CHlCsKQIvN0vJHgStqfZxLV+hlgpyVdujWk+Bz9MfdtJCLC1UG7uJFSt/lwX
         hcS8dBHiALGST0fSLwcPQ8fRF6m0my2SR91zpAdk4nU5CWNuX8rtf3JYbRMz2qSKbDz5
         KuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=C2EzsUQ6sOwcPkm43mfsKiml3ytIXdXhTWnUMmgpa+c=;
        b=orjgsb9PrqC4TwkduPMlVAe/aoulh6vR54ybbFXywSSvT2PlSn27TeIGQPqVEacxRr
         lT/cJW+iXm2MXHrtrNFI2wSWuLHLKJFHAhH6+iBMKi1Nl6PyvKHwSGRyycr4w17gjS2l
         uU/kI1jcJjj+WwJ9vMQSH4MwbzAaOSbRs8HsKhgDl0Ho9y/zYJkl6IGbtBBi0a3L7pWZ
         zdSRHTns08mQlPE0CIbWRgU6/rlGecYNaamrDW9W8twqrAYkSX3SOoTbn7mOag9iYmUC
         i/bTrVt2DBpxtQf0XU1nbAeEMZnlctAvZ7IyS6Z04oT+YYC4iBmnvMF7E5+G4FrVprdY
         /qEA==
X-Gm-Message-State: APjAAAXULAwKouEZvGHX8r48yHEG1lSLP6HuL7J72pX8+Ajb9sSGDzNY
        tpRm/zXwIhtKS+iJujPxONZVyezS
X-Google-Smtp-Source: APXvYqyDCF3kj3exLcfgFAOhduvbo+vwHE3R+q1H8zZ6u/81FRkv2zC0pCGwYGKInPny6dFBmAd/nw==
X-Received: by 2002:a81:34a:: with SMTP id 71mr2829050ywd.221.1581695399700;
        Fri, 14 Feb 2020 07:49:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d66sm2574526ywc.16.2020.02.14.07.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:49:59 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFnweU029156;
        Fri, 14 Feb 2020 15:49:58 GMT
Subject: [PATCH RFC 3/9] svcrdma: Avoid DMA mapping small RPC Replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:49:58 -0500
Message-ID: <20200214154958.3848.99445.stgit@klimt.1015granger.net>
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

On some platforms, DMA mapping part of a page is more costly than
copying bytes. Indeed, not involving the I/O MMU can help the
RPC/RDMA transport scale better for tiny I/Os across more RDMA
devices. This is because interaction with the I/O MMU is eliminated
for each of these small I/Os. Without the explicit unmapping, the
NIC no longer needs to do a costly internal TLB shoot down for
buffers that are just a handful of bytes.

The heuristic for now is to pull-up when the size of the RPC message
body is smaller than half the minimum Send buffer size.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   40 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 +++++++++++++++++----
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..6f0d3e8ce95c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -336,6 +336,44 @@
 				),					\
 				TP_ARGS(rqst))
 
+DECLARE_EVENT_CLASS(xdr_buf_class,
+	TP_PROTO(
+		const struct xdr_buf *xdr
+	),
+
+	TP_ARGS(xdr),
+
+	TP_STRUCT__entry(
+		__field(const void *, head_base)
+		__field(size_t, head_len)
+		__field(const void *, tail_base)
+		__field(size_t, tail_len)
+		__field(unsigned int, page_len)
+		__field(unsigned int, msg_len)
+	),
+
+	TP_fast_assign(
+		__entry->head_base = xdr->head[0].iov_base;
+		__entry->head_len = xdr->head[0].iov_len;
+		__entry->tail_base = xdr->tail[0].iov_base;
+		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_len = xdr->page_len;
+		__entry->msg_len = xdr->len;
+	),
+
+	TP_printk("head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+		__entry->head_base, __entry->head_len, __entry->page_len,
+		__entry->tail_base, __entry->tail_len, __entry->msg_len
+	)
+);
+
+#define DEFINE_XDRBUF_EVENT(name)					\
+		DEFINE_EVENT(xdr_buf_class, name,			\
+				TP_PROTO(				\
+					const struct xdr_buf *xdr	\
+				),					\
+				TP_ARGS(xdr))
+
 /**
  ** Connection events
  **/
@@ -1634,6 +1672,8 @@
 	)
 );
 
+DEFINE_XDRBUF_EVENT(svcrdma_send_pullup);
+
 TRACE_EVENT(svcrdma_send_failed,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a11983c2056f..8ea21ca351e2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -537,16 +537,32 @@ void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
 				      DMA_TO_DEVICE);
 }
 
-/* If the xdr_buf has more elements than the device can
- * transmit in a single RDMA Send, then the reply will
- * have to be copied into a bounce buffer.
+/**
+ * svc_rdma_pull_up_needed - Determine whether to use pull-up
+ * @rdma: controlling transport
+ * @ctxt: I/O resources for an RDMA Send
+ * @xdr: xdr_buf containing RPC message to transmit
+ * @wr_lst: pointer to start of Write chunk list
+ *
+ * Returns:
+ *	%true if pull-up should be used
+ *	%false otherwise
  */
 static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_send_ctxt *ctxt,
 				    struct xdr_buf *xdr,
 				    __be32 *wr_lst)
 {
 	int elements;
 
+	/* Avoid the overhead of DMA mapping for small messages.
+	 */
+	if (xdr->len < RPCRDMA_V1_DEF_INLINE_SIZE >> 1)
+		return true;
+
+	/* Check whether the xdr_buf has more elements than can
+	 * fit in a single RDMA Send.
+	 */
 	/* xdr->head */
 	elements = 1;
 
@@ -627,6 +643,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 				      ctxt->sc_sges[0].length,
 				      DMA_TO_DEVICE);
 
+	trace_svcrdma_send_pullup(xdr);
 	return 0;
 }
 
@@ -652,7 +669,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	u32 xdr_pad;
 	int ret;
 
-	if (svc_rdma_pull_up_needed(rdma, xdr, wr_lst))
+	if (svc_rdma_pull_up_needed(rdma, ctxt, xdr, wr_lst))
 		return svc_rdma_pull_up_reply_msg(rdma, ctxt, xdr, wr_lst);
 
 	++ctxt->sc_cur_sge_no;

