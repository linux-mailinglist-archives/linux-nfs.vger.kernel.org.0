Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1715230DFA0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhBCQYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBCQYm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 11:24:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9149A64F84;
        Wed,  3 Feb 2021 16:24:01 +0000 (UTC)
Subject: [PATCH v2 2/6] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:24:00 -0500
Message-ID: <161236944071.1030487.460353530274045763.stgit@manet.1015granger.net>
In-Reply-To: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
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
index 832765f3ebba..529adb6ad4db 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -214,7 +214,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
 		     unsigned int *n)
 {
 	if (vec->iov_len) {
-		seg->mr_page = NULL;
+		seg->mr_page = virt_to_page(vec->iov_base);
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


