Return-Path: <linux-nfs+bounces-3969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9290C10C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 03:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670E6282A83
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259A1CD3C;
	Tue, 18 Jun 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lomVYW6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5C1CD39
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672982; cv=none; b=XV7XaVsunXEWaWyhHhyMHz/fCv31pD46zp74v7NMmUNVKe0VICCYxytTyF+D7sw2ug4onEvlTUnhxcYQ9aAa1Y1mUW/OdauTqJ4A3TCKqSiys82oC5wMhpQYJdX1TDWh8IdM/1uBN3idb9UPmds4z+N5pRTcqxTO6bkNLKX5jDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672982; c=relaxed/simple;
	bh=7k9CVswpxFMOs+fM3IDvz28XxIAojxXP6bgmTPOccWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNoYRimX/+fHVSLG0mb/LXfADd9BTiWVmiEzvX/ZOocV0VreeOyf+DNT8JOuSj2QGFVRuBrWr1Io1iWoMKKzD8QSeaSq8A2PBr2a6m6Ij1bKiqE5wH99J6MOEx5DEXywjbdQn8oO7rf7kG5RgotKvdtPfwKdb1kX9RDRVyuilJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lomVYW6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A51C2BD10;
	Tue, 18 Jun 2024 01:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672982;
	bh=7k9CVswpxFMOs+fM3IDvz28XxIAojxXP6bgmTPOccWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lomVYW6Eny2L6LxU7t+tqEqUtWTEi1hHgdGDvIo7tB07rT3lCyu/1c6aPTD3mwkl0
	 1LLI/Qo6kk8lkUMwY9euoH/FKGAN7c9nFAiRG5FGCJ7uQrLzN5M369X3lKVtFb1mSl
	 Vqo02xk7h+dcIxdve/BPORidWgwHso4Tn1Qbm0NTA+vUcU/p+IXHiC3ixuTRW45X6w
	 iIUNUrqibHaXCT0dsEwAKFhCv9oxLkwgMoCrA7dkQy24AXxEJgPvKKCW5vD7I8KjGZ
	 r1aBdFAo5Nnsg3FGBo2UlM46d8nWiReU0LO6T/ZegfUgzPeYfP927B2PWl1ybeIaSr
	 o2PbuoFtbd3ew==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com,
	axboe@kernel.dk
Subject: [PATCH v4 18/18] nfs/localio: use dedicated workqueues for filesystem read and write
Date: Mon, 17 Jun 2024 21:09:17 -0400
Message-ID: <20240618010917.23385-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618010917.23385-1-snitzer@kernel.org>
References: <20240618010917.23385-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For localio access, don't call filesystem read() and write() routines
directly.

Some filesystem writeback routines can end up taking up a lot of stack
space (particularly xfs). Instead of risking running over due to the
extra overhead from the NFS stack, we should just call these routines
from a workqueue job.

Use of dedicated workqueues improves performance over using the
system_unbound_wq. Localio is motivated by the promise of improved
performance, it makes little sense to yield it back.

But further analysis of the latest stack depth requirements would be
useful. It'd be nice to root cause and fix the latest stack pigs,
because using workqueues at all causes a loss in performance:

Testing using fio with 24 read threads, libaio engine and directio.
First to baseline /dev/pmem0 device and then to NFS running client in
host and server in a container that exports the XFS filesystem on
/dev/pmem0:

Without this commit:
  read: IOPS=1037k, BW=63.3GiB/s (68.0GB/s)(1266GiB/20002msec)
  read: IOPS=795k, BW=48.5GiB/s (52.1GB/s)(971GiB/20002msec)

With this commit:
  read: IOPS=1073k, BW=65.5GiB/s (70.3GB/s)(1310GiB/20002msec)
  read: IOPS=701k, BW=42.8GiB/s (46.0GB/s)(856GiB/20001msec)

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c    |  57 +++++++++++++++++---------
 fs/nfs/internal.h |   1 +
 fs/nfs/localio.c  | 102 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 118 insertions(+), 42 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f9923cbf6058..aac8c5302503 100644
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
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	wq = nfslocaliod_workqueue;
+	if (wq != NULL) {
+		nfslocaliod_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
+#endif /* CONFIG_NFS_LOCALIO */
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
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
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
+#endif /* CONFIG_NFS_LOCALIO */
+	return 0;
 }
 
 unsigned int nfs_net_id;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d30a2e63063c..404524cd4d4a 100644
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
index d41130f5a84d..27fc941d9dfa 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -45,6 +45,12 @@ struct nfs_local_fsync_ctx {
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
@@ -417,21 +423,38 @@ nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
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
@@ -441,11 +464,18 @@ nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
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
 
@@ -555,14 +585,35 @@ nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
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
@@ -570,7 +621,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, WRITE);
 
 	switch (hdr->args.stable) {
 	default:
@@ -590,14 +640,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 
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


