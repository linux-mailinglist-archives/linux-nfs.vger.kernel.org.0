Return-Path: <linux-nfs+bounces-13347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C9B176C0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145EB1C24C8D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AD246BB0;
	Thu, 31 Jul 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNASx1Go"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF9245019
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991094; cv=none; b=kRh4yPAyPoAyXsSgf91GXIPYt5rOczwXKhCgW92ZQmPsYQinizJKND/cOj6Bj+Lx0pPgqpoUO4OfU8eTvqb9aIxnBhvgJxyTyCix5dAV6cUh+1+59L16b2+5GSlmc664UDxoFcypO7q0ECCSZx3FTlDlyPaqb0T1hmQ8+0idpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991094; c=relaxed/simple;
	bh=WTbfoWdNHlKzmzzNK3M2uqIv70YWPRf0QslMrXd90oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBat+pbWW7mSGXKV1CO2Ku3TEt9AR4tDlRMrbLUE7M0HFawwn82rVq77tFwZF7/8gUW39gWON3MmwfrhRYJAts2a3UHqE/MEwO9ouypzDegxpIFcXSM7F3BAokrZAWy5GYFQsjbk30uP+zU5giM/dGFpqgQa7/e+BJ7MgxTAViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNASx1Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABDC4CEF8;
	Thu, 31 Jul 2025 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753991094;
	bh=WTbfoWdNHlKzmzzNK3M2uqIv70YWPRf0QslMrXd90oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNASx1GonLqPvCNsVwJ7p9VZxi9CWMUNtyKiTBv1TO794AqkVpskDM7Q7dwRVVyBs
	 1iAjX84nzYd86TgCPLw0w2V+Pjjdx6E4Jno7JpEViIMGL3rVCxTh3W2vupZ8Wt2cve
	 tjJgNQb6s6ltzFa1DqFf887LNTCbLL0EFztv4OmrIwUIF/Y2dP4/9uNoh47fCndBJl
	 Qd47upfFzQCjigbEAdJUpCgbO8gxlvCLSVNC7Weg9kSz7xqWuZwlDMqAveoKuDqTzn
	 s1xcv1LKea1vullpx2jUF7m8hbxK8JUtNCrk599yZwhdeCLsDT9Kv3IWQYCdFKUzXJ
	 s4igICQOCyMpQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
Date: Thu, 31 Jul 2025 15:44:47 -0400
Message-ID: <20250731194448.88816-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731194448.88816-1-snitzer@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
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

  nfsd-55714   [043] ..... 79976.260851: nfsd_write_opened: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
  nfsd-55714   [043] ..... 79976.260852: nfsd_analyze_write_dio: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
  nfsd-55714   [043] ..... 79976.260857: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0x0 pos 0x0 bytecount 0xb000
  nfsd-55714   [043] ..... 79976.260965: nfsd_write_io_done: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008

  nfsd-55714   [043] ..... 79976.307762: nfsd_write_opened: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
  nfsd-55714   [043] ..... 79976.307762: nfsd_analyze_write_dio: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008 start=47008+2144 middle=49152+40960 end=90112+3904
  nfsd-55714   [043] ..... 79976.307797: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0xc000 pos 0xc000 bytecount 0xa000
  nfsd-55714   [043] ..... 79976.307866: nfsd_write_io_done: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e4855c32dad12..23360825455a2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1314,6 +1314,113 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio
+{
+	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
+	loff_t end_offset;	/* Offset for start of DIO-aligned end */
+	ssize_t	start_len;	/* Length for misaligned first extent */
+	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
+	ssize_t	end_len;	/* Length for misaligned last extent */
+};
+
+static void init_nfsd_write_dio(struct nfsd_write_dio *write_dio)
+{
+	memset(write_dio, 0, sizeof(*write_dio));
+}
+
+static bool nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				   struct nfsd_file *nf, loff_t offset,
+				   unsigned long len, struct nfsd_write_dio *write_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	loff_t orig_end, middle_end, start_end, start_offset = offset;
+	ssize_t start_len = len;
+	bool aligned = true;
+
+	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
+		      "%s: underlying filesystem has not provided DIO alignment info\n",
+		      __func__))
+		return false;
+
+	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
+		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
+		      __func__, dio_blocksize, PAGE_SIZE))
+		return false;
+
+	if (unlikely(len < dio_blocksize)) {
+		aligned = false;
+		goto out;
+	}
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
+	return aligned;
+}
+
+/*
+ * Setup as many as 3 iov_iter based on extents possibly described by @write_dio.
+ * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
+ * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
+ * @nvecs: number of segments in @rq_bvec
+ * @cnt: size of the request in bytes
+ * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
+ *
+ * Returns the number of iov_iter that were setup.
+ */
+static int nfsd_setup_write_iters(struct iov_iter **iterp, struct bio_vec *rq_bvec,
+				  unsigned int nvecs, unsigned long cnt,
+				  struct nfsd_write_dio *write_dio)
+{
+	int n_iters = 0;
+	struct iov_iter *iters = *iterp;
+
+	/* Setup misaligned start? */
+	if (write_dio->start_len) {
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iters[n_iters].count = write_dio->start_len;
+		n_iters++;
+	}
+
+	/* Setup possibly DIO-aligned middle */
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (write_dio->start_len)
+		iov_iter_advance(&iters[n_iters], write_dio->start_len);
+	iters[n_iters].count -= write_dio->end_len;
+	n_iters++;
+
+	/* Setup misaligned end? */
+	if (write_dio->end_len) {
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iov_iter_advance(&iters[n_iters],
+				 write_dio->start_len + write_dio->middle_len);
+		n_iters++;
+	}
+
+	return n_iters;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1348,9 +1455,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
-	struct iov_iter		iter_stack[1];
+	struct iov_iter		iter_stack[3];
 	struct iov_iter		*iter = iter_stack;
 	unsigned int		n_iters = 0;
+	bool                    dio_aligned = false;
+	struct nfsd_write_dio	write_dio;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1379,18 +1488,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		kiocb.ki_flags |= IOCB_DSYNC;
 
-	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-	n_iters++;
-
+	init_nfsd_write_dio(&write_dio);
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
-		/* direct I/O must be aligned to device logical sector size */
-		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
-		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
-		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
-					nf->nf_dio_offset_align - 1))
-			kiocb.ki_flags = IOCB_DIRECT;
+		if (nfsd_analyze_write_dio(rqstp, fhp, nf, offset,
+					   *cnt, &write_dio))
+			dio_aligned = true;
 		break;
 	case NFSD_IO_DONTCACHE:
 		kiocb.ki_flags = IOCB_DONTCACHE;
@@ -1399,12 +1502,22 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		break;
 	}
 
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	n_iters = nfsd_setup_write_iters(&iter, rqstp->rq_bvec, nvecs, *cnt, &write_dio);
+
 	*cnt = 0;
 	for (int i = 0; i < n_iters; i++) {
 		since = READ_ONCE(file->f_wb_err);
 		if (verf)
 			nfsd_copy_write_verifier(verf, nn);
 
+		if (dio_aligned) {
+			if (iov_iter_is_aligned(&iter[i], nf->nf_dio_mem_align - 1,
+						nf->nf_dio_offset_align - 1))
+				kiocb.ki_flags |= IOCB_DIRECT;
+			else
+				kiocb.ki_flags &= ~IOCB_DIRECT;
+		}
 		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
 		if (host_err < 0) {
 			commit_reset_write_verifier(nn, rqstp, host_err);
-- 
2.44.0


