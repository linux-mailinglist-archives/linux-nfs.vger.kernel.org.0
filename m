Return-Path: <linux-nfs+bounces-13455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42EB1BD0E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C5518A4528
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03C2BD5A8;
	Tue,  5 Aug 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Vcyfco"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487282951DD
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436080; cv=none; b=GvE2ErJcNJeF+sTRtzVmTlA04MxEmvblJ2dv7yoiybwBIk3dc9eZ+Vo4DonF7g8m0rOJ/bSZ4TAr+lp0eCmJk++/K/mbmq9//3iOnWgHAjo2KHJgYaads7Mmaebuqpe5JB4WhT/cgCk1n6HxihrIytNCtVJ6QNJphwW+eS6feXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436080; c=relaxed/simple;
	bh=lWxWAXxTPKSHt4gJxydLdsjoMoLiXg5VEDhWAefPDLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ2SBn4Fv5Mj6DituAlMfpqWqk1BBYdgHVpZiMMQIELtbb1i6ucjUa841f6fLi7XKAF1ek2uh8fH4Smfkkcg3v/5qJNldaCkvpWJpexuYYy6LnME2zlQPfqcM9Pf2lz6c7vUO2zZdmBmQO2BMW3Xzw6qI4RZ/5OYSqZ+S5sy9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Vcyfco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63DBC4CEF0;
	Tue,  5 Aug 2025 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436080;
	bh=lWxWAXxTPKSHt4gJxydLdsjoMoLiXg5VEDhWAefPDLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0VcyfcobF054UaZsqD4HtVhb82zdpmDTugfU7R1N150PnIVDFYXKLPbGmiybyVGC
	 LC7dIfjvdOpyf4iSrCfpKMETNc/F7auioWAXC+r76uHf9qAD97BcHEWrPdbbkHIVob
	 k8Tc+u81mGQZgZbg4+zB+57e/X4wfimpZrXI7PAE/6LZzPNisN8vMmqawTUIqOY59Y
	 0tfdXu/YUiR94+9UStiUTzOZIGWnKpJMtezp9CK0WrxF9fjwHucqcjB6gE1cgqI9qF
	 sTOF0qP0KgKBcRsqIIkqcL3mKTKxR4OF8GLPwXsoqWvzTQ+CIC4t31Bchp7rNa8BAL
	 71rsmo92bi4eA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 08/11] nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
Date: Tue,  5 Aug 2025 19:21:03 -0400
Message-ID: <20250805232106.8656-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
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
 fs/nfs/localio.c  | 167 ++++++++++++++++++++++++++++++----------------
 fs/nfs/pagelist.c |  15 +++--
 3 files changed, 127 insertions(+), 64 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 522011eea5f2f..f1015413b85cf 100644
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
index ac5e0dc405564..3e625947ad796 100644
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
@@ -319,46 +331,60 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
-static void
-nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+static int
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct page **pagevec = hdr->page_array.pagevec;
+	bool misaligned_DIO = false;
 	unsigned long v, total;
 	size_t len;
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
+		/* Verify the IO is DIO-aligned as required */
+		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
+						&nf_dio_offset_align,
+						&nf_dio_read_offset_align);
+		if (rw == ITER_DEST)
+			nf_dio_offset_align = nf_dio_read_offset_align;
+		if (!nf_dio_mem_align || !nf_dio_offset_align ||
+		    (hdr->args.pgbase && (hdr->args.pgbase & (nf_dio_mem_align - 1))) ||
+		    ((hdr->args.offset | hdr->args.count) & (nf_dio_offset_align - 1)))
+			misaligned_DIO = true;
+	}
+
 	v = 0;
 	total = hdr->args.count + hdr->args.pgbase;
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE);
 		bvec_set_page(&iocb->bvec[v], *(pagevec++), len, 0);
+		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
 		total -= len;
 		++v;
 	}
 	WARN_ON_ONCE(v != hdr->page_array.npages);
 
-	iov_iter_bvec(i, dir, iocb->bvec, v, hdr->args.count + hdr->args.pgbase);
+	iov_iter_bvec(i, rw, iocb->bvec, v, hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
-		/* Verify the IO is DIO-aligned as required */
-		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
-						&nf_dio_offset_align,
-						&nf_dio_read_offset_align);
-		if (dir == READ)
-			nf_dio_offset_align = nf_dio_read_offset_align;
-		/* direct I/O must be aligned to device logical sector size */
-		if (nf_dio_mem_align && nf_dio_offset_align &&
-		    (hdr->args.pgbase && (hdr->args.pgbase & (nf_dio_mem_align - 1)) == 0) &&
-		    (((hdr->args.offset | hdr->args.count) & (nf_dio_offset_align - 1)) == 0))
-			return 0;
-
+	if (misaligned_DIO) {
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
@@ -391,13 +417,18 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
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
 
@@ -458,18 +489,16 @@ static void nfs_local_call_read(struct work_struct *work)
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
@@ -479,25 +508,14 @@ static void nfs_local_call_read(struct work_struct *work)
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
 
@@ -649,20 +667,18 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -675,26 +691,15 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -715,32 +720,78 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
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


