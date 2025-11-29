Return-Path: <linux-nfs+bounces-16788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E9C937D2
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 235254E0585
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A61229B2A;
	Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA19QG2q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE622E3E7
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389196; cv=none; b=rRn3eKSqGfeQo+3xRh7v8e2S9jWk2uHkSsdNGi/ipr1mkxHSAxYcE3/9uK1YIyx9ikCqKQ8cvYeGyhGIeI6llxuU6+ZjcEtnxnfs675pCMNAmGNc8NOk6GN10XwhAzqGxLB5aG/uBwJLbsxZt6VpZJnNbx55R25IoHPpPiH4B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389196; c=relaxed/simple;
	bh=lTOJCQZi4KQyLn7tbVje80wjUz9zJ2xZatwmRYvOsGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5Wo51UUBiVXx4kFx0OZrlc87494VBAqOY1KYq5Sv+88AFRC7sCfFyERL+DQ+Z4WSJ9KPPYNq88eiKoSFLpgTrzXDm1/V7A3A44r7Tzw1wE7Wje8z1EojRXUjxC7CzViDUTzDUtc7WfeHFuj1e8ZzOFj1+VrFrBX0MbSaG/BQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA19QG2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98206C4CEFB;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389195;
	bh=lTOJCQZi4KQyLn7tbVje80wjUz9zJ2xZatwmRYvOsGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LA19QG2qzHWg1XxIEqffKwHKBAmEHVizWpg5JshSEEBKllF87yJ83XyyFoz9juNi4
	 EWZuYom1zNyUnID2M8LEtt/LaQi2uu6GsSeGyQU6s4IYiGwliJeiwjyUmWya1jctE0
	 ZztAW+HAqwYQZuhMGt6xFJfswaFf6J3WSVcw66rIuGtHwHnzdGukyZHznfNpnegy3O
	 JpLr9R+0J6nVIyZSjvj4ZZqvaLFERqUaxCAc99gVhDvgjCtQUC8F5AFGKmvOTINNVg
	 Owf4xWgtrnmHn/asWle/p12X95vzcTTT7Id7GNNDp/4EVTO8aVJQ++E3JVdIdU9kW7
	 4U0/wJKVE2Lmw==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] NFS: Automounted filesystem should inherit ro,noexec,nodev,sync flags
Date: Fri, 28 Nov 2025 23:06:30 -0500
Message-ID: <b6ffd220aca29e14c0a0cf21834f465c80b6a07c.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When a filesystem is being automounted, it needs to preserve the
user-set superblock mount options, such as the "ro" flag.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Link: https://lore.kernel.org/all/20240604112636.236517-3-lilingfeng@huaweicloud.com/
Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/namespace.c | 6 ++++++
 fs/nfs/super.c     | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 5a4d193da1a9..dca055676c4f 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -149,6 +149,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
 	struct nfs_server *server = NFS_SB(path->dentry->d_sb);
 	struct nfs_client *client = server->nfs_client;
+	unsigned long s_flags = path->dentry->d_sb->s_flags;
 	int timeout = READ_ONCE(nfs_mountpoint_expiry_timeout);
 	int ret;
 
@@ -174,6 +175,11 @@ struct vfsmount *nfs_d_automount(struct path *path)
 		fc->net_ns = get_net(client->cl_net);
 	}
 
+	/* Inherit the flags covered by NFS_SB_MASK */
+	fc->sb_flags_mask |= NFS_SB_MASK;
+	fc->sb_flags &= ~NFS_SB_MASK;
+	fc->sb_flags |= s_flags & NFS_SB_MASK;
+
 	/* for submounts we want the same server; referrals will reassign */
 	memcpy(&ctx->nfs_server._address, &client->cl_addr, client->cl_addrlen);
 	ctx->nfs_server.addrlen	= client->cl_addrlen;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 9b9464e70a7f..66413133b43e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1315,10 +1315,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 	if (server->flags & NFS_MOUNT_NOAC)
 		fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (ctx->clone_data.sb)
-		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
-			fc->sb_flags |= SB_SYNCHRONOUS;
-
 	/* Get a superblock - note that we may end up sharing one that already exists */
 	fc->s_fs_info = server;
 	s = sget_fc(fc, compare_super, nfs_set_super);
-- 
2.52.0


