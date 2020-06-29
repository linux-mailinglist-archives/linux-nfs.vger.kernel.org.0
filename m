Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6061B20E5D1
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2020 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbgF2VmA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgF2Sh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F7C02F030;
        Mon, 29 Jun 2020 07:59:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g11so7765300qvs.2;
        Mon, 29 Jun 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JekA222ZBrRj7GVNVej75VxNc6uUkegN9a8r4swWpVM=;
        b=i3/qpCyqySnjDkt6vlmJOjWkh5fWh3UkRsfuKwJh7tPtUzKDBbcB7nV0YghyofVNyB
         DhjNv1rTYYtsTGlJQSuq+2h977e43lULYJDiXDgcJAuC359YKfTk5pnhWXj8ghN+PsIv
         vGRqiDZ50w+ICtCKx318C5pYIXXWqCwUHzUtad16B/ajRkY7meMBYxddQbtO0/rJZ0q1
         Q1w67kNZ5Vh+zC0fcHS4oJ6UoKv+wqSZSd9sIfmHQ38XwAqFi4GU+l049JDuLPEUW/FZ
         nLqItw8JWOI/S5ll9GpnEbuZk4/XFl58qyWr7Rluzb6Qt712S7zfrE6bc005bfW6W4UQ
         HSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JekA222ZBrRj7GVNVej75VxNc6uUkegN9a8r4swWpVM=;
        b=QLAYk9Aadmf330dlD17AUDF6P2665RxXSC0V22lbQvI1PsOyVVKjeWA+NPxI9ndiiC
         MBMmJU+SmOTLqmaawZ7sVeyJZ7/ixo7enlqC06ztifGOQf/7UMqgghuDeq0U8w0nOmXF
         XTgixmXn1JLsS9mR/o6uly4fFTgKdhcr63TJwPvK6rQjIlfLC2ZHn7W0mrskl22K9977
         UQQ+hVEV3DfoFlv4Xp5L+B+EG2xn2aZxBYWoEOPuLEg66I3buLOYjcl7qOc+H2swojaB
         lXe4w0etqQZHCmqfrvHNbX8SG82zeIzonkhi5EDtDz1kg37kmTzlKJrvkfYBh+8iViPY
         xeoA==
X-Gm-Message-State: AOAM531rQQ+4y0y6usIAJq7mNEfRdseDD7jhAKmrH7g25oPxeyeF8381
        pW155PpEMYusb9YpYpRqLtZn00AZ
X-Google-Smtp-Source: ABdhPJz/EG3J6s2wE9+qO9m1lmdW0W0xgWA6KBxbLjAEZf+v+mJMSMxIC5nQL76zaowNfzhFEfv1KA==
X-Received: by 2002:a0c:f0c8:: with SMTP id d8mr15835120qvl.217.1593442746744;
        Mon, 29 Jun 2020 07:59:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e129sm19846qkf.132.2020.06.29.07.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:59:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEx5VL006257;
        Mon, 29 Jun 2020 14:59:05 GMT
Subject: [PATCH v1 6/6] svcrdma: Display chunk completion ID when posting a
 rw_ctxt
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:59:05 -0400
Message-ID: <20200629145905.15100.27460.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
References: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Re-use the post_rw tracepoint (safely) to trace cc_info lifetime
events, including completion IDs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   56 ++++++++-----------------------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   14 ++++++++-
 2 files changed, 24 insertions(+), 46 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index aeeba9188ed5..abe942225637 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1802,41 +1802,6 @@ TRACE_EVENT(svcrdma_send_err,
 	)
 );
 
-DECLARE_EVENT_CLASS(svcrdma_sendcomp_event,
-	TP_PROTO(
-		const struct ib_wc *wc
-	),
-
-	TP_ARGS(wc),
-
-	TP_STRUCT__entry(
-		__field(const void *, cqe)
-		__field(unsigned int, status)
-		__field(unsigned int, vendor_err)
-	),
-
-	TP_fast_assign(
-		__entry->cqe = wc->wr_cqe;
-		__entry->status = wc->status;
-		if (wc->status)
-			__entry->vendor_err = wc->vendor_err;
-		else
-			__entry->vendor_err = 0;
-	),
-
-	TP_printk("cqe=%p status=%s (%u/0x%x)",
-		__entry->cqe, rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
-	)
-);
-
-#define DEFINE_SENDCOMP_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_sendcomp_event, svcrdma_wc_##name,	\
-				TP_PROTO(				\
-					const struct ib_wc *wc		\
-				),					\
-				TP_ARGS(wc))
-
 TRACE_EVENT(svcrdma_post_send,
 	TP_PROTO(
 		const struct svc_rdma_send_ctxt *ctxt
@@ -1916,31 +1881,34 @@ TRACE_EVENT(svcrdma_rq_post_err,
 	)
 );
 
-TRACE_EVENT(svcrdma_post_rw,
+TRACE_EVENT(svcrdma_post_chunk,
 	TP_PROTO(
-		const void *cqe,
+		const struct rpc_rdma_cid *cid,
 		int sqecount
 	),
 
-	TP_ARGS(cqe, sqecount),
+	TP_ARGS(cid, sqecount),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(int, sqecount)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = cqe;
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
 		__entry->sqecount = sqecount;
 	),
 
-	TP_printk("cqe=%p sqecount=%d",
-		__entry->cqe, __entry->sqecount
+	TP_printk("cq.id=%u cid=%d sqecount=%d",
+		__entry->cq_id, __entry->completion_id,
+		__entry->sqecount
 	)
 );
 
-DEFINE_SENDCOMP_EVENT(read);
-DEFINE_SENDCOMP_EVENT(write);
+DEFINE_COMPLETION_EVENT(svcrdma_wc_read);
+DEFINE_COMPLETION_EVENT(svcrdma_wc_write);
 
 TRACE_EVENT(svcrdma_qp_error,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 2038b1b286dd..c16d10601d65 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -145,15 +145,24 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
  * demand, and not cached.
  */
 struct svc_rdma_chunk_ctxt {
+	struct rpc_rdma_cid	cc_cid;
 	struct ib_cqe		cc_cqe;
 	struct svcxprt_rdma	*cc_rdma;
 	struct list_head	cc_rwctxts;
 	int			cc_sqecount;
 };
 
+static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
+				 struct rpc_rdma_cid *cid)
+{
+	cid->ci_queue_id = rdma->sc_sq_cq->res.id;
+	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
+}
+
 static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 			     struct svc_rdma_chunk_ctxt *cc)
 {
+	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
 	cc->cc_rdma = rdma;
 	svc_xprt_get(&rdma->sc_xprt);
 
@@ -237,7 +246,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct svc_rdma_write_info *info =
 			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
-	trace_svcrdma_wc_write(wc);
+	trace_svcrdma_wc_write(wc, &cc->cc_cid);
 
 	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
 	wake_up(&rdma->sc_send_wait);
@@ -295,7 +304,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct svc_rdma_read_info *info =
 			container_of(cc, struct svc_rdma_read_info, ri_cc);
 
-	trace_svcrdma_wc_read(wc);
+	trace_svcrdma_wc_read(wc, &cc->cc_cid);
 
 	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
 	wake_up(&rdma->sc_send_wait);
@@ -351,6 +360,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	do {
 		if (atomic_sub_return(cc->cc_sqecount,
 				      &rdma->sc_sq_avail) > 0) {
+			trace_svcrdma_post_chunk(&cc->cc_cid, cc->cc_sqecount);
 			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
 			if (ret)
 				break;

