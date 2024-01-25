Return-Path: <linux-nfs+bounces-1423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A583CCEC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79C91C23F52
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A845C0B;
	Thu, 25 Jan 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uPuoKODe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48925135A5B
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212431; cv=none; b=Ge/PXhUlH5vX4t2WOiDm6Rmndj/KLELhviGwfroB1afvWFnmgaDL6NI98VSInRzniSVSb0IOn5GgSrp/7wPkD74b0dDRgs4i0wVX0WrqJBCFHGliC9a8pXYjoPUrEukXOB6+A96BsW0evKFdZmsTXKYFCw23QS+R6lrHirLI7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212431; c=relaxed/simple;
	bh=0Swv5ltMaPmLpvzjUSQGWPiAJ0jJvwJ4r2aZ9TmQ5uc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl7dEMxvO9+5f+wR7p2cBRe9uO5DPEo8gHbycKLglbhS3pyCNe2uUbEDgPi54zYIy86fwqFze4UlrhCmbYiGmFUWPtRYmjqO05SnSGAUqDo+6hV+hOzn3zG41sJx31pJEgdMZMTejI4P9upHsAQ4wgWxFWlfijTkm+bipbwsTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uPuoKODe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc223d20a29so6030980276.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212429; x=1706817229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pldtfI6J5p1Psab7h/+4/66zkVokyywUv447L2q1U/I=;
        b=uPuoKODeA8saYktr078+CM7UKBgWX7E0Dfa6DayhO4xKBggfMg0TDe2nnXzXEuXrWX
         l93Ng43dI/v8wMWDGkSgI9DJC+ruUFxYA6P6BEsUtAErboE0yyJZxXuBYWpZOIMSrqPJ
         fNxuO4L/e0TRZrYueMlUTR2q3jmqEe4Z+Aceva9LYmA6lwl/hk5/zkRUkJ/kmNf63wh8
         uoWUcKBtvmJnLsN4duShVsdkY09bWgX91BB/0bC3HYxzG3zA0Dx/v03tav9naJZnyLJt
         xEDhOIHTQaeuS5YBEvypTrpdVtZogYkuD3twR3mtJUKjVE48W89EUU2MqrOmvEJGjCvI
         AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212429; x=1706817229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pldtfI6J5p1Psab7h/+4/66zkVokyywUv447L2q1U/I=;
        b=qCmJvEd1UH75+xy1PItQgE5gxDDB2UosAsoYepOb4nxHo3XHS9ZA7GuWP6Qizgo4wR
         yRgXWKc3JAQ72/bWli6YflC5zOomPqmus17xlIFZ3WWqbQ9Cfi7KtLoMHAsfBrG1vdbV
         SKpvjP+4cIe9fhrWVfGzpkgaPCvnxU2R0LOeQ2mQ/ELWMf3ExK+i2/pnWfqNfgnMUtyf
         7dFddJnNgLnFuHLSuHCdzwGyNMq5uhFYT8xX6fPtaHVoMh/sJzcHA2NR2KjkRsu86APU
         gaP9x6jsUlrAKgjcqyokg8lUYb1sJm8/TaN71P9cCgVQ/GyRf7ehvWLdNCmWBLl53aix
         sFrQ==
X-Gm-Message-State: AOJu0YwMKuwP09egGyhX9LAxxb5J4H+8N0AWgYr2hT5UKp8in32758R0
	Iez9UE8PqrIrRnQAo7NW4cQ34xQqOl8hjiEb15GscnsI5Ko++VhVH1GeRyVY9STq+Bh1R/EvAna
	7
X-Google-Smtp-Source: AGHT+IGW6aMoTpQZQJchcUFpSSFKuZ4ll0jWfmiQA4Oa6jiBl0M0QhnUVXCuvB6SNzPZiJg2lT8PAw==
X-Received: by 2002:a5b:610:0:b0:dc6:833:6fcd with SMTP id d16-20020a5b0610000000b00dc608336fcdmr311302ybq.120.1706212429169;
        Thu, 25 Jan 2024 11:53:49 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a25664d000000b00dc278dca7cfsm3559012ybm.8.2024.01.25.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 13/13] nfs: make the rpc_stat per net namespace
Date: Thu, 25 Jan 2024 14:53:23 -0500
Message-ID: <a5d5c5968b50bcf7b53ff309fc97a1aef4d395d4.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
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


