Return-Path: <linux-nfs+bounces-13174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10AAB0CFE1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 04:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9F1C2016D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 02:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795E2737F6;
	Tue, 22 Jul 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siQhUFbF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444C272E6B
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152571; cv=none; b=tfeGBUqF3QLjQWz+BS4KZvMl9wss57u4FDdxL/1uYeViqhkGsr06vmsOJjYQcrKM7yEOznKxiOTOYh5MHN4J384mCn6hQ5h3C9+quz3pPXzntRlCK/2SN7MTFgkWpU+s47ZSKPtAXCbvedmMkqiQaYA7TEj5ULfyOAUASCKNUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152571; c=relaxed/simple;
	bh=tIdqmUN9Rm9L6IvdFcbQYC2GuIRpAW7caDRV6uhpJE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzxGQONL3TK3h4U4JU1cmr+EvrllCW2MZ/OStgt7jnrd92ZRYcHrP7/8hpAmp7kZNR29FmAAAdAJh8JQHbF4GtuuW+lGpwRJZDpuReN/y8jDwLd/3zxUMVoYivXX0TTdgvurn4jWe0TnUu6H3DOabKo4UizdjsTrBrvr0MUVUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siQhUFbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8A1C4CEED;
	Tue, 22 Jul 2025 02:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753152571;
	bh=tIdqmUN9Rm9L6IvdFcbQYC2GuIRpAW7caDRV6uhpJE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siQhUFbFh2J2y9/srCECI//ttO6sk8hzEnIp64Bnz+0MXQyaH00/76iIIjcM0Swpc
	 BbSrQnqkFQhrCHB3wo7aomlhY9UNVJPTAKEbAKChHzDxuJw1/SzUPLYwf7s3bOIx+T
	 KLb3g1cUPLgg7R66kTpHpfuELTU4JBvdZbp9b1MO8TGBgZvgacA/h4XM5h4eSYvOWF
	 GUbaL8EnCwAarBx5Fdqkkv38h/hP+q07bB/cF37CfTU2hvij9MchjwopKaDrYU6lNj
	 r+mSUfHZg8roKZADR40V+bE54t0UbQQtSawlYBBD5qvdf/FStSxpvWkbMi52KUSIK6
	 NlN1UTFFnVUXQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/7] nfs/localio: refactor iocb initialization
Date: Mon, 21 Jul 2025 22:49:21 -0400
Message-ID: <20250722024924.49877-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250722024924.49877-1-snitzer@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
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
 fs/nfs/localio.c | 56 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 0c48db38f74f..9ce242454c66 100644
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
@@ -339,8 +323,22 @@ static void
 nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct page **pagevec = hdr->page_array.pagevec;
+	unsigned long v, total;
+	size_t len;
 
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
@@ -469,6 +467,10 @@ static void nfs_local_call_read(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, READ);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 	if (status != -EIOCBQUEUED) {
@@ -502,11 +504,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -663,6 +660,10 @@ static void nfs_local_call_write(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
 
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
@@ -712,11 +713,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
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


