Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66CC7261EF
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 16:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjFGOAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbjFGOAZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 10:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261611BF1
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 07:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8917163723
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93762C433EF;
        Wed,  7 Jun 2023 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146421;
        bh=BuUKYrVeD2D510114CHwG8CAdA3ngJtIF7NsffJTTuM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mdU0X2aADOiMxkiK1Is41tltolPirkoKZrMa9FvRn91HYqoGJF3epanP6CbyPSabv
         KYW/f42As/RR4OWsDlIzd0+bu+/aDEBlDgj6awr+MmlYRY7alnky+TeqZC3I8ws6NC
         zYQxqVYJCrNPIi2yuvdVicHo6AQw+yR0pzQQPw63gJlQ2W7vIHYtK4CKEyKWsIGl0d
         0E5l00h8/60gBaGDFDiDJbCMMWa4ssj1Az+5zyF8MZZhW2kEqgpB5BxDmPf7OtwAED
         zLnRUKrG18OljU/v9TNiJmXgYonN5NHj7XDDabgDjNIoEDL4CZwSZFMFjza//wzx/i
         +rGgqVWM4OQ/Q==
Subject: [PATCH v4 9/9] NFS: Add an "xprtsec=" NFS mount option
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 07 Jun 2023 10:00:09 -0400
Message-ID: <168614639943.2082.4586975754355006296.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
References: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

After some discussion, we decided that controlling transport layer
security policy should be separate from the setting for the user
authentication flavor. To accomplish this, add a new NFS mount
option to select a transport layer security policy for RPC
operations associated with the mount point.

  xprtsec=none     - Transport layer security is forced off.

  xprtsec=tls      - Establish an encryption-only TLS session. If
                     the initial handshake fails, the mount fails.
                     If TLS is not available on a reconnect, drop
                     the connection and try again.

  xprtsec=mtls     - Both sides authenticate and an encrypted
                     session is created. If the initial handshake
                     fails, the mount fails. If TLS is not available
                     on a reconnect, drop the connection and try
                     again.

To support client peer authentication (mtls), the handshake daemon
will have configurable default authentication material (certificate
or pre-shared key). In the future, mount options can be added that
can provide this material on a per-mount basis.

Updates to mount.nfs (to support xprtsec=auto) and nfs(5) will be
sent under separate cover.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c     |    6 ++---
 fs/nfs/fs_context.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |    1 +
 fs/nfs/nfs3client.c |    8 +++++--
 fs/nfs/nfs4client.c |   28 +++++++++++++++--------
 fs/nfs/super.c      |   12 ++++++++++
 6 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9bfdade0f6e6..d5441e60d7e1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -463,6 +463,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 
 	switch (proto) {
 	case XPRT_TRANSPORT_TCP:
+	case XPRT_TRANSPORT_TCP_TLS:
 	case XPRT_TRANSPORT_RDMA:
 		if (retrans == NFS_UNSPEC_RETRANS)
 			to->to_retries = NFS_DEF_TCP_RETRANS;
@@ -515,6 +516,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.version	= clp->rpc_ops->version,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
+		.xprtsec	= cl_init->xprtsec,
 	};
 
 	if (test_bit(NFS_CS_DISCRTRY, &clp->cl_flags))
@@ -680,9 +682,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
 		.init_flags = (1UL << NFS_CS_REUSEPORT),
-		.xprtsec = {
-			.policy = RPC_XPRTSEC_NONE,
-		},
+		.xprtsec = ctx->xprtsec,
 	};
 	struct nfs_client *clp;
 	int error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 5626d358ee2e..853e8d609bb3 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -18,6 +18,9 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
+
+#include <net/handshake.h>
+
 #include "nfs.h"
 #include "internal.h"
 
@@ -88,6 +91,7 @@ enum nfs_param {
 	Opt_vers,
 	Opt_wsize,
 	Opt_write,
+	Opt_xprtsec,
 };
 
 enum {
@@ -194,6 +198,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("vers",		Opt_vers),
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
+	fsparam_string("xprtsec",	Opt_xprtsec),
 	{}
 };
 
@@ -267,6 +272,20 @@ static const struct constant_table nfs_secflavor_tokens[] = {
 	{}
 };
 
+enum {
+	Opt_xprtsec_none,
+	Opt_xprtsec_tls,
+	Opt_xprtsec_mtls,
+	nr__Opt_xprtsec
+};
+
+static const struct constant_table nfs_xprtsec_policies[] = {
+	{ "none",	Opt_xprtsec_none },
+	{ "tls",	Opt_xprtsec_tls },
+	{ "mtls",	Opt_xprtsec_mtls },
+	{}
+};
+
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -320,9 +339,21 @@ static int nfs_validate_transport_protocol(struct fs_context *fc,
 	default:
 		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 	}
+
+	if (ctx->xprtsec.policy != RPC_XPRTSEC_NONE)
+		switch (ctx->nfs_server.protocol) {
+		case XPRT_TRANSPORT_TCP:
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP_TLS;
+			break;
+		default:
+			goto out_invalid_xprtsec_policy;
+	}
+
 	return 0;
 out_invalid_transport_udp:
 	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
+out_invalid_xprtsec_policy:
+	return nfs_invalf(fc, "NFS: Transport does not support xprtsec");
 }
 
 /*
@@ -430,6 +461,29 @@ static int nfs_parse_security_flavors(struct fs_context *fc,
 	return 0;
 }
 
+static int nfs_parse_xprtsec_policy(struct fs_context *fc,
+				    struct fs_parameter *param)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	trace_nfs_mount_assign(param->key, param->string);
+
+	switch (lookup_constant(nfs_xprtsec_policies, param->string, -1)) {
+	case Opt_xprtsec_none:
+		ctx->xprtsec.policy = RPC_XPRTSEC_NONE;
+		break;
+	case Opt_xprtsec_tls:
+		ctx->xprtsec.policy = RPC_XPRTSEC_TLS_ANON;
+		break;
+	case Opt_xprtsec_mtls:
+		ctx->xprtsec.policy = RPC_XPRTSEC_TLS_X509;
+		break;
+	default:
+		return nfs_invalf(fc, "NFS: Unrecognized transport security policy");
+	}
+	return 0;
+}
+
 static int nfs_parse_version_string(struct fs_context *fc,
 				    const char *string)
 {
@@ -696,6 +750,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		if (ret < 0)
 			return ret;
 		break;
+	case Opt_xprtsec:
+		ret = nfs_parse_xprtsec_policy(fc, param);
+		if (ret < 0)
+			return ret;
+		break;
 
 	case Opt_proto:
 		if (!param->string)
@@ -1574,6 +1633,9 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
 		ctx->minorversion	= 0;
 		ctx->need_mount		= true;
+		ctx->xprtsec.policy	= RPC_XPRTSEC_NONE;
+		ctx->xprtsec.cert_serial	= TLS_NO_CERT;
+		ctx->xprtsec.privkey_serial	= TLS_NO_PRIVKEY;
 
 		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5c986c0d3cce..0019c7578f9d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -102,6 +102,7 @@ struct nfs_fs_context {
 	unsigned int		bsize;
 	struct nfs_auth_info	auth_info;
 	rpc_authflavor_t	selected_flavor;
+	struct xprtsec_parms	xprtsec;
 	char			*client_address;
 	unsigned int		version;
 	unsigned int		minorversion;
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 8fa187a9c46d..0844f1651e0f 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -103,8 +103,12 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
-	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP)
-		cl_init.nconnect = mds_clp->cl_nconnect;
+	switch (ds_proto) {
+	case XPRT_TRANSPORT_TCP:
+	case XPRT_TRANSPORT_TCP_TLS:
+		if (mds_clp->cl_nconnect > 1)
+			cl_init.nconnect = mds_clp->cl_nconnect;
+	}
 
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 75ed8354576b..321854942ce1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -918,8 +918,11 @@ static int nfs4_set_client(struct nfs_server *server,
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
 	else
 		cl_init.max_connect = max_connect;
-	if (proto == XPRT_TRANSPORT_TCP)
+	switch (proto) {
+	case XPRT_TRANSPORT_TCP:
+	case XPRT_TRANSPORT_TCP_TLS:
 		cl_init.nconnect = nconnect;
+	}
 
 	if (server->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
@@ -988,9 +991,13 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
-	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP) {
-		cl_init.nconnect = mds_clp->cl_nconnect;
-		cl_init.max_connect = NFS_MAX_TRANSPORTS;
+	switch (ds_proto) {
+	case XPRT_TRANSPORT_TCP:
+	case XPRT_TRANSPORT_TCP_TLS:
+		if (mds_clp->cl_nconnect > 1) {
+			cl_init.nconnect = mds_clp->cl_nconnect;
+			cl_init.max_connect = NFS_MAX_TRANSPORTS;
+		}
 	}
 
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
@@ -1130,9 +1137,6 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
-	struct xprtsec_parms xprtsec = {
-		.policy		= RPC_XPRTSEC_NONE,
-	};
 	struct rpc_timeout timeparms;
 	int error;
 
@@ -1164,7 +1168,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
 				fc->net_ns,
-				&xprtsec);
+				&ctx->xprtsec);
 	if (error < 0)
 		return error;
 
@@ -1226,8 +1230,8 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_client *parent_client;
 	struct nfs_server *server, *parent_server;
+	int proto, error;
 	bool auth_probe;
-	int error;
 
 	server = nfs_alloc_server();
 	if (!server)
@@ -1260,13 +1264,16 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
+	proto = XPRT_TRANSPORT_TCP;
+	if (parent_client->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
+		proto = XPRT_TRANSPORT_TCP_TLS;
 	rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
 	error = nfs4_set_client(server,
 				ctx->nfs_server.hostname,
 				&ctx->nfs_server._address,
 				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
-				XPRT_TRANSPORT_TCP,
+				proto,
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
@@ -1323,6 +1330,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 		.dstaddr	= (struct sockaddr *)sap,
 		.addrlen	= salen,
 		.servername	= hostname,
+		/* cel: bleh. We might need to pass TLS parameters here */
 	};
 	char buf[INET6_ADDRSTRLEN + 1];
 	struct sockaddr_storage address;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 30e53e93049e..059b0beabc1b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -59,6 +59,8 @@
 #include <linux/uaccess.h>
 #include <linux/nfs_ssc.h>
 
+#include <uapi/linux/tls.h>
+
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
@@ -491,6 +493,16 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * nfss->client->cl_timeout->to_initval / HZ);
 	seq_printf(m, ",retrans=%u", nfss->client->cl_timeout->to_retries);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+	switch (clp->cl_xprtsec.policy) {
+	case RPC_XPRTSEC_TLS_ANON:
+		seq_puts(m, ",xprtsec=tls");
+		break;
+	case RPC_XPRTSEC_TLS_X509:
+		seq_puts(m, ",xprtsec=mtls");
+		break;
+	default:
+		break;
+	}
 
 	if (version != 4)
 		nfs_show_mountd_options(m, nfss, showdefaults);


