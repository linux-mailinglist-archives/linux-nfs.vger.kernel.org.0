Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62507057B8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEPToG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjEPToG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057F180
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 933F16323D
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A60C433D2;
        Tue, 16 May 2023 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266223;
        bh=0cifp6VmmhCEDQnTWVp8nDnSel08/sRy/06a03y/7fY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ee0gvcUZ5UGpLuNGbOq/w852tUBijDnm9s1bwwmQJLSvSpWP35S1eyN7iKKGQwaz4
         tQSrJYuQ6dB7oiemdlhjJY2B+mjwyEywbQrRd3eeeSdFGjDLxec+aYP6DKYDnF5luw
         gIvOQzMqjQl+WRyQP2RupPktbfI0HoUVtvMtJa4LQeYflVJ7x0Q9Ii1mbDk+6pHAoZ
         wBxcF3dD8dxenlDL0/5Vhc2bGwx0LxuXM9XWHiOooHQ0ui0CTthnuExmDvQH2+UKCi
         7z4BR75SARf8b8/7Us/q5bQH1e9EP3RzXY1IFgaMdpZqozrg7aPzRo8FvtaYcl7TD6
         GYAc3eZGxaFTg==
Subject: [PATCH RFC 12/12] NFS: Add an "xprtsec=" NFS mount option
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:43:31 -0400
Message-ID: <168426620158.74246.4700489766147656540.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
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
 fs/nfs/client.c     |    5 ++---
 fs/nfs/fs_context.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |    1 +
 fs/nfs/nfs4client.c |    6 ++----
 fs/nfs/super.c      |   12 ++++++++++++
 5 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9bfdade0f6e6..c3a984b1879d 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -515,6 +515,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.version	= clp->rpc_ops->version,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
+		.xprtsec	= cl_init->xprtsec,
 	};
 
 	if (test_bit(NFS_CS_DISCRTRY, &clp->cl_flags))
@@ -680,9 +681,7 @@ static int nfs_init_server(struct nfs_server *server,
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
index 5626d358ee2e..e49e3d18ef88 100644
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
@@ -430,6 +449,29 @@ static int nfs_parse_security_flavors(struct fs_context *fc,
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
@@ -696,6 +738,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
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
@@ -1574,6 +1621,9 @@ static int nfs_init_fs_context(struct fs_context *fc)
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
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 75ed8354576b..bfc68d4e8d32 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1130,9 +1130,6 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
-	struct xprtsec_parms xprtsec = {
-		.policy		= RPC_XPRTSEC_NONE,
-	};
 	struct rpc_timeout timeparms;
 	int error;
 
@@ -1164,7 +1161,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
 				fc->net_ns,
-				&xprtsec);
+				&ctx->xprtsec);
 	if (error < 0)
 		return error;
 
@@ -1323,6 +1320,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
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


