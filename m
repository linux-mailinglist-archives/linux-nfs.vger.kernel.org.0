Return-Path: <linux-nfs+bounces-17574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26387CFEE7C
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430CE314F0BF
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39536A022;
	Wed,  7 Jan 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueZyQwq7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0938E138
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802143; cv=none; b=IW3JH++7tQAfiNHhLNbaCnhqOwoqoZNgVRJcJSnXlwSRBGmmx+Ncv9Ue0qIUeAXmdkhGVzXOfXiI7ypItjLewdQjJt9ZbAw/sdG0H1IbGKTb+KtmY7GvDAjf0d7etRTMPa/ZFURFkRk3C4eCfGXEiqHsHZibfJpA9WYFYjp87aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802143; c=relaxed/simple;
	bh=eZEsVvXMcWy8qXTRmVqAESrh7Iom2YXDjiT7pbvwAdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV8r08kxF0rJq/CcRDI0WsUQHWdY9mO/aYqLZIADmELe4Ygy6bwPduKRxarn04vD54NzjpdQ5rEcYn/DY1JnZXQRWxhgSs8QFUlDzhVvCqiN0u/5ili+dg9jxFn+h9RakN1Zq5j+PV28NaES1ap3YIVm0nQAxxyH1pg43onuKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueZyQwq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6BC4CEF7;
	Wed,  7 Jan 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802143;
	bh=eZEsVvXMcWy8qXTRmVqAESrh7Iom2YXDjiT7pbvwAdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueZyQwq7qGXW8eQ4FuqGX/Cdi6r4PPWHTxSFCe0HI4ftKZudQXGkXNguHmAZy8XSw
	 2fOFsXjpKKLF3AqywJacrG5Z5mTmZwkTS3Yi5HO5raSsib24RErvXKTx/uKX4hwuvU
	 p5r6dOTbHWHUYNw2A7uugioVdeODPs/rLmEhJykYefewv03zRGhd05PoPYd1gf8UQX
	 Lipn91SAdrekU6uMjX+qCht2z+j5zT1HPesPRYrYib1N0j3pUXVVv0o5eoSDC0R0/d
	 kZITY1oWNhc6brHxyQ55F3Y4VRSSZE68VuTqdPHMio20q6xOLCIZ4k4jX6rTrtdX9v
	 lCWair6zcpE1A==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
Date: Wed,  7 Jan 2026 11:08:56 -0500
Message-ID: <20260107160858.6847-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260107160858.6847-1-snitzer@kernel.org>
References: <20260107160858.6847-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

nfslocaliod_workqueue is a non-memreclaim workqueue (it isn't
initialized with WQ_MEM_RECLAIM), see commit b9f5dd57f4a5
("nfs/localio: use dedicated workqueues for filesystem read and
write").

Use nfslocaliod_workqueue for LOCALIO's SYNC work.

Also, set PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO in
nfs_local_fsync_work.

Fixes: b9f5dd57f4a5 ("nfs/localio: use dedicated workqueues for filesystem read and write")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c38e7d4685e2f..9ec1652cc5369 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -1060,17 +1060,22 @@ nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
 static void
 nfs_local_fsync_work(struct work_struct *work)
 {
+	unsigned long old_flags = current->flags;
 	struct nfs_local_fsync_ctx *ctx;
 	int status;
 
 	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
 
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
 	status = nfs_local_run_commit(nfs_to->nfsd_file_file(ctx->localio),
 				      ctx->data);
 	nfs_local_commit_done(ctx->data, status);
 	if (ctx->done != NULL)
 		complete(ctx->done);
 	nfs_local_fsync_ctx_free(ctx);
+
+	current->flags = old_flags;
 }
 
 static struct nfs_local_fsync_ctx *
@@ -1094,7 +1099,7 @@ int nfs_local_commit(struct nfsd_file *localio,
 {
 	struct nfs_local_fsync_ctx *ctx;
 
-	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_KERNEL);
+	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_NOIO);
 	if (!ctx) {
 		nfs_local_commit_done(data, -ENOMEM);
 		nfs_local_release_commit_data(localio, data, call_ops);
@@ -1106,10 +1111,10 @@ int nfs_local_commit(struct nfsd_file *localio,
 	if (how & FLUSH_SYNC) {
 		DECLARE_COMPLETION_ONSTACK(done);
 		ctx->done = &done;
-		queue_work(nfsiod_workqueue, &ctx->work);
+		queue_work(nfslocaliod_workqueue, &ctx->work);
 		wait_for_completion(&done);
 	} else
-		queue_work(nfsiod_workqueue, &ctx->work);
+		queue_work(nfslocaliod_workqueue, &ctx->work);
 
 	return 0;
 }
-- 
2.44.0


