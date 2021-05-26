Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3113920FC
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhEZTgx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 15:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhEZTgx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 May 2021 15:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AEDB613CD;
        Wed, 26 May 2021 19:35:21 +0000 (UTC)
Subject: [PATCH v1] xprtrdma: Revert 586a0787ce35
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 26 May 2021 15:35:20 -0400
Message-ID: <162205747766.515075.15998908898996547188.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 9ed5af268e88 ("SUNRPC: Clean up the handling of page padding
in rpc_prepare_reply_pages()") [Dec 2020] affects RPC Replies that
have a data payload (i.e., Write chunks).

rpcrdma_prepare_readch(), as its name suggests, sets up Read chunks
which are data payloads within RPC Calls. Those payloads are
constructed by xdr_write_pages(), which continues to stuff the call
buffer's tail kvec with the payload's XDR roundup. Thus removing
the tail buffer logic in rpcrdma_prepare_readch() was the wrong
thing to do.

Fixes: 586a0787ce35 ("xprtrdma: Clean up rpcrdma_prepare_readch()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

I'm not sure how this got by initial testing. However, the issue came
up when I started testing internally against Solaris NFS servers.


diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 649f7d8b9733..c335c1361564 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -628,8 +628,9 @@ static bool rpcrdma_prepare_pagelist(struct rpcrdma_req *req,
 	return false;
 }
 
-/* The tail iovec might not reside in the same page as the
- * head iovec.
+/* The tail iovec may include an XDR pad for the page list,
+ * as well as additional content, and may not reside in the
+ * same page as the head iovec.
  */
 static bool rpcrdma_prepare_tail_iov(struct rpcrdma_req *req,
 				     struct xdr_buf *xdr,
@@ -747,19 +748,27 @@ static bool rpcrdma_prepare_readch(struct rpcrdma_xprt *r_xprt,
 				   struct rpcrdma_req *req,
 				   struct xdr_buf *xdr)
 {
-	struct kvec *tail = &xdr->tail[0];
-
 	if (!rpcrdma_prepare_head_iov(r_xprt, req, xdr->head[0].iov_len))
 		return false;
 
-	/* If there is a Read chunk, the page list is handled
+	/* If there is a Read chunk, the page list is being handled
 	 * via explicit RDMA, and thus is skipped here.
 	 */
 
-	if (tail->iov_len) {
-		if (!rpcrdma_prepare_tail_iov(req, xdr,
-					      offset_in_page(tail->iov_base),
-					      tail->iov_len))
+	/* Do not include the tail if it is only an XDR pad */
+	if (xdr->tail[0].iov_len > 3) {
+		unsigned int page_base, len;
+
+		/* If the content in the page list is an odd length,
+		 * xdr_write_pages() adds a pad at the beginning of
+		 * the tail iovec. Force the tail's non-pad content to
+		 * land at the next XDR position in the Send message.
+		 */
+		page_base = offset_in_page(xdr->tail[0].iov_base);
+		len = xdr->tail[0].iov_len;
+		page_base += len & 3;
+		len -= len & 3;
+		if (!rpcrdma_prepare_tail_iov(req, xdr, page_base, len))
 			return false;
 		kref_get(&req->rl_kref);
 	}


