Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764B41689BE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBUWBG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:01:06 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42994 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgBUWBF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:01:05 -0500
Received: by mail-yb1-f196.google.com with SMTP id z125so1859577ybf.9;
        Fri, 21 Feb 2020 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nrIMzjvseHo3F6e5qgpv0bwz6kq9bvpFfzm3XMd+csA=;
        b=hb4ijIvMRUK9MM5cU3eOJ8WbS1dl6LsZ9zcSAiHpmBuVX4YfEGD8o6EdkZ4aUwKXh0
         hhOx24Xuizf9uw0ftxEYeiHFI4TduvVI0uh0jqQLPDvnGMYEyfAHgbj0+lo8M4sVQrl6
         zmatZHOuw/Vrg3MSP7Tf/kAvVDTAhBA+bA1oLhdJ3sqCEwEs+J/xdOtHLIHDRfnIPrYl
         9srQUliMrhD+V1/Vb6t+pscSbIRlfNyQ6HT/9ecTCk8PxLWRew0Ep5aG41I6p1d++4u+
         EkyctHdQ4s1b40BvNdASE6CMA6x+fqucyCWreNLOG/dw5XeCxOTaA+JcigdLd6IOnzQg
         p1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nrIMzjvseHo3F6e5qgpv0bwz6kq9bvpFfzm3XMd+csA=;
        b=MXZKCFnHJ9LWocb9uqzOIdH7yaFzWwyhPYTJmROajbXLikZyqXpKBb7Qk1xKAiqNjb
         MH3Q4+GHxblFPKGSsRW6oD58sODaGwI0u8m/7XSOmx3uvoUcm2vO4o+L2wC30euYiHWb
         0JdqC+5izqVUgMln7hlzpQau9dxY1L+jKZDgZF7bGpMoHN3oj7HJOSSok4YGgovfr0F2
         Kdzum7SKTc+rLAo/fq3ZuTdHWNX7GI6HQJr00Yz7FJZvBP6xt/uSyaLGJWn5ioYYXjo8
         OpBoulqgQKbsRe5H/kgJIEZBRbmklyAizmheJuOET+i7OXjoAG6TM74HGoK9PtzDMBqY
         L6QQ==
X-Gm-Message-State: APjAAAVZwaNyrS5bhLIVhhQy7rv6bQEqdq5y1cRgvNsRTIbVgiaVHrRQ
        dwK572hhPWEA5PhlK5gaRdbBi6S9
X-Google-Smtp-Source: APXvYqyZKLktOnwurJTUB7rA/4r7v6FOJqX9oz09n33+/yWangHPpNR6uoTdvGLN+YI5i92rcOmrrg==
X-Received: by 2002:a25:ba4a:: with SMTP id z10mr37075939ybj.48.1582322461827;
        Fri, 21 Feb 2020 14:01:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h23sm1817224ywc.105.2020.02.21.14.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:01:01 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM10Ye019006;
        Fri, 21 Feb 2020 22:01:00 GMT
Subject: [PATCH v1 10/11] xprtrdma: Extract sockaddr from struct rdma_cm_id
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:01:00 -0500
Message-ID: <20200221220100.2072.45609.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpcrdma_cm_event_handler() is always passed an @id pointer that is
valid. However, in a subsequent patch, we won't be able to extract
an r_xprt in every case. So instead of using the r_xprt's
presentation address strings, extract them from struct rdma_cm_id.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   78 +++++++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/verbs.c    |   33 +++++++----------
 2 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bebc45f7c570..a6d3a2122e9b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -373,47 +373,74 @@
 
 TRACE_EVENT(xprtrdma_inline_thresh,
 	TP_PROTO(
-		const struct rpcrdma_xprt *r_xprt
+		const struct rpcrdma_ep *ep
 	),
 
-	TP_ARGS(r_xprt),
+	TP_ARGS(ep),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__field(unsigned int, inline_send)
 		__field(unsigned int, inline_recv)
 		__field(unsigned int, max_send)
 		__field(unsigned int, max_recv)
-		__string(addr, rpcrdma_addrstr(r_xprt))
-		__string(port, rpcrdma_portstr(r_xprt))
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
 	),
 
 	TP_fast_assign(
-		const struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+		const struct rdma_cm_id *id = ep->re_id;
 
-		__entry->r_xprt = r_xprt;
 		__entry->inline_send = ep->re_inline_send;
 		__entry->inline_recv = ep->re_inline_recv;
 		__entry->max_send = ep->re_max_inline_send;
 		__entry->max_recv = ep->re_max_inline_recv;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p neg send/recv=%u/%u, calc send/recv=%u/%u",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
+	TP_printk("%pISpc -> %pISpc neg send/recv=%u/%u, calc send/recv=%u/%u",
+		__entry->srcaddr, __entry->dstaddr,
 		__entry->inline_send, __entry->inline_recv,
 		__entry->max_send, __entry->max_recv
 	)
 );
 
+TRACE_EVENT(xprtrdma_remove,
+	TP_PROTO(
+		const struct rpcrdma_ep *ep
+	),
+
+	TP_ARGS(ep),
+
+	TP_STRUCT__entry(
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+		__string(name, ep->re_id->device->name)
+	),
+
+	TP_fast_assign(
+		const struct rdma_cm_id *id = ep->re_id;
+
+		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+		__assign_str(name, id->device->name);
+	),
+
+	TP_printk("%pISpc -> %pISpc device=%s",
+		__entry->srcaddr, __entry->dstaddr, __get_str(name)
+	)
+);
+
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
 DEFINE_CONN_EVENT(flush_dct);
 
 DEFINE_RXPRT_EVENT(xprtrdma_create);
 DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
-DEFINE_RXPRT_EVENT(xprtrdma_remove);
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
 DEFINE_RXPRT_EVENT(xprtrdma_op_close);
 DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
@@ -480,32 +507,33 @@
 
 TRACE_EVENT(xprtrdma_qp_event,
 	TP_PROTO(
-		const struct rpcrdma_xprt *r_xprt,
+		const struct rpcrdma_ep *ep,
 		const struct ib_event *event
 	),
 
-	TP_ARGS(r_xprt, event),
+	TP_ARGS(ep, event),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
-		__field(unsigned int, event)
+		__field(unsigned long, event)
 		__string(name, event->device->name)
-		__string(addr, rpcrdma_addrstr(r_xprt))
-		__string(port, rpcrdma_portstr(r_xprt))
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
+		const struct rdma_cm_id *id = ep->re_id;
+
 		__entry->event = event->event;
 		__assign_str(name, event->device->name);
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: dev %s: %s (%u)",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
-		__get_str(name), rdma_show_ib_event(__entry->event),
-		__entry->event
+	TP_printk("%pISpc -> %pISpc device=%s %s (%lu)",
+		__entry->srcaddr, __entry->dstaddr, __get_str(name),
+		rdma_show_ib_event(__entry->event), __entry->event
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 10826982ddf8..5cb308fb4f0f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -116,16 +116,14 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
  * @context: ep that owns QP where event occurred
  *
  * Called from the RDMA provider (device driver) possibly in an interrupt
- * context.
+ * context. The QP is always destroyed before the ID, so the ID will be
+ * reliably available when this handler is invoked.
  */
-static void
-rpcrdma_qp_event_handler(struct ib_event *event, void *context)
+static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
 {
 	struct rpcrdma_ep *ep = context;
-	struct rpcrdma_xprt *r_xprt = container_of(ep, struct rpcrdma_xprt,
-						   rx_ep);
 
-	trace_xprtrdma_qp_event(r_xprt, event);
+	trace_xprtrdma_qp_event(ep, event);
 }
 
 /**
@@ -202,11 +200,10 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	rpcrdma_rep_destroy(rep);
 }
 
-static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
+static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 				      struct rdma_conn_param *param)
 {
 	const struct rpcrdma_connect_private *pmsg = param->private_data;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	unsigned int rsize, wsize;
 
 	/* Default settings for RPC-over-RDMA Version One */
@@ -241,6 +238,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 static int
 rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
+	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
 	struct rpcrdma_xprt *r_xprt = id->context;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
@@ -264,23 +262,22 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 		return 0;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-		pr_info("rpcrdma: removing device %s for %s:%s\n",
-			ep->re_id->device->name,
-			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
+		pr_info("rpcrdma: removing device %s for %pISpc\n",
+			ep->re_id->device->name, sap);
 #endif
 		init_completion(&ep->re_remove_done);
 		ep->re_connect_status = -ENODEV;
 		xprt_force_disconnect(xprt);
 		wait_for_completion(&ep->re_remove_done);
-		trace_xprtrdma_remove(r_xprt);
+		trace_xprtrdma_remove(ep);
 
 		/* Return 1 to ensure the core destroys the id. */
 		return 1;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		++xprt->connect_cookie;
 		ep->re_connect_status = 1;
-		rpcrdma_update_cm_private(r_xprt, &event->param.conn);
-		trace_xprtrdma_inline_thresh(r_xprt);
+		rpcrdma_update_cm_private(ep, &event->param.conn);
+		trace_xprtrdma_inline_thresh(ep);
 		wake_up_all(&ep->re_connect_wait);
 		break;
 	case RDMA_CM_EVENT_CONNECT_ERROR:
@@ -290,9 +287,8 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 		ep->re_connect_status = -ENETUNREACH;
 		goto disconnected;
 	case RDMA_CM_EVENT_REJECTED:
-		dprintk("rpcrdma: connection to %s:%s rejected: %s\n",
-			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
-			rdma_reject_msg(id, event->status));
+		dprintk("rpcrdma: connection to %pISpc rejected: %s\n",
+			sap, rdma_reject_msg(id, event->status));
 		ep->re_connect_status = -ECONNREFUSED;
 		if (event->status == IB_CM_REJ_STALE_CONN)
 			ep->re_connect_status = -EAGAIN;
@@ -307,8 +303,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 		break;
 	}
 
-	dprintk("RPC:       %s: %s:%s on %s/frwr: %s\n", __func__,
-		rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
+	dprintk("RPC:       %s: %pISpc on %s/frwr: %s\n", __func__, sap,
 		ep->re_id->device->name, rdma_event_msg(event->event));
 	return 0;
 }

