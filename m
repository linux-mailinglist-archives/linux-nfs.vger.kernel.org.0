Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD71C1C0F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgEARkk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARkj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:39 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E4C061A0C;
        Fri,  1 May 2020 10:40:39 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y19so5092881qvv.4;
        Fri, 01 May 2020 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9C4PcF/usiCJ5I83M8hMFfyUfv897E3z7ZSz4cgOCbs=;
        b=mXYMmzeERNOAPHg/vR6dpSm1IVHzwIZCBQF1VUmpjfaSwnjaLVQpGhE6xS4B2b4Iyw
         LgTm0LFjgbqcVE4hpLATC6ns/zevxt1K23NYXZ+MeqW+iHfvq1aHlNucKoMvMvUJ5cET
         dAxEyckVYUfL+tczoL/KCovGrYxt2a8S4rU47EsjpTxOUugwUjc9IKyQq7eY5gXr9MZ/
         oIp04NB1Czrvc5yWHVoRryOyBpZWddRof2ZOT8egsDwFqaCa64kRziLTvqabBxxit47i
         SCp/aDKSZwXyT6WxC+chA8DJK/5+fXsSHOMeAHpWZ2pCo5cG5quVlepCtgocY+nZS25K
         uwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9C4PcF/usiCJ5I83M8hMFfyUfv897E3z7ZSz4cgOCbs=;
        b=NuA3kV5bb0LUzODAG4ZXHDjc34s35FU0RHkzxzQQNvptxfn6C+BPy+UxaSoe6CkW2E
         umvgoxchsUJLV3bG6jldvtcrcTQ7vyxrC00nBEZNoA2ukJPGGHBFs2JJzBhc6TEbHvbT
         ajavtGWBK3ZkCugDzmCGunjEd8en3VmQIpdS8Ovne5lVa0/2zbXs/73bwbS1MV01ocOd
         gp6atm0rLNwZ2YVZ2Z1ExmiHHM63825opYxTrhuQ9UN5JyWHDGaEW6fhlOX9mrqHavb1
         v7Zm1AYb3UUNprhziNzPrdCwSnJ+hPyvAxAcY+B4OfTnyiPtdNGFHQDiq0jHxLHRrjkP
         Yf0g==
X-Gm-Message-State: AGi0PuYtjdlxjrUWnqOIUVRkdumE/Ei83XiJtUXqPpdV2njgyS9qwgYu
        6MgFcja00UdPxEt49Z5xFBfv+oJN
X-Google-Smtp-Source: APiQypJihBRjJ2oXYOxdu2OatOrP+A+qHl8Tbzd+UF4bC7PBkOm3WvyKfYqOMvdpdXtN1ZtW8BQmBw==
X-Received: by 2002:a0c:b659:: with SMTP id q25mr5152946qvf.48.1588354838880;
        Fri, 01 May 2020 10:40:38 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p2sm3162256qkm.65.2020.05.01.10.40.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:38 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HebBQ026768;
        Fri, 1 May 2020 17:40:37 GMT
Subject: [PATCH v1 2/7] svcrdma: Clean up handling of get_rw_ctx errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:37 -0400
Message-ID: <20200501174037.3899.88600.stgit@klimt.1015granger.net>
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

Replace two dprintk call sites with a tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   25 +++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   27 +++++++++++----------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 72dc9f6146fb..a2fc5f3fb7d9 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1620,6 +1620,31 @@ TRACE_EVENT(svcrdma_dma_map_rw_err,
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

