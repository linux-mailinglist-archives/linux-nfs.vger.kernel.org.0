Return-Path: <linux-nfs+bounces-1512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374F83E43F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE221F22CC4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B92E3E4;
	Fri, 26 Jan 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HkxSY1/a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17068286BF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305763; cv=none; b=h2pnBK91PioAXvJkwxTdhA6es8W7i+FfE1s0zrQLEgOAzom2GpEvVBLXjITF2ELEG9kZu5oeaD6UXNp9XnkYQHOIhe7O8BnxAkdjTXqru27wyNH/oBD5Zkc4tDHRg/VeeXxyJE1tva9qxhjPeLNS0zhAWbfWPPiex05wtld0h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305763; c=relaxed/simple;
	bh=dT/x4S9dPhP1hnPlf39Kuz4qA5UhMAnNDKno0Sk8fNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arWvBTAthV7uwAQsJriVYiaz9rcH94iPl3xs8XQZZgTR1rvDdwEzqI/ED590geUDG4FYnXGYEnG8o4pkJ3SMVFfgPSCO9pGjrQnxhUJVjCPT42OXJcU/7u2+Ye6aFwQecF3QQN/jBMGAPzN0K1TQBFfHnCcbKigAcwQ0pF64yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HkxSY1/a; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5fc2e997804so9531227b3.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706305761; x=1706910561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtLuNkJg1GjLuVwgzWgWd67FZ5UILcvpMOYAbQXWrSg=;
        b=HkxSY1/aOo75Z3nLMrrZgS8jJEwMsIofF6kE7DVk87wtykk1vbiAD+jrJCIMYbo1iH
         3PAoAraj/DZjxwGVDyuJ5Iq1szC9pprK4XjStWOTKfAFX6F1/bMvPShs7yVO7YOnHYd8
         FLoQkMgQgicBL7eZMksh4Lm1gM/kUsqCwPxRdvn2pw9ovx4BX8LzhH0ldpv+qsWTu8Dw
         8sXmymEMzDpIkJCD6GFzRQZtuR02NNEA1Jkwt3k2I171pO55xQxeKv3zvK+lhVWLeZun
         k8hnIwrcujqn4K3ZO6yjIrh/LLKIuyO49hXOvT1KAnjVBBOyvxAP/D2E/QBOsb5+KnV2
         TLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305761; x=1706910561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtLuNkJg1GjLuVwgzWgWd67FZ5UILcvpMOYAbQXWrSg=;
        b=XXA054BHktN58Q/mAIsC+W9SKz5pr28vPIg/DrsvFsnFzwiXy1suRD+7n1ZDmKUzsZ
         1loBcD4t/AkDSksv+6xqhMrbIAsbW6qXefR8/mE67lyztWded3ZT7bCDjCfOpp+vxKL7
         CgLblaK05yk3wBcZnfBjpq8vMBqOuIhaa5gdr9UHnJN0Y1V/MqSe7zXbFKHHWdc/T3GN
         xecRr0ZS8zphvA6Bakx+ZkwDGNXTsyQYN9ocojlP0hzdwAqS59tBOPJNvdFQUJ6/MV52
         dcaQSW/KCpjItsk5yTlnRxuv3LRyFOXs1OIjK/bFj5EDrJrpQcSvhz8RJfsRr/B8YAxo
         Gvpg==
X-Gm-Message-State: AOJu0YxDBX/ju3gCHF0rkxgg1lScd3ZZQtIjhaR5lFDsbiQ2s5c9C94Q
	xnk3k8Zhi3OUMK6Yvx7k8/39TStNsEvC5QuDX06FB5+QhIj+fp4cIfDQS9A8VrkKB4WYpgs/HKm
	e
X-Google-Smtp-Source: AGHT+IGWgkfvi+QMCcXXBaneGrubQMV3PHT/zwu/SlfxGMH4AJ11JRExMRbKtZm7xlh1VzuQO0To1g==
X-Received: by 2002:a81:de03:0:b0:5ff:62b0:acf with SMTP id k3-20020a81de03000000b005ff62b00acfmr536436ywj.40.1706305760969;
        Fri, 26 Jan 2024 13:49:20 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bf15-20020a05690c028f00b00602f3e50c62sm97701ywb.113.2024.01.26.13.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:49:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 3/3] nfs: make the rpc_stat per net namespace
Date: Fri, 26 Jan 2024 16:49:02 -0500
Message-ID: <fd68188777db9f8325f1d73152aa3900c5a3b578.1706305686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706305686.git.josef@toxicpanda.com>
References: <cover.1706305686.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're exposing the rpc stats on a per-network namespace basis,
move this struct into struct nfs_net and use that to make sure only the
per-network namespace stats are exposed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/client.c   | 5 ++++-
 fs/nfs/inode.c    | 4 +++-
 fs/nfs/internal.h | 2 --
 fs/nfs/netns.h    | 2 ++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..4d9249c99989 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -73,7 +73,6 @@ const struct rpc_program nfs_program = {
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
 	.version		= nfs_version,
-	.stats			= &nfs_rpcstat,
 	.pipe_dir_name		= NFS_PIPE_DIRNAME,
 };
 
@@ -502,6 +501,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 			  const struct nfs_client_initdata *cl_init,
 			  rpc_authflavor_t flavor)
 {
+	struct nfs_net		*nn = net_generic(clp->cl_net, nfs_net_id);
 	struct rpc_clnt		*clnt = NULL;
 	struct rpc_create_args args = {
 		.net		= clp->cl_net,
@@ -513,6 +513,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.servername	= clp->cl_hostname,
 		.nodename	= cl_init->nodename,
 		.program	= &nfs_program,
+		.stats		= &nn->rpcstats,
 		.version	= clp->rpc_ops->version,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
@@ -1175,6 +1176,8 @@ void nfs_clients_init(struct net *net)
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
+	memset(&nn->rpcstats, 0, sizeof(nn->rpcstats));
+	nn->rpcstats.program = &nfs_program;
 
 	nfs_netns_sysfs_setup(nn, net);
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e11e9c34aa56..91b4d811958a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2426,8 +2426,10 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 
 static int nfs_net_init(struct net *net)
 {
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+
 	nfs_clients_init(net);
-	rpc_proc_register(net, &nfs_rpcstat);
+	rpc_proc_register(net, &nn->rpcstats);
 	return nfs_fs_proc_net_init(net);
 }
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e3722ce6722e..06253695fe53 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -449,8 +449,6 @@ int nfs_try_get_tree(struct fs_context *);
 int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
 
-extern struct rpc_stat nfs_rpcstat;
-
 extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 extern bool nfs_sb_active(struct super_block *sb);
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index c8374f74dce1..a68b21603ea9 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -9,6 +9,7 @@
 #include <linux/nfs4.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/sunrpc/stats.h>
 
 struct bl_dev_msg {
 	int32_t status;
@@ -34,6 +35,7 @@ struct nfs_net {
 	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
 	ktime_t boot_time;
+	struct rpc_stat rpcstats;
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_nfsfs;
 #endif
-- 
2.43.0


