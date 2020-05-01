Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114FD1C1C0D
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgEARkf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729218AbgEARke (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A620C061A0C;
        Fri,  1 May 2020 10:40:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so8515433qtm.4;
        Fri, 01 May 2020 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UuL4nrLdfSBwWKtLxiILrceo4WQfjllGgKQTN+8K0+A=;
        b=YDcgWDcG5jJC5QZRuDIXB0paYUm6sc9z3gOixXklrzrGQ+tU7S9plN9fJYx8Hje9vm
         mQGRi3jcaWatrP1bWQcZtr68zDiFkQ4++dBzBYCnLyNZ2wdl225eD1BhLSW+rgfLLWoD
         d9i9UGQo0n+0rOj4jdr3hwPY0s3VQeUBbR5dwT+o04g8Ou3wF09cIHk46sW0tu3bNk/W
         AAgCrN/g4RfPPuwJOWaapgyL6pdxc8z51zDY5Lk3SJWhdEBRX2WmbDFgqZVNABmWsIwl
         F2KG26Xv+oMcrfOieQ7pcLjaCVtrLUCqTacpDz4PRmjrw4CIV3s+HBJ6OACQBiHqGIpz
         FjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UuL4nrLdfSBwWKtLxiILrceo4WQfjllGgKQTN+8K0+A=;
        b=FiLQr5J0c8gcJBsUuyFaD8CWvKiFfW4HlR7z5TLH38NrDdRdRr1SJ91rna/U9Pcyqj
         mrpQm+OyN7W1JXfICQNF9aZTCcDh6C/CJwUgp0JZzRaQEnQZMixu+8ZmhdskvsxqXc/i
         9tRPb903t2zvI3G0Z9z4Ar4YkDjBM8pdVHON/+OIrULpVjNKTpO3Fq+aiDRYMX8jlZxV
         g0v6x4ab3oPiMWAVlff7xdy+KsNdKXwRyUw1RgpKLy5dKhJiDJB0ruWjWMao7V+LtzBK
         pkzbvcFn6umnfZMOPHwDcBguk8+PI6xdfAOG4HcI6TjoAsUKg7UdQA996SDQsXQ0e8yH
         UKvg==
X-Gm-Message-State: AGi0PuZOjPwswPW4FlzC/gOzWF5T6gCY31kxJ8CJvVF8eBpeS5X6ZzUG
        jWdeOuiBe81fiGvvXULNJBbCG2p8
X-Google-Smtp-Source: APiQypKC1JouBDQ8ZhPjze5b5xCMJJUSf0ktw/PlCASlMqYls2fdPviTwx4MjnX8E98+CwoYSm1jSw==
X-Received: by 2002:ac8:3254:: with SMTP id y20mr4984778qta.67.1588354833437;
        Fri, 01 May 2020 10:40:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q62sm2036503qke.22.2020.05.01.10.40.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:33 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HeVS3026765;
        Fri, 1 May 2020 17:40:31 GMT
Subject: [PATCH v1 1/7] svcrdma: Clean up the tracing for rw_ctx_init errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:31 -0400
Message-ID: <20200501174031.3899.64778.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
References: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
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
- Replace one use of xpt_remotebuf
- Fix a dumb signage issue

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   12 +++++---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   56 +++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c25e11564598..72dc9f6146fb 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1591,28 +1591,32 @@ DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
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

