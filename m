Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75C71E919A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgE3N3m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3N3m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6235C03E969;
        Sat, 30 May 2020 06:29:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y18so2319141iow.3;
        Sat, 30 May 2020 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/sRqLmRYc9bjxHRmqoe3ap8ylNJEgtFgIiEVKoCfaB0=;
        b=OasrAyDueFsL2vsN4JHghybIOmuszpZ526lSLN0F18/aIKjY9n2Z/y8McfV93lg1Gv
         g6GlsZA8fmtMFyj79qxWymZeFLH/Wzm1plbPlKs1PcSIDXTlMkMMJwHDKYqx0+8/eGt3
         ydf9jALDwc3JC5+49zYJ6vVk2NXmlMoHrR6iwjaXPdQheS8EDgwx8PEfqZxxk3s0UFeI
         z8Eo2josiBl6Z1h74d9Nj9CWaLAKTwJhnZ+OZCMPSJ5cNXE2jL9np2zf+Kjf8jGIceUH
         HCFZGQQDp74A4Pv35SWQvR+035ljywMzoX0YkRZCgquKxKGbKZ8S6h5B1c+5QBA/Ct8J
         g0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/sRqLmRYc9bjxHRmqoe3ap8ylNJEgtFgIiEVKoCfaB0=;
        b=WQbHUQC5WMJRJVHTH88xAFUmlxl+LZ3LiYN+ohG+rG8iwNKgGLQLHpt2C0wQTZ5xIi
         ZEODS7TZGfsywo5DSRPvMoTwumkfQhJOGhuCpNLpJpq7W10zx9DihExC7ebm+aFM3KAT
         WhlJhSa8vPvj2xj/W9+6ZeWi0Fc8UstfQJM2XYa9QzBj3GZn+JNasPKawsHriP+UXyBk
         ZvvzsCip3Di0cO9u0aIDlD/s3GvTpTNqu2UrhvjeFEbOkv1QOUlg3JBbJivSCOcj65U3
         4TlWl2U82St3b0U0OneOGlriDczuRn8jWpoIA507Xlb2Rb2Ns50voWzg9a3GOjMXpFRe
         1wIg==
X-Gm-Message-State: AOAM530opyrMRiBmW78bqf0oU3xz3Gqjh4DGQh7mInDAJs0WBpv+hMnx
        RqbgYTwbsrzQIkKP4cmjYksLTHYg
X-Google-Smtp-Source: ABdhPJyZlCFuOEMYxfSsZVWOtqyjM7k1vowcbqazLS2q6oDJJrS+PMVI05tJ9MmDzuERT0ekXm9Sng==
X-Received: by 2002:a05:6638:cb2:: with SMTP id x18mr12528593jad.6.1590845380038;
        Sat, 30 May 2020 06:29:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l21sm6668185ili.8.2020.05.30.06.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:39 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTcVV001438;
        Sat, 30 May 2020 13:29:38 GMT
Subject: [PATCH v4 18/33] SUNRPC: Replace dprintk call sites in TCP state
 change callouts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:38 -0400
Message-ID: <20200530132938.10117.17749.stgit@klimt.1015granger.net>
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
index fdc44675f347..8691fbeaff17 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1500,6 +1500,73 @@ DEFINE_SVCSOCK_EVENT(tcp_send);
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

