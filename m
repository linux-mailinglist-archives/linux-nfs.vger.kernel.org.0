Return-Path: <linux-nfs+bounces-13484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CAB1DB9E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2884D3BDC96
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B8E26F45A;
	Thu,  7 Aug 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl4RS2yp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135B26E711
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583956; cv=none; b=R/OJV9/PjVIdrkEuo9+ABpl3rmq63Q2XtAkHFr6tojOs1iCFOt2svZdLirZuPYm3GxCQKTST/CCi6DwG/nXEuKhXNUEcOoqJKkb4Au3lAM9GUMdgDD4K5DzzQSefiCBFn5tGua0g/ATkK8V+cHRSGZatkF1V6dy3eshDtifgOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583956; c=relaxed/simple;
	bh=t2j8WugX5KSNQzMN38chdfNzr1GbtqFIuPZsjZEFuUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvxaxnGo0sCDJ41uV8zTGBIQ4cKvFtk92jseerD6d8dvs6WogTm6qc+rpVwXBrCQWikmkZ4YCyHKECi02rA2jnG9DVJUklkOT4bGQY2NHwqiXmBLHGUYUZKQ4fc1vNQ2UALzCspNzAip2MivDwySamy6z0FRnCF9UcSuwKZmv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl4RS2yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C619C4CEEB;
	Thu,  7 Aug 2025 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583955;
	bh=t2j8WugX5KSNQzMN38chdfNzr1GbtqFIuPZsjZEFuUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kl4RS2yprL/ZuL22+gom4PujLJprH+zGctw1eftUHa3X/kUSM2fkGVI2+dm71XqbO
	 sNQPx/KqVaWnZBzDtLyixJs9KHr4V/1MS3rQXKpHBi8gTyt5QgFZlDV+hdZ5zSzctX
	 NvWsvOK0KW/1fbOEBHquItcDLIhuVeAtrhG+D6XckJb6TLKxAvMw9cqFsTvdIN2gk0
	 TA8pf4kFu/kZiuZ6LxcA+LagzJzbPTfY6FeXbFn7tEDTgF3y7XlwniigctCscwXkMG
	 67teD0uv27JZrrljwtvgNz9dvsggBp4XlRsZgcb+hv3tPQD8qEy5Kj23MQGF3LjeCA
	 oc0f5CaZwk68A==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 7/7] NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
Date: Thu,  7 Aug 2025 12:25:44 -0400
Message-ID: <20250807162544.17191-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250807162544.17191-1-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
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

The nfsd_analyze_write_dio trace event shows how NFSD splits a given
misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
extent.

This combination of trace events is useful:

  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

Which for this dd command:

  dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct

Results in:

  nfsd-23908   [010] ..... 10374.902333: nfsd_write_opened: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008
  nfsd-23908   [010] ..... 10374.902335: nfsd_analyze_write_dio: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+46592 end=46592+416
  nfsd-23908   [010] ..... 10374.902343: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0x0 pos 0x0 bytecount 0xb600
  nfsd-23908   [010] ..... 10374.902697: nfsd_write_io_done: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008

  nfsd-23908   [010] ..... 10374.902925: nfsd_write_opened: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008
  nfsd-23908   [010] ..... 10374.902926: nfsd_analyze_write_dio: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=47008+96 middle=47104+46592 end=93696+320
  nfsd-23908   [010] ..... 10374.903010: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0xb800 pos 0xb800 bytecount 0xb600
  nfsd-23908   [010] ..... 10374.903239: nfsd_write_io_done: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 170 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index be083a8812717..1b5aa3e6e6623 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1315,6 +1315,167 @@ static int wait_for_concurrent_writes(struct file *file)
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
+		goto out;
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
+out:
+	trace_nfsd_analyze_write_dio(rqstp, fhp, offset, len, start_offset, start_len,
+				     write_dio->middle_offset, write_dio->middle_len,
+				     write_dio->end_offset, write_dio->end_len);
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
+		n_iters++;
+	}
+
+	/* Setup DIO-aligned middle */
+	iter_is_dio_aligned[n_iters] = true;
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (write_dio->start_len)
+		iov_iter_advance(&iters[n_iters], write_dio->start_len);
+	iters[n_iters].count -= write_dio->end_len;
+	n_iters++;
+
+	/* Setup misaligned end? */
+	if (write_dio->end_len) {
+		iter_is_dio_aligned[n_iters] = false;
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iov_iter_advance(&iters[n_iters],
+				 write_dio->start_len + write_dio->middle_len);
+		n_iters++;
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
+	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset,
+				    *cnt, &write_dio)) {
+		return nfsd_issue_write_buffered(rqstp, file,
+					nvecs, cnt, kiocb);
+	} else {
+		bool iter_is_dio_aligned[3];
+		struct iov_iter iter_stack[3];
+		struct iov_iter *iter = iter_stack;
+		unsigned int n_iters = 0;
+		int host_err;
+
+		n_iters = nfsd_setup_write_dio_iters(&iter,
+				iter_is_dio_aligned, rqstp->rq_bvec,
+				nvecs, *cnt, &write_dio);
+		*cnt = 0;
+		for (int i = 0; i < n_iters; i++) {
+			if (iter_is_dio_aligned[i])
+				kiocb->ki_flags |= IOCB_DIRECT;
+			else
+				kiocb->ki_flags &= ~IOCB_DIRECT;
+			host_err = vfs_iocb_iter_write(file, kiocb,
+						       &iter[i]);
+			if (host_err < 0)
+				return host_err;
+			*cnt += host_err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1342,7 +1503,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1379,31 +1539,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb.ki_flags |= IOCB_DSYNC;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
+	since = READ_ONCE(file->f_wb_err);
+	if (verf)
+		nfsd_copy_write_verifier(verf, nn);
 
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
-		break;
+		fallthrough;
 	case NFSD_IO_BUFFERED:
+		host_err = nfsd_issue_write_buffered(rqstp, file,
+						nvecs, cnt, &kiocb);
 		break;
 	}
-
-	since = READ_ONCE(file->f_wb_err);
-	if (verf)
-		nfsd_copy_write_verifier(verf, nn);
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


