Return-Path: <linux-nfs+bounces-15534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFDBFE038
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3873A18C4945
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58F2EF64C;
	Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEnyb1KI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F83370F5
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160940; cv=none; b=gp+Q7ZIf2/7t+CjnxeRMVzDMVHiqGz9+ojk/vvItl5Y36pDS1YXw+9nkKIkIeErzyJYS3L6UspORPsQ79fmk8uIwIKWKWPr4sPbOzMcwcO+DNrV04SMgQKfjjID2y6HUgP+DI/phHVaCAC3A4xN6C88/Z3eIAUwjcUUf5wW89ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160940; c=relaxed/simple;
	bh=PA9xc+k2MjyinTM6JhuDpj7EXwGfNcQOT2ZaHKpJ6is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/KEgPKa8u49PJIbKhGZO78e6kOgeNTlPKCH2ggI+NRpeB4HDsGAZgLxGk1LrYp6lbrLKcY4nn5FUjJ/fIToDS6wITLmjozPA4QaZ8PeC/L8U3hEREGo0ueIg05pIhWJePt7T5YL31FcRAj4VPyU9vgu1lcTnhiQBQeqPiKGgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEnyb1KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDA2C113D0;
	Wed, 22 Oct 2025 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160940;
	bh=PA9xc+k2MjyinTM6JhuDpj7EXwGfNcQOT2ZaHKpJ6is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEnyb1KIalX7ILLO7TzaUoGTHKlS9qQuTU1zhM89gJhIngTdUO26BYvIA20v4fy+4
	 SXqzzpQEfOGYETXJzWuF2XHiP1Gv8MeXnTrFKOOAYweDuYxNS61Lbg5J6w8JmLL25s
	 DkAci1meKgkFmbWju9R7BC80dNnsHdRJVLYtRqcjiYtiE9t/zLFTUTquOMj/8MX/AF
	 nur0rT3kUDrBuSHoX+SRnWxvYuO7KsX/BFNq9qcM9Jc6RutJSXjsa5KBz/rshYV2NL
	 NWKmLt2qfR07oFWgDTiltcIaVsfNEnjTpLP6gyXBD9JpU2Wv2DH2fhA13ow7vxoZy5
	 gswsUleiOiyzA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Wed, 22 Oct 2025 15:22:07 -0400
Message-ID: <20251022192208.1682-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192208.1682-1-cel@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
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
the start and/or end are misaligned. An O_SYNC buffered write (with
preference towards using DONTCACHE) is used for the misaligned extents
and O_DIRECT is used for the middle DIO-aligned extent.

nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
allows the client to drop its dirty data and avoid needing an extra
COMMIT operation.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |   1 +
 fs/nfsd/trace.h   |   1 +
 fs/nfsd/vfs.c     | 181 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)

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
index 41cd2b53d803..29c29a5111f8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,105 @@ static int wait_for_concurrent_writes(struct file *file)
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
+	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
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
+ * Set up as many as 3 iov_iter based on extents described by @write_dio.
+ * Returns the number of iov_iter that were setup.
+ */
+static int
+nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
+			   struct bio_vec *rq_bvec, unsigned int nvecs,
+			   unsigned long cnt, struct nfsd_write_dio *write_dio,
+			   struct nfsd_file *nf)
+{
+	struct iov_iter *iters = *iterp;
+	int n_iters = 0;
+
+	/* Set up misaligned start? */
+	if (write_dio->start_len) {
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iters[n_iters].count = write_dio->start_len;
+		iter_is_dio_aligned[n_iters] = false;
+		++n_iters;
+	}
+
+	/* Set up DIO-aligned middle */
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
+	/* Set up misaligned end? */
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
@@ -1270,6 +1369,80 @@ nfsd_iocb_write(struct svc_rqst *rqstp, struct file *file, unsigned int nvecs,
 	return 0;
 }
 
+static int
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct nfsd_file *nf, unsigned int nvecs,
+		     unsigned long *cnt, struct kiocb *kiocb,
+		     struct nfsd_write_dio *write_dio)
+{
+	struct iov_iter iter_stack[3];
+	struct iov_iter *iter = iter_stack;
+	loff_t in_offset = kiocb->ki_pos;
+	struct file *file = nf->nf_file;
+	unsigned long in_count = *cnt;
+	bool iter_is_dio_aligned[3];
+	unsigned int n_iters = 0;
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
+	 * SYNC + DIRECT means the write should persist dirty time stamps.
+	 *
+	 * But for buffered writes done as fallback or to handle misaligned
+	 * payload segments, the data must be durable before nfsd_vfs_write
+	 * returns.
+	 */
+	kiocb->ki_flags &= ~IOCB_DSYNC;
+	kiocb->ki_flags |= IOCB_SYNC;
+
+	*cnt = 0;
+	for (int i = 0; i < n_iters; i++) {
+		if (iter_is_dio_aligned[i])
+			kiocb->ki_flags |= IOCB_DIRECT;
+		else
+			kiocb->ki_flags &= ~IOCB_DIRECT;
+
+		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+		if (host_err < 0)
+			return host_err;
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
+		  struct nfsd_file *nf, unsigned int nvecs,
+		  unsigned long *cnt, struct kiocb *kiocb)
+{
+	struct nfsd_write_dio write_dio;
+
+	/*
+	 * Check if the underlying file system allows IOCB_DONTCACHE to be
+	 * used when issuing buffered IO. If so, request it to preserve the
+	 * intent of NFSD_IO_DIRECT. DONTCACHE will be ignored for direct
+	 * writes.
+	 */
+	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		kiocb->ki_flags |= IOCB_DONTCACHE;
+
+	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
+		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
+					    &write_dio);
+
+	return nfsd_iocb_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1311,6 +1484,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (sb->s_export_op)
 		exp_op_flags = sb->s_export_op->flags;
 
+	/* cel: UNSTABLE buffered WRITEs might want some form of throttling
+	 *	as well to prevent clients from pushing writes to us faster
+	 *	than they can be flushed onto durable storage */
 	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
 	    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
 		/*
@@ -1341,6 +1517,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
+	case NFSD_IO_DIRECT:
+		host_err = nfsd_direct_write(rqstp, fhp, nf, nvecs, cnt,
+					     &kiocb);
+		stable = *stable_how = NFS_FILE_SYNC;
+		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
-- 
2.51.0


