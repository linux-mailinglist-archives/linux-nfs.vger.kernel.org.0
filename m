Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5206720D8F0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgF2Tm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbgF2Tmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F314C02F022;
        Mon, 29 Jun 2020 07:53:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so12980309qke.9;
        Mon, 29 Jun 2020 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9W486G6MOwvs86RPa64GieAuupAr7TMSvF/6Xm7uZYA=;
        b=U9y8P0PjrZHvDrF+SYvNX6bN96B+EmQOrR70qQ5Xigjcot7zfeS831aUnHZgQfcNZN
         Ge2+oGujuptj2ok4rtPfYFRxR73L9HWpQCmJz2ysQ0YGguhWfZutWM1yc7KGsSDc1Pyh
         UdzeKcy3NOmtcB5mNPiAZlBLtTO53NIoTKvIuDOdYo02rAGxOcD14290SQGu4HJNAqha
         t+h43W7ERQm4X2WSwwUxwVO6scMoXDH0KkUH4ieX1KkV5z22bAQd4IYM1cy6f8+RfjTz
         h6q7L3CQq/pLriZH/hM/FvD0BtYjscnD+1kDyQMvz9WSprkoWMgqog+bluWTrWlOPc46
         cOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9W486G6MOwvs86RPa64GieAuupAr7TMSvF/6Xm7uZYA=;
        b=XImRoI6PyKX7xcRJMJYrv246XY/I+bnf328VfnWdUS8KE4zGmBDWLQESePax88JftR
         Ymom+6fPrlLgApzsHCJEOh4ow/OMTgiTyS+Ftrn5JYtXb3ENzFGQqZdahobZ704iUT7g
         WXL0gGp7t5nkBqeWlaIAb2eiFJVzcOB9ABBYt2I7sI13NiSJV8wRHaTJuhfTRvH6Hv4N
         Zw5iDFn1WfiTPnc9Gg/E5N9oCu7ComHh3ebEoUtzmWJdLUo/n5eQtxQum/J+zYg7YDc0
         UbWj7YqOW1wPLiZ/+lpgbVRP+wl3nYph/5LJtbEVO+/W34zu6Axx76C42CShIIb0Bldf
         Wm6g==
X-Gm-Message-State: AOAM5323T7r57sajrWz7o7dLlqzqfvRdQKiLhUDAaooQ4XgrBeK0wVLC
        Z1M7k+4jIBXAdRUWqkcu6Nqi1htz
X-Google-Smtp-Source: ABdhPJxFOcS6VDNYCR874AYGDql/V7/z5f77C2UK3XVXpBngZQomXj9/wyTdqKhgUHMJ+Dwcks5uLA==
X-Received: by 2002:ae9:e8c7:: with SMTP id a190mr15348499qkg.94.1593442430346;
        Mon, 29 Jun 2020 07:53:50 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 73sm53346qkk.38.2020.06.29.07.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:53:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TErnZi006233;
        Mon, 29 Jun 2020 14:53:49 GMT
Subject: [PATCH v1 4/4] svcrdma: Add common XDR encoders for RDMA and Read
 segments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:53:49 -0400
Message-ID: <20200629145349.15063.39304.stgit@klimt.1015granger.net>
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
 include/linux/sunrpc/rpc_rdma.h       |   37 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c        |   14 +++---------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 +---
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/linux/sunrpc/rpc_rdma.h b/include/linux/sunrpc/rpc_rdma.h
index db50380f64f4..4af31bbc8802 100644
--- a/include/linux/sunrpc/rpc_rdma.h
+++ b/include/linux/sunrpc/rpc_rdma.h
@@ -124,6 +124,43 @@ rpcrdma_decode_buffer_size(u8 val)
 	return ((unsigned int)val + 1) << 10;
 }
 
+/**
+ * xdr_encode_rdma_segment - Encode contents of an RDMA segment
+ * @p: Pointer into a send buffer
+ * @handle: The RDMA handle to encode
+ * @length: The RDMA length to encode
+ * @offset: The RDMA offset to encode
+ *
+ * Return value:
+ *   Pointer to the XDR position that follows the encoded RDMA segment
+ */
+static inline __be32 *xdr_encode_rdma_segment(__be32 *p, u32 handle,
+					      u32 length, u64 offset)
+{
+	*p++ = cpu_to_be32(handle);
+	*p++ = cpu_to_be32(length);
+	return xdr_encode_hyper(p, offset);
+}
+
+/**
+ * xdr_encode_read_segment - Encode contents of a Read segment
+ * @p: Pointer into a send buffer
+ * @position: The position to encode
+ * @handle: The RDMA handle to encode
+ * @length: The RDMA length to encode
+ * @offset: The RDMA offset to encode
+ *
+ * Return value:
+ *   Pointer to the XDR position that follows the encoded Read segment
+ */
+static inline __be32 *xdr_encode_read_segment(__be32 *p, u32 position,
+					      u32 handle, u32 length,
+					      u64 offset)
+{
+	*p++ = cpu_to_be32(position);
+	return xdr_encode_rdma_segment(p, handle, length, offset);
+}
+
 /**
  * xdr_decode_rdma_segment - Decode contents of an RDMA segment
  * @p: Pointer to the undecoded RDMA segment
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 5461f01eeca6..73ed51893175 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -275,14 +275,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 	return n;
 }
 
-static void
-xdr_encode_rdma_segment(__be32 *iptr, struct rpcrdma_mr *mr)
-{
-	*iptr++ = cpu_to_be32(mr->mr_handle);
-	*iptr++ = cpu_to_be32(mr->mr_length);
-	xdr_encode_hyper(iptr, mr->mr_offset);
-}
-
 static int
 encode_rdma_segment(struct xdr_stream *xdr, struct rpcrdma_mr *mr)
 {
@@ -292,7 +284,7 @@ encode_rdma_segment(struct xdr_stream *xdr, struct rpcrdma_mr *mr)
 	if (unlikely(!p))
 		return -EMSGSIZE;
 
-	xdr_encode_rdma_segment(p, mr);
+	xdr_encode_rdma_segment(p, mr->mr_handle, mr->mr_length, mr->mr_offset);
 	return 0;
 }
 
@@ -307,8 +299,8 @@ encode_read_segment(struct xdr_stream *xdr, struct rpcrdma_mr *mr,
 		return -EMSGSIZE;
 
 	*p++ = xdr_one;			/* Item present */
-	*p++ = cpu_to_be32(position);
-	xdr_encode_rdma_segment(p, mr);
+	xdr_encode_read_segment(p, position, mr->mr_handle, mr->mr_length,
+				mr->mr_offset);
 	return 0;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a78f1d22e9bb..38d8f0ee35ec 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -376,7 +376,6 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
 
 	xdr_decode_rdma_segment(src, &handle, &length, &offset);
 
-	*p++ = cpu_to_be32(handle);
 	if (*remaining < length) {
 		/* segment only partly filled */
 		length = *remaining;
@@ -385,8 +384,7 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
 		/* entire segment was consumed */
 		*remaining -= length;
 	}
-	*p++ = cpu_to_be32(length);
-	xdr_encode_hyper(p, offset);
+	xdr_encode_rdma_segment(p, handle, length, offset);
 
 	trace_svcrdma_encode_wseg(handle, length, offset);
 	return len;

