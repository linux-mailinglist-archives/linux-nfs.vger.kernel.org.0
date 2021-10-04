Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E32421128
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJDOR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232999AbhJDOR6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFC5D61216;
        Mon,  4 Oct 2021 14:16:08 +0000 (UTC)
Subject: [PATCH 1/5] svcrdma: Split the svcrdma_wc_receive() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:16:08 -0400
Message-ID: <163335696821.3921.2054888968700411603.stgit@klimt.1015granger.net>
In-Reply-To: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
References: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are currently three separate purposes being served by a single
tracepoint here. They need to be split up.

svcrdma_wc_recv:
 - status is always zero, so there's no value in recording it.
 - vendor_err is meaningless unless status is not zero, so
   there's no value in recording it.
 - This tracepoint is needed only when developing modifications,
   so it should be left disabled most of the time.

svcrdma_wc_recv_flush:
 - As above, needed only rarely, and not an error.

svcrdma_wc_recv_err:
 - received is always zero, so there's no value in recording it.
 - This tracepoint can be left enabled because completion
   errors are run-time problems (except for FLUSHED_ERR).
 - Tracepoint name now ends in _err to reflect its purpose.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |   75 +++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    9 +++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index de4195499592..342d6d7b5cd9 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -145,6 +145,77 @@ DECLARE_EVENT_CLASS(rpcrdma_receive_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
+DECLARE_EVENT_CLASS(rpcrdma_receive_success_class,
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
+		__field(u32, received)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->received = wc->byte_len;
+	),
+
+	TP_printk("cq.id=%u cid=%d received=%u",
+		__entry->cq_id, __entry->completion_id,
+		__entry->received
+	)
+);
+
+#define DEFINE_RECEIVE_SUCCESS_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_receive_success_class, name,	\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
+DECLARE_EVENT_CLASS(rpcrdma_receive_flush_class,
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
+#define DEFINE_RECEIVE_FLUSH_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_receive_flush_class, name,		\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
 DECLARE_EVENT_CLASS(xprtrdma_reply_class,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
@@ -1892,7 +1963,9 @@ TRACE_EVENT(svcrdma_post_recv,
 	)
 );
 
-DEFINE_RECEIVE_COMPLETION_EVENT(svcrdma_wc_receive);
+DEFINE_RECEIVE_SUCCESS_EVENT(svcrdma_wc_recv);
+DEFINE_RECEIVE_FLUSH_EVENT(svcrdma_wc_recv_flush);
+DEFINE_RECEIVE_FLUSH_EVENT(svcrdma_wc_recv_err);
 
 TRACE_EVENT(svcrdma_rq_post_err,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 6be23ce7a93d..cf76a6ad127b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -330,9 +330,9 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	/* WARNING: Only wc->wr_cqe and wc->status are reliable */
 	ctxt = container_of(cqe, struct svc_rdma_recv_ctxt, rc_cqe);
 
-	trace_svcrdma_wc_receive(wc, &ctxt->rc_cid);
 	if (wc->status != IB_WC_SUCCESS)
 		goto flushed;
+	trace_svcrdma_wc_recv(wc, &ctxt->rc_cid);
 
 	/* If receive posting fails, the connection is about to be
 	 * lost anyway. The server will not be able to send a reply
@@ -345,7 +345,7 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	 */
 	if (rdma->sc_pending_recvs < rdma->sc_max_requests)
 		if (!svc_rdma_refresh_recvs(rdma, rdma->sc_recv_batch, false))
-			goto flushed;
+			goto dropped;
 
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
@@ -360,6 +360,11 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	return;
 
 flushed:
+	if (wc->status == IB_WC_WR_FLUSH_ERR)
+		trace_svcrdma_wc_recv_flush(wc, &ctxt->rc_cid);
+	else
+		trace_svcrdma_wc_recv_err(wc, &ctxt->rc_cid);
+dropped:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 }


