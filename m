Return-Path: <linux-nfs+bounces-13385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E297B18655
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5819545841
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34181DB377;
	Fri,  1 Aug 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQHNz8PF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7191A23A6
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068257; cv=none; b=hm8W4HTzJwD9jSso6S624oE/UWI2QqXPqEGdONPBQLIpCGxEBRJ3F08vOm0HEVbvC+XafP+5azTzxbViDf9aq/gGkX3a69wML9zXrY1kDtABwTh8iRLUwAHk+x/JBVZVvl4AoTsWximQc6whQ9up/x340Cpxu9vRXAGk4nTeYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068257; c=relaxed/simple;
	bh=BVOswX4l6PDF7iw1jf65E/Jg5+p/lBPOF0d/FuIMISk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm8DzkGU9YxppuBlLwUC2UM7ef8D8+PfIaK4kY0xug5ZF6SUaQipr3mqoWPCdR4JJ+dDwoK6ecbd/eKb4xLif4J7HElexvtLrmZ1y1jHdKMPp/70ixphJHjt9zOUbYBQt5L8xBcEdz9bnUP4CG4ki9U0UHS7vEJBL6qYvxAvDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQHNz8PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C2C4CEE7;
	Fri,  1 Aug 2025 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068257;
	bh=BVOswX4l6PDF7iw1jf65E/Jg5+p/lBPOF0d/FuIMISk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQHNz8PFh3l2pUb4JJAn393BvN1e9fpfIo7pmgK0bKka939yVvG5UKlrbZhVPj6M7
	 3VShAx8yGaN+UxyAJyQwO4Jxd8RfcwibO6Oi6kKd45hhFB+R5KhdnBj79zi+k3O9+u
	 EYuluTlOZrQxbr9psvJUfNtL6gukIaxHx3KCGpXPA/fvs98RPlSF+ObifnY36bDA4m
	 tkdK3PIMj0MEEUNRgNXYCQQgwp2L1Xqu+LtrRJ2Zcfz7BzH1Gha6jC3oG73HasVDOo
	 FXZPMW7UuTCfXRutvi23c/ighrSqxZEv4Avz4PF6uBktB+dtjvCXFkLMFbjjTxNHmZ
	 EXfXI1+95pRGA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 5/7] nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
Date: Fri,  1 Aug 2025 13:10:47 -0400
Message-ID: <20250801171049.94235-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250801171049.94235-1-snitzer@kernel.org>
References: <20250801171049.94235-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

But this fallback is sub-optimal due to resorting to using RPC and
will only serve as a last resort if NFS client's O_DIRECT support
fails to align misaligned IO (support is added in subsequent patches).

Add 'localio_O_DIRECT_align_misaligned_IO' modparm, which depends on
localio_O_DIRECT_semantics=Y, to control if LOCALIO will make best
effort to transform misaligned IO to DIO-aligned (e.g. expanding
misaligned READ to DIO-aligned).

If LOCALIO determines that an O_DIRECT READ is misaligned, and larger
than 32K, then it makes sense to immediately issue the READ remotely
via NFSD (which has the ability to expand a misaligned O_DIRECT READ
to be DIO-aligned) if/when NFSD is configured to use O_DIRECT for READ
IO with: echo 3 > /sys/kernel/debug/nfsd/io_cache_read

This commit's various refactoring makes it possible for LOCALIO to
fallback to NFS pagelist code in process context to allow for
immediate retry over RPC. This refactoring alone makes this commit
worthwile even though it is highly unlikely that LOCALIO will ever
fallback to NFSD for misaligned READs (again, only a bug in the
subsequent patches would be cause for fallback).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h |   9 ++-
 fs/nfs/localio.c  | 138 +++++++++++++++++++++++++++++++---------------
 fs/nfs/pagelist.c |  15 +++--
 3 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 217d4c69b6822..ea496a457d194 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -462,13 +462,14 @@ extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   struct nfs_file_localio *,
 					   const fmode_t);
 extern int nfs_local_doio(struct nfs_client *,
-			  struct nfsd_file *,
+			  struct nfsd_file **,
 			  struct nfs_pgio_header *,
 			  const struct rpc_call_ops *);
 extern int nfs_local_commit(struct nfsd_file *,
 			    struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
+extern bool nfs_localio_O_DIRECT_align_misaligned_IO(void);
 
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_probe(struct nfs_client *clp) {}
@@ -481,7 +482,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	return NULL;
 }
 static inline int nfs_local_doio(struct nfs_client *clp,
-				 struct nfsd_file *localio,
+				 struct nfsd_file **localio,
 				 struct nfs_pgio_header *hdr,
 				 const struct rpc_call_ops *call_ops)
 {
@@ -497,6 +498,10 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
 {
 	return false;
 }
+static inline bool nfs_localio_O_DIRECT_align_misaligned_IO(void)
+{
+	return false;
+}
 #endif /* CONFIG_NFS_LOCALIO */
 
 /* super.c */
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 9ce242454c665..8864abc0e1c12 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -36,6 +36,7 @@ struct nfs_local_kiocb {
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
 	void (*aio_complete_work)(struct work_struct *);
+	struct iov_iter		iter ____cacheline_aligned;
 	struct nfsd_file	*localio;
 };
 
@@ -54,6 +55,11 @@ module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
 		 "LOCALIO will use O_DIRECT semantics to filesystem.");
 
+static bool localio_O_DIRECT_align_misaligned_IO __read_mostly = true;
+module_param(localio_O_DIRECT_align_misaligned_IO, bool, 0644);
+MODULE_PARM_DESC(localio_O_DIRECT_align_misaligned_IO,
+		 "If LOCALIO_O_DIRECT_semantics=Y make best effort to transform misaligned IO to DIO-aligned.");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -65,6 +71,12 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+bool nfs_localio_O_DIRECT_align_misaligned_IO(void)
+{
+	return localio_O_DIRECT_align_misaligned_IO;
+}
+EXPORT_SYMBOL_GPL(nfs_localio_O_DIRECT_align_misaligned_IO);
+
 /*
  * UUID_IS_LOCAL XDR functions
  */
@@ -319,8 +331,8 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
-static void
-nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+static int
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct page **pagevec = hdr->page_array.pagevec;
@@ -338,7 +350,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 	}
 	WARN_ON_ONCE(v != hdr->page_array.npages);
 
-	iov_iter_bvec(i, dir, iocb->bvec, v,
+	iov_iter_bvec(i, rw, iocb->bvec, v,
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
@@ -349,7 +361,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
 						&nf_dio_offset_align,
 						&nf_dio_read_offset_align);
-		if (dir == READ)
+		if (rw == ITER_DEST)
 			nf_dio_offset_align = nf_dio_read_offset_align;
 		/* direct I/O must be aligned to device logical sector size */
 		if (nf_dio_mem_align && nf_dio_offset_align &&
@@ -358,10 +370,21 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 					nf_dio_offset_align - 1))
 			return 0;
 
+		/* Only send misaligned READ to NFSD if 32K or larger */
+		if (localio_O_DIRECT_align_misaligned_IO &&
+		    (rw == ITER_DEST) && (hdr->args.count >= (32 << 10))) {
+			/*
+			 * Fallback to sending this READ to NFSD since it
+			 * can expand misaligned READ IO to be DIO-aligned.
+			 */
+			return -ENOSYS;
+		}
 		/* Fallback to using buffered for this misaligned IO */
 		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
 	}
+
+	return 0;
 }
 
 static void
@@ -394,13 +417,18 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 	}
 }
 
-static void
-nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+static void nfs_local_iocb_release(struct nfs_local_kiocb *iocb)
 {
-	struct nfs_pgio_header *hdr = iocb->hdr;
-
 	nfs_local_file_put(iocb->localio);
 	nfs_local_iocb_free(iocb);
+}
+
+static void
+nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	nfs_local_iocb_release(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
 
@@ -461,18 +489,16 @@ static void nfs_local_call_read(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
-	struct iov_iter iter;
 	ssize_t status;
 
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, READ);
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
 		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
 	}
 
-	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iter);
 	if (status != -EIOCBQUEUED) {
 		nfs_local_read_done(iocb, status);
 		nfs_local_pgio_release(iocb);
@@ -482,25 +508,14 @@ static void nfs_local_call_read(struct work_struct *work)
 }
 
 static int
-nfs_do_local_read(struct nfs_pgio_header *hdr,
-		  struct nfsd_file *localio,
+nfs_local_do_read(struct nfs_local_kiocb *iocb,
 		  const struct rpc_call_ops *call_ops)
 {
-	struct nfs_local_kiocb *iocb;
-	struct file *file = nfs_to->nfsd_file_file(localio);
-
-	/* Don't support filesystems without read_iter */
-	if (!file->f_op->read_iter)
-		return -EAGAIN;
+	struct nfs_pgio_header *hdr = iocb->hdr;
 
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
-	iocb = nfs_local_iocb_alloc(hdr, file, GFP_KERNEL);
-	if (iocb == NULL)
-		return -ENOMEM;
-	iocb->localio = localio;
-
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
@@ -653,20 +668,18 @@ static void nfs_local_call_write(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
 	const struct cred *save_cred;
-	struct iov_iter iter;
 	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, WRITE);
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
 		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
 	}
 
 	file_start_write(filp);
-	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iter);
 	file_end_write(filp);
 	if (status != -EIOCBQUEUED) {
 		nfs_local_write_done(iocb, status);
@@ -679,26 +692,15 @@ static void nfs_local_call_write(struct work_struct *work)
 }
 
 static int
-nfs_do_local_write(struct nfs_pgio_header *hdr,
-		   struct nfsd_file *localio,
+nfs_local_do_write(struct nfs_local_kiocb *iocb,
 		   const struct rpc_call_ops *call_ops)
 {
-	struct nfs_local_kiocb *iocb;
-	struct file *file = nfs_to->nfsd_file_file(localio);
-
-	/* Don't support filesystems without write_iter */
-	if (!file->f_op->write_iter)
-		return -EAGAIN;
+	struct nfs_pgio_header *hdr = iocb->hdr;
 
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
-	iocb = nfs_local_iocb_alloc(hdr, file, GFP_NOIO);
-	if (iocb == NULL)
-		return -ENOMEM;
-	iocb->localio = localio;
-
 	switch (hdr->args.stable) {
 	default:
 		break;
@@ -719,32 +721,78 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	return 0;
 }
 
-int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
+static struct nfs_local_kiocb *
+nfs_local_iocb_init(struct nfs_pgio_header *hdr, struct nfsd_file **localio)
+{
+	struct file *file = nfs_to->nfsd_file_file(*localio);
+	struct nfs_local_kiocb *iocb;
+	gfp_t gfp_mask;
+	int rw, status;
+
+	if (hdr->rw_mode & FMODE_READ) {
+		if (!file->f_op->read_iter)
+			return ERR_PTR(-EOPNOTSUPP);
+		gfp_mask = GFP_KERNEL;
+		rw = ITER_DEST;
+	} else {
+		if (!file->f_op->write_iter)
+			return ERR_PTR(-EOPNOTSUPP);
+		gfp_mask = GFP_NOIO;
+		rw = ITER_SOURCE;
+	}
+
+	iocb = nfs_local_iocb_alloc(hdr, file, gfp_mask);
+	if (iocb == NULL)
+		return ERR_PTR(-ENOMEM);
+	iocb->hdr = hdr;
+	iocb->localio = *localio;
+
+	status = nfs_local_iter_init(&iocb->iter, iocb, rw);
+	if (status == -ENOSYS) {
+		/* close nfsd_file and clear localio,
+		 * this informs callers that IO should
+		 * be serviced remotely.
+		 */
+		nfs_local_iocb_release(iocb);
+		*localio = NULL;
+		return ERR_PTR(status);
+	}
+	WARN_ON_ONCE(status != 0);
+
+	return iocb;
+}
+
+int nfs_local_doio(struct nfs_client *clp, struct nfsd_file **localio,
 		   struct nfs_pgio_header *hdr,
 		   const struct rpc_call_ops *call_ops)
 {
+	struct nfs_local_kiocb *iocb;
 	int status = 0;
 
 	if (!hdr->args.count)
 		return 0;
 
+	iocb = nfs_local_iocb_init(hdr, localio);
+	if (IS_ERR(iocb))
+		return PTR_ERR(iocb);
+
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
-		status = nfs_do_local_read(hdr, localio, call_ops);
+		status = nfs_local_do_read(iocb, call_ops);
 		break;
 	case FMODE_WRITE:
-		status = nfs_do_local_write(hdr, localio, call_ops);
+		status = nfs_local_do_write(iocb, call_ops);
 		break;
 	default:
 		dprintk("%s: invalid mode: %d\n", __func__,
 			hdr->rw_mode);
-		status = -EINVAL;
+		status = -EOPNOTSUPP;
 	}
 
 	if (status != 0) {
 		if (status == -EAGAIN)
 			nfs_localio_disable_client(clp);
-		nfs_local_file_put(localio);
+		nfs_local_iocb_release(iocb);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 11968dcb72431..9ddff27e96e9f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -762,9 +762,17 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
 
-	if (localio)
-		return nfs_local_doio(NFS_SERVER(hdr->inode)->nfs_client,
-				      localio, hdr, call_ops);
+	if (localio) {
+		int status = nfs_local_doio(NFS_SERVER(hdr->inode)->nfs_client,
+					    &localio, hdr, call_ops);
+		/* nfs_local_doio() will clear localio and return -ENOSYS if
+		 * it is prudent to immediately service this IO remotely.
+		 */
+		if (status != -ENOSYS)
+			return status;
+		WARN_ON_ONCE(localio != NULL);
+		/* fallthrough */
+	}
 
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
@@ -959,7 +967,6 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
 		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
-
 		struct nfsd_file *localio =
 			nfs_local_open_fh(clp, hdr->cred, hdr->args.fh,
 					  &hdr->args.context->nfl,
-- 
2.44.0


