Return-Path: <linux-nfs+bounces-1422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731783CCEB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21AF1F22EB8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFF135A5C;
	Thu, 25 Jan 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i5BSsuoT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26E13666C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212430; cv=none; b=CRIDuIqOo4gOt7I1UU3Hr6aBRiN4liHPZGxkHKZ1TWtC11wt4vIN9hW0tonZOZ8PKk/3EOAOhirWMkkfs2f/XCiZI9jQZqynqwxmD1KIBnLOMmvCGEeE7vhDkdwOTV9LJ7JqFOPZV1TSxnPDAmUXS9OdYMRREs10210TOJCcMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212430; c=relaxed/simple;
	bh=u1dHi6mNixi1zGBfCROOYSu8eSvq8Cesu/3w1LhDWZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFRM29I6gVTlpZi+HdxhU4LFSm4dpy7PE3ZzHFRVyyMH7Li5ypiBBZ51VBzb2qn5rXExRWfeHIV3xZtpxxDEKpCZYBh+vWv901XTfO3yMyevn32wZfakWTRZFg/AKUXT5ySSFUapxpdW7PWjIOeavToJt28g+mp1K8sI2c+23H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i5BSsuoT; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc223f3dd5eso6063972276.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212428; x=1706817228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=i5BSsuoT25ftojA1XvPe4txi7OcOoRQ2zWNwZsomeBx1jAKRqrUfJq5lsVTl8koPKi
         hliCmj4q/DJeqbzbdADKqeKtT/oQpHmveL2dn2Q3CILiLC3KEudcf72G3XvNRAVPmn9C
         OGtky5QBCErN8Ul4eKCxnkQKfq5Ue3Bd7u33ff95lFRm+M8luzIC+xe/xQHliJZRZthK
         hbzjuc+cU1MtW+CxvQ29FOuR5O+Kij0c4F8JrqOZmLsheqt77plj/USfERjC6WhjWlP7
         w5jMrAznF64xiR9HPVbezITRkkcc+RQ/Xbg9tQmTv810JoXoOJ9HYX95/DUgu25sdaIp
         Uwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212428; x=1706817228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=edMaJ2LXyEwuDh0LuZFOYcG0bC5vCzVB8gxoQ+H/uexOjy2KDs7b2UFgDcpBQrVAoT
         n3pFtZgFOuyabHbUM+mURN1OUAQuIvwTJutaI/rd1pkDU/ADiRBNS5NHV7HQv4U6TuHr
         DDTv6iethXXAoR7+kfzqqlJqHbz4/UXBAgDZwD8n57yAGOpDReP2MzboFaA6QKI8TFJx
         9zJIl+ac0G5yWLhJOsBU7nRWFCrFx+NSBbwr9ZDgdTTNv/KeWk1S/G2z/ynkzak4U6db
         NXXc2effQVdWml2wpbruAfYRdatW0K0EcTfdQZDwnQVWl7/YkYFJR0E1y/8t/uam7cra
         j8zg==
X-Gm-Message-State: AOJu0YwvqR2XGV7P0QnFg0bvGj8wPqBKD+DzrjbKL1H0pGWNK33yn1dL
	ClCmlM+IXLc+nEZjj4uaIFrbdMHr159Cxy5aA6pE08NVyTuKuS922oOyJ6NOAyV80igdhajI3k1
	T
X-Google-Smtp-Source: AGHT+IE60uMzVgsOJM6M2FS5Ila2N6Sc6vPcXptooEdHNkB1W5CtjtmRT3mX+MKiKpxQ3I1Vd7OvNQ==
X-Received: by 2002:a25:2fce:0:b0:dc6:18fb:447d with SMTP id v197-20020a252fce000000b00dc618fb447dmr394393ybv.13.1706212428181;
        Thu, 25 Jan 2024 11:53:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c18-20020a5b0bd2000000b00dc255105656sm3574061ybr.4.2024.01.25.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:47 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 12/13] nfs: expose /proc/net/sunrpc/nfs in net namespaces
Date: Thu, 25 Jan 2024 14:53:22 -0500
Message-ID: <db8a0b4348a8ac4dac61d9c94a3404618babcaa4.1706212208.git.josef@toxicpanda.com>
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


