Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1979130DFA2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhBCQYw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBCQYt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 11:24:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D920264F86;
        Wed,  3 Feb 2021 16:24:07 +0000 (UTC)
Subject: [PATCH v2 3/6] xprtrdma: Refactor invocations of offset_in_page()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:24:07 -0500
Message-ID: <161236944700.1030487.6859398915626711523.stgit@manet.1015granger.net>
In-Reply-To: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up so that offset_in_page() is invoked less often in the
most common case, which is mapping xdr->pages.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    8 +++-----
 net/sunrpc/xprtrdma/rpc_rdma.c  |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 13a50f77dddb..766a1048a48a 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -306,16 +306,14 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	if (nsegs > ep->re_max_fr_depth)
 		nsegs = ep->re_max_fr_depth;
 	for (i = 0; i < nsegs;) {
-		sg_set_page(&mr->mr_sg[i],
-			    seg->mr_page,
-			    seg->mr_len,
-			    offset_in_page(seg->mr_offset));
+		sg_set_page(&mr->mr_sg[i], seg->mr_page,
+			    seg->mr_len, seg->mr_offset);
 
 		++seg;
 		++i;
 		if (ep->re_mrtype == IB_MR_TYPE_SG_GAPS)
 			continue;
-		if ((i < nsegs && offset_in_page(seg->mr_offset)) ||
+		if ((i < nsegs && seg->mr_offset) ||
 		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
 			break;
 	}
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 529adb6ad4db..b3e66b8f65ab 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -215,7 +215,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
 {
 	if (vec->iov_len) {
 		seg->mr_page = virt_to_page(vec->iov_base);
-		seg->mr_offset = vec->iov_base;
+		seg->mr_offset = offset_in_page(vec->iov_base);
 		seg->mr_len = vec->iov_len;
 		++seg;
 		++(*n);
@@ -248,7 +248,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 	page_base = offset_in_page(xdrbuf->page_base);
 	while (len) {
 		seg->mr_page = *ppages;
-		seg->mr_offset = (char *)page_base;
+		seg->mr_offset = page_base;
 		seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
 		len -= seg->mr_len;
 		++ppages;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 02971e183989..ed1c5444fb9d 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -287,7 +287,7 @@ enum {
 struct rpcrdma_mr_seg {
 	u32		mr_len;		/* length of segment */
 	struct page	*mr_page;	/* underlying struct page */
-	char		*mr_offset;	/* IN: page offset, OUT: iova */
+	u64		mr_offset;	/* IN: page offset, OUT: iova */
 };
 
 /* The Send SGE array is provisioned to send a maximum size


