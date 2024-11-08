Return-Path: <linux-nfs+bounces-7798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AB9C282A
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5C283098
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0C8F54;
	Fri,  8 Nov 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra0PigWX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED3610D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109212; cv=none; b=Xqe1WniQdtbfBAbUbjc8EGgGeB590srPryILq7g1UuW2GlX1MhFOJCRD3rbAdAb9HZUAiT/evyRNWSVBZ3lX98pMxY+sQT8AixDQl2dKNpVyBqmCT5jzuhXIWAWlq+YR/5ZJGHJ0URv4sZPGTXmA2szVU0DzwFxcHqPPofhTX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109212; c=relaxed/simple;
	bh=Q8g8UICpZs7iT3g1RfNyW2/Auufa40rgpzRtnpgNkEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TClpXusqeL5UTVI/GdYFnH7yaEYOem/5wXEHGhD3v1QxrP/B5Sm5Tlh/vqHuAkJYmTmL/UUMPHfnd6caDFqGUNFr40lRQ9G5aQP9tMHi3Nt2yE1CrmEwsCFJPBN58MWi2LucZWj+DwrPOAKEja2/AIzTTWm90sPFxrw15wPyQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra0PigWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED02C4CECE;
	Fri,  8 Nov 2024 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109212;
	bh=Q8g8UICpZs7iT3g1RfNyW2/Auufa40rgpzRtnpgNkEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra0PigWXRV7uG8v0kogAUVHkYEVB4YARxkBvmemKtKyY1pMHhCmR3TbukEZiomUYY
	 S9UsqdJkTnyTJnRoETu36IjIFFy/lSiXIW8dfmbVzJ99mixs/9EKG6A0orVAbNVSz0
	 Wk6fKDfEmdHEsjG9+GdIvt0CvZ9lp/JxDd1drRdzOBLdoZzn0r0GMNZyXVh4LjX8S3
	 bn1jWG5mVPzJU14iRwIbPPrXNC4ei1mzl1SUCUFykIH/pPER5Z+IdpJEZm5NAn70IA
	 qP0gaJXfuqfsBkXg2t9OHvpW4iHQrjw/WJTmVbqWWERUm2fhwjYLWNz9r+vv2TWSPg
	 HmxBTO13MaXSQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 06/19] nfs/localio: eliminate need for nfs_local_fsync_work forward declaration
Date: Fri,  8 Nov 2024 18:39:49 -0500
Message-ID: <20241108234002.16392-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move nfs_local_fsync_ctx_alloc() after nfs_local_fsync_work().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index a77ac7e8a05c..4b8618cf114c 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -44,7 +44,6 @@ struct nfs_local_fsync_ctx {
 	struct work_struct	work;
 	struct completion	*done;
 };
-static void nfs_local_fsync_work(struct work_struct *work);
 
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
@@ -684,21 +683,6 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
 	call_ops->rpc_release(data);
 }
 
-static struct nfs_local_fsync_ctx *
-nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
-			  struct nfsd_file *localio, gfp_t flags)
-{
-	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
-
-	if (ctx != NULL) {
-		ctx->localio = localio;
-		ctx->data = data;
-		INIT_WORK(&ctx->work, nfs_local_fsync_work);
-		ctx->done = NULL;
-	}
-	return ctx;
-}
-
 static void
 nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
 {
@@ -723,6 +707,21 @@ nfs_local_fsync_work(struct work_struct *work)
 	nfs_local_fsync_ctx_free(ctx);
 }
 
+static struct nfs_local_fsync_ctx *
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
+			  struct nfsd_file *localio, gfp_t flags)
+{
+	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
+
+	if (ctx != NULL) {
+		ctx->localio = localio;
+		ctx->data = data;
+		INIT_WORK(&ctx->work, nfs_local_fsync_work);
+		ctx->done = NULL;
+	}
+	return ctx;
+}
+
 int nfs_local_commit(struct nfsd_file *localio,
 		     struct nfs_commit_data *data,
 		     const struct rpc_call_ops *call_ops, int how)
-- 
2.44.0


