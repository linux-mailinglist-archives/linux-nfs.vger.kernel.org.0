Return-Path: <linux-nfs+bounces-10637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18BA66003
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326C519A200F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C6204F7E;
	Mon, 17 Mar 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncl1QSkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EE204F63;
	Mon, 17 Mar 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245214; cv=none; b=SbRuBKYysLSj5MmqewJMLd5RWXCigjQI6foVzs9tO77J7FW63/KCPfvJcB1lsTYz0jvMX5osHQe7/5lUiUu79PKRmBUdnwTjNvmL2burrG+7gPNFxhC04MHEG8r2cLt5eUWloGivUnJp+Q+vZA15OPnTMSTUvqM1UPuvmDaKWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245214; c=relaxed/simple;
	bh=+wgurTIA42S6EU/CFvkiUXQW5qZX53Jdp807van4r5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HovdZOd1Sj+iEsPoypPCLvq/rz/TMY9zZe+Qnqm38ibUMKdomm9KtDT7/IPHlZxWIN49tOh8ONwadEkBs8B+HKqbJ+2rqlUovz43WuBL7mt2mdiNIQE3+wGzgt9Ucozn6raE6cW4lMoB33fHw6V+bUoJpn/1/pZI+5FMS6Uu1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncl1QSkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F19C4CEF0;
	Mon, 17 Mar 2025 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245214;
	bh=+wgurTIA42S6EU/CFvkiUXQW5qZX53Jdp807van4r5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ncl1QSkIDiZqv59li1IKJ4kQRNXOxVoLLPmRwXs0ffjmEvmVyUQsT7MnWX3QBA12X
	 HgKUTnGvEYxG9as6+jRiHh7+POOVyRjcGL6EnXCxnT5MEEZ3gF0E1q+EZuzZwQBzFY
	 uH/b4i0k2t1zMcrXW5LeRLxBqsm4rmlNQvvDeVZq4NpSuashwi2/lv25C4i0Pe4bTc
	 M572+xDOfCDLDQK6uZje/l2uvoGmaq0w1iNjjbu2VwkUORE4h9bV50vr5HvvoHtlFB
	 Rwwo5xj8tGcpqYXmT12Bda2JKfrK/G6kxgThmAEuIk4ARGcdjW1FeaAgSeRwwxdfxU
	 szwIr2Ou3Ys1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:56 -0400
Subject: [PATCH RFC 4/9] nfs: transplant nfs_server shutdown into a helper
 function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-4-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+wgurTIA42S6EU/CFvkiUXQW5qZX53Jdp807van4r5I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1UJxGyym3ELJRBjYuUrRDsHe6bm7Wjns3Rp
 E5pCnQiiz+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVAAKCRAADmhBGVaC
 Fa2YEADB7WfIfGw5nyum3kkEEUiGKwMfFrN8nnBQkPWswm6yRLKXs10kbip+bitofjnLbRsfOwz
 GWKL48T8MPa1jGywKyOjoubfxMWlvdkDotFH+uObCeDR/ycDFZlouX5bPTmCieuqXSuaVKbbIt1
 v8rzkY//bonVh1F/zfOzsRSYdG51GEFXj5ALevCcmKAzIlzRdTTXsSulpEMRC+5PN6fz3IoYOl7
 agQKiBC1ctWfjkiVwzrGgT0u5jiYJYuOwtPrLSm5ZQNV4BVE0Ya6AUMKIGbbiiB5Hr/FZK+LOJg
 am/j7L4cjSdXxbrycq6lQnszdhcwPpZYdgYUirZvNItT9e7/w8TL7kS0RAxea9ZUT3C+ANUYEfF
 ajaOvHBBvcszteYfyLSFQUtIRYBBq+ayR/1o3LKsrcGz3qnuf1WdZ2LtD1PGcNWReX4S8O/DXQv
 AZWc9mr7mC/2/IUDrMugsRflkpmdZRl9UOiaUqBPL/WerIteB4J17dNhtzjNhNixoUG0yLHuM4W
 Z1YTXyXz0ZIL2m0TIuP2NEE6B27eHuHtTVgeleG+Qw/PyI6j02DX6PQup57mVsfOzpr39xpDrHq
 zcSQINwMvfG6JRTxpgn4rK+hQ/UM2YnNSjoHsaf18iilM8jlhlWCsbrxHk4RmhqknOQdWtIRaeD
 OlCUGfYreg2QWOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Move the guts of shutdown_store() into a new helper for shutting down a
nfs_server.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/internal.h |  1 +
 fs/nfs/super.c    | 18 ++++++++++++++++++
 fs/nfs/sysfs.c    | 16 ++--------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc286e1c5ad2b2225b1e9a6930b56b..968c8c845f49f5b7ca6f78e391ba2a3024ce64ff 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -507,6 +507,7 @@ bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 int nfs_try_get_tree(struct fs_context *);
 int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
+void nfs_server_shutdown(struct nfs_server *server);
 
 extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index aeb715b4a6902dc907b4b4cf2712232b080c497f..b78251dde6b717738847ebf4b75f6de10e7ea644 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -56,6 +56,7 @@
 #include <linux/parser.h>
 #include <linux/nsproxy.h>
 #include <linux/rcupdate.h>
+#include <linux/lockd/lockd.h>
 
 #include <linux/uaccess.h>
 #include <linux/nfs_ssc.h>
@@ -1386,6 +1387,23 @@ void nfs_kill_super(struct super_block *s)
 }
 EXPORT_SYMBOL_GPL(nfs_kill_super);
 
+void nfs_server_shutdown(struct nfs_server *server)
+{
+	/* already shut down? */
+	if (server->flags & NFS_MOUNT_SHUTDOWN)
+		return;
+
+	server->flags |= NFS_MOUNT_SHUTDOWN;
+	rpc_clnt_shutdown(server->client);
+	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
+
+	if (!IS_ERR(server->client_acl))
+		rpc_clnt_shutdown(server->client_acl);
+
+	if (server->nlm_host)
+		nlm_host_shutdown_rpc(server->nlm_host);
+}
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 /*
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index c0bfe6df53b51c0fcc541c33ab7590813114d7ec..1b2e2ed10a1bf8d4ad06dc676ec5831d6eba99b4 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 #include <linux/lockd/lockd.h>
 
+#include "internal.h"
 #include "nfs4_fs.h"
 #include "netns.h"
 #include "sysfs.h"
@@ -242,20 +243,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (val != 1)
 		return -EINVAL;
 
-	/* already shut down? */
-	if (server->flags & NFS_MOUNT_SHUTDOWN)
-		goto out;
-
-	server->flags |= NFS_MOUNT_SHUTDOWN;
-	rpc_clnt_shutdown(server->client);
-	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
-
-	if (!IS_ERR(server->client_acl))
-		rpc_clnt_shutdown(server->client_acl);
-
-	if (server->nlm_host)
-		nlm_host_shutdown_rpc(server->nlm_host);
-out:
+	nfs_server_shutdown(server);
 	return count;
 }
 

-- 
2.48.1


