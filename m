Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155AC20D90B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbgF2Tni (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgF2Tmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:42:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29302C02F021;
        Mon, 29 Jun 2020 07:53:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so13032353qtg.4;
        Mon, 29 Jun 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZkrTQFCNrGZ2J9HlWpEHVgSvYmNVSxda0z0g3Ja1x0Q=;
        b=BKyjxNXsjoIqJQ7duuZwQ8NBqE4yh0ajYKaxfZbmRdACJrbcHetOGdgFPIM5Mr6Qdc
         5fhMtD9U2066biIaSm4kezGxULI+Pq4NjcT5ICHqwVqk5bwX+9A3ljDyKq2bBsNnt3B5
         MProH4Wex8e1K8XJg7C+mJy9Y9C2D+r3M5i3ukLsSNXWyn0TXVUl0I0EWQPMla1ttFn+
         8LtohEhKaV/gjzTrRNWwjcm9VXFSeCIpe1JA5fQ52xPT/9I9/c2Z41BUSsZ+Hmk8tH4M
         JxdjVn6zQsBkG0RUnYGMjNj0dWQm7U+sfIYZhd6TjGwPf2j0cKqwyAk/YJGkosg8ctl2
         s4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZkrTQFCNrGZ2J9HlWpEHVgSvYmNVSxda0z0g3Ja1x0Q=;
        b=LaMMlr0joHq7FmAGNW6gXjMwKjyFiC9T+J2xnJDHjW+IuQMNbpLoWlkrn9PvGcEzBn
         D/K3Lc7RNj7Bsz1288vgHUkUakUhOOdWARIjSEmTVyT4Q7mvCig1KQ4yA6NZ90tWZu6O
         SoFCdIrqbWFqyudtHi6jv6tQYL8lkPieu80CLNp7UzpHVVnsew0nirwcXQWeH2MEe50Q
         Tln4Q1UxtUzktOUxAGkVC2dGWPVJCxiO53t/27Ln5jAu9pznrZus491vCkAuZ/BiMcI2
         RIentgUj9k1MaQM0cdClxMwXR5q+1yzkq6FKbwLhjztydEr1nas+XuyttUhLIGZzusEL
         iq7g==
X-Gm-Message-State: AOAM531kup7dSRGSY4X1FgKgfXwSEmuPhPH7HYs7YYGeCvCLxQOnRNYs
        NkBAdfjIs6zf781UxRgdgMpK03ud
X-Google-Smtp-Source: ABdhPJyHM0XuuBxXuGH/jLJUdEWyWEe8HWZHzqwgKt1ehC4az5OmD5zWgKItFubYRVo7RYLLnsuwqw==
X-Received: by 2002:ac8:4507:: with SMTP id q7mr15885586qtn.142.1593442425188;
        Mon, 29 Jun 2020 07:53:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r49sm20147693qtr.11.2020.06.29.07.53.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:53:44 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TErhZN006230;
        Mon, 29 Jun 2020 14:53:43 GMT
Subject: [PATCH v1 3/4] svcrdma: Add common XDR decoders for RDMA and Read
 segments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:53:43 -0400
Message-ID: <20200629145343.15063.16512.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
References: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: De-duplicate some code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/rpc_rdma.h          |   37 ++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/frwr_ops.c           |    1 -
 net/sunrpc/xprtrdma/rpc_rdma.c           |    5 +---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    4 +--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |   37 +++++++++++++-----------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |    5 +---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 -
 7 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/include/linux/sunrpc/rpc_rdma.h b/include/linux/sunrpc/rpc_rdma.h
index 320c672d84de..db50380f64f4 100644
--- a/include/linux/sunrpc/rpc_rdma.h
+++ b/include/linux/sunrpc/rpc_rdma.h
@@ -124,4 +124,41 @@ rpcrdma_decode_buffer_size(u8 val)
 	return ((unsigned int)val + 1) << 10;
 }
 
+/**
+ * xdr_decode_rdma_segment - Decode contents of an RDMA segment
+ * @p: Pointer to the undecoded RDMA segment
+ * @handle: Upon return, the RDMA handle
+ * @length: Upon return, the RDMA length
+ * @offset: Upon return, the RDMA offset
+ *
+ * Return value:
+ *   Pointer to the XDR item that follows the RDMA segment
+ */
+static inline __be32 *xdr_decode_rdma_segment(__be32 *p, u32 *handle,
+					      u32 *length, u64 *offset)
+{
+	*handle = be32_to_cpup(p++);
+	*length = be32_to_cpup(p++);
+	return xdr_decode_hyper(p, offset);
+}
+
+/**
+ * xdr_decode_read_segment - Decode contents of a Read segment
+ * @p: Pointer to the undecoded Read segment
+ * @position: Upon return, the segment's position
+ * @handle: Upon return, the RDMA handle
+ * @length: Upon return, the RDMA length
+ * @offset: Upon return, the RDMA offset
+ *
+ * Return value:
+ *   Pointer to the XDR item that follows the Read segment
+ */
+static inline __be32 *xdr_decode_read_segment(__be32 *p, u32 *position,
+					      u32 *handle, u32 *length,
+					      u64 *offset)
+{
+	*position = be32_to_cpup(p++);
+	return xdr_decode_rdma_segment(p, handle, length, offset);
+}
+
 #endif				/* _LINUX_SUNRPC_RPC_RDMA_H */
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index b647562a26dd..7f94c9a19fd3 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -40,7 +40,6 @@
  * New MRs are created on demand.
  */
 
-#include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index feecd1f55f18..5461f01eeca6 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1176,10 +1176,7 @@ static int decode_rdma_segment(struct xdr_stream *xdr, u32 *length)
 	if (unlikely(!p))
 		return -EIO;
 
-	handle = be32_to_cpup(p++);
-	*length = be32_to_cpup(p++);
-	xdr_decode_hyper(p, &offset);
-
+	xdr_decode_rdma_segment(p, &handle, length, &offset);
 	trace_xprtrdma_decode_seg(handle, *length, offset);
 	return 0;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 5e78067889f3..c0587d3cd389 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -466,9 +466,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt, u32 maxlen)
 		if (!p)
 			return false;
 
-		handle = be32_to_cpup(p++);
-		length = be32_to_cpup(p++);
-		xdr_decode_hyper(p, &offset);
+		xdr_decode_rdma_segment(p, &handle, &length, &offset);
 		trace_svcrdma_decode_wseg(handle, length, offset);
 
 		total += length;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 83806fa94def..2038b1b286dd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -7,6 +7,7 @@
 
 #include <rdma/rw.h>
 
+#include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
 
@@ -441,34 +442,32 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	seg = info->wi_segs + info->wi_seg_no * rpcrdma_segment_maxsz;
 	do {
 		unsigned int write_len;
-		u32 seg_length, seg_handle;
-		u64 seg_offset;
+		u32 handle, length;
+		u64 offset;
 
 		if (info->wi_seg_no >= info->wi_nsegs)
 			goto out_overflow;
 
-		seg_handle = be32_to_cpup(seg);
-		seg_length = be32_to_cpup(seg + 1);
-		xdr_decode_hyper(seg + 2, &seg_offset);
-		seg_offset += info->wi_seg_off;
+		xdr_decode_rdma_segment(seg, &handle, &length, &offset);
+		offset += info->wi_seg_off;
 
-		write_len = min(remaining, seg_length - info->wi_seg_off);
+		write_len = min(remaining, length - info->wi_seg_off);
 		ctxt = svc_rdma_get_rw_ctxt(rdma,
 					    (write_len >> PAGE_SHIFT) + 2);
 		if (!ctxt)
 			return -ENOMEM;
 
 		constructor(info, write_len, ctxt);
-		ret = svc_rdma_rw_ctx_init(rdma, ctxt, seg_offset, seg_handle,
+		ret = svc_rdma_rw_ctx_init(rdma, ctxt, offset, handle,
 					   DMA_TO_DEVICE);
 		if (ret < 0)
 			return -EIO;
 
-		trace_svcrdma_send_wseg(seg_handle, write_len, seg_offset);
+		trace_svcrdma_send_wseg(handle, write_len, offset);
 
 		list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 		cc->cc_sqecount += ret;
-		if (write_len == seg_length - info->wi_seg_off) {
+		if (write_len == length - info->wi_seg_off) {
 			seg += 4;
 			info->wi_seg_no++;
 			info->wi_seg_off = 0;
@@ -689,21 +688,17 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 	ret = -EINVAL;
 	info->ri_chunklen = 0;
 	while (*p++ != xdr_zero && be32_to_cpup(p++) == info->ri_position) {
-		u32 rs_handle, rs_length;
-		u64 rs_offset;
+		u32 handle, length;
+		u64 offset;
 
-		rs_handle = be32_to_cpup(p++);
-		rs_length = be32_to_cpup(p++);
-		p = xdr_decode_hyper(p, &rs_offset);
-
-		ret = svc_rdma_build_read_segment(info, rqstp,
-						  rs_handle, rs_length,
-						  rs_offset);
+		p = xdr_decode_rdma_segment(p, &handle, &length, &offset);
+		ret = svc_rdma_build_read_segment(info, rqstp, handle, length,
+						  offset);
 		if (ret < 0)
 			break;
 
-		trace_svcrdma_send_rseg(rs_handle, rs_length, rs_offset);
-		info->ri_chunklen += rs_length;
+		trace_svcrdma_send_rseg(handle, length, offset);
+		info->ri_chunklen += length;
 	}
 
 	return ret;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f985f548346a..a78f1d22e9bb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -106,7 +106,6 @@
 #include <rdma/rdma_cm.h>
 
 #include <linux/sunrpc/debug.h>
-#include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"
@@ -375,9 +374,7 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
 	if (!p)
 		return -EMSGSIZE;
 
-	handle = be32_to_cpup(src++);
-	length = be32_to_cpup(src++);
-	xdr_decode_hyper(src, &offset);
+	xdr_decode_rdma_segment(src, &handle, &length, &offset);
 
 	*p++ = cpu_to_be32(handle);
 	if (*remaining < length) {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index d38be57b00ed..3da7901a49e6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -55,7 +55,6 @@
 
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/debug.h>
-#include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/svc_rdma.h>
 

