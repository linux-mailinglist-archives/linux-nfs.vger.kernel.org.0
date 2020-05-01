Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7C1C1BF4
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgEARiE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARiE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F4C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g16so4505889qtp.11
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QuMsnTvS/IK7TWa2P2FA2ktebEJNuKiUIuY0v+J4dSk=;
        b=mcIDFDsifngYlOX6I7vVJ3wsWp9OLhmPxv5/Lky01JvXVqLH6ZW+P8iL6o+FGPXrnA
         p/FVw5pazNpE6WMts+CBxL7Iq4MZWyoCiIXiMsmONPQugN80g9cqhRUPv21BvkPWOQH6
         IaRqGCIol8IX3bZmfFymfltx2cXDEI+vdWVlvoV+4FNMfbQ05uAMHqcAUhvZIMKlyDVH
         2KOsSRR4FAB7tMyQXNLhen6JbaUIBNJA4r+Dg/8KTlCPYFbGZGzWn50yQCa4VtWNDH0N
         MRyP6+rTCAL2Am0gHthFG7KI1Ti5c55MtNy3I8LB1hn0OjwSBAGR8T0MAT1AXlhgGpXr
         07Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QuMsnTvS/IK7TWa2P2FA2ktebEJNuKiUIuY0v+J4dSk=;
        b=s94Bqx6djVCYPcXDAxDSOlCsXynq8B7K99A6ul1YD/FnaOXzlnPNmPiqZBaa1yV3HT
         mTxQesNPmJRORp5KOg4ufzCzQ0TOxK0xfuy6hGp7HpbOwF71aGRJGZFuWvGv5f6o1nez
         eG5EJ3pELhiVjDNnSUMXzqmHuCzdBknpigzpYWqoUDcS/4t+WN//WnmC2n49xWi/+61/
         jPl0vR4cdNpISPGRkUps1jsyqw1/RDoQWA8DcjvDPpEpzA3TuN68ZbT7qeQFzrn4rPIp
         mYgMfdKpTKfGB7OncJEbLgAbRrwCfgsW5RlUH/Q8NLz0xv0+tpH+cy7SO7wrEkkH6kAp
         1foQ==
X-Gm-Message-State: AGi0PuaI4K5uyuJms2NIusJaxt7mZqPU1VhoyPwAdUpQtH/nbA2dJ1KX
        ZqiXY6SupSyUhv3RkswbkGImGGxi
X-Google-Smtp-Source: APiQypIR4fVNgYa4FTSyD7v/e5M6PJlsIeMw4NSH3RiEIckjxlbeVsoLHLWki+JS4DEPiNyFjJCe+w==
X-Received: by 2002:aed:34c3:: with SMTP id x61mr4621312qtd.333.1588354682959;
        Fri, 01 May 2020 10:38:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e186sm3144411qkb.40.2020.05.01.10.38.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:38:02 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041Hc19l026734
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:38:01 GMT
Subject: [PATCH v1 3/8] SUNRPC: Replace dprintk call sites in TCP state
 change callouts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:38:01 -0400
Message-ID: <20200501173801.3868.35817.stgit@klimt.1015granger.net>
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
index 95ee3d1a49c2..cb839ceba89e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1497,6 +1497,73 @@ DEFINE_SVCSOCK_EVENT(tcp_send);
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

