Return-Path: <linux-nfs+bounces-13396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61403B199D8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 03:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1CC188ACFC
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F71EA7E9;
	Mon,  4 Aug 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSA4VRH8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841C1EA7CC
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270972; cv=none; b=SrFKioTeEqKKNJgsTyRGEu2rXyphyFyWRUeRQnCCLVJ5Cyv3JrtyGeosdO4ELoepxY6Q9fxEWZuGJ1nFBvoFpO6QRlSO5VYVD80/y+y6+QGbibCaJrsWn5/3IjGG4RjDmIXfMFyBdlANukW2KRyMF8YbQIEKa0JQOX2jJQ+UUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270972; c=relaxed/simple;
	bh=8SunJevCGtqJiFApF0Aliae+7+ahY36skuvKuOYNt24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/i6XmyrpI9k+ajf4mAtUKE7waQlMpiHTxIPF5fXDRiOvg3/ZvC9cXVVq+qIK1EribH8yhZnhidAHwhCaFNBgaNZqbjj6mU19Ac7wUOc6MQ1OyAsWFN5UhovSbiyXbqQ05/PJ+2oz1q8ZvtuxCKmtLLsbojZwCc/nJgWLcQqnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSA4VRH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55632C4CEF7
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754270971;
	bh=8SunJevCGtqJiFApF0Aliae+7+ahY36skuvKuOYNt24=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bSA4VRH8QxK0FdAf8S7+gIq78NY2OkYelvmsvv0JFlrpzUCBS8ZBxVbGbFCqYOCi2
	 41ZHg02cw1R+N3gGtAbpYYlkGRVoOQbrKTe2IzZbUdaUw7zY9BnpgYbxzuAhicvUuE
	 mIt0wxlV2mj+Y3tUETHJv7TxHRahx15Yikz1kcHJf/Wq5DuZbvabtDZAEW73RfUTwk
	 3topcC3Dky2dW+hJCC3ty97e5QVZG3QgojiWHhYWa1F2eNCQz+7Y7dk2JT5AV6LIzs
	 JiY7n6wGZqrdpVIh6gz81E8cY/8sSEU8xZsVs8SlUBMpgqEZzg30B0cMVF6MgM6qCX
	 bLcaGZI9nRDjQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Fix the setting of capabilities when automounting a new filesystem
Date: Sun,  3 Aug 2025 18:29:28 -0700
Message-ID: <488da9a6a16ddd9bccc755448ccdf2832638f502.1754270543.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754270543.git.trond.myklebust@hammerspace.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Capabilities cannot be inherited when we cross into a new filesystem.
They need to be reset to the minimal defaults, and then probed for
again.

Fixes: 54ceac451598 ("NFS: Share NFS superblocks per-protocol per-server per-FSID")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c     | 44 ++++++++++++++++++++++++++++++++++++++++++--
 fs/nfs/internal.h   |  2 +-
 fs/nfs/nfs4client.c | 20 +-------------------
 fs/nfs/nfs4proc.c   |  2 +-
 4 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e13eb429b8b5..8fb4a950dd55 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -682,6 +682,44 @@ struct nfs_client *nfs_init_client(struct nfs_client *clp,
 }
 EXPORT_SYMBOL_GPL(nfs_init_client);
 
+static void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_V4)
+	/* Set the basic capabilities */
+	server->caps = server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+		server->caps &= ~NFS_CAP_READDIRPLUS;
+	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
+		server->caps &= ~NFS_CAP_READ_PLUS;
+
+	/*
+	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
+	 * authentication.
+	 */
+	if (nfs4_disable_idmapping &&
+	    server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
+#endif
+}
+
+void nfs_server_set_init_caps(struct nfs_server *server)
+{
+	switch (server->nfs_client->rpc_ops->version) {
+	case 2:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		break;
+	case 3:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		if (!(server->flags & NFS_MOUNT_NORDIRPLUS))
+			server->caps |= NFS_CAP_READDIRPLUS;
+		break;
+	default:
+		nfs4_server_set_init_caps(server);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
+
 /*
  * Create a version 2 or 3 client
  */
@@ -726,7 +764,6 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
 
 	switch (clp->rpc_ops->version) {
 	case 2:
@@ -762,6 +799,8 @@ static int nfs_init_server(struct nfs_server *server,
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (ctx->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &ctx->mount_server.address,
@@ -934,7 +973,6 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1169,6 +1207,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_server(server, fh);
 	if (error < 0)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0143e0794d32..1a18d8d9be25 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -231,7 +231,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
-extern void nfs4_server_set_init_caps(struct nfs_server *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 2ea98f1f116f..6fddf43d729c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1074,24 +1074,6 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
 #endif
 }
 
-void nfs4_server_set_init_caps(struct nfs_server *server)
-{
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
-		server->caps &= ~NFS_CAP_READ_PLUS;
-
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-}
-
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1110,7 +1092,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		return error;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d7dc669d84c5..c7c7ec22f21d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4092,7 +4092,7 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.50.1


