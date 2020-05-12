Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4BB1D006F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgELVNb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVNb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30488C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so15204932qke.13
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IJ6pgEyXTC5dRki+zk4SlMepsbWzX4nMUt5FJEXjShI=;
        b=SoLpbr8SuXW3YVW7/Bt84soWcevCtaymN1ZAEywb43yU9hGBswgLk0Mfs251ymJZkX
         H1hzobxzbFiH3frqcQRgjVSsBzBeFSWrdrGZbB0oqVWGQ3r3nTbQBQxme96UVfxHy4r3
         NxsJe5I/YKF8LAJou2wOkOlVxhkm1ivF4i1iSFcAIH3IT2gu5tGgcZ2muhpGcNBTGd4I
         VSG1ujsDxCMcy1iX2yuAKN6NtvP7L33dDCUPZx0d4vxvMOxZU7iXxtPgdL2JVBLNxH1W
         0d0gKCrr+55RY3R5rMKYIdJ0F1B7kkJY1/dhol5HEvQDYqIm/+1hvEYsyGWu0eiWcXsL
         8C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IJ6pgEyXTC5dRki+zk4SlMepsbWzX4nMUt5FJEXjShI=;
        b=LALA+6E37mImns7W7rzN33wR7k8CqajQRNfzZHlPOjo+78d1s9mROLyx9MzfbnMdEE
         lfOS5gdlwffrPP19k5c1FVlCmhsFAAnxPNdaCi7L9+az1HdnRp1caqVstWIUS9q6iR2S
         L1iMN88eIzfcuDs42P1mmf65hfdFVI9Pd/Iqz8konMe/LEtL9X3A+BHtiVis2Xbf8F91
         XBQkbYOoQFEqQ/ez+QDT+8ar68Ircdgaw3Jtg53NJvnA4kUz9rIo0MOuIQrz6FPRM/w/
         Ft4k7IvFP2RKb4C2MSGGbzjUwVc/W4YmVTJ5wPVOOsRY4+vNeB0SkvQTKXkNa+OF4a//
         S+iQ==
X-Gm-Message-State: AGi0PuZ2qzzd01S9O4iHY/t9rIHM1gFOBZaV8GG7j9d4QH3YEJQCoERa
        KZ/fFESph6vqe1bEWkUN19M=
X-Google-Smtp-Source: APiQypJHkMU0aX5A6SIJilHB96Fb+m0xs2UN94P3bwofXYApv/QFbXvn6NrVGEzzcJq7U7qwpTLpGw==
X-Received: by 2002:a37:5ac2:: with SMTP id o185mr21725466qkb.461.1589318010279;
        Tue, 12 May 2020 14:13:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x124sm12444362qkb.108.2020.05.12.14.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:29 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDSWF009804;
        Tue, 12 May 2020 21:13:28 GMT
Subject: [PATCH v1 07/15] SUNRPC: Split the xdr_buf event class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:28 -0400
Message-ID: <20200512211328.3288.35105.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
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
---
 include/trace/events/sunrpc.h |  113 ++++++++++++++++++++++++-----------------
 net/sunrpc/clnt.c             |    4 +
 net/sunrpc/svc_xprt.c         |    4 +
 net/sunrpc/xprt.c             |    2 -
 4 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f1fd3fae5b0f..4747803b370e 100644
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
@@ -31,6 +34,8 @@
 	),
 
 	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
 		__entry->head_base = xdr->head[0].iov_base;
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
@@ -39,23 +44,26 @@
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
@@ -560,43 +568,6 @@
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
@@ -1024,6 +995,54 @@
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
index 9151ade01a55..c600628efa91 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1270,7 +1270,7 @@ void rpc_prepare_reply_pages(struct rpc_rqst *req, struct page **pages,
 	hdrsize += RPC_REPHDRSIZE + req->rq_cred->cr_auth->au_ralign - 1;
 
 	xdr_inline_pages(&req->rq_rcv_buf, hdrsize << 2, pages, base, len);
-	trace_rpc_reply_pages(req);
+	trace_rpc_xdr_reply_pages(req->rq_task, &req->rq_rcv_buf);
 }
 EXPORT_SYMBOL_GPL(rpc_prepare_reply_pages);
 
@@ -2532,7 +2532,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
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
@@ -1460,7 +1460,7 @@ void xprt_end_transmit(struct rpc_task *task)
 	 */
 	req->rq_ntrans++;
 
-	trace_xprt_sendto(&req->rq_snd_buf);
+	trace_rpc_xdr_sendto(task, &req->rq_snd_buf);
 	connect_cookie = xprt->connect_cookie;
 	status = xprt->ops->send_request(req);
 	if (status != 0) {

