Return-Path: <linux-nfs+bounces-12942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079F4AFD07F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B37F188674F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA422E427E;
	Tue,  8 Jul 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LujPKqqa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E732E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991676; cv=none; b=M4oCKjdJ0DhrLxTlGMv8/Deyd5eSFIZL3Z43h4evblO/UNhNyLzTdo85AdKNhYatRPKHR3RRHjzOitaD4gBL8uiCjszF+/TNncTQulGgcATg3LBAgo0uLe5lhDoJFCXy0+V4QFm27eW5dfT2SFRQ8DSRsBw3q1/1HE1gsdoUO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991676; c=relaxed/simple;
	bh=3z2VQNkbQqKXBSpmNDogX8LoyLiWRBJFZqYrirnxDCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwfzumiqN3V0ezBWfDhdh27FdHlTapie4kKNIMz9De50oj6IlfNTwUUzPVmOXNhneU7S3e1CO0gNyworv3Z80OzpO+2oySvHYSBjMlawb1m08Y7jKMYrbXMeH6MiSxkfwUNjrUErtuShhOYPUKXtQwui2T/gcpBfcEm3nyXUMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LujPKqqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8136EC4CEED;
	Tue,  8 Jul 2025 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991675;
	bh=3z2VQNkbQqKXBSpmNDogX8LoyLiWRBJFZqYrirnxDCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LujPKqqaI+5u+R80+87OyzS0fycPrbVSCHq8zNN1CckIFLQAM5AYXVcOmtC0wtq1/
	 MBj/Bj14cfJ19y1EZZ30WSTD3Tr9OlKphiBaUMCQzmQ89TkEXV7HOcpmy0vF3ZPJUF
	 nMG7K9vmHv++9iXIXvhJQO8rJFUSYh4i0MGMehIcmTmwr8cR5YeJH3ngMz2IKfZP5A
	 STsyDY7fmWrmzPhjbULgZwmxCHftOviKO9KSIup++7rMhppKioWUbXalyKtS1Joypy
	 QHnG1dv66UtPWWEDEAbblyxAT/2J6fui6sqxQ2UEZv7lUIgstiDIC6ULlJYmkDAFh9
	 HvqMXEO5w4Hqw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 5/6] nfs/localio: refactor iocb initialization
Date: Tue,  8 Jul 2025 12:20:46 -0400
Message-ID: <20250708162047.65017-6-snitzer@kernel.org>
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

No functional change, but slighty cleaner.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 60 ++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index e551690e3f6b..d577fb27fd2f 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -287,23 +287,6 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
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
@@ -320,8 +303,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	iocb = kmalloc(sizeof(*iocb), flags);
 	if (iocb == NULL)
 		return NULL;
-	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
-			hdr->page_array.npages, flags);
+	// FIXME: would do well to allocate memory based on NUMA node.
+	iocb->bvec = kmalloc_array(hdr->page_array.npages,
+				   sizeof(struct bio_vec), flags);
 	if (iocb->bvec == NULL) {
 		kfree(iocb);
 		return NULL;
@@ -344,7 +328,10 @@ static void
 nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct page **pagevec = hdr->page_array.pagevec;
 	u32 nf_dio_mem_align, nf_dio_offset_align;
+	unsigned long v, total;
+	size_t len;
 
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
 		nf_dio_mem_align = iocb->nf_dio_mem_align;
@@ -354,18 +341,29 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 			nf_dio_offset_align = iocb->nf_dio_offset_align;
 	}
 
-	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
+	v = 0;
+	total = hdr->args.count + hdr->args.pgbase;
+	while (total) {
+		len = min_t(size_t, total, PAGE_SIZE);
+		bvec_set_page(&iocb->bvec[v], *(pagevec++),
+			      len, 0);
+		total -= len;
+		++v;
+	}
+	WARN_ON_ONCE(v != hdr->page_array.npages);
+
+	iov_iter_bvec(i, dir, iocb->bvec, v,
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
+
 	/* Verify the IO is DIO-aligned as needed */
 	if (iocb->kiocb.ki_flags & IOCB_DIRECT &&
 	    !iov_iter_is_aligned(i, nf_dio_mem_align - 1,
 				 nf_dio_offset_align - 1)) {
 		/* Fallback to buffered IO */
 		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
-		iocb->kiocb.ki_complete = NULL;
-		iocb->aio_complete_work = NULL;
+		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
 	}
 }
 
@@ -472,6 +470,10 @@ static void nfs_local_call_read(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, READ);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 	if (status != -EIOCBQUEUED) {
@@ -508,11 +510,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -669,6 +666,10 @@ static void nfs_local_call_write(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
 
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
@@ -721,11 +722,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
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


