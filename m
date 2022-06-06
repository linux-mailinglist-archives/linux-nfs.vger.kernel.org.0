Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3553EA67
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiFFOwM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiFFOwM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18D1001
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7116FB81A79
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B16C34115;
        Mon,  6 Jun 2022 14:52:06 +0000 (UTC)
Subject: [PATCH v2 15/15] NFS: Add an "xprtsec=" NFS mount option
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:52:05 -0400
Message-ID: <165452712574.1496.3911067710891054200.stgit@oracle-102.nfsv4.dev>
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

After some discussion, we decided that controlling transport layer
security policy should be separate from the setting for the user
authentication flavor. To accomplish this, add a new NFS mount
option to select a transport layer security policy for RPC
operations associated with the mount point.

  xprtsec=none     - Transport layer security is disabled.

  xprtsec=tls      - Establish an encryption-only TLS session. If
                     the initial handshake fails, the mount fails.
                     If TLS is not available on a reconnect, drop
                     the connection and try again.

The mount.nfs command will provide an addition setting:

  xprtsec=auto     - Try to establish a TLS session, but proceed
                     with no transport layer security if that fails.

Updates to mount.nfs and nfs(5) will be sent under separate cover.

Future work:

To support client peer authentication, the plan is to add another
xprtsec= choice called "mtls" which will require a second mount
option that specifies the pathname of a directory containing the
private key and an x.509 certificate.

Similarly, pre-shared key authentication can be supported by adding
support for "xprtsec=psk" along with a second mount option that
specifies the name of a file containing the key.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c     |   10 +++++++++-
 fs/nfs/fs_context.c |   40 ++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |    1 +
 fs/nfs/nfs4client.c |    2 +-
 fs/nfs/super.c      |    7 +++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 0896e4f047d1..1f26c1ad18b3 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -530,6 +530,14 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
 		args.flags |= RPC_CLNT_CREATE_REUSEPORT;
 
+	switch (clp->cl_xprtsec) {
+	case NFS_CS_XPRTSEC_TLS:
+		args.xprtsec = RPC_XPRTSEC_TLS_X509;
+		break;
+	default:
+		args.xprtsec = RPC_XPRTSEC_NONE;
+	}
+
 	if (!IS_ERR(clp->cl_rpcclient))
 		return 0;
 
@@ -680,7 +688,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
 		.init_flags = (1UL << NFS_CS_REUSEPORT),
-		.xprtsec_policy = NFS_CS_XPRTSEC_NONE,
+		.xprtsec_policy = ctx->xprtsec_policy,
 	};
 	struct nfs_client *clp;
 	int error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 35e400a557b9..3e29dd88b59b 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -88,6 +88,7 @@ enum nfs_param {
 	Opt_vers,
 	Opt_wsize,
 	Opt_write,
+	Opt_xprtsec,
 };
 
 enum {
@@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("vers",		Opt_vers),
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
+	fsparam_string("xprtsec",	Opt_xprtsec),
 	{}
 };
 
@@ -267,6 +269,18 @@ static const struct constant_table nfs_secflavor_tokens[] = {
 	{}
 };
 
+enum {
+	Opt_xprtsec_none,
+	Opt_xprtsec_tls,
+	nr__Opt_xprtsec
+};
+
+static const struct constant_table nfs_xprtsec_policies[] = {
+	{ "none",	Opt_xprtsec_none },
+	{ "tls",	Opt_xprtsec_tls },
+	{}
+};
+
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -431,6 +445,26 @@ static int nfs_parse_security_flavors(struct fs_context *fc,
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
+		ctx->xprtsec_policy = NFS_CS_XPRTSEC_NONE;
+		break;
+	case Opt_xprtsec_tls:
+		ctx->xprtsec_policy = NFS_CS_XPRTSEC_TLS;
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
@@ -695,6 +729,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		if (ret < 0)
 			return ret;
 		break;
+	case Opt_xprtsec:
+		ret = nfs_parse_xprtsec_policy(fc, param);
+		if (ret < 0)
+			return ret;
+		break;
 
 	case Opt_proto:
 		trace_nfs_mount_assign(param->key, param->string);
@@ -1564,6 +1603,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
 		ctx->minorversion	= 0;
 		ctx->need_mount		= true;
+		ctx->xprtsec_policy	= NFS_CS_XPRTSEC_NONE;
 
 		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0a3512c39376..bc60a556ad92 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -102,6 +102,7 @@ struct nfs_fs_context {
 	unsigned int		bsize;
 	struct nfs_auth_info	auth_info;
 	rpc_authflavor_t	selected_flavor;
+	unsigned int		xprtsec_policy;
 	char			*client_address;
 	unsigned int		version;
 	unsigned int		minorversion;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 682d47e5977b..8dbdb00859fe 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1159,7 +1159,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
 				fc->net_ns,
-				NFS_CS_XPRTSEC_NONE);
+				ctx->xprtsec_policy);
 	if (error < 0)
 		return error;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6ab5eeb000dc..66da994500f9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -491,6 +491,13 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * nfss->client->cl_timeout->to_initval / HZ);
 	seq_printf(m, ",retrans=%u", nfss->client->cl_timeout->to_retries);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+	switch (clp->cl_xprtsec) {
+	case NFS_CS_XPRTSEC_TLS:
+		seq_printf(m, ",xprtsec=tls");
+		break;
+	default:
+		break;
+	}
 
 	if (version != 4)
 		nfs_show_mountd_options(m, nfss, showdefaults);


