Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960BA2AC52F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgKITkG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITkG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:40:06 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226FC0613CF;
        Mon,  9 Nov 2020 11:40:06 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so2492112qtp.1;
        Mon, 09 Nov 2020 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M6OCYaplLhRt+tkj12rTkc6fuXvyButQ/GFIVrJOJn8=;
        b=O2bONco5+k/3hAIpIIEOb+KJxRwQOH6RVsV9uA19AFiKZW0TRiixR2+XusHHfZlQk4
         0dXOvIDznWfJzM0jCZZE4/GVDwr3NovpwFA3IrJcoobGrHNJ08dcVk0zmq1oG50fz/8m
         4PzPspixrPaHa9ZzrOsbK0uLZW554f0iijiTSA9NBhMW/3pDCpIeQrIKXe6Hq7htYRyB
         FatpW/YS7YGv8blzXUWq/GaD4Wgn7j4WqghGW4DM8nTCz4wtiZuKXUKXBRKdIlJfh2FJ
         lKbJnHBJmzL/D+hDCR+3HFeAHNDpLEH5hS0fKkhr0pIpqedULp3n43EwyPoipUoFUQq6
         U9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=M6OCYaplLhRt+tkj12rTkc6fuXvyButQ/GFIVrJOJn8=;
        b=Jfo63sb57QvKBfF20n1Es9PV1rsluK73tdq+YZQc+daCLxWUXFXdmTn9jvbHTR6nl2
         E1WeU5110OW6XiC8A9GIv+3tq0T9CECCyHr6jiSWW12qpaPsHKE8GHuNAg4bbe58lreC
         Fbk4m79VQQPufztX+QWk/phvAC+EEmYJVmbijWsyRAu13PG3wQwd9rPDWTGX3n7u+v8a
         n83OgNIOTc0F9JdFVg0MVJL0tMOlHrPiiuEy9Z11iUCGn6X6K3noiTAidK0zoGm+QhBZ
         pa/H6ipKI0dAiUi5BmucalqbEhYCZVv02DJZ/EgkDh3NH31lmirjP5Cs5Lj5YFzuR/7J
         lKCQ==
X-Gm-Message-State: AOAM533WhjyKqU4YPgFsnPtFuu7MdE9IqRNP9V0Z95pYd2gmeLs7TbiR
        obdTYFiIbmIW6WERO2Rv7x0+gqbpwhA=
X-Google-Smtp-Source: ABdhPJzelT+4d7krXWXLSsO5wFjhJtZqHmlwJQd7t2x6aLkrIx21PIEoFu80YcO5Pcednv4FyT/X7A==
X-Received: by 2002:aed:3b7b:: with SMTP id q56mr15342251qte.377.1604950805210;
        Mon, 09 Nov 2020 11:40:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 8sm7067107qkb.98.2020.11.09.11.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:04 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9Je3p2021829;
        Mon, 9 Nov 2020 19:40:03 GMT
Subject: [PATCH v1 10/13] xprtrdma: Display the task ID when reporting MR
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:40:03 -0500
Message-ID: <160495080365.2072548.15440792549170057984.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tie each MR event to the requesting rpc_task to make it easier to
follow MR ownership and control flow.

MR unmapping and recycling can happen in the background, after an
MR's mr_req field is stale, so set up a separate tracepoint class
for those events.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   96 ++++++++++++++++++++++++----------------
 net/sunrpc/xprtrdma/frwr_ops.c |    1 
 net/sunrpc/xprtrdma/rpc_rdma.c |    1 
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 4fcda2a25bb8..166bbeef996c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -274,7 +274,55 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 				{ DMA_FROM_DEVICE, "FROM_DEVICE" },	\
 				{ DMA_NONE, "NONE" })
 
-DECLARE_EVENT_CLASS(xprtrdma_mr,
+DECLARE_EVENT_CLASS(xprtrdma_mr_class,
+	TP_PROTO(
+		const struct rpcrdma_mr *mr
+	),
+
+	TP_ARGS(mr),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, mr_id)
+		__field(int, nents)
+		__field(u32, handle)
+		__field(u32, length)
+		__field(u64, offset)
+		__field(u32, dir)
+	),
+
+	TP_fast_assign(
+		const struct rpcrdma_req *req = mr->mr_req;
+		const struct rpc_task *task = req->rl_slot.rq_task;
+
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
+		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->nents  = mr->mr_nents;
+		__entry->handle = mr->mr_handle;
+		__entry->length = mr->mr_length;
+		__entry->offset = mr->mr_offset;
+		__entry->dir    = mr->mr_dir;
+	),
+
+	TP_printk("task:%u@%u mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
+		__entry->task_id, __entry->client_id,
+		__entry->mr_id, __entry->nents, __entry->length,
+		(unsigned long long)__entry->offset, __entry->handle,
+		xprtrdma_show_direction(__entry->dir)
+	)
+);
+
+#define DEFINE_MR_EVENT(name)						\
+		DEFINE_EVENT(xprtrdma_mr_class,				\
+				xprtrdma_mr_##name,			\
+				TP_PROTO(				\
+					const struct rpcrdma_mr *mr	\
+				),					\
+				TP_ARGS(mr))
+
+DECLARE_EVENT_CLASS(xprtrdma_anonymous_mr_class,
 	TP_PROTO(
 		const struct rpcrdma_mr *mr
 	),
@@ -306,11 +354,12 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 	)
 );
 
-#define DEFINE_MR_EVENT(name) \
-		DEFINE_EVENT(xprtrdma_mr, xprtrdma_mr_##name, \
-				TP_PROTO( \
-					const struct rpcrdma_mr *mr \
-				), \
+#define DEFINE_ANON_MR_EVENT(name)					\
+		DEFINE_EVENT(xprtrdma_anonymous_mr_class,		\
+				xprtrdma_mr_##name,			\
+				TP_PROTO(				\
+					const struct rpcrdma_mr *mr	\
+				),					\
 				TP_ARGS(mr))
 
 DECLARE_EVENT_CLASS(xprtrdma_callback_class,
@@ -516,35 +565,6 @@ TRACE_EVENT(xprtrdma_createmrs,
 	)
 );
 
-TRACE_EVENT(xprtrdma_mr_get,
-	TP_PROTO(
-		const struct rpcrdma_req *req
-	),
-
-	TP_ARGS(req),
-
-	TP_STRUCT__entry(
-		__field(const void *, req)
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(u32, xid)
-	),
-
-	TP_fast_assign(
-		const struct rpc_rqst *rqst = &req->rl_slot;
-
-		__entry->req = req;
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
-	),
-
-	TP_printk("task:%u@%u xid=0x%08x req=%p",
-		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->req
-	)
-);
-
 TRACE_EVENT(xprtrdma_nomrs_err,
 	TP_PROTO(
 		const struct rpcrdma_xprt *r_xprt,
@@ -946,9 +966,9 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 
 DEFINE_MR_EVENT(localinv);
 DEFINE_MR_EVENT(map);
-DEFINE_MR_EVENT(unmap);
-DEFINE_MR_EVENT(reminv);
-DEFINE_MR_EVENT(recycle);
+
+DEFINE_ANON_MR_EVENT(unmap);
+DEFINE_ANON_MR_EVENT(recycle);
 
 TRACE_EVENT(xprtrdma_dma_maperr,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 76322b1acf3d..cb2f92409c2f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -431,7 +431,6 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 	list_for_each_entry(mr, mrs, mr_list)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
-			trace_xprtrdma_mr_reminv(mr);
 			rpcrdma_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index f27eb2322b38..9ed89872ec75 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -315,7 +315,6 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
 		*mr = rpcrdma_mr_get(r_xprt);
 		if (!*mr)
 			goto out_getmr_err;
-		trace_xprtrdma_mr_get(req);
 		(*mr)->mr_req = req;
 	}
 


