Return-Path: <linux-nfs+bounces-13692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F5B288C5
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A248FB65985
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949F23C503;
	Fri, 15 Aug 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqvhNccm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E312620F5
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300610; cv=none; b=DC5N38EcddePqbZcfWC7boD5ri4ZqNysTeeKD+Xhe1jObYyB+JbwWxeq7j7vmHZIb2ONSSbFU/RE1v4EdIWMlDoYFGZcH0tGbJZ91+WpPNJJE65n2iaMTo7CNKo2iGpL6Xt77DDpzz3reL0JTTjOIou3RgFnz8HMLi9FcuLSK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300610; c=relaxed/simple;
	bh=mMfCaGUP0NUBCZdAeLzCfC8ftRZAG4uZcGR/agiASz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwaEJFh5xjeXtS1yLRQGgVG0+1/p9fGxmK3p73k4pvCL6iD0MVsxYy0If591kRkFszr41Ulk8m1rS24BPfABo091Jsj5qPL6ZoJz0KRLJSNYuc+5xD/4DjZVHWyOMZA/+qrkPTTyTeaLodpj4DCqjKVZjLNmlG5rcaF3cCaszog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqvhNccm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1051BC4CEEB;
	Fri, 15 Aug 2025 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300610;
	bh=mMfCaGUP0NUBCZdAeLzCfC8ftRZAG4uZcGR/agiASz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqvhNccmFAIHll9QNFm/EPvRwOsUT+1VNCLDwxe+wZYIo9zS2y7AjNuji/JfC+0jB
	 LXo2E8OWADf+MrY8L0HQePg2dGRyjWQcrH8RTDcFRhZsbvJcLjPw9NPruw3qJi75RC
	 3W21pHumW3Sa/btyAVOosayTLUBzQaQtKOl9Rla5JeeUldLHZliJaggHm7fsOkptlq
	 khHsZFQCrvcyMN741tUYZJ+rS6v70/oTV6IC4xTNJe/Qxuys79Nc0tGB9u8/6AtUbw
	 bKsLWDM3JKUeSiPsPLULZVjPm3jgfjfLvmvR1xXb6VHNzQpwOj2E6oguF2DHTTztCm
	 D0j+BrSlY1twg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 4/9] nfs/localio: refactor iocb and iov_iter_bvec initialization
Date: Fri, 15 Aug 2025 19:29:58 -0400
Message-ID: <20250815233003.55071-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
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
 fs/nfs/localio.c | 69 ++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 9b12ddc19485f..a2df099b188c4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -282,23 +282,6 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
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
@@ -315,8 +298,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
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
@@ -360,14 +344,27 @@ static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
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
+	while (total) {
+		len = min_t(size_t, total, PAGE_SIZE - base);
+		bvec_set_page(&iocb->bvec[v], *(pagevec++), len, base);
+		total -= len;
+		++v;
+		base = 0;
+	}
+	WARN_ON_ONCE(v != hdr->page_array.npages);
+
+	iov_iter_bvec(i, rw, iocb->bvec, v, hdr->args.count);
 
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
@@ -375,7 +372,7 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
 						&nf_dio_offset_align,
 						&nf_dio_read_offset_align);
-		if (dir == READ)
+		if (rw == ITER_DEST)
 			nf_dio_offset_align = nf_dio_read_offset_align;
 
 		if (nf_dio_mem_align && nf_dio_offset_align &&
@@ -500,7 +497,11 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, READ);
+	nfs_local_iter_init(&iter, iocb, ITER_DEST);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 
@@ -535,11 +536,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -700,7 +696,11 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -751,11 +751,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
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


