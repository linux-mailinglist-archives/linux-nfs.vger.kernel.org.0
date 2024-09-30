Return-Path: <linux-nfs+bounces-6725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9398AA43
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA9C28347F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2C194C6A;
	Mon, 30 Sep 2024 16:46:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AC18EB0
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714816; cv=none; b=CDrAqmFB2qAUDVLHWvwpcIUD3212Vw1iIMhl/wTh8s/TBiR9RMRSbnUbYvpEIZMDqdiZFw7D2EfF12yAJO61EgwlSd0yr0sHGW9NYjCthWj1jPj2KsI+jYjadlsiWUXV8NWj40YKjrt/vc/PIj7S4yEhQZHZDFTro/FK55TSrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714816; c=relaxed/simple;
	bh=7ldDcdObu85WuKTz+1DDacI/L7k70lt+f+X9H03hq7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy86qV9Rk6VHplf5OL2a2zFDCqJKQGqdkkXzxXNtXL24y3UxWdKNhhD1EHTITMvHXxN8EUW4Fh47v4AsHfTA9UGXI4R8GSaOGIteCHSGPWq1fMEN89LYsNVkLPfyu+Y8dY+y1K/R6Q60JVVYduP0WOhR66xO1UgBBEoS+fi2b/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582face04dso42712221cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714812; x=1728319612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSVobspXebR8qHRQIs3lV5zVmfvjvUl8vp8qouzXXDM=;
        b=rBrAsnUUdUBCgmwVOQgYzpbAVV/m2V8aqQoAoF+ZCDQJ/PoE2Ib4Be7z/5kh2JYVGd
         bJuKZ/QUz43AsxxX4ZwXl5POL2ChBDaMlL0pGHl1nNH6bmx2Yan15s7ngKolnaSxVZLo
         KFp+ytjV1WZFaxTlWSVPSx15QYEyaHsNkqhH6MSQ0jeBOr1tNgGCYkMtb0K648ze21Td
         9XUF2ceDF+vcXlhlOyKjvo7Zz49rq6NprRVsnUIL08dTtIVqFSxuv27m18WyGU/iYtf4
         viNp53zHQUPcCakcce5Lon7aqunGFzIxO49d58+VaB8kv7IXU/mXaX6Eg/E9bGCE2vq6
         E0Mw==
X-Gm-Message-State: AOJu0YwYK+B+RBacFOU0Xr7mty97fUaO/RjFxKM9hJRGvx6V0eTEsgt7
	Pa1jwFQc3YVkYcM1o7nbXoTjRlQa0CElFku8xfozIttxn8MeOh9q97efCFQ7KsTLGhcLodZKvtS
	MSrPmeeHeU0HDpPeajGh1+kZBiD/nPUfGLdgiXS6ys/eCmJZzYDxCh88WyAvCKvGO4K2T9V5jTC
	YTKVn2OU6i9Lk8M46a+alzfv3BGFhb7SnI37pyt50=
X-Google-Smtp-Source: AGHT+IEonzlFKAkvwWK91j/VlQMr4rnogSCQ/cn0uhNFZ+mwd7Wv/pvl/vc0/5AXb0hRmm6oiHIA3g==
X-Received: by 2002:ac8:5250:0:b0:45d:7416:1636 with SMTP id d75a77b69052e-45d74161665mr660241cf.2.1727714812521;
        Mon, 30 Sep 2024 09:46:52 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2b6dabsm37744601cf.27.2024.09.30.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:50 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 3/5] nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
Date: Mon, 30 Sep 2024 12:46:35 -0400
Message-ID: <20240930164637.8300-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240930164637.8300-1-snitzer@kernel.org>
References: <20240930164637.8300-1-snitzer@kernel.org>
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


