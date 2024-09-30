Return-Path: <linux-nfs+bounces-6727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D698AA45
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0FC281E13
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560D195980;
	Mon, 30 Sep 2024 16:47:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BB18EB0
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714823; cv=none; b=N2ftyvAd8ZeHp5Id3qoOjDdKuK0VeFEFqPQpCPnRVsEzDXscvd6cOYealB/XzHB1TlAJVpRcixOPAdxW7rBdlFLjm9HhOVX+LkGsXrWluMeTYP7yDydd8absM0WyCcw4dXdM4vhBHKuB2BEfbkOL8E9MgNOwYEldbwsMN1NR6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714823; c=relaxed/simple;
	bh=wf+uxwVhQ23mgHRQ1/toeoe9veu4h6XUqaiUyiHud5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSmg6OtZj5kFeu+T4+Ye5pMl5QXVUGxMso2NbxY9shv6PX51N/YpRk5reVq5HHK7u2TEtyeyZRh7SJAGWjLaCESaNwwAY8VpIKJLxThLwHDBnjXsDmITh63MH9IMcEGw3ZXd0kL2qrzWfDgUGihlz/QKDacuxCHfSVr5C1m09Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a3a8cef4d2so846748137.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714819; x=1728319619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWDhj2bMDWCX0Wn/uG71cVjb4CiZW/kucpfpijmbd7Q=;
        b=jQV7a0+ptnY1mLt8YRE0HPA/iLtb/xgm3i2B3di22dRXxjovw6sWdF8fLrcEaW5J+I
         gFkYm4/8DTiMxrQugyu68YsiiMI5d+3U55MXYj1rc41RYXxucV0AloLcxLXaipJ2EyWi
         qsaLNJ6ZVJBbFO+kl74kvSU/6Ahn+WD1Cgz3dUQ0hmkI5CZWHEjcW3dK+S6CxFcWulaM
         j41jf+rA/W/yJmdQjG5ifwClRWDvVPZ4Bv9jsmAYDICNqu8KvGz0o9qXjalKo+amQrLH
         F3ZKVSk1V4abNJEHBaNYK+ZvJ/X7WITCI4I0vdco3SwwAfd+jgO9xYydNeh87xlhEY98
         vS4Q==
X-Gm-Message-State: AOJu0YwX7ISDRQeT7TfQ01NPno/nE7Ta9GvTITC/i2iITv7Xw2YukZTQ
	PS/0N3PwC5z5aA8iDFhak6vKRajJbRNBmOVJknVUxCp/0TuN/jGC99sp29uoWIujkknBzZj21vq
	/Js7CMWvoWE0l67ymlzXarnl1iav6hY/MampmK2p/Dh0YeLhh0bixO/7dGPC4prCYUStdEGae/c
	j80WLvhirewWOOmLF96tx00Y4cE0KZsjKbF1z0zcY=
X-Google-Smtp-Source: AGHT+IEAahnuyoWmalkgMw4fQvQGtXxDyDwVPaJ9B7LccR2Lu+nE64jGm7VHdll8UZhOYUvAkev7kg==
X-Received: by 2002:a05:6102:41a3:b0:4a3:cdfb:5926 with SMTP id ada2fe7eead31-4a3cdfb5d80mr2002251137.4.1727714818708;
        Mon, 30 Sep 2024 09:46:58 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b610b12sm41363436d6.39.2024.09.30.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:57 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 5/5] nfs/localio: eliminate need for nfs_local_fsync_work forward declaration
Date: Mon, 30 Sep 2024 12:46:37 -0400
Message-ID: <20240930164637.8300-6-snitzer@kernel.org>
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


