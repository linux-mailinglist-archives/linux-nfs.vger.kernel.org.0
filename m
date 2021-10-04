Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604BA42112C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhJDOS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233504AbhJDOSK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 163BF61216;
        Mon,  4 Oct 2021 14:16:21 +0000 (UTC)
Subject: [PATCH 3/5] svcrdma: Split svcrmda_wc_{read,write} tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:16:20 -0400
Message-ID: <163335698039.3921.2188708036946954981.stgit@klimt.1015granger.net>
In-Reply-To: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
References: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are currently three separate purposes being served by single
tracepoints. Split them up, as was done with wc_send.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   38 +++++++++++++++++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   30 +++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 1d7c12f65f87..b5a1388e51a4 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2099,8 +2099,42 @@ DEFINE_POST_CHUNK_EVENT(read);
 DEFINE_POST_CHUNK_EVENT(write);
 DEFINE_POST_CHUNK_EVENT(reply);
 
-DEFINE_COMPLETION_EVENT(svcrdma_wc_read);
-DEFINE_COMPLETION_EVENT(svcrdma_wc_write);
+TRACE_EVENT(svcrdma_wc_read,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid,
+		unsigned int totalbytes,
+		const ktime_t posttime
+	),
+
+	TP_ARGS(wc, cid, totalbytes, posttime),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(s64, read_latency)
+		__field(unsigned int, totalbytes)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->totalbytes = totalbytes;
+		__entry->read_latency = ktime_us_delta(ktime_get(), posttime);
+	),
+
+	TP_printk("cq.id=%u cid=%d totalbytes=%u latency-us=%lld",
+		__entry->cq_id, __entry->completion_id,
+		__entry->totalbytes, __entry->read_latency
+	)
+);
+
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_flush);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_err);
+
+DEFINE_SEND_COMPLETION_EVENT(svcrdma_wc_write);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_flush);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_err);
 
 TRACE_EVENT(svcrdma_qp_error,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e27433f08ca7..5f0155fdefc7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -155,6 +155,7 @@ struct svc_rdma_chunk_ctxt {
 	struct ib_cqe		cc_cqe;
 	struct svcxprt_rdma	*cc_rdma;
 	struct list_head	cc_rwctxts;
+	ktime_t			cc_posttime;
 	int			cc_sqecount;
 	enum ib_wc_status	cc_status;
 	struct completion	cc_done;
@@ -267,7 +268,16 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct svc_rdma_write_info *info =
 			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
-	trace_svcrdma_wc_write(wc, &cc->cc_cid);
+	switch (wc->status) {
+	case IB_WC_SUCCESS:
+		trace_svcrdma_wc_write(wc, &cc->cc_cid);
+		break;
+	case IB_WC_WR_FLUSH_ERR:
+		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
+		break;
+	default:
+		trace_svcrdma_wc_write_err(wc, &cc->cc_cid);
+	}
 
 	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
 
@@ -320,11 +330,22 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svcxprt_rdma *rdma = cc->cc_rdma;
+	struct svc_rdma_read_info *info;
 
-	trace_svcrdma_wc_read(wc, &cc->cc_cid);
+	switch (wc->status) {
+	case IB_WC_SUCCESS:
+		info = container_of(cc, struct svc_rdma_read_info, ri_cc);
+		trace_svcrdma_wc_read(wc, &cc->cc_cid, info->ri_totalbytes,
+				      cc->cc_posttime);
+		break;
+	case IB_WC_WR_FLUSH_ERR:
+		trace_svcrdma_wc_read_flush(wc, &cc->cc_cid);
+		break;
+	default:
+		trace_svcrdma_wc_read_err(wc, &cc->cc_cid);
+	}
 
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+	svc_rdma_wake_send_waiters(cc->cc_rdma, cc->cc_sqecount);
 	cc->cc_status = wc->status;
 	complete(&cc->cc_done);
 	return;
@@ -363,6 +384,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	do {
 		if (atomic_sub_return(cc->cc_sqecount,
 				      &rdma->sc_sq_avail) > 0) {
+			cc->cc_posttime = ktime_get();
 			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
 			if (ret)
 				break;


