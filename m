Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB51E917E
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgE3N21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N21 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827CC03E969;
        Sat, 30 May 2020 06:28:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j3so5154598ilk.11;
        Sat, 30 May 2020 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cc9RbaP1PbGzDZ6es5NE10b7zglpoGibXUKC8RXcruk=;
        b=Vi9VSAUr4ooLRjeJN0RrGXQbHdj70K3t9igp0FskRndkmiWVGcAWK09VR1pmnvanQ8
         48W5F1MXsMHlgbtFCCkTvRYJ/o3gaVXjCDpZHCELSRa51I2FoAojhFOlTN+7OIbX3HcC
         cYIFudKCl16vV9e3YXslGcqTqSCFA5PZ9GdYU/eIS6GRueZMOXQxwgroP03zhXEstwBc
         XKFp1Yhvz3CBuYzPExXZ75Ji0iCybsRcuXoD5TpopsQRCxK2m9W3Y7zGgLCBToCdYuVR
         0qWbobfocEvlvCYq9kQGrla2oxb2gv8GLhl0afdgCI/8c/3QU0UWdj+FdUNSmLPLf9dt
         /q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cc9RbaP1PbGzDZ6es5NE10b7zglpoGibXUKC8RXcruk=;
        b=nKGqyOS+m/cl0IOU+U82i9qyAqKtKIi/iMwf6r2WestoRNeiBslXDTJZ05Xu88XHHV
         4K9sK9ph/FTkl7XTjQMPq+D0LvjPHCYuZhtZAVcewsd0slGwg0GweIBKxaeKZJUlVyp9
         zSoP75NIt4SqiXJzt7siZIu+Fb/a3lmM2XSnmQ/tByND25ApSaYqm9EdqLQZb2VdIy0R
         LLRDN5EDxxIsRWa0DQ4ZGu+jZhnOlkfOmVhrD47BqcpTxTTdRhULCAwrxkEgu5fWIjoJ
         LJ+6Mni7lNHMIG8+yRfU1B/rSt0H2w+uzMmsvu42UppNgQFtNLFZrZx852UWc2M0tI7H
         hC3A==
X-Gm-Message-State: AOAM531kMueq6IHfhqDST/keWy1ha/R1E1w3vbOQAlj07wB1sGrFwpqj
        CFM2fKTKGayjl7sFPpj7ImvYmldc
X-Google-Smtp-Source: ABdhPJxMYbmZAJz7D9GiOyL6qlyEzaa6+AaOIpMrJtrtVRlTeAQcizqg0gQSS+K92kCsNzkIwMqF2g==
X-Received: by 2002:a92:af11:: with SMTP id n17mr58851ili.156.1590845306589;
        Sat, 30 May 2020 06:28:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o15sm6394927ilg.46.2020.05.30.06.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:26 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSPTe001396;
        Sat, 30 May 2020 13:28:25 GMT
Subject: [PATCH v4 04/33] svcrdma: Clean up handling of get_rw_ctx errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:25 -0400
Message-ID: <20200530132825.10117.40320.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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

