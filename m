Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD8835D6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfHFPyP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37800 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id t76so67326042oih.4;
        Tue, 06 Aug 2019 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=L/QHiMFG50yh0Rtu7NrBqYslOf4urkZVDVq7mRJW4W8=;
        b=R5g/0FW5TiDIzQherZPtnFIeIXC73S1R/JNkmM8e1NujIHrnrC2SuYoXkNuXJJeldx
         5XBNiE+l4ac00GYXCsy7kjcrJGkuKUzx8gfIWbzRjmDRGLHT2xkWV0+Gs5pI+DEwuvDJ
         hq2omRy7Y6QXW4xS70Yc/LlfBCSp7otlp0Xm8CBPOg0/zVfBlzVHMUsODsD5LfU/oaQQ
         xRmEIT4s6dFhiHPEsqOi57z5RjCM9ffkoqBaL06BHax4vrKJI0/NEB3vIn6PSJkXY2wh
         iGa3EpmyMxbzYBjSs50i/oWcMzl+VQ2DpX2J17PcldSWAr6neFKsROHwy/+2FNPYqjci
         e0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=L/QHiMFG50yh0Rtu7NrBqYslOf4urkZVDVq7mRJW4W8=;
        b=DUzztPFYw+pkYijb9ap42q4VubnjNTd9tDoZqHW1VNlKczubg/bQiBpstz2dEeA02V
         wH9YA9+qcbq0AUpzFypdwrn1a6mzFYqCTLtATScOO5GjGWnOHXNmQkfe/I2ih9eZjTbe
         OxnRH0OPpcaOKFjA9vYovcvDresHdFjGf++FdYOxVQi4m8vBCURs9p95cI0HEOp2tF+r
         iXmSa7BPSuwXjgBaaLtgeUN8ZS0HLGYYppTEcUVDF+CUDgZiOCZUwsq/QxsJ1wXr9vLX
         rijlEON4Dw65ciFyYXIHGjy0cwCPCThZWJyHoNh4UEckfQAqWrlOID13DI0nZ63kkRZr
         ME9w==
X-Gm-Message-State: APjAAAUMB8goYigDT1t0PmesT+HqPxWJ6K+BSSOrBkFQNlB1ieduCxmW
        NiRYJQu6Gb66BRJoslOyivu4B4Dk
X-Google-Smtp-Source: APXvYqwMsOdLNLFDo0rj1dCZ3CMWEs6rGS2jk2fwLqAbozzDi7v+rWpYilbOnjyIy8OTVzR6ZE/tDQ==
X-Received: by 2002:a02:9a03:: with SMTP id b3mr4944740jal.0.1565106854272;
        Tue, 06 Aug 2019 08:54:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y5sm92306518ioc.86.2019.08.06.08.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsDjV011526;
        Tue, 6 Aug 2019 15:54:13 GMT
Subject: [PATCH v1 05/18] xprtrdma: Rename CQE field in Receive trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:13 -0400
Message-ID: <20190806155413.9529.38954.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make the field name the same for all trace points that handle
pointers to struct rpcrdma_rep. That makes it easy to grep for
matching rep points in trace output.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   21 +++++++++++----------
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f6a4eaa..6e6055e 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -623,21 +623,21 @@
 
 TRACE_EVENT(xprtrdma_post_recv,
 	TP_PROTO(
-		const struct ib_cqe *cqe
+		const struct rpcrdma_rep *rep
 	),
 
-	TP_ARGS(cqe),
+	TP_ARGS(rep),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(const void *, rep)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = cqe;
+		__entry->rep = rep;
 	),
 
-	TP_printk("cqe=%p",
-		__entry->cqe
+	TP_printk("rep=%p",
+		__entry->rep
 	)
 );
 
@@ -715,14 +715,15 @@
 	TP_ARGS(wc),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(const void *, rep)
 		__field(u32, byte_len)
 		__field(unsigned int, status)
 		__field(u32, vendor_err)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = wc->wr_cqe;
+		__entry->rep = container_of(wc->wr_cqe, struct rpcrdma_rep,
+					    rr_cqe);
 		__entry->status = wc->status;
 		if (wc->status) {
 			__entry->byte_len = 0;
@@ -733,8 +734,8 @@
 		}
 	),
 
-	TP_printk("cqe=%p %u bytes: %s (%u/0x%x)",
-		__entry->cqe, __entry->byte_len,
+	TP_printk("rep=%p %u bytes: %s (%u/0x%x)",
+		__entry->rep, __entry->byte_len,
 		rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
 	)
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index b10aa16..902cc82 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1523,7 +1523,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
 			goto release_wrs;
 
-		trace_xprtrdma_post_recv(rep->rr_recv_wr.wr_cqe);
+		trace_xprtrdma_post_recv(rep);
 		++count;
 	}
 

