Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A335055A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhCaRWQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 13:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhCaRWQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 13:22:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D6861042;
        Wed, 31 Mar 2021 17:22:15 +0000 (UTC)
Subject: [PATCH 1/3] SUNRPC: Move fault injection call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 13:22:14 -0400
Message-ID: <161721133412.515091.3634995666026759187.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've hit some crashes that occur in the xprt_rdma_inject_disconnect
path. It appears that, for some provides, rdma_disconnect() can
take so long that the transport can disconnect and release its
hardware resources while rdma_disconnect() is still running,
resulting in a UAF in the provider.

The transport's fault injection method may depend on the stability
of transport data structures. That means it needs to be invoked
only from contexts that hold the transport write lock.

Fixes: 4a0682583988 ("SUNRPC: Transport fault injection")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c               |    1 -
 net/sunrpc/xprt.c               |    6 ++++--
 net/sunrpc/xprtrdma/transport.c |    6 ++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641f4c..c2a01125be1a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1799,7 +1799,6 @@ call_allocate(struct rpc_task *task)
 
 	status = xprt->ops->buf_alloc(task);
 	trace_rpc_buf_alloc(task, status);
-	xprt_inject_disconnect(xprt);
 	if (status == 0)
 		return;
 	if (status != -ENOMEM) {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 691ccf8049a4..d616b93751d8 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1483,7 +1483,10 @@ bool xprt_prepare_transmit(struct rpc_task *task)
 
 void xprt_end_transmit(struct rpc_task *task)
 {
-	xprt_release_write(task->tk_rqstp->rq_xprt, task);
+	struct rpc_xprt	*xprt = task->tk_rqstp->rq_xprt;
+
+	xprt_inject_disconnect(xprt);
+	xprt_release_write(xprt, task);
 }
 
 /**
@@ -1885,7 +1888,6 @@ void xprt_release(struct rpc_task *task)
 	spin_unlock(&xprt->transport_lock);
 	if (req->rq_buffer)
 		xprt->ops->buf_free(task);
-	xprt_inject_disconnect(xprt);
 	xdr_free_bvec(&req->rq_rcv_buf);
 	xdr_free_bvec(&req->rq_snd_buf);
 	if (req->rq_cred != NULL)
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 78d29d1bcc20..09953597d055 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -262,8 +262,10 @@ xprt_rdma_connect_worker(struct work_struct *work)
  * xprt_rdma_inject_disconnect - inject a connection fault
  * @xprt: transport context
  *
- * If @xprt is connected, disconnect it to simulate spurious connection
- * loss.
+ * If @xprt is connected, disconnect it to simulate spurious
+ * connection loss. Caller must hold @xprt's send lock to
+ * ensure that data structures and hardware resources are
+ * stable during the rdma_disconnect() call.
  */
 static void
 xprt_rdma_inject_disconnect(struct rpc_xprt *xprt)


