Return-Path: <linux-nfs+bounces-15699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBBC0F16E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD0E188E423
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FF3126C5;
	Mon, 27 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AREGXN6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3613126A3
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580001; cv=none; b=Vb3jrNLoecrpoL/hu0wjdbCAt27H/Nt5RzA7Ogy7fIUgq9xgtSq+5gEXo6H1zrHaJTKTuc7oZS+AS9EggJjZ8tElMTD9IL1P03D13imt+dfOaDSgv+YXcmSZC4kHculqa7FiAyPQP8O7LuJPyKrrjmPe1avI99GdXvLHXopbl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580001; c=relaxed/simple;
	bh=ienfd15EwyDtinHF97kVgGMvHTUBGO9ea0r7+rIrPgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFWrtCwCLjAH5gXCncxz1+ZjiF7Dg+MZBwcwRe0xSYsiWu4U4hY/UPmBiBFw04Bv5NVXaNargx9kwIS3GtJFOfSx6sfSlzKU7JDpXYrfk0Xpo0bDKcEwOzQ3lgMaJGLoNKzvwNOh+D4PC7Y+GnBXo1F+O+WzULzbLWw3NtFKTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AREGXN6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEDC4CEF1;
	Mon, 27 Oct 2025 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580000;
	bh=ienfd15EwyDtinHF97kVgGMvHTUBGO9ea0r7+rIrPgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AREGXN6j7B1itMDRRQE5ykuIL+kNz/oOeulioPgnZWF0XG5GBQ447H5OUtMlqAcEe
	 uhHy8fLHRyH3tXLTkI9GsLY+A4I0zYcO1tiZMjAmQz2J5QGX+/ma7HEiSQaIN4ZlAy
	 z3c7mytDtOuZlBSGkb+7fSpGQDxV+qQyKG+YvW3LcJz3l39nXyCy9CqZV1Eai1t8L/
	 3kjDC7ZLK4UGFPRc9pvvYgJlruFaCs956awwJAG//+3OfR/B3bt38wJaamM3ZFM9M4
	 JAK/JdKimlqXJOqg7bEEAH0Bfzs4kPDesHMCdqWP7CTEZZA/syXgvzUgUZ/EsAFaWy
	 zkONy4XhevOkQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v8 07/12] NFSD: Introduce struct nfsd_write_dio_seg
Date: Mon, 27 Oct 2025 11:46:25 -0400
Message-ID: <20251027154630.1774-8-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Passing iter arrays by reference is a little risky. Instead, pass a
struct with a fixed-size array so bounds checking can be done.

Name each item in the array a "segment", as the term "extent"
generally refers to a set of blocks on storage, not to a buffer.
Each segment is processed via a single vfs_iocb_iter_write() call,
and is either IOCB_DIRECT or buffered.

Introduce a segment constructor function so each segment is
initialized identically.

Consensus is that allowing the code to build segment arrays that
are smaller than 3 is better than the I/O loop unconditionally
visiting all 3 segments, skipping the zero-length ones.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 120 ++++++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 326c60eada65..5d6efcceb8c9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,12 +1254,16 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio_seg {
+	struct iov_iter			iter;
+	bool				use_dio;
+};
+
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
-
-	ssize_t	start_len;	/* Length for misaligned first extent */
-	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
-	ssize_t	end_len;	/* Length for misaligned last extent */
+	size_t				first, middle, last;
+	unsigned int			nsegs;
+	struct nfsd_write_dio_seg	segment[3];
 };
 
 static bool
@@ -1267,21 +1271,20 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 			   struct nfsd_write_dio_args *args)
 {
 	u32 dio_blocksize = args->nf->nf_dio_offset_align;
-	loff_t start_end, orig_end, middle_end;
+	loff_t first_end, orig_end, middle_end;
 
 	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
 
-	start_end = round_up(offset, dio_blocksize);
+	first_end = round_up(offset, dio_blocksize);
 	orig_end = offset + len;
 	middle_end = round_down(orig_end, dio_blocksize);
 
-	args->start_len = start_end - offset;
-	args->middle_len = middle_end - start_end;
-	args->end_len = orig_end - middle_end;
-
+	args->first = first_end - offset;
+	args->middle = middle_end - first_end;
+	args->last = orig_end - middle_end;
 	return true;
 }
 
@@ -1311,47 +1314,47 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
 	return true;
 }
 
-/*
- * Setup as many as 3 iov_iter based on extents described by @write_dio.
- * Returns the number of iov_iter that were setup.
- */
-static int
-nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
-			   struct bio_vec *rq_bvec, unsigned int nvecs,
-			   unsigned long cnt, struct nfsd_write_dio_args *args)
+static void
+nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
+			struct bio_vec *bvec, unsigned int nvecs,
+			unsigned long total, size_t start, size_t len)
 {
-	int n_iters = 0;
-	struct iov_iter *iters = *iterp;
+	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
+	if (start)
+		iov_iter_advance(&segment->iter, start);
+	iov_iter_truncate(&segment->iter, len);
+	segment->use_dio = false;
+}
 
-	/* Setup misaligned start? */
-	if (args->start_len) {
-		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-		iters[n_iters].count = args->start_len;
-		iter_is_dio_aligned[n_iters] = false;
-		++n_iters;
+static bool
+nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
+			   unsigned long total,
+			   struct nfsd_write_dio_args *args)
+{
+	args->nsegs = 0;
+
+	if (args->first) {
+		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
+					nvecs, total, 0, args->first);
+		++args->nsegs;
 	}
 
-	/* Setup DIO-aligned middle */
-	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-	if (args->start_len)
-		iov_iter_advance(&iters[n_iters], args->start_len);
-	iters[n_iters].count -= args->end_len;
-	iter_is_dio_aligned[n_iters] =
-		nfsd_iov_iter_aligned_bvec(args->nf, &iters[n_iters]);
-	if (unlikely(!iter_is_dio_aligned[n_iters]))
-		return 0; /* no DIO-aligned IO possible */
-	++n_iters;
+	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
+				total, args->first, args->middle);
+	if (!nfsd_iov_iter_aligned_bvec(args->nf,
+					&args->segment[args->nsegs].iter))
+		return false;	/* no DIO-aligned IO possible */
+	args->segment[args->nsegs].use_dio = true;
+	++args->nsegs;
 
-	/* Setup misaligned end? */
-	if (args->end_len) {
-		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-		iov_iter_advance(&iters[n_iters],
-				 args->start_len + args->middle_len);
-		iter_is_dio_aligned[n_iters] = false;
-		++n_iters;
+	if (args->last) {
+		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
+					nvecs, total, args->first +
+					args->middle, args->last);
+		++args->nsegs;
 	}
 
-	return n_iters;
+	return true;
 }
 
 static int
@@ -1377,22 +1380,12 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 		     struct nfsd_write_dio_args *args)
 {
 	struct file *file = args->nf->nf_file;
-	bool iter_is_dio_aligned[3];
-	struct iov_iter iter_stack[3];
-	struct iov_iter *iter = iter_stack;
-	unsigned int n_iters = 0;
-	unsigned long in_count = *cnt;
-	loff_t in_offset = kiocb->ki_pos;
 	ssize_t host_err;
+	unsigned int i;
 
-	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
-					     rqstp->rq_bvec, nvecs, *cnt,
-					     args);
-	if (unlikely(!n_iters))
+	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
 		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
 
-	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
-
 	/*
 	 * Any buffered IO issued here will be misaligned, use
 	 * sync IO to ensure it has completed before returning.
@@ -1402,18 +1395,21 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	*stable_how = NFS_FILE_SYNC;
 
 	*cnt = 0;
-	for (int i = 0; i < n_iters; i++) {
-		if (iter_is_dio_aligned[i])
+	for (i = 0; i < args->nsegs; i++) {
+		if (args->segment[i].use_dio) {
 			kiocb->ki_flags |= IOCB_DIRECT;
-		else
+			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
+						args->segment[i].iter.count);
+		} else
 			kiocb->ki_flags &= ~IOCB_DIRECT;
 
-		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+		host_err = vfs_iocb_iter_write(file, kiocb,
+					       &args->segment[i].iter);
 		if (host_err < 0)
 			return host_err;
 		*cnt += host_err;
-		if (host_err < iter[i].count) /* partial write? */
-			break;
+		if (host_err < args->segment[i].iter.count)
+			break;	/* partial write */
 	}
 
 	return 0;
-- 
2.51.0


