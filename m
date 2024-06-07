Return-Path: <linux-nfs+bounces-3602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14E90068F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E74A1F21A6C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8102196D87;
	Fri,  7 Jun 2024 14:27:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D477196444
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770436; cv=none; b=hyCusjC++5Yf8Z5nAbPlw1+1Hx9bQe+rYeXxT0bz8mCGjIjeCediyY/hcQWNpbC8XDQcryzz3vn1E/hRA11A1frjiEowWyGjmiiBsN2P40TOzDskuJFnNmhc2FiUCH3raE6osJJ42yRIMPgx7b+J5b7MwScV6HBTvJbjBfGrBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770436; c=relaxed/simple;
	bh=9AX1XzQR+3txaydZI7fw3uGSB8rPMIrUEwzrXKzmNwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDBRdIPb3qQZa1E6gRSVsvkfHFg5i5nUUlG4Vxmg3GjJcOxraviy4V9Dwdm6T44j3iBem/DbqM6UojN0EBLriej10DjiGmvK+n8J6guZucOKNWaRIAcUTYOKEMjAuSpC7ZL4Ri49tXAHlJpbjJrqroPm8O6R/QhVLKjs8EeQnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-795186ae415so121973985a.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770434; x=1718375234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgdTHijKUc24G63xh7A6xtPwKLa17EyJO5cOAyPJBgo=;
        b=Wtb3WTK+ozA9cjti+SvI/iKIGzAjfGw5u0Di04h5vMRCUah6GKdKLT6lCwFIz8YzNT
         e2Jgy6kDD/0CEl6INor7L1FglVupVe1TT2BRSQXIZNYhO2n9CdDVMQL709a9TsHuwvBY
         p1rhXXk31y2vinyRATodrjkRuZ5P43BeXYjaeLeXIoFDs2azRz+DTR0VMPH73MfKxpCr
         FCbT6WWuXyBsmkEukt3I2Xqs+SuQBrwXAX9i5rJWQR6nGkDiQB4fDxcO7cR1yeUIHz0c
         EIpqSomvPz9G7b4w7UAv4Ft5YM9uaBWfFX8D0PuFlk/4q7PiUIL8SCs0yYGBzgLWd+eK
         NsGA==
X-Gm-Message-State: AOJu0YwLRbUyY1roard7JkunOyn7/kcZpZ4ddfsDte3QEGVrWqIQMGGc
	W9NDFbLrzySETdqeZPyVANq1zgOx7o2sA1+dTmrrF9ekFaMYdHC57qAAx+YfO/JYbQfsH+JEzeb
	uVuI=
X-Google-Smtp-Source: AGHT+IHjeMFK83WWj487sUv2N1FfyyICU9n5tSbKUX9vk11Bi/2bq8CkRmmf3FryUTwE4eeyJPlijA==
X-Received: by 2002:a05:620a:1495:b0:793:fab:b503 with SMTP id af79cd13be357-7953c5eed48mr240753285a.64.1717770433979;
        Fri, 07 Jun 2024 07:27:13 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795328464bdsm171304485a.30.2024.06.07.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:13 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 17/29] NFS: Use completion rather than flush_work() in nfs_local_commit()
Date: Fri,  7 Jun 2024 10:26:34 -0400
Message-ID: <20240607142646.20924-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Make the code consistent with other routines.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d997f0a96627..d7918e26aeb6 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -60,6 +60,7 @@ struct nfs_local_fsync_ctx {
 	struct nfs_commit_data	*data;
 	struct work_struct	work;
 	struct kref		kref;
+	struct completion	*done;
 };
 static void nfs_local_fsync_work(struct work_struct *work);
 
@@ -813,6 +814,7 @@ nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
 		ctx->data = data;
 		INIT_WORK(&ctx->work, nfs_local_fsync_work);
 		kref_init(&ctx->kref);
+		ctx->done = NULL;
 	}
 	return ctx;
 }
@@ -847,6 +849,8 @@ nfs_local_fsync_work(struct work_struct *work)
 
 	status = nfs_local_run_commit(ctx->filp, ctx->data);
 	nfs_local_commit_done(ctx->data, status);
+	if (ctx->done != NULL)
+		complete(ctx->done);
 	nfs_local_fsync_ctx_free(ctx);
 }
 
@@ -866,9 +870,13 @@ nfs_local_commit(struct nfs_client *clp, struct file *filp,
 
 	nfs_local_init_commit(data, call_ops);
 	kref_get(&ctx->kref);
-	queue_work(nfsiod_workqueue, &ctx->work);
-	if (how & FLUSH_SYNC)
-		flush_work(&ctx->work);
+	if (how & FLUSH_SYNC) {
+		DECLARE_COMPLETION_ONSTACK(done);
+		ctx->done = &done;
+		queue_work(nfsiod_workqueue, &ctx->work);
+		wait_for_completion(&done);
+	} else
+		queue_work(nfsiod_workqueue, &ctx->work);
 	nfs_local_fsync_ctx_put(ctx);
 	return 0;
 }
-- 
2.44.0


