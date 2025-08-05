Return-Path: <linux-nfs+bounces-13444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942CB1BA6F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6A1189652E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D825394C;
	Tue,  5 Aug 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Sxy+K8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AC299924
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419475; cv=none; b=lhy+CM6rkwQTDNMqNNPLVW3uHTEti9tgs/xLmGtqzkIIvshtVxzo775b0xOxdpPlylC/RPKIOOp075+o57rhk2rkZEbE/BOhRdJFs5ftxPSgHQ+C4PZ9AVh08WLREdJO8rAFUfc/pG0G/LnxAsrhFGq811bMgm+74OuHghchxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419475; c=relaxed/simple;
	bh=gUtxC6H8mmhB3yTP31ewd9dKl5JKkBpe31auQhGOvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX5Le+leH5cY4fDlox2klL8vNVNj9FRboSLaXynndZ7vum9i4VClFPc4JD/cr+yuRIgGdFeIs7QY/5QMLmO+uBdIpRQq2b+fOwnrriMsMqySvC5TVh1TAxAJyTXzOwEI9NPfjHKOR8N8SsDtr5jjD0lLApHVgJCcGG52iRdeSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4Sxy+K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DED7C4CEF0;
	Tue,  5 Aug 2025 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419475;
	bh=gUtxC6H8mmhB3yTP31ewd9dKl5JKkBpe31auQhGOvvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4Sxy+K8TV5viMvrUIXyqMub4Tv9JAb3j27NiwYSpSeokUlGszFohtJ7uqXlF2Cl2
	 Dl2h4yOWfsLCczdZqFWnlO2UsJKUlYbXtDapqoXMpFBNSO3oqk5foA+gQ4jzxeZEXL
	 eoBNYgjIhoyjwZqYOpDq4voBPz24ujx9kP/r87A/2et4B1YLZt0yCsKQiYeTOH8rDW
	 Frk2SZmu/QC5+5rDGwJGo2AYU/RC5lotIPDDdLyqf9z5DQGEes3ifvMu+xR4Pv2sBJ
	 F/Oall+WeNYkjgDgCcZaws2rfSMpu+YuQZaqTQAF2zA6k3455H1/xibvPq7WcFyFAu
	 mfKl6vZ3EkVPA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/4] NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
Date: Tue,  5 Aug 2025 14:44:28 -0400
Message-ID: <20250805184428.5848-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805184428.5848-1-snitzer@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0d4f9f452d466..4980800fab66e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1315,6 +1315,121 @@ static int wait_for_concurrent_writes(struct file *file)
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
+ * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
+ * @dio_aligned: bool that reflects nfsd_analyze_write_dio()'s return
+ * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
+ * @nvecs: number of segments in @rq_bvec
+ * @cnt: size of the request in bytes
+ * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
+ *
+ * Returns the number of iov_iter that were setup.
+ */
+static int nfsd_setup_write_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
+				  bool dio_aligned, struct bio_vec *rq_bvec,
+				  unsigned int nvecs, unsigned long cnt,
+				  struct nfsd_write_dio *write_dio)
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
+	/* Setup possibly DIO-aligned middle */
+	iter_is_dio_aligned[n_iters] = dio_aligned;
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (dio_aligned) {
+		if (write_dio->start_len)
+			iov_iter_advance(&iters[n_iters], write_dio->start_len);
+		iters[n_iters].count -= write_dio->end_len;
+	}
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
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1349,9 +1464,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
-	struct iov_iter		iter_stack[1];
+	struct iov_iter		iter_stack[3];
 	struct iov_iter		*iter = iter_stack;
 	unsigned int		n_iters = 0;
+	bool			iov_iter_is_dio_aligned[3];
+	bool			dio_aligned = false;
+	struct nfsd_write_dio	write_dio;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1380,18 +1498,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1400,11 +1512,19 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		break;
 	}
 
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	n_iters = nfsd_setup_write_iters(&iter, iov_iter_is_dio_aligned, dio_aligned,
+					 rqstp->rq_bvec, nvecs, *cnt, &write_dio);
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
 	*cnt = 0;
 	for (int i = 0; i < n_iters; i++) {
+		if (iov_iter_is_dio_aligned[i])
+			kiocb.ki_flags |= IOCB_DIRECT;
+		else
+			kiocb.ki_flags &= ~IOCB_DIRECT;
 		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
 		if (host_err < 0) {
 			commit_reset_write_verifier(nn, rqstp, host_err);
-- 
2.44.0


