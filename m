Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF957057AC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEPTnJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjEPTm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FDD2C5
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B646324B
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BBBC433D2;
        Tue, 16 May 2023 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266150;
        bh=rsk/uhOncNt82Q+2sHjPOpGZZsYx7ax3lBBwX7BEwM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VC/CQNECq+0yTuwM6uNhtZZpP8OIhWRE4pjooi4gl7gZJkcnLO6mYSukZ/43cWXLJ
         JSMMEbTYs8rjGIRvuxCoSzjkBUsWe+1NwLtpeAaoJVu69+PvZikjDnrVM1YSvN0juD
         BmuKXHvRehitNKRFIN55bobIT2a3yIKjHmf3jc9mnVY8SviiOLDp6xfzgwefTtdRbn
         WLhJ7w+uyuwMEmebQeKwUNBhPwpnWrbuJCF+A/DtNzzEzQKiZ0VRyozUJRaj+CSPGa
         pkFMkKheeBKNVyN5htsVX7rnklml6uOk9JqjjMbv//kr6IMCpeahF1sRmuyFnQaKRr
         dnAA4YgwCnhlQ==
Subject: [PATCH RFC 09/12] SUNRPC: Add RPC-with-TLS support to xprtsock.c
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:42:19 -0400
Message-ID: <168426612899.74246.12074514989473589840.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Use the new TLS handshake API to enable the SunRPC client code
to request a TLS handshake. This implements support for RFC 9289.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprtsock.h |    1 
 net/sunrpc/xprtsock.c           |  289 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 253 insertions(+), 37 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 574a6a5391ba..700a1e6c047c 100644
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
index 7ea5984a52a3..686dd313f89f 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -48,6 +48,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/handshake.h>
 
 #include <linux/bvec.h>
 #include <linux/highmem.h>
@@ -189,6 +190,11 @@ static struct ctl_table xs_tunables_table[] = {
  */
 #define XS_IDLE_DISC_TO		(5U * 60 * HZ)
 
+/*
+ * TLS handshake timeout.
+ */
+#define XS_TLS_HANDSHAKE_TO	(10U * HZ)
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # undef  RPC_DEBUG_DATA
 # define RPCDBG_FACILITY	RPCDBG_TRANS
@@ -1238,6 +1244,10 @@ static void xs_reset_transport(struct sock_xprt *transport)
 	if (atomic_read(&transport->xprt.swapper))
 		sk_clear_memalloc(sk);
 
+	/* XXX: Maybe also send a TLS Closure alert? */
+
+	tls_handshake_cancel(sk);
+
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 
 	mutex_lock(&transport->recv_mutex);
@@ -2411,60 +2421,266 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
+/*
+ * Transfer the connected socket to @upper_transport, then mark that
+ * xprt CONNECTED.
+ */
+static int xs_tls_finish_connecting(struct rpc_xprt *lower_xprt,
+				    struct sock_xprt *upper_transport)
+{
+	struct sock_xprt *lower_transport =
+			container_of(lower_xprt, struct sock_xprt, xprt);
+	struct rpc_xprt *upper_xprt = &upper_transport->xprt;
+
+	if (!upper_transport->inet) {
+		struct socket *sock = lower_transport->sock;
+		struct sock *sk = sock->sk;
+
+		/* Avoid temporary address, they are bad for long-lived
+		 * connections such as NFS mounts.
+		 * RFC4941, section 3.6 suggests that:
+		 *    Individual applications, which have specific
+		 *    knowledge about the normal duration of connections,
+		 *    MAY override this as appropriate.
+		 */
+		if (xs_addr(upper_xprt)->sa_family == PF_INET6) {
+			ip6_sock_set_addr_preferences(sk,
+				IPV6_PREFER_SRC_PUBLIC);
+		}
+
+		xs_tcp_set_socket_timeouts(upper_xprt, sock);
+		tcp_sock_set_nodelay(sk);
+
+		lock_sock(sk);
+
+		/*
+		 * @sk is already connected, so it now has the RPC callbacks.
+		 * Reach into @lower_transport to save the original ones.
+		 */
+		upper_transport->old_data_ready = lower_transport->old_data_ready;
+		upper_transport->old_state_change = lower_transport->old_state_change;
+		upper_transport->old_write_space = lower_transport->old_write_space;
+		upper_transport->old_error_report = lower_transport->old_error_report;
+		sk->sk_user_data = upper_xprt;
+
+		/* socket options */
+		sock_reset_flag(sk, SOCK_LINGER);
+
+		xprt_clear_connected(upper_xprt);
+
+		upper_transport->sock = sock;
+		upper_transport->inet = sk;
+		upper_transport->file = lower_transport->file;
+
+		release_sock(sk);
+
+		/* Reset lower_transport before shutting down its clnt */
+		mutex_lock(&lower_transport->recv_mutex);
+		lower_transport->inet = NULL;
+		lower_transport->sock = NULL;
+		lower_transport->file = NULL;
+
+		xprt_clear_connected(lower_xprt);
+		xs_sock_reset_connection_flags(lower_xprt);
+		xs_stream_reset_connect(lower_transport);
+		mutex_unlock(&lower_transport->recv_mutex);
+	}
+
+	if (!xprt_bound(upper_xprt))
+		return -ENOTCONN;
+
+	xs_set_memalloc(upper_xprt);
+
+	if (!xprt_test_and_set_connected(upper_xprt)) {
+		upper_xprt->connect_cookie++;
+		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
+		xprt_clear_connecting(upper_xprt);
+
+		upper_xprt->stat.connect_count++;
+		upper_xprt->stat.connect_time += (long)jiffies -
+					   upper_xprt->stat.connect_start;
+		xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDING);
+	}
+	return 0;
+}
+
 /**
- * xs_tls_connect - establish a TLS session on a socket
- * @work: queued work item
+ * xs_tls_handshake_done - TLS handshake completion handler
+ * @data: address of xprt to wake
+ * @status: status of handshake
+ * @peerid: serial number of key containing the remote's identity
  *
  */
-static void xs_tls_connect(struct work_struct *work)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
 {
-	struct sock_xprt *transport =
-		container_of(work, struct sock_xprt, connect_worker.work);
-	struct rpc_clnt *clnt;
+	struct rpc_xprt *lower_xprt = data;
+	struct sock_xprt *lower_transport =
+				container_of(lower_xprt, struct sock_xprt, xprt);
 
-	clnt = transport->clnt;
-	transport->clnt = NULL;
-	if (IS_ERR(clnt))
-		goto out_unlock;
+	lower_transport->xprt_err = status ? -EACCES : 0;
+	complete(&lower_transport->handshake_done);
+	xprt_put(lower_xprt);
+}
 
-	xs_tcp_setup_socket(work);
+static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struct xprtsec_parms *xprtsec)
+{
+	struct sock_xprt *lower_transport =
+				container_of(lower_xprt, struct sock_xprt, xprt);
+	struct tls_handshake_args args = {
+		.ta_sock	= lower_transport->sock,
+		.ta_done	= xs_tls_handshake_done,
+		.ta_data	= xprt_get(lower_xprt),
+		.ta_peername	= lower_xprt->servername,
+	};
+	struct sock *sk = lower_transport->inet;
+	int rc;
 
-	rpc_shutdown_client(clnt);
+	init_completion(&lower_transport->handshake_done);
+	set_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
 
-out_unlock:
-	return;
+	lower_transport->xprt_err = -ETIMEDOUT;
+	switch (xprtsec->policy) {
+	case RPC_XPRTSEC_TLS_ANON:
+		rc = tls_client_hello_anon(&args, GFP_KERNEL);
+		if (rc)
+			goto out_put_xprt;
+		break;
+	case RPC_XPRTSEC_TLS_X509:
+		args.ta_my_cert = xprtsec->cert_serial;
+		args.ta_my_privkey = xprtsec->privkey_serial;
+		rc = tls_client_hello_x509(&args, GFP_KERNEL);
+		if (rc)
+			goto out_put_xprt;
+		break;
+	default:
+		rc = -EACCES;
+		goto out_put_xprt;
+	}
+
+	rc = wait_for_completion_interruptible_timeout(&lower_transport->handshake_done,
+						       XS_TLS_HANDSHAKE_TO);
+	if (rc <= 0) {
+		if (!tls_handshake_cancel(sk)) {
+			if (rc == 0)
+				rc = -ETIMEDOUT;
+			goto out_put_xprt;
+		}
+	}
+
+	rc = lower_transport->xprt_err;
+
+out:
+	xs_stream_reset_connect(lower_transport);
+	clear_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
+	return rc;
+
+out_put_xprt:
+	xprt_put(lower_xprt);
+	goto out;
 }
 
-static void xs_set_transport_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+/**
+ * xs_tls_connect - establish a TLS session on a socket
+ * @work: queued work item
+ *
+ * For RPC-with-TLS, there is a two-stage connection process.
+ *
+ * The "upper-layer xprt" is visible to the RPC consumer. Once it has
+ * been marked connected, the consumer knows that a TCP connection and
+ * a TLS session have been established.
+ *
+ * A "lower-layer xprt", created in this function, handles the mechanics
+ * of connecting the TCP socket, performing the RPC_AUTH_TLS probe, and
+ * then driving the TLS handshake. Once all that is complete, the upper
+ * layer xprt is marked connected.
+ */
+static void xs_tls_connect(struct work_struct *work)
 {
-	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+	struct sock_xprt *upper_transport =
+		container_of(work, struct sock_xprt, connect_worker.work);
+	struct rpc_clnt *upper_clnt = upper_transport->clnt;
+	struct rpc_xprt *upper_xprt = &upper_transport->xprt;
 	struct rpc_create_args args = {
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
+		.net		= upper_xprt->xprt_net,
+		.protocol	= upper_xprt->prot,
+		.address	= (struct sockaddr *)&upper_xprt->addr,
+		.addrsize	= upper_xprt->addrlen,
+		.timeout	= upper_clnt->cl_timeout,
+		.servername	= upper_xprt->servername,
+		.nodename	= upper_clnt->cl_nodename,
+		.program	= upper_clnt->cl_program,
+		.prognumber	= upper_clnt->cl_prog,
+		.version	= upper_clnt->cl_vers,
 		.authflavor	= RPC_AUTH_TLS,
-		.cred		= clnt->cl_cred,
+		.cred		= upper_clnt->cl_cred,
 		.xprtsec	= {
 			.policy		= RPC_XPRTSEC_NONE,
 		},
-		.flags		= RPC_CLNT_CREATE_NOPING,
 	};
+	unsigned int pflags = current->flags;
+	struct rpc_clnt *lower_clnt;
+	struct rpc_xprt *lower_xprt;
+	int status;
 
-	switch (xprt->xprtsec.policy) {
-	case RPC_XPRTSEC_TLS_ANON:
-	case RPC_XPRTSEC_TLS_X509:
-		transport->clnt = rpc_create(&args);
-		break;
-	default:
-		transport->clnt = ERR_PTR(-ENOTCONN);
+	if (atomic_read(&upper_xprt->swapper))
+		current->flags |= PF_MEMALLOC;
+
+	xs_stream_start_connect(upper_transport);
+
+	/* This implicitly sends an RPC_AUTH_TLS probe */
+	lower_clnt = rpc_create(&args);
+	if (IS_ERR(lower_clnt)) {
+		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
+		xprt_clear_connecting(upper_xprt);
+		xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
+		smp_mb__before_atomic();
+		xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDING);
+		goto out_unlock;
 	}
+
+	/* RPC_AUTH_TLS probe was successful. Try a TLS handshake on
+	 * the lower xprt.
+	 */
+	rcu_read_lock();
+	lower_xprt = rcu_dereference(lower_clnt->cl_xprt);
+	rcu_read_unlock();
+	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
+	if (status)
+		goto out_close;
+
+	status = xs_tls_finish_connecting(lower_xprt, upper_transport);
+	if (status)
+		goto out_close;
+
+	trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
+	if (!xprt_test_and_set_connected(upper_xprt)) {
+		upper_xprt->connect_cookie++;
+		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
+		xprt_clear_connecting(upper_xprt);
+
+		upper_xprt->stat.connect_count++;
+		upper_xprt->stat.connect_time += (long)jiffies -
+					   upper_xprt->stat.connect_start;
+		xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDING);
+	}
+	rpc_shutdown_client(lower_clnt);
+
+out_unlock:
+	current_restore_flags(pflags, PF_MEMALLOC);
+	upper_transport->clnt = NULL;
+	xprt_unlock_connect(upper_xprt, upper_transport);
+	return;
+
+out_close:
+	rpc_shutdown_client(lower_clnt);
+
+	/* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
+	 * Wake them first here to ensure they get our tk_status code.
+	 */
+	xprt_wake_pending_tasks(upper_xprt, status);
+	xs_tcp_force_close(upper_xprt);
+	xprt_clear_connecting(upper_xprt);
+	goto out_unlock;
 }
 
 /**
@@ -2498,8 +2714,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
-	xs_set_transport_clnt(task->tk_client, xprt);
-
+	transport->clnt = task->tk_client;
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);


