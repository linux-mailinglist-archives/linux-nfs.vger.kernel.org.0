Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD60414E82
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhIVRCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 13:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236733AbhIVRCc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Sep 2021 13:02:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76BE8611CA;
        Wed, 22 Sep 2021 17:01:02 +0000 (UTC)
Subject: [PATCH v1 2/3] svcrdma: Split the svcrdma_wc_send() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 22 Sep 2021 13:01:01 -0400
Message-ID: <163233006176.2994.10748682582748659034.stgit@klimt.1015granger.net>
In-Reply-To: <163233005560.2994.7205464325452467490.stgit@klimt.1015granger.net>
References: <163233005560.2994.7205464325452467490.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are currently three separate purposes being served by a single
tracepoint here. They need to be split up.

svcrdma_wc_send:
 - status is always zero, so there's no value in recording it.
 - vendor_err is meaningless unless status is not zero, so
   there's no value in recording it.
 - This tracepoint is needed only when developing modifications,
   so it should be left disabled most of the time.

svcrdma_wc_send_flush:
 - As above, needed only rarely, and not an error.

svcrdma_wc_send_err:
 - This tracepoint can be left persistently enabled because
   completion errors are run-time problems (except for FLUSHED_ERR).
 - Tracepoint name now ends in _err to reflect its purpose.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   72 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   14 +++++-
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 342d6d7b5cd9..1d7c12f65f87 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -60,6 +60,74 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
+DECLARE_EVENT_CLASS(rpcrdma_send_completion_class,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid
+	),
+
+	TP_ARGS(wc, cid),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+	),
+
+	TP_printk("cq.id=%u cid=%d",
+		__entry->cq_id, __entry->completion_id
+	)
+);
+
+#define DEFINE_SEND_COMPLETION_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_send_completion_class, name,	\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
+DECLARE_EVENT_CLASS(rpcrdma_send_flush_class,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid
+	),
+
+	TP_ARGS(wc, cid),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		__entry->vendor_err = wc->vendor_err;
+	),
+
+	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x)",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err
+	)
+);
+
+#define DEFINE_SEND_FLUSH_EVENT(name)					\
+		DEFINE_EVENT(rpcrdma_send_flush_class, name,		\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
 DECLARE_EVENT_CLASS(rpcrdma_mr_completion_class,
 	TP_PROTO(
 		const struct ib_wc *wc,
@@ -1939,7 +2007,9 @@ TRACE_EVENT(svcrdma_post_send,
 	)
 );
 
-DEFINE_COMPLETION_EVENT(svcrdma_wc_send);
+DEFINE_SEND_COMPLETION_EVENT(svcrdma_wc_send);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_flush);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_err);
 
 TRACE_EVENT(svcrdma_post_recv,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 599021b2391d..22a871e6fe4d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -280,13 +280,21 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	struct svc_rdma_send_ctxt *ctxt =
 		container_of(cqe, struct svc_rdma_send_ctxt, sc_cqe);
 
-	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
-
 	svc_rdma_wake_send_waiters(rdma, 1);
 	complete(&ctxt->sc_done);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS))
-		svc_xprt_deferred_close(&rdma->sc_xprt);
+		goto flushed;
+
+	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
+	return;
+
+flushed:
+	if (wc->status != IB_WC_WR_FLUSH_ERR)
+		trace_svcrdma_wc_send_err(wc, &ctxt->sc_cid);
+	else
+		trace_svcrdma_wc_send_flush(wc, &ctxt->sc_cid);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**


