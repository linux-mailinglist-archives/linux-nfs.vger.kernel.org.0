Return-Path: <linux-nfs+bounces-13028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61605B03715
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707C51892B18
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4D223DDF;
	Mon, 14 Jul 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kw2xE2dH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42592BE4A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474659; cv=none; b=nH2TfZLe6qqLI9qGOfTza1nNXt5Oj82ZreOUxjvT/xPv+1BV3Qd8Sv10amwAdrBuw75ARJ4eUmiR4O3M/GKYeuWVbZuPQXHjYZC/mL0XtQhijSAAkUaR3BV9gEx4We2czVGeqRgxnwpZqe3PkHvaNXRliRh9ldai9qrxX72SeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474659; c=relaxed/simple;
	bh=DiZk0e1hLXEtL4dST/OxIB4j0gnJHAa/fDiOmWFuL1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNkRDVrnB8r2VHweuG0QW9EyxNV1ew75QeBmuFp4fE9TtbN9cliMAVkJmDj/fKe9XHFy304aLiQiVSkhvelg1Hu10i9wDMEHSMxJgZTfXtc+zB/e02SYfkgTGBwRCudBU/lqE6jzbiWyFxmaW/5ZPwHzSmUb0hOsUWIda0KxoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kw2xE2dH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=leV/Thyy5SNmzKeYmryIl7eFBQNxzodpX6UMtgZNRlo=; b=kw2xE2dHnSvNXfOP11OJ3Xhr/2
	0MMm2D9oktA3rC2m4yNiGFsBVz/B4zmwMJqLfoJkzXXLVv2BNHmOvWnU4D2X3JW36JlK19jqJhXnK
	6ZJ/VAvIpyKqDyloPYAKlqvJ9svFFzZIh3MDrQIaw8ToUJaxC6f3uNd2Bzpjay4o2+rXclfvhBURB
	NQI5Dw3mRQOK/Yp76ryCgZj4QSzfPPPKgsQ6ugH9xAvD6uCP8+E7ERgHwuIz4C16Wr0qWLdWX+q5p
	gue306zY1aXc1vBCND2TxL9wDmAKiLFAH1TcIxTztl6CrtLrn5MYtjNNKQ5ASSkf0JIKgCYIHdauB
	MzhBbjog==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCiH-00000001Lyw-2VZo;
	Mon, 14 Jul 2025 06:30:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: pass struct nfs_client_initdata to nfs4_set_client
Date: Mon, 14 Jul 2025 08:30:45 +0200
Message-ID: <20250714063053.1487761-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714063053.1487761-1-hch@lst.de>
References: <20250714063053.1487761-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Passed the partially filled out structure to nfs4_set_client instead of
11 arguments that then get stashed into the structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4client.c | 151 ++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 83 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 162c85a83a14..2e623da1a787 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -895,55 +895,40 @@ nfs4_find_client_sessionid(struct net *net, const struct sockaddr *addr,
  * Set up an NFS4 client
  */
 static int nfs4_set_client(struct nfs_server *server,
-		const char *hostname,
-		const struct sockaddr_storage *addr,
-		const size_t addrlen,
-		const char *ip_addr,
-		int proto, const struct rpc_timeout *timeparms,
-		u32 minorversion, unsigned int nconnect,
-		unsigned int max_connect,
-		struct net *net,
-		struct xprtsec_parms *xprtsec)
+		struct nfs_client_initdata *cl_init)
 {
-	struct nfs_client_initdata cl_init = {
-		.hostname = hostname,
-		.addr = addr,
-		.addrlen = addrlen,
-		.ip_addr = ip_addr,
-		.nfs_mod = &nfs_v4,
-		.proto = proto,
-		.minorversion = minorversion,
-		.net = net,
-		.timeparms = timeparms,
-		.cred = server->cred,
-		.xprtsec = *xprtsec,
-	};
 	struct nfs_client *clp;
 
-	if (minorversion == 0)
-		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
-	else
-		cl_init.max_connect = max_connect;
-	switch (proto) {
+	cl_init->nfs_mod = &nfs_v4;
+	cl_init->cred = server->cred;
+
+	if (cl_init->minorversion == 0) {
+		__set_bit(NFS_CS_REUSEPORT, &cl_init->init_flags);
+		cl_init->max_connect = 0;
+	}
+
+	switch (cl_init->proto) {
 	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_TCP_TLS:
-		cl_init.nconnect = nconnect;
+		break;
+	default:
+		cl_init->nconnect = 0;
 	}
 
 	if (server->flags & NFS_MOUNT_NORESVPORT)
-		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
+		__set_bit(NFS_CS_NORESVPORT, &cl_init->init_flags);
 	if (server->options & NFS_OPTION_MIGRATION)
-		__set_bit(NFS_CS_MIGRATION, &cl_init.init_flags);
+		__set_bit(NFS_CS_MIGRATION, &cl_init->init_flags);
 	if (test_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status))
-		__set_bit(NFS_CS_TSM_POSSIBLE, &cl_init.init_flags);
-	server->port = rpc_get_port((struct sockaddr *)addr);
+		__set_bit(NFS_CS_TSM_POSSIBLE, &cl_init->init_flags);
+	server->port = rpc_get_port((struct sockaddr *)cl_init->addr);
 
 	if (server->flags & NFS_MOUNT_NETUNREACH_FATAL)
-		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
+		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init->init_flags);
 
 	/* Allocate or find a client reference we can use */
-	clp = nfs_get_client(&cl_init);
+	clp = nfs_get_client(cl_init);
 	if (IS_ERR(clp))
 		return PTR_ERR(clp);
 
@@ -1156,6 +1141,19 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct rpc_timeout timeparms;
+	struct nfs_client_initdata cl_init = {
+		.hostname = ctx->nfs_server.hostname,
+		.addr = &ctx->nfs_server._address,
+		.addrlen = ctx->nfs_server.addrlen,
+		.ip_addr = ctx->client_address,
+		.proto = ctx->nfs_server.protocol,
+		.minorversion = ctx->minorversion,
+		.net = fc->net_ns,
+		.timeparms = &timeparms,
+		.xprtsec = ctx->xprtsec,
+		.nconnect = ctx->nfs_server.nconnect,
+		.max_connect = ctx->nfs_server.max_connect,
+	};
 	int error;
 
 	nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
@@ -1175,18 +1173,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 		ctx->selected_flavor = RPC_AUTH_UNIX;
 
 	/* Get a client record */
-	error = nfs4_set_client(server,
-				ctx->nfs_server.hostname,
-				&ctx->nfs_server._address,
-				ctx->nfs_server.addrlen,
-				ctx->client_address,
-				ctx->nfs_server.protocol,
-				&timeparms,
-				ctx->minorversion,
-				ctx->nfs_server.nconnect,
-				ctx->nfs_server.max_connect,
-				fc->net_ns,
-				&ctx->xprtsec);
+	error = nfs4_set_client(server, &cl_init);
 	if (error < 0)
 		return error;
 
@@ -1246,18 +1233,28 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
-	struct nfs_client *parent_client;
-	struct nfs_server *server, *parent_server;
-	int proto, error;
+	struct nfs_server *parent_server = NFS_SB(ctx->clone_data.sb);
+	struct nfs_client *parent_client = parent_server->nfs_client;
+	struct nfs_client_initdata cl_init = {
+		.hostname = ctx->nfs_server.hostname,
+		.addr = &ctx->nfs_server._address,
+		.addrlen = ctx->nfs_server.addrlen,
+		.ip_addr = parent_client->cl_ipaddr,
+		.minorversion = parent_client->cl_mvops->minor_version,
+		.net = parent_client->cl_net,
+		.timeparms = parent_server->client->cl_timeout,
+		.xprtsec = parent_client->cl_xprtsec,
+		.nconnect = parent_client->cl_nconnect,
+		.max_connect = parent_client->cl_max_connect,
+	};
+	struct nfs_server *server;
 	bool auth_probe;
+	int error;
 
 	server = nfs_alloc_server();
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	parent_server = NFS_SB(ctx->clone_data.sb);
-	parent_client = parent_server->nfs_client;
-
 	server->cred = get_cred(parent_server->cred);
 
 	/* Initialise the client representation from the parent server */
@@ -1266,38 +1263,17 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	/* Get a client representation */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
-	error = nfs4_set_client(server,
-				ctx->nfs_server.hostname,
-				&ctx->nfs_server._address,
-				ctx->nfs_server.addrlen,
-				parent_client->cl_ipaddr,
-				XPRT_TRANSPORT_RDMA,
-				parent_server->client->cl_timeout,
-				parent_client->cl_mvops->minor_version,
-				parent_client->cl_nconnect,
-				parent_client->cl_max_connect,
-				parent_client->cl_net,
-				&parent_client->cl_xprtsec);
+	cl_init.proto = XPRT_TRANSPORT_RDMA;
+	error = nfs4_set_client(server, &cl_init);
 	if (!error)
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
-	proto = XPRT_TRANSPORT_TCP;
+	cl_init.proto = XPRT_TRANSPORT_TCP;
 	if (parent_client->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
-		proto = XPRT_TRANSPORT_TCP_TLS;
+		cl_init.proto = XPRT_TRANSPORT_TCP_TLS;
 	rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
-	error = nfs4_set_client(server,
-				ctx->nfs_server.hostname,
-				&ctx->nfs_server._address,
-				ctx->nfs_server.addrlen,
-				parent_client->cl_ipaddr,
-				proto,
-				parent_server->client->cl_timeout,
-				parent_client->cl_mvops->minor_version,
-				parent_client->cl_nconnect,
-				parent_client->cl_max_connect,
-				parent_client->cl_net,
-				&parent_client->cl_xprtsec);
+	error = nfs4_set_client(server, &cl_init);
 	if (error < 0)
 		goto error;
 
@@ -1353,6 +1329,19 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	char buf[INET6_ADDRSTRLEN + 1];
 	struct sockaddr_storage address;
 	struct sockaddr *localaddr = (struct sockaddr *)&address;
+	struct nfs_client_initdata cl_init = {
+		.hostname = hostname,
+		.addr = sap,
+		.addrlen = salen,
+		.ip_addr = buf,
+		.proto = clp->cl_proto,
+		.minorversion = clp->cl_minorversion,
+		.net = net,
+		.timeparms = clnt->cl_timeout,
+		.xprtsec = clp->cl_xprtsec,
+		.nconnect = clp->cl_nconnect,
+		.max_connect = clp->cl_max_connect,
+	};
 	int error;
 
 	error = rpc_switch_client_transport(clnt, &xargs, clnt->cl_timeout);
@@ -1368,11 +1357,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 
 	nfs_server_remove_lists(server);
 	set_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
-	error = nfs4_set_client(server, hostname, sap, salen, buf,
-				clp->cl_proto, clnt->cl_timeout,
-				clp->cl_minorversion,
-				clp->cl_nconnect, clp->cl_max_connect,
-				net, &clp->cl_xprtsec);
+	error = nfs4_set_client(server, &cl_init);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error != 0) {
 		nfs_server_insert_lists(server);
-- 
2.47.2


