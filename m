Return-Path: <linux-nfs+bounces-13240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFDB111C8
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC1E1D00320
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8E2EE600;
	Thu, 24 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7x6Ty7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0232EE27C
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385479; cv=none; b=KNz4K4l/HuRLRllTjLX/MpeiJBRr7Nx1l7TXRPaTuH/Pkve0pJXKke8yKaGVm45SJJIvi3g7QlI3im9Y1FSj+YHeFBLPwsuglTKWRcI4UH6C+w5F0tUoioAEoehyuP6yW/tz+udoXFXZmpE1hp6wQpdWXAGZz7omxSou/a8azQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385479; c=relaxed/simple;
	bh=/HH7lsIVaUroyKpSARQmQA0NHiWT+1Mq1JnAEJmg7gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3Gwkta6sZyHRc3A7ZtDqEZOos3tKDTD3b27j1zQ3DURDQgDYtS3AmmVO0JvK3PtHNYU59G0IeK7oIFlTzRvqPy0KqMyOrWTBwv+8B7Aan6bJHMBlzV2in10VTG3q34IWhKoUSdhHqHPxfYvBp+kRyhsOHHic+Smyc6qravIDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7x6Ty7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF2DC4CEF1;
	Thu, 24 Jul 2025 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385479;
	bh=/HH7lsIVaUroyKpSARQmQA0NHiWT+1Mq1JnAEJmg7gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7x6Ty7dFyVwH0bqkSHdbe6HieReyPAf76D8i2vmjoFjATnPK/I0YGEEK4UVwucBB
	 JdjefKcF29a4TGB/zpd/Vt8LupCoSmN/Hb8uADJTacMUBJTZ6cNWNMMrSKVgkE2H0D
	 izcySsupG/LRaZ5U3vPS46HJtFqmumUgGIAXjzK3pFhY/5zPCE8SRwlvgfrzuCHtWN
	 RoMgTMlURcofrgYiw1RFNRB6ejbDlDsC3LOVO9nY9Fr1IBjuG5RtUwpbN8zRCBJfR3
	 ID0ouK9q6UC+7HHDzEBvRH/kmtIj9tULEPPJxIF3P5UM5HYGDrNs6csC98nuoqqBl3
	 H2HwMpP2DzNvA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 11/13] nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
Date: Thu, 24 Jul 2025 15:31:00 -0400
Message-ID: <20250724193102.65111-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LOCALIO is left enabled, it just isn't used for any misaligned
O_DIRECT READ larger than 32K.

If LOCALIO determines that an O_DIRECT READ is misaligned then it
makes sense to immediately issue the READ remotely via NFSD (which has
the ability to expand a misaligned O_DIRECT READ to be DIO-aligned)
if/when NFSD is configured to use O_DIRECT for READ IO with:
  echo 3 > /sys/kernel/debug/nfsd/io_cache_read

This change in behavior for LOCALIO's O_DIRECT support really should
be dependent on NFSD running with io_cache_read=3 but there isn't an
interface to check for that (currently).  This fallback is sub-optimal
due to resorting to using RPC and will only serve as a last resort
if/when NFS client's O_DIRECT support isn't able to align misaligned
IO (support will be added in subsequent patches).

Add 'localio_O_DIRECT_align_misaligned_IO' modparm, which depends on
localio_O_DIRECT_semantics=Y, to control if LOCALIO will make best
effort to transform misaligned IO to DIO-aligned (e.g. expanding
misaligned READ to DIO-aligned).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/internal.h                      |   9 +-
 fs/nfs/localio.c                       | 139 +++++++++++++++++--------
 fs/nfs/pagelist.c                      |  15 ++-
 4 files changed, 113 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4bea008dbebd..fbcf7c5ac118 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1911,6 +1911,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh, FMODE_READ);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
+		// FIXME: if fallback occurs is this stats start bogus?
 		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
 	}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..f54030684c97 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -463,13 +463,14 @@ extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
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
@@ -482,7 +483,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	return NULL;
 }
 static inline int nfs_local_doio(struct nfs_client *clp,
-				 struct nfsd_file *localio,
+				 struct nfsd_file **localio,
 				 struct nfs_pgio_header *hdr,
 				 const struct rpc_call_ops *call_ops)
 {
@@ -498,6 +499,10 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
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
index 9ce242454c66..f61cfe42d745 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -36,6 +36,7 @@ struct nfs_local_kiocb {
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
 	void (*aio_complete_work)(struct work_struct *);
+	struct iov_iter		iter ____cacheline_aligned;
 	struct nfsd_file	*localio;
 };
 
@@ -54,6 +55,12 @@ module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
 		 "LOCALIO will use O_DIRECT semantics to filesystem.");
 
+static bool localio_O_DIRECT_align_misaligned_IO __read_mostly = true;
+module_param(localio_O_DIRECT_align_misaligned_IO, bool, 0644);
+/* This feature also depends on: echo 2 > /sys/kernel/debug/nfsd/io_cache_read */
+MODULE_PARM_DESC(localio_O_DIRECT_align_misaligned_IO,
+		 "If LOCALIO_O_DIRECT_semantics=Y make best effort to transform misaligned IO to DIO-aligned.");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -65,6 +72,12 @@ bool nfs_server_is_local(const struct nfs_client *clp)
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
@@ -319,8 +332,8 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
-static void
-nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+static int
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct page **pagevec = hdr->page_array.pagevec;
@@ -338,7 +351,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 	}
 	WARN_ON_ONCE(v != hdr->page_array.npages);
 
-	iov_iter_bvec(i, dir, iocb->bvec, v,
+	iov_iter_bvec(i, rw, iocb->bvec, v,
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
@@ -349,7 +362,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
 						&nf_dio_offset_align,
 						&nf_dio_read_offset_align);
-		if (dir == READ)
+		if (rw == ITER_DEST)
 			nf_dio_offset_align = nf_dio_read_offset_align;
 		/* direct I/O must be aligned to device logical sector size */
 		if (nf_dio_mem_align && nf_dio_offset_align &&
@@ -358,10 +371,21 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
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
@@ -394,13 +418,18 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
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
 
@@ -461,18 +490,16 @@ static void nfs_local_call_read(struct work_struct *work)
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
@@ -482,25 +509,14 @@ static void nfs_local_call_read(struct work_struct *work)
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
 
@@ -653,20 +669,18 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -679,26 +693,15 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -719,32 +722,78 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
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
index 11968dcb7243..9ddff27e96e9 100644
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


