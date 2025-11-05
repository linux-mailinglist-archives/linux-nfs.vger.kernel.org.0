Return-Path: <linux-nfs+bounces-16087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367CC377A1
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 20:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D4334E2459
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8133E361;
	Wed,  5 Nov 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlePasYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82072245006
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370894; cv=none; b=TuaGnfOpbu1KnGibiGoes4mvLE0bnaP+ixysJkk9eXDo9zyTpizOzQMx3B7ULIc509ayHOIaocAzQ8o6CkqztQxkhwJ8EfP9rbxeURv+hChIVG8PZdyOAvRDkclbrHS6h9iwW0vrsFICQSkh5wbUbugkEe1S8bsbwJ71giyTqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370894; c=relaxed/simple;
	bh=89VIyq4/MDixFIruAlStmmcaw4vVK1QbD8fAwLF0Dp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDDLjGhaOiF/m6MKDB/EwVYpcE/OzhmuznBve4d1zmBNm8C6PPAQcV6idCsS2uC6W/LCI65/+UV9sdMwZ5RiPraee1rq4TA5kIlTAsOISiVIjnFHeTZoGlFRB9biYse3MyEYc1RdDiyyOeznjolocgk6ccx+Vg/95qar77rKUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlePasYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B3FC116C6;
	Wed,  5 Nov 2025 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762370894;
	bh=89VIyq4/MDixFIruAlStmmcaw4vVK1QbD8fAwLF0Dp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlePasYA5oOuVlWlCB4vZhiVOYGy521t+dWFVjNo7sX+RZq3IZLb1x7dWXcWSTKHn
	 WH0EUJyqq3q5vs4V4pplHz8BkAp39/i+TmFjKtYWF0yrY9h3JyCVO1q5vPgSl+Y/xI
	 ie0wn2sUxaSgw5iM89mvINkxOAxBC6dX2vQpvAAitcqju/mSft6SxLnbObAxuaDrv2
	 OwIg2iqzulusthGzUs7ntabTrxrjljLRBLuVvF1rZ4C06CaxSJc1TqhjOWuooRm/t8
	 INap+CTkGM0Ff8tFigpBZi3fDxTzCaXCvDBDWb9UU9hM4ryOWyJtPALJCRyMKDHlQ7
	 M1ZuX7S+OgwBA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Wed,  5 Nov 2025 14:28:05 -0500
Message-ID: <20251105192806.77093-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105192806.77093-1-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>
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
 fs/nfsd/vfs.c     | 170 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 168 insertions(+), 4 deletions(-)

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
index f3be36b960e5..8158e129a560 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,161 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio_seg {
+	struct iov_iter			iter;
+	bool				use_dio;
+};
+
+struct nfsd_write_dio_args {
+	struct nfsd_file		*nf;
+	int				flags_buffered;
+	int				flags_direct;
+	unsigned int			nsegs;
+	struct nfsd_write_dio_seg	segment[3];
+};
+
+/*
+ * Check if the bvec iterator is aligned for direct I/O.
+ *
+ * bvecs generated from RPC receive buffers are contiguous: After the first
+ * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
+ * Therefore, only the first bvec is checked.
+ */
+static bool
+nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
+{
+	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
+	const struct bio_vec *bvec = i->bvec;
+
+	return ((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask) == 0;
+}
+
+static void
+nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
+			struct bio_vec *bvec, unsigned int nvecs,
+			unsigned long total, size_t start, size_t len)
+{
+	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
+	if (start)
+		iov_iter_advance(&segment->iter, start);
+	iov_iter_truncate(&segment->iter, len);
+	segment->use_dio = false;
+}
+
+static void
+nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
+			  loff_t offset, unsigned long total,
+			  struct nfsd_write_dio_args *args)
+{
+	u32 offset_align = args->nf->nf_dio_offset_align;
+	u32 mem_align = args->nf->nf_dio_mem_align;
+	loff_t prefix_end, orig_end, middle_end;
+	size_t prefix, middle, suffix;
+
+	args->nsegs = 0;
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
+		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
+					nvecs, total, 0, prefix);
+		++args->nsegs;
+	}
+
+	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
+				total, prefix, middle);
+	if (!nfsd_iov_iter_aligned_bvec(args->nf,
+					&args->segment[args->nsegs].iter))
+		goto no_dio;
+	args->segment[args->nsegs].use_dio = true;
+	++args->nsegs;
+
+	if (suffix) {
+		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
+					nvecs, total, prefix + middle, suffix);
+		++args->nsegs;
+	}
+
+	return;
+
+no_dio:
+	/*
+	 * No DIO alignment possible - pack into single non-DIO segment.
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
+	 */
+	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		args->flags_buffered |= IOCB_DONTCACHE;
+	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
+				0, total);
+	args->nsegs = 1;
+}
+
+static int
+nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct kiocb *kiocb, unsigned int nvecs,
+		     unsigned long *cnt, struct nfsd_write_dio_args *args)
+{
+	struct file *file = args->nf->nf_file;
+	ssize_t host_err;
+	unsigned int i;
+
+	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
+				  *cnt, args);
+
+	*cnt = 0;
+	for (i = 0; i < args->nsegs; i++) {
+		if (args->segment[i].use_dio) {
+			kiocb->ki_flags = args->flags_direct;
+			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
+						args->segment[i].iter.count);
+		} else
+			kiocb->ki_flags = args->flags_buffered;
+
+		host_err = vfs_iocb_iter_write(file, kiocb,
+					       &args->segment[i].iter);
+		if (host_err < 0)
+			return host_err;
+		*cnt += host_err;
+		if (host_err < args->segment[i].iter.count)
+			break;	/* partial write */
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
+	struct nfsd_write_dio_args args;
+
+	args.flags_direct = kiocb->ki_flags | IOCB_DIRECT;
+	args.flags_buffered = kiocb->ki_flags;
+	args.nf = nf;
+
+	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1329,25 +1484,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


