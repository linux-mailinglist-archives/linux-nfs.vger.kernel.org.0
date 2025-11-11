Return-Path: <linux-nfs+bounces-16270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB6C4EAE8
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 941DE4FCD92
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D251350A2E;
	Tue, 11 Nov 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+j6dcIE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77741328250
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873177; cv=none; b=CscsutOLJny5GjBeq4c3Q9KfOTo0f2czHjRwuPFxRgdKH9eQin61reccMahJ2lgV4+xiyuHWAirX3zQkPIm0wDb6CLj0TFl66H4yeP2QfscfprrlfgvdkrEIBpztWDJOlssYrO4cku4PnCoM7DhA8y9evkIdLqY0Sw+a1TTbN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873177; c=relaxed/simple;
	bh=xDLfh3WnlUnuS7fQ0IzgbEZxwcTkZk1Ud4G3VhkGrxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQEFfi5xQp0COTjeH33UAvZPd8iP/HlRFbkENc3iMWhfVZqO/EIVPp/Kqg+NfWuk0Mr1F+dA0YfUNY00qf2VYh6hT7qgfgSr/tuz7YNbjhC9V0N5luNAENCMUD4nhT+le7hDFVjucQfk6/HYTfTDmz39gtj3vaajTN0BMUhzO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+j6dcIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A47BC19421;
	Tue, 11 Nov 2025 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873177;
	bh=xDLfh3WnlUnuS7fQ0IzgbEZxwcTkZk1Ud4G3VhkGrxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+j6dcIEGjkWcTWTjMAmVKXYsPWhlNthAqI5yKts/u/Yg9pJM50NXVWpPcg7ExAH0
	 uGHR4WUIGIv9ZU/LQk0L5DQQOLT2bePVubOHlFmRNEiehTh97XTS4AfxXoZCTuLZTb
	 fLU9+iKZxUvs/ynGV34opzi0oYjFLe0EE3Gg6nrlwy2pUKMipVLIQSZIpsOe3I8lfi
	 y9x/zCLBywhmJxBCA1eL3KUFseigdn0jXwHDGy1juBp4+0reyMmQVpDwtfrhxHFHw6
	 up398EjatAdruFCUz298s9e65VnrGdK/lrQz3KRSxD3Hb1DKNG3GwcmxvSzWSEXZ4m
	 6QUQQ4SGizXCQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v12 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Tue, 11 Nov 2025 09:59:31 -0500
Message-ID: <20251111145932.23784-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111145932.23784-1-cel@kernel.org>
References: <20251111145932.23784-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

When NFSD_IO_DIRECT is selected via the
/sys/kernel/debug/nfsd/io_cache_write experimental tunable, split
incoming unaligned NFS WRITE requests into a prefix, middle and
suffix segment, as needed. The middle segment is now DIO-aligned and
the prefix and/or suffix are unaligned. Synchronous buffered IO is
used for the unaligned segments, and IOCB_DIRECT is used for the
middle DIO-aligned extent.

Although IOCB_DIRECT avoids the use of the page cache, by itself it
doesn't guarantee data durability. For UNSTABLE WRITE requests,
durability is obtained by a subsequent NFS COMMIT request.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |   1 +
 fs/nfsd/trace.h   |   2 +
 fs/nfsd/vfs.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 144 insertions(+), 4 deletions(-)

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
index 85a1521ad757..5ae2a611e57f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -469,6 +469,8 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
 DEFINE_NFSD_IO_EVENT(read_done);
 DEFINE_NFSD_IO_EVENT(write_start);
 DEFINE_NFSD_IO_EVENT(write_opened);
+DEFINE_NFSD_IO_EVENT(write_direct);
+DEFINE_NFSD_IO_EVENT(write_vector);
 DEFINE_NFSD_IO_EVENT(write_io_done);
 DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5333d49910d9..ab46301da4ae 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,136 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio_seg {
+	struct iov_iter			iter;
+	int				flags;
+};
+
+static unsigned long
+iov_iter_bvec_offset(const struct iov_iter *iter)
+{
+	return (unsigned long)(iter->bvec->bv_offset + iter->iov_offset);
+}
+
+static void
+nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
+			struct bio_vec *bvec, unsigned int nvecs,
+			unsigned long total, size_t start, size_t len,
+			struct kiocb *iocb)
+{
+	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
+	if (start)
+		iov_iter_advance(&segment->iter, start);
+	iov_iter_truncate(&segment->iter, len);
+	segment->flags = iocb->ki_flags;
+}
+
+static unsigned int
+nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
+			  unsigned int nvecs, struct kiocb *iocb,
+			  unsigned long total,
+			  struct nfsd_write_dio_seg segments[3])
+{
+	u32 offset_align = nf->nf_dio_offset_align;
+	loff_t prefix_end, orig_end, middle_end;
+	u32 mem_align = nf->nf_dio_mem_align;
+	size_t prefix, middle, suffix;
+	loff_t offset = iocb->ki_pos;
+	unsigned int nsegs = 0;
+
+	/*
+	 * Check if direct I/O is feasible for this write request.
+	 * If alignments are not available, the write is too small,
+	 * or no alignment can be found, fall back to buffered I/O.
+	 */
+	if (unlikely(!mem_align || !offset_align) ||
+	    unlikely(total < max(offset_align, mem_align)))
+		goto no_dio;
+
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
+	if (prefix)
+		nfsd_write_dio_seg_init(&segments[nsegs++], bvec,
+					nvecs, total, 0, prefix, iocb);
+
+	nfsd_write_dio_seg_init(&segments[nsegs], bvec, nvecs,
+				total, prefix, middle, iocb);
+
+	/*
+	 * Check if the bvec iterator is aligned for direct I/O.
+	 *
+	 * bvecs generated from RPC receive buffers are contiguous: After
+	 * the first bvec, all subsequent bvecs start at bv_offset zero
+	 * (page-aligned). Therefore, only the first bvec is checked.
+	 */
+	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
+		goto no_dio;
+	segments[nsegs].flags |= IOCB_DIRECT;
+	nsegs++;
+
+	if (suffix)
+		nfsd_write_dio_seg_init(&segments[nsegs++], bvec, nvecs, total,
+					prefix + middle, suffix, iocb);
+
+	return nsegs;
+
+no_dio:
+	/* No DIO alignment possible - pack into single non-DIO segment. */
+	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
+				total, iocb);
+	return 1;
+}
+
+static noinline_for_stack int
+nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct nfsd_file *nf, unsigned int nvecs,
+		  unsigned long *cnt, struct kiocb *kiocb)
+{
+	struct nfsd_write_dio_seg segments[3];
+	struct file *file = nf->nf_file;
+	unsigned int nsegs, i;
+	ssize_t host_err;
+
+	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
+					  kiocb, *cnt, segments);
+
+	*cnt = 0;
+	for (i = 0; i < nsegs; i++) {
+		kiocb->ki_flags = segments[i].flags;
+		if (kiocb->ki_flags & IOCB_DIRECT)
+			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
+						segments[i].iter.count);
+		else {
+			trace_nfsd_write_vector(rqstp, fhp, kiocb->ki_pos,
+						segments[i].iter.count);
+			/*
+			 * Mark the I/O buffer as evict-able to reduce
+			 * memory contention.
+			 */
+			if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+				kiocb->ki_flags |= IOCB_DONTCACHE;
+		}
+
+		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
+		if (host_err < 0)
+			return host_err;
+		*cnt += host_err;
+		if (host_err < segments[i].iter.count)
+			break;	/* partial write */
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1328,25 +1458,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+		host_err = nfsd_direct_write(rqstp, fhp, nf, nvecs,
+					     cnt, &kiocb);
 		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
+		fallthrough;
+	case NFSD_IO_BUFFERED:
+		iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+		host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
+		if (host_err < 0)
+			break;
+		*cnt = host_err;
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


