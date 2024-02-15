Return-Path: <linux-nfs+bounces-1973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC5856E37
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 21:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE01F230A1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 20:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D913AA3B;
	Thu, 15 Feb 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="O8nX5guS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8A13AA2A
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027067; cv=none; b=sW2YCyi0K4rP04sKD/uphBFtce/Chi9jyTVS1ziXcsHGtUqLIiANXJh9pK82nwGCVELddBHfzqFQRDfbYITSPvFsp8HSq2Oc3NfZS9NeOk2y/f5Y1WTQV9+zAq8HqJSZUcKPJ7lJmn8NXcdYFxnwNP+5W9nMxCNVmfB3PpiDs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027067; c=relaxed/simple;
	bh=dT/x4S9dPhP1hnPlf39Kuz4qA5UhMAnNDKno0Sk8fNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWxQeKs5yKY6vWxh9H+65ZxpcXXuJHU9beTktJSSEP3gk3p+p45g+BxR0lh4HEwFG8JJTvIJ9xfr+KC4G8/srdXS24xZUhOPSZyULuJ8XCSu601GyLTwLgu4tMs/oXbWNEuVsEOQPBoktz7Ye8k+80zizS1PzbAlBPHsVJlsSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=O8nX5guS; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1263173276.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 11:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708027065; x=1708631865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtLuNkJg1GjLuVwgzWgWd67FZ5UILcvpMOYAbQXWrSg=;
        b=O8nX5guSmYHchJRfDiEVTDXmWFTwK/TWOipgPGZ/usgbXY9r1y1bpBWCvFTiWiWzFb
         +m9TUPcG13FyzoTfyiiKfv0i30En7pV7tHmeXkYFVY5+n8EsjDMm4TXepD7FsGSZf6wo
         WCA9bH/c28uHeyUcKXiE5teNUlxtquMPbmZtHB9vI6bXW/3jSbN2XxSHt6kzSyeDCThK
         mCkVEfRbr31HKqut26r5t920otWhjYeMiXHvDWjhq4Od2aC6c5R9h3t6x9Jc4DHJIC3S
         xbWSj3B9pT5flLAbdYMXnamd/e+Ro72P/p/cju5duVgvHntwRoiSM7B1GaZkDxASQ4m5
         EpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027065; x=1708631865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtLuNkJg1GjLuVwgzWgWd67FZ5UILcvpMOYAbQXWrSg=;
        b=Bb1Tfx82l8CI9DCFenfg827X/bsd69Jox5YK8VImLyNcV10VD7/kb3KEYjqJpg3Bnj
         WmPveK7chrVAOgWMfTPBm0aD0p9CuNHcUDS/iJEUb3wy4ESxyVT+ErbjcjaxxIZhrf84
         JOmiTb/83XdUhUUPJqiBXFNGBYEYJvQBPKWnapDBuz59Q9R7QKlMNnNeVMVcZRjR7V3A
         UX7IR5+i5QLLvihv3ZEEu0gxaMNi0d73PQ1b7C7/m5tDM7/FPI3o9LL/d8gMrtU2JWiJ
         XWQxm0Riz0lqKmaNZq52YSrlda5NoJG8VU+XFwzYcRHuQW2OStZLiYPpBSEc3j4Zl5yj
         M73g==
X-Forwarded-Encrypted: i=1; AJvYcCXCmn1DbMe+GagohwMsZ+OLLK/0hsXOlxc8QbnrcVWGWH4OVJav7nmak1fs+8DA+wwxPP5d902K5vmtqUC616EoF7vIdQjLcmuI
X-Gm-Message-State: AOJu0YzfE2fO9tRa6KdYpqC0861Un5/0q6JAwjmHOTS/4CkYtTQt0o1Z
	YhdclXklgmGdzdl0e9a281XwN09Kq6C41Tevo/h3sPj4ZDIUxlHKjuwvkqSiD3wSJDYRLe/1gf7
	Q
X-Google-Smtp-Source: AGHT+IFJT2cfAUdh2DvQxFhOsw2AGvDCXURiriGyYuuLUTXwp0WiKTQORW4Zf3lRM3ICMO2X/HjN+A==
X-Received: by 2002:a25:cec9:0:b0:dcc:4747:c54a with SMTP id x192-20020a25cec9000000b00dcc4747c54amr2459702ybe.49.1708027065026;
        Thu, 15 Feb 2024 11:57:45 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i126-20020a256d84000000b00dcd25ce965esm15265ybc.41.2024.02.15.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:57:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 3/3] nfs: make the rpc_stat per net namespace
Date: Thu, 15 Feb 2024 14:57:32 -0500
Message-ID: <4cb938c107a6400baa723098d15dd8a3355d24e8.1708026931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708026931.git.josef@toxicpanda.com>
References: <cover.1708026931.git.josef@toxicpanda.com>
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


