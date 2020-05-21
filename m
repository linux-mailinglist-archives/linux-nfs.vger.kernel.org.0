Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5D1DCFF2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgEUOfQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEUOfP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66223C061A0E;
        Thu, 21 May 2020 07:35:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x5so7660414ioh.6;
        Thu, 21 May 2020 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=stmkbiHWzCCZRNsPWiFjJVSrWBUV/AE/XfhmyB/uKqQ=;
        b=cJ3ni8koQbqUhAaEupZBRSij8wpDZTzlxBmbPvJhYt9lCVTgNT//d38AYKUqzfrETC
         V1cHSbEh+3yEo9h/52m15La22kacuSud3lpNKrYxkue0+RkTtzcdH9Oxr9q3LtO/NoOD
         N3Ysa0hyP5amYXcMmGZtZ9uTDbmJGVnPs9bNk5RTyIzcESE0WJ2ut5Rz+UYggYviLt35
         waSd6Wrpwv5hQcj6WNNNbRR2JQtjW64X0tCR/pUVgRn47kabeavioBD8Na2a3lJZBYr5
         nqHnulSs/JLCbebfxnF3+a4B90ScSOQ0590MpPJ+Jo+10Pjf1iCdsMYuLqrAbpEFHdiu
         SKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=stmkbiHWzCCZRNsPWiFjJVSrWBUV/AE/XfhmyB/uKqQ=;
        b=oOZTqhFcjm0OmGs5sAJbyEmjGezscSduQmNs3qjW/bU28xk7jnEu5GzGdE4zjeCB8n
         ITXb62CgbYYL5d79peVqqcEpz4rAHkRDi9+r42BCYrciKm+kMQYGkz+/P3odN4B7KS+j
         qgLnzcN576UdvfVPTeJ6a5zXWhZKQhfmQ+0F4mfn8U4QigOuyKbTFz1O20ocGExnOY5v
         9a1ks+j1dfOl5jdNHsW+uf75u6Q8WrCWQwXRv9sFahkjyGE2AIVDwIbVJi1raZ1SjzDK
         9IJy4xptqa6sbM0FDKXrK7iYO7yVOI8fVV8YG7K/vHL9MGyFnpRQ/qCZhUX3NfP2A1T4
         g6tA==
X-Gm-Message-State: AOAM531DCHKKV9lL9JA963dRzW7rinyycnhaIYccGqoLx6Y6Q8K5kmBv
        GkfzoYNGvzCQXsffOoFWFhWNqUbp
X-Google-Smtp-Source: ABdhPJxE6LEbZmp2CJkEo69I0UWKh9FldPdEw4yPUpz8Rh8/ylR29q+6IiwcoJc3e8VnaNZrUx04oQ==
X-Received: by 2002:a05:6638:bc4:: with SMTP id g4mr3969192jad.55.1590071714471;
        Thu, 21 May 2020 07:35:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o18sm2935334ils.30.2020.05.21.07.35.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:13 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZDcZ000878;
        Thu, 21 May 2020 14:35:13 GMT
Subject: [PATCH v3 17/32] SUNRPC: Replace dprintk call sites in TCP state
 change callouts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:13 -0400
Message-ID: <20200521143513.3557.11220.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Report TCP socket state changes and accept failures via
tracepoints, replacing dprintk() call sites.

No tracepoint is added in svc_tcp_listen_data_ready. There's
no information available there that isn't also reported by the
svcsock_new_socket and the accept failure tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   67 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svcsock.c          |   35 ++++-----------------
 2 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index bf086640b14a..ed8c991d4f04 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1481,6 +1481,73 @@ DEFINE_SVCSOCK_EVENT(tcp_send);
 DEFINE_SVCSOCK_EVENT(data_ready);
 DEFINE_SVCSOCK_EVENT(write_space);
 
+TRACE_EVENT(svcsock_tcp_state,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		const struct socket *socket
+	),
+
+	TP_ARGS(xprt, socket),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, socket_state)
+		__field(unsigned long, sock_state)
+		__field(unsigned long, flags)
+		__string(addr, xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->socket_state = socket->state;
+		__entry->sock_state = socket->sk->sk_state;
+		__entry->flags = xprt->xpt_flags;
+		__assign_str(addr, xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s state=%s sk_state=%s flags=%s", __get_str(addr),
+		rpc_show_socket_state(__entry->socket_state),
+		rpc_show_sock_state(__entry->sock_state),
+		show_svc_xprt_flags(__entry->flags)
+	)
+);
+
+DECLARE_EVENT_CLASS(svcsock_accept_class,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		const char *service,
+		long status
+	),
+
+	TP_ARGS(xprt, service, status),
+
+	TP_STRUCT__entry(
+		__field(long, status)
+		__string(service, service)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->status = status;
+		__assign_str(service, service);
+		memcpy(__entry->addr, &xprt->xpt_local, sizeof(__entry->addr));
+	),
+
+	TP_printk("listener=%pISpc service=%s status=%ld",
+		__entry->addr, __get_str(service), __entry->status
+	)
+);
+
+#define DEFINE_ACCEPT_EVENT(name) \
+	DEFINE_EVENT(svcsock_accept_class, svcsock_##name##_err, \
+			TP_PROTO( \
+				const struct svc_xprt *xprt, \
+				const char *service, \
+				long status \
+			), \
+			TP_ARGS(xprt, service, status))
+
+DEFINE_ACCEPT_EVENT(accept);
+DEFINE_ACCEPT_EVENT(getpeername);
+
 DECLARE_EVENT_CLASS(cache_event,
 	TP_PROTO(
 		const struct cache_detail *cd,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 758b835ad4ce..4ac1180c6306 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -657,9 +657,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
-	dprintk("svc: socket %p TCP (listen) state change %d\n",
-		sk, sk->sk_state);
-
 	if (svsk) {
 		/* Refer to svc_setup_socket() for details. */
 		rmb();
@@ -680,8 +677,7 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 		if (svsk) {
 			set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 			svc_xprt_enqueue(&svsk->sk_xprt);
-		} else
-			printk("svc: socket %p: no user data\n", sk);
+		}
 	}
 }
 
@@ -692,15 +688,11 @@ static void svc_tcp_state_change(struct sock *sk)
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
-	dprintk("svc: socket %p TCP (connected) state change %d (svsk %p)\n",
-		sk, sk->sk_state, sk->sk_user_data);
-
-	if (!svsk)
-		printk("svc: socket %p: no user data\n", sk);
-	else {
+	if (svsk) {
 		/* Refer to svc_setup_socket() for details. */
 		rmb();
 		svsk->sk_ostate(sk);
+		trace_svcsock_tcp_state(&svsk->sk_xprt, svsk->sk_sock);
 		if (sk->sk_state != TCP_ESTABLISHED) {
 			set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
 			svc_xprt_enqueue(&svsk->sk_xprt);
@@ -721,7 +713,6 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	struct socket	*newsock;
 	struct svc_sock	*newsvsk;
 	int		err, slen;
-	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
 	if (!sock)
 		return NULL;
@@ -735,30 +726,18 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 		else if (err != -EAGAIN)
 			net_warn_ratelimited("%s: accept failed (err %d)!\n",
 					     serv->sv_name, -err);
+		trace_svcsock_accept_err(xprt, serv->sv_name, err);
 		return NULL;
 	}
 	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 
 	err = kernel_getpeername(newsock, sin);
 	if (err < 0) {
-		net_warn_ratelimited("%s: peername failed (err %d)!\n",
-				     serv->sv_name, -err);
+		trace_svcsock_getpeername_err(xprt, serv->sv_name, err);
 		goto failed;		/* aborted connection or whatever */
 	}
 	slen = err;
 
-	/* Ideally, we would want to reject connections from unauthorized
-	 * hosts here, but when we get encryption, the IP of the host won't
-	 * tell us anything.  For now just warn about unpriv connections.
-	 */
-	if (!svc_port_is_privileged(sin)) {
-		dprintk("%s: connect from unprivileged port: %s\n",
-			serv->sv_name,
-			__svc_print_addr(sin, buf, sizeof(buf)));
-	}
-	dprintk("%s: connect from %s\n", serv->sv_name,
-		__svc_print_addr(sin, buf, sizeof(buf)));
-
 	/* Reset the inherited callbacks before calling svc_setup_socket */
 	newsock->sk->sk_state_change = svsk->sk_ostate;
 	newsock->sk->sk_data_ready = svsk->sk_odata;
@@ -776,10 +755,8 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	svc_xprt_set_remote(&newsvsk->sk_xprt, sin, slen);
 	err = kernel_getsockname(newsock, sin);
 	slen = err;
-	if (unlikely(err < 0)) {
-		dprintk("svc_tcp_accept: kernel_getsockname error %d\n", -err);
+	if (unlikely(err < 0))
 		slen = offsetof(struct sockaddr, sa_data);
-	}
 	svc_xprt_set_local(&newsvsk->sk_xprt, sin, slen);
 
 	if (sock_is_loopback(newsock->sk))

