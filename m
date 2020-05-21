Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBF1DCFCB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgEUOd4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEUOd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:33:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25996C061A0E;
        Thu, 21 May 2020 07:33:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so7667069ios.4;
        Thu, 21 May 2020 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yfG48olU7TS5yzA2N599YfkoG5dmTwMqyAOMPXu150M=;
        b=ONSvK7bRXILAU4cByX4/BzOFbBuE+7JDF8w+HLibX5ZXGMRDrad73i2Qer6Duqfctu
         1v6cqyeyWS/B0ZKAmXklk+DPex2a+tXYJlkACXmNexH96aF7mlePWDsZJncwztyzlOVs
         MSm8Qz2cY4U0E3BIXpp0MEk4cdl0iXcQx5nW8X+YpSp+pZ4r1qHOSJA16OkBm64+5k87
         rcCtde+SX+7B5Qyoa35B9BuEgSUcaJGpBruRJb3a3D5hi/FNPvff4wHRVoxI6Pf+Zzkb
         DAi4Y4LqPWhT79d8A1tbfAT7FfTYKBM4CGjV/PJTW4QF0Jg3exYZ5YKBhTsnjGMnpfAf
         vUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yfG48olU7TS5yzA2N599YfkoG5dmTwMqyAOMPXu150M=;
        b=B76FbwUsDyRdCuoLx61W0ZDgTQdPJixRQSRkKjLGdehzfFAntVNyHNJbMuJyUtwx7l
         0Gr5VncBaFqEemAwsqwRhaMpng346P7Vata1Y7zfrmxbJ53EnMLp0LQ1C9MJaJf0SHA8
         KbLGaoLBDfh61sDIlPqvkrEzEKGZ/+14hDIkHdXEZKWsqFHddz1NrLnv5WYLM4TEf0LP
         J9I242j6yw4eRsN65a8ahdY9s5NM5+rPZvej1k4t5uUrgK8ds7boDhu+B+o/NQXJYvnS
         mMSGcCOJB+6VUrKZTa+ja9AREKalM6BtJrTwLjL3r/q2RZKMJBbNKZ1Zbt/FF5ypF81a
         0tBA==
X-Gm-Message-State: AOAM530zq5BFBePD/cXHUdIOneKlByv78mEyJpdQtb/M77JPWka9kHKw
        xzo2XqXdBDRcMX8NPPz08UWbt8AT
X-Google-Smtp-Source: ABdhPJyck3C17RI14jPO2UdhlLgJGEsZsbe/rJYtJaj14KEUBarPE/9TKeNBrVUcqVlS7kw5xVOFjQ==
X-Received: by 2002:a02:94e6:: with SMTP id x93mr4116503jah.48.1590071635168;
        Thu, 21 May 2020 07:33:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o70sm3203565ild.3.2020.05.21.07.33.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:33:54 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEXrx1000809;
        Thu, 21 May 2020 14:33:53 GMT
Subject: [PATCH v3 02/32] svcrdma: Clean up the tracing for rw_ctx_init
 errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:33:53 -0400
Message-ID: <20200521143353.3557.99243.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
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

