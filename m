Return-Path: <linux-nfs+bounces-13215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D4B0F755
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EB2AA7ED7
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252B210F59;
	Wed, 23 Jul 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq6a1ZoE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6C20C029
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285440; cv=none; b=cZcDm0uxomw5/9LsTzHZKEXRSm1KYowGZriUwFvIsgD3blTdD5gSjtN38dayVeCnkcheRc6a4nFUl0UZQnLQ6ZMPyu5HL/xkCcNCOJnxFvidsXaSnES7SGDZ6aGvVwceCHhvHAXIZkmlKjJLSOQgqImbtaMTVOUF3RXxIczy1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285440; c=relaxed/simple;
	bh=1nJQxeXB748eya78UgHZ3sIBlYpG7TOnsQ0z8GBOTjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwGcSsqcnnZMp5vqL8cN/y2wg0Ox0h6oRH/EsFwEDjCccRS3sWULR9hKUYklypxg2NNV6urbV25FLTT16LJSKaiqrAxbL3FGyEFvOvSBgyYcbmCnQp4xYqG5/Isw2L0bHNXvSR8YPWQguAcDtEycmAFRTGo4D1b3jyKOoeTFl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq6a1ZoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C7C4CEF1;
	Wed, 23 Jul 2025 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285440;
	bh=1nJQxeXB748eya78UgHZ3sIBlYpG7TOnsQ0z8GBOTjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uq6a1ZoEg4eBfprERr94qrToolK8jGYnbmCPtKsCQgZRxOS0SGk+gn9xeFashc1Ys
	 Nu2GohYzvyk+pCduCjwZBXthqAGk/I3cMH3AeVb1u6Ta0ZzBUSdE2HL+WwB/EtdaMd
	 joDYBVY9kg4WVsAowCzzYGuwO1HTI7c5bMtUEq8+wSXMaJSGDl61re+lekgQd/hpHr
	 /Q4DAzAoQ4GX8qTHibJcP/uh/IheU40qIfAcFy4k97vCI89070TUQI5wR9B1Vsw35u
	 EAJAXtKcbvBOoySa0W10WNEI0i4hxR5p0qHn07yVUKtLXxH4cs9bj0hnccUBC02P86
	 H/E8doK20tL3Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 5/5] NFSD: issue READs using O_DIRECT even if IO is misaligned
Date: Wed, 23 Jul 2025 11:43:51 -0400
Message-ID: <20250723154351.59042-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250723154351.59042-1-snitzer@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
DIO-aligned block (on either end of the READ). The expanded READ is
verified to have proper offset/len (logical_block_size) and
dma_alignment checking.

Must allocate and use a bounce-buffer page (called 'start_extra_page')
if/when expanding the misaligned READ requires reading extra partial
page at the start of the READ so that its DIO-aligned. Otherwise that
extra page at the start will make its way back to the NFS client and
corruption will occur. As found, and then this fix of using an extra
page verified, using the 'dt' utility:
  dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
     iotype=sequential pattern=iot onerr=abort oncerr=abort
see: https://github.com/RobinTMiller/dt.git

Any misaligned READ that is less than 32K won't be expanded to be
DIO-aligned (this heuristic just avoids excess work, like allocating
start_extra_page, for smaller IO that can generally already perform
well using buffered IO).

Also add nfsd_read_vector_dio trace event. This combination of
trace events is useful:

 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector_dio/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
 echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

Which for this dd command:

 dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

Results in:

 nfsd-16580   [001] .....  5672.403130: nfsd_read_vector_dio: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008 start=0+0 end=47104-96
 nfsd-16580   [001] .....  5672.403131: nfsd_read_vector: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47104
 nfsd-16580   [001] .....  5672.403134: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0x0 bytecount 0xb800
 nfsd-16580   [001] .....  5672.404380: nfsd_read_io_done: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008

 nfsd-16580   [001] .....  5672.404672: nfsd_read_vector_dio: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008 start=46592+416 end=94208-192
 nfsd-16580   [001] .....  5672.404672: nfsd_read_vector: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=46592 len=47616
 nfsd-16580   [001] .....  5672.404673: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0xb600 bytecount 0xba00
 nfsd-16580   [001] .....  5672.405771: nfsd_read_io_done: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008

Suggested-by: Jeff Layton <jlayton@kernel.org>
Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/trace.h            |  37 ++++++++
 fs/nfsd/vfs.c              | 180 ++++++++++++++++++++++++++++++++-----
 include/linux/sunrpc/svc.h |   5 +-
 3 files changed, 200 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a664fdf1161e..55055482f8a8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,6 +473,43 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
+TRACE_EVENT(nfsd_read_vector_dio,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*fhp,
+		 u64		offset,
+		 u32		len,
+		 loff_t         start,
+		 loff_t         start_extra,
+		 loff_t         end,
+		 loff_t         end_extra),
+	TP_ARGS(rqstp, fhp, offset, len, start, start_extra, end, end_extra),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(u64, offset)
+		__field(u32, len)
+		__field(loff_t, start)
+		__field(loff_t, start_extra)
+		__field(loff_t, end)
+		__field(loff_t, end_extra)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->start = start;
+		__entry->start_extra = start_extra;
+		__entry->end = end;
+		__entry->end_extra = end_extra;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%llu end=%llu-%llu",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->offset, __entry->len,
+		  __entry->start, __entry->start_extra,
+		  __entry->end, __entry->end_extra)
+);
+
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fac8be5a825d..1698fced6e11 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -19,6 +19,7 @@
 #include <linux/splice.h>
 #include <linux/falloc.h>
 #include <linux/fcntl.h>
+#include <linux/math.h>
 #include <linux/namei.h>
 #include <linux/delay.h>
 #include <linux/fsnotify.h>
@@ -1073,6 +1074,113 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+struct nfsd_read_dio
+{
+	loff_t start;
+	loff_t end;
+	unsigned long start_extra;
+	unsigned long end_extra;
+	struct page *start_extra_page;
+};
+
+static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
+{
+	memset(read_dio, 0, sizeof(*read_dio));
+	read_dio->start_extra_page = NULL;
+}
+
+static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				  struct nfsd_file *nf, loff_t offset,
+				  unsigned long len, unsigned int base,
+				  struct nfsd_read_dio *read_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
+	loff_t orig_end = offset + len;
+
+	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
+		      "%s: underlying filesystem has not provided DIO alignment info\n",
+		      __func__))
+		return false;
+
+	if ((base & (nf->nf_dio_mem_align-1)) != 0)
+		return false;
+
+	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
+		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
+		      __func__, dio_blocksize, PAGE_SIZE))
+		return false;
+
+	read_dio->start = round_down(offset, dio_blocksize);
+	read_dio->end = round_up(orig_end, dio_blocksize);
+	read_dio->start_extra = offset - read_dio->start;
+	read_dio->end_extra = read_dio->end - orig_end;
+
+	/* don't expand READ for IO less than 32K */
+	if ((read_dio->start_extra || read_dio->end_extra) && (len < (32 << 10))) {
+		init_nfsd_read_dio(read_dio);
+		return false;
+	}
+
+	if (read_dio->start_extra) {
+		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
+		if (WARN_ONCE(read_dio->start_extra_page == NULL,
+			      "%s: Unable to allocate start_extra_page\n", __func__)) {
+			init_nfsd_read_dio(read_dio);
+			return false;
+		}
+	}
+
+	/* Show original offset and count, and how it was expanded for DIO */
+	trace_nfsd_read_vector_dio(rqstp, fhp, offset, len,
+				   read_dio->start, read_dio->start_extra,
+				   read_dio->end, read_dio->end_extra);
+
+	return true;
+}
+
+static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
+						 struct nfsd_read_dio *read_dio,
+						 ssize_t bytes_read,
+						 unsigned long bytes_expected,
+						 loff_t *offset,
+						 unsigned long *rq_bvec_numpages)
+{
+	ssize_t host_err = bytes_read;
+	loff_t v;
+
+	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
+	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
+	 */
+	if (read_dio->start_extra_page) {
+		__free_page(read_dio->start_extra_page);
+		*rq_bvec_numpages -= 1;
+		v = *rq_bvec_numpages;
+		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
+			v * sizeof(struct bio_vec));
+	}
+	/* Eliminate any end_extra bytes from the last page */
+	v = *rq_bvec_numpages;
+	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
+
+	if (host_err < 0)
+		return host_err;
+
+	/* nfsd_analyze_read_dio() may have expanded the start and end,
+	 * if so adjust returned read size to reflect original extent.
+	 */
+	*offset += read_dio->start_extra;
+	if (likely(host_err >= read_dio->start_extra)) {
+		host_err -= read_dio->start_extra;
+		if (host_err > bytes_expected)
+			host_err = bytes_expected;
+	} else {
+		/* Short read that didn't read any of requested data */
+		host_err = 0;
+	}
+
+	return host_err;
+}
+
 /**
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
@@ -1094,45 +1202,75 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		      unsigned int base, u32 *eof)
 {
 	struct file *file = nf->nf_file;
-	unsigned long v, total;
+	unsigned long v, total, in_count = *count;
+	struct nfsd_read_dio read_dio;
 	struct iov_iter iter;
 	struct kiocb kiocb;
-	ssize_t host_err;
+	ssize_t host_err = 0;
 	size_t len;
 
+	init_nfsd_read_dio(&read_dio);
 	init_sync_kiocb(&kiocb, file);
+
+	/*
+	 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
+	 * the next DIO-aligned block (on either end of the READ).
+	 */
+	if (nfsd_io_cache_read == NFSD_IO_DIRECT) {
+		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
+					  in_count, base, &read_dio)) {
+			/* trace_nfsd_read_vector() will reflect larger
+			 * DIO-aligned READ.
+			 */
+			offset = read_dio.start;
+			in_count = read_dio.end - offset;
+			kiocb.ki_flags = IOCB_DIRECT;
+		}
+	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
+		kiocb.ki_flags = IOCB_DONTCACHE;
+
 	kiocb.ki_pos = offset;
 
 	v = 0;
-	total = *count;
+	total = in_count;
+	if (read_dio.start_extra) {
+		bvec_set_page(&rqstp->rq_bvec[v++], read_dio.start_extra_page,
+			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
+		total -= read_dio.start_extra;
+	}
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
-		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
+		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
 			      len, base);
 		total -= len;
-		++v;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > rqstp->rq_maxpages);
+	if (WARN_ONCE(v > rqstp->rq_maxpages,
+		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
+		      v, rqstp->rq_maxpages)) {
+		host_err = -EINVAL;
+	}
+
+	if (!host_err) {
+		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
+		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+		/* Double check nfsd_analyze_read_dio's DIO-aligned result */
+		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
+			     !iov_iter_is_aligned(&iter,
+				nf->nf_dio_mem_align - 1,
+				nf->nf_dio_read_offset_align - 1))) {
+			/* Fallback to buffered IO */
+			kiocb.ki_flags &= ~IOCB_DIRECT;
+		}
 
-	switch (nsfd_io_cache_read) {
-	case NFSD_IO_DIRECT:
-		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
-		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
-					nf->nf_dio_read_offset_align - 1))
-			kiocb.ki_flags = IOCB_DIRECT;
-		break;
-	case NFSD_IO_DONTCACHE:
-		kiocb.ki_flags = IOCB_DONTCACHE;
-		break;
-	case NFSD_IO_BUFFERED:
-		break;
+		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	}
 
-	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
+	if (read_dio.start_extra || read_dio.end_extra) {
+		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
+					host_err, *count, &offset, &v);
+	}
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e64ab444e0a7..190c2667500e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * pages, one for the request, and one for the reply.
  * nfsd_splice_actor() might need an extra page when a READ payload
  * is not page-aligned.
+ * nfsd_iter_read() might need two extra pages when a READ payload
+ * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
+ * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
  */
 static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 {
-	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
 }
 
 /*
-- 
2.44.0


