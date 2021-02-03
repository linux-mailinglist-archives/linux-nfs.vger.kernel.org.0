Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FF30E3CD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBCUHp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 15:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBCUHp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A74664F84;
        Wed,  3 Feb 2021 20:07:04 +0000 (UTC)
Subject: [PATCH v3 3/6] xprtrdma: Refactor invocations of offset_in_page()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 15:07:03 -0500
Message-ID: <161238282305.946943.10855776878676219069.stgit@manet.1015granger.net>
In-Reply-To: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
References: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
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
Reviewed-by: Tom Talpey <tom@talpey.com>
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
index 7b10efeee29f..d9ed6d04be10 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -214,7 +214,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
 		     unsigned int *n)
 {
 	seg->mr_page = virt_to_page(vec->iov_base);
-	seg->mr_offset = vec->iov_base;
+	seg->mr_offset = offset_in_page(vec->iov_base);
 	seg->mr_len = vec->iov_len;
 	++seg;
 	++(*n);
@@ -246,7 +246,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
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


