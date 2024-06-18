Return-Path: <linux-nfs+bounces-4026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CD90DD3A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C241F222B0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58DC1741CE;
	Tue, 18 Jun 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FezWyrX3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E831741CB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742013; cv=none; b=ahRlG//dzKlTTf8SzNK/+QiNsw0ZLJ1ZQelH0U+6YKbA25WSNHead6klQLqsODZRu5nWJrrJtcuUJ+FCtXccQbuQow9oo3/pUKdlaKPVA5ci5NsNeixYhjuoCMUeOQzxh7CZ4mwYfE+LrIzILQUSGAiJ4N4sj+UIJtrfI+ENiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742013; c=relaxed/simple;
	bh=klBiXk0vfM57wyjj1/1z9BOCxY7HyGEIWVyeSA68v6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBSOKwX2wQFzmnbFhEFfxe84OyYwp2mcb59w9CYYJUQjnsXWAewE+e4mwWDtZpMH0biCrN4a2btR4tRngfeiei1ubSNbjO1J/k4mKTJhLL5qCD8KnHxk/oKZAzOgNyuETPyQHTIvuSH+EBfZ1gYxCZldYU0ViO5gxqEtymPLZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FezWyrX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E998C4AF1C;
	Tue, 18 Jun 2024 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718742013;
	bh=klBiXk0vfM57wyjj1/1z9BOCxY7HyGEIWVyeSA68v6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FezWyrX37UCqbKGMH7ifOiwcQ6LC0lRMs2fPJ85OcKpn4LM3HK2657QcSNzFmPP91
	 g/48kNZRiw80t3CgZcIj/Q5gxZb2V1KKEvtUh6og7peiIZNl3BnMjqcaS/aMkVu18I
	 cPownHEcZNnwjYZuPIJvTYaEc/g0idRUC2BgME9tNH+nL1Q4Eb7RutuV6XOW0EytB0
	 vOTD/dZv1dYEtyqiYUD6OoSb96LlAAosiYhi1Uqv721TmyoG2HxfkxsRkaw6gvpzPc
	 NmiornxWvnzhiXa2K0TQvbu9IGRG+d2A0MAwOf145A5DNn+JWWGk6O8ffoFHUus8Jl
	 wi/57eZKtPluQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 18/19] nfs/localio: use dedicated workqueues for filesystem read and write
Date: Tue, 18 Jun 2024 16:19:48 -0400
Message-ID: <20240618201949.81977-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
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
useful. It'd be nice to root cause and fix the latest stack hogs,
because using workqueues at all can cause a loss in performance due to
context switches.

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


