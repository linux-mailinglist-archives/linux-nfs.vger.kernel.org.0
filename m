Return-Path: <linux-nfs+bounces-15595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AABC06C05
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144524FBB4D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25ED31B823;
	Fri, 24 Oct 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0zGh0+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBE31E0E0
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316997; cv=none; b=ekPM4l2qsMrTAFMaL2tYWizfCkCMA5zUvxEkFjHP+g48XH1McCZtwCmJWgMu4h2gDZcuXhUI5LcQo1aMSlYoPqpfJXzWqUhwfFGjADRsZQr3Q/dnoHrcqz4BVybckmUuQEkNG9nj1fxIQYQWDaNciBmcvy3q1BDUcPF6RQq9khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316997; c=relaxed/simple;
	bh=Kighdai8fST3RkbLM2PD5ALwUUUBCB5uf31R20luyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAfpksPyU35xt3qqI+CO7/XsruOwrVcbj5fDLrst4rmdNHYwtpnlaJULJuxwJN6PZTe8CpuI6uJ1bI8p4x4R0K5TRCKYWj1+7x2FwRlRH6u5CHO9AYM49I59ET6ePAaz+wbhzMthSly0KH8J+AnV6jn9JdSU/j1Itaxd3ROxpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0zGh0+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62EC4CEF5;
	Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316997;
	bh=Kighdai8fST3RkbLM2PD5ALwUUUBCB5uf31R20luyxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0zGh0+vBhho0gXZgiTbc/ac7m0Ag7CmR1/uHBKSvY7YiY09/9VGDM5vGBo4F7PAJ
	 P5e4P9vwH6gfF/xjKeNIbRaTu46R2di89atifkt3unIDNCJkySJ8M7PVSRQKyNvYR4
	 W6PI5bBEE2wuVFTHnnIc3w8x5k5u4RtrqPVreuWVmTGTub+7bgDG+YdyxTQbXpxsln
	 fM+E7ajBIEXQBbwGu3A5N+jCNgzOzmvArpPNLwJYLENiJZH5pRG73w3jexw3eY3+Ig
	 5DS/HI5oGtdJRhb9o2CoFFOGiPnd4gfFYB8zzDEVajwx3ABp6Girr6c8ybklv14SUW
	 /nSXUGYKm0U5w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 11/14] NFSD: Clean up struct nfsd_write_dio
Date: Fri, 24 Oct 2025 10:43:03 -0400
Message-ID: <20251024144306.35652-12-cel@kernel.org>
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

Prepare for moving more common arguments into the shared per-request
structure.

First step is to move the target nfsd_file into that structure, as
it needs to be available in several functions.

As a clean-up, adopt the common naming of a structure that carries
the arguments for a number of functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 61 ++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e7c3458bd178..429f5fc61ead 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,21 +1254,22 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
-struct nfsd_write_dio {
+struct nfsd_write_dio_args {
+	struct nfsd_file		*nf;
+
 	ssize_t	start_len;	/* Length for misaligned first extent */
 	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
 	ssize_t	end_len;	/* Length for misaligned last extent */
 };
 
 static bool
-nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
-			   struct nfsd_file *nf,
-			   struct nfsd_write_dio *write_dio)
+nfsd_is_write_dio_possible(struct nfsd_write_dio_args *args, loff_t offset,
+			   unsigned long len)
 {
-	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	const u32 dio_blocksize = args->nf->nf_dio_offset_align;
 	loff_t start_end, orig_end, middle_end;
 
-	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
+	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
@@ -1277,9 +1278,9 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 	orig_end = offset + len;
 	middle_end = round_down(orig_end, dio_blocksize);
 
-	write_dio->start_len = start_end - offset;
-	write_dio->middle_len = middle_end - start_end;
-	write_dio->end_len = orig_end - middle_end;
+	args->start_len = start_end - offset;
+	args->middle_len = middle_end - start_end;
+	args->end_len = orig_end - middle_end;
 
 	return true;
 }
@@ -1314,36 +1315,35 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
 static int
 nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
 			   struct bio_vec *rq_bvec, unsigned int nvecs,
-			   unsigned long cnt, struct nfsd_write_dio *write_dio,
-			   struct nfsd_file *nf)
+			   unsigned long cnt, struct nfsd_write_dio_args *args)
 {
 	int n_iters = 0;
 	struct iov_iter *iters = *iterp;
 
 	/* Setup misaligned start? */
-	if (write_dio->start_len) {
+	if (args->start_len) {
 		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-		iters[n_iters].count = write_dio->start_len;
+		iters[n_iters].count = args->start_len;
 		iter_is_dio_aligned[n_iters] = false;
 		++n_iters;
 	}
 
 	/* Setup DIO-aligned middle */
 	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
-	if (write_dio->start_len)
-		iov_iter_advance(&iters[n_iters], write_dio->start_len);
-	iters[n_iters].count -= write_dio->end_len;
+	if (args->start_len)
+		iov_iter_advance(&iters[n_iters], args->start_len);
+	iters[n_iters].count -= args->end_len;
 	iter_is_dio_aligned[n_iters] =
-		nfsd_iov_iter_aligned_bvec(nf, &iters[n_iters]);
+		nfsd_iov_iter_aligned_bvec(args->nf, &iters[n_iters]);
 	if (unlikely(!iter_is_dio_aligned[n_iters]))
 		return 0; /* no DIO-aligned IO possible */
 	++n_iters;
 
 	/* Setup misaligned end? */
-	if (write_dio->end_len) {
+	if (args->end_len) {
 		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
 		iov_iter_advance(&iters[n_iters],
-				 write_dio->start_len + write_dio->middle_len);
+				 args->start_len + args->middle_len);
 		iter_is_dio_aligned[n_iters] = false;
 		++n_iters;
 	}
@@ -1369,11 +1369,10 @@ nfsd_iocb_write(struct file *file, struct bio_vec *bvec, unsigned int nvecs,
 
 static int
 nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		     struct nfsd_file *nf, unsigned int nvecs,
-		     unsigned long *cnt, struct kiocb *kiocb,
-		     struct nfsd_write_dio *write_dio)
+		     struct nfsd_write_dio_args *args, struct kiocb *kiocb,
+		     unsigned int nvecs, unsigned long *cnt)
 {
-	struct file *file = nf->nf_file;
+	struct file *file = args->nf->nf_file;
 	bool iter_is_dio_aligned[3];
 	struct iov_iter iter_stack[3];
 	struct iov_iter *iter = iter_stack;
@@ -1384,7 +1383,7 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
 					     rqstp->rq_bvec, nvecs, *cnt,
-					     write_dio, nf);
+					     args);
 	if (unlikely(!n_iters))
 		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
 				       cnt, kiocb);
@@ -1414,14 +1413,15 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct nfsd_file *nf, unsigned int nvecs,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
-	struct nfsd_write_dio write_dio;
+	struct file *file = nf->nf_file;
+	struct nfsd_write_dio_args args;
 
 	/*
 	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
 	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
 	 * be ignored for any DIO issued here).
 	 */
-	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+	if (file->f_op->fop_flags & FOP_DONTCACHE)
 		kiocb->ki_flags |= IOCB_DONTCACHE;
 
 	/*
@@ -1435,11 +1435,12 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 */
 	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
 
-	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
-		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
-					    &write_dio);
+	args.nf = nf;
+	if (nfsd_is_write_dio_possible(&args, kiocb->ki_pos, *cnt))
+		return nfsd_issue_write_dio(rqstp, fhp, &args, kiocb,
+					    nvecs, cnt);
 
-	return nfsd_iocb_write(nf->nf_file, rqstp->rq_bvec, nvecs, cnt, kiocb);
+	return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs, cnt, kiocb);
 }
 
 /**
-- 
2.51.0


