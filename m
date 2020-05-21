Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E541DCFCD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgEUOeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEUOeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAACFC061A0E;
        Thu, 21 May 2020 07:34:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 17so7296936ilj.3;
        Thu, 21 May 2020 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cc9RbaP1PbGzDZ6es5NE10b7zglpoGibXUKC8RXcruk=;
        b=Mol1wgkRpPE5CYsepwAunV0RjuB6nSCApFzcKSVpd+i68TqEaf0awDGVkF0wvkwtL5
         5/9RnSIzEVviwIHlOQ7LTen2CvTrhzR6OQuEaVTw5RZvZYQk0GaECN8GnXBB+G8sEYnF
         uQrKAYrOy5fOu492SbJlvDb+5T/eABzeg+gx90yx0qUE+1Xb5ldb1CFHMmnACTFVAOPD
         sIjO/ji4Qc3Idt/ywBOXcCftN3bj0u8JBvUqIj7QVXRSHX9plAXPFZwY9d6QpuIY81d7
         wc+01pQR4BObj6gPNnoNROYR4Yhblk+DNnysokyHeA4P20Ud/Z1c0//FvIwa36nYBhQ+
         Lq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cc9RbaP1PbGzDZ6es5NE10b7zglpoGibXUKC8RXcruk=;
        b=rsBxADxIgbCK6mtnIgWbFMDXYBMVuDDnV3eTmIyMvU6lmUV5LIr449HetXtrz/YghH
         ak95MP2DKy0WJ14EkEvKrVZQWOczriDdy4RauujsLzFypjjwMlQURcyuq8EXEwGeIbOM
         lD3fvFR4cYhXK0ReJQqJadoY624ODtSAzux1HbCo5j5mP0shnxJpLCJcsTAnLoZLC7ql
         5ScO7JFuwLThRYTgvGW66iru9BC+t2md/R8TnvYs3RV1qAFCt8DuVR9ugUCEfRa61ZDF
         vXoR35zUOXfLYGCHmYyLUuLUg9gn2ARFqRg0BwahpKMVPug3J/KUQUAyaTrPfRcKGENf
         6dgw==
X-Gm-Message-State: AOAM530/RylnJVgcoAcvZNp/ZqQm7p6jWJQ7yiiIc8sXPImb3nqbwNfJ
        jDSxpYNCJXfSn+enbrdBmXhyWxvq
X-Google-Smtp-Source: ABdhPJyuFHK7Jcd+W4JMCqTM5Ioyz0X59BOEpICqddXdKpmC0ZhpiWEkjifJ8tOf7gEmg7pxCvfpAw==
X-Received: by 2002:a92:5d86:: with SMTP id e6mr8627358ilg.120.1590071640883;
        Thu, 21 May 2020 07:34:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f10sm2941662ilj.85.2020.05.21.07.33.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:33:59 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEXxKK000812;
        Thu, 21 May 2020 14:33:59 GMT
Subject: [PATCH v3 03/32] svcrdma: Clean up handling of get_rw_ctx errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:33:59 -0400
Message-ID: <20200521143359.3557.19246.stgit@klimt.1015granger.net>
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

Clean up: Replace two dprintk call sites with a tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   25 +++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   27 +++++++++++----------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f231975064cb..aca9d0f3d769 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1612,6 +1612,31 @@ TRACE_EVENT(svcrdma_dma_map_rw_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_no_rwctx_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		unsigned int num_sges
+	),
+
+	TP_ARGS(rdma, num_sges),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, num_sges)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->num_sges = num_sges;
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s num_sges=%d",
+		__get_str(addr), __get_str(device), __entry->num_sges
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index db70709e165a..c2d49f607cfe 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -67,19 +67,22 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 		ctxt = kmalloc(struct_size(ctxt, rw_first_sgl, SG_CHUNK_SIZE),
 			       GFP_KERNEL);
 		if (!ctxt)
-			goto out;
+			goto out_noctx;
 		INIT_LIST_HEAD(&ctxt->rw_list);
 	}
 
 	ctxt->rw_sg_table.sgl = ctxt->rw_first_sgl;
 	if (sg_alloc_table_chained(&ctxt->rw_sg_table, sges,
 				   ctxt->rw_sg_table.sgl,
-				   SG_CHUNK_SIZE)) {
-		kfree(ctxt);
-		ctxt = NULL;
-	}
-out:
+				   SG_CHUNK_SIZE))
+		goto out_free;
 	return ctxt;
+
+out_free:
+	kfree(ctxt);
+out_noctx:
+	trace_svcrdma_no_rwctx_err(rdma, sges);
+	return NULL;
 }
 
 static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
@@ -456,7 +459,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		ctxt = svc_rdma_get_rw_ctxt(rdma,
 					    (write_len >> PAGE_SHIFT) + 2);
 		if (!ctxt)
-			goto out_noctx;
+			return -ENOMEM;
 
 		constructor(info, write_len, ctxt);
 		ret = svc_rdma_rw_ctx_init(rdma, ctxt, seg_offset, seg_handle,
@@ -484,10 +487,6 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	dprintk("svcrdma: inadequate space in Write chunk (%u)\n",
 		info->wi_nsegs);
 	return -E2BIG;
-
-out_noctx:
-	dprintk("svcrdma: no R/W ctxs available\n");
-	return -ENOMEM;
 }
 
 /* Send one of an xdr_buf's kvecs by itself. To send a Reply
@@ -637,7 +636,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
 	ctxt = svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
 	if (!ctxt)
-		goto out_noctx;
+		return -ENOMEM;
 	ctxt->rw_nents = sge_no;
 
 	sg = ctxt->rw_sg_table.sgl;
@@ -676,10 +675,6 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	cc->cc_sqecount += ret;
 	return 0;
 
-out_noctx:
-	dprintk("svcrdma: no R/W ctxs available\n");
-	return -ENOMEM;
-
 out_overrun:
 	dprintk("svcrdma: request overruns rq_pages\n");
 	return -EINVAL;

