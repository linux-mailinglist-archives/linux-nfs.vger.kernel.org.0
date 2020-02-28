Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702C8172D49
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgB1AbE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35586 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AbC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so504753plt.2;
        Thu, 27 Feb 2020 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lg3kW/ZNuCeM5EyA07wYe13GW+GeWvh9tixEQ7JryzQ=;
        b=cyX01OBzp8GkyfjhCVJvgI8rpBlciq2ehbMyIZpScr+DIHxt/CsNwGWdahb7QtjYe7
         u2IuG0GjCltPjwXTl38bMHLWBSQ9miADsWsYhx5Y1CatFvLJbYzWUzZDsD9NR+VfWb5L
         kqwFAmQJrRs3igdU2mXW5P3WgKqDNrMGNvRkUwmkrCyR7ummc+pqqEuN4TIzUuakcriq
         A+95BJnffz4PdNmiP85UzP0gKucarcwbNgjEnsi9DRXQLz5UqPj/xDtmw9/bGU6nEY4h
         v5x2OwVogRXp4n4ns0F5bZvfQvRk5FGvdGBOOMZHYHCF1YGgvN2RGRWHbwyaeeVdERWl
         jV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lg3kW/ZNuCeM5EyA07wYe13GW+GeWvh9tixEQ7JryzQ=;
        b=PY5FTwfnFoqfuAY6+Fo/AqwLLST4HF6jB71zrlFQ+uNbRjc39QdmaS5mgOKBC8p3QG
         AxjWo8PD1YvxGK/ebvUYLWWkfQz8VxfgGboD4oUiYmXEQfo3mpfBhCdD6/h/c0MgAPft
         rgb3/6WUbYoZOISw1rWZgG+b4k7YTezVySip/9Y2YJc9PwkAMWAdBWyS5NHe/bzapTBu
         QkCeuCLiqlgDOCO6gGPa/PK/JLYjGufXQ/2cxZPKawHRu8foAu4Dd3vhMcVLtFguAE/J
         HK1e9F7IIBx3+WcjtAQjuYfzdI92J8QjGYyuRrWC5b1kyD9Krpbj06ulyf3nXZ1QiM/s
         RbXg==
X-Gm-Message-State: APjAAAUsKvT5lLCoP064qRu6b9EzgR1WHkEHC8oZyyariuOUbBjePOHF
        Rvdu3LYGHmbuzk4HPi0Dc8eZ+7Q8vbs=
X-Google-Smtp-Source: APXvYqz9GDqrV4TEJhfKXIGs942F3u5olLg1v13Be2wO6dlKk9oW5g3Qv7hQQJJwz+slfXFXqfPxDw==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr1397049plb.140.1582849861678;
        Thu, 27 Feb 2020 16:31:01 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id u25sm3426994pfn.59.2020.02.27.16.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:01 -0800 (PST)
Subject: [PATCH v1 05/16] svcrdma: Create a generic tracing class for
 displaying xdr_buf layout
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:30:59 -0500
Message-ID: <158284985994.38468.11081309957716392757.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This class can be used to create trace points in either the RPC
client or RPC server paths. It simply displays the length of each
part of an xdr_buf, which is useful to determine that the transport
and XDR codecs are operating correctly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   43 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc_xprt.c         |    6 +++++-
 net/sunrpc/xprt.c             |    4 ++--
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ee993575d2fa..1577223add43 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,6 +14,49 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
+DECLARE_EVENT_CLASS(xdr_buf_class,
+	TP_PROTO(
+		const struct xdr_buf *xdr
+	),
+
+	TP_ARGS(xdr),
+
+	TP_STRUCT__entry(
+		__field(const void *, head_base)
+		__field(size_t, head_len)
+		__field(const void *, tail_base)
+		__field(size_t, tail_len)
+		__field(unsigned int, page_len)
+		__field(unsigned int, msg_len)
+	),
+
+	TP_fast_assign(
+		__entry->head_base = xdr->head[0].iov_base;
+		__entry->head_len = xdr->head[0].iov_len;
+		__entry->tail_base = xdr->tail[0].iov_base;
+		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_len = xdr->page_len;
+		__entry->msg_len = xdr->len;
+	),
+
+	TP_printk("head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+		__entry->head_base, __entry->head_len, __entry->page_len,
+		__entry->tail_base, __entry->tail_len, __entry->msg_len
+	)
+);
+
+#define DEFINE_XDRBUF_EVENT(name)					\
+		DEFINE_EVENT(xdr_buf_class, name,			\
+				TP_PROTO(				\
+					const struct xdr_buf *xdr	\
+				),					\
+				TP_ARGS(xdr))
+
+DEFINE_XDRBUF_EVENT(xprt_sendto);
+DEFINE_XDRBUF_EVENT(xprt_recvfrom);
+DEFINE_XDRBUF_EVENT(svc_recvfrom);
+DEFINE_XDRBUF_EVENT(svc_sendto);
+
 TRACE_DEFINE_ENUM(RPC_AUTH_OK);
 TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
 TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDCRED);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index de3c077733a7..081564449e98 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -802,6 +802,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			len = svc_deferred_recv(rqstp);
 		else
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
+		if (len > 0)
+			trace_svc_recvfrom(&rqstp->rq_arg);
 		rqstp->rq_stime = ktime_get();
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
@@ -912,8 +914,10 @@ int svc_send(struct svc_rqst *rqstp)
 	if (test_bit(XPT_DEAD, &xprt->xpt_flags)
 			|| test_bit(XPT_CLOSE, &xprt->xpt_flags))
 		len = -ENOTCONN;
-	else
+	else {
+		trace_svc_sendto(xb);
 		len = xprt->xpt_ops->xpo_sendto(rqstp);
+	}
 	mutex_unlock(&xprt->xpt_mutex);
 	trace_svc_send(rqstp, len);
 	svc_xprt_release(rqstp);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 1aafe8d3f3f4..30989d9b61a0 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1117,9 +1117,8 @@ void xprt_complete_rqst(struct rpc_task *task, int copied)
 	struct rpc_rqst *req = task->tk_rqstp;
 	struct rpc_xprt *xprt = req->rq_xprt;
 
-	dprintk("RPC: %5u xid %08x complete (%d bytes received)\n",
-			task->tk_pid, ntohl(req->rq_xid), copied);
 	trace_xprt_complete_rqst(xprt, req->rq_xid, copied);
+	trace_xprt_recvfrom(&req->rq_rcv_buf);
 
 	xprt->stat.recvs++;
 
@@ -1462,6 +1461,7 @@ xprt_request_transmit(struct rpc_rqst *req, struct rpc_task *snd_task)
 	 */
 	req->rq_ntrans++;
 
+	trace_xprt_sendto(&req->rq_snd_buf);
 	connect_cookie = xprt->connect_cookie;
 	status = xprt->ops->send_request(req);
 	if (status != 0) {

