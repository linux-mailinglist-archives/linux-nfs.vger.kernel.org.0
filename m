Return-Path: <linux-nfs+bounces-3603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC91900690
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D451D1C233C7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0541196C72;
	Fri,  7 Jun 2024 14:27:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710919643F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770438; cv=none; b=q9OmjrsnjG0OW28hAyjTq9gbbVfDiRGx6fV9TResj3+fa0COz6EJf7RRPTU5Wj2B72rkiEzvN4bihiwwIy0danmXAVh1dOFYFDZF7vHkRFxZ4Bgk8tgiFG3WJawZCbBb8b57AX+ZphJ+39tLekXFhFTqBW3BH0Ee3S+aygKjCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770438; c=relaxed/simple;
	bh=PGs9SM9c5btXCQBTo2cCE424URKl7TWd+mAF0O8hqjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0Q4bwzOTUjfSpiF63eR2declaW4tjtKaHbbUve8hQgMcp0VsbS4ud99rpxX5jmuPCDwOOgoV6GP1uT9diNbW936NXPQdoW5QTsLMIFtcLSItnIMCLb0GCIUVfPLzkZDVzc7wH4dvx2mFB8ZOtX9r8Jw+twxI5e4XkYe3Ez8wJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79535efc9d8so115163185a.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770436; x=1718375236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UMN+ZOHwnD3QK3Nchwp5ADELYSCP19Cxy87zfC5aUo=;
        b=olKZNIvvt8M9iwIbOHkqde+lbwz2x2xic2y1PACWZDnNph8QzAkynl6yFvZGpKl5hN
         LzETKv6t+b/EET05uib+mp8vqs0UX9dfXwtDhm6q4gzgQQhsClHt1yOx3//VhiD7pWFl
         eg33XcXl7YhH2op3xa5F6Xd+5wjbKpSl9izgHK/mNWaAUAw00JIzVzd30wDt4vYnb53V
         Hek+65ODSs9qnzyHqP0Z4HcwEc/I6Qcf7q7unDO4KCjLCsa6UL2PkZmEbWL7KAdw7jdn
         40ZfjU7PQtshreDMN+gzEv2RghWOnsfuo+15P79lNO+u4LiqxfgOcVV5uj8GEXabfAp/
         Y+lw==
X-Gm-Message-State: AOJu0YwzKXxa0OE+z8iwW/EAyRQSEJjcQ2mMNzACZ/R7JQ0DgjWskJ+f
	YXrIwhN7sWI1F7TvR11/PPTNZaEanQxFMJL44FxVaoUMvy1iAn78Fds+Y/eRqUVRQ6V2xcCH1qb
	AbsI=
X-Google-Smtp-Source: AGHT+IEewKX9MbPHALkeMaimNL7QaY65t8xoNbJzV6yGFHqT/TeiIPP/Wx7Q0butXpsx4upeUn/m9A==
X-Received: by 2002:a05:6214:3d9d:b0:6af:c66a:d5a8 with SMTP id 6a1803df08f44-6b059f65400mr30137846d6.51.1717770435388;
        Fri, 07 Jun 2024 07:27:15 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f7c64sm17455016d6.119.2024.06.07.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:14 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 18/29] NFS: localio writes need to use a normal workqueue
Date: Fri,  7 Jun 2024 10:26:35 -0400
Message-ID: <20240607142646.20924-19-snitzer@kernel.org>
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

When we start getting low on space, XFS goes and calls flush_work() on a
non-memreclaim work queue, which causes a priority inversion problem.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c    | 24 +++++++++++++++++++-----
 fs/nfs/internal.h |  1 +
 fs/nfs/localio.c  |  4 ++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4f88b860494f..b80469bce8df 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2394,6 +2394,7 @@ static void nfs_destroy_inodecache(void)
 	kmem_cache_destroy(nfs_inode_cachep);
 }
 
+struct workqueue_struct *nfssync_workqueue;
 struct workqueue_struct *nfsiod_workqueue;
 EXPORT_SYMBOL_GPL(nfsiod_workqueue);
 
@@ -2404,9 +2405,17 @@ static int nfsiod_start(void)
 {
 	struct workqueue_struct *wq;
 	dprintk("RPC:       creating workqueue nfsiod\n");
+	wq = alloc_workqueue("nfs-sync", WQ_UNBOUND, 0);
+	if (wq == NULL)
+		return -ENOMEM;
+	nfssync_workqueue = wq;
 	wq = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	if (wq == NULL)
+	if (wq == NULL) {
+		wq = nfssync_workqueue;
+		nfsiod_workqueue = NULL;
+		destroy_workqueue(wq);
 		return -ENOMEM;
+	}
 	nfsiod_workqueue = wq;
 	return 0;
 }
@@ -2419,10 +2428,15 @@ static void nfsiod_stop(void)
 	struct workqueue_struct *wq;
 
 	wq = nfsiod_workqueue;
-	if (wq == NULL)
-		return;
-	nfsiod_workqueue = NULL;
-	destroy_workqueue(wq);
+	if (wq != NULL) {
+		nfsiod_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
+	wq = nfssync_workqueue;
+	if (wq != NULL) {
+		nfssync_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
 }
 
 unsigned int nfs_net_id;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 67b348447a40..0927a1704bbb 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -446,6 +446,7 @@ int nfs_check_flags(int);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
+extern struct workqueue_struct *nfssync_workqueue;
 extern struct inode *nfs_alloc_inode(struct super_block *sb);
 extern void nfs_free_inode(struct inode *);
 extern int nfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d7918e26aeb6..d724f8d4dd65 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -511,7 +511,7 @@ static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
 	args.done = &done;
 	INIT_WORK_ONSTACK(&args.work, nfs_local_call_read);
 
-	queue_work(nfsiod_workqueue, &args.work);
+	queue_work(nfssync_workqueue, &args.work);
 	wait_for_completion(&done);
 	destroy_work_on_stack(&args.work);
 	return 0;
@@ -682,7 +682,7 @@ static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 	args.done = &done;
 	INIT_WORK_ONSTACK(&args.work, nfs_local_call_write);
 
-	queue_work(nfsiod_workqueue, &args.work);
+	queue_work(nfssync_workqueue, &args.work);
 	wait_for_completion(&done);
 	destroy_work_on_stack(&args.work);
 	return 0;
-- 
2.44.0


