Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794DE1D00A3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgELVWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A34DC061A0C;
        Tue, 12 May 2020 14:22:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so14127830qka.10;
        Tue, 12 May 2020 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=enuIa/CAxDLGyEpBWEgOIVDJdEAUWX4V+0vJorOkAn/t2md+bXZ1CxQ7cP6jDhixbY
         4KiA4zvK3+XQX2NtcVAxEJu+CB4CIQ0oCDMwa6bwGlG7bCQSqW/8ed/sT10gVDNOxdKP
         XbeRGp7yFRwaLGNUC4E3V1sy3l0DLG9pS8XE2j4QkGEuXb5G5+7VZl15BDL/LJ44VNVE
         zu7D+7HEtRja7reIZ/12ZHi2CXORXEgJSj2XjVNtKH4at7jDjmjvG+i8ZGH6fQCHb86B
         Rrp/Z2gXx9nmPUFVgoWDU6EmwBZvEnL1IMPAv1QuOkLikeAL6Yo8B4093TD5ZJPKtE8a
         nd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=S+qroTk+GMIutd7YwocEOcVtEofVXENciGu6ABF+aOfcbDZxlCOt7xW6v3yChuWrIt
         DWbVb+HZqqMUdNhHg6A5rTO/Iz16qYnPiJZmfT4MaNkNeEMtQNVLvNE2OiCyyGUGuQnp
         VAzJIt+EhtObgFhJ/HyqKsObc1spHZaHkcLP6IXaPPYrafJT1hv6FrGLZAOy0xjo9IiI
         EHZKW6ctlO7YsEDi2rAvtE/AvTmubK8qSRkruM6V7gJ0oQTu1TFOS+8oxYPTsB9Tsi5J
         Pq32AERdh8Xe8Jyk3KNt8SJjuH5FfCEfHWu4keB8l1qRxbwwt2/Ml7jNKiih6Ys+k2DR
         6ZPA==
X-Gm-Message-State: AGi0PubviATXVH3lBe5yuEAh1BCjlZpR3VuyFo6hxk1EA24Q2Pr89Am7
        x3ZFvWBADCk86Tr/B4wxJwPzz6ja
X-Google-Smtp-Source: APiQypL/K8rWQ2yd1hLYJMU2l3ZJs94bTyXFWtra+z3X5xnMfkeYRzJDnIpZjRvStNEi90bP4XVGoQ==
X-Received: by 2002:a37:a0d5:: with SMTP id j204mr23179612qke.128.1589318553142;
        Tue, 12 May 2020 14:22:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h3sm12329782qkf.15.2020.05.12.14.22.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:32 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMVxY009888;
        Tue, 12 May 2020 21:22:31 GMT
Subject: [PATCH v2 05/29] svcrdma: trace undersized Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:31 -0400
Message-ID: <20200512212231.5826.45494.stgit@klimt.1015granger.net>
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

Clean up: Replace a dprintk call site.

This is the last remaining dprintk call site in svc_rdma_rw.c, so
remove dprintk infrastructure as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   32 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    7 ++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index d6da6b8d521d..c046b198072a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1665,6 +1665,38 @@ TRACE_EVENT(svcrdma_page_overrun_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_small_wrch_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		unsigned int remaining,
+		unsigned int seg_no,
+		unsigned int num_segs
+	),
+
+	TP_ARGS(rdma, remaining, seg_no, num_segs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, remaining)
+		__field(unsigned int, seg_no)
+		__field(unsigned int, num_segs)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->remaining = remaining;
+		__entry->seg_no = seg_no;
+		__entry->num_segs = num_segs;
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s remaining=%u seg_no=%u num_segs=%u",
+		__get_str(addr), __get_str(device), __entry->remaining,
+		__entry->seg_no, __entry->num_segs
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 17098a11d2ad..5eb35309ecef 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -9,13 +9,10 @@
 
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
-#include <linux/sunrpc/debug.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc);
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 
@@ -484,8 +481,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return 0;
 
 out_overflow:
-	dprintk("svcrdma: inadequate space in Write chunk (%u)\n",
-		info->wi_nsegs);
+	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
+				     info->wi_nsegs);
 	return -E2BIG;
 }
 

