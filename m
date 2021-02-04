Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E174D30F8F0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Feb 2021 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhBDRA5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Feb 2021 12:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238272AbhBDRAD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Feb 2021 12:00:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7951864F77;
        Thu,  4 Feb 2021 16:59:20 +0000 (UTC)
Subject: [PATCH v4 4/6] rpcrdma: Fix comments about reverse-direction
 operation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 04 Feb 2021 11:59:19 -0500
Message-ID: <161245795975.737759.7447460236438637578.stgit@manet.1015granger.net>
In-Reply-To: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
References: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

During the final stages of publication of RFC 8167, reviewers
requested that we use the term "reverse direction" rather than
"backwards direction". Update comments to reflect this preference.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
---
 net/sunrpc/xprtrdma/backchannel.c          |    4 ++--
 net/sunrpc/xprtrdma/rpc_rdma.c             |    6 +-----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h            |    6 +++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 946edf2db646..a249837d6a55 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2015-2020, Oracle and/or its affiliates.
  *
- * Support for backward direction RPCs on RPC/RDMA.
+ * Support for reverse-direction RPCs on RPC/RDMA.
  */
 
 #include <linux/sunrpc/xprt.h>
@@ -208,7 +208,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 }
 
 /**
- * rpcrdma_bc_receive_call - Handle a backward direction call
+ * rpcrdma_bc_receive_call - Handle a reverse-direction Call
  * @r_xprt: transport receiving the call
  * @rep: receive buffer containing the call
  *
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index b2482d9328d1..283e9bfcab44 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1151,14 +1151,10 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
 	 */
 	p = xdr_inline_decode(xdr, 3 * sizeof(*p));
 	if (unlikely(!p))
-		goto out_short;
+		return true;
 
 	rpcrdma_bc_receive_call(r_xprt, rep);
 	return true;
-
-out_short:
-	pr_warn("RPC/RDMA short backward direction call\n");
-	return true;
 }
 #else	/* CONFIG_SUNRPC_BACKCHANNEL */
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 63f8be974df2..4a1edbb4028e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2015-2018 Oracle.  All rights reserved.
  *
- * Support for backward direction RPCs on RPC/RDMA (server-side).
+ * Support for reverse-direction RPCs on RPC/RDMA (server-side).
  */
 
 #include <linux/sunrpc/svc_rdma.h>
@@ -59,7 +59,7 @@ void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
 	spin_unlock(&xprt->queue_lock);
 }
 
-/* Send a backwards direction RPC call.
+/* Send a reverse-direction RPC Call.
  *
  * Caller holds the connection's mutex and has already marshaled
  * the RPC/RDMA request.
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index ed1c5444fb9d..fe3be985e239 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -98,9 +98,9 @@ struct rpcrdma_ep {
 	atomic_t		re_completion_ids;
 };
 
-/* Pre-allocate extra Work Requests for handling backward receives
- * and sends. This is a fixed value because the Work Queues are
- * allocated when the forward channel is set up, long before the
+/* Pre-allocate extra Work Requests for handling reverse-direction
+ * Receives and Sends. This is a fixed value because the Work Queues
+ * are allocated when the forward channel is set up, long before the
  * backchannel is provisioned. This value is two times
  * NFS4_DEF_CB_SLOT_TABLE_SIZE.
  */


