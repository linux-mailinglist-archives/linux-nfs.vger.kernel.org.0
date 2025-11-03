Return-Path: <linux-nfs+bounces-15940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E2BC2D454
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB39A346829
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767BF3101C2;
	Mon,  3 Nov 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOwlF3hy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519093164A6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188841; cv=none; b=VAqsqDxSLx5b0LiTwCApOIOeGihn3+Xb2BSOftChKYgAPyjeljT0bBMTUnHxAjauQEgPHuqfCnA9On4Rzy+oeMU2ul8GpHp6GUgUaKpjwz+MgGvw8iqBOXpTQbvuqAtycS14EMzCkarDDrde0PC8nOP4pEsrlCn9qAUQCsUc9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188841; c=relaxed/simple;
	bh=fLL539ueOehu6c1CpERe98er8eAEXoZergVXXb280jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe3wcTM9Y1s3232SJNFTEEZgYq8MyS/ZISQZVBYn7A1Wn2D6ekfnT6kPSAvUr+qlzCogIB7n6f6enbr0sliQVO89JUu+SWvwj/YHNaw9pVJqdMCGbKf3D3aaF+lQwZyoSsHrrR8KFEQaTg1T7Ew5ywJU9U14Ld/fCji6bBe5DOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOwlF3hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1149FC116C6;
	Mon,  3 Nov 2025 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188839;
	bh=fLL539ueOehu6c1CpERe98er8eAEXoZergVXXb280jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOwlF3hyAHipToyIc4oqgy+ZgsJGyt8QbEXEmU+i3RoNfGFnBZ8nSTAumEAmGYN/8
	 GLalzq+eLATivymlcmNeLXJ4N2WD5XBpFQNRR2CqcAYuKyQX4vXsAQEq4/dpjB/v1M
	 BjyHgeUjb0RXk0VpcCJtBflhad2spz119odc7CnsCREp9wpLRMGpQPk8NxAOSpN7zZ
	 0q5zQdx32qlTDaF8mhMhLfXi48oTYZZoNdU9tWdGishvq4P1HGJJ+c0O7fWBf5YA0v
	 jBj6cWhgOHBLoGgXgYHooAihHzTN4CgLLyaDKaNjIMy3ejMUjdHZEQ5NB6dHW87gH9
	 HLUZSP+LxCMAA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v9 06/12] NFSD: Clean up struct nfsd_write_dio
Date: Mon,  3 Nov 2025 11:53:45 -0500
Message-ID: <20251103165351.10261-7-cel@kernel.org>
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

Prepare for moving more common arguments into the shared per-request
structure.

First step is to move the target nfsd_file into that structure, as
it needs to be available in several functions.

As a clean-up, adopt the conventional naming of a structure that
carries the same arguments for a number of functions.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 67 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 80bc105eb0b6..326c60eada65 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,7 +1254,9 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
-struct nfsd_write_dio {
+struct nfsd_write_dio_args {
+	struct nfsd_file		*nf;
+
 	ssize_t	start_len;	/* Length for misaligned first extent */
 	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
 	ssize_t	end_len;	/* Length for misaligned last extent */
@@ -1262,12 +1264,12 @@ struct nfsd_write_dio {
 
 static bool
 nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
-		       struct nfsd_file *nf, struct nfsd_write_dio *write_dio)
+			   struct nfsd_write_dio_args *args)
 {
-	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	u32 dio_blocksize = args->nf->nf_dio_offset_align;
 	loff_t start_end, orig_end, middle_end;
 
-	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
+	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
@@ -1276,16 +1278,18 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
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
 
-static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
-		unsigned int addr_mask, unsigned int len_mask)
+static bool
+nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
 {
+	unsigned int len_mask = nf->nf_dio_offset_align - 1;
+	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
 	const struct bio_vec *bvec = i->bvec;
 	size_t skip = i->iov_offset;
 	size_t size = i->count;
@@ -1314,37 +1318,35 @@ static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
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
-		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
-				nf->nf_dio_mem_align-1, nf->nf_dio_offset_align-1);
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
@@ -1370,11 +1372,11 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
 }
 
 static int
-nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
-		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
-		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
+		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
+		     struct nfsd_write_dio_args *args)
 {
-	struct file *file = nf->nf_file;
+	struct file *file = args->nf->nf_file;
 	bool iter_is_dio_aligned[3];
 	struct iov_iter iter_stack[3];
 	struct iov_iter *iter = iter_stack;
@@ -1384,7 +1386,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
 	ssize_t host_err;
 
 	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
-				rqstp->rq_bvec, nvecs, *cnt, write_dio, nf);
+					     rqstp->rq_bvec, nvecs, *cnt,
+					     args);
 	if (unlikely(!n_iters))
 		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
 
@@ -1421,21 +1424,23 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
-	struct nfsd_write_dio write_dio;
+	struct nfsd_write_dio_args args;
+
+	args.nf = nf;
 
 	/*
 	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
 	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
 	 * be ignored for any DIO issued here).
 	 */
-	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
 		kiocb->ki_flags |= IOCB_DONTCACHE;
 
-	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
-		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
-					    cnt, kiocb, &write_dio);
+	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, &args))
+		return nfsd_issue_write_dio(rqstp, fhp, stable_how, kiocb,
+					    nvecs, cnt, &args);
 
-	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
+	return nfsd_buffered_write(rqstp, args.nf->nf_file, nvecs, cnt, kiocb);
 }
 
 /**
-- 
2.51.0


