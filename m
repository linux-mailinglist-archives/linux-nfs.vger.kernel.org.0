Return-Path: <linux-nfs+bounces-7796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C429C2827
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6611F229F0
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274DB1E1C07;
	Fri,  8 Nov 2024 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD6fK7Jw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033848F54
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109210; cv=none; b=o2DdfUAtmX5txithVcO3/3q050FecIqahCngUnbttHa1vPQpUX+uGsxHDJvH11o8IEqDDWnOl9/bAhnhdtJfMlBbJfdWlUcSczkYPJDV7LNokkt94f3h3GBc3nvkUOqUc8IZOoD65sCasd3BYPBK7xElr5FO5z+yxqIS/CQmk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109210; c=relaxed/simple;
	bh=bn5mwiijpdOy4SciTU3enJgrIX4vhWuUxDZQeVlPoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWLfcbhVn0kCZjSibwZAP7ESGWAkiQsQrna3WXeBD7whopA2cjdPyBHBx91LppNFBSijcUucWX7Ip2IophDflmP1vPt87iKODUrJlBeG9zRMr466WZYY3CilqxW7+v1BcZq1ayPdQ0Fn1GCUUnsKUNQYLDyRVZYin67rKN9zrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD6fK7Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F165C4CECE;
	Fri,  8 Nov 2024 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109209;
	bh=bn5mwiijpdOy4SciTU3enJgrIX4vhWuUxDZQeVlPoWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD6fK7JwbzBxqOSpOvi/5EB0QXbE9jD6iR7qP5Ea7vD8Fjr4fv1hhFMf7GbfC5xis
	 lLC8U+46RO3nYvoRZinbd/KVs3kYrJTLEDazEJzevIe0rfJJmS1MRPnYcVa6Ut8Jih
	 QYOUbolh3nnIbvgk3pCMcD6m3eSnnkdgJxUgivYLrHivhfSQ0V1wcNAxhh4PvL9nqM
	 mIbhGUzgQjlfPkAdTdXn5kHAfdfd41Ylc/hagHsxHEgLQuebKaK1JEI4dKjO/dDryN
	 BXeuQhBb5nAr0qxFCndKOdFzPiQvUT17SK2Pxv4rvrcoLQFHK5xFNmXUsW/3Pn5Vdm
	 XPQmBIpxKjtDw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 04/19] nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
Date: Fri,  8 Nov 2024 18:39:47 -0500
Message-ID: <20241108234002.16392-5-snitzer@kernel.org>
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

nfs_local_commit() doesn't need async cleanup of nfs_local_fsync_ctx,
so there is no need to use a kref.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4b24933093b6..a7eb83a604d0 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -42,7 +42,6 @@ struct nfs_local_fsync_ctx {
 	struct nfsd_file	*localio;
 	struct nfs_commit_data	*data;
 	struct work_struct	work;
-	struct kref		kref;
 	struct completion	*done;
 };
 static void nfs_local_fsync_work(struct work_struct *work);
@@ -689,30 +688,17 @@ nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
 		ctx->localio = localio;
 		ctx->data = data;
 		INIT_WORK(&ctx->work, nfs_local_fsync_work);
-		kref_init(&ctx->kref);
 		ctx->done = NULL;
 	}
 	return ctx;
 }
 
-static void
-nfs_local_fsync_ctx_kref_free(struct kref *kref)
-{
-	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
-}
-
-static void
-nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
-{
-	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
-}
-
 static void
 nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
 {
 	nfs_local_release_commit_data(ctx->localio, ctx->data,
 				      ctx->data->task.tk_ops);
-	nfs_local_fsync_ctx_put(ctx);
+	kfree(ctx);
 }
 
 static void
@@ -745,7 +731,7 @@ int nfs_local_commit(struct nfsd_file *localio,
 	}
 
 	nfs_local_init_commit(data, call_ops);
-	kref_get(&ctx->kref);
+
 	if (how & FLUSH_SYNC) {
 		DECLARE_COMPLETION_ONSTACK(done);
 		ctx->done = &done;
@@ -753,6 +739,6 @@ int nfs_local_commit(struct nfsd_file *localio,
 		wait_for_completion(&done);
 	} else
 		queue_work(nfsiod_workqueue, &ctx->work);
-	nfs_local_fsync_ctx_put(ctx);
+
 	return 0;
 }
-- 
2.44.0


