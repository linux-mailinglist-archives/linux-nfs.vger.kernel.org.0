Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0BA34E969
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhC3NkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 09:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhC3NkO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Mar 2021 09:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC5B619AD;
        Tue, 30 Mar 2021 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617111613;
        bh=XpwHXQP36h3OtLLpN6tLl07iLjfdBUlnw8X1kIQsYcg=;
        h=From:To:Cc:Subject:Date:From;
        b=jcagH5aV2bIyoQmCIMnONaktd3QKgBbDz2Z1pDuWw9eH6ZtBgqG4pohg1k1A0Kbuz
         7Nz/mnUq+EP6Gn4+oeG+b3wyI2nlTbbCtzZyC7L0YsuwdWyjcc5+0gsCrc8rBwFXCG
         uJQpy+eM+tLGIxnRDaW3H/Q97cHIJ/QfJomL+put6M6V+L+43a5I7s8yTfTfdyCojv
         FuD7SaJKhLRV1P50W4T+NrdLP6SjX31n1yL8qgeDgZZu8ssLFrwy29OTBw3UXknnNd
         tehAVNk54NrHp5icGhDyjsh9CWFDsygqjXEWaTFhyKw8Y7SOiTGhASvMaBbM8HfZsN
         jDb80p2MqhlKg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Eryu Guan <eguan@linux.alibaba.com>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: [PATCH] NFS: Fix up the support for CONFIG_NFS_DISABLE_UDP_SUPPORT
Date:   Tue, 30 Mar 2021 09:40:10 -0400
Message-Id: <20210330134010.61313-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Rather than removing the support in nfs_init_timeout_values(), we should
just fix up the validation checks in the mount option parsers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c     |  2 --
 fs/nfs/fs_context.c | 54 +++++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 94d47be1d1f6..2aeb4e52a4f1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -476,7 +476,6 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 			to->to_maxval = to->to_initval;
 		to->to_exponential = 0;
 		break;
-#ifndef CONFIG_NFS_DISABLE_UDP_SUPPORT
 	case XPRT_TRANSPORT_UDP:
 		if (retrans == NFS_UNSPEC_RETRANS)
 			to->to_retries = NFS_DEF_UDP_RETRANS;
@@ -487,7 +486,6 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
 		to->to_exponential = 1;
 		break;
-#endif
 	default:
 		BUG();
 	}
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 902db1262d2b..cdf32b9a6c35 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -283,20 +283,40 @@ static int nfs_verify_server_address(struct sockaddr *addr)
 	return 0;
 }
 
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
+static bool nfs_server_transport_udp_invalid(const struct nfs_fs_context *ctx)
+{
+	return true;
+}
+#else
+static bool nfs_server_transport_udp_invalid(const struct nfs_fs_context *ctx)
+{
+	if (ctx->version == 4)
+		return true;
+	return false;
+}
+#endif
+
 /*
  * Sanity check the NFS transport protocol.
- *
  */
-static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
+static int nfs_validate_transport_protocol(struct fs_context *fc,
+					   struct nfs_fs_context *ctx)
 {
 	switch (ctx->nfs_server.protocol) {
 	case XPRT_TRANSPORT_UDP:
+		if (nfs_server_transport_udp_invalid(ctx))
+			goto out_invalid_transport_udp;
+		break;
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
 		break;
 	default:
 		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 	}
+	return 0;
+out_invalid_transport_udp:
+	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
 }
 
 /*
@@ -305,8 +325,6 @@ static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
  */
 static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 {
-	nfs_validate_transport_protocol(ctx);
-
 	if (ctx->mount_server.protocol == XPRT_TRANSPORT_UDP ||
 	    ctx->mount_server.protocol == XPRT_TRANSPORT_TCP)
 			return;
@@ -929,6 +947,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 	struct nfs_fh *mntfh = ctx->mntfh;
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
+	int ret;
 
 	if (data == NULL)
 		goto out_no_data;
@@ -1054,6 +1073,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		goto generic;
 	}
 
+	ret = nfs_validate_transport_protocol(fc, ctx);
+	if (ret)
+		return ret;
+
 	ctx->skip_reconfig_option_check = true;
 	return 0;
 
@@ -1155,6 +1178,7 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	int ret;
 	char *c;
 
 	if (!data) {
@@ -1227,9 +1251,9 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 	ctx->acdirmin	= data->acdirmin;
 	ctx->acdirmax	= data->acdirmax;
 	ctx->nfs_server.protocol = data->proto;
-	nfs_validate_transport_protocol(ctx);
-	if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
-		goto out_invalid_transport_udp;
+	ret = nfs_validate_transport_protocol(fc, ctx);
+	if (ret)
+		return ret;
 done:
 	ctx->skip_reconfig_option_check = true;
 	return 0;
@@ -1240,9 +1264,6 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 
 out_no_address:
 	return nfs_invalf(fc, "NFS4: mount program didn't pass remote address");
-
-out_invalid_transport_udp:
-	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
 }
 #endif
 
@@ -1307,6 +1328,10 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 	if (!nfs_verify_server_address(sap))
 		goto out_no_address;
 
+	ret = nfs_validate_transport_protocol(fc, ctx);
+	if (ret)
+		return ret;
+
 	if (ctx->version == 4) {
 		if (IS_ENABLED(CONFIG_NFS_V4)) {
 			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
@@ -1315,9 +1340,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 				port = NFS_PORT;
 			max_namelen = NFS4_MAXNAMLEN;
 			max_pathlen = NFS4_MAXPATHLEN;
-			nfs_validate_transport_protocol(ctx);
-			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
-				goto out_invalid_transport_udp;
 			ctx->flags &= ~(NFS_MOUNT_NONLM | NFS_MOUNT_NOACL |
 					NFS_MOUNT_VER3 | NFS_MOUNT_LOCAL_FLOCK |
 					NFS_MOUNT_LOCAL_FCNTL);
@@ -1326,10 +1348,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 		}
 	} else {
 		nfs_set_mount_transport_protocol(ctx);
-#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
-	       if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
-		       goto out_invalid_transport_udp;
-#endif
 		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
 			port = NFS_RDMA_PORT;
 	}
@@ -1363,8 +1381,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 out_v4_not_compiled:
 	nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
 	return -EPROTONOSUPPORT;
-out_invalid_transport_udp:
-	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
 out_no_address:
 	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 out_mountproto_mismatch:
-- 
2.30.2

