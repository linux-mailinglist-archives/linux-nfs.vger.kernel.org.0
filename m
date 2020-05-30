Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2651E9180
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgE3N2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D7C03E969;
        Sat, 30 May 2020 06:28:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so2280559iob.10;
        Sat, 30 May 2020 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=rfOof2t849Rx28tyt16S5persRiDijlZRRTfMlcT58F4XyXIBopGgk3RFyyEuPh/Kl
         SYsY8AjyCrUunsAih4l4k+pAVR11XatMwZGThNyvEoio++fh15WYBhnAX8xDR12+onb1
         GeHI0n6iiN5+1QjNiRUpSvGbT92U91U/WSAZKLEC0mAJLIMxRsz8NbJ2txOP/kb8NOIT
         Y+maCB+br7Sb6jEREUa38yJmAYlHW7xypJUo/f/cmJzPYXrVUm98j3YxQbGxJk/f7t11
         mplbVFkQzsNSnJ7cuvbxfroYyyIUBufnmZTa8irbDO/OHVhuT8K9XNndrzFZUnsJCDc3
         0c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=A+5M5qIPfz67F3/3yW1W1UQQloJkuzM7G1RpaziEMXKsTELfRZQB8JbFown1uajnNl
         ez0kvrDMvUs/LSt/vqCVgMsw2qDuwMN8bkSVxJSA7hQPAyiMil0Uxt/8/NeSgOyVGh+4
         GeoIQjLfV4ImRbk/Yrka5za7tWFAaOckrDeC7avymJovRsdoYYv4XzqKecVQRSsjZJ4G
         j4zLRfFD4bVkzAufqAquwsJgtyQqnrmlnFCvJDVKW1k5bwX9JWsFkqQnrQacTDKNPJZL
         Vh0H9DHQ2ODOhISUVyFoMZnPAYYsoWCpcBDdC/SQgTyvUtOgHvb9QyT0cb6aYi/ymTe6
         BANg==
X-Gm-Message-State: AOAM530NVnH3KxM9ub6jtxPrDiga/Qoa0mKdWaGoTAo6zRRzIow8OqI8
        fnDGWedxN+BBTRUlgVp+MvTh46RC
X-Google-Smtp-Source: ABdhPJz8md8lCPIAurAyPcd9c5oPCHnUazG97SGxxST33NIa2zKJbJ7rnQrnxaadODitx8AD8pnfNw==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr10946551ioc.19.1590845312071;
        Sat, 30 May 2020 06:28:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n22sm5085116ioh.46.2020.05.30.06.28.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:31 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSUwq001399;
        Sat, 30 May 2020 13:28:30 GMT
Subject: [PATCH v4 05/33] svcrdma: Trace page overruns when constructing
 RDMA Reads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:30 -0400
Message-ID: <20200530132830.10117.99579.stgit@klimt.1015granger.net>
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

Clean up: Replace a dprintk call site with a tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   28 ++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index aca9d0f3d769..d6da6b8d521d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1637,6 +1637,34 @@ TRACE_EVENT(svcrdma_no_rwctx_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_page_overrun_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		const struct svc_rqst *rqst,
+		unsigned int pageno
+	),
+
+	TP_ARGS(rdma, rqst, pageno),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, pageno)
+		__field(u32, xid)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->pageno = pageno;
+		__entry->xid = __be32_to_cpu(rqst->rq_xid);
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s xid=0x%08x pageno=%u", __get_str(addr),
+		__get_str(device), __entry->xid, __entry->pageno
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c2d49f607cfe..17098a11d2ad 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -676,7 +676,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return 0;
 
 out_overrun:
-	dprintk("svcrdma: request overruns rq_pages\n");
+	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, info->ri_pageno);
 	return -EINVAL;
 }
 

