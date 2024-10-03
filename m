Return-Path: <linux-nfs+bounces-6847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5BE98F716
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C071D1C21C1B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358D1ABED9;
	Thu,  3 Oct 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKm5mArS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFD1AAE0C
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984112; cv=none; b=uPgezLpREoELofsGMqy7MAgJTVTuFLWsAFXQM8ZAskdfgz8dG4gmc4qzPQqJpYgB13aywKWzyU1R5oirBn6yZPviy/XI1ajlV5u8780QkIZl8Aj6RozHMvgv14CSrhd+k/HmLajybJwELAf8uODJT6Mr64PWGPD0aIzpqNg9kfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984112; c=relaxed/simple;
	bh=7ldDcdObu85WuKTz+1DDacI/L7k70lt+f+X9H03hq7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0bKkOVOP2grcfIKoKOH4tP0kSulESXIgp50I9tQyJyN8T/ykCogTVaMQQUsxQ4v4OT79jBaYme9bXzyOiqEuZ+92wRRIW9xPco7JF3AGOv8JoO+tIyfB36sf6AUTWIOkluXUk14/D1QRoYFAsiLexockBx7nINrCw82iunOFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKm5mArS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14153C4CEC5;
	Thu,  3 Oct 2024 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984112;
	bh=7ldDcdObu85WuKTz+1DDacI/L7k70lt+f+X9H03hq7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKm5mArS2X/UjI5eI7oIaFqMz4gUXXnhbHsIdOEzlnGl2M89CD5OpNK7R5S3lLvLk
	 /IFeEOYVRpBOMP1qeSYYxnHKa0Ntn1Pz+XvSCrLcmW2DbLUskJKOKmUnR4OrzF84cr
	 qR798ug55KTx1WhvHikVuBOo1kCy32PNukkO1Xf5SgJdqdzWShRPIqT3l+TpffHda5
	 QmRHyAOwGNOvQYy3WSbBHJ2DNPPgVEzH6H2Jwz2KMOBolQWi3kO89t+16l1TZmSYu6
	 hBwLG2y4QD/ilC4OyFnldis50KSuSJPLrQGibucieRQkPHcXNECPdiAHIoETofohYz
	 BVp5Gt6HoD7iw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 5/7] nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
Date: Thu,  3 Oct 2024 15:35:02 -0400
Message-ID: <20241003193504.34640-6-snitzer@kernel.org>
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

nfs_local_commit() doesn't need async cleanup of nfs_local_fsync_ctx,
so there is no need to use a kref.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 88b6658b93fc..2f302b03b253 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -43,7 +43,6 @@ struct nfs_local_fsync_ctx {
 	struct nfsd_file	*localio;
 	struct nfs_commit_data	*data;
 	struct work_struct	work;
-	struct kref		kref;
 	struct completion	*done;
 };
 static void nfs_local_fsync_work(struct work_struct *work);
@@ -683,30 +682,17 @@ nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
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
@@ -739,7 +725,7 @@ int nfs_local_commit(struct nfsd_file *localio,
 	}
 
 	nfs_local_init_commit(data, call_ops);
-	kref_get(&ctx->kref);
+
 	if (how & FLUSH_SYNC) {
 		DECLARE_COMPLETION_ONSTACK(done);
 		ctx->done = &done;
@@ -747,6 +733,6 @@ int nfs_local_commit(struct nfsd_file *localio,
 		wait_for_completion(&done);
 	} else
 		queue_work(nfsiod_workqueue, &ctx->work);
-	nfs_local_fsync_ctx_put(ctx);
+
 	return 0;
 }
-- 
2.44.0


