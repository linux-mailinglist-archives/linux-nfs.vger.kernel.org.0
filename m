Return-Path: <linux-nfs+bounces-15702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C70C0F0E7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CEBC34D787
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD331A802;
	Mon, 27 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka2kr+FS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAF31280D
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580004; cv=none; b=L6doqVkaH5+V8aL8DUmNkiaA6cchAzF2DBVznCHMOFEyrysPa0RCdfCQmUZn5bJqrehY8TdOBaXMI7bK5tTV4LV+Q+YxDCLs6C7PwajNUCjtmXd2ZlLHxdaOc7BKPXslgT/9HZWnuRSdQdxuPAkFZBNqU2sTT4SawUkYkhKJWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580004; c=relaxed/simple;
	bh=4kQqJKgk/uY5t8ci7KqPvDRnsmMcGk4zYvqFkpwubnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csKaZScDyQgJnsQ/3xyQ3adJCoyLhZQTR3kDcUOc2TLl1eRMyyJK6IkmuTw819JMxbzRei8B0q9kRgNhB1cllenI4H3/BtPInJhCssq7NHHlcm6RdDcDERFYDxE3s9hvjy5hPwec4FzWNgUwfZuL9dAYRmzC1jQVSSDfGPTwvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka2kr+FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F6C113D0;
	Mon, 27 Oct 2025 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580003;
	bh=4kQqJKgk/uY5t8ci7KqPvDRnsmMcGk4zYvqFkpwubnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ka2kr+FSBmdYGp5QSIDvuoF3TDQAE4WtciO0VuRSgg+EWloH2LQN03opasXc0kFvH
	 Nl6fCI1w1mAMsKKkvF6hVDbSMSzuxhMfjR+4+53c8ZUO7RNKEVNw4GYiBBcm6zNXVV
	 PzxTjri+pbe5SY7Ha0MdiwlFDpIsRe/7IezzTCgyPvh8FHbEqX2f24LSpglaOCVCD/
	 H420TmyhgC59P4KfsQpLmPhmubjptgSZ5pja3j4C+a5873DtNTVtPMVEW/kEw+ZInM
	 cSjUgeZISUVZ/pim8FuuygZslCoU5MQbC5EcYlSxr9qrIuHNR4r6HcCvXvaQ/5WCb3
	 YrdK4DPKkF5gA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 10/12] NFSD: Combine direct I/O feasibility check with iterator setup
Date: Mon, 27 Oct 2025 11:46:28 -0400
Message-ID: <20251027154630.1774-11-cel@kernel.org>
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

When direct I/O is not feasible (due to missing alignment info,
too-small writes, or no alignment possible), pack the entire
write payload into a single non-DIO segment and follow the usual
direct write I/O path.

This simplifies nfsd_direct_write() by eliminating the fallback path
and the separate nfsd_buffered_write() call - all writes now go
through nfsd_issue_write_dio() which handles both DIO and buffered
segments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 69 +++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a872be300c9f..be0688f2ab3d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1304,30 +1304,6 @@ nfsd_find_dio_aligned_offset(struct nfsd_file *nf, loff_t file_offset,
 	return SIZE_MAX;  /* No alignment found */
 }
 
-/*
- * Check if the underlying file system implements direct I/O.
- */
-static bool
-nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
-			   struct nfsd_write_dio_args *args)
-{
-	u32 offset_align = args->nf->nf_dio_offset_align;
-	u32 mem_align = args->nf->nf_dio_mem_align;
-
-	if (unlikely(!mem_align || !offset_align))
-		return false;
-
-	/*
-	 * Need enough data to potentially find an aligned segment.
-	 * In the worst case, we might need up to
-	 * lcm(offset_align, mem_align) bytes for the prefix.
-	 */
-	if (unlikely(len < max(offset_align, mem_align)))
-		return false;
-
-	return true;
-}
-
 static void
 nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 			struct bio_vec *bvec, unsigned int nvecs,
@@ -1340,22 +1316,31 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 	segment->use_dio = false;
 }
 
-static bool
-nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
-			   loff_t offset, unsigned long total,
-			   struct nfsd_write_dio_args *args)
+static void
+nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
+			  loff_t offset, unsigned long total,
+			  struct nfsd_write_dio_args *args)
 {
 	u32 offset_align = args->nf->nf_dio_offset_align;
+	u32 mem_align = args->nf->nf_dio_mem_align;
 	unsigned long mem_offset = bvec->bv_offset;
 	loff_t prefix_end, orig_end, middle_end;
 	size_t prefix, middle, suffix;
 
 	args->nsegs = 0;
 
+	/*
+	 * Check if direct I/O is feasible for this write request.
+	 * If alignments are not available, the write is too small,
+	 * or no alignment can be found, fall back to buffered I/O.
+	 */
+	if (unlikely(!mem_align || !offset_align) ||
+	    unlikely(total < max(offset_align, mem_align)))
+		goto no_dio;
 	prefix = nfsd_find_dio_aligned_offset(args->nf, offset, mem_offset,
 					     total);
 	if (prefix == SIZE_MAX)
-		return false;	/* No alignment possible */
+		goto no_dio;
 
 	prefix_end = offset + prefix;
 	orig_end = offset + total;
@@ -1371,7 +1356,7 @@ nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
 	}
 
 	if (!middle)
-		return false;	/* No aligned region for DIO */
+		goto no_dio;
 
 	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
 				total, prefix, middle);
@@ -1384,7 +1369,13 @@ nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
 		++args->nsegs;
 	}
 
-	return true;
+	return;
+
+no_dio:
+	/* No alignment possible - pack into single non-DIO segment */
+	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
+				0, total);
+	args->nsegs = 1;
 }
 
 static int
@@ -1405,7 +1396,7 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
 }
 
 static int
-nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
+nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
 		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
 		     struct nfsd_write_dio_args *args)
 {
@@ -1413,10 +1404,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	ssize_t host_err;
 	unsigned int i;
 
-	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
-					*cnt, args))
-		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
-
 	/*
 	 * Any buffered IO issued here will be misaligned, use
 	 * sync IO to ensure it has completed before returning.
@@ -1425,6 +1412,9 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	kiocb->ki_flags |= (IOCB_DSYNC|IOCB_SYNC);
 	*stable_how = NFS_FILE_SYNC;
 
+	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
+				  *cnt, args);
+
 	*cnt = 0;
 	for (i = 0; i < args->nsegs; i++) {
 		if (args->segment[i].use_dio) {
@@ -1463,11 +1453,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
 		kiocb->ki_flags |= IOCB_DONTCACHE;
 
-	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, &args))
-		return nfsd_issue_write_dio(rqstp, fhp, stable_how, kiocb,
-					    nvecs, cnt, &args);
-
-	return nfsd_buffered_write(rqstp, args.nf->nf_file, nvecs, cnt, kiocb);
+	return nfsd_issue_dio_write(rqstp, fhp, stable_how, kiocb, nvecs,
+				    cnt, &args);
 }
 
 /**
-- 
2.51.0


