Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA742CFEC7
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Dec 2020 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLEUXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Dec 2020 15:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLEUXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Dec 2020 15:23:41 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A928AC0613D1
        for <linux-nfs@vger.kernel.org>; Sat,  5 Dec 2020 12:23:00 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so8937428qke.9
        for <linux-nfs@vger.kernel.org>; Sat, 05 Dec 2020 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CICdBTikk8E5TH9/5RmMKuOpZt/HAEwI6uLWeS5HKY4=;
        b=iFv6xgLX0LYCI/greMaIuZKDdGoarYkfxNd2OeQWsUIUTmM1F96+1y+VqwcqD8CCwN
         h6MoZgkkYOEQG9ojYTLEzdUKJ4FXCYr6/t1eju81a6DYZIh6BYNAzD0D+duVXtD+hXQh
         tZC32tW+l03WTwbGgI1bhsKMnirGpYHCK7apwoIVAwApJTwqpQRs+/nEhr57Ntc/JnBa
         1SODaHY89Xg+cF8ZXCGSxPfp6L+8/P1fmiugcHS2E/IPxFOpOc3oQ0HCZbVL1Vcv0lzt
         dP6U27MHtRiFzxXGk87wFflvKoGpax37yI4w6kaI8TgxXBz0/Be+KSIV4sMLA2w9du7M
         msMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CICdBTikk8E5TH9/5RmMKuOpZt/HAEwI6uLWeS5HKY4=;
        b=BOHqc2UnaNBjSlN5ikmVzjgHuHNfaZCGjzFSY8EnOK+4Dh9dUjRtHfoIK+v8PaUJHY
         Wox1MyRVdep6HsxRd8pE5CN/Jo4YH2hZOmf/1idMKBA+5CJevs6eEejymLIkzPu60olr
         GNKHsth1LHbQrL1h5pkyZR2BDnFqsZbnK1/bvSXHOarsJzgh247lki/JGiZZJi/zYPtM
         6M2rHFB3oBPeEQI3Pz6oHI/mI5/6b5o9Bai6ZCd1MZgm+BZuPCbPnur0VXQZa0am1+7N
         CzjhYpBzFOOuFCV979YfWc6AtBrahEVZpWdDgU/1+9vqh7gCtBfThdMhf0rjUuH6PoqU
         rxEQ==
X-Gm-Message-State: AOAM531pmorywoD5NstOHDrblTzrxLWe6k/uxPcOx9tdpgxbaSjg7nWT
        fy5/tIgvlIpXuuTECTmRGfYhZM2mIzw=
X-Google-Smtp-Source: ABdhPJzmUWT6JtlFdb6uUYsp8cUlZFVsQ16/VbqvVp2WhtNMd7hjn+zY8ppEAyjYSqUF7kZgIxq2QA==
X-Received: by 2002:a37:6242:: with SMTP id w63mr4870611qkb.490.1607199779522;
        Sat, 05 Dec 2020 12:22:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m54sm9799447qtc.29.2020.12.05.12.22.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 12:22:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0B5KMvP0010547
        for <linux-nfs@vger.kernel.org>; Sat, 5 Dec 2020 20:22:57 GMT
Subject: [PATCH 4] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 05 Dec 2020 15:22:57 -0500
Message-ID: <160719971621.32538.11224487886769737849.stgit@manet.1015granger.net>
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
 net/sunrpc/xdr.c               |    1 +
 net/sunrpc/xprtrdma/rpc_rdma.c |   41 +++++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

Changes since v3:
- I swear I am not drunk. I forgot to commit the change before mailing it.

Changes since v2:
- Actually fix the xdr_buf_pagecount() problem

Changes since RFC:
- Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
- noinline the sparse page allocator -- it's an uncommon path

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 71e03b930b70..878f4c4fec1a 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -141,6 +141,7 @@ xdr_buf_pagecount(struct xdr_buf *buf)
 		return 0;
 	return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(xdr_buf_pagecount);
 
 int
 xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0f5120c7668f..6c9a1810a70a 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -179,6 +179,32 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
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
@@ -233,15 +259,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
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
@@ -867,6 +884,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
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


