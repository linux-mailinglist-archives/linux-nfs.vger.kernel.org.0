Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5923D5C0B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhGZOGb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 10:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhGZOGa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2832960E78;
        Mon, 26 Jul 2021 14:46:59 +0000 (UTC)
Subject: [PATCH v1 1/3] svcrdma: Fewer calls to wake_up() in Send completion
 handler
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Jul 2021 10:46:58 -0400
Message-ID: <162731081843.13580.15415936872318036839.stgit@klimt.1015granger.net>
In-Reply-To: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Because wake_up() takes an IRQ-safe lock, it can be expensive,
especially to call inside of a single-threaded completion handler.
What's more, the Send wait queue almost never has waiters, so
most of the time, this is an expensive no-op.

As always, the goal is to reduce the average overhead of each
completion, because a transport's completion handlers are single-
threaded on one CPU core. This change reduces CPU utilization of
the Send completion thread by 2-3% on my server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    7 ++-----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   18 +++++++++++++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 3184465de3a0..57c60ffe76dd 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -207,6 +207,7 @@ extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_send_ctxt *sctxt,
 				    struct svc_rdma_recv_ctxt *rctxt,
 				    int status);
+extern void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 1e651447dc4e..3d1b119f6e3e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -248,8 +248,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	trace_svcrdma_wc_write(wc, &cc->cc_cid);
 
-	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
-	wake_up(&rdma->sc_send_wait);
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		svc_xprt_deferred_close(&rdma->sc_xprt);
@@ -304,9 +303,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	trace_svcrdma_wc_read(wc, &cc->cc_cid);
 
-	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
-	wake_up(&rdma->sc_send_wait);
-
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
 	cc->cc_status = wc->status;
 	complete(&cc->cc_done);
 	return;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index d6bbafb773e1..fba2ee4eb607 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -258,6 +258,20 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 	spin_unlock(&rdma->sc_send_lock);
 }
 
+/**
+ * svc_rdma_wake_send_waiters - manage Send Queue accounting
+ * @rdma: controlling transport
+ * @avail: Number of additional SQEs that are now available
+ *
+ */
+void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail)
+{
+	atomic_add(avail, &rdma->sc_sq_avail);
+	smp_mb__after_atomic();
+	if (unlikely(waitqueue_active(&rdma->sc_send_wait)))
+		wake_up(&rdma->sc_send_wait);
+}
+
 /**
  * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
  * @cq: Completion Queue context
@@ -275,11 +289,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 
 	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
 
+	svc_rdma_wake_send_waiters(rdma, 1);
 	complete(&ctxt->sc_done);
 
-	atomic_inc(&rdma->sc_sq_avail);
-	wake_up(&rdma->sc_send_wait);
-
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		svc_xprt_deferred_close(&rdma->sc_xprt);
 }


