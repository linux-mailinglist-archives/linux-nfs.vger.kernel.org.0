Return-Path: <linux-nfs+bounces-15943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D5C2D4F9
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD83B1F0C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01C31A7EF;
	Mon,  3 Nov 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9PygPO2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFF3195EC
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188843; cv=none; b=JQCODtibDrecvrWebG7/8x+gyvLqPxM3yIn5UN2VK2skRJXM77BIIpE43KPYCV+FM//7ups93uAb1yXTTovTBrvDjGaB3mbQYt3j4rP7cUrMx8i6G0vm2Y9Xxp5HxT63hmHFlNVgxG2LVhlnovE1Jqm51j1/tQpe78dKo7OHNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188843; c=relaxed/simple;
	bh=YflSxizKoq6AGx4/IcuuqM0kgQ7R4up4DMTMFC2/UdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPFE5MM4N08qtYRHV2oNd6xn9uS9pdgnBWE/m94XxOzeDJlBSrOpItNgorrWNj3wSBjVauIctyMa7X1cYHGzCY2jCbAg0H6MPwn/GxJ41Wy/FOrM/SDIzCQO9QWBFKpDusp6wRb4WzVIVTp7ZaOYPBcAcWNYeOfVlWTfqP+fLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9PygPO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CA8C116C6;
	Mon,  3 Nov 2025 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188842;
	bh=YflSxizKoq6AGx4/IcuuqM0kgQ7R4up4DMTMFC2/UdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9PygPO2JqPP1B+o/Cbk2EufCRypmqdknztv/HBkpt5zJ2bj+5ECWv9K3gdisXuzY
	 XROrBO3NYECZQp5q7kfyp6lSS8RCcfbk8Gw7Sn6evkItVVcjwPfp9mc0SHU1oHMNHD
	 wRFCdQzFF2usUmqnn1dw6UCaGQI0GYaCtpnkbJ7Ubh1Ry9BBudN3HdLjYFd6K38ZWz
	 Hi8ohcBlX65skvHQ7WJ0yvLpesSo+yelmNX2l365l6jSeyReIfHhXYTHdPy+HbgTgb
	 wdYHMg/glYs4mcORjtILNuP5S6qDgkZLZTKhhWpQSr/ckYYaydKPJQ9+TyG+3cM1s4
	 86TmvubSAI6ew==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 09/12] NFSD: Combine direct I/O feasibility check with iterator setup
Date: Mon,  3 Nov 2025 11:53:48 -0500
Message-ID: <20251103165351.10261-10-cel@kernel.org>
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
 fs/nfsd/vfs.c | 93 +++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 37353fb48d58..1b1173de4f78 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1261,33 +1261,10 @@ struct nfsd_write_dio_seg {
 
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
-	size_t				first, middle, last;
 	unsigned int			nsegs;
 	struct nfsd_write_dio_seg	segment[3];
 };
 
-static bool
-nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
-			   struct nfsd_write_dio_args *args)
-{
-	u32 dio_blocksize = args->nf->nf_dio_offset_align;
-	loff_t first_end, orig_end, middle_end;
-
-	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
-		return false;
-	if (unlikely(len < dio_blocksize))
-		return false;
-
-	first_end = round_up(offset, dio_blocksize);
-	orig_end = offset + len;
-	middle_end = round_down(orig_end, dio_blocksize);
-
-	args->first = first_end - offset;
-	args->middle = middle_end - first_end;
-	args->last = orig_end - middle_end;
-	return true;
-}
-
 /*
  * Check if the bvec iterator is aligned for direct I/O.
  *
@@ -1316,35 +1293,66 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 	segment->use_dio = false;
 }
 
-static bool
-nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
-			   unsigned long total,
-			   struct nfsd_write_dio_args *args)
+static void
+nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
+			  loff_t offset, unsigned long total,
+			  struct nfsd_write_dio_args *args)
 {
+	u32 offset_align = args->nf->nf_dio_offset_align;
+	u32 mem_align = args->nf->nf_dio_mem_align;
+	loff_t prefix_end, orig_end, middle_end;
+	size_t prefix, middle, suffix;
+
 	args->nsegs = 0;
 
-	if (args->first) {
+	/*
+	 * Check if direct I/O is feasible for this write request.
+	 * If alignments are not available, the write is too small,
+	 * or no alignment can be found, fall back to buffered I/O.
+	 */
+	if (unlikely(!mem_align || !offset_align) ||
+	    unlikely(total < max(offset_align, mem_align)))
+		goto no_dio;
+
+	/* Calculate aligned segments */
+	prefix_end = round_up(offset, offset_align);
+	orig_end = offset + total;
+	middle_end = round_down(orig_end, offset_align);
+
+	prefix = prefix_end - offset;
+	middle = middle_end - prefix_end;
+	suffix = orig_end - middle_end;
+
+	if (!middle)
+		goto no_dio;
+
+	if (prefix) {
 		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
-					nvecs, total, 0, args->first);
+					nvecs, total, 0, prefix);
 		++args->nsegs;
 	}
 
 	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
-				total, args->first, args->middle);
+				total, prefix, middle);
 	if (!nfsd_iov_iter_aligned_bvec(args->nf,
 					&args->segment[args->nsegs].iter))
-		return false;	/* no DIO-aligned IO possible */
+		goto no_dio;
 	args->segment[args->nsegs].use_dio = true;
 	++args->nsegs;
 
-	if (args->last) {
+	if (suffix) {
 		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
-					nvecs, total, args->first +
-					args->middle, args->last);
+					nvecs, total, prefix + middle, suffix);
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
@@ -1365,7 +1373,7 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
 }
 
 static int
-nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
+nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
 		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
 		     struct nfsd_write_dio_args *args)
 {
@@ -1373,9 +1381,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	ssize_t host_err;
 	unsigned int i;
 
-	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
-		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
-
 	/*
 	 * Any buffered IO issued here will be misaligned, use
 	 * sync IO to ensure it has completed before returning.
@@ -1384,6 +1389,9 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	kiocb->ki_flags |= (IOCB_DSYNC|IOCB_SYNC);
 	*stable_how = NFS_FILE_SYNC;
 
+	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
+				  *cnt, args);
+
 	*cnt = 0;
 	for (i = 0; i < args->nsegs; i++) {
 		if (args->segment[i].use_dio) {
@@ -1422,11 +1430,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


