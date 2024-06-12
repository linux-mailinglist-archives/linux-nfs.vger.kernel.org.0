Return-Path: <linux-nfs+bounces-3664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8390495A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F511F23024
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1821360;
	Wed, 12 Jun 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUgR9Apk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC62135A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161685; cv=none; b=DwUlb9Nnl/6FYm02oh0bNveG6d8M6/y8p79aUZJubrig9GLd4zI4D6JKRGy77oCsYb6692j+BRWR4gOcIiIPdpfvjfkHKixeuGDI/vv5Q7rissFkndJrk5663SIKHXbDlsUwR/gVOrhh3h/hdEhgzSQ16t8BxocE4aQqgH2iMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161685; c=relaxed/simple;
	bh=FB+TqGKW6GpXuu7+EK8Ue9/v8il2Gxp5ePh04jDSmJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcjGHeIzok8Jl/B5wy/x/XcqgBi9mMFMZMytoea0rI++EbJuhmBIDQrjQtS+gEiAFcg6sUiKbfQ/eCJ210sDwYTmwdeHwRQow27ZGTpyfkbM6mW3JIACcb0euM/r76XucMNyJxG38Pj66WbD54LGHtr3zTVZWoHAhNy8hlLbkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUgR9Apk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFBBC32786;
	Wed, 12 Jun 2024 03:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161685;
	bh=FB+TqGKW6GpXuu7+EK8Ue9/v8il2Gxp5ePh04jDSmJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUgR9ApkSEkA2jgzgxpNDrGtp0y57OiC4hMNerUvDEVI8lFYwpcDUhkAfXegq8lE3
	 7ylqwq1K+Czl+ms+gNBvKQufCGC9jX8qhc+M23u5GRB3ijIBDjF9+eCYyr6hPyDZ+T
	 zvBoNu6qZUIO9GXbdBTPFMasQNzWKyMMZqzb2RCgmh8h1ujv5t9vm9OsqJ4UyG9WLk
	 94RcXL/DUcWzf9IKuXuaUFQHVtlYDmyVrwopHCSIF9C8CvRJeA8BpYmnZ0FUroMU4X
	 3yCtc7cYqiD67iugDsnuRLHODPQkZypwIC3y9Se8NUSgVCgKMi1vRVs6kNWaBjLcPT
	 P/qTaXt/x07pg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 08/15] NFS: for localio don't call filesystem read() and write() routines directly
Date: Tue, 11 Jun 2024 23:07:45 -0400
Message-ID: <20240612030752.31754-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Some filesystem writeback routines can end up taking up a lot of stack
space (particularly xfs). Instead of risking running over due to the
extra overhead from the NFS stack, we should just call these routines
from a workqueue job.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c    |  57 +++++++++++++++++---------
 fs/nfs/internal.h |   1 +
 fs/nfs/localio.c  | 102 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 118 insertions(+), 42 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4f88b860494f..f5a618887c6f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2394,35 +2394,54 @@ static void nfs_destroy_inodecache(void)
 	kmem_cache_destroy(nfs_inode_cachep);
 }
 
+struct workqueue_struct *nfslocaliod_workqueue;
 struct workqueue_struct *nfsiod_workqueue;
 EXPORT_SYMBOL_GPL(nfsiod_workqueue);
 
 /*
- * start up the nfsiod workqueue
- */
-static int nfsiod_start(void)
-{
-	struct workqueue_struct *wq;
-	dprintk("RPC:       creating workqueue nfsiod\n");
-	wq = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	if (wq == NULL)
-		return -ENOMEM;
-	nfsiod_workqueue = wq;
-	return 0;
-}
-
-/*
- * Destroy the nfsiod workqueue
+ * Destroy the nfsiod workqueues
  */
 static void nfsiod_stop(void)
 {
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
+#if defined(CONFIG_NFS_V3_LOCALIO) || defined(CONFIG_NFS_V4_LOCALIO)
+	wq = nfslocaliod_workqueue;
+	if (wq != NULL) {
+		nfslocaliod_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
+#endif /* CONFIG_NFS_V3_LOCALIO || CONFIG_NFS_V4_LOCALIO */
+}
+
+/*
+ * Start the nfsiod workqueues
+ */
+static int nfsiod_start(void)
+{
+	dprintk("RPC:       creating workqueue nfsiod\n");
+	nfsiod_workqueue = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (nfsiod_workqueue == NULL)
+		return -ENOMEM;
+#if defined(CONFIG_NFS_V3_LOCALIO) || defined(CONFIG_NFS_V4_LOCALIO)
+	/*
+	 * localio writes need to use a normal (non-memreclaim) workqueue.
+	 * When we start getting low on space, XFS goes and calls flush_work() on
+	 * a non-memreclaim work queue, which causes a priority inversion problem.
+	 */
+	dprintk("RPC:       creating workqueue nfslocaliod\n");
+	nfslocaliod_workqueue = alloc_workqueue("nfslocaliod", WQ_UNBOUND, 0);
+	if (unlikely(nfslocaliod_workqueue == NULL)) {
+		nfsiod_stop();
+		return -ENOMEM;
+	}
+#endif /* CONFIG_NFS_V3_LOCALIO || CONFIG_NFS_V4_LOCALIO */
+	return 0;
 }
 
 unsigned int nfs_net_id;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62909e5594b1..c299b1bfae9b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -440,6 +440,7 @@ int nfs_check_flags(int);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
+extern struct workqueue_struct *nfslocaliod_workqueue;
 extern struct inode *nfs_alloc_inode(struct super_block *sb);
 extern void nfs_free_inode(struct inode *);
 extern int nfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b3996bf9c45d..00832c9be9f5 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -64,6 +64,12 @@ struct nfs_local_fsync_ctx {
 };
 static void nfs_local_fsync_work(struct work_struct *work);
 
+struct nfs_local_io_args {
+	struct nfs_local_kiocb *iocb;
+	struct work_struct work;
+	struct completion *done;
+};
+
 /*
  * We need to translate between nfs status return values and
  * the local errno values which may not be the same.
@@ -421,21 +427,38 @@ nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_complete(iocb);
 }
 
-static int
-nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_read(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_io_args *args =
+		container_of(work, struct nfs_local_io_args, work);
+	struct nfs_local_kiocb *iocb = args->iocb;
+	struct file *filp = iocb->kiocb.ki_filp;
 	struct iov_iter iter;
 	ssize_t status;
 
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_read_done(iocb, status);
+		nfs_local_pgio_release(iocb);
+	}
+	complete(args->done);
+}
+
+static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+			     const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_io_args args;
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, READ);
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
@@ -445,11 +468,18 @@ nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
 		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
 	}
 
-	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
-	if (status != -EIOCBQUEUED) {
-		nfs_local_read_done(iocb, status);
-		nfs_local_pgio_release(iocb);
-	}
+	/*
+	 * Don't call filesystem read() routines directly.
+	 * In order to avoid issues with stack overflow,
+	 * call the read routines from a workqueue job.
+	 */
+	args.iocb = iocb;
+	args.done = &done;
+	INIT_WORK_ONSTACK(&args.work, nfs_local_call_read);
+	queue_work(nfslocaliod_workqueue, &args.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&args.work);
+
 	return 0;
 }
 
@@ -559,14 +589,35 @@ nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_complete(iocb);
 }
 
-static int
-nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_write(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_io_args *args =
+		container_of(work, struct nfs_local_io_args, work);
+	struct nfs_local_kiocb *iocb = args->iocb;
+	struct file *filp = iocb->kiocb.ki_filp;
 	struct iov_iter iter;
 	ssize_t status;
 
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_write_done(iocb, status);
+		nfs_get_vfs_attr(filp, iocb->hdr->res.fattr);
+		nfs_local_pgio_release(iocb);
+	}
+	complete(args->done);
+}
+
+static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+			      const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_io_args args;
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
@@ -574,7 +625,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, WRITE);
 
 	switch (hdr->args.stable) {
 	default:
@@ -594,14 +644,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
-	file_start_write(filp);
-	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
-	file_end_write(filp);
-	if (status != -EIOCBQUEUED) {
-		nfs_local_write_done(iocb, status);
-		nfs_get_vfs_attr(filp, hdr->res.fattr);
-		nfs_local_pgio_release(iocb);
-	}
+	/*
+	 * Don't call filesystem write() routines directly.
+	 * Some filesystem writeback routines can end up taking up a lot of
+	 * stack (particularly xfs). Instead of risking running over due to
+	 * the extra overhead from the NFS stack, call these write routines
+	 * from a workqueue job.
+	 */
+	args.iocb = iocb;
+	args.done = &done;
+	INIT_WORK_ONSTACK(&args.work, nfs_local_call_write);
+	queue_work(nfslocaliod_workqueue, &args.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&args.work);
+
 	return 0;
 }
 
-- 
2.44.0


