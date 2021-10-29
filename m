Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857E24403E2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2UNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 16:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhJ2UNt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Oct 2021 16:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8DA961038
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635538280;
        bh=iu1S8qx4hSTqkMu+LfsmgbFkbHORK//w//ExthNUifM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VKFY375tZtXt93b2YxkWbV62F/DscbVmwaUemlc8I5jHMQCMlmNwnk1xwb3zUtAr4
         aDFmHJwCsLB2HtD/KZuqLer2pqruFO9mrLa5Q3O3okdwO5zlPU1OQdSh1QV61GpdEv
         +gmRs0uHmJW6BuUsppR9sZF1yD4hWxY67fHHbJwMorS7zUtTM6aQEGLlmN2qiYTbx7
         2G/OMGj6bVxAASQ+/74uB+yDmMIeo8s0IwCSVSaOP2fqHxOptO2IPPWbGxlKVNLUX9
         p9QyLzWl+4TKHnbQxFeibapDttIkMbbTa355tyjbEfy1ktnMbjWa8oQHlNxboVBv3+
         Wknq9K24fvQdg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] SUNRPC: Clean up xs_tcp_setup_sock()
Date:   Fri, 29 Oct 2021 16:04:20 -0400
Message-Id: <20211029200421.65090-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029200421.65090-2-trondmy@kernel.org>
References: <20211029200421.65090-1-trondmy@kernel.org>
 <20211029200421.65090-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Move the error handling into a single switch statement for clarity.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 68 ++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 291b63136c08..7fb302e202bc 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2159,7 +2159,6 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 {
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
-	int ret = -ENOTCONN;
 
 	if (!transport->inet) {
 		struct sock *sk = sock->sk;
@@ -2203,7 +2202,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 	}
 
 	if (!xprt_bound(xprt))
-		goto out;
+		return -ENOTCONN;
 
 	xs_set_memalloc(xprt);
 
@@ -2211,22 +2210,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 	/* Tell the socket layer to start connecting... */
 	set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
-	ret = kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
-	switch (ret) {
-	case 0:
-		xs_set_srcport(transport, sock);
-		fallthrough;
-	case -EINPROGRESS:
-		/* SYN_SENT! */
-		if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
-			xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
-		break;
-	case -EADDRNOTAVAIL:
-		/* Source port number is unavailable. Try a new one! */
-		transport->srcport = 0;
-	}
-out:
-	return ret;
+	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
 }
 
 /**
@@ -2241,14 +2225,14 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 		container_of(work, struct sock_xprt, connect_worker.work);
 	struct socket *sock = transport->sock;
 	struct rpc_xprt *xprt = &transport->xprt;
-	int status = -EIO;
+	int status;
 
 	if (!sock) {
 		sock = xs_create_sock(xprt, transport,
 				xs_addr(xprt)->sa_family, SOCK_STREAM,
 				IPPROTO_TCP, true);
 		if (IS_ERR(sock)) {
-			status = PTR_ERR(sock);
+			xprt_wake_pending_tasks(xprt, PTR_ERR(sock));
 			goto out;
 		}
 	}
@@ -2265,21 +2249,21 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 			xprt, -status, xprt_connected(xprt),
 			sock->sk->sk_state);
 	switch (status) {
-	default:
-		printk("%s: connect returned unhandled error %d\n",
-			__func__, status);
-		fallthrough;
-	case -EADDRNOTAVAIL:
-		/* We're probably in TIME_WAIT. Get rid of existing socket,
-		 * and retry
-		 */
-		xs_tcp_force_close(xprt);
-		break;
 	case 0:
+		xs_set_srcport(transport, sock);
+		fallthrough;
 	case -EINPROGRESS:
+		/* SYN_SENT! */
+		if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
+			xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
+		fallthrough;
 	case -EALREADY:
-		xprt_unlock_connect(xprt, transport);
-		return;
+		goto out_unlock;
+	case -EADDRNOTAVAIL:
+		/* Source port number is unavailable. Try a new one! */
+		transport->srcport = 0;
+		status = -EAGAIN;
+		break;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
@@ -2291,18 +2275,22 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
-		/* xs_tcp_force_close() wakes tasks with a fixed error code.
-		 * We need to wake them first to ensure the correct error code.
-		 */
-		xprt_wake_pending_tasks(xprt, status);
-		xs_tcp_force_close(xprt);
-		goto out;
+		break;
+	default:
+		printk("%s: connect returned unhandled error %d\n",
+			__func__, status);
+		status = -EAGAIN;
 	}
-	status = -EAGAIN;
+
+	/* xs_tcp_force_close() wakes tasks with a fixed error code.
+	 * We need to wake them first to ensure the correct error code.
+	 */
+	xprt_wake_pending_tasks(xprt, status);
+	xs_tcp_force_close(xprt);
 out:
 	xprt_clear_connecting(xprt);
+out_unlock:
 	xprt_unlock_connect(xprt, transport);
-	xprt_wake_pending_tasks(xprt, status);
 }
 
 /**
-- 
2.31.1

