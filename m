Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF41D009D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgELVWT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730200AbgELVWT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA191C061A0C;
        Tue, 12 May 2020 14:22:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c24so6012280qtw.7;
        Tue, 12 May 2020 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yfG48olU7TS5yzA2N599YfkoG5dmTwMqyAOMPXu150M=;
        b=uenUzDQe/1auRbiENxah6O0wk2RDIh94ojB99SiaF9ELj0NUnveRRqrN7xHn5Y2zc6
         iHJIpIoHCMb7QEOHYJEnz0Jw/x9UIZlPaTZM2AgVHLB0E7V+lvxCe69HJ6hggUP5HI8l
         1HGhcl3u0UZ2VaiEfLsqVV6syj3D6t8EvN7ZNLX2T0Atrfo1MwmP0/XFY8Qs9OEIEhwT
         w1XdGjv3iO1FkL9jP+NGZ7dHzJGIK73gfeYDqi5nb3699kNNTn1PY5MxSfBiuYBiR1q8
         8Zv3uRKvLXULF97Bh0c6zEBMJf7aJGXDRBdhA8I35q8I8svxypl7MFwkbHrq3Vy7Yy8r
         xCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yfG48olU7TS5yzA2N599YfkoG5dmTwMqyAOMPXu150M=;
        b=C3+Ovv+QoWVWCio2Q27E1SFSlPCz+8WlkN58OiwMyV3U1oyGfwY2AiwpeUFm39spjP
         J/NkLPK9m5YvmVnXDH5G6jw0iZQm4DOIYcxqw6VoPNxtdyol9fOcHR6FioZLBG4e+/Ji
         5pz4pKhASzx9aK1chihW91sIuIAtE9dRKh9YNOIN7b5SwmS9m8HbdTcLXAIMo8pgv4cw
         V3N07nBW+l5YPeU+Pk3aqYnOCX2KIvjRwlyuqg+rHc/cc8bJwQVLETu3Akou/VqFMa4f
         ATwXOlbPo9bxvYMcOqpe1YNg4mUFJqd1X5mNHTqJSNe6AkD4HcGY9EQAwCUhSWfn6lbL
         HhIQ==
X-Gm-Message-State: AOAM531GWrL39UTyj3sh92LxVRg+mwDkERiig0TDiSr2kQUT4mNLT5Qm
        Ks2plR3eTbRDpchF6Peeep9WeD4m
X-Google-Smtp-Source: ABdhPJzkKfANumAkcXKDJj1xj6WE61BjeF1OrtW+ZcnqhTiaVuej+CAb1Eu3mEfiLaMnLzDn8jZqdw==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr9852274qtn.165.1589318536754;
        Tue, 12 May 2020 14:22:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b129sm10407238qkc.58.2020.05.12.14.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:16 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMFc4009878;
        Tue, 12 May 2020 21:22:15 GMT
Subject: [PATCH v2 02/29] svcrdma: Clean up the tracing for rw_ctx_init
 errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:15 -0400
Message-ID: <20200512212215.5826.47419.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- De-duplicate code
- Rename the tracepoint with "_err" to allow enabling via glob
- Report the sg_cnt for the failing rw_ctx
- Fix a dumb signage issue

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   12 +++++---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   56 +++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 132c3c778a43..f231975064cb 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1583,28 +1583,32 @@ DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 DEFINE_SVC_DMA_EVENT(dma_map_page);
 DEFINE_SVC_DMA_EVENT(dma_unmap_page);
 
-TRACE_EVENT(svcrdma_dma_map_rwctx,
+TRACE_EVENT(svcrdma_dma_map_rw_err,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
+		unsigned int nents,
 		int status
 	),
 
-	TP_ARGS(rdma, status),
+	TP_ARGS(rdma, nents, status),
 
 	TP_STRUCT__entry(
 		__field(int, status)
+		__field(unsigned int, nents)
 		__string(device, rdma->sc_cm_id->device->name)
 		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
 		__entry->status = status;
+		__entry->nents = nents;
 		__assign_str(device, rdma->sc_cm_id->device->name);
 		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s status=%d",
-		__get_str(addr), __get_str(device), __entry->status
+	TP_printk("addr=%s device=%s nents=%u status=%d",
+		__get_str(addr), __get_str(device), __entry->nents,
+		__entry->status
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 23c2d3ce0dc9..db70709e165a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -39,7 +39,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 struct svc_rdma_rw_ctxt {
 	struct list_head	rw_list;
 	struct rdma_rw_ctx	rw_ctx;
-	int			rw_nents;
+	unsigned int		rw_nents;
 	struct sg_table		rw_sg_table;
 	struct scatterlist	rw_first_sgl[];
 };
@@ -107,6 +107,34 @@ void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma)
 	}
 }
 
+/**
+ * svc_rdma_rw_ctx_init - Prepare a R/W context for I/O
+ * @rdma: controlling transport instance
+ * @ctxt: R/W context to prepare
+ * @offset: RDMA offset
+ * @handle: RDMA tag/handle
+ * @direction: I/O direction
+ *
+ * Returns on success, the number of WQEs that will be needed
+ * on the workqueue, or a negative errno.
+ */
+static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
+				struct svc_rdma_rw_ctxt *ctxt,
+				u64 offset, u32 handle,
+				enum dma_data_direction direction)
+{
+	int ret;
+
+	ret = rdma_rw_ctx_init(&ctxt->rw_ctx, rdma->sc_qp, rdma->sc_port_num,
+			       ctxt->rw_sg_table.sgl, ctxt->rw_nents,
+			       0, offset, handle, direction);
+	if (unlikely(ret < 0)) {
+		svc_rdma_put_rw_ctxt(rdma, ctxt);
+		trace_svcrdma_dma_map_rw_err(rdma, ctxt->rw_nents, ret);
+	}
+	return ret;
+}
+
 /* A chunk context tracks all I/O for moving one Read or Write
  * chunk. This is a a set of rdma_rw's that handle data movement
  * for all segments of one chunk.
@@ -431,12 +459,10 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 			goto out_noctx;
 
 		constructor(info, write_len, ctxt);
-		ret = rdma_rw_ctx_init(&ctxt->rw_ctx, rdma->sc_qp,
-				       rdma->sc_port_num, ctxt->rw_sg_table.sgl,
-				       ctxt->rw_nents, 0, seg_offset,
-				       seg_handle, DMA_TO_DEVICE);
+		ret = svc_rdma_rw_ctx_init(rdma, ctxt, seg_offset, seg_handle,
+					   DMA_TO_DEVICE);
 		if (ret < 0)
-			goto out_initerr;
+			return -EIO;
 
 		trace_svcrdma_send_wseg(seg_handle, write_len, seg_offset);
 
@@ -462,11 +488,6 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 out_noctx:
 	dprintk("svcrdma: no R/W ctxs available\n");
 	return -ENOMEM;
-
-out_initerr:
-	svc_rdma_put_rw_ctxt(rdma, ctxt);
-	trace_svcrdma_dma_map_rwctx(rdma, ret);
-	return -EIO;
 }
 
 /* Send one of an xdr_buf's kvecs by itself. To send a Reply
@@ -646,12 +667,10 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 			goto out_overrun;
 	}
 
-	ret = rdma_rw_ctx_init(&ctxt->rw_ctx, cc->cc_rdma->sc_qp,
-			       cc->cc_rdma->sc_port_num,
-			       ctxt->rw_sg_table.sgl, ctxt->rw_nents,
-			       0, offset, rkey, DMA_FROM_DEVICE);
+	ret = svc_rdma_rw_ctx_init(cc->cc_rdma, ctxt, offset, rkey,
+				   DMA_FROM_DEVICE);
 	if (ret < 0)
-		goto out_initerr;
+		return -EIO;
 
 	list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 	cc->cc_sqecount += ret;
@@ -664,11 +683,6 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 out_overrun:
 	dprintk("svcrdma: request overruns rq_pages\n");
 	return -EINVAL;
-
-out_initerr:
-	trace_svcrdma_dma_map_rwctx(cc->cc_rdma, ret);
-	svc_rdma_put_rw_ctxt(cc->cc_rdma, ctxt);
-	return -EIO;
 }
 
 /* Walk the segments in the Read chunk starting at @p and construct

