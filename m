Return-Path: <linux-nfs+bounces-15695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3096DC0F162
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ED3188C227
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE53126A2;
	Mon, 27 Oct 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUAtzJhF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FF311C3C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579998; cv=none; b=XmckZCqZ1hRaeTGfX2QsOJYjtjhs+7O8MgvOXbzjET9MB3wUuz62jAD4PJtT0HRZdyg9usoXfgWYT9xaQQ0/HYOKsFV6FT0xReDDqmdsGYqP5jtYiu+3oYiQ0a8/Y3Uy6yg5blIIpFlt2uyXAx/jNMWT6e0vS2MCeXqWmF3q8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579998; c=relaxed/simple;
	bh=T+1lXuaP5OvXK0F1+h+zagylB+dIJ+VQdJbZFgLl7QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpwuUvRLjnuYwUiLAwUxNsj8/wr8PzO2fPteU91kYH0gpsAuazxqV1ylHly//FaL3BEqm7FO8bDqyUaJOLjPBfcWARGTBxhDtpAeMJyZ9I/YEeYWVHEHCSYa1c6J/qgRacDtWfqgKJSL5Nn5GCKnfKPFJSdaVbeZX6+UMr/z2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUAtzJhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174B9C113D0;
	Mon, 27 Oct 2025 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579996;
	bh=T+1lXuaP5OvXK0F1+h+zagylB+dIJ+VQdJbZFgLl7QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUAtzJhFNDt7vPsHjiB1/PeQSveRMN0GrsgipfSKuOzcjq1KDIWF0qErMzcj/+wme
	 xp6oBww4Q3JXheegfvEotPUWYHJvfvtyL+OB9Q6HfOF3a67r3zeBiRy0RMpozjelcq
	 8JyV6OOHh4UgFoXSgxzNxYLmw+0Jy2ctMU63xzE3eEpHK8MspH+jN8UGCb7EVpJNZE
	 pt0Wm9Ovbm7nimwoELE+7WomAmc1abDT6CzLdDg3C364LYJXsUn0oC1awa6a4Wn/At
	 CxMGhHC3chltlKAo9fgeRt+5sMCZuPksimEyOwMsr1lHP1Dkrd81170TJWLCTvrcIx
	 N9RNWzC6Rd8LQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v8 03/12] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Mon, 27 Oct 2025 11:46:21 -0400
Message-ID: <20251027154630.1774-4-cel@kernel.org>
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

From: Mike Snitzer <snitzer@kernel.org>

If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
middle and end as needed. The large middle extent is DIO-aligned and
the start and/or end are misaligned. Synchronous buffered IO (with
preference towards using DONTCACHE) is used for the misaligned extents
and O_DIRECT is used for the middle DIO-aligned extent.

nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
allows the client to drop its dirty data and avoid needing an extra
COMMIT operation.

If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
invalidate the page cache on behalf of the DIO WRITE, then
nfsd_issue_write_dio() will fall back to using buffered IO.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |   1 +
 fs/nfsd/trace.h   |   1 +
 fs/nfsd/vfs.c     | 218 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 00eb1ecef6ac..7f44689e0a53 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -108,6 +108,7 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
 	switch (val) {
 	case NFSD_IO_BUFFERED:
 	case NFSD_IO_DONTCACHE:
+	case NFSD_IO_DIRECT:
 		nfsd_io_cache_write = val;
 		break;
 	default:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index bfd41236aff2..ad74439d0105 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -469,6 +469,7 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
 DEFINE_NFSD_IO_EVENT(read_done);
 DEFINE_NFSD_IO_EVENT(write_start);
 DEFINE_NFSD_IO_EVENT(write_opened);
+DEFINE_NFSD_IO_EVENT(write_direct);
 DEFINE_NFSD_IO_EVENT(write_io_done);
 DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f3be36b960e5..6cb0efd8ecdd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,210 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio {
+	ssize_t	start_len;	/* Length for misaligned first extent */
+	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
+	ssize_t	end_len;	/* Length for misaligned last extent */
+};
+
+static bool
+nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
+		       struct nfsd_file *nf, struct nfsd_write_dio *write_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	loff_t start_end, orig_end, middle_end;
+
+	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
+		return false;
+	if (unlikely(dio_blocksize > PAGE_SIZE))
+		return false;
+	if (unlikely(len < dio_blocksize))
+		return false;
+
+	start_end = round_up(offset, dio_blocksize);
+	orig_end = offset + len;
+	middle_end = round_down(orig_end, dio_blocksize);
+
+	write_dio->start_len = start_end - offset;
+	write_dio->middle_len = middle_end - start_end;
+	write_dio->end_len = orig_end - middle_end;
+
+	return true;
+}
+
+static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
+		unsigned int addr_mask, unsigned int len_mask)
+{
+	const struct bio_vec *bvec = i->bvec;
+	size_t skip = i->iov_offset;
+	size_t size = i->count;
+
+	if (size & len_mask)
+		return false;
+	do {
+		size_t len = bvec->bv_len;
+
+		if (len > size)
+			len = size;
+		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
+			return false;
+		bvec++;
+		size -= len;
+		skip = 0;
+	} while (size);
+
+	return true;
+}
+
+/*
+ * Setup as many as 3 iov_iter based on extents described by @write_dio.
+ * Returns the number of iov_iter that were setup.
+ */
+static int
+nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
+			   struct bio_vec *rq_bvec, unsigned int nvecs,
+			   unsigned long cnt, struct nfsd_write_dio *write_dio,
+			   struct nfsd_file *nf)
+{
+	int n_iters = 0;
+	struct iov_iter *iters = *iterp;
+
+	/* Setup misaligned start? */
+	if (write_dio->start_len) {
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iters[n_iters].count = write_dio->start_len;
+		iter_is_dio_aligned[n_iters] = false;
+		++n_iters;
+	}
+
+	/* Setup DIO-aligned middle */
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (write_dio->start_len)
+		iov_iter_advance(&iters[n_iters], write_dio->start_len);
+	iters[n_iters].count -= write_dio->end_len;
+	iter_is_dio_aligned[n_iters] =
+		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
+				nf->nf_dio_mem_align-1, nf->nf_dio_offset_align-1);
+	if (unlikely(!iter_is_dio_aligned[n_iters]))
+		return 0; /* no DIO-aligned IO possible */
+	++n_iters;
+
+	/* Setup misaligned end? */
+	if (write_dio->end_len) {
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iov_iter_advance(&iters[n_iters],
+				 write_dio->start_len + write_dio->middle_len);
+		iter_is_dio_aligned[n_iters] = false;
+		++n_iters;
+	}
+
+	return n_iters;
+}
+
+static int
+nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
+		    unsigned int nvecs, unsigned long *cnt,
+		    struct kiocb *kiocb)
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
+static int
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
+		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
+		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
+{
+	struct file *file = nf->nf_file;
+	bool iter_is_dio_aligned[3];
+	struct iov_iter iter_stack[3];
+	struct iov_iter *iter = iter_stack;
+	unsigned int n_iters = 0;
+	unsigned long in_count = *cnt;
+	loff_t in_offset = kiocb->ki_pos;
+	ssize_t host_err;
+
+	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
+				rqstp->rq_bvec, nvecs, *cnt, write_dio, nf);
+	if (unlikely(!n_iters))
+		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
+
+	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
+
+	/*
+	 * Any buffered IO issued here will be misaligned, use
+	 * sync IO to ensure it has completed before returning.
+	 * Also update @stable_how to avoid need for COMMIT.
+	 */
+	kiocb->ki_flags |= (IOCB_DSYNC|IOCB_SYNC);
+	*stable_how = NFS_FILE_SYNC;
+
+	*cnt = 0;
+	for (int i = 0; i < n_iters; i++) {
+		if (iter_is_dio_aligned[i])
+			kiocb->ki_flags |= IOCB_DIRECT;
+		else
+			kiocb->ki_flags &= ~IOCB_DIRECT;
+
+		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+		if (host_err < 0) {
+			/*
+			 * VFS will return -ENOTBLK if DIO WRITE fails to
+			 * invalidate the page cache. Retry using buffered IO.
+			 */
+			if (unlikely(host_err == -ENOTBLK)) {
+				kiocb->ki_flags &= ~IOCB_DIRECT;
+				*cnt = in_count;
+				kiocb->ki_pos = in_offset;
+				return nfsd_buffered_write(rqstp, file,
+							   nvecs, cnt, kiocb);
+			} else if (unlikely(host_err == -EINVAL)) {
+				struct inode *inode = d_inode(fhp->fh_dentry);
+
+				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
+						    inode->i_sb->s_id, inode->i_ino);
+				host_err = -ESERVERFAULT;
+			}
+			return host_err;
+		}
+		*cnt += host_err;
+		if (host_err < iter[i].count) /* partial write? */
+			break;
+	}
+
+	return 0;
+}
+
+static noinline_for_stack int
+nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
+		  unsigned long *cnt, struct kiocb *kiocb)
+{
+	struct nfsd_write_dio write_dio;
+
+	/*
+	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
+	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
+	 * be ignored for any DIO issued here).
+	 */
+	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		kiocb->ki_flags |= IOCB_DONTCACHE;
+
+	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
+		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
+					    cnt, kiocb, &write_dio);
+
+	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1282,7 +1486,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1329,25 +1532,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
-	case NFSD_IO_BUFFERED:
+	case NFSD_IO_DIRECT:
+		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
+					     nvecs, cnt, &kiocb);
+		stable = *stable_how;
 		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
+		fallthrough; /* must call nfsd_buffered_write */
+	case NFSD_IO_BUFFERED:
+		host_err = nfsd_buffered_write(rqstp, file,
+					       nvecs, cnt, &kiocb);
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
2.51.0


