Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0F2CFEC5
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Dec 2020 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLEUV5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Dec 2020 15:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEUV4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Dec 2020 15:21:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87EC0613D1
        for <linux-nfs@vger.kernel.org>; Sat,  5 Dec 2020 12:21:09 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 19so1366603qkm.8
        for <linux-nfs@vger.kernel.org>; Sat, 05 Dec 2020 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sQa+cPfviU14/dlxA5PFqpKRRsYsq62sLTCfHUMNdcI=;
        b=QJ3ZYNSc0ickaUS9Sfdg3VAVgnbe7fyG/cwYX2XDa+GARgR1Y+grxwvfhkqqujlFsa
         021c9v2wRk41Y4mF6m3XQ9KUvxFLhYkM5MIH7yqvhyF/LfeOnmbf/QZFPeIzwJyVDCGC
         xjDOIXKrH2MeC2ZNc6A3zfbCHntCL1ivdJLUk/k5OOvWzu25/UvlvAbD9kS1JDibk8hk
         VcasPMUn/z47R1x1LxKX5kG3zBunzFd+Utvg4Nx+sDYW1PrATiXXJUHoaoJXLWx/eTKd
         7CKY66o+MSWEbX4mP+8iKmtIFz3PHCcHj7YExd9SsyX5yJ1NGqZ14yFZVeA63cgEwXfr
         YQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sQa+cPfviU14/dlxA5PFqpKRRsYsq62sLTCfHUMNdcI=;
        b=RpoMXKzVvhFyVAe7bgquf9WII1YF7Ut/qHkewlo9g6x2JysEmG2HrroGpGK6Cgqole
         hnVpwGfIDRUwEEfnnd7VHr+VTXbqXXVSOoVD0cQyvMMD7XzGz8wgolHG9OYGuwJi6j1w
         pXkTptBnGNTXLhYrLJsNZLr2tCREbjFsuwz+Hh6/W51L7vHtzKlPGGfDTgltKqQcZJwH
         3/ff/6gOrZ4hXizzf/vKEicRaQjhtdXGrQx7OR+1b2XODmwFUA9BQM3eFYGQ67pRbtQH
         QnYVTuUCA3OFwsCtq9LDoY1mffht4FG8LmwUMssYoATiJe6b5a2Ia4ZC7YtQdoiwqyDi
         hShA==
X-Gm-Message-State: AOAM53118aOEhfUkuO8BTXLWYEP4lstiUq+/fdvyzv02cNR8bgJ+4Z93
        TIfiVnv42Z4eLO9vDfJWBJmFxMy85/s=
X-Google-Smtp-Source: ABdhPJz1CHtSpD4PUalLs4VYiqtvtrzp7LQV3/l9lImLamAoM9cPoPdMlc+4AeZEWqEqsWdFV9Boeg==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr16807809qka.190.1607199668789;
        Sat, 05 Dec 2020 12:21:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s134sm9700620qke.99.2020.12.05.12.21.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 12:21:07 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0B5KL6Zu010544
        for <linux-nfs@vger.kernel.org>; Sat, 5 Dec 2020 20:21:06 GMT
Subject: [PATCH 3] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 05 Dec 2020 15:21:06 -0500
Message-ID: <160719962208.32424.3107134914715206238.stgit@manet.1015granger.net>
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

Changes since v2:
- Actually fix the xdr_buf_pagecount() problem

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


