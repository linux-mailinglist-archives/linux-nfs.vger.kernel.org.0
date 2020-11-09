Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437F82AC51B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgKITjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E6C0613CF;
        Mon,  9 Nov 2020 11:39:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b18so9101841qkc.9;
        Mon, 09 Nov 2020 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=APnuPL/aojxnXvlxsQQygIUtKJ2olB6s4yI0GG/OMHo=;
        b=iWsSDtxWQVaK3Hs3hoUjkslGFQHPOfYulcrcWIhLn7n6hm+HhETBlVPUeBzEghybsc
         16T+OGhZmeF0FHcGlx1PgWjmFGKXnl8yLD5Pj+E+d1VtQBrz9MlyvwkHUnpuhK1peb0L
         BdgxIJCH4pbhthjBkkr2RAJin6fK7jQboZsBV0ue6Gm8wl+oI2QEjoJr1NCMoOuAUhPw
         OJlJSeAqLZnBjZD/SqTbHkn6HEJtACiBYvnfwh5bZM5j5oWKgxwKxEzhYFtSQ3YPu63O
         Gcp02/UZvaOfJz8ct5nZ2KXwwjAAQaX9saNNvBqcsPGBDmUp7FW4TrxcpHQQyuBZH+Bg
         ifMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=APnuPL/aojxnXvlxsQQygIUtKJ2olB6s4yI0GG/OMHo=;
        b=UoOLhC1gPqDUrpdZjA26QJ2uMey5VnOWrbBzeIXPEWE5zCD7VdjvyOKa4eI7nN/j1e
         f9wWuOlto398EaWoWg0ex4xzWQKkQ0Xnh0pxx9MGtOx1k4CbVmTEebeVcxqGx2dGR/xA
         cFpCP8mEaJS9KkB38KgMScafHAywdGJ5F/GdOhehBors1dB0MhTjkoIXjgh31Qs3CcoF
         YbTkvjqZw7QeBq5NG66Je8tDjaNndgBT0c36i7x5MH2O/3ILGO+O0WOGr8vpe17H6Uiy
         DNQOr7uCljcF6aMAqRUgq5K4Spnpw4qQ5o7bEcAXeSIfQK5lES82XuLSzn4ZzacRfW/l
         LBCQ==
X-Gm-Message-State: AOAM5304145I8Yx2ATSL5rwk0DmnhwsRvX3/LoMbiCZpMnzNbHZfS6lG
        peL/ccn5gOUOVbXXiMqZmiBovaSZC4E=
X-Google-Smtp-Source: ABdhPJyfLad5pHTXUkARoEBcJs03Mm1Hr5Y6cSElcvrG/9k1UknJfxSZBQhAST5Wq2K2f5yWRaPnDg==
X-Received: by 2002:a37:ac10:: with SMTP id e16mr14808597qkm.318.1604950762901;
        Mon, 09 Nov 2020 11:39:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j25sm6481135qtk.79.2020.11.09.11.39.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdLLZ021794;
        Mon, 9 Nov 2020 19:39:21 GMT
Subject: [PATCH v1 02/13] xprtrdma: Introduce Receive completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:21 -0500
Message-ID: <160495076114.2072548.12296791888135843037.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set up a completion ID in each rpcrdma_rep. The ID is used to match
an incoming Receive completion to a transport and to a previous
ib_post_recv().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   46 +++++++--------------------------------
 net/sunrpc/xprtrdma/verbs.c     |    6 ++++-
 net/sunrpc/xprtrdma/xprt_rdma.h |    5 ++++
 3 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index d5e66428e27e..1c91c8e721e7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -771,15 +771,17 @@ TRACE_EVENT(xprtrdma_post_recv,
 	TP_ARGS(rep),
 
 	TP_STRUCT__entry(
-		__field(const void *, rep)
+		__field(u32, cq_id)
+		__field(int, completion_id)
 	),
 
 	TP_fast_assign(
-		__entry->rep = rep;
+		__entry->cq_id = rep->rr_cid.ci_queue_id;
+		__entry->completion_id = rep->rr_cid.ci_completion_id;
 	),
 
-	TP_printk("rep=%p",
-		__entry->rep
+	TP_printk("cq.id=%d cid=%d",
+		__entry->cq_id, __entry->completion_id
 	)
 );
 
@@ -845,6 +847,8 @@ TRACE_EVENT(xprtrdma_post_linv,
  ** Completion events
  **/
 
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
+
 TRACE_EVENT(xprtrdma_wc_send,
 	TP_PROTO(
 		const struct rpcrdma_sendctx *sc,
@@ -876,40 +880,6 @@ TRACE_EVENT(xprtrdma_wc_send,
 	)
 );
 
-TRACE_EVENT(xprtrdma_wc_receive,
-	TP_PROTO(
-		const struct ib_wc *wc
-	),
-
-	TP_ARGS(wc),
-
-	TP_STRUCT__entry(
-		__field(const void *, rep)
-		__field(u32, byte_len)
-		__field(unsigned int, status)
-		__field(u32, vendor_err)
-	),
-
-	TP_fast_assign(
-		__entry->rep = container_of(wc->wr_cqe, struct rpcrdma_rep,
-					    rr_cqe);
-		__entry->status = wc->status;
-		if (wc->status) {
-			__entry->byte_len = 0;
-			__entry->vendor_err = wc->vendor_err;
-		} else {
-			__entry->byte_len = wc->byte_len;
-			__entry->vendor_err = 0;
-		}
-	),
-
-	TP_printk("rep=%p %u bytes: %s (%u/0x%x)",
-		__entry->rep, __entry->byte_len,
-		rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
-	)
-);
-
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_fastreg);
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li);
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li_wake);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ad6e2e4994ce..2c8d2801ec4f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -186,7 +186,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_receive(wc);
+	trace_xprtrdma_wc_receive(wc, &rep->rr_cid);
 	--r_xprt->rx_ep->re_receive_count;
 	if (wc->status != IB_WC_SUCCESS)
 		goto out_flushed;
@@ -972,6 +972,9 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
 		goto out_free_regbuf;
 
+	rep->rr_cid.ci_completion_id =
+		atomic_inc_return(&r_xprt->rx_ep->re_completion_ids);
+
 	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rep->rr_rdmabuf),
 		     rdmab_length(rep->rr_rdmabuf));
 	rep->rr_cqe.done = rpcrdma_wc_receive;
@@ -1411,6 +1414,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 		if (!rep)
 			break;
 
+		rep->rr_cid.ci_queue_id = ep->re_attr.recv_cq->res.id;
 		trace_xprtrdma_post_recv(rep);
 		rep->rr_recv_wr.next = wr;
 		wr = &rep->rr_recv_wr;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 43974ef39a50..b94940bc67aa 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -53,6 +53,7 @@
 #include <rdma/ib_verbs.h>		/* RDMA verbs api */
 
 #include <linux/sunrpc/clnt.h> 		/* rpc_xprt */
+#include <linux/sunrpc/rpc_rdma_cid.h> 	/* completion IDs */
 #include <linux/sunrpc/rpc_rdma.h> 	/* RPC/RDMA protocol */
 #include <linux/sunrpc/xprtrdma.h> 	/* xprt parameters */
 
@@ -93,6 +94,8 @@ struct rpcrdma_ep {
 	unsigned int		re_max_requests; /* depends on device */
 	unsigned int		re_inline_send;	/* negotiated */
 	unsigned int		re_inline_recv;	/* negotiated */
+
+	atomic_t		re_completion_ids;
 };
 
 /* Pre-allocate extra Work Requests for handling backward receives
@@ -180,6 +183,8 @@ enum {
 
 struct rpcrdma_rep {
 	struct ib_cqe		rr_cqe;
+	struct rpc_rdma_cid	rr_cid;
+
 	__be32			rr_xid;
 	__be32			rr_vers;
 	__be32			rr_proc;


