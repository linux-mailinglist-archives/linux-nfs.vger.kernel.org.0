Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6353EBD3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiFFOvn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiFFOvm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF48187066
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74AA8614B2
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AEDC34115;
        Mon,  6 Jun 2022 14:51:40 +0000 (UTC)
Subject: [PATCH v2 11/15] SUNRPC: Add a connect worker function for TLS
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:39 -0400
Message-ID: <165452709969.1496.10685243187303005896.stgit@oracle-102.nfsv4.dev>
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

Introduce a connect worker function that will handle the AUTH_TLS
probe and TLS handshake after a TCP connection is established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprtsock.h |    2 +
 net/sunrpc/xprtsock.c           |   86 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index daef030f4848..e0b6009f1f69 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -76,6 +76,8 @@ struct sock_xprt {
 	void			(*old_state_change)(struct sock *);
 	void			(*old_write_space)(struct sock *);
 	void			(*old_error_report)(struct sock *);
+
+	struct rpc_clnt		*xprtsec_clnt;
 };
 
 /*
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c73af8f1c3d4..a4fee00412d4 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2422,6 +2422,73 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
+#if IS_ENABLED(CONFIG_TLS)
+
+/**
+ * xs_tls_connect - establish a TLS session on a socket
+ * @work: queued work item
+ *
+ */
+static void xs_tls_connect(struct work_struct *work)
+{
+	struct sock_xprt *transport =
+		container_of(work, struct sock_xprt, connect_worker.work);
+	struct rpc_clnt *clnt;
+
+	clnt = transport->xprtsec_clnt;
+	transport->xprtsec_clnt = NULL;
+	if (IS_ERR(clnt))
+		goto out_unlock;
+
+	xs_tcp_setup_socket(work);
+
+	rpc_shutdown_client(clnt);
+
+out_unlock:
+	return;
+}
+
+static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+{
+	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+	struct rpc_create_args args = {
+		.net		= xprt->xprt_net,
+		.protocol	= xprt->prot,
+		.address	= (struct sockaddr *)&xprt->addr,
+		.addrsize	= xprt->addrlen,
+		.timeout	= clnt->cl_timeout,
+		.servername	= xprt->servername,
+		.nodename	= clnt->cl_nodename,
+		.program	= clnt->cl_program,
+		.prognumber	= clnt->cl_prog,
+		.version	= clnt->cl_vers,
+		.authflavor	= RPC_AUTH_TLS,
+		.cred		= clnt->cl_cred,
+		.xprtsec	= RPC_XPRTSEC_NONE,
+		.flags		= RPC_CLNT_CREATE_NOPING,
+	};
+
+	switch (xprt->xprtsec) {
+	case RPC_XPRTSEC_TLS_X509:
+	case RPC_XPRTSEC_TLS_PSK:
+		transport->xprtsec_clnt = rpc_create(&args);
+		break;
+	default:
+		transport->xprtsec_clnt = ERR_PTR(-ENOTCONN);
+	}
+}
+
+#else
+
+static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+{
+	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+
+	transport->xprtsec_clnt = ERR_PTR(-ENOTCONN);
+}
+
+#endif /*CONFIG_TLS */
+
 /**
  * xs_connect - connect a socket to a remote endpoint
  * @xprt: pointer to transport structure
@@ -2453,6 +2520,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
+	xs_set_xprtsec_clnt(task->tk_client, xprt);
+
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);
@@ -3068,7 +3137,22 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
 	INIT_WORK(&transport->error_worker, xs_error_handle);
-	INIT_DELAYED_WORK(&transport->connect_worker, xs_tcp_setup_socket);
+
+	xprt->xprtsec = args->xprtsec;
+	switch (args->xprtsec) {
+	case RPC_XPRTSEC_NONE:
+		INIT_DELAYED_WORK(&transport->connect_worker, xs_tcp_setup_socket);
+		break;
+	case RPC_XPRTSEC_TLS_X509:
+	case RPC_XPRTSEC_TLS_PSK:
+#if IS_ENABLED(CONFIG_TLS)
+		INIT_DELAYED_WORK(&transport->connect_worker, xs_tls_connect);
+#else
+		ret = ERR_PTR(-EACCES);
+		goto out_err;
+#endif
+		break;
+	}
 
 	switch (addr->sa_family) {
 	case AF_INET:


