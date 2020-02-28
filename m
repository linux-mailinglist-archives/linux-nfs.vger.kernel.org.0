Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B529172D5E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgB1Ab6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Ab6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id l7so738179pff.6;
        Thu, 27 Feb 2020 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SNn9dgUZJq1qDJ3pMC89zXA5DX6KAQg/f61MzZyr0zo=;
        b=RXiENqS8FNFInUsHXe4bjX4hGQ9oDgmdIHanQjF0oMwtWbiyt8riBQWLFlB8XD1Xjg
         b5aCBOiCjt8WfoYHMbWhDwQnr1oHvXttGoF4CSmW/1YYnZ8IZXsFiIvLdke0wV3MPD5c
         C61MueJDOGpn2AneF3htSttNYeif4MHwBEloCoIngkdVY2fzb0dDrLCwlKKl5XuFbGj5
         MQRx1mnvM3/E9I/qb3qINvbXSR3yRDAxl0N+8k6RCwF1NvO8Re4mbPwXqjwVIJBZKmzO
         Ty4EsEbdQniRuhmqtFlAKjwv8RbzvyJUejWyW9W1742kSxXI7kJLahIbPfaOVUGf5Vas
         mGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SNn9dgUZJq1qDJ3pMC89zXA5DX6KAQg/f61MzZyr0zo=;
        b=f+nKGBUljMP8tWYOQQj6yhQ8bVZ0zsT6AOJYZjqCCpxlfx5Xci7WbUrAS67m9PpS5l
         sJsQB1ip/93qBqjeWpiLzNVUS6zEw/hqXASkPEdOVs2ih2lawlDQORo8zYJMIcALfIrW
         ZEwBQbtIaHVaEpHf4GiMLCu9rmYB2a1p71LT5MvB+aodaMmtUHgDC8vo0xmRgUEhiRQ0
         Tn0fOrcr1O83hhxz9W+0zERfUecNrujZfqx8PbC7jsWtwc3LIlFm98EAH02MDFuzQNWL
         1C1rWNursn2uU4br7fBk4l4Wj62E70Yj2FKzp3Yr8WUgNix/vWwHIW+5vNdGvZWKOnQU
         0C1g==
X-Gm-Message-State: APjAAAV6f76asplz3cJaSrp1a9yQUQx+n4DylTpCNrwOK63p9IcdYcLz
        sbRIXIHgyPNUR+DHwt7+Wtb0+bjfKRg=
X-Google-Smtp-Source: APXvYqz/NKi0xqTJHP53z8MSNzfIZAnG6VoH0BDMNJrdzvTjM8MaJ8Q88ExKrOXNCoMLTPffGQHl/w==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr1675922pfq.157.1582849917021;
        Thu, 27 Feb 2020 16:31:57 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id k1sm6342250pgt.70.2020.02.27.16.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:56 -0800 (PST)
Subject: [PATCH v1 13/16] SUNRPC: Add encoders for list item discriminators
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:55 -0500
Message-ID: <158284991530.38468.7171819678223366860.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. These are taken from the client-side RPC/RDMA transport
to a more global header file so they can be used elsewhere.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h     |   38 ++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c |   36 +++++-------------------------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 80972512edfd..cddfab4a5440 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -316,6 +316,44 @@ xdr_pad_size(size_t n)
 	return xdr_align_size(n) - n;
 }
 
+/**
+ * xdr_stream_encode_item_present - Encode a "present" list item
+ * @xdr: pointer to xdr_stream
+ *
+ * Return values:
+ *   On success, returns length in bytes of XDR buffer consumed
+ *   %-EMSGSIZE on XDR buffer overflow
+ */
+static inline ssize_t xdr_stream_encode_item_present(struct xdr_stream *xdr)
+{
+	const size_t len = sizeof(__be32);
+	__be32 *p = xdr_reserve_space(xdr, len);
+
+	if (unlikely(!p))
+		return -EMSGSIZE;
+	*p = xdr_one;
+	return len;
+}
+
+/**
+ * xdr_stream_encode_item_absent - Encode a "not present" list item
+ * @xdr: pointer to xdr_stream
+ *
+ * Return values:
+ *   On success, returns length in bytes of XDR buffer consumed
+ *   %-EMSGSIZE on XDR buffer overflow
+ */
+static inline int xdr_stream_encode_item_absent(struct xdr_stream *xdr)
+{
+	const size_t len = sizeof(__be32);
+	__be32 *p = xdr_reserve_space(xdr, len);
+
+	if (unlikely(!p))
+		return -EMSGSIZE;
+	*p = xdr_zero;
+	return len;
+}
+
 /**
  * xdr_stream_encode_u32 - Encode a 32-bit integer
  * @xdr: pointer to xdr_stream
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index b51e92d43dfd..737a54c3ad53 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -275,32 +275,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 	return n;
 }
 
-static inline int
-encode_item_present(struct xdr_stream *xdr)
-{
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, sizeof(*p));
-	if (unlikely(!p))
-		return -EMSGSIZE;
-
-	*p = xdr_one;
-	return 0;
-}
-
-static inline int
-encode_item_not_present(struct xdr_stream *xdr)
-{
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, sizeof(*p));
-	if (unlikely(!p))
-		return -EMSGSIZE;
-
-	*p = xdr_zero;
-	return 0;
-}
-
 static void
 xdr_encode_rdma_segment(__be32 *iptr, struct rpcrdma_mr *mr)
 {
@@ -414,7 +388,7 @@ static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
 	} while (nsegs);
 
 done:
-	return encode_item_not_present(xdr);
+	return xdr_stream_encode_item_absent(xdr);
 }
 
 /* Register and XDR encode the Write list. Supports encoding a list
@@ -453,7 +427,7 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 	if (nsegs < 0)
 		return nsegs;
 
-	if (encode_item_present(xdr) < 0)
+	if (xdr_stream_encode_item_present(xdr) < 0)
 		return -EMSGSIZE;
 	segcount = xdr_reserve_space(xdr, sizeof(*segcount));
 	if (unlikely(!segcount))
@@ -480,7 +454,7 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 	*segcount = cpu_to_be32(nchunks);
 
 done:
-	return encode_item_not_present(xdr);
+	return xdr_stream_encode_item_absent(xdr);
 }
 
 /* Register and XDR encode the Reply chunk. Supports encoding an array
@@ -507,14 +481,14 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 	__be32 *segcount;
 
 	if (wtype != rpcrdma_replych)
-		return encode_item_not_present(xdr);
+		return xdr_stream_encode_item_absent(xdr);
 
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf, 0, wtype, seg);
 	if (nsegs < 0)
 		return nsegs;
 
-	if (encode_item_present(xdr) < 0)
+	if (xdr_stream_encode_item_present(xdr) < 0)
 		return -EMSGSIZE;
 	segcount = xdr_reserve_space(xdr, sizeof(*segcount));
 	if (unlikely(!segcount))

