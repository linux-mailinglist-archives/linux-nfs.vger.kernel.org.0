Return-Path: <linux-nfs+bounces-12943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34049AFD07E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461383B508D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F892E49A8;
	Tue,  8 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dARMYnF+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD52E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991677; cv=none; b=Ya0VD6/L7zewN2E6+b5OfOn7PmdTLUer1C6TK7uEO3XTrgTCqBxQyK4Mt39U/hlr3YoAWPMaDfRWgzSBzhe8fmYuynrKy8GM/u78E5fQ4AFeckq7wx70sH0bE4e+uF7C9/aPqjsJKSYsNdF24Wr70QndA7/qY8zzp27dK7mlEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991677; c=relaxed/simple;
	bh=/yjc8CVpLI8c/DoGRYm1lf8BgUta9S8EsET5A6BlpIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB9uIoZQ+8B4Phw7CIgnCdKaJiCjKz0wB5UWGPOimkFAmePJikZC7rlqxi46Cqtk9rPQTBBW9H/uIay4KGQlrAtUFh4pj6h0Y1lNE+2sk8XW87LagxSku9cVSNjg5WDZGDFxkwo+HmJphTedcmzI9bybRO4ozrFO31roSJP5MCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dARMYnF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF809C4CEED;
	Tue,  8 Jul 2025 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991677;
	bh=/yjc8CVpLI8c/DoGRYm1lf8BgUta9S8EsET5A6BlpIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dARMYnF+dVrF0kGvbV357JJhB9f1p48qCySVMcQLEY4wy1nARSHLjJbTTc/V8+D6M
	 QK+seVaDiD6nJhRnxybQgoiuUd3or9Tllwi7GmBz+HtAXeQc2KB7F045HSbrxzCr6h
	 t8OvE1b7V12jqv3huAAXCV0j9V299OJ+fvsOi+d5C9RJIZSsgLaIW7/FNRu4dsUoZ5
	 EQFk8KaByxQHB8NRDAHXFMj4Z5E4OmVHo8Ddo9V6vDNF/E7uL7CvcBjJsKxZaYI2NO
	 VSZRF/g1i9Efw8eMDu4rIk+67Fpm00Bmu/dfzgkJkEM0K9ZzL1XslZCv9Y/TOUjdRw
	 h43ow/NL5JPLA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 6/6] nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
Date: Tue,  8 Jul 2025 12:20:47 -0400
Message-ID: <20250708162047.65017-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708162047.65017-1-snitzer@kernel.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

LOCALIO is left enabled, it just isn't used for any misaligned
O_DIRECT READ.

If LOCALIO determines that an O_DIRECT READ is misaligned then it
makes sense to immediately issue the READ remotely via NFSD (which has
the ability to expand a misaligned O_DIRECT READ to be DIO-aligned)
if/when NFSD is configured to use O_DIRECT for READ IO with:
  echo 2 > /sys/kernel/debug/nfsd/io_cache_read

This change in behavior for LOCALIO's O_DIRECT support really should
be dependent on NFSD running with io_cache_read=2 but there isn't an
interface to check for that (currently).

Add 'localio_O_DIRECT_align_misaligned_READ' modparm, which depends on
localio_O_DIRECT_semantics=Y, to control if LOCALIO will expand
misaligned READ to DIO-aligned (boolean control is Y by default).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/internal.h                      |   4 +-
 fs/nfs/localio.c                       | 152 +++++++++++++++----------
 fs/nfs/pagelist.c                      |  15 ++-
 4 files changed, 107 insertions(+), 65 deletions(-)

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
index 3a2ff094216c..5c39e143efc0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -463,7 +463,7 @@ extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   struct nfs_file_localio *,
 					   const fmode_t);
 extern int nfs_local_doio(struct nfs_client *,
-			  struct nfsd_file *,
+			  struct nfsd_file **,
 			  struct nfs_pgio_header *,
 			  const struct rpc_call_ops *);
 extern int nfs_local_commit(struct nfsd_file *,
@@ -482,7 +482,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	return NULL;
 }
 static inline int nfs_local_doio(struct nfs_client *clp,
-				 struct nfsd_file *localio,
+				 struct nfsd_file **localio,
 				 struct nfs_pgio_header *hdr,
 				 const struct rpc_call_ops *call_ops)
 {
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d577fb27fd2f..3eab88715d5b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -36,11 +36,8 @@ struct nfs_local_kiocb {
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
 	void (*aio_complete_work)(struct work_struct *);
+	struct iov_iter		iter ____cacheline_aligned;
 	struct nfsd_file	*localio;
-	/* local copy of nfsd_file's dio alignment attrs */
-	u32			nf_dio_mem_align;
-	u32			nf_dio_offset_align;
-	u32			nf_dio_read_offset_align;
 };
 
 struct nfs_local_fsync_ctx {
@@ -63,6 +60,12 @@ module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
 		 "LOCALIO will use O_DIRECT semantics to filesystem.");
 
+static bool localio_O_DIRECT_align_misaligned_READ __read_mostly = true;
+module_param(localio_O_DIRECT_align_misaligned_READ, bool, 0644);
+/* This feature also depends on: echo 2 > /sys/kernel/debug/nfsd/io_cache_read */
+MODULE_PARM_DESC(localio_O_DIRECT_align_misaligned_READ,
+		 "If LOCALIO_O_DIRECT_semantics=Y it will expand misaligned READ to DIO-aligned.");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -324,21 +327,23 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
-static void
-nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+static int
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct page **pagevec = hdr->page_array.pagevec;
-	u32 nf_dio_mem_align, nf_dio_offset_align;
+	u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
 	unsigned long v, total;
 	size_t len;
 
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		nf_dio_mem_align = iocb->nf_dio_mem_align;
-		if (dir == READ)
-			nf_dio_offset_align = iocb->nf_dio_read_offset_align;
+		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
+						&nf_dio_offset_align,
+						&nf_dio_read_offset_align);
+		if (rw == ITER_DEST)
+			nf_dio_offset_align = nf_dio_read_offset_align;
 		else
-			nf_dio_offset_align = iocb->nf_dio_offset_align;
+			nf_dio_offset_align = nf_dio_offset_align;
 	}
 
 	v = 0;
@@ -352,7 +357,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 	}
 	WARN_ON_ONCE(v != hdr->page_array.npages);
 
-	iov_iter_bvec(i, dir, iocb->bvec, v,
+	iov_iter_bvec(i, rw, iocb->bvec, v,
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
@@ -361,10 +366,20 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT &&
 	    !iov_iter_is_aligned(i, nf_dio_mem_align - 1,
 				 nf_dio_offset_align - 1)) {
-		/* Fallback to buffered IO */
+		if (localio_O_DIRECT_align_misaligned_READ &&
+		    rw == ITER_DEST) {
+			/*
+			 * Fallback to sending this READ to NFSD since it
+			 * can expand misaligned READ IO to be DIO-aligned.
+			 */
+			return -ENOSYS;
+		}
+		/* Fallback to using buffered IO for this WRITE */
 		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
 	}
+
+	return 0;
 }
 
 static void
@@ -397,13 +412,18 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
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
 
@@ -464,18 +484,16 @@ static void nfs_local_call_read(struct work_struct *work)
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
@@ -485,28 +503,14 @@ static void nfs_local_call_read(struct work_struct *work)
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
-	nfs_to->nfsd_file_dio_alignment(localio, &iocb->nf_dio_mem_align,
-					&iocb->nf_dio_offset_align,
-					&iocb->nf_dio_read_offset_align);
-
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
@@ -659,20 +663,18 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -685,29 +687,15 @@ static void nfs_local_call_write(struct work_struct *work)
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
-	nfs_to->nfsd_file_dio_alignment(localio, &iocb->nf_dio_mem_align,
-					&iocb->nf_dio_offset_align,
-					&iocb->nf_dio_read_offset_align);
-
 	switch (hdr->args.stable) {
 	default:
 		break;
@@ -728,21 +716,67 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
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
+			return ERR_PTR(-EINVAL);
+		gfp_mask = GFP_KERNEL;
+		rw = ITER_DEST;
+	} else {
+		if (!file->f_op->write_iter)
+			return ERR_PTR(-EINVAL);
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
@@ -753,7 +787,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
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


