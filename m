Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE61E9178
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3N2M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98960C03E969;
        Sat, 30 May 2020 06:28:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q18so5209153ilm.5;
        Sat, 30 May 2020 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ApO5bAAj0nn19PGMMs3nmnkpRDjVwopR9Q8CzxSUKnA=;
        b=JYh6qb3BLzcO8+Kiz5be79a13070sZZPwZkJ8bdxxW1y/0GRn5BxMBjH3p97mAXU20
         wgyTgDumaa6VpcTaWBNw0GfisuX5pJn3KzlyDnGToQFH/BkKDiTpsU+ALsE2/lfMmJPD
         DUO0IzmUMlDqb9W+7DE3ERivLRj4URtVHBiJDGhEcTIjUzNPBwrR/61Ez02OPjbUjwbC
         B7uzE2VLc1hRSYXE2RYCEfO1cxhud6JD/3Ge+Va9vPywicMXOoHBm6ue7T1Af6HuDK0h
         2ovIDJi/C6JOqtoEn+H/q7xr5+nawPGGvr00bSueMX1Ck00xdHGgslkkvpTyAzchxw6z
         B9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ApO5bAAj0nn19PGMMs3nmnkpRDjVwopR9Q8CzxSUKnA=;
        b=rWYNXNajVP5wqNcSw5R+vR6xN6PA8rMKEijF0tEf+bhg6wJRAtGRb1XqFzJFbGw6iN
         NHDCQwFAFuViLTuPTsQT/TgLrgfmY0jSBhCzDCTEQSfc78CUhqmD6nOkEYHiFUJ/wEOV
         k0RbuHbcMX7wviNknmt4LHWFHckyXQOLvRG/WH4riwpdGpyt32Ji1ta9q7ug+9gKSsMu
         8CNDNc8TeIUzhljC67t02Y1pAgzYT4WZymve8bN5mRmRPvvat42CPfflvfcexJJ8E+7N
         QfEt/Jy3EOvcA/hm76+50BXLseCB5yhaHcMg83OxxXyZgQzIuAG9lWT+3lrnaBuRSnKT
         4wzg==
X-Gm-Message-State: AOAM532FttUAj3ykv3YzRmSQVkPCG5nYG91I9kI+Zl7l57XbfR4tnmZH
        CGcq2F8zLV4voCOF40UXSeKetram
X-Google-Smtp-Source: ABdhPJyfR3QjC+TaUAoba9X297pD0COh55vaIBHdpqwlLXP0ATULmV5CkIlS+JQdTMfMnorovK4zxw==
X-Received: by 2002:a05:6e02:965:: with SMTP id q5mr12064726ilt.272.1590845290750;
        Sat, 30 May 2020 06:28:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h5sm6280709ile.35.2020.05.30.06.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:10 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDS9Aq001387;
        Sat, 30 May 2020 13:28:09 GMT
Subject: [PATCH v4 01/33] SUNRPC: Split the xdr_buf event class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:09 -0400
Message-ID: <20200530132809.10117.56384.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To help tie the recorded xdr_buf to a particular RPC transaction,
the client side version of this class should display task ID
information and the server side one should show the request's XID.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/trace/events/sunrpc.h |  113 ++++++++++++++++++++++++-----------------
 net/sunrpc/clnt.c             |    4 +
 net/sunrpc/svc_xprt.c         |    4 +
 net/sunrpc/xprt.c             |    2 -
 4 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ffd2215950dc..1d53b77dd3e8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,14 +14,17 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
-DECLARE_EVENT_CLASS(xdr_buf_class,
+DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 	TP_PROTO(
+		const struct rpc_task *task,
 		const struct xdr_buf *xdr
 	),
 
-	TP_ARGS(xdr),
+	TP_ARGS(task, xdr),
 
 	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
 		__field(const void *, head_base)
 		__field(size_t, head_len)
 		__field(const void *, tail_base)
@@ -31,6 +34,8 @@ DECLARE_EVENT_CLASS(xdr_buf_class,
 	),
 
 	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
 		__entry->head_base = xdr->head[0].iov_base;
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
@@ -39,23 +44,26 @@ DECLARE_EVENT_CLASS(xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+		__entry->task_id, __entry->client_id,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
 	)
 );
 
-#define DEFINE_XDRBUF_EVENT(name)					\
-		DEFINE_EVENT(xdr_buf_class, name,			\
+#define DEFINE_RPCXDRBUF_EVENT(name)					\
+		DEFINE_EVENT(rpc_xdr_buf_class,				\
+				rpc_xdr_##name,				\
 				TP_PROTO(				\
+					const struct rpc_task *task,	\
 					const struct xdr_buf *xdr	\
 				),					\
-				TP_ARGS(xdr))
+				TP_ARGS(task, xdr))
+
+DEFINE_RPCXDRBUF_EVENT(sendto);
+DEFINE_RPCXDRBUF_EVENT(recvfrom);
+DEFINE_RPCXDRBUF_EVENT(reply_pages);
 
-DEFINE_XDRBUF_EVENT(xprt_sendto);
-DEFINE_XDRBUF_EVENT(xprt_recvfrom);
-DEFINE_XDRBUF_EVENT(svc_recvfrom);
-DEFINE_XDRBUF_EVENT(svc_sendto);
 
 TRACE_DEFINE_ENUM(RPC_AUTH_OK);
 TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
@@ -526,43 +534,6 @@ TRACE_EVENT(rpc_xdr_alignment,
 	)
 );
 
-TRACE_EVENT(rpc_reply_pages,
-	TP_PROTO(
-		const struct rpc_rqst *req
-	),
-
-	TP_ARGS(req),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(const void *, head_base)
-		__field(size_t, head_len)
-		__field(const void *, tail_base)
-		__field(size_t, tail_len)
-		__field(unsigned int, page_len)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = req->rq_task->tk_pid;
-		__entry->client_id = req->rq_task->tk_client->cl_clid;
-
-		__entry->head_base = req->rq_rcv_buf.head[0].iov_base;
-		__entry->head_len = req->rq_rcv_buf.head[0].iov_len;
-		__entry->page_len = req->rq_rcv_buf.page_len;
-		__entry->tail_base = req->rq_rcv_buf.tail[0].iov_base;
-		__entry->tail_len = req->rq_rcv_buf.tail[0].iov_len;
-	),
-
-	TP_printk(
-		"task:%u@%u xdr=[%p,%zu]/%u/[%p,%zu]\n",
-		__entry->task_id, __entry->client_id,
-		__entry->head_base, __entry->head_len,
-		__entry->page_len,
-		__entry->tail_base, __entry->tail_len
-	)
-);
-
 /*
  * First define the enums in the below macros to be exported to userspace
  * via TRACE_DEFINE_ENUM().
@@ -990,6 +961,54 @@ TRACE_EVENT(xs_stream_read_request,
 			__entry->copied, __entry->reclen, __entry->offset)
 );
 
+
+DECLARE_EVENT_CLASS(svc_xdr_buf_class,
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const struct xdr_buf *xdr
+	),
+
+	TP_ARGS(rqst, xdr),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(const void *, head_base)
+		__field(size_t, head_len)
+		__field(const void *, tail_base)
+		__field(size_t, tail_len)
+		__field(unsigned int, page_len)
+		__field(unsigned int, msg_len)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->head_base = xdr->head[0].iov_base;
+		__entry->head_len = xdr->head[0].iov_len;
+		__entry->tail_base = xdr->tail[0].iov_base;
+		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_len = xdr->page_len;
+		__entry->msg_len = xdr->len;
+	),
+
+	TP_printk("xid=0x%08x head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+		__entry->xid,
+		__entry->head_base, __entry->head_len, __entry->page_len,
+		__entry->tail_base, __entry->tail_len, __entry->msg_len
+	)
+);
+
+#define DEFINE_SVCXDRBUF_EVENT(name)					\
+		DEFINE_EVENT(svc_xdr_buf_class,				\
+				svc_xdr_##name,				\
+				TP_PROTO(				\
+					const struct svc_rqst *rqst,	\
+					const struct xdr_buf *xdr	\
+				),					\
+				TP_ARGS(rqst, xdr))
+
+DEFINE_SVCXDRBUF_EVENT(recvfrom);
+DEFINE_SVCXDRBUF_EVENT(sendto);
+
 #define show_rqstp_flags(flags)						\
 	__print_flags(flags, "|",					\
 		{ (1UL << RQ_SECURE),		"RQ_SECURE"},		\
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 61b21dafd7c0..953f3e78401a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1270,7 +1270,7 @@ void rpc_prepare_reply_pages(struct rpc_rqst *req, struct page **pages,
 	hdrsize += RPC_REPHDRSIZE + req->rq_cred->cr_auth->au_ralign - 1;
 
 	xdr_inline_pages(&req->rq_rcv_buf, hdrsize << 2, pages, base, len);
-	trace_rpc_reply_pages(req);
+	trace_rpc_xdr_reply_pages(req->rq_task, &req->rq_rcv_buf);
 }
 EXPORT_SYMBOL_GPL(rpc_prepare_reply_pages);
 
@@ -2531,7 +2531,7 @@ call_decode(struct rpc_task *task)
 		goto out;
 
 	req->rq_rcv_buf.len = req->rq_private_buf.len;
-	trace_xprt_recvfrom(&req->rq_rcv_buf);
+	trace_rpc_xdr_recvfrom(task, &req->rq_rcv_buf);
 
 	/* Check that the softirq receive buffer is valid */
 	WARN_ON(memcmp(&req->rq_rcv_buf, &req->rq_private_buf,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2284ff038dad..8ef44275c255 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -812,7 +812,7 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		else
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
 		if (len > 0)
-			trace_svc_recvfrom(&rqstp->rq_arg);
+			trace_svc_xdr_recvfrom(rqstp, &rqstp->rq_arg);
 		rqstp->rq_stime = ktime_get();
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
@@ -913,7 +913,7 @@ int svc_send(struct svc_rqst *rqstp)
 	xb->len = xb->head[0].iov_len +
 		xb->page_len +
 		xb->tail[0].iov_len;
-	trace_svc_sendto(xb);
+	trace_svc_xdr_sendto(rqstp, xb);
 
 	/* Grab mutex to serialize outgoing data. */
 	mutex_lock(&xprt->xpt_mutex);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 493a30a296fc..053de053a024 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1460,7 +1460,7 @@ xprt_request_transmit(struct rpc_rqst *req, struct rpc_task *snd_task)
 	 */
 	req->rq_ntrans++;
 
-	trace_xprt_sendto(&req->rq_snd_buf);
+	trace_rpc_xdr_sendto(task, &req->rq_snd_buf);
 	connect_cookie = xprt->connect_cookie;
 	status = xprt->ops->send_request(req);
 	if (status != 0) {

