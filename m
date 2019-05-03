Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AED12C3D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfECLWe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 07:22:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54481 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECLWd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 07:22:33 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so8488567ite.4
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PIeb4QrzDhjMmLSKtovb3fEeWKpzRXqV0qXTt7d2m0=;
        b=oJ5zUWUu2bcoPIVvvG6RwOY98xiEiO54raLRRaHw9EJhnT7nS90lOWuYujWvND1mrL
         2vxbY6u804azLJZ5AN/M1Ogr90Klvli6mn3t+z83DhYM6dXyhutpV46rFpT3xe8gPGeW
         VybG+/iCOLNn9MWbRYM/FH80k8PZUG5nt17QOzgtME0DrbPzAnNKHDPfJ0683GRdDr4j
         nltDr+M66qZMixG3i3vpciWeA47hgaIU7b0nwkCmhosECWgf28xWfo1ERh9/h7EYsbi4
         Obpxqk7NUxnUXHXPWrG9Fv7wReQQs0u33aJcj/pZ7kLgvnIefP00qhQ/UNhlh8N8u7Hf
         +mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PIeb4QrzDhjMmLSKtovb3fEeWKpzRXqV0qXTt7d2m0=;
        b=LiFNDvDc720Qq+/LN43Zz8bmEZeum9b9LKgzfc2XbE14qHwcCwR/3nLrEzKlD6HCy+
         eHANM0vITuF2bvmX7pvRhCQDwdW5oykO3SQz6PCItEbKcPLaPdiJSORbAsObzGgYQA62
         Pxk/ZH2TyxPOurgciM9Zma5cTK7CBDI4/wMbv05hNTVFxL/+SG6LeA6Ab9/8OvXzpIhq
         qW52NiYGBlhw+ZVzBj+7NBkAV9pQE+cDATWUNH+LNXDrvG5Gr6OWEpyBwOmHLZTGbnCd
         gP++151hr2DQU4IJCDxxZW+/F7N5/8quvsi5L41Gw7WKRWqdbqotvGnMF/LDPBInHBED
         o64g==
X-Gm-Message-State: APjAAAVUSd+7xtC5lpWdOCfk76LeVL4mA22wLlkSboh8ft/E35aXYJms
        abosTrHxfeOgXl7pqi2s3cO8bu4ZKw==
X-Google-Smtp-Source: APXvYqy/9gTmOXCk/3QYVX9sFpDXNCqxN42HAOaP6pSlAiLYeuzujahMn9Nxq3pGTxc8UxEvJLTs9g==
X-Received: by 2002:a02:a394:: with SMTP id y20mr6600515jak.96.1556882552700;
        Fri, 03 May 2019 04:22:32 -0700 (PDT)
Received: from localhost.localdomain ([8.46.76.65])
        by smtp.gmail.com with ESMTPSA id d193sm737325iog.34.2019.05.03.04.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:22:31 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/5] SUNRPC: Replace direct task wakeups from softirq context
Date:   Fri,  3 May 2019 06:18:38 -0500
Message-Id: <20190503111841.4391-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503111841.4391-2-trond.myklebust@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace the direct task wakeups from inside a softirq context with
wakeups from a process context.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprtsock.h |  5 +++
 net/sunrpc/xprtsock.c           | 78 ++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index b81d0b3e0799..7638dbe7bc50 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -56,6 +56,7 @@ struct sock_xprt {
 	 */
 	unsigned long		sock_state;
 	struct delayed_work	connect_worker;
+	struct work_struct	error_worker;
 	struct work_struct	recv_worker;
 	struct mutex		recv_mutex;
 	struct sockaddr_storage	srcaddr;
@@ -84,6 +85,10 @@ struct sock_xprt {
 #define XPRT_SOCK_CONNECTING	1U
 #define XPRT_SOCK_DATA_READY	(2)
 #define XPRT_SOCK_UPD_TIMEOUT	(3)
+#define XPRT_SOCK_WAKE_ERROR	(4)
+#define XPRT_SOCK_WAKE_WRITE	(5)
+#define XPRT_SOCK_WAKE_PENDING	(6)
+#define XPRT_SOCK_WAKE_DISCONNECT	(7)
 
 #endif /* __KERNEL__ */
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c69951ed2ebc..e0195b1a0c18 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1211,6 +1211,15 @@ static void xs_sock_reset_state_flags(struct rpc_xprt *xprt)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 
 	clear_bit(XPRT_SOCK_DATA_READY, &transport->sock_state);
+	clear_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state);
+	clear_bit(XPRT_SOCK_WAKE_WRITE, &transport->sock_state);
+	clear_bit(XPRT_SOCK_WAKE_DISCONNECT, &transport->sock_state);
+}
+
+static void xs_run_error_worker(struct sock_xprt *transport, unsigned int nr)
+{
+	set_bit(nr, &transport->sock_state);
+	queue_work(xprtiod_workqueue, &transport->error_worker);
 }
 
 static void xs_sock_reset_connection_flags(struct rpc_xprt *xprt)
@@ -1231,6 +1240,7 @@ static void xs_sock_reset_connection_flags(struct rpc_xprt *xprt)
  */
 static void xs_error_report(struct sock *sk)
 {
+	struct sock_xprt *transport;
 	struct rpc_xprt *xprt;
 	int err;
 
@@ -1238,13 +1248,14 @@ static void xs_error_report(struct sock *sk)
 	if (!(xprt = xprt_from_sock(sk)))
 		goto out;
 
+	transport = container_of(xprt, struct sock_xprt, xprt);
 	err = -sk->sk_err;
 	if (err == 0)
 		goto out;
 	dprintk("RPC:       xs_error_report client %p, error=%d...\n",
 			xprt, -err);
 	trace_rpc_socket_error(xprt, sk->sk_socket, err);
-	xprt_wake_pending_tasks(xprt, err);
+	xs_run_error_worker(transport, XPRT_SOCK_WAKE_ERROR);
  out:
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1507,7 +1518,7 @@ static void xs_tcp_state_change(struct sock *sk)
 			xprt->stat.connect_count++;
 			xprt->stat.connect_time += (long)jiffies -
 						   xprt->stat.connect_start;
-			xprt_wake_pending_tasks(xprt, -EAGAIN);
+			xs_run_error_worker(transport, XPRT_SOCK_WAKE_PENDING);
 		}
 		spin_unlock(&xprt->transport_lock);
 		break;
@@ -1525,7 +1536,7 @@ static void xs_tcp_state_change(struct sock *sk)
 		/* The server initiated a shutdown of the socket */
 		xprt->connect_cookie++;
 		clear_bit(XPRT_CONNECTED, &xprt->state);
-		xs_tcp_force_close(xprt);
+		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
 		/* fall through */
 	case TCP_CLOSING:
 		/*
@@ -1547,7 +1558,7 @@ static void xs_tcp_state_change(struct sock *sk)
 			xprt_clear_connecting(xprt);
 		clear_bit(XPRT_CLOSING, &xprt->state);
 		/* Trigger the socket release */
-		xs_tcp_force_close(xprt);
+		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
 	}
  out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1556,6 +1567,7 @@ static void xs_tcp_state_change(struct sock *sk)
 static void xs_write_space(struct sock *sk)
 {
 	struct socket_wq *wq;
+	struct sock_xprt *transport;
 	struct rpc_xprt *xprt;
 
 	if (!sk->sk_socket)
@@ -1564,13 +1576,14 @@ static void xs_write_space(struct sock *sk)
 
 	if (unlikely(!(xprt = xprt_from_sock(sk))))
 		return;
+	transport = container_of(xprt, struct sock_xprt, xprt);
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
 	if (!wq || test_and_clear_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags) == 0)
 		goto out;
 
-	if (xprt_write_space(xprt))
-		sk->sk_write_pending--;
+	xs_run_error_worker(transport, XPRT_SOCK_WAKE_WRITE);
+	sk->sk_write_pending--;
 out:
 	rcu_read_unlock();
 }
@@ -2461,6 +2474,56 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 			delay);
 }
 
+static void xs_wake_disconnect(struct sock_xprt *transport)
+{
+	if (test_and_clear_bit(XPRT_SOCK_WAKE_DISCONNECT, &transport->sock_state))
+		xs_tcp_force_close(&transport->xprt);
+}
+
+static void xs_wake_write(struct sock_xprt *transport)
+{
+	if (test_and_clear_bit(XPRT_SOCK_WAKE_WRITE, &transport->sock_state))
+		xprt_write_space(&transport->xprt);
+}
+
+static void xs_wake_error(struct sock_xprt *transport)
+{
+	int sockerr;
+	int sockerr_len = sizeof(sockerr);
+
+	if (!test_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state))
+		return;
+	mutex_lock(&transport->recv_mutex);
+	if (transport->sock == NULL)
+		goto out;
+	if (!test_and_clear_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state))
+		goto out;
+	if (kernel_getsockopt(transport->sock, SOL_SOCKET, SO_ERROR,
+				(char *)&sockerr, &sockerr_len) != 0)
+		goto out;
+	if (sockerr < 0)
+		xprt_wake_pending_tasks(&transport->xprt, sockerr);
+out:
+	mutex_unlock(&transport->recv_mutex);
+}
+
+static void xs_wake_pending(struct sock_xprt *transport)
+{
+	if (test_and_clear_bit(XPRT_SOCK_WAKE_PENDING, &transport->sock_state))
+		xprt_wake_pending_tasks(&transport->xprt, -EAGAIN);
+}
+
+static void xs_error_handle(struct work_struct *work)
+{
+	struct sock_xprt *transport = container_of(work,
+			struct sock_xprt, error_worker);
+
+	xs_wake_disconnect(transport);
+	xs_wake_write(transport);
+	xs_wake_error(transport);
+	xs_wake_pending(transport);
+}
+
 /**
  * xs_local_print_stats - display AF_LOCAL socket-specifc stats
  * @xprt: rpc_xprt struct containing statistics
@@ -2873,6 +2936,7 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 	xprt->timeout = &xs_local_default_timeout;
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
+	INIT_WORK(&transport->error_worker, xs_error_handle);
 	INIT_DELAYED_WORK(&transport->connect_worker, xs_dummy_setup_socket);
 
 	switch (sun->sun_family) {
@@ -2943,6 +3007,7 @@ static struct rpc_xprt *xs_setup_udp(struct xprt_create *args)
 	xprt->timeout = &xs_udp_default_timeout;
 
 	INIT_WORK(&transport->recv_worker, xs_udp_data_receive_workfn);
+	INIT_WORK(&transport->error_worker, xs_error_handle);
 	INIT_DELAYED_WORK(&transport->connect_worker, xs_udp_setup_socket);
 
 	switch (addr->sa_family) {
@@ -3024,6 +3089,7 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 		(xprt->timeout->to_retries + 1);
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
+	INIT_WORK(&transport->error_worker, xs_error_handle);
 	INIT_DELAYED_WORK(&transport->connect_worker, xs_tcp_setup_socket);
 
 	switch (addr->sa_family) {
-- 
2.21.0

