Return-Path: <linux-nfs+bounces-14445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7AB58102
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4B3A2690
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4E21767C;
	Mon, 15 Sep 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oriqtJpH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0927442
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950883; cv=none; b=aqHjAhDECxDCsKKE+RbuF5/H1mLT+yHyCZJHrHhHUlr4XAEkVwnBGrkafr2uKCXuTokdYtuiwmexN7TZjiDOBRaFgnpDlEskqxEQ8pMtA0wTiQSoj+XEsEezl81li1r2y0UMM/RF4EM9c9oSsMHfsB8jICOHIqKXV2Q6KMJ0jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950883; c=relaxed/simple;
	bh=V597Hj4IAGuJdolzylQQPuRZnC/Dydt8+OjH0MXiMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S02RYfC2A0RdfDHyQsAGKV9OI6spzb30amAu7d11NMkQDxEs8IZLbGXT7qZvWqDUPkmK8xDy9fXrBgqzW5B03Nt1nolO6roDTpqTYP0h5AgqQvY3jhqNQmiuMeV5jRv7t2MxTfBo4ARKlpadBkYMKzwCNlZq40/1EuvI41tjAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oriqtJpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF29BC4CEF1;
	Mon, 15 Sep 2025 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950883;
	bh=V597Hj4IAGuJdolzylQQPuRZnC/Dydt8+OjH0MXiMn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oriqtJpHDB+OOo7tWXk7l+yrmVIrnI1rOss4wpgnMcsmeDtyqNbcsLAWImYXw8dht
	 h77v6pEO9qVjTw/NHNc0XCI1IVv7YuWKOlnDM/YdoIC/iX2SdU1cJkxmcWOrTduZhO
	 s+8UhaxDxyI/iBT5op2DDrAOVO5r43WcK/2eFFqigo/ij1kCtSDBjUU9SrzNb2l1bZ
	 Lh/YA0mOLvkh+QuOBZv27Ri3Aac23mhRmd7E5eCSqvDZpqVCuRQUDPg4SeEi3prj6J
	 cPk65BsJqtkYaTgvxU68tckeCB9eITQGMbVRthk67KMQsiCK4JE7m2DQh1abv93LgS
	 +dR3oefwoy1XQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 4/7] nfs/localio: refactor iocb initialization further
Date: Mon, 15 Sep 2025 11:41:12 -0400
Message-ID: <20250915154115.19579-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250915154115.19579-1-snitzer@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this commit's various refactoring is to have LOCALIO's per
IO initialization occur in process context so that we don't get into a
situation where IO fails to be issued from workqueue (e.g. due to lack
of memory, etc). Better to have LOCALIO's iocb initialization fail
early.

There isn't immediate need but this commit makes it possible for
LOCALIO to fallback to NFS pagelist code in process context to allow
for immediate retry over RPC.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 95 ++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2ffe9fb5c5c1a..82894962966e8 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -36,6 +36,7 @@ struct nfs_local_kiocb {
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
 	void (*aio_complete_work)(struct work_struct *);
+	struct iov_iter		iter ____cacheline_aligned;
 	struct nfsd_file	*localio;
 };
 
@@ -412,12 +413,18 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 }
 
 static void
-nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+nfs_local_iocb_release(struct nfs_local_kiocb *iocb)
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
 
@@ -485,18 +492,16 @@ static void nfs_local_call_read(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
-	struct iov_iter iter;
 	ssize_t status;
 
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, ITER_DEST);
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
 		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
 	}
 
-	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iter);
 
 	revert_creds(save_cred);
 
@@ -507,25 +512,14 @@ static void nfs_local_call_read(struct work_struct *work)
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
 
@@ -684,20 +678,18 @@ static void nfs_local_call_write(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
 	const struct cred *save_cred;
-	struct iov_iter iter;
 	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, ITER_SOURCE);
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
 		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
 	}
 
 	file_start_write(filp);
-	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iter);
 	file_end_write(filp);
 
 	revert_creds(save_cred);
@@ -711,26 +703,15 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -751,32 +732,68 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	return 0;
 }
 
+static struct nfs_local_kiocb *
+nfs_local_iocb_init(struct nfs_pgio_header *hdr, struct nfsd_file *localio)
+{
+	struct file *file = nfs_to->nfsd_file_file(localio);
+	struct nfs_local_kiocb *iocb;
+	gfp_t gfp_mask;
+	int rw;
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
+	iocb->localio = localio;
+
+	nfs_local_iter_init(&iocb->iter, iocb, rw);
+
+	return iocb;
+}
+
 int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
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
-- 
2.44.0


