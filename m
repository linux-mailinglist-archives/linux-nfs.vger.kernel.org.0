Return-Path: <linux-nfs+bounces-13904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F2B372B6
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C3D7A7A62
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7936CC83;
	Tue, 26 Aug 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgS+zBbi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDF1FECAB
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234649; cv=none; b=g/XTwbIWQ3JqiYzJykJ5RvWCDuYiC7vgSxmn6wKI1f7lIpcFMfKnVuM4ewNnGearrXe171ju8GdzGCrDDzD/AyTtpY5NRZ0Xq22D2pGZe+KIbqF5RZt34GbWp53hsJNaqQLGavrumRoltj+1fNBrCmwVrbsuWMvfwbIUuIJE+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234649; c=relaxed/simple;
	bh=9Dt5MHcnXZ5q8xvk2y+nB1brfLjSfEqFAymQxKP37Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTyB6frc3VcqysjiBCvkNEOAW2c44PNawHGoUzL/pz1Avbf99kkRpV0US+j16KkKf5FgIjQwAfUYak8boxF0o3vgtQCPJ3JubObEinT3ai4R8Vec5q7rpEo/A9ZGqmkDlYPkgWi48aUUBJgFhv7Hu5FfT7cdwnzpEU4Ql+Fs2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgS+zBbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E459DC113D0;
	Tue, 26 Aug 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234649;
	bh=9Dt5MHcnXZ5q8xvk2y+nB1brfLjSfEqFAymQxKP37Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgS+zBbi10lj6E0wP/0bGQw2yTbJWAPUirMzikrB/ntbCWxfcCO5Fcri3+LYxRnOO
	 rmyjHH4Owl7KzGzCpx/+uWoBRNu5AVdzZyg4MsOCOACoqozPauEUwMEnLZ1ywlE1Qw
	 SIn+w1EEQXk95oQFMNV7eaCv+i3Bj3Q0pBwT5I1m2KTfupBUUQQXWcXeCpr9J3Ibnn
	 bwwohi0Hn7KShhitpmwqfEJHf9w+k6tMvvCjpCCuoewwzeLmleXLwc0kLu/Mega5Wc
	 zx3adp96r7bIXJV1XPM46tixgKGvW3TZiKswTf9A1HrLrwTh0GU4WgoqC1kSUgzqJd
	 h0LImm92WQU8A==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 6/7] NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
Date: Tue, 26 Aug 2025 14:57:17 -0400
Message-ID: <20250826185718.5593-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250826185718.5593-1-snitzer@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
middle and end as needed. The large middle extent is DIO-aligned and
the start and/or end are misaligned. Buffered IO is used for the
misaligned extents and O_DIRECT is used for the middle DIO-aligned
extent.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 173 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 64732dc8985d6..967ca67f197fc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1355,6 +1355,174 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio {
+	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
+	loff_t end_offset;	/* Offset for start of DIO-aligned end */
+	ssize_t	start_len;	/* Length for misaligned first extent */
+	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
+	ssize_t	end_len;	/* Length for misaligned last extent */
+};
+
+static bool
+nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		       struct nfsd_file *nf, loff_t offset,
+		       unsigned long len, struct nfsd_write_dio *write_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	loff_t orig_end, middle_end, start_end, start_offset = offset;
+	ssize_t start_len = len;
+
+	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
+		      "%s: underlying filesystem has not provided DIO alignment info\n",
+		      __func__))
+		return false;
+	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
+		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
+		      __func__, dio_blocksize, PAGE_SIZE))
+		return false;
+	if (unlikely(len < dio_blocksize))
+		return false;
+
+	memset(write_dio, 0, sizeof(*write_dio));
+
+	if (((offset | len) & (dio_blocksize-1)) == 0) {
+		/* already DIO-aligned, no misaligned head or tail */
+		write_dio->middle_offset = offset;
+		write_dio->middle_len = len;
+		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
+		start_offset = 0;
+		start_len = 0;
+		return true;
+	}
+
+	start_end = round_up(offset, dio_blocksize);
+	start_len = start_end - offset;
+	orig_end = offset + len;
+	middle_end = round_down(orig_end, dio_blocksize);
+
+	write_dio->start_len = start_len;
+	write_dio->middle_offset = start_end;
+	write_dio->middle_len = middle_end - start_end;
+	write_dio->end_offset = middle_end;
+	write_dio->end_len = orig_end - middle_end;
+
+	return true;
+}
+
+/*
+ * Setup as many as 3 iov_iter based on extents described by @write_dio.
+ * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
+ * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
+ * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
+ * @nvecs: number of segments in @rq_bvec
+ * @cnt: size of the request in bytes
+ * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
+ *
+ * Returns the number of iov_iter that were setup.
+ */
+static int
+nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
+			   struct bio_vec *rq_bvec, unsigned int nvecs,
+			   unsigned long cnt, struct nfsd_write_dio *write_dio)
+{
+	int n_iters = 0;
+	struct iov_iter *iters = *iterp;
+
+	/* Setup misaligned start? */
+	if (write_dio->start_len) {
+		iter_is_dio_aligned[n_iters] = false;
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iters[n_iters].count = write_dio->start_len;
+		++n_iters;
+	}
+
+	/* Setup DIO-aligned middle */
+	iter_is_dio_aligned[n_iters] = true;
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (write_dio->start_len)
+		iov_iter_advance(&iters[n_iters], write_dio->start_len);
+	iters[n_iters].count -= write_dio->end_len;
+	++n_iters;
+
+	/* Setup misaligned end? */
+	if (write_dio->end_len) {
+		iter_is_dio_aligned[n_iters] = false;
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iov_iter_advance(&iters[n_iters],
+				 write_dio->start_len + write_dio->middle_len);
+		++n_iters;
+	}
+
+	return n_iters;
+}
+
+static int
+nfsd_issue_write_buffered(struct svc_rqst *rqstp, struct file *file,
+			  unsigned int nvecs, unsigned long *cnt,
+			  struct kiocb *kiocb)
+{
+	struct iov_iter iter;
+	int host_err;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
+	if (host_err < 0)
+		return host_err;
+	*cnt = host_err;
+
+	return 0;
+}
+
+static noinline int
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct nfsd_file *nf, loff_t offset,
+		     unsigned int nvecs, unsigned long *cnt,
+		     struct kiocb *kiocb)
+{
+	struct nfsd_write_dio write_dio;
+	struct file *file = nf->nf_file;
+
+	/* Any buffered IO issued here will be misaligned, use
+	 * IOCB_SYNC to ensure it has completed before returning.
+	 */
+	kiocb->ki_flags |= IOCB_SYNC;
+
+	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset, *cnt, &write_dio))
+		return nfsd_issue_write_buffered(rqstp, file, nvecs, cnt, kiocb);
+	else {
+		bool iter_is_dio_aligned[3];
+		struct iov_iter iter_stack[3];
+		struct iov_iter *iter = iter_stack;
+		unsigned int n_iters = 0;
+		int host_err;
+
+		n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
+				rqstp->rq_bvec, nvecs, *cnt, &write_dio);
+		*cnt = 0;
+		for (int i = 0; i < n_iters; i++) {
+			if (iter_is_dio_aligned[i] &&
+			    nfsd_iov_iter_aligned_bvec(&iter[i], nf->nf_dio_mem_align-1,
+						       nf->nf_dio_offset_align-1))
+				kiocb->ki_flags |= IOCB_DIRECT;
+			else
+				kiocb->ki_flags &= ~IOCB_DIRECT;
+			host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+			if (host_err < 0) {
+				/* Underlying FS will return -EINVAL if misaligned
+				 * DIO is attempted because it shouldn't be.
+				 */
+				WARN_ON_ONCE(host_err == -EINVAL);
+				return host_err;
+			}
+			*cnt += host_err;
+			if (host_err < iter[i].count) /* partial write? */
+				return *cnt;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1382,7 +1550,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1419,31 +1586,29 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb.ki_flags |= IOCB_DSYNC;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
-		/* direct I/O must be aligned to device logical sector size */
-		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
-		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0))
-			kiocb.ki_flags |= IOCB_DIRECT;
+		host_err = nfsd_issue_write_dio(rqstp, fhp, nf, offset,
+						nvecs, cnt, &kiocb);
 		break;
 	case NFSD_IO_DONTCACHE:
 		kiocb.ki_flags |= IOCB_DONTCACHE;
 		fallthrough;
 	case NFSD_IO_UNSPECIFIED:
 	case NFSD_IO_BUFFERED:
+		host_err = nfsd_issue_write_buffered(rqstp, file,
+						nvecs, cnt, &kiocb);
 		break;
 	}
-	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
-	*cnt = host_err;
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-- 
2.44.0


