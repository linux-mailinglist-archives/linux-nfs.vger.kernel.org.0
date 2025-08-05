Return-Path: <linux-nfs+bounces-13454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96443B1BD0C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CA3627B73
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543C291C1B;
	Tue,  5 Aug 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhgRkioF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FD2BD5A8
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436078; cv=none; b=Ka6ewlXwQUEf9aQZ9zxIskNFu9yhhFxTQC7apMWI89LWTAZB0wF5bsxn2+4IcdG9jA5OS8PzSuqwYbSue53tSvhZqdzfItVCfVox0EUKSoDPhSSUz+VMjZLKPWvQ3+5GgsVik+HQmQ2AQhu1zBq3/MsFNuwKe198/JT8mW7yJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436078; c=relaxed/simple;
	bh=5MRhNrl6FYeC5z7Ujz6FVotH1tX3WvKuk0U81vaXeaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y311p6XAZ267GzKgKTafVc3ysCOP/11aj4vIxtj4Km/Nr0+oealUOJZ/RdCRU5v65uuEc3NLISlu/BcqZZg5ySU54+Y5GQkZjia9KBPvBVcMMEqL8bLcgLp662GhiTsV338Io6rOrnqn3CMzbK1JNPVgJN9JLkwwUyk23FtsxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhgRkioF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC17C4CEF0;
	Tue,  5 Aug 2025 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436078;
	bh=5MRhNrl6FYeC5z7Ujz6FVotH1tX3WvKuk0U81vaXeaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhgRkioFDe0FMZ/wLHpNDrkzB3AxNE080PzzV8c8gQ4eEwMjT7N3lRINLDddukvLp
	 NhMj8caDA854rZJyd7sr4L1wSDDbjPlj71FkeZz6Y2fHl+ywQJWEroeikkQKOGOztH
	 IBjRA8/voNBMHqiDt708DNKoWi5V2f7qv0ofiJ/WSoCg4Xq/CTBPeWsdsZES0iNbEZ
	 b02YwgdoFKVHLiLVXUbpcAsSSKKBseBC5FHyr28df8lHXTzviAiic81zlKrivi/4dE
	 1hjbxrZCKgBQ9SbLPq18bVS8REDMZKMYi6EEG6FNvk/UOYs9Lnmguq+6U8uTTqLQYc
	 fzGRuxwJAuzew==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 07/11] nfs/localio: refactor iocb initialization
Date: Tue,  5 Aug 2025 19:21:02 -0400
Message-ID: <20250805232106.8656-8-snitzer@kernel.org>
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

From: Mike Snitzer <snitzer@hammerspace.com>

No functional change, but slighty cleaner.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 56 +++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 932019c074a6e..ac5e0dc405564 100644
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
@@ -339,9 +323,21 @@ static void
 nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct page **pagevec = hdr->page_array.pagevec;
+	unsigned long v, total;
+	size_t len;
 
-	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
-		      hdr->args.count + hdr->args.pgbase);
+	v = 0;
+	total = hdr->args.count + hdr->args.pgbase;
+	while (total) {
+		len = min_t(size_t, total, PAGE_SIZE);
+		bvec_set_page(&iocb->bvec[v], *(pagevec++), len, 0);
+		total -= len;
+		++v;
+	}
+	WARN_ON_ONCE(v != hdr->page_array.npages);
+
+	iov_iter_bvec(i, dir, iocb->bvec, v, hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
 
@@ -468,6 +464,10 @@ static void nfs_local_call_read(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, READ);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
 	if (status != -EIOCBQUEUED) {
@@ -501,11 +501,6 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
-		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-	}
-
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -661,6 +656,10 @@ static void nfs_local_call_write(struct work_struct *work)
 	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
 
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
@@ -710,11 +709,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
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


