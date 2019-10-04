Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F63CBC66
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2019 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbfJDN6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Oct 2019 09:58:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37638 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfJDN6X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Oct 2019 09:58:23 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so13754729iob.4;
        Fri, 04 Oct 2019 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BkUt5LiybN+dYsfgIZi/llLOI8b7tpVT44LJM3jeSXo=;
        b=I7kuTi+/wz00Y/pPQe5lPFNtQFDKpdmEy+lCf/TqJAqwv1klGhHdRjGW6GX/Wdvm6h
         x0+3GFZ+LqpVUjrLgNJPlAgRQW/9rQ/YMT7Gx5SYTeBH25tXKvmO+c2xnc7yB6rw/0RJ
         lgT1tkpFMuvTqmjzurlYxj7VmKSwuPJKeD472vhZrNuNQF5bDfmpItYcjJMa6xdxN4fM
         uh3d89Eul4jbL4DaiYv01ZYJrPZksAUinB8aPDACI0GNo6d1HR0PiJZMMnSzOdzX39CP
         fwbQdW5YJEEEWl+oc83zaZVowiP+YPtyRk2FQA4nAzk1n0YlOw8RbZy5FouKplrqUwYo
         jsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BkUt5LiybN+dYsfgIZi/llLOI8b7tpVT44LJM3jeSXo=;
        b=t7birBZErJu5x8Rh+HAbYIpqCx1DcwrkOv8iIJM1nyyghkQwPgE7e0GDDjQcyPr3lP
         3KVU1dvJfp6SqWttyHXaI8h/jFncXjd/mhpuNWQF/hFmdGgSiAg0QmXQ4SsrvRwdDTbB
         oiNzqGiTQbo3cxdsrjkKqYRGDhzXa0z8aSXe96cHjK4KhEQzoTGOP2DyzmajWSgguqlI
         nzre43LnyLDXIUxnIMdaAQIvAydk4yHSwZUvH+IsQY7Yxy9/OK9fzHENKuBvFqMtyr+2
         A068ubhPeAZRvH+/CNNGHtR8cKgBKrfJMYcjqETFEorcZlvbTwvStbYA4g7BVJXZm218
         OuaQ==
X-Gm-Message-State: APjAAAVTDmOnPdx7apyydwsSkfr9+YuV3f78jC02IoIaDZ2anoEKaNSb
        uNWeH/cEqZBSY9bXOnlKXXvUAlFx
X-Google-Smtp-Source: APXvYqxR9vCi2Q8+NGI+7m5I99n8WKUpA5gsAWzaumch2XBYj4Qdqm8KVyhCS9Zw+iWFHGLTuABOrw==
X-Received: by 2002:a02:2941:: with SMTP id p62mr15268150jap.142.1570197502346;
        Fri, 04 Oct 2019 06:58:22 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h17sm2519283ilq.66.2019.10.04.06.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:58:21 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x94DwKWW019110;
        Fri, 4 Oct 2019 13:58:21 GMT
Subject: [PATCH] svcrdma: Improve DMA mapping trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:58:20 -0400
Message-ID: <20191004135745.2510.93924.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture the total size of Sends, the size of DMA map and the
matching DMA unmap to ensure operation is correct.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   30 +++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    8 ++++++--
 2 files changed, 29 insertions(+), 9 deletions(-)

Hey Bruce-

Please consider this patch for v5.5. Thanks!


diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index a138306..9dd7680 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1498,31 +1498,47 @@
  ** Server-side RDMA API events
  **/
 
-TRACE_EVENT(svcrdma_dma_map_page,
+DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
-		const void *page
+		u64 dma_addr,
+		u32 length
 	),
 
-	TP_ARGS(rdma, page),
+	TP_ARGS(rdma, dma_addr, length),
 
 	TP_STRUCT__entry(
-		__field(const void *, page);
+		__field(u64, dma_addr)
+		__field(u32, length)
 		__string(device, rdma->sc_cm_id->device->name)
 		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->page = page;
+		__entry->dma_addr = dma_addr;
+		__entry->length = length;
 		__assign_str(device, rdma->sc_cm_id->device->name);
 		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s device=%s page=%p",
-		__get_str(addr), __get_str(device), __entry->page
+	TP_printk("addr=%s device=%s dma_addr=%llu length=%u",
+		__get_str(addr), __get_str(device),
+		__entry->dma_addr, __entry->length
 	)
 );
 
+#define DEFINE_SVC_DMA_EVENT(name)					\
+		DEFINE_EVENT(svcrdma_dma_map_class, svcrdma_##name,	\
+				TP_PROTO(				\
+					const struct svcxprt_rdma *rdma,\
+					u64 dma_addr,			\
+					u32 length			\
+				),					\
+				TP_ARGS(rdma, dma_addr, length))
+
+DEFINE_SVC_DMA_EVENT(dma_map_page);
+DEFINE_SVC_DMA_EVENT(dma_unmap_page);
+
 TRACE_EVENT(svcrdma_dma_map_rwctx,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 6fdba72..f3f1080 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -233,11 +233,15 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 	/* The first SGE contains the transport header, which
 	 * remains mapped until @ctxt is destroyed.
 	 */
-	for (i = 1; i < ctxt->sc_send_wr.num_sge; i++)
+	for (i = 1; i < ctxt->sc_send_wr.num_sge; i++) {
 		ib_dma_unmap_page(device,
 				  ctxt->sc_sges[i].addr,
 				  ctxt->sc_sges[i].length,
 				  DMA_TO_DEVICE);
+		trace_svcrdma_dma_unmap_page(rdma,
+					     ctxt->sc_sges[i].addr,
+					     ctxt->sc_sges[i].length);
+	}
 
 	for (i = 0; i < ctxt->sc_page_count; ++i)
 		put_page(ctxt->sc_pages[i]);
@@ -490,6 +494,7 @@ static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
 	dma_addr_t dma_addr;
 
 	dma_addr = ib_dma_map_page(dev, page, offset, len, DMA_TO_DEVICE);
+	trace_svcrdma_dma_map_page(rdma, dma_addr, len);
 	if (ib_dma_mapping_error(dev, dma_addr))
 		goto out_maperr;
 
@@ -499,7 +504,6 @@ static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
 	return 0;
 
 out_maperr:
-	trace_svcrdma_dma_map_page(rdma, page);
 	return -EIO;
 }
 

