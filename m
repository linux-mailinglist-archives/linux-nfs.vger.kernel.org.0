Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA98471633C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjE3OJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjE3OJf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 10:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D7B2
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 07:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2759261202
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15853C433EF;
        Tue, 30 May 2023 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455772;
        bh=GE1LJlVqzqoJyPBK3T7QoC342wVBx65VGm9LOBvWSlg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AyK1kw/ZazSHiduRMFbDirmYF7A7dG8N5pxdNumlrgD7Uk4o0zDm5UUuBrgfQHax4
         5fs46Q9I/y7RTEozyGoST/DyX0omI5Mr8gCM6yAk+UsVliE71mJITFHUk7r1YYsB6+
         Jf4aY/gYR5wlpviPx7qvnYjfUvycLBICZAO+vp27VV3ogImrkNFHm188nU3dRQzICI
         bMO2yI9hqS34O6vkkjGACxNSjxxM1tmvfVId2Kn30notDyrByORuA8agO7K0SQuyvV
         9FnJSnbToz5s8y6bmjYLxFVyCHE93o4DOXe5wBnv+HL2tupx3J6Ta+DfuFrXwltDOh
         wFCYX9DSRi/RQ==
Subject: [PATCH v3 10/11] NFS: Have struct nfs_client carry a TLS policy field
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 30 May 2023 10:09:21 -0400
Message-ID: <168545575953.1917.4045288613102437485.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
References: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The new field is used to match struct nfs_clients that have the same
TLS policy setting.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c           |    8 ++++++++
 fs/nfs/internal.h         |    1 +
 fs/nfs/nfs3client.c       |    1 +
 fs/nfs/nfs4client.c       |   20 +++++++++++++++-----
 include/linux/nfs_fs_sb.h |    3 ++-
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f50e025ae406..9bfdade0f6e6 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -184,6 +184,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_net = get_net(cl_init->net);
 
 	clp->cl_principal = "*";
+	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
 
 error_cleanup:
@@ -326,6 +327,10 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 							   sap))
 				continue;
 
+		/* Match the xprt security policy */
+		if (clp->cl_xprtsec.policy != data->xprtsec.policy)
+			continue;
+
 		refcount_inc(&clp->cl_count);
 		return clp;
 	}
@@ -675,6 +680,9 @@ static int nfs_init_server(struct nfs_server *server,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
 		.init_flags = (1UL << NFS_CS_REUSEPORT),
+		.xprtsec = {
+			.policy = RPC_XPRTSEC_NONE,
+		},
 	};
 	struct nfs_client *clp;
 	int error;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3cc027d3bd58..5c986c0d3cce 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -81,6 +81,7 @@ struct nfs_client_initdata {
 	struct net *net;
 	const struct rpc_timeout *timeparms;
 	const struct cred *cred;
+	struct xprtsec_parms xprtsec;
 };
 
 /*
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 669cda757a5c..8fa187a9c46d 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -93,6 +93,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		.net = mds_clp->cl_net,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
+		.xprtsec = mds_clp->cl_xprtsec,
 	};
 	struct nfs_client *clp;
 	char buf[INET6_ADDRSTRLEN + 1];
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d3051b051a56..75ed8354576b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -896,7 +896,8 @@ static int nfs4_set_client(struct nfs_server *server,
 		int proto, const struct rpc_timeout *timeparms,
 		u32 minorversion, unsigned int nconnect,
 		unsigned int max_connect,
-		struct net *net)
+		struct net *net,
+		struct xprtsec_parms *xprtsec)
 {
 	struct nfs_client_initdata cl_init = {
 		.hostname = hostname,
@@ -909,6 +910,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		.net = net,
 		.timeparms = timeparms,
 		.cred = server->cred,
+		.xprtsec = *xprtsec,
 	};
 	struct nfs_client *clp;
 
@@ -978,6 +980,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		.net = mds_clp->cl_net,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
+		.xprtsec = mds_srv->nfs_client->cl_xprtsec,
 	};
 	char buf[INET6_ADDRSTRLEN + 1];
 
@@ -1127,6 +1130,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct xprtsec_parms xprtsec = {
+		.policy		= RPC_XPRTSEC_NONE,
+	};
 	struct rpc_timeout timeparms;
 	int error;
 
@@ -1157,7 +1163,8 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->minorversion,
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
-				fc->net_ns);
+				fc->net_ns,
+				&xprtsec);
 	if (error < 0)
 		return error;
 
@@ -1247,7 +1254,8 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
 				parent_client->cl_max_connect,
-				parent_client->cl_net);
+				parent_client->cl_net,
+				&parent_client->cl_xprtsec);
 	if (!error)
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
@@ -1263,7 +1271,8 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
 				parent_client->cl_max_connect,
-				parent_client->cl_net);
+				parent_client->cl_net,
+				&parent_client->cl_xprtsec);
 	if (error < 0)
 		goto error;
 
@@ -1336,7 +1345,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	error = nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion,
-				clp->cl_nconnect, clp->cl_max_connect, net);
+				clp->cl_nconnect, clp->cl_max_connect,
+				net, &clp->cl_xprtsec);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error != 0) {
 		nfs_server_insert_lists(server);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..fa5a592de798 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -63,7 +63,8 @@ struct nfs_client {
 	u32			cl_minorversion;/* NFSv4 minorversion */
 	unsigned int		cl_nconnect;	/* Number of connections */
 	unsigned int		cl_max_connect; /* max number of xprts allowed */
-	const char *		cl_principal;  /* used for machine cred */
+	const char *		cl_principal;	/* used for machine cred */
+	struct xprtsec_parms	cl_xprtsec;	/* xprt security policy */
 
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct list_head	cl_ds_clients; /* auth flavor data servers */


