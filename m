Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D493530E3C8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhBCUHm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 15:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBCUHi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A2B064F78;
        Wed,  3 Feb 2021 20:06:57 +0000 (UTC)
Subject: [PATCH v3 2/6] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 15:06:56 -0500
Message-ID: <161238281675.946943.12167039416039771883.stgit@manet.1015granger.net>
In-Reply-To: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
References: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Remove a conditional branch from the SGL set-up loop in frwr_map():
Instead of using either sg_set_page() or sg_set_buf(), initialize
the mr_page field properly when rpcrdma_convert_kvec() converts the
kvec to an SGL entry. frwr_map() can then invoke sg_set_page()
unconditionally.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   12 ++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |    9 +++++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index baca49fe83af..13a50f77dddb 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -306,14 +306,10 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	if (nsegs > ep->re_max_fr_depth)
 		nsegs = ep->re_max_fr_depth;
 	for (i = 0; i < nsegs;) {
-		if (seg->mr_page)
-			sg_set_page(&mr->mr_sg[i],
-				    seg->mr_page,
-				    seg->mr_len,
-				    offset_in_page(seg->mr_offset));
-		else
-			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
-				   seg->mr_len);
+		sg_set_page(&mr->mr_sg[i],
+			    seg->mr_page,
+			    seg->mr_len,
+			    offset_in_page(seg->mr_offset));
 
 		++seg;
 		++i;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 76ae5885815d..7b10efeee29f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -213,7 +213,7 @@ static struct rpcrdma_mr_seg *
 rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
 		     unsigned int *n)
 {
-	seg->mr_page = NULL;
+	seg->mr_page = virt_to_page(vec->iov_base);
 	seg->mr_offset = vec->iov_base;
 	seg->mr_len = vec->iov_len;
 	++seg;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 94b28657aeeb..02971e183989 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -283,10 +283,11 @@ enum {
 				  RPCRDMA_MAX_IOV_SEGS,
 };
 
-struct rpcrdma_mr_seg {		/* chunk descriptors */
-	u32		mr_len;		/* length of chunk or segment */
-	struct page	*mr_page;	/* owning page, if any */
-	char		*mr_offset;	/* kva if no page, else offset */
+/* Arguments for DMA mapping and registration */
+struct rpcrdma_mr_seg {
+	u32		mr_len;		/* length of segment */
+	struct page	*mr_page;	/* underlying struct page */
+	char		*mr_offset;	/* IN: page offset, OUT: iova */
 };
 
 /* The Send SGE array is provisioned to send a maximum size


