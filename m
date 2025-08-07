Return-Path: <linux-nfs+bounces-13483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E5B1DB9F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15ED18901B3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2026E715;
	Thu,  7 Aug 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgja2nI6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61726F45A
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583954; cv=none; b=NSgQ9nSm2SHPX1mtIrpm3m2eC1KAzOieiNYdPVa70mfvqEPl+mExnMmGvbh6h3PDhp4aLTi7rKpCdmTeJzxvNKQqwF+dWqMN8sVYmUghOz9BXCyH/6kg2c2DxfWoy9X4TeDNf5GMSztI4zT9X4KkhVFWar0YqwUjVq2Qf0AB7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583954; c=relaxed/simple;
	bh=l6W2Cah82uS3ywGcQbgi+e+n3QyTqKkceMOHn3Qt9K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkgrYJ1fzS5+oFtqKdoLgOuc7FFa6/90wzAApx6OFBrLC8ny2Q4ogC/8ThRvLS9YPuGpDi9oQrZ8fhHrfuRLbUfqIbA+AUz1FxNnu8xXAzWA54AHe5/lDzYEk+n9mHfOQtkT1g1lGFivJHwU9XHFC3rGc7AefBaaKKQZavvxHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgja2nI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C085C4CEEB;
	Thu,  7 Aug 2025 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583954;
	bh=l6W2Cah82uS3ywGcQbgi+e+n3QyTqKkceMOHn3Qt9K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgja2nI6En23y1SlcCsW3ddjMGiPrj9a7uLD0Y7PQsu1QSBEzhkiSMmS9jMxhFW6T
	 WBH79ZAhYMKF6PdI66jiLaHTIrgIZmMcaKCxLGzsTlhSdl0DtoPJbeIdQNAdPJQ5mr
	 tbCL5ytFdvx1kYAaV4UoeZUJXjpHlb63ZS5F95NWj5+hdw8tHWFd8noO+JiOWdyCP3
	 t4d2tX8odQYKEaynbUjDwJHBHsJ+LXNN1rORVqmtnh+ybtwb2JqWLrOZM7uJAGtsTj
	 lzhJuOAeWU9H0JEjdZQe9RqBoUNhECqF29JLjF93hllTJq+9MEWpPWqWIBT9V9TTzX
	 sQwUx4+88myvA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 6/7] NFSD: issue READs using O_DIRECT even if IO is misaligned
Date: Thu,  7 Aug 2025 12:25:43 -0400
Message-ID: <20250807162544.17191-7-snitzer@kernel.org>
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

Also add EVENT_CLASS nfsd_analyze_dio_class and use it to create
nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events. This
prepares for nfsd_vfs_write() to also make use of it when handling
misaligned WRITEs.

This combination of trace events is useful:

 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
 echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
 echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

Which for this dd command:

 dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

Results in:

  nfsd-23908   [010] ..... 10375.141640: nfsd_analyze_read_dio: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
  nfsd-23908   [010] ..... 10375.141642: nfsd_read_vector: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47104
  nfsd-23908   [010] ..... 10375.141643: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0x0 bytecount 0xb800
  nfsd-23908   [010] ..... 10375.141773: nfsd_read_io_done: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008

  nfsd-23908   [010] ..... 10375.142063: nfsd_analyze_read_dio: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=46592+416 middle=47008+47008 end=94016+192
  nfsd-23908   [010] ..... 10375.142064: nfsd_read_vector: xid=0x83c5923b fh_hash=0x857ca4fc offset=46592 len=47616
  nfsd-23908   [010] ..... 10375.142065: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0xb600 bytecount 0xba00
  nfsd-23908   [010] ..... 10375.142103: nfsd_read_io_done: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008

Suggested-by: Jeff Layton <jlayton@kernel.org>
Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/trace.h            |  61 ++++++++++++++
 fs/nfsd/vfs.c              | 167 ++++++++++++++++++++++++++++++++++---
 include/linux/sunrpc/svc.h |   5 +-
 3 files changed, 221 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a664fdf1161e9..4173bd9344b6b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,6 +473,67 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
+DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*fhp,
+		 u64		offset,
+		 u32		len,
+		 loff_t		start,
+		 ssize_t	start_len,
+		 loff_t		middle,
+		 ssize_t	middle_len,
+		 loff_t		end,
+		 ssize_t	end_len),
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(u64, offset)
+		__field(u32, len)
+		__field(loff_t, start)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
+		__field(loff_t, end)
+		__field(ssize_t, end_len)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->start = start;
+		__entry->start_len = start_len;
+		__entry->middle = middle;
+		__entry->middle_len = middle_len;
+		__entry->end = end;
+		__entry->end_len = end_len;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->offset, __entry->len,
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
+DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
+	TP_PROTO(struct svc_rqst *rqstp,			\
+		 struct svc_fh	*fhp,				\
+		 u64		offset,				\
+		 u32		len,				\
+		 loff_t		start,				\
+		 ssize_t	start_len,			\
+		 loff_t		middle,				\
+		 ssize_t	middle_len,			\
+		 loff_t		end,				\
+		 ssize_t	end_len),			\
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len))
+
+DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
+DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
+
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5768244c7a3c3..be083a8812717 100644
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
@@ -1073,6 +1074,116 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+struct nfsd_read_dio {
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
+	loff_t middle_end, orig_end = offset + len;
+
+	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
+		      "%s: underlying filesystem has not provided DIO alignment info\n",
+		      __func__))
+		return false;
+	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
+		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
+		      __func__, dio_blocksize, PAGE_SIZE))
+		return false;
+
+	/* Return early if IO is irreparably misaligned
+	 * (len < PAGE_SIZE, or base not aligned).
+	 */
+	if (unlikely(len < dio_blocksize) ||
+	    ((base & (nf->nf_dio_mem_align-1)) != 0))
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
+	middle_end = read_dio->end - read_dio->end_extra;
+	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
+				    read_dio->start, read_dio->start_extra,
+				    offset, (middle_end - offset),
+				    middle_end, read_dio->end_extra);
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
@@ -1094,26 +1205,49 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 
+	/*
+	 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
+	 * the next DIO-aligned block (on either end of the READ).
+	 */
 	if (nfsd_io_cache_read == NFSD_IO_DIRECT) {
-		/* Verify ondisk DIO alignment, memory addrs checked below */
-		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
-		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0))
-			kiocb.ki_flags = IOCB_DIRECT;
+		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
+					  in_count, base, &read_dio)) {
+			/* trace_nfsd_read_vector() will reflect larger
+			 * DIO-aligned READ.
+			 */
+			offset = read_dio.start;
+			in_count = read_dio.end - offset;
+			/* Verify ondisk DIO alignment, memory addrs checked below */
+			if (likely(((offset | in_count) &
+				    (nf->nf_dio_read_offset_align - 1)) == 0))
+				kiocb.ki_flags = IOCB_DIRECT;
+		}
 	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
 		kiocb.ki_flags = IOCB_DONTCACHE;
 
 	kiocb.ki_pos = offset;
 
 	v = 0;
-	total = *count;
+	total = in_count;
+	if (read_dio.start_extra) {
+		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
+			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
+		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
+			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
+			kiocb.ki_flags &= ~IOCB_DIRECT;
+		total -= read_dio.start_extra;
+		v++;
+	}
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
@@ -1125,11 +1259,22 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		base = 0;
 		v++;
 	}
-	WARN_ON_ONCE(v > rqstp->rq_maxpages);
+	if (WARN_ONCE(v > rqstp->rq_maxpages,
+		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
+		      v, rqstp->rq_maxpages)) {
+		host_err = -EINVAL;
+	}
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
-	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
+	if (!host_err) {
+		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
+		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
+		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
+	}
+
+	if (read_dio.start_extra || read_dio.end_extra) {
+		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
+					host_err, *count, &offset, &v);
+	}
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e64ab444e0a7f..190c2667500e2 100644
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


