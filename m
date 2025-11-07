Return-Path: <linux-nfs+bounces-16188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733AC4099D
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39344E987B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695332B9BA;
	Fri,  7 Nov 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUKmWGGM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB52F0C45
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529669; cv=none; b=u9mFBc+ZU1QOq0OASRJA37muSiQuORLOy0H3PYzP1BI0cKBsf0kWNeXnx+x+/CpAYdXDulvo/keT1ZOLXRdQidu63pjYsWrS6NNfQYaVCA2GC2QNQkP/d8bm/X2axe6rsdrhkmwaFY6ND1ysbxtNcYdNgXmRjvObxn+FS01GkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529669; c=relaxed/simple;
	bh=+wb6289KnaxYV5/8er1gwoCKH30p1b1+3DlCvhMGdjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuH3PSld0tFRm0+849K3p5llknWdWtD8SeEC4E7h+LsBs9SiZunCLQXN5Xu9tX1EKAJ+IZpJYfbKOexS5/3dIYDxeyyZDEgyX/Ls9Pez6A/tFO71MAZjMcc5w7dODuKk1ea6uuwC9EsBTXBx4IjfJ6TQXGFZU2eTrkQiO0RA8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUKmWGGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68281C19423;
	Fri,  7 Nov 2025 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529668;
	bh=+wb6289KnaxYV5/8er1gwoCKH30p1b1+3DlCvhMGdjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUKmWGGMvMCUD+rFeYIAp35SOVzwFPqOk/1reWFjm/AP6XFsxOvxSVbANw0jlOr4G
	 gGxnJLpDjTu2OaGx982HkNCYrb11gv+HzIpYf9j4ikyzFCoc5sPLssSqLrWz/Zo/M3
	 VuAGQw+QExfDEYhGXxD5dUGsnG74EwAr/Q6m4ut9EMwJVJI8Oahxl4jUdY91GQAH0q
	 oRx68lPlQ01lWUVEnbyUUNn3/64GflSF7Yc+oI2AqpAEiPW7sBat2XzTPH1wJrz1Dr
	 hlq7HRurcpfJAMAu4rWlUzE97QLPPfWMXk1jpGsJALVJBt4I5bbhPqmdvySl7csIo4
	 9b1HBHmHnZyQA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Fri,  7 Nov 2025 10:34:21 -0500
Message-ID: <20251107153422.4373-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107153422.4373-1-cel@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
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
 fs/nfsd/trace.h   |   1 +
 fs/nfsd/vfs.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 138 insertions(+), 4 deletions(-)

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
index 85a1521ad757..8047a6d97b81 100644
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
index 5333d49910d9..7e56be190170 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,131 @@ static int wait_for_concurrent_writes(struct file *file)
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
+	/*
+	 * No DIO alignment possible - pack into single non-DIO segment.
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
+	 */
+	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
+				total, iocb);
+	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		segments[nsegs].flags |= IOCB_DONTCACHE;
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
@@ -1328,25 +1453,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


