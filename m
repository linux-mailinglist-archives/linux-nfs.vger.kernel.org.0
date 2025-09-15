Return-Path: <linux-nfs+bounces-14444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5AB580FF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D5784E226E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07521883F;
	Mon, 15 Sep 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/5qroS3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8427442
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950882; cv=none; b=mRq+Xws/ndpW1ALstmZfWbXEndXX7lI4MYNGYNQtjb03zaVY9neHPgH2vYiTuNKkAA5Lk2nGZvQ8FoFIAjKrMezB86cXzP3Wo8yek8zRvyfhaFu/AERrMUNo+La3No3l1AbDy4IbJqIur7WxLtHWVBBuNBiHLc6r/+QAS6lE1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950882; c=relaxed/simple;
	bh=9jJHKMcXOEMERQ7NUWB8modf8JfKrXiKRWma2TiK9/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdz3R89ftuQvFVhg89gAyRhEPkk5nSnPDChSadrLaQBwoqz6SpBgdLZupplDS9Yt117tu4IQ0ei2rwcsYdSPXEU3fZ1TBoShvo717EGX9Hwy+9Az69LUtyxb1o8H7lbTXL878myQQ9Vy4+Vkq0qgp5wJTGfVbK3wj9rWgO6+Bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/5qroS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC7C4CEF1;
	Mon, 15 Sep 2025 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950881;
	bh=9jJHKMcXOEMERQ7NUWB8modf8JfKrXiKRWma2TiK9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/5qroS3FpVgDQPBghh9vR8XISm0L9sxcVPp24DLCz8jRaETFN6l0ulFXH7oFAjwp
	 6Iwvfhx7LnQuQt2spzu3bDw9Cldal2WBr2KYG4Dkqm2x/mCA5xY25fHUrqIda/J7uY
	 k9mDhgBxkieK6A0D4s+Ixct0j5simf/z8OEolUAB+EHI+/nVdcvbz9vMkTTQSkbYib
	 mllJ6brXDzvsaz1UU7b/0+lfYETbdYxnkcEBBstfntlXgmQ+6xcv/SylLSAui/FAEy
	 xvMqYnJrQWgjAfLzfeTlxopeagNZ1xA+zzUOiXYiL7b82bOI44JIovWlEAfh4n1+aG
	 /zZR47p3KC8uw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 3/7] nfs/localio: refactor iocb and iov_iter_bvec initialization
Date: Mon, 15 Sep 2025 11:41:11 -0400
Message-ID: <20250915154115.19579-4-snitzer@kernel.org>
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
index 380407c41822c..2ffe9fb5c5c1a 100644
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
+	while (total) {
+		len = min_t(size_t, total, PAGE_SIZE - base);
+		bvec_set_page(&iocb->bvec[v], *(pagevec++), len, base);
+		total -= len;
+		base = 0;
+		if (++v == hdr->page_array.npages)
+			break;
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
@@ -492,7 +490,11 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	save_cred = override_creds(filp->f_cred);
 
-	nfs_local_iter_init(&iter, iocb, READ);
+	nfs_local_iter_init(&iter, iocb, ITER_DEST);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 
@@ -527,11 +529,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -693,7 +690,11 @@ static void nfs_local_call_write(struct work_struct *work)
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
@@ -744,11 +745,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
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


