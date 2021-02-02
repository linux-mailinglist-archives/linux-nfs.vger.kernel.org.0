Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D630C23D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 15:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhBBOpa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 09:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234431AbhBBOn3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Feb 2021 09:43:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C38A864F49;
        Tue,  2 Feb 2021 14:42:48 +0000 (UTC)
Subject: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 02 Feb 2021 09:42:47 -0500
Message-ID: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
Remove support for FMR memory registration") [Dec 2018]. That means
the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
on page boundaries") [Mar 2016], is no longer necessary. FRWR
memory registration handles this case with aplomb.

A related simplification removes an extra conditional branch from
the SGL set-up loop in frwr_map(): Instead of using either
sg_set_page() or sg_set_buf(), initialize the mr_page field properly
when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
frwr_map() can then invoke sg_set_page() unconditionally.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
 net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index baca49fe83af..5eb044a5f0be 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
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
+		sg_set_page(&mr->mr_sg[i], seg->mr_page,
+			    seg->mr_len, offset_in_page(seg->mr_offset));
 
 		++seg;
 		++i;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 8f5d0cb68360..529adb6ad4db 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
 	return 0;
 }
 
-/* Split @vec on page boundaries into SGEs. FMR registers pages, not
- * a byte range. Other modes coalesce these SGEs into a single MR
- * when they can.
+/* Convert @vec to a single SGL element.
  *
  * Returns pointer to next available SGE, and bumps the total number
  * of SGEs consumed.
@@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
 rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
 		     unsigned int *n)
 {
-	u32 remaining, page_offset;
-	char *base;
-
-	base = vec->iov_base;
-	page_offset = offset_in_page(base);
-	remaining = vec->iov_len;
-	while (remaining) {
-		seg->mr_page = NULL;
-		seg->mr_offset = base;
-		seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
-		remaining -= seg->mr_len;
-		base += seg->mr_len;
+	if (vec->iov_len) {
+		seg->mr_page = virt_to_page(vec->iov_base);
+		seg->mr_offset = vec->iov_base;
+		seg->mr_len = vec->iov_len;
 		++seg;
 		++(*n);
-		page_offset = 0;
 	}
 	return seg;
 }
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 94b28657aeeb..4a9fe6592795 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -285,7 +285,7 @@ enum {
 
 struct rpcrdma_mr_seg {		/* chunk descriptors */
 	u32		mr_len;		/* length of chunk or segment */
-	struct page	*mr_page;	/* owning page, if any */
+	struct page	*mr_page;	/* underlying struct page */
 	char		*mr_offset;	/* kva if no page, else offset */
 };
 


