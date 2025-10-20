Return-Path: <linux-nfs+bounces-15412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38579BF269B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 757FD4F9AC8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16974287504;
	Mon, 20 Oct 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmIJTSNI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D972877D0
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977553; cv=none; b=gKt/x9eWWicAF4KA57evkBpckXbwSZhDnMt20mvXoGjQJcFLXpLxsqh0IdBiztPFg5zK2G3/UPEZ414IegnL8ZPL4thRsR7TOTXyL0V3XSFWTvQ1OJNlZ9Lkz36F07TyGJr4TRO7yL5bynKCQZTUkA/oKyUVWKuRjKDxw6wx6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977553; c=relaxed/simple;
	bh=Utxxpx+2yFytpgRq6q/0yVo/68zUnyJW9wo9Y0TBiCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZclYpdZX3pPLCYg+f/+ft2mevfHX3M3AivkmT5OhTFrJdoF+Ds2Fbh4exVbA7aX+YYOOZ9VAT7O5Im4ZPssVlmV//PSgpSPsdes0O/fAPTJZ7hfAmfs2QolVE3jiXCttcQN4dVrZptCDbfGgXFp7k+Bbw8Rd6ERnwD6vIRQuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmIJTSNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A55C116B1;
	Mon, 20 Oct 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977552;
	bh=Utxxpx+2yFytpgRq6q/0yVo/68zUnyJW9wo9Y0TBiCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmIJTSNI2LbqUmcLGbkpASP0yF4Y+1CxQwncCS3JLoym3rFOk+kEGyKIjrCaVPZ4E
	 QBDT31fh+FbFcxiW8AA8bTOnuoWLaTt5YBowkFqhopii7PEtlxomz4Mp5yd3QjkN8D
	 TJJAfAmd3DYN1h62FExgJVGTOEir1cxhwS2tWWBje5XR2rFv4bxjcSDn+PAvizOQGI
	 ptzypA8B61xLCKO8XjddEQI/scddWB53iMq/aP3lnMvlUMgkwjYtYDvKv1UGjqhxXw
	 hz17iKdLp1Z2GnT3Ny5WOyPaDj8vrgiv9Ie1gM8dd1VOpyfyO/Zjnw6ksl+k2u8c9o
	 MbOMMHLDEbhYA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v5 3/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Mon, 20 Oct 2025 12:25:45 -0400
Message-ID: <20251020162546.5066-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020162546.5066-1-cel@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
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

These changes served as the original starting point for the NFS
client's misaligned O_DIRECT support that landed with
commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
READ and WRITE"). But NFSD's support is simpler because it currently
doesn't use AIO completion.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |   1 +
 fs/nfsd/trace.h   |   1 +
 fs/nfsd/vfs.c     | 196 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

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
index ae9c41f7374e..6840fff37649 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,109 @@ static int wait_for_concurrent_writes(struct file *file)
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
+			   struct nfsd_file *nf,
+			   struct nfsd_write_dio *write_dio)
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
+static bool
+nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
+			   unsigned int len_mask)
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
+					   nf->nf_dio_mem_align - 1,
+					   nf->nf_dio_offset_align - 1);
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
 static int
 nfsd_iocb_write(struct svc_rqst *rqstp, struct file *file, unsigned int nvecs,
 		unsigned long *cnt, struct kiocb *kiocb)
@@ -1270,6 +1373,94 @@ nfsd_iocb_write(struct svc_rqst *rqstp, struct file *file, unsigned int nvecs,
 	return 0;
 }
 
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
+					     rqstp->rq_bvec, nvecs, *cnt,
+					     write_dio, nf);
+	if (unlikely(!n_iters))
+		return nfsd_iocb_write(rqstp, file, nvecs, cnt, kiocb);
+
+	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
+
+	/*
+	 * Any buffered IO issued here will be misaligned, use
+	 * sync IO to ensure it has completed before returning.
+	 * Also update @stable_how to avoid need for COMMIT.
+	 */
+	kiocb->ki_flags |= IOCB_DSYNC;
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
+				return nfsd_iocb_write(rqstp, file, nvecs, cnt,
+						       kiocb);
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
+	return nfsd_iocb_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1340,6 +1531,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
+	case NFSD_IO_DIRECT:
+		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
+					     nvecs, cnt, &kiocb);
+		stable = *stable_how;
+		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
-- 
2.51.0


