Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E04403E1
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhJ2UNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 16:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhJ2UNs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Oct 2021 16:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70903603E5
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635538279;
        bh=rO06O1P79Via9XHPXh/lB7OrQETtXnneA2VchLVjzVw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LQCKFHlYqfsPgMjdjo0/uVvbjib9XAf42riGdbR3zPOx2hc2pGHfCDY8h2GV4ur8d
         byccFU+t8t0maJjc0qS11YCCsz/sTh2jkgIAZLqvElSnwSmimAhbPUIofAcPeX+6kD
         ceKfVIekmLrt5gkjE31Kvr8NCyMKt5T/tdXHvedFq+EtF22PS3ZtV+JeL6Xs/tpywP
         FYDrKwIm8k+Giec0FJWmD8JC4jVdr78v+L7xfsWuunWsNQCfi2Vkd33wul19jFOyDn
         6kf11bPihr7od5twFB3J/zFUI1MJmfsUjAKtz+tWM5iV8NmBcANWDZcY37KT7tR5y0
         BnDnDj0QYM+Qw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] SUNRPC: Replace use of socket sk_callback_lock with sock_lock
Date:   Fri, 29 Oct 2021 16:04:19 -0400
Message-Id: <20211029200421.65090-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029200421.65090-1-trondmy@kernel.org>
References: <20211029200421.65090-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since we do things like setting flags, etc it really is more appropriate
to use sock_lock().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b18d13479104..291b63136c08 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1154,14 +1154,13 @@ static void xs_error_report(struct sock *sk)
 	struct sock_xprt *transport;
 	struct rpc_xprt *xprt;
 
-	read_lock_bh(&sk->sk_callback_lock);
 	if (!(xprt = xprt_from_sock(sk)))
-		goto out;
+		return;
 
 	transport = container_of(xprt, struct sock_xprt, xprt);
 	transport->xprt_err = -sk->sk_err;
 	if (transport->xprt_err == 0)
-		goto out;
+		return;
 	dprintk("RPC:       xs_error_report client %p, error=%d...\n",
 			xprt, -transport->xprt_err);
 	trace_rpc_socket_error(xprt, sk->sk_socket, transport->xprt_err);
@@ -1169,8 +1168,6 @@ static void xs_error_report(struct sock *sk)
 	/* barrier ensures xprt_err is set before XPRT_SOCK_WAKE_ERROR */
 	smp_mb__before_atomic();
 	xs_run_error_worker(transport, XPRT_SOCK_WAKE_ERROR);
- out:
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void xs_reset_transport(struct sock_xprt *transport)
@@ -1189,7 +1186,7 @@ static void xs_reset_transport(struct sock_xprt *transport)
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 
 	mutex_lock(&transport->recv_mutex);
-	write_lock_bh(&sk->sk_callback_lock);
+	lock_sock(sk);
 	transport->inet = NULL;
 	transport->sock = NULL;
 	transport->file = NULL;
@@ -1198,10 +1195,10 @@ static void xs_reset_transport(struct sock_xprt *transport)
 
 	xs_restore_old_callbacks(transport, sk);
 	xprt_clear_connected(xprt);
-	write_unlock_bh(&sk->sk_callback_lock);
 	xs_sock_reset_connection_flags(xprt);
 	/* Reset stream record info */
 	xs_stream_reset_connect(transport);
+	release_sock(sk);
 	mutex_unlock(&transport->recv_mutex);
 
 	trace_rpc_socket_close(xprt, sock);
@@ -1365,7 +1362,6 @@ static void xs_data_ready(struct sock *sk)
 {
 	struct rpc_xprt *xprt;
 
-	read_lock_bh(&sk->sk_callback_lock);
 	dprintk("RPC:       xs_data_ready...\n");
 	xprt = xprt_from_sock(sk);
 	if (xprt != NULL) {
@@ -1380,7 +1376,6 @@ static void xs_data_ready(struct sock *sk)
 		if (!test_and_set_bit(XPRT_SOCK_DATA_READY, &transport->sock_state))
 			queue_work(xprtiod_workqueue, &transport->recv_worker);
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 /*
@@ -1409,9 +1404,8 @@ static void xs_tcp_state_change(struct sock *sk)
 	struct rpc_xprt *xprt;
 	struct sock_xprt *transport;
 
-	read_lock_bh(&sk->sk_callback_lock);
 	if (!(xprt = xprt_from_sock(sk)))
-		goto out;
+		return;
 	dprintk("RPC:       xs_tcp_state_change client %p...\n", xprt);
 	dprintk("RPC:       state %x conn %d dead %d zapped %d sk_shutdown %d\n",
 			sk->sk_state, xprt_connected(xprt),
@@ -1472,8 +1466,6 @@ static void xs_tcp_state_change(struct sock *sk)
 		/* Trigger the socket release */
 		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
 	}
- out:
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void xs_write_space(struct sock *sk)
@@ -1512,13 +1504,9 @@ static void xs_write_space(struct sock *sk)
  */
 static void xs_udp_write_space(struct sock *sk)
 {
-	read_lock_bh(&sk->sk_callback_lock);
-
 	/* from net/core/sock.c:sock_def_write_space */
 	if (sock_writeable(sk))
 		xs_write_space(sk);
-
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 /**
@@ -1533,13 +1521,9 @@ static void xs_udp_write_space(struct sock *sk)
  */
 static void xs_tcp_write_space(struct sock *sk)
 {
-	read_lock_bh(&sk->sk_callback_lock);
-
 	/* from net/core/stream.c:sk_stream_write_space */
 	if (sk_stream_is_writeable(sk))
 		xs_write_space(sk);
-
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void xs_udp_do_set_buffer_size(struct rpc_xprt *xprt)
@@ -1834,7 +1818,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 	if (!transport->inet) {
 		struct sock *sk = sock->sk;
 
-		write_lock_bh(&sk->sk_callback_lock);
+		lock_sock(sk);
 
 		xs_save_old_callbacks(transport, sk);
 
@@ -1850,7 +1834,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		transport->sock = sock;
 		transport->inet = sk;
 
-		write_unlock_bh(&sk->sk_callback_lock);
+		release_sock(sk);
 	}
 
 	xs_stream_start_connect(transport);
@@ -2032,7 +2016,7 @@ static void xs_udp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 	if (!transport->inet) {
 		struct sock *sk = sock->sk;
 
-		write_lock_bh(&sk->sk_callback_lock);
+		lock_sock(sk);
 
 		xs_save_old_callbacks(transport, sk);
 
@@ -2049,7 +2033,7 @@ static void xs_udp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 		xs_set_memalloc(xprt);
 
-		write_unlock_bh(&sk->sk_callback_lock);
+		release_sock(sk);
 	}
 	xs_udp_do_set_buffer_size(xprt);
 
@@ -2195,7 +2179,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		xs_tcp_set_socket_timeouts(xprt, sock);
 		tcp_sock_set_nodelay(sk);
 
-		write_lock_bh(&sk->sk_callback_lock);
+		lock_sock(sk);
 
 		xs_save_old_callbacks(transport, sk);
 
@@ -2215,7 +2199,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		transport->sock = sock;
 		transport->inet = sk;
 
-		write_unlock_bh(&sk->sk_callback_lock);
+		release_sock(sk);
 	}
 
 	if (!xprt_bound(xprt))
-- 
2.31.1

