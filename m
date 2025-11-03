Return-Path: <linux-nfs+bounces-15941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBCC2D4F3
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB5B3B176F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E1315794;
	Mon,  3 Nov 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0dpZnzv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D73164A6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188842; cv=none; b=SJv35+uUGDz8dBAevev34IKR8yx85cdBIFtZCxyZMARvI/e3cH7FPASnoXqcR4piDn2V+onZOKMmDbDcIeVTu2EkU1CnH6/rFUjBtscJ/6tvYa570ZrY7eBZS3GhTXDkHyGUVlJ0iVr66PWC1XsbMmVZaSKGrit+UTJZKuPuabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188842; c=relaxed/simple;
	bh=ienfd15EwyDtinHF97kVgGMvHTUBGO9ea0r7+rIrPgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9uqfE4mkyGTV6mMaCoqQVoMrIj1ux8fi6L/FGXXNI+KsjEq+X1J2OqyxU0ifBQGtOXG6/dfxq2pTCbiaDEkwXBM82pOOHLaQwNzmBj/YULj/nzlOU7qZefCE7lmHZ7Ng7BOB5Tsw0swT89ur3Sk0h7F3E5NtAlIIxqpyzvHo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0dpZnzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C0BC4CEE7;
	Mon,  3 Nov 2025 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188841;
	bh=ienfd15EwyDtinHF97kVgGMvHTUBGO9ea0r7+rIrPgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0dpZnzvrVEGK+gJ124SW/vYmGFqqUlo3pfGK0zVPstdenWgBMtkbr2x3NCFz71Ns
	 D3s1cdY4zq+wwW/61A4BmB+hkManw7gTAgvieQSqqPUasLi17k83JZMgRizqgkdGuu
	 5zx2TEizJU9ncE9BZMLTZrI/4fK+uQ7C/DILhMDnisVGL+QEBt1Ahymeqoz92eIVoO
	 c0y49To92mTqGp4pQqncSL5QVEhBTAgZcadnUgwGwd8Fp2VtNxJcnErNhXGwJgeDxH
	 UeN4pB5tkeolVpoLAdkI3udxMS1aC3fisRQwlHX7pk7eEd0elXzQhFMCrkJM8442vU
	 Eb/IStE0SovgA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v9 07/12] NFSD: Introduce struct nfsd_write_dio_seg
Date: Mon,  3 Nov 2025 11:53:46 -0500
Message-ID: <20251103165351.10261-8-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
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


