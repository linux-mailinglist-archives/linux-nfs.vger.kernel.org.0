Return-Path: <linux-nfs+bounces-15596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B931FC06C17
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09FA3B4704
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7C3191D6;
	Fri, 24 Oct 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGfr8nAd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F031B123
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316998; cv=none; b=ah7gHSZRr/FMfjAu1vg5OZmIbpXmBnD8G/meupAGJSFEz9Zt1BcbvV1Sxjqn6ExWlTo3h2tNBAJpj18xDJ4j0PFb89QbfJ4QIbpYKrLiZ4AgHYeS/tL3Qp+DSyfeZuWon+4voYaBCUI0phzSLltS8J4af7nihVuNLKiwT7bnBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316998; c=relaxed/simple;
	bh=ZJKCKvp1oV82e325hNgso20jNch0uR+K5C/Kq23SPZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsjYSUc2pbJA5g8fXlFZ8jY/Hp1HaxPUve4ppEG4YmovCGIETohANOkSdG+QBP4HCCv5ZQiK7e8ZSC6PflOMgjLPzia2PSV0lLzO3ssSb+69laFyLbdW4dKYd/5K+aLmpDX5KL57qhsVRFn1cdUUhqyB2O8h6yIDwIFx4+Y8zSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGfr8nAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C84C4CEF1;
	Fri, 24 Oct 2025 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316998;
	bh=ZJKCKvp1oV82e325hNgso20jNch0uR+K5C/Kq23SPZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGfr8nAdmwvn08Rqut+Lz3NhdsxKicpj2pat4GW9F0R8qqRl+22eg6f6oD+YDU3Ke
	 2/s9Qer70ykGWoe2plmuoEdRT7HZR1kGG/fharPkod00NhflZBNuuc+N03SHUhPOsV
	 Ccvn1NCCFHjqW7drENbUG4+uZTwq8SBxRDtMX7kuYsN6X9N1ewm1S0WxgrwUH53yE7
	 bWWXWnJc+bDKEO5wkE+aM3WbikY1XHzy4np1ZXxCCFMR23dzBPIPMawj8bnNDBqZWL
	 Ud36aOd19MtT/qYypApbol0eUCwvfWZxWdlTXG901/t5+3HFYWja0jvpEbwSNS+IFa
	 vYISWwpDb24kw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 12/14] NFSD: Introduce struct nfsd_write_dio_seg
Date: Fri, 24 Oct 2025 10:43:04 -0400
Message-ID: <20251024144306.35652-13-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
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

Each segment has its own length. The loop that iterates over the
segment array can simply skip over the segments of zero length.
A count of segments is not needed.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 121 ++++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 64 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 429f5fc61ead..b7f217aa4994 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,12 +1254,15 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio_seg {
+	struct iov_iter			iter;
+	size_t				len;
+	bool				use_dio;
+};
+
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
-
-	ssize_t	start_len;	/* Length for misaligned first extent */
-	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
-	ssize_t	end_len;	/* Length for misaligned last extent */
+	struct nfsd_write_dio_seg	segment[3];
 };
 
 static bool
@@ -1267,21 +1270,19 @@ nfsd_is_write_dio_possible(struct nfsd_write_dio_args *args, loff_t offset,
 			   unsigned long len)
 {
 	const u32 dio_blocksize = args->nf->nf_dio_offset_align;
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
-
-	args->start_len = start_end - offset;
-	args->middle_len = middle_end - start_end;
-	args->end_len = orig_end - middle_end;
-
+	args->segment[0].len = first_end - offset;	/* first segment */
+	args->segment[1].len = middle_end - first_end;	/* middle segment */
+	args->segment[2].len = orig_end - middle_end;	/* last segment */
 	return true;
 }
 
@@ -1308,47 +1309,42 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
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
+nfsd_setup_write_dio_seg(struct nfsd_write_dio_seg *segment,
+			 struct bio_vec *bvec, unsigned int nvecs,
+			 unsigned long total, size_t start)
 {
-	int n_iters = 0;
-	struct iov_iter *iters = *iterp;
+	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
+	if (start)
+		iov_iter_advance(&segment->iter, start);
+	iov_iter_truncate(&segment->iter, segment->len);
+	segment->use_dio = false;
+}
 
-	/* Setup misaligned start? */
-	if (args->start_len) {
-		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-		iters[n_iters].count = args->start_len;
-		iter_is_dio_aligned[n_iters] = false;
-		++n_iters;
-	}
+static bool
+nfsd_setup_write_dio_iters(struct nfsd_write_dio_args *args,
+			   struct bio_vec *bvec, unsigned int nvecs,
+			   unsigned long total)
+{
+	/* first segment */
+	if (args->segment[0].len)
+		nfsd_setup_write_dio_seg(&args->segment[0],
+					 bvec, nvecs, total, 0);
 
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
+	/* middle segment */
+	nfsd_setup_write_dio_seg(&args->segment[1], bvec, nvecs, total,
+				 args->segment[0].len);
+	if (!nfsd_iov_iter_aligned_bvec(args->nf, &args->segment[1].iter))
+		return false; /* no DIO-aligned IO possible */
+	args->segment[1].use_dio = true;
 
-	/* Setup misaligned end? */
-	if (args->end_len) {
-		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-		iov_iter_advance(&iters[n_iters],
-				 args->start_len + args->middle_len);
-		iter_is_dio_aligned[n_iters] = false;
-		++n_iters;
-	}
+	/* last segment */
+	if (args->segment[2].len)
+		nfsd_setup_write_dio_seg(&args->segment[2], bvec, nvecs,
+					 total, args->segment[0].len +
+					 args->segment[1].len);
 
-	return n_iters;
+	return true;
 }
 
 static int
@@ -1373,36 +1369,33 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int nvecs, unsigned long *cnt)
 {
 	struct file *file = args->nf->nf_file;
-	bool iter_is_dio_aligned[3];
-	struct iov_iter iter_stack[3];
-	struct iov_iter *iter = iter_stack;
-	unsigned int n_iters = 0;
-	unsigned long in_count = *cnt;
-	loff_t in_offset = kiocb->ki_pos;
+	struct nfsd_write_dio_seg *segment;
 	ssize_t host_err;
+	size_t i;
 
-	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
-					     rqstp->rq_bvec, nvecs, *cnt,
-					     args);
-	if (unlikely(!n_iters))
+	if (!nfsd_setup_write_dio_iters(args, rqstp->rq_bvec, nvecs, *cnt))
 		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
 				       cnt, kiocb);
 
-	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
-
 	*cnt = 0;
-	for (int i = 0; i < n_iters; i++) {
-		if (iter_is_dio_aligned[i])
+	segment = args->segment;
+	for (i = 0; i < ARRAY_SIZE(args->segment); i++) {
+		if (segment->len == 0)
+			continue;
+		if (segment->use_dio) {
 			kiocb->ki_flags |= IOCB_DIRECT;
-		else
+			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
+						segment->len);
+		} else
 			kiocb->ki_flags &= ~IOCB_DIRECT;
 
-		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
 		if (host_err < 0)
 			return host_err;
 		*cnt += host_err;
-		if (host_err < iter[i].count) /* partial write? */
+		if (host_err < segment->iter.count)
 			break;
+		++segment;
 	}
 
 	return 0;
-- 
2.51.0


