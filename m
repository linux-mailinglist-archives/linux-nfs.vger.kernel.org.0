Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1231129E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 21:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBESwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 13:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233088AbhBEPEk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A87864E92;
        Fri,  5 Feb 2021 16:31:35 +0000 (UTC)
Subject: [PATCH v1] xprtrdma: Clean up rpcrdma_prepare_readch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 05 Feb 2021 11:31:34 -0500
Message-ID: <161254265485.1728.15776929905868209914.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 9ed5af268e88 ("SUNRPC: Clean up the handling of page
padding in rpc_prepare_reply_pages()") [Dec 2020] the NFS client
passes payload data to the transport with the padding in xdr->pages
instead of in the send buffer's tail kvec. There's no need for the
extra logic to advance the base of the tail kvec because the upper
layer no longer places XDR padding there.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

Hi Anna-

Found one more clean-up related to the series I sent yesterday.


diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 1c3e377272e0..292f066d006e 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -628,9 +628,8 @@ static bool rpcrdma_prepare_pagelist(struct rpcrdma_req *req,
 	return false;
 }
 
-/* The tail iovec may include an XDR pad for the page list,
- * as well as additional content, and may not reside in the
- * same page as the head iovec.
+/* The tail iovec might not reside in the same page as the
+ * head iovec.
  */
 static bool rpcrdma_prepare_tail_iov(struct rpcrdma_req *req,
 				     struct xdr_buf *xdr,
@@ -748,27 +747,19 @@ static bool rpcrdma_prepare_readch(struct rpcrdma_xprt *r_xprt,
 				   struct rpcrdma_req *req,
 				   struct xdr_buf *xdr)
 {
+	struct kvec *tail = &xdr->tail[0];
+
 	if (!rpcrdma_prepare_head_iov(r_xprt, req, xdr->head[0].iov_len))
 		return false;
 
-	/* If there is a Read chunk, the page list is being handled
+	/* If there is a Read chunk, the page list is handled
 	 * via explicit RDMA, and thus is skipped here.
 	 */
 
-	/* Do not include the tail if it is only an XDR pad */
-	if (xdr->tail[0].iov_len > 3) {
-		unsigned int page_base, len;
-
-		/* If the content in the page list is an odd length,
-		 * xdr_write_pages() adds a pad at the beginning of
-		 * the tail iovec. Force the tail's non-pad content to
-		 * land at the next XDR position in the Send message.
-		 */
-		page_base = offset_in_page(xdr->tail[0].iov_base);
-		len = xdr->tail[0].iov_len;
-		page_base += len & 3;
-		len -= len & 3;
-		if (!rpcrdma_prepare_tail_iov(req, xdr, page_base, len))
+	if (tail->iov_len) {
+		if (!rpcrdma_prepare_tail_iov(req, xdr,
+					      offset_in_page(tail->iov_base),
+					      tail->iov_len))
 			return false;
 		kref_get(&req->rl_kref);
 	}


