Return-Path: <linux-nfs+bounces-1972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F8856E35
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 21:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37162888F4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F1E13A892;
	Thu, 15 Feb 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="glyN6dzT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C913AA26
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027067; cv=none; b=bEq1M6oVPwkOr+zczexN8714j7qsG16x84QFiCvSslEXVHDsGm1+KoErCDo3EqfSC7Senqdzotb3SGw9KlDHKaVqxLAqgVXtV31bJZuAAcxB4RihUypN+56RvZZpC23ui7hfdlO0IIfQEcxdrIJRRmccK7AXYMBZAhDS/ShZRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027067; c=relaxed/simple;
	bh=u1dHi6mNixi1zGBfCROOYSu8eSvq8Cesu/3w1LhDWZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qReOwbRR7NcF57a3BduAkyzBP5aoN6AYo/6QEi+t4UXbPVf6jfR/ayFskIURpwhoWRjswm8uV/sUe/9pSK4zDM1NqecxawBZEy0u66uEXjU9Vq3y36ovA5fgfaxWJ+fmmMMmszD6rsD2L/Hhydam4JBJoeE6UgsQm36RsGwtMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=glyN6dzT; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso1283964276.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708027064; x=1708631864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=glyN6dzT94/qBaWVgpCJzi4yKMXZaOZAb5T4Du2yywGOxJ3V/KSGxzyMQPPm5KT/Te
         L9BRBhoRbEJMtEg3vumhL3yaW7OXpE9sWuBRT90AVBbSJTM+vpxXjyFZZwtp7W1Npzn9
         BOjqVAzA3HjFg00chOLkv8kj0ogPiOEYyOSB8V5f5Uy36z+8UkzJZEHDd7uR794COE/h
         aUSHtGYCu7/HHAD+NN2DfZzvVoX7MygpGBBuwdPsrfYg7QQ16QRdToCk/89cKiz9bwll
         2z5V4joN/99a8TeUxKEQoPsxbBt/VnB8I30BxMfTg93NpK6hawhoQlZ7L1fDE9/+RqSk
         Z0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027064; x=1708631864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=GeFF/kdFeJqRLWdBqlXU+H3BkUFkRfpwDlb5TiwD1jrbdkCZYBWUcEs4Gcktyws0WO
         /Penyd7tIlUpIjbHz+jqK+6E5XoDZK9hpqLr4RzAkrPBWr3tAb1bHkUSGeiBQwwP4fHX
         mipLVjkT98k6cKs9+24jXXrHQy/fZR60bS67OhA1JJcM3tB22xAIffkbN/CYibD+WF2w
         NtKfK3ekeFvOUH6QvyNTH+GiunUNqzrZLW1P7q7FbP5iPe6ZU7s9mnGflxF/Zu9lSZcc
         yJIKEodh5Q/0LJ9V+3vGsvwleq9kpQOH9CB9MxMQA6S71w0N2JbTovBhyufZcuuG6n9B
         cqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYyVBqqU0/BMjZ536uRHvGdSlrTEEzpqK2Sd7nOQQkaTmnY1Er6WYYRjddBBjdfUfD7nKoBSJI2qu3TYkYrTz7Oq0kxDWixza8
X-Gm-Message-State: AOJu0YwwSO8r7+JLuskHsTy7ZKIBiC1bU2psLn6b6pzjJleAmXO1uHVN
	BkYqaLoFzRKkzb5BkzVAApeEKri16WBsQIGOAyXwJc8kcDJy/37Z62BYe8CUAAg=
X-Google-Smtp-Source: AGHT+IGPIxn78YhbzvKca1sMjn6QO+usa+wNQs+ZF0mV5Ud5yGJ9CG6YbPUBjgVNcPPkWGvCrcJ5xQ==
X-Received: by 2002:a81:ac1c:0:b0:607:f09d:b2af with SMTP id k28-20020a81ac1c000000b00607f09db2afmr746818ywh.1.1708027064134;
        Thu, 15 Feb 2024 11:57:44 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gz7-20020a05690c470700b00607b3038a7dsm21954ywb.9.2024.02.15.11.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:57:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 2/3] nfs: expose /proc/net/sunrpc/nfs in net namespaces
Date: Thu, 15 Feb 2024 14:57:31 -0500
Message-ID: <ad5c97b53255a08cf443bb34460847e92cfe6410.1708026931.git.josef@toxicpanda.com>
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


