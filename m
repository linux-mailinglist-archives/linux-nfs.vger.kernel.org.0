Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E861C1BF3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEARiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARiA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97BC061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p13so5059844qvt.12
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vb4DcyADCr/rwXplOufRwBAwRVk61kowYNusZULLRXY=;
        b=NiR6LNxYLn6tkFfIsyqnXzCZY7HXqwPq5ulGjBsNvZNEuscYroODPPoPZxkXuZH1o3
         fuz7maiPNqqF1V41jnIX0y9DLvqtCl319dCmJf28uCQ7e9rej0Dr3dwszo2QwbEcGl/I
         tC/Hz6XMpvaFrd8TI6QX4tr1yFivVOPEZmfAGXSd25hPl7qgFjqA3FEhcepTmJEHryBW
         3I4Y1kflRJE30rqLpoX3dyuYgqZeBerchq5l5WRbfpZ/JosGkFBO2Z3iOjopy+wGMlaD
         EwRjpPUmN7Bpa0xD2KWbANN50VU5e5ibLyThiQfewUb/90ECChWwENJRk6vvZqEHDhxE
         BLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vb4DcyADCr/rwXplOufRwBAwRVk61kowYNusZULLRXY=;
        b=a5ot5si6DaeLInA8krvKID248rJhKMugzE6sDCbY0mEsEhr7iEsvjx7wh0dAxa7cj4
         hs8fbyOZ1JxHYg02OdfhQPUwFj6Ov+whJ4SzZLCjR+wHmb1YcHxdnYhD036gziSQGB9i
         emtPoKsoKUWmKnHeIS9qfrTshtohI4hEZyUAZstdlX1NOuVIMjY1KFL+E7wEL9cm5JBS
         1Ux8BDs6rQYRJedrPdNIOyXxr37bqF45fLxkdVAxkICdwYr8L5WdTDFGJukgL1vSP1bO
         vxpAf5ecGcjHtFpiJj+7TysD+bMML/dz4gMlaseqFe9Lhc2aXIBZjMhk0RmQLqpD5Fqo
         u1pA==
X-Gm-Message-State: AGi0PuZMmQyFKr0Yn8J9BbL9GAaWiZK2U3uX40N0mavN2cw2tOA9cUX+
        XYm9y52xMtO6x4RIsfzHwCBOVyyP
X-Google-Smtp-Source: APiQypKx5y6i+qQRuuxddiBzTHaHlefyUxbHIwQ7LohRMQ4YumrGm+iYRDhF+++ImYZitDBPpPe1Dw==
X-Received: by 2002:a0c:e204:: with SMTP id q4mr5026621qvl.16.1588354678082;
        Fri, 01 May 2020 10:37:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b10sm3035607qkl.19.2020.05.01.10.37.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:37:57 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HbuNE026731
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:37:56 GMT
Subject: [PATCH v1 2/8] SUNRPC: Add more svcsock tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:37:56 -0400
Message-ID: <20200501173756.3868.76227.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
References: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In addition to tracing recently-updated socket sendto events, this
commit adds a trace event class that can be used for additional
svcsock-related tracepoints in subsequent patches.

Commit 850cbaddb52d ("udp: use it's own memory accounting schema")
removed the last skb trace event from svcsock.c, so it is no
longer necessary to include trace/events/skb.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   97 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svcsock.c          |   30 ++++---------
 2 files changed, 107 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 561a438bcc66..95ee3d1a49c2 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,6 +14,39 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
+TRACE_DEFINE_ENUM(SOCK_STREAM);
+TRACE_DEFINE_ENUM(SOCK_DGRAM);
+TRACE_DEFINE_ENUM(SOCK_RAW);
+TRACE_DEFINE_ENUM(SOCK_RDM);
+TRACE_DEFINE_ENUM(SOCK_SEQPACKET);
+TRACE_DEFINE_ENUM(SOCK_DCCP);
+TRACE_DEFINE_ENUM(SOCK_PACKET);
+
+#define show_socket_type(type)					\
+	__print_symbolic(type,					\
+		{ SOCK_STREAM,		"STREAM" },		\
+		{ SOCK_DGRAM,		"DGRAM" },		\
+		{ SOCK_RAW,		"RAW" },		\
+		{ SOCK_RDM,		"RDM" },		\
+		{ SOCK_SEQPACKET,	"SEQPACKET" },		\
+		{ SOCK_DCCP,		"DCCP" },		\
+		{ SOCK_PACKET,		"PACKET" })
+
+/* This list is known to be incomplete, add new enums as needed. */
+TRACE_DEFINE_ENUM(AF_UNSPEC);
+TRACE_DEFINE_ENUM(AF_UNIX);
+TRACE_DEFINE_ENUM(AF_LOCAL);
+TRACE_DEFINE_ENUM(AF_INET);
+TRACE_DEFINE_ENUM(AF_INET6);
+
+#define rpc_show_address_family(family)				\
+	__print_symbolic(family,				\
+		{ AF_UNSPEC,		"AF_UNSPEC" },		\
+		{ AF_UNIX,		"AF_UNIX" },		\
+		{ AF_LOCAL,		"AF_LOCAL" },		\
+		{ AF_INET,		"AF_INET" },		\
+		{ AF_INET6,		"AF_INET6" })
+
 DECLARE_EVENT_CLASS(xdr_buf_class,
 	TP_PROTO(
 		const struct xdr_buf *xdr
@@ -1400,6 +1433,70 @@ DEFINE_SVC_DEFERRED_EVENT(drop);
 DEFINE_SVC_DEFERRED_EVENT(queue);
 DEFINE_SVC_DEFERRED_EVENT(recv);
 
+TRACE_EVENT(svcsock_new_socket,
+	TP_PROTO(
+		const struct socket *socket
+	),
+
+	TP_ARGS(socket),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, type)
+		__field(unsigned long, family)
+		__field(bool, listener)
+	),
+
+	TP_fast_assign(
+		__entry->type = socket->type;
+		__entry->family = socket->sk->sk_family;
+		__entry->listener = (socket->sk->sk_state == TCP_LISTEN);
+	),
+
+	TP_printk("type=%s family=%s%s",
+		show_socket_type(__entry->type),
+		rpc_show_address_family(__entry->family),
+		__entry->listener ? " (listener)" : ""
+	)
+);
+
+DECLARE_EVENT_CLASS(svcsock_class,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		ssize_t result
+	),
+
+	TP_ARGS(xprt, result),
+
+	TP_STRUCT__entry(
+		__field(ssize_t, result)
+		__field(unsigned long, flags)
+		__string(addr, xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->result = result;
+		__entry->flags = xprt->xpt_flags;
+		__assign_str(addr, xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s result=%zd flags=%s", __get_str(addr),
+		__entry->result, show_svc_xprt_flags(__entry->flags)
+	)
+);
+
+#define DEFINE_SVCSOCK_EVENT(name) \
+	DEFINE_EVENT(svcsock_class, svcsock_##name, \
+			TP_PROTO( \
+				const struct svc_xprt *xprt, \
+				ssize_t result \
+			), \
+			TP_ARGS(xprt, result))
+
+DEFINE_SVCSOCK_EVENT(udp_send);
+DEFINE_SVCSOCK_EVENT(tcp_send);
+DEFINE_SVCSOCK_EVENT(data_ready);
+DEFINE_SVCSOCK_EVENT(write_space);
+
 DECLARE_EVENT_CLASS(cache_event,
 	TP_PROTO(
 		const struct cache_detail *cd,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 1c4d0aacc531..758b835ad4ce 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -54,6 +54,8 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/xprt.h>
 
+#include <trace/events/sunrpc.h>
+
 #include "socklib.h"
 #include "sunrpc.h"
 
@@ -281,13 +283,10 @@ static void svc_data_ready(struct sock *sk)
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
 	if (svsk) {
-		dprintk("svc: socket %p(inet %p), busy=%d\n",
-			svsk, sk,
-			test_bit(XPT_BUSY, &svsk->sk_xprt.xpt_flags));
-
 		/* Refer to svc_setup_socket() for details. */
 		rmb();
 		svsk->sk_odata(sk);
+		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
 			svc_xprt_enqueue(&svsk->sk_xprt);
 	}
@@ -301,11 +300,9 @@ static void svc_write_space(struct sock *sk)
 	struct svc_sock	*svsk = (struct svc_sock *)(sk->sk_user_data);
 
 	if (svsk) {
-		dprintk("svc: socket %p(inet %p), write_space busy=%d\n",
-			svsk, sk, test_bit(XPT_BUSY, &svsk->sk_xprt.xpt_flags));
-
 		/* Refer to svc_setup_socket() for details. */
 		rmb();
+		trace_svcsock_write_space(&svsk->sk_xprt, 0);
 		svsk->sk_owspace(sk);
 		svc_xprt_enqueue(&svsk->sk_xprt);
 	}
@@ -545,6 +542,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
 		xdr_free_bvec(xdr);
 	}
+	trace_svcsock_udp_send(xprt, err);
 
 	mutex_unlock(&xprt->xpt_mutex);
 	if (err < 0)
@@ -616,7 +614,7 @@ static struct svc_xprt_class svc_udp_class = {
 
 static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 {
-	int err, level, optname, one = 1;
+	int level, optname, one = 1;
 
 	svc_xprt_init(sock_net(svsk->sk_sock->sk), &svc_udp_class,
 		      &svsk->sk_xprt, serv);
@@ -647,9 +645,8 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	default:
 		BUG();
 	}
-	err = kernel_setsockopt(svsk->sk_sock, level, optname,
-					(char *)&one, sizeof(one));
-	dprintk("svc: kernel_setsockopt returned %d\n", err);
+	kernel_setsockopt(svsk->sk_sock, level, optname, (char *)&one,
+			  sizeof(one));
 }
 
 /*
@@ -1100,6 +1097,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 		goto out_notconn;
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
 	xdr_free_bvec(xdr);
+	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
 	mutex_unlock(&xprt->xpt_mutex);
@@ -1170,13 +1168,11 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	set_bit(XPT_CACHE_AUTH, &svsk->sk_xprt.xpt_flags);
 	set_bit(XPT_CONG_CTRL, &svsk->sk_xprt.xpt_flags);
 	if (sk->sk_state == TCP_LISTEN) {
-		dprintk("setting up TCP socket for listening\n");
 		strcpy(svsk->sk_xprt.xpt_remotebuf, "listener");
 		set_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags);
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
-		dprintk("setting up TCP socket for reading\n");
 		sk->sk_state_change = svc_tcp_state_change;
 		sk->sk_data_ready = svc_data_ready;
 		sk->sk_write_space = svc_write_space;
@@ -1226,7 +1222,6 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	int		pmap_register = !(flags & SVC_SOCK_ANONYMOUS);
 	int		err = 0;
 
-	dprintk("svc: svc_setup_socket %p\n", sock);
 	svsk = kzalloc(sizeof(*svsk), GFP_KERNEL);
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
@@ -1263,12 +1258,7 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	else
 		svc_tcp_init(svsk, serv);
 
-	dprintk("svc: svc_setup_socket created %p (inet %p), "
-			"listen %d close %d\n",
-			svsk, svsk->sk_sk,
-			test_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags),
-			test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags));
-
+	trace_svcsock_new_socket(sock);
 	return svsk;
 }
 

