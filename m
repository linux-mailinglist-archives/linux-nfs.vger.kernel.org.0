Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB670DF47
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjEWOcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjEWOcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA78A138
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9CB63322
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 14:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36734C433D2;
        Tue, 23 May 2023 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852367;
        bh=ofC3CZ4r/P3uLrWkpv9u764Q+NkU35iRcZ8sEshiWA0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KGzZWssMpiaSXIWgmn5OuPsItixDxzEO+Axg5fQZqfu/8wFLkG/icDIh9yj1l3E3+
         lac0kEXyqKNQNW6NexzrLO6h45s7KoGhUDGVw9G1VjH6U/SBU1pF6bsVvzYxonJ6Xl
         KqBMlwxyTVSOmUDr+p7CJ5zcGXhA4vVBsaaq2f/BbqEUfU6AhNZU36QDh9GgljcvDi
         Bco5coWyq/1M+xFrE3YAFFjAt1JzcZCqba3bO8OfKDLJj3bOa3HekFJbOfVmDMioQY
         H0B+YZhJwYcMYuK7XvlUfbrVFAdXbQhH+A+OgsApZQNDKcOcDUTtNTLkXnvOqFUkUK
         3ArnGTOsRR3+w==
Subject: [PATCH v2 07/11] SUNRPC: Add a connect worker function for TLS
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 23 May 2023 10:32:36 -0400
Message-ID: <168485234621.6613.3827602274383164889.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
References: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
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

Introduce a connect worker function that will handle the AUTH_TLS
probe and TLS handshake, once a TCP connection is established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/xprtsock.h |    1 +
 net/sunrpc/xprtsock.c           |   70 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index daef030f4848..574a6a5391ba 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -60,6 +60,7 @@ struct sock_xprt {
 	struct sockaddr_storage	srcaddr;
 	unsigned short		srcport;
 	int			xprt_err;
+	struct rpc_clnt		*clnt;
 
 	/*
 	 * UDP socket buffer size parameters
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 6f2fc863b47e..7ea5984a52a3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2411,6 +2411,62 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
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
+	clnt = transport->clnt;
+	transport->clnt = NULL;
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
+static void xs_set_transport_clnt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
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
+		.xprtsec	= {
+			.policy		= RPC_XPRTSEC_NONE,
+		},
+		.flags		= RPC_CLNT_CREATE_NOPING,
+	};
+
+	switch (xprt->xprtsec.policy) {
+	case RPC_XPRTSEC_TLS_ANON:
+	case RPC_XPRTSEC_TLS_X509:
+		transport->clnt = rpc_create(&args);
+		break;
+	default:
+		transport->clnt = ERR_PTR(-ENOTCONN);
+	}
+}
+
 /**
  * xs_connect - connect a socket to a remote endpoint
  * @xprt: pointer to transport structure
@@ -2442,6 +2498,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
+	xs_set_transport_clnt(task->tk_client, xprt);
+
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);
@@ -3057,7 +3115,17 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
 	INIT_WORK(&transport->error_worker, xs_error_handle);
-	INIT_DELAYED_WORK(&transport->connect_worker, xs_tcp_setup_socket);
+
+	xprt->xprtsec = args->xprtsec;
+	switch (args->xprtsec.policy) {
+	case RPC_XPRTSEC_NONE:
+		INIT_DELAYED_WORK(&transport->connect_worker, xs_tcp_setup_socket);
+		break;
+	case RPC_XPRTSEC_TLS_ANON:
+	case RPC_XPRTSEC_TLS_X509:
+		INIT_DELAYED_WORK(&transport->connect_worker, xs_tls_connect);
+		break;
+	}
 
 	switch (addr->sa_family) {
 	case AF_INET:


