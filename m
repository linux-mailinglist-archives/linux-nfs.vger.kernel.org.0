Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2559C3DDF7B
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhHBSoa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBSo2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A864660F55;
        Mon,  2 Aug 2021 18:44:18 +0000 (UTC)
Subject: [PATCH v1 1/5] xprtrdma: Disconnect after an ib_post_send() immediate
 error
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:17 -0400
Message-ID: <162792985795.3902.7336825698400392872.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ib_post_send() does not disconnect the QP when it returns an
immediate error. Thus, the code that posts LocalInv has to
explicitly disconnect after an immediate error. This is just
like the frwr_send() callers handle it.

If a disconnect isn't done here, the transport deadlocks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    8 ++++++++
 net/sunrpc/xprtrdma/verbs.c     |    2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 229fcc9a9064..754c5dffe127 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -557,6 +557,10 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* On error, the MRs get destroyed once the QP has drained. */
 	trace_xprtrdma_post_linv_err(req, rc);
+
+	/* Force a connection loss to ensure complete recovery.
+	 */
+	rpcrdma_force_disconnect(ep);
 }
 
 /**
@@ -653,4 +657,8 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * retransmission.
 	 */
 	rpcrdma_unpin_rqst(req->rl_reply);
+
+	/* Force a connection loss to ensure complete recovery.
+	 */
+	rpcrdma_force_disconnect(ep);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 649c23518ec0..c1797ea19418 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -124,7 +124,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
  * connection is closed or lost. (The important thing is it needs
  * to be invoked "at least" once).
  */
-static void rpcrdma_force_disconnect(struct rpcrdma_ep *ep)
+void rpcrdma_force_disconnect(struct rpcrdma_ep *ep)
 {
 	if (atomic_add_unless(&ep->re_force_disconnect, 1, 1))
 		xprt_force_disconnect(ep->re_xprt);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5d231d94e944..927e20a2c04e 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -454,6 +454,7 @@ extern unsigned int xprt_rdma_memreg_strategy;
 /*
  * Endpoint calls - xprtrdma/verbs.c
  */
+void rpcrdma_force_disconnect(struct rpcrdma_ep *ep);
 void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);


