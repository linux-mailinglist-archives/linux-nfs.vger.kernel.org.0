Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED16E30DF92
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBCQVJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhBCQVJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 11:21:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 172E164E06;
        Wed,  3 Feb 2021 16:20:28 +0000 (UTC)
Subject: [PATCH v2 1/6] xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:20:27 -0500
Message-ID: <161236922720.1030469.710332262819343933.stgit@manet.1015granger.net>
In-Reply-To: <161236921379.1030469.17739946617932155431.stgit@manet.1015granger.net>
References: <161236921379.1030469.17739946617932155431.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
Remove support for FMR memory registration") [Dec 2018]. That means
the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
on page boundaries") [Mar 2016], is no longer necessary. FRWR
memory registration handles this case with aplomb.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 8f5d0cb68360..832765f3ebba 100644
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
+	if (vec->iov_len) {
 		seg->mr_page = NULL;
-		seg->mr_offset = base;
-		seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
-		remaining -= seg->mr_len;
-		base += seg->mr_len;
+		seg->mr_offset = vec->iov_base;
+		seg->mr_len = vec->iov_len;
 		++seg;
 		++(*n);
-		page_offset = 0;
 	}
 	return seg;
 }


