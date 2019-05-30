Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466AD2E9CA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfE3Ant (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3Ant (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C26D6AC2C;
        Thu, 30 May 2019 00:43:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 7/9] NFSv4: Allow multiple connections to NFSv4.x servers
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688881.3988.15202717018849539621.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the user specifies the -onconnect=<number> mount option, then set up
<number> connections to the server. The connections will all go to the
same IP address.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/client.c     |    2 ++
 fs/nfs/internal.h   |    1 +
 fs/nfs/nfs4client.c |   10 ++++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3d04cb0b839e..9005643b0db4 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_rpcclient = ERR_PTR(-EINVAL);
 
 	clp->cl_proto = cl_init->proto;
+	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_net = get_net(cl_init->net);
 
 	clp->cl_principal = "*";
@@ -497,6 +498,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 	struct rpc_create_args args = {
 		.net		= clp->cl_net,
 		.protocol	= clp->cl_proto,
+		.nconnect	= clp->cl_nconnect,
 		.address	= (struct sockaddr *)&clp->cl_addr,
 		.addrsize	= clp->cl_addrlen,
 		.timeout	= cl_init->timeparms,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index bba09dace5d6..4a49dc1495c5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -82,6 +82,7 @@ struct nfs_client_initdata {
 	struct nfs_subversion *nfs_mod;
 	int proto;
 	u32 minorversion;
+	unsigned int nconnect;
 	struct net *net;
 	const struct rpc_timeout *timeparms;
 	const struct cred *cred;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 81b9b6d7927a..401a76290e55 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -859,7 +859,8 @@ static int nfs4_set_client(struct nfs_server *server,
 		const size_t addrlen,
 		const char *ip_addr,
 		int proto, const struct rpc_timeout *timeparms,
-		u32 minorversion, struct net *net)
+		u32 minorversion, unsigned int nconnect,
+		struct net *net)
 {
 	struct nfs_client_initdata cl_init = {
 		.hostname = hostname,
@@ -872,6 +873,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		.net = net,
 		.timeparms = timeparms,
 		.cred = server->cred,
+		.nconnect = nconnect,
 	};
 	struct nfs_client *clp;
 
@@ -1074,6 +1076,7 @@ static int nfs4_init_server(struct nfs_server *server,
 			data->nfs_server.protocol,
 			&timeparms,
 			data->minorversion,
+			data->nfs_server.nconnect,
 			data->net);
 	if (error < 0)
 		return error;
@@ -1163,6 +1166,7 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 				XPRT_TRANSPORT_RDMA,
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
+				parent_client->cl_nconnect,
 				parent_client->cl_net);
 	if (!error)
 		goto init_server;
@@ -1176,6 +1180,7 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 				XPRT_TRANSPORT_TCP,
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
+				parent_client->cl_nconnect,
 				parent_client->cl_net);
 	if (error < 0)
 		goto error;
@@ -1271,7 +1276,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	set_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	error = nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
-				clp->cl_minorversion, net);
+				clp->cl_minorversion,
+				clp->cl_nconnect, net);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error != 0) {
 		nfs_server_insert_lists(server);


