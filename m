Return-Path: <linux-nfs+bounces-1511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4283E43D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A01C2140B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CF288D9;
	Fri, 26 Jan 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Lz4ufOJJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC709286A6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305762; cv=none; b=EkfNScwboTYvI1KZ0Ie8n+ukN23rCyCHV16Br1vDDRV6UXYfwkQ5KgqV4Hkv1Hy/M4Ok54oSUkZSmwrYakt5lJfqxbjDdOn/kKYf1EcFqyl3xLG2FjYXiQe3NRuftc50CXH8wuARVTqoV+AE9gLOeSBHkm6mXnDD6ioer6c/YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305762; c=relaxed/simple;
	bh=u1dHi6mNixi1zGBfCROOYSu8eSvq8Cesu/3w1LhDWZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CftyTuN207IuHn2MM/4vifzkDwVWuJkRubuI7EKCJ475oQAN6w3y5IcGmu98j30gNjY/dKVaHxOV4HfWfnQ2QLSqla6MiBMgcJZDcjklStq6y/oQsvZsRGEDGGqcBzNDi0Fscx4Ppn4ZaiuuF4ZsjL5Zbk+2bMBUXCVEmyl/vZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Lz4ufOJJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc2308fe275so854417276.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706305760; x=1706910560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=Lz4ufOJJE0QuJbpeiw1+bmfhtTHyE9A2Ui/diz7q5nkuGV5sTGmeoJ3mR66FsjA+4p
         zr0NgBsUuf0EhIK+nqemdHu7BimKeGp5FygXOWq5TiafWplRnPrDagRMLX9sm/8gezUu
         Zm4GjNSZCgi7GHF386ts/izsT8X1PApQOePo17A9UfXalHQGrk/6774stSlm0G69bQuP
         m4RXOwl1BaWVjMTrM284LYUzxkZ6nm4implEyoZ4Tw0Qx/+wbY+3oObz4RSLZ1H43I1S
         LeQt9GQMP7gxe91GSTRHZjWHjDua158CAubd0l5avAvcP63DjuM+/9G6QyMYr8JqG+8s
         PqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305760; x=1706910560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=tgkff1Yk0UXDNmQLpPQTMVXeJq2NH7h+VMjbfE1+7aSJE4/TVXAiIczv5MvSnX4SsC
         Ys7RxGmgN37OL6plr4zbPXpmQ1n1STAa0rb2ll0iAys7CAQFoNZau6ROd7f5roUkwGX6
         Q+EvlEtl5zikUIQL5yBANt6edJhf/BAWiCPQmfzyZXfcxffzTegc3xBMrM4RPWeuMWbG
         iZaA5Bf4eVLKX2XJ6tHKWqTMxHPYPfoGHGExuVusuW5JLHpHI69/WlxwKjUtBxRfeNlX
         EKDill4rDez0+psX3GHrFARxARB2od0Jxe+U/SsGJ/+esd80THXbDrQGLlVK5fTsyfz5
         U2Fw==
X-Gm-Message-State: AOJu0YyXI+tEVP2GxVcyIMcvlAxrRf6Maxn6dO0624bCIFbmZB95yagB
	X22FEHi12q/DW/iluRtwxJqUf8DzlDXfDebJXcx/jSB/vqcHyzKsXSrf55SYUsdvfIkSg04h0OU
	v
X-Google-Smtp-Source: AGHT+IEYveM9zYLDpYhgazcIcgSdzEz4rijq8UBLxiywWSQLMcQK5W6hfHcAxWO3L1AZK/u5NdxmsA==
X-Received: by 2002:a25:8807:0:b0:dbd:7495:5779 with SMTP id c7-20020a258807000000b00dbd74955779mr511037ybl.57.1706305759737;
        Fri, 26 Jan 2024 13:49:19 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a258049000000b00dc227379358sm623117ybn.19.2024.01.26.13.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:49:19 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 2/3] nfs: expose /proc/net/sunrpc/nfs in net namespaces
Date: Fri, 26 Jan 2024 16:49:01 -0500
Message-ID: <fc3121f2bb74c6cf98c1c4ad86399322f37ffa08.1706305686.git.josef@toxicpanda.com>
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

We're using nfs mounts inside of containers in production and noticed
that the nfs stats are not exposed in /proc.  This is a problem for us
as we use these stats for monitoring, and have to do this awkward bind
mount from the main host into the container in order to get to these
states.

Add the rpc_proc_register call to the pernet operations entry and exit
points so these stats can be exposed inside of network namespaces.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..e11e9c34aa56 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2427,11 +2427,13 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	nfs_clients_init(net);
+	rpc_proc_register(net, &nfs_rpcstat);
 	return nfs_fs_proc_net_init(net);
 }
 
 static void nfs_net_exit(struct net *net)
 {
+	rpc_proc_unregister(net, "nfs");
 	nfs_fs_proc_net_exit(net);
 	nfs_clients_exit(net);
 }
@@ -2486,15 +2488,12 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-	rpc_proc_register(&init_net, &nfs_rpcstat);
-
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
 
 	return 0;
 out0:
-	rpc_proc_unregister(&init_net, "nfs");
 	nfs_destroy_directcache();
 out1:
 	nfs_destroy_writepagecache();
@@ -2524,7 +2523,6 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
 	unregister_pernet_subsys(&nfs_net_ops);
-	rpc_proc_unregister(&init_net, "nfs");
 	unregister_nfs_fs();
 	nfs_fs_proc_exit();
 	nfsiod_stop();
-- 
2.43.0


