Return-Path: <linux-nfs+bounces-1312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64783B259
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B69B2173A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A22131E39;
	Wed, 24 Jan 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nmkNyzyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DB132C1D
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125036; cv=none; b=bCogapw+gj3lIAgQQRpndp3yNfFvtJKxxfQ7p1ZqsFlFR3APVMLyLRQFYOlBidHY0RNrRUmpObYhGmUlUcxPcSrusxbK8iwj/maaikVrylp/urIEYbdIdONPOO7mjgZE/G+1znxZfAZkGmQ67URtfVkIkh22rcZ3blHbkUixyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125036; c=relaxed/simple;
	bh=u1dHi6mNixi1zGBfCROOYSu8eSvq8Cesu/3w1LhDWZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfYl1EF/zXNuwzKdSTHitDLMe9Nk/AKBQ5Fa9VFknIJqtgNYBr6KRFJwRuzhLbKcn7TjQsD94Mvf5H7FTb+kUAA+qdgg3WNtEWbTnAVoKavNeVe5hoQxeiHnZCYoE+PYtxP51UzYbTaMs+Bmck2zO39DJyFB0iPawIh7kLmZbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nmkNyzyQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60032f9e510so19706557b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706125033; x=1706729833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=nmkNyzyQ08zNUXV/2toiURkjGSSDNlySn62XZJRfBa+wOxne+Mq5fxKtdeS50H1d5R
         iSv563GURHxEaqQOfoHtyl6myeXhKscg6s85WRRrr4jlf1P1OrznGsvboElA+nCqxEew
         elaq14sf2ItR8PMK4WV/ZBTofxxq/ujStAoyA9JJewMGVAbuqslrOvxR8y1MWNfXiH6m
         Qe0t4BnCaLyeFmBq/yLPGXB3MzWkUV9JrBRTgefTbfvB5NYa55dziHV1U98jCYwWEjpz
         nYpHC98BBXWpd+lP2AtTHG/aeTsX2zGIQ+4YqqwlwlkvkdmkbvgiQ0DJ2o4Y1+xVbjuM
         6QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125033; x=1706729833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=o2lcS81ys0Oi4pSQHthf5a+jRfB/QGGCO/9WwWxkN2OdVW2qu8OBuRe2jOaop9Jfi7
         xgPD0w/XKyWtv88Jx5ZmiYTi87LmyMLRq6zLaK5eqVFtzB6c4ETwsw6uRVGIyxffpC0g
         N0THno1zqqvIzrJb0xWqSccv1EEyJYFpNW0RN131hNZs1rmzaHr0y5WjCyT7jPkDsLdm
         cPQKlh+PyWeNex2teoqXwJyUH7MsXJVnFSW786yaKbSFDpdP+QO6i4iezqKcN+At8ic/
         QxMtwPxratCdSWuCKj5hSIvuxrMa/weBjVN7p1ZfVSJy+8dNqEiTar+noEBoyXdoG3LW
         7wwA==
X-Gm-Message-State: AOJu0YwVSVBbfrZWAAedmYIiyh4I12I8fAUslYnoudoglJ+AFYQ4dvWv
	EKLSzHtKtCmsEBoi9X9+NAaRYHfYKT49DlXho4K9tnocXLmh4ZAVdN87EuAo8No5ysHxp+fPQwK
	X
X-Google-Smtp-Source: AGHT+IEbs31EjEli+UgVbi9XsQngS+LG5D9PrQZPwcZsEpgpqrG9V0abJeF4kRKgNaf+KnDqBkHYUg==
X-Received: by 2002:a81:de4b:0:b0:5ff:71b6:6d08 with SMTP id o11-20020a81de4b000000b005ff71b66d08mr1278914ywl.60.1706125033250;
        Wed, 24 Jan 2024 11:37:13 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k124-20020a0dc882000000b005ffc4cdd868sm143231ywd.54.2024.01.24.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:37:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] nfs: expose /proc/net/sunrpc/nfs in net namespaces
Date: Wed, 24 Jan 2024 14:36:59 -0500
Message-ID: <08e0e9271d8289d4aada0d83a17d3aa85086d18a.1706124811.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706124811.git.josef@toxicpanda.com>
References: <cover.1706124811.git.josef@toxicpanda.com>
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


