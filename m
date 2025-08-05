Return-Path: <linux-nfs+bounces-13456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88881B1BD0F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF6317F128
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316129CB4D;
	Tue,  5 Aug 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhgGC4ON"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298629C347
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436083; cv=none; b=H1Nf9w8/GVGvBcn9CrGv6CPJst9I5LAzeLPUEIOvqkkAoYdOZZ/ktsFiwzrIny3tauqz/+wm9gNpQ4bUGQ8/5xnm0BAmWFWk8FBePQjyZK6CTglypVIwHLBgW9IL1Ar5BODMhxm/gBU3jBaxV+P+RkSg8p+akYckmI627VHe8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436083; c=relaxed/simple;
	bh=G+/0pNjyHyQCdYzRAy09BRPj/hKgACGmixd27ZZcShk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9S9B9iteSIWvLAOGbj/58XtLiV+0ZlD8GYsrWdXPIiX/Gy6mDrn/sAfcO0WFPOwSe5bii92EwsriDUoUgmeHr1nPPLGkJDSIykZkbxBcHhQCz+1X3NYpwEWh8l08zKNgP1Fu7gcCAQny9h7GIA3WbUvutwpFGwvHuNlbHzbNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhgGC4ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB7BC4CEF0;
	Tue,  5 Aug 2025 23:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436081;
	bh=G+/0pNjyHyQCdYzRAy09BRPj/hKgACGmixd27ZZcShk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhgGC4ONFSBhsvi+aL77eyzplTEGaZT1Wrmy8HDTF3+qcZB50k9AhfFtXJsv+jXp3
	 T97fApknsucWQgT5xI6QQ2sdPzGJ0jARPfAX6A3SIqRF5e9cnVpbbeddFvDfN9ImNx
	 z6oJh1OFrTeheFS5pTAaid8zB2wTctsin2YTRHWxzHCFpE5mClFONxBKK82huX2rhs
	 1vgumKdH8VngIiBB4oFzkZmzWEANimqwbJqOB6PgPqAspPOe3U69Mjp19AXpaZL/WX
	 ouoEvyLY5nPQVfGFhEuKvXVsRUYbNB2Y9YQYtgFTDdHlKQ7aiFOP8LepLNjUBPRDFp
	 LIuNxdPXOK6pQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 09/11] nfs/direct: add misaligned READ handling
Date: Tue,  5 Aug 2025 19:21:04 -0400
Message-ID: <20250805232106.8656-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the NFS client will already happily handle misaligned O_DIRECT
IO (by sending it out to NFSD via RPC) this commit's new capabilities
are for the benefit of LOCALIO and require the nfs modparam:
  localio_O_DIRECT_align_misaligned_IO=Y

When enabled, misaligned READ IO is expanded to consist of a
DIO-aligned extent followed by a single misaligned tail page (due to
it being a partial page).

Also add nfs_analyze_dio_class and use it to create
nfs_analyze_read_dio and nfs_analyze_write_dio trace events.

The nfs_analyze_read_dio trace event's start and middle reflect the
combined DIO-aligned extent that is issued using O_DIRECT, and the end
reflects the misaligned tail page that is issued with buffered IO.

This combination of trace events is useful for LOCALIO READs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_read_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

Which for this dd command:

  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

Results in:
              dd-34643   [041] ..... 36754.259543: nfs_analyze_read_dio: fileid=00:2e:1739 fhandle=0x9b43f225 offset=0 count=47008 start=0+0 middle=0+45056 end=45056+1952
              dd-34643   [041] ..... 36754.259557: nfs_initiate_read: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=0 count=45056
  kworker/u194:3-33963   [042] ..... 36754.259559: xfs_file_direct_read: dev 259:16 ino 0x3e00008f disize 0x16f40 pos 0x0 bytecount 0xb000
              dd-34643   [041] ..... 36754.259560: nfs_initiate_read: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=1952
  kworker/u194:8-33926   [035] ..... 36754.259563: nfs_readpage_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=1952 res=1952
  kworker/u194:8-33926   [035] ..... 36754.259579: nfs_readpage_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=0 count=45056 res=45056

              dd-34643   [041] ..... 36754.259584: nfs_analyze_read_dio: fileid=00:2e:1739 fhandle=0x9b43f225 offset=47008 count=47008 start=45056+1952 middle=47008+43104 end=90112+3904
              dd-34643   [041] ..... 36754.259586: nfs_initiate_read: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=45056
  kworker/u194:8-33926   [035] ..... 36754.259588: xfs_file_direct_read: dev 259:16 ino 0x3e00008f disize 0x16f40 pos 0xb000 bytecount 0xb000
              dd-34643   [041] ..... 36754.259588: nfs_initiate_read: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=90112 count=3904
  kworker/u194:3-33963   [042] ..... 36754.259591: nfs_readpage_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=90112 count=3904 res=3904 eof
  kworker/u194:3-33963   [042] ..... 36754.259606: nfs_readpage_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=45056 res=45056

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c          | 176 ++++++++++++++++++++++++++++++++++++---
 fs/nfs/internal.h        |   8 ++
 fs/nfs/nfstrace.h        |  58 +++++++++++++
 fs/nfs/pagelist.c        |   7 ++
 include/linux/nfs_page.h |   1 +
 5 files changed, 239 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 48d89716193a7..118782070c5e8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -210,6 +210,13 @@ static void nfs_direct_req_free(struct kref *kref)
 		nfs_put_lock_context(dreq->l_ctx);
 	if (dreq->ctx != NULL)
 		put_nfs_open_context(dreq->ctx);
+
+	if (dreq->start_extra_bvec != NULL) {
+		if (dreq->start_extra_bvec->bv_page != NULL)
+			__free_page(dreq->start_extra_bvec->bv_page);
+		kfree(dreq->start_extra_bvec);
+	}
+
 	kmem_cache_free(nfs_direct_cachep, dreq);
 }
 
@@ -264,6 +271,10 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 		if (dreq->count != 0) {
 			res = (long) dreq->count;
 			WARN_ON_ONCE(dreq->count < 0);
+			/* Reduce res by front_pad */
+			if ((dreq->start_extra_bvec != NULL) &&
+			    res >= dreq->start_extra_bvec->bv_len)
+				res -= dreq->start_extra_bvec->bv_len;
 		}
 		dreq->iocb->ki_complete(dreq->iocb, res);
 	}
@@ -285,6 +296,15 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 	}
 
 	nfs_direct_count_bytes(dreq, hdr);
+
+	if (dreq->start_extra_bvec != NULL && (dreq->count == dreq->max_count)) {
+		unsigned front_pad = dreq->start_extra_bvec->bv_len;
+
+		hdr->res.count -= front_pad;
+		hdr->good_bytes -= front_pad;
+		hdr->args.count -= front_pad;
+		hdr->args.offset += front_pad;
+	}
 	spin_unlock(&dreq->lock);
 
 	nfs_update_delegated_atime(dreq->inode);
@@ -353,6 +373,30 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	desc.pg_dreq = dreq;
 	inode_dio_begin(inode);
 
+	if (dreq->start_extra_bvec != NULL) {
+		struct nfs_page *req;
+		size_t pgbase = dreq->start_extra_bvec->bv_offset;
+		unsigned int front_pad = dreq->start_extra_bvec->bv_len;
+
+		/* Must force start pos to DIO-aligned start */
+		WARN_ON(pos != dreq->io_start);
+		req = nfs_page_create_from_page(dreq->ctx,
+						dreq->start_extra_bvec->bv_page,
+						pgbase, pos, front_pad);
+		if (IS_ERR(req)) {
+			result = PTR_ERR(req);
+			goto out;
+		}
+		if (!nfs_pageio_add_request(&desc, req)) {
+			result = desc.pg_error;
+			nfs_release_request(req);
+			goto out;
+		}
+
+		requested_bytes += front_pad;
+		pos += front_pad;
+	}
+
 	while (iov_iter_count(iter)) {
 		struct page **pagevec;
 		size_t bytes;
@@ -363,12 +407,19 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
-	
-		bytes = result;
-		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
+
+		/* Limit the first batch of pages to DIO-aligned boundary? */
+		if (pos < dreq->end_offset && dreq->middle_len)
+			bytes = min_t(size_t, dreq->middle_len, result);
+		else
+			bytes = result;
+		npages = (bytes + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
+
 		for (i = 0; i < npages; i++) {
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
+			bool issue_dio_now = false;
+
 			/* XXX do we need to do the eof zeroing found in async_filler? */
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
 							pgbase, pos, req_len);
@@ -376,15 +427,33 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 				result = PTR_ERR(req);
 				break;
 			}
+
+			pgbase = 0;
+			result -= req_len;
+			bytes -= req_len;
+			requested_bytes += req_len;
+			pos += req_len;
+
+			/* Looking ahead, is this req the end of the DIO-aligned middle? */
+			if (bytes == 0 && dreq->end_len &&
+			    pos == dreq->end_offset && result == dreq->end_len) {
+				desc.pg_doio_now = 1;
+				issue_dio_now = true;
+				/* Reset iter to the last page (known misaligned),
+				 * issue previous DIO-aligned page and then handle
+				 * the last partial page stored in iter
+				 */
+				iov_iter_revert(iter, result);
+			}
+
 			if (!nfs_pageio_add_request(&desc, req)) {
 				result = desc.pg_error;
 				nfs_release_request(req);
 				break;
 			}
-			pgbase = 0;
-			bytes -= req_len;
-			requested_bytes += req_len;
-			pos += req_len;
+
+			if (issue_dio_now)
+				break;
 		}
 		nfs_direct_release_pages(pagevec, npages);
 		kvfree(pagevec);
@@ -398,6 +467,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	 * If no bytes were started, return the error, and let the
 	 * generic layer handle the completion.
 	 */
+out:
 	if (requested_bytes == 0) {
 		inode_dio_end(inode);
 		nfs_direct_req_release(dreq);
@@ -409,6 +479,68 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	return requested_bytes;
 }
 
+/*
+ * If localio_O_DIRECT_align_misaligned_READ enabled, expand any
+ * misaligned READ to include the previous DIO-aligned block.
+ * - FIXME: expanding the end to also be DIO-aligned requires a
+ *   bounce page that must be copied to original partial end page.
+ */
+static bool nfs_analyze_read_dio(loff_t offset, size_t len,
+				 struct nfs_direct_req *dreq)
+{
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/* Hardcoded to PAGE_SIZE (since don't have LOCALIO nfsd_file's
+	 * dio_alignment), works for smaller alignment too (e.g. 512b).
+	 */
+	u32 dio_blocksize = PAGE_SIZE;
+	loff_t start, front_pad, orig_end, middle_end;
+
+	/* Return early if feature disabled, if IO is irreparably
+	 * misaligned (len < PAGE_SIZE) or if IO is already DIO-aligned.
+	 */
+	if (!nfs_localio_O_DIRECT_align_misaligned_IO() ||
+	    unlikely(len < dio_blocksize) ||
+	    (((offset | len) & (dio_blocksize-1)) == 0))
+		return false;
+
+	start = round_down(offset, dio_blocksize);
+	front_pad = offset - start;
+	orig_end = offset + len;
+	middle_end = round_down(orig_end, dio_blocksize);
+
+	if (front_pad) {
+		gfp_t gfp_mask = nfs_io_gfp_mask();
+
+		dreq->start_extra_bvec = kmalloc(sizeof(struct bio_vec), gfp_mask);
+		if (dreq->start_extra_bvec == NULL)
+			return false;
+		dreq->start_extra_bvec->bv_page = alloc_page(gfp_mask);
+		if (dreq->start_extra_bvec->bv_page == NULL) {
+			kfree(dreq->start_extra_bvec);
+			dreq->start_extra_bvec = NULL;
+			return false;
+		}
+		bvec_set_page(dreq->start_extra_bvec,
+			      dreq->start_extra_bvec->bv_page,
+			      front_pad, PAGE_SIZE - front_pad);
+	}
+
+	dreq->io_start = start;
+	dreq->start_len = front_pad;
+	dreq->middle_offset = offset;
+	dreq->middle_len = middle_end - offset;
+	dreq->end_offset = middle_end;
+	dreq->end_len = orig_end - middle_end;
+
+	dreq->max_count = orig_end - start;
+
+	trace_nfs_analyze_read_dio(offset, len, dreq);
+	return true;
+#else
+	return false;
+#endif
+}
+
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
@@ -439,6 +571,9 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct nfs_lock_context *l_ctx;
 	ssize_t result, requested;
 	size_t count = iov_iter_count(iter);
+	size_t in_count = count;
+	unsigned int front_pad = 0;
+
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, count);
 
 	dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
@@ -456,8 +591,19 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = iocb->ki_pos;
+	if (!swap && nfs_analyze_read_dio(iocb->ki_pos, count, dreq)) {
+		/* note that dreq values do include front_pad
+		 * (dreq->io_start -> dreq->start_extra_bvec->bv_offset)
+		 */
+		iocb->ki_pos = dreq->io_start;
+		count = dreq->max_count;
+		if (dreq->start_extra_bvec)
+			front_pad = dreq->start_extra_bvec->bv_len;
+	} else {
+		dreq->io_start = iocb->ki_pos;
+		dreq->max_count = count;
+	}
+
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
@@ -483,16 +629,24 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		}
 	}
 
-	NFS_I(inode)->read_io += count;
+	NFS_I(inode)->read_io += in_count;
 	requested = nfs_direct_read_schedule_iovec(dreq, iter, iocb->ki_pos);
 
 	if (!swap)
 		nfs_end_io_direct(inode);
 
 	if (requested > 0) {
+		if (front_pad) {
+			/* given the iov_iter_revert below, must exclude the
+			 * front_pad (dreq->start_extra_bvec) from requested,
+			 */
+			requested -= front_pad;
+		}
+
 		result = nfs_direct_wait(dreq);
 		if (result > 0) {
-			requested -= result;
+			if (front_pad && result >= front_pad)
+				result -= front_pad;
 			iocb->ki_pos += result;
 		}
 		iov_iter_revert(iter, requested);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f1015413b85cf..9e1991026a338 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -992,4 +992,12 @@ struct nfs_direct_req {
 	/* for read */
 #define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
 #define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
+
+	/* State for expanding/splitting misaligned IO to be DIO-aligned (for LOCALIO) */
+	struct bio_vec *        start_extra_bvec;
+	loff_t			middle_offset;
+	loff_t			end_offset;
+	ssize_t			start_len;
+	ssize_t			middle_len;
+	ssize_t			end_len;
 };
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4ec66d5e9cc6c..ec4c0f073361a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1598,6 +1598,64 @@ DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
 
+DECLARE_EVENT_CLASS(nfs_analyze_dio_class,
+	TP_PROTO(
+		loff_t offset,
+		ssize_t count,
+		const struct nfs_direct_req *dreq
+	),
+	TP_ARGS(offset, count, dreq),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, fileid)
+		__field(u32, fhandle)
+		__field(loff_t, offset)
+		__field(ssize_t, count)
+		__field(loff_t, start)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
+		__field(loff_t, end)
+		__field(ssize_t, end_len)
+	),
+	TP_fast_assign(
+		const struct inode *inode = dreq->inode;
+		const struct nfs_inode *nfsi = NFS_I(inode);
+		const struct nfs_fh *fh = &nfsi->fh;
+
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->fileid = nfsi->fileid;
+		__entry->fhandle = nfs_fhandle_hash(fh);
+		__entry->offset = offset;
+		__entry->count = count;
+		__entry->start = dreq->io_start;
+		__entry->start_len = dreq->start_len;
+		__entry->middle = dreq->middle_offset;
+		__entry->middle_len = dreq->middle_len;
+		__entry->end = dreq->end_offset;
+		__entry->end_len = dreq->end_len;
+	),
+	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
+		  "offset=%lld count=%zd "
+		  "start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long long)__entry->fileid,
+		  __entry->fhandle, __entry->offset, __entry->count,
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFS_ANALYZE_DIO_EVENT(name)			\
+DEFINE_EVENT(nfs_analyze_dio_class, nfs_analyze_##name##_dio,	\
+	TP_PROTO(loff_t offset,					\
+		 ssize_t count,					\
+		 const struct nfs_direct_req *dreq),		\
+	TP_ARGS(offset, count, dreq))
+
+DEFINE_NFS_ANALYZE_DIO_EVENT(read);
+DEFINE_NFS_ANALYZE_DIO_EVENT(write);
+
 TRACE_EVENT(nfs_fh_to_dentry,
 		TP_PROTO(
 			const struct super_block *sb,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 9ddff27e96e9f..8d877360042d4 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -832,6 +832,7 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 		     int io_flags)
 {
 	desc->pg_moreio = 0;
+	desc->pg_doio_now = 0;
 	desc->pg_inode = inode;
 	desc->pg_ops = pg_ops;
 	desc->pg_completion_ops = compl_ops;
@@ -1141,6 +1142,8 @@ nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
 		return size;
 	nfs_list_move_request(req, &mirror->pg_list);
 	mirror->pg_count += req->wb_bytes;
+	if (desc->pg_doio_now)
+		return 0; /* trigger nfs_pageio_doio() in caller */
 	return req->wb_bytes;
 }
 
@@ -1220,6 +1223,10 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 			nfs_pageio_doio(desc);
 			if (desc->pg_error < 0 || mirror->pg_recoalesce)
 				return 0;
+			if (desc->pg_doio_now) {
+				desc->pg_doio_now = 0;
+				return 1;
+			}
 			/* retry add_request for this subreq */
 			nfs_page_group_lock(req);
 			continue;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff47..2e88dc2ff3fea 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -117,6 +117,7 @@ struct nfs_pageio_descriptor {
 	u32			pg_mirror_idx;	/* current mirror */
 	unsigned short		pg_maxretrans;
 	unsigned char		pg_moreio : 1;
+	unsigned char		pg_doio_now : 1;
 };
 
 /* arbitrarily selected limit to number of mirrors */
-- 
2.44.0


