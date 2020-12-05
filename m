Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1A2CFC82
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Dec 2020 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbgLESW0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Dec 2020 13:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLESWU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Dec 2020 13:22:20 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D0C061A4F
        for <linux-nfs@vger.kernel.org>; Sat,  5 Dec 2020 10:21:40 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so6457624qtp.8
        for <linux-nfs@vger.kernel.org>; Sat, 05 Dec 2020 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eCKTPOfgG6AGFdHVAphaSYckh/Tp47VBhvzJKexr5zc=;
        b=NL3ArVNfgqHt73JMIksflJZQVhbJa8JLOrrggFuw3QvvbKhskt91FQ4md9fSfL4H7Q
         sIWWq7/rQRGSs9gASGP4S37M/0s8VWLMGGfQhEpXbv6vLd9EUUznTJoCMOjp9VhWUr1z
         FaThuOQ0cluzTTjRIRRKV0znL2YjSGIbFzQ47T9uwL4jTEbffQ9X5/yUp5HEJyfwr5Wx
         xHn9yivUCAYG/XzEHmxqXgOQMisNQ4SLtliuBaXTEE8UZhUFAYK9A5aAoqXJR3sVKdaa
         Ct1jxCFMB2nqlMApu11Y8oA2js6bdNbzBAArnzsLawVqigcLxL7xYIbncqaui69IIpwT
         fHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eCKTPOfgG6AGFdHVAphaSYckh/Tp47VBhvzJKexr5zc=;
        b=PPL9TLrs+voI62wH2zWlgjLNDw4DmjXgX9kI3rqpLub/I1o0c/+VVv0KE/fKNXKPz1
         70DgmLQuk8OR3byfg8UJKxQ1Cn2scwYMHhiysKKuIGMt93H3VFZ6aioNY19ATdESU8yq
         paZ1t5a2T1Qw8imKCf287nw3SPMyokg/d8R+wSR/icjmpzyiRFFp/9F7Jszufm6SwV3G
         p+8A2KMI+Qeg9kOIe35XdrSbck6q6YvCj4H0zXiyEmhf++kVcRvY3ai4b3vYcs2KCKGN
         vY14oBoVrLaYrSPlhRVhWcUCfb8AglS0JDy+6QrX82VG+v8Fo8b84CRdbggvHsrHsgdI
         ZwYw==
X-Gm-Message-State: AOAM533b0DpW0gnq3pN9BnYQA+S8ilpp3YGux61cXCtcflIJifhO72OH
        78LH8dHrkO8Lxc96sEJ7RO4=
X-Google-Smtp-Source: ABdhPJyXPZtn+J8GdBjchyWd8pbSH8GyakBzLj37HCjttzV6Qex4Kn6pBNXjISCDy8yDruDZ1v0e3w==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr15650923qto.104.1607192499898;
        Sat, 05 Dec 2020 10:21:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p62sm8623524qkf.50.2020.12.05.10.21.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 10:21:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0B5ILZfi010353;
        Sat, 5 Dec 2020 18:21:36 GMT
Subject: [PATCH 2] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com, fllinden@amazon.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 05 Dec 2020 13:21:35 -0500
Message-ID: <160719245638.15161.12213610638492684869.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
only when it has determined that a Reply chunk is necessary. There
are plenty of cases where no Reply chunk is needed, but the
XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
rpcrdma_inline_fixup() when it tries to copy parts of the received
Reply into a missing page.

To avoid crashing, handle sparse page allocation up front.

Until XATTR support was added, this issue did not appear often
because the only SPARSE_PAGES consumer always expected a reply large
enough to always require a Reply chunk.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   42 +++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

Changes since RFC:
- Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
- noinline the sparse page allocator -- it's an uncommon path

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0f5120c7668f..3ce7dcce5fb9 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -49,6 +49,7 @@
 
 #include <linux/highmem.h>
 
+#include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"
@@ -179,6 +180,32 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
 		r_xprt->rx_ep->re_max_inline_recv;
 }
 
+/* ACL likes to be lazy in allocating pages. For TCP, these
+ * pages can be allocated during receive processing. Not true
+ * for RDMA, which must always provision receive buffers
+ * up front.
+ */
+static noinline int
+rpcrdma_alloc_sparse_pages(struct rpc_rqst *rqst)
+{
+	struct xdr_buf *xb = &rqst->rq_rcv_buf;
+	struct page **ppages;
+	int len;
+
+	len = xb->page_len;
+	ppages = xb->pages + xdr_buf_pagecount(xb);
+	while (len > 0) {
+		if (!*ppages)
+			*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
+		if (!*ppages)
+			return -ENOBUFS;
+		ppages++;
+		len -= PAGE_SIZE;
+	}
+
+	return 0;
+}
+
 /* Split @vec on page boundaries into SGEs. FMR registers pages, not
  * a byte range. Other modes coalesce these SGEs into a single MR
  * when they can.
@@ -233,15 +260,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 	ppages = xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
 	page_base = offset_in_page(xdrbuf->page_base);
 	while (len) {
-		/* ACL likes to be lazy in allocating pages - ACLs
-		 * are small by default but can get huge.
-		 */
-		if (unlikely(xdrbuf->flags & XDRBUF_SPARSE_PAGES)) {
-			if (!*ppages)
-				*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
-			if (!*ppages)
-				return -ENOBUFS;
-		}
 		seg->mr_page = *ppages;
 		seg->mr_offset = (char *)page_base;
 		seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
@@ -867,6 +885,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
 	__be32 *p;
 	int ret;
 
+	if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
+		ret = rpcrdma_alloc_sparse_pages(rqst);
+		if (ret)
+			return ret;
+	}
+
 	rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
 	xdr_init_encode(xdr, &req->rl_hdrbuf, rdmab_data(req->rl_rdmabuf),
 			rqst);


