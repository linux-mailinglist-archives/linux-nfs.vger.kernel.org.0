Return-Path: <linux-nfs+bounces-6849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18798F718
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDC1C22025
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C01AC8A2;
	Thu,  3 Oct 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nct6g8xG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25121AC429
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984115; cv=none; b=hWMqlkKt/W88JfKTR2X2Tn8AC+rXJM0B4MDzQYwTIsZ6HI6sQ4JweKUHzngJAFiDs0UmdIPybYLnsCKDa/L4rMq2lbjMN/hvXQndvtMsehlLSNfiXe+j/Ss/CCdBe0hG0ZSU6rVeIvjDsrU7NBaNeJqA7a+iMgM1+H4SmO2sH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984115; c=relaxed/simple;
	bh=wf+uxwVhQ23mgHRQ1/toeoe9veu4h6XUqaiUyiHud5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGdiJ6WvwqsbKZ3YtS//Cat+FzgkyFmD2WF8oU3DllS1m5jxVNl9ZcrPVt6ENUj/+CGuCYm+j1S8tK2erJ9hXkznP89I1na00XXl5sdR8uyBFfPo/Lj6ThiIvz3ah8+YylRYFS7SfV7luyiAcApdBg/huz+b3ldshfuT5kLXJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nct6g8xG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1538C4CECC;
	Thu,  3 Oct 2024 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984114;
	bh=wf+uxwVhQ23mgHRQ1/toeoe9veu4h6XUqaiUyiHud5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nct6g8xGd35mkIc2fqpHaxGsQgNW4ZZUkEOgI5RIdUYSscMjPoM8bLidS0BDDRLDk
	 nZK1IMd0z0wmrgCqXsof7LdvY2swFBM16SJJBPVVVVHkKQ8e0oax8YQUg4ZAkyCSyx
	 wHvvX7huXaOEp6yL7PCK/nsMgUowTGbobiLFIY190vQx3dpRpq3mquCFqjozpi/wO3
	 fwVS3szaS1Vtb+hZwyIbqQA5lJBDiZcFjThLsyyivLeXqn2y1Z2k3d+5Jt81ZCFGxE
	 lE5oO1jHoGA8gIcOQcjYRrWwE4uUmYDzPn6sujcIhkDdy5HM3vKT+OxOMTc5OaDAze
	 ONjuCk9vPdz+Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 7/7] nfs/localio: eliminate need for nfs_local_fsync_work forward declaration
Date: Thu,  3 Oct 2024 15:35:04 -0400
Message-ID: <20241003193504.34640-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
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
index 12d3e200156c..98cd572426b4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -45,7 +45,6 @@ struct nfs_local_fsync_ctx {
 	struct work_struct	work;
 	struct completion	*done;
 };
-static void nfs_local_fsync_work(struct work_struct *work);
 
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
@@ -678,21 +677,6 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
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
@@ -717,6 +701,21 @@ nfs_local_fsync_work(struct work_struct *work)
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


