Return-Path: <linux-nfs+bounces-1486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709583DDE1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E57288F79
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FCA1D527;
	Fri, 26 Jan 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="duuvcxIW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFB1D6BE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283864; cv=none; b=pk2yZrFUAsyhLo67XVLtnC9dI9LfXDRNl0CUTjceIAGt7D9tY3YU5Ks55ZG17+UAm1EMAgLlHJrLb0xUYKsXP+7bZIRq/RBINebdQzhycd+wgRC/AdzghUp0/vDegiVmFhBCIv4AyE/BoCRyxhZJRyvMLI7db/HtUZP0P8JCazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283864; c=relaxed/simple;
	bh=0Swv5ltMaPmLpvzjUSQGWPiAJ0jJvwJ4r2aZ9TmQ5uc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osrWfBCGyyMz6MLzwGt33nWRxg0cm+UgdTLmvxULn1o0KrXFg0nmEQieDZ9/pZ5QDU7apsA5aaBy9ciWz+TYSx/TSYXBk0vFhcU9Li3COBbNoKu7QYOTgpU2rTgKqky2yrgLS6nmDS1MCVmIAiieQl0Z92y/++BRajDlQhNB/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=duuvcxIW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-600273605a9so5000977b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283862; x=1706888662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pldtfI6J5p1Psab7h/+4/66zkVokyywUv447L2q1U/I=;
        b=duuvcxIW998PO7/LriOFH+ClZJGgXHv9lHwfAVvPMV1ndJPTVDHMvAAJw0/VGZIaof
         lmftId3I+dFX+UDJvgKzhAer9Fx3l4TZ3W+1ie54/xtM2TRxzQY3kPhfCrspEHn9Wf8K
         D6pAr04M/m1jJiZ5H3xBt+0WpzoiCjIN03UlKZiUrJ59Tw9/akj3drHlEkx2vHn535Bd
         dO9+aENs+sAGBWDt08x1fLwO1H5+lEFHjHIVZmP8jkvFZ4lK8Pw55mpMx4M1mxLtT2LA
         6NR3UVTw/9UgKzNiKfj1zJd5pHsXlkcwZw4uwJEsAJmLs6abqJLaa8AmEVx4p/CNB6lx
         3Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283862; x=1706888662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pldtfI6J5p1Psab7h/+4/66zkVokyywUv447L2q1U/I=;
        b=h2Ck/fRjsqfv6lQ8lzbJ6Ni1wnxMD4NzHA9gN7gmjqI/JY9RLqQ9Y6Rce0xvCCFLjV
         H1vvPCrVXabgYg6u67Jpm5586sY++MvHq57ZvzsTWA07Zcn0298YLcQ0tKuqXqPmBZf+
         prVL4eMBG23MyjRw5vt5rtVPfpmtaiLLReoQUzpOmCwLEECCQnCVA77GCuBU1UvpT+s7
         p0/V0sZQbYT5vvqPiLsU/2rZMkRNufNvI6aJheXptwqeqzuPk4nPRySfWyyUmICCk2O0
         cWvUhutOGacnHDwsnX6bIy8wJk3G/0KSTu4NgRDunAUSfgt+vwjszUTeTGWnzuyMUgPp
         UvXg==
X-Gm-Message-State: AOJu0Yz0neYISxooNFp5CEWnG3jDEjPTq6c8Z5kVoRFuxvI+/JbYVsVw
	QjCwTbR1AUVSMHyyCnkzC1hNzDyu4fzm2lmGwmsZUZESaAC/uE1m5qFmeTDPjAcm+mfitBAjH4y
	Q
X-Google-Smtp-Source: AGHT+IFALm5jSXSwHlgHUJfHGDFIihhvyYSgssfZmFKlMlTPj6v+U42OIhz18TMkSKSDaGyVxOwRSA==
X-Received: by 2002:a81:9997:0:b0:5fb:e165:2551 with SMTP id q145-20020a819997000000b005fbe1652551mr1256807ywg.105.1706283861901;
        Fri, 26 Jan 2024 07:44:21 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p64-20020a819843000000b00602b93f6f27sm455201ywg.120.2024.01.26.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:19 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] nfs: make the rpc_stat per net namespace
Date: Fri, 26 Jan 2024 10:43:34 -0500
Message-ID: <9561ff84b1732c9f6a64d72ccb23595379fe74d7.1706283674.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283674.git.josef@toxicpanda.com>
References: <cover.1706283674.git.josef@toxicpanda.com>
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
index 590be14f182f..4d9249c99989 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -73,7 +73,6 @@ const struct rpc_program nfs_program = {
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
 	.version		= nfs_version,
-	.stats                  = &nfs_rpcstat,
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


