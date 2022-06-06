Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702953E6D9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiFFOvw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiFFOvv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43E18AD81
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1607D614B3
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F768C34115;
        Mon,  6 Jun 2022 14:51:47 +0000 (UTC)
Subject: [PATCH v2 12/15] SUNRPC: Add RPC-with-TLS support to xprtsock.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:46 -0400
Message-ID: <165452710606.1496.14773661487729121787.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprtsock.h |    1 
 net/sunrpc/xprtsock.c           |  243 ++++++++++++++++++++++++++++++++-------
 2 files changed, 201 insertions(+), 43 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index e0b6009f1f69..eaf3d705f758 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -57,6 +57,7 @@ struct sock_xprt {
 	struct work_struct	error_worker;
 	struct work_struct	recv_worker;
 	struct mutex		recv_mutex;
+	struct completion	handshake_done;
 	struct sockaddr_storage	srcaddr;
 	unsigned short		srcport;
 	int			xprt_err;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index a4fee00412d4..63fe97ede573 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -48,6 +48,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tlsh.h>
 
 #include <linux/bvec.h>
 #include <linux/highmem.h>
@@ -197,6 +198,11 @@ static struct ctl_table sunrpc_table[] = {
  */
 #define XS_IDLE_DISC_TO		(5U * 60 * HZ)
 
+/*
+ * TLS handshake timeout.
+ */
+#define XS_TLS_HANDSHAKE_TO    (20U * HZ)
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # undef  RPC_DEBUG_DATA
 # define RPCDBG_FACILITY	RPCDBG_TRANS
@@ -1254,6 +1260,8 @@ static void xs_reset_transport(struct sock_xprt *transport)
 	if (atomic_read(&transport->xprt.swapper))
 		sk_clear_memalloc(sk);
 
+	/* TODO: Maybe send a TLS Closure alert */
+
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 
 	mutex_lock(&transport->recv_mutex);
@@ -2424,6 +2432,147 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 
 #if IS_ENABLED(CONFIG_TLS)
 
+/**
+ * xs_tls_handshake_done - TLS handshake completion handler
+ * @data: address of xprt to wake
+ * @status: status of handshake
+ *
+ */
+static void xs_tls_handshake_done(void *data, int status)
+{
+	struct rpc_xprt *xprt = data;
+	struct sock_xprt *transport =
+				container_of(xprt, struct sock_xprt, xprt);
+
+	transport->xprt_err = status ? -EACCES : 0;
+	complete(&transport->handshake_done);
+	xprt_put(xprt);
+}
+
+static int xs_tls_handshake_sync(struct rpc_xprt *xprt, unsigned int xprtsec)
+{
+	struct sock_xprt *transport =
+				container_of(xprt, struct sock_xprt, xprt);
+	int rc;
+
+	init_completion(&transport->handshake_done);
+	set_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
+
+	transport->xprt_err = -ETIMEDOUT;
+	switch (xprtsec) {
+	case RPC_XPRTSEC_TLS_X509:
+		rc = tls_client_hello_x509(transport->sock,
+					   xs_tls_handshake_done, xprt_get(xprt),
+					   TLSH_DEFAULT_PRIORITIES, TLSH_NO_PEERID,
+					   TLSH_NO_CERT);
+		break;
+	case RPC_XPRTSEC_TLS_PSK:
+		rc = tls_client_hello_psk(transport->sock, xs_tls_handshake_done,
+					  xprt_get(xprt), TLSH_DEFAULT_PRIORITIES,
+					  TLSH_NO_PEERID);
+		break;
+	default:
+		rc = -EACCES;
+	}
+	if (rc)
+		goto out;
+
+	rc = wait_for_completion_interruptible_timeout(&transport->handshake_done,
+						       XS_TLS_HANDSHAKE_TO);
+	if (rc < 0)
+		goto out;
+
+	rc = transport->xprt_err;
+
+out:
+	xs_stream_reset_connect(transport);
+	clear_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
+	return rc;
+}
+
+/*
+ * Transfer the connected socket to @dst_transport, then mark that
+ * xprt CONNECTED.
+ */
+static int xs_tls_finish_connecting(struct rpc_xprt *src_xprt,
+				    struct sock_xprt *dst_transport)
+{
+	struct sock_xprt *src_transport =
+			container_of(src_xprt, struct sock_xprt, xprt);
+	struct rpc_xprt *dst_xprt = &dst_transport->xprt;
+
+	if (!dst_transport->inet) {
+		struct socket *sock = src_transport->sock;
+		struct sock *sk = sock->sk;
+
+		/* Avoid temporary address, they are bad for long-lived
+		 * connections such as NFS mounts.
+		 * RFC4941, section 3.6 suggests that:
+		 *    Individual applications, which have specific
+		 *    knowledge about the normal duration of connections,
+		 *    MAY override this as appropriate.
+		 */
+		if (xs_addr(dst_xprt)->sa_family == PF_INET6) {
+			ip6_sock_set_addr_preferences(sk,
+				IPV6_PREFER_SRC_PUBLIC);
+		}
+
+		xs_tcp_set_socket_timeouts(dst_xprt, sock);
+		tcp_sock_set_nodelay(sk);
+
+		lock_sock(sk);
+
+		/*
+		 * @sk is already connected, so it now has the RPC callbacks.
+		 * Reach into @src_transport to save the original ones.
+		 */
+		dst_transport->old_data_ready = src_transport->old_data_ready;
+		dst_transport->old_state_change = src_transport->old_state_change;
+		dst_transport->old_write_space = src_transport->old_write_space;
+		dst_transport->old_error_report = src_transport->old_error_report;
+		sk->sk_user_data = dst_xprt;
+
+		/* socket options */
+		sock_reset_flag(sk, SOCK_LINGER);
+
+		xprt_clear_connected(dst_xprt);
+
+		dst_transport->sock = sock;
+		dst_transport->inet = sk;
+		dst_transport->file = src_transport->file;
+
+		release_sock(sk);
+
+		/* Reset src_transport before shutting down its clnt */
+		mutex_lock(&src_transport->recv_mutex);
+		src_transport->inet = NULL;
+		src_transport->sock = NULL;
+		src_transport->file = NULL;
+
+		xprt_clear_connected(src_xprt);
+		xs_sock_reset_connection_flags(src_xprt);
+		xs_stream_reset_connect(src_transport);
+		mutex_unlock(&src_transport->recv_mutex);
+	}
+
+	if (!xprt_bound(dst_xprt))
+		return -ENOTCONN;
+
+	xs_set_memalloc(dst_xprt);
+
+	if (!xprt_test_and_set_connected(dst_xprt)) {
+		dst_xprt->connect_cookie++;
+		clear_bit(XPRT_SOCK_CONNECTING, &dst_transport->sock_state);
+		xprt_clear_connecting(dst_xprt);
+
+		dst_xprt->stat.connect_count++;
+		dst_xprt->stat.connect_time += (long)jiffies -
+					   dst_xprt->stat.connect_start;
+		xs_run_error_worker(dst_transport, XPRT_SOCK_WAKE_PENDING);
+	}
+	return 0;
+}
+
 /**
  * xs_tls_connect - establish a TLS session on a socket
  * @work: queued work item
@@ -2433,61 +2582,70 @@ static void xs_tls_connect(struct work_struct *work)
 {
 	struct sock_xprt *transport =
 		container_of(work, struct sock_xprt, connect_worker.work);
+	struct rpc_create_args args = {
+		.net		= transport->xprt.xprt_net,
+		.protocol	= transport->xprt.prot,
+		.address	= (struct sockaddr *)&transport->xprt.addr,
+		.addrsize	= transport->xprt.addrlen,
+		.timeout	= transport->xprtsec_clnt->cl_timeout,
+		.servername	= transport->xprt.servername,
+		.nodename	= transport->xprtsec_clnt->cl_nodename,
+		.program	= transport->xprtsec_clnt->cl_program,
+		.prognumber	= transport->xprtsec_clnt->cl_prog,
+		.version	= transport->xprtsec_clnt->cl_vers,
+		.authflavor	= RPC_AUTH_TLS,
+		.cred		= transport->xprtsec_clnt->cl_cred,
+		.xprtsec	= RPC_XPRTSEC_NONE,
+	};
+	unsigned int pflags = current->flags;
 	struct rpc_clnt *clnt;
+	struct rpc_xprt *xprt;
+	int status;
 
-	clnt = transport->xprtsec_clnt;
-	transport->xprtsec_clnt = NULL;
+	if (atomic_read(&transport->xprt.swapper))
+		current->flags |= PF_MEMALLOC;
+
+	xs_stream_start_connect(transport);
+
+	clnt = rpc_create(&args);
 	if (IS_ERR(clnt))
 		goto out_unlock;
+	rcu_read_lock();
+	xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	rcu_read_unlock();
 
-	xs_tcp_setup_socket(work);
+	status = xs_tls_handshake_sync(xprt, transport->xprt.xprtsec);
+	if (status)
+		goto out_close;
 
+	status = xs_tls_finish_connecting(xprt, transport);
+	if (status)
+		goto out_close;
+	trace_rpc_socket_connect(&transport->xprt, transport->sock, 0);
+
+	xprt_put(xprt);
 	rpc_shutdown_client(clnt);
 
 out_unlock:
+	xprt_unlock_connect(&transport->xprt, transport);
+	current_restore_flags(pflags, PF_MEMALLOC);
+	transport->xprtsec_clnt = NULL;
 	return;
-}
 
-static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
-{
-	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
-	struct rpc_create_args args = {
-		.net		= xprt->xprt_net,
-		.protocol	= xprt->prot,
-		.address	= (struct sockaddr *)&xprt->addr,
-		.addrsize	= xprt->addrlen,
-		.timeout	= clnt->cl_timeout,
-		.servername	= xprt->servername,
-		.nodename	= clnt->cl_nodename,
-		.program	= clnt->cl_program,
-		.prognumber	= clnt->cl_prog,
-		.version	= clnt->cl_vers,
-		.authflavor	= RPC_AUTH_TLS,
-		.cred		= clnt->cl_cred,
-		.xprtsec	= RPC_XPRTSEC_NONE,
-		.flags		= RPC_CLNT_CREATE_NOPING,
-	};
-
-	switch (xprt->xprtsec) {
-	case RPC_XPRTSEC_TLS_X509:
-	case RPC_XPRTSEC_TLS_PSK:
-		transport->xprtsec_clnt = rpc_create(&args);
-		break;
-	default:
-		transport->xprtsec_clnt = ERR_PTR(-ENOTCONN);
-	}
-}
-
-#else
-
-static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
-{
-	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+out_close:
+	xprt_put(xprt);
+	rpc_shutdown_client(clnt);
 
-	transport->xprtsec_clnt = ERR_PTR(-ENOTCONN);
+	/* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
+	 * Wake them first here to ensure they get our tk_status code.
+	 */
+	xprt_wake_pending_tasks(&transport->xprt, status);
+	xs_tcp_force_close(&transport->xprt);
+	xprt_clear_connecting(&transport->xprt);
+	goto out_unlock;
 }
 
-#endif /*CONFIG_TLS */
+#endif /* CONFIG_TLS */
 
 /**
  * xs_connect - connect a socket to a remote endpoint
@@ -2520,8 +2678,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
-	xs_set_xprtsec_clnt(task->tk_client, xprt);
-
+	transport->xprtsec_clnt = task->tk_client;
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);


