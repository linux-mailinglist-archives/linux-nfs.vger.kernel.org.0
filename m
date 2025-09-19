Return-Path: <linux-nfs+bounces-14600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB321B8A013
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D07418954DD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D2314B74;
	Fri, 19 Sep 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkmg2K+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F8314A7F
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292597; cv=none; b=cD5N6qW928fZhs/TlJkglp+CPS3RIYmFqqOb6aHS8XWWL2p3gHdncNZ736DsjFhqgaPnljOUwyAgLruNyYMmKPbGRfjgh6syp9RjxMF78zJ41/TiK6CzfEwvWcY62CwmO2nIejsFyxLbQqkzqCt4dHsVRHR18cXbqaqABkmAoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292597; c=relaxed/simple;
	bh=vZpkier/TqXBx/7sG/aWbCy9fk8IdaRo21IvjUW+6uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mduScnWeYPs3H2QZ1CI/qF0WXa3OeeasQ64JNcskJ97grAPul5HVN5P54MRgZUyisGQdOyiWqxqNUIJVrX1F/k+F1rtdDvCdygbNCEqrK0LntiT/lp2InbWewJUVc+b+GMJuLfZKBluREJWL69T5pR572eAHTjqnQC8QrzA7S5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkmg2K+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C98FC4CEF1;
	Fri, 19 Sep 2025 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292596;
	bh=vZpkier/TqXBx/7sG/aWbCy9fk8IdaRo21IvjUW+6uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gkmg2K+ajb1Ih3oR1ODYCLrl1OTu1j+hGu6qj6cEG0lPVzwoGBe9F/a6niIIDty92
	 d38yn+xscX2M79ImMlJHvhWMyPf1voD5crokrQgW5s2XW3QFOsefzRuVPZQ0WL8lKS
	 lWxG9LPYLnApNTu262FG/WtXvlpEKn8RB8eC00R/2o3S1NRpC9tNmrCSy85IveO0Fb
	 YLxjCHdZ2qgUmf3cGEzGlt/8CscTx9dmldLL1laQDr62xMuB7h2TtrI5rLoW2NOgyK
	 IxUcK3MhD9iVmR8Usgv8JnJ3KgBAjEtcdA1R01fu3aGiJi5R+7pT2wEPyUDH6ToveJ
	 kQcDGg+0m1XqA==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v11 3/7] nfs/localio: refactor iocb and iov_iter_bvec initialization
Date: Fri, 19 Sep 2025 10:36:27 -0400
Message-ID: <20250919143631.44851-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250919143631.44851-1-snitzer@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs_local_iter_init() is updated to follow the same pattern to
initializing LOCALIO's iov_iter_bvec as was established by
nfsd_iter_read().

Other LOCALIO iocb initialization refactoring in this commit offers
incremental cleanup that will be taken further by the next commit.

No functional change.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 70 +++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b165922e5cb65..3b8fa75ce7cdb 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -277,23 +277,6 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
 
-static struct bio_vec *
-nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
-		unsigned int npages, gfp_t flags)
-{
-	struct bio_vec *bvec, *p;
-
-	bvec = kmalloc_array(npages, sizeof(*bvec), flags);
-	if (bvec != NULL) {
-		for (p = bvec; npages > 0; p++, pagevec++, npages--) {
-			p->bv_page = *pagevec;
-			p->bv_len = PAGE_SIZE;
-			p->bv_offset = 0;
-		}
-	}
-	return bvec;
-}
-
 static void
 nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 {
@@ -310,8 +293,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	iocb = kmalloc(sizeof(*iocb), flags);
 	if (iocb == NULL)
 		return NULL;
-	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
-			hdr->page_array.npages, flags);
+
+	iocb->bvec = kmalloc_array(hdr->page_array.npages,
+				   sizeof(struct bio_vec), flags);
 	if (iocb->bvec == NULL) {
 		kfree(iocb);
 		return NULL;
@@ -354,14 +338,28 @@ static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
 }
 
 static void
-nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct page **pagevec = hdr->page_array.pagevec;
+	unsigned long v, total;
+	unsigned int base;
+	size_t len;
 
-	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
-		      hdr->args.count + hdr->args.pgbase);
-	if (hdr->args.pgbase != 0)
-		iov_iter_advance(i, hdr->args.pgbase);
+	v = 0;
+	total = hdr->args.count;
+	base = hdr->args.pgbase;
+	while (total && v < hdr->page_array.npages) {
+		len = min_t(size_t, total, PAGE_SIZE - base);
+		bvec_set_page(&iocb->bvec[v], *pagevec, len, base);
+		total -= len;
+		++pagevec;
+		++v;
+		base = 0;
+	}
+	len = hdr->args.count - total;
+
+	iov_iter_bvec(i, rw, iocb->bvec, v, len);
 
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
@@ -369,7 +367,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
 						&nf_dio_offset_align,
 						&nf_dio_read_offset_align);
-		if (dir == READ)
+		if (rw == ITER_DEST)
 			nf_dio_offset_align = nf_dio_read_offset_align;
 
 		if (nf_dio_mem_align && nf_dio_offset_align &&
@@ -490,7 +488,11 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, READ);
+	nfs_local_iter_init(&iter, iocb, ITER_DEST);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 
@@ -525,11 +527,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -689,7 +686,11 @@ static void nfs_local_call_write(struct work_struct *work)
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, WRITE);
+	nfs_local_iter_init(&iter, iocb, ITER_SOURCE);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
 
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
@@ -740,11 +741,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
-		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_write);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
-- 
2.44.0


