Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886732CF69B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLDWLw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 17:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDWLw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Dec 2020 17:11:52 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BBAC0613D1
        for <linux-nfs@vger.kernel.org>; Fri,  4 Dec 2020 14:11:12 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b9so5135616qtr.2
        for <linux-nfs@vger.kernel.org>; Fri, 04 Dec 2020 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7jXvn3NLvF4oZYrt/o6z2xKxZ08EByNdkeRX5tVdPOI=;
        b=tijrMz15RRoEN7CZGB5KJnl/PUAkN16r9gE9FOYEBiW1THVT+P+NDJY4f34ZzWiH1/
         6iaBoWYa+w+pe8JQMZEI3Avwr4Qyz3xn+ock0cIKzKsZuB/mkeZdk5VgtzNRPICF0d/k
         f/S2BmdoVy7VjhYrK7jD3mt3TRZrkCeqPbcJRizJ3OH1Qnqb7H1zg1CgOiEbCl49ko5i
         XLFoH/WTFy7vLwABvvi+tSqRuc9mVLAaWw+lNeTmds3DltxVx9s4xT7DS60KW2RBdc8U
         dAT0Nvv3uXuhqdwZVuRALMuhMqZw33GLWZ9YYACSlHTZ9xA1J0mm8lRD6h6/+ZttIEJQ
         IBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7jXvn3NLvF4oZYrt/o6z2xKxZ08EByNdkeRX5tVdPOI=;
        b=iBhVSzwyTTgR5tEDgcnGU/duxCkIO05gqZJaeDRYzWVzX1IBVOJykiWTdmKNvJxew4
         JdYHNgSNhuWarg9uvXYljxB066owm3K3izqmRMXz43+QbONZXAzf70Zfl6nPE6RrzJTJ
         Obcv+9qjAaTSvQQraAACv87SuaJhKo0eiiyZJtH675nr4PYt8WuXR2z5O6P+8Gcljj5I
         kmZ0ki0ucXSvGG54Xwvt7AR1Qcs84kqwe28I18QtSbKjyx0pgJ9sBYPyDbTM/AxdTsqy
         hxsTqxpprk+7ed87qvP7V9+4NlKp7Av4KZQMBNSUtkbCCbEEwh0pbWF7CMX4dcnSsdxP
         9Jsg==
X-Gm-Message-State: AOAM531U78VpE4MB8+Y5msxJHzqAk60TQobDEcm6jfUgiqnqj3FIpMtF
        Hnz1xofObbSBh3hzickFXd8=
X-Google-Smtp-Source: ABdhPJwnYhFvYfIgmWSJD2BUuvOU+FrqvFkFqu0mnWbN3NH+y7/ANb9btyZN//RHSDpEZojkREXSyw==
X-Received: by 2002:aed:2393:: with SMTP id j19mr11731722qtc.75.1607119871246;
        Fri, 04 Dec 2020 14:11:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a35sm1338662qtk.82.2020.12.04.14.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 14:11:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0B4MB8Is008024;
        Fri, 4 Dec 2020 22:11:08 GMT
Subject: [PATCH RFC] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com, fllinden@amazon.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 04 Dec 2020 17:11:08 -0500
Message-ID: <160711969521.12486.14622797339746381076.stgit@manet.1015granger.net>
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
enough to require a Reply chunk.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   41 +++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

Here's a stop-gap that can be back-ported to earlier kernels if needed.
Untested. Comments welcome.

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0f5120c7668f..09b7649fa112 100644
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
+static int
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


