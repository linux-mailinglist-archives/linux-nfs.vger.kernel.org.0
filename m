Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3B35454D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbhDEQfb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 12:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242432AbhDEQfb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Apr 2021 12:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B392D61398;
        Mon,  5 Apr 2021 16:35:24 +0000 (UTC)
Subject: [PATCH v1 6/6] xprtrdma: Avoid Send Queue wrapping
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 05 Apr 2021 12:35:24 -0400
Message-ID: <161764052395.29855.5602569735350576645.stgit@manet.1015granger.net>
In-Reply-To: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
References: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Send WRs can be signalled or unsignalled. A signalled Send WR
always has a matching Send completion, while a unsignalled Send
has a completion only if the Send WR fails.

xprtrdma has a Send account mechanism that is designed to reduce
the number of signalled Send WRs. This in turn mitigates the
interrupt rate of the underlying device.

RDMA consumers can't leave all Sends unsignaled, however, because
providers rely on Send completions to maintain their Send Queue head
and tail pointers. xprtrdma counts the number of unsignaled Send WRs
that have been posted to ensure that Sends are signalled often
enough to prevent the Send Queue from wrapping.

This mechanism neglected to account for FastReg WRs, which are
posted on the Send Queue but never signalled. As a result, the
Send Queue wrapped on occasion, resulting in duplication completions
of FastReg and LocalInv WRs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |   17 +++++++++++++++--
 net/sunrpc/xprtrdma/verbs.c    |   16 +---------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 951ae20485f3..43a412ea337a 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -390,11 +390,13 @@ static void frwr_cid_init(struct rpcrdma_ep *ep,
  */
 int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
+	struct ib_send_wr *post_wr, *send_wr = &req->rl_wr;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
+	unsigned int num_wrs;
 
-	post_wr = &req->rl_wr;
+	num_wrs = 1;
+	post_wr = send_wr;
 	list_for_each_entry(mr, &req->rl_registered, mr_list) {
 		struct rpcrdma_frwr *frwr;
 
@@ -409,8 +411,19 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		frwr->fr_regwr.wr.send_flags = 0;
 
 		post_wr = &frwr->fr_regwr.wr;
+		++num_wrs;
 	}
 
+	if ((kref_read(&req->rl_kref) > 1) || num_wrs > ep->re_send_count) {
+		send_wr->send_flags |= IB_SEND_SIGNALED;
+		ep->re_send_count = min_t(unsigned int, ep->re_send_batch,
+					  num_wrs - ep->re_send_count);
+	} else {
+		send_wr->send_flags &= ~IB_SEND_SIGNALED;
+		ep->re_send_count -= num_wrs;
+	}
+
+	trace_xprtrdma_post_send(req);
 	return ib_post_send(ep->re_id->qp, post_wr, NULL);
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index d4e573eef416..55c45cad2c8a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1365,21 +1365,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
  */
 int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
-	struct ib_send_wr *send_wr = &req->rl_wr;
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	int rc;
-
-	if (!ep->re_send_count || kref_read(&req->rl_kref) > 1) {
-		send_wr->send_flags |= IB_SEND_SIGNALED;
-		ep->re_send_count = ep->re_send_batch;
-	} else {
-		send_wr->send_flags &= ~IB_SEND_SIGNALED;
-		--ep->re_send_count;
-	}
-
-	trace_xprtrdma_post_send(req);
-	rc = frwr_send(r_xprt, req);
-	if (rc)
+	if (frwr_send(r_xprt, req))
 		return -ENOTCONN;
 	return 0;
 }


