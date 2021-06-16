Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600673A8E19
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhFPBM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D51C06175F
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c18so906996qkc.11
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0C3XncB5gac/OTCtz1qZ9eL3c2bkAVJA0vgsKsB6j/g=;
        b=kpHJMhAfe3sf3B0OCZqvsHhj+PJmxiJIne4OWY69key9/Ga9TN+azvOvr5IPgTVSnn
         oc1I+oXlHhM7r5OvE26Hyh0EsgjWTcILcXJazz5eFABAM6KLsJScaePjStJozOA2S/Iu
         eWdkR4t9BKaruP50V3oBoBmcOTvZxdAKgcZBcOma6ShG7a7XXCUj/FiY20pEF05GOtP6
         h0jXMT0lsMWHYoiF7h8eWZDsRXhhH+3SgFhHulsEzkT3l6vpU8nDxXH05k/L6hHOkzqo
         kikCF/h6fjo3Ph6YS3LgrqqtJxOWzonYaaU5RJBTyPB2aZpvSnjyhfTSOYs9SCCAuJ8Y
         WHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0C3XncB5gac/OTCtz1qZ9eL3c2bkAVJA0vgsKsB6j/g=;
        b=nE2fqZrBDqBP3xlrF0KjFh9InwWifDFnVb6wMcsXmGTbsbm8GHeXCaOFmLLZi4Swec
         3RcVQh7qnJyqYaY0pH0ljjXbiKoOoTEg+z8F/B9YbgEpxkT9ZILL7uGqIMRLO6r+/3Hk
         2PAXznptqAzkDaBiYNR+8CWR+bjVLVSyqPwfDm4lXmGnrktSSb2JStNgvNSMxNsic11w
         A0wmv01H7j5vNeIXcG80tDS3X2OeuNC+Drl6WuEfaKEQJjxRPsczAF/D0yyH5L+dRMeA
         SOOiq42ZRjyJm+1iCZ+B27+4DlASF2eGgYlnin9MMAlub00pWJO/pq35VA+tntdhMPXc
         cXwQ==
X-Gm-Message-State: AOAM531Ce2Q/Qd1MIaE/ux6KNS394jojZ1ubcd/YKcK+wL0EHg1dkIgz
        nH0iScKuW00uHVIwbIy1mnCojAVMj5KWmw==
X-Google-Smtp-Source: ABdhPJxqn1fOgr6fJAnT3gdPjMK4rrPQ3wDIU39wW5BtwIBTqOwd5pRqGxGRIoI7bizcU1teZdFtng==
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr2529983qkk.197.1623805819863;
        Tue, 15 Jun 2021 18:10:19 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/6] NFSv4 introduce max_connect mount options
Date:   Tue, 15 Jun 2021 21:10:10 -0400
Message-Id: <20210616011013.50547-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This option will control up to how many xprts can the client
establish to the server with a distinct address (that means
nconnect connections are not counted towards this new limit).
This patch is setting up nfs structures to keeep track of the
max_connect limit (does not enforce it).

The default value is kept at 1 so that no current mounts that
don't want any additional connections would be effected. The
maximum value is set at 16.

Mounts to DS are not limited to default value of 1 but instead
set to the maximum default value of 16 (NFS_MAX_TRANSPORTS).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/fs_context.c       |  7 +++++++
 fs/nfs/internal.h         |  2 ++
 fs/nfs/nfs4client.c       | 12 ++++++++++--
 fs/nfs/super.c            |  2 ++
 include/linux/nfs_fs.h    |  5 +++++
 include/linux/nfs_fs_sb.h |  1 +
 7 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 330f65727c45..486dec59972b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	clp->cl_proto = cl_init->proto;
 	clp->cl_nconnect = cl_init->nconnect;
+	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
 	clp->cl_principal = "*";
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d95c9a39bc70..0d444a90f513 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -60,6 +60,7 @@ enum nfs_param {
 	Opt_mountvers,
 	Opt_namelen,
 	Opt_nconnect,
+	Opt_max_connect,
 	Opt_port,
 	Opt_posix,
 	Opt_proto,
@@ -158,6 +159,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("mountvers",	Opt_mountvers),
 	fsparam_u32   ("namlen",	Opt_namelen),
 	fsparam_u32   ("nconnect",	Opt_nconnect),
+	fsparam_u32   ("max_connect",	Opt_max_connect),
 	fsparam_string("nfsvers",	Opt_vers),
 	fsparam_u32   ("port",		Opt_port),
 	fsparam_flag_no("posix",	Opt_posix),
@@ -770,6 +772,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_of_bounds;
 		ctx->nfs_server.nconnect = result.uint_32;
 		break;
+	case Opt_max_connect:
+		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_TRANSPORTS)
+			goto out_of_bounds;
+		ctx->nfs_server.max_connect = result.uint_32;
+		break;
 	case Opt_lookupcache:
 		switch (result.uint_32) {
 		case Opt_lookupcache_all:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a36af04188c2..66fc936834f2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -67,6 +67,7 @@ struct nfs_client_initdata {
 	int proto;
 	u32 minorversion;
 	unsigned int nconnect;
+	unsigned int max_connect;
 	struct net *net;
 	const struct rpc_timeout *timeparms;
 	const struct cred *cred;
@@ -121,6 +122,7 @@ struct nfs_fs_context {
 		int			port;
 		unsigned short		protocol;
 		unsigned short		nconnect;
+		unsigned short		max_connect;
 		unsigned short		export_path_len;
 	} nfs_server;
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 28431acd1230..270caa1805a2 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -865,6 +865,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		const char *ip_addr,
 		int proto, const struct rpc_timeout *timeparms,
 		u32 minorversion, unsigned int nconnect,
+		unsigned int max_connect,
 		struct net *net)
 {
 	struct nfs_client_initdata cl_init = {
@@ -883,6 +884,8 @@ static int nfs4_set_client(struct nfs_server *server,
 
 	if (minorversion == 0)
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
+	else
+		cl_init.max_connect = max_connect;
 	if (proto == XPRT_TRANSPORT_TCP)
 		cl_init.nconnect = nconnect;
 
@@ -952,8 +955,10 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
-	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP)
+	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP) {
 		cl_init.nconnect = mds_clp->cl_nconnect;
+		cl_init.max_connect = NFS_MAX_TRANSPORTS;
+	}
 
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
@@ -1122,6 +1127,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				&timeparms,
 				ctx->minorversion,
 				ctx->nfs_server.nconnect,
+				ctx->nfs_server.max_connect,
 				fc->net_ns);
 	if (error < 0)
 		return error;
@@ -1211,6 +1217,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_max_connect,
 				parent_client->cl_net);
 	if (!error)
 		goto init_server;
@@ -1226,6 +1233,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_max_connect,
 				parent_client->cl_net);
 	if (error < 0)
 		goto error;
@@ -1323,7 +1331,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	error = nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion,
-				clp->cl_nconnect, net);
+				clp->cl_nconnect, clp->cl_max_connect, net);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error != 0) {
 		nfs_server_insert_lists(server);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index fe58525cfed4..e65c83494c05 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -480,6 +480,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	if (clp->cl_nconnect > 0)
 		seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
 	if (version == 4) {
+		if (clp->cl_max_connect > 1)
+			seq_printf(m, ",max_connect=%u", clp->cl_max_connect);
 		if (nfss->port != NFS_PORT)
 			seq_printf(m, ",port=%u", nfss->port);
 	} else
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ffba254d2098..c13414a8dfde 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -40,6 +40,11 @@
 
 #include <linux/mempool.h>
 
+/*
+ * These are the default for number of transports to different server IPs
+ */
+#define NFS_MAX_TRANSPORTS 16
+
 /*
  * These are the default flags for swap requests
  */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d71a0e90faeb..2a9acbfe00f0 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -62,6 +62,7 @@ struct nfs_client {
 
 	u32			cl_minorversion;/* NFSv4 minorversion */
 	unsigned int		cl_nconnect;	/* Number of connections */
+	unsigned int		cl_max_connect; /* max number of xprts allowed */
 	const char *		cl_principal;  /* used for machine cred */
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-- 
2.27.0

