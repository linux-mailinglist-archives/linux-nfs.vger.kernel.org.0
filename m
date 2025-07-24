Return-Path: <linux-nfs+bounces-13241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C534B111C9
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698011D000DB
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3D22AE5D;
	Thu, 24 Jul 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ralhbNEc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985921B192
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385481; cv=none; b=t4YPihm9VDWL0hnT17m8AOs6WgWqESgkEyGVkJwb6/1yTPVZGYT5Z9KJLMwNMFXG0WESNfWdAu/FbHnPVsp0UA7YC+usy4F8S/0CMbEm0N4o4s/f4RrjnFkrmWX9XqsgSnpFn5+FLl38pRBpyvD2OBez666e5VTMDlW3TbZ6Fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385481; c=relaxed/simple;
	bh=ZbcxnqLmV16TLi7tfISJO4shEnGMU08uCZZyrXcfruk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zva32eqLYBKu/gPpfPqSGFR4A3ko4Ec7q8aOSKJEWC/xI3/tRyU7toLYZciPIVhiSnFzeTFOarlN+UdTrlHGo34V4Y9pzkqNpmAWznyoRnqS/KWarwXaJREj4QU/OtYouUB+tb/WLw8uTVc6hAbFDAzkGSmeutoeQym6mEJuaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ralhbNEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F8FC4CEED;
	Thu, 24 Jul 2025 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385480;
	bh=ZbcxnqLmV16TLi7tfISJO4shEnGMU08uCZZyrXcfruk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ralhbNEcvYL3xkPsnsFn4IABXRiRXVVDEh3yMZ1eeawkeSo41U/XF1GXBHmFd984W
	 oVUcdGaUf7zroy92UGhQyU0868/Bb3MLL7ZUWkk7wckgkpgKjh8YyVqrHYlDrcALPH
	 wwRCzXqTXhIsiJ+2IhCDUvlV6fHjknv3yWxbfHmRjD2cvzVPAGCE7OFxoWyGvozafA
	 bMvM3NPD7wLQPSMF/sHdiIeleFbEDjIAG/CAuFnYiRFZv1DDgkD79BMwK0LeQi120I
	 9r+MeDWmbsxq5uzi59xkpDSb0759dKJjBdqbcwaH90lBWBbF3yCPO6g/t/IAC8Edgv
	 HVap9b0ZJdplA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 12/13] nfs/direct: add misaligned READ handling
Date: Thu, 24 Jul 2025 15:31:01 -0400
Message-ID: <20250724193102.65111-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
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

Also add an nfs_analyze_dio trace event that shows how the NFS client
split a given misaligned IO into a mix of misaligned page(s) and a
DIO-aligned extent.

This combination of trace events is useful for LOCALIO READs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

Which for this dd command:

  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

Results in:

              dd-63258   [002] ..... 83742.428577: nfs_analyze_dio: READ offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
              dd-63258   [002] ..... 83742.428591: nfs_initiate_read: fileid=00:2e:219750 fhandle=0xf6927a01 offset=0 count=45056
  kworker/u193:3-62985   [011] ..... 83742.428594: xfs_file_direct_read: dev 259:22 ino 0x5e0000a3 disize 0x16f40 pos 0x0 bytecount 0xb000
              dd-63258   [002] ..... 83742.428595: nfs_initiate_read: fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=1952
  kworker/u193:4-63221   [004] ..... 83742.428598: nfs_readpage_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=1952 res=1952
  kworker/u193:4-63221   [004] ..... 83742.428613: nfs_readpage_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=0 count=45056 res=45056

              dd-63258   [002] ..... 83742.428619: nfs_analyze_dio: READ offset=47008 len=47008 start=45056+1952 middle=47008+43104 end=90112+3904
              dd-63258   [002] ..... 83742.428622: nfs_initiate_read: fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=45056
              dd-63258   [002] ..... 83742.428624: nfs_initiate_read: fileid=00:2e:219750 fhandle=0xf6927a01 offset=90112 count=3904
  kworker/u193:4-63221   [004] ..... 83742.428624: xfs_file_direct_read: dev 259:22 ino 0x5e0000a3 disize 0x16f40 pos 0xb000 bytecount 0xb000
  kworker/u193:3-62985   [011] ..... 83742.428628: nfs_readpage_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=90112 count=3904 res=3904 eof
  kworker/u193:3-62985   [011] ..... 83742.428642: nfs_readpage_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=45056 res=45056

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c          | 178 ++++++++++++++++++++++++++++++++++++---
 fs/nfs/internal.h        |   7 ++
 fs/nfs/nfstrace.h        |  41 +++++++++
 fs/nfs/pagelist.c        |   7 ++
 include/linux/nfs_page.h |   1 +
 5 files changed, 223 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 48d89716193a..4e1e668eaa1f 100644
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
@@ -409,6 +479,70 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	return requested_bytes;
 }
 
+/*
+ * If localio_O_DIRECT_align_misaligned_READ enabled, expand any
+ * misaligned READ to include the previous DIO-aligned block.
+ * - FIXME: expanding the end to also be DIO-aligned requires a
+ *   bounce page that must be copied to original partial end page.
+ */
+static bool nfs_analyze_read_dio(loff_t offset, __u32 len,
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
+
+		bvec_set_page(dreq->start_extra_bvec,
+			      dreq->start_extra_bvec->bv_page,
+			      front_pad, PAGE_SIZE - front_pad);
+	}
+
+	dreq->middle_offset = offset;
+	dreq->middle_len = middle_end - offset;
+	dreq->end_offset = middle_end;
+	dreq->end_len = orig_end - middle_end;
+
+	dreq->io_start = start;
+	dreq->max_count = orig_end - start;
+
+	trace_nfs_analyze_dio(READ, offset, len, start, front_pad,
+			      dreq->middle_offset, dreq->middle_len,
+			      dreq->end_offset, dreq->end_len);
+	return true;
+#else
+	return false;
+#endif
+}
+
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
@@ -439,6 +573,9 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct nfs_lock_context *l_ctx;
 	ssize_t result, requested;
 	size_t count = iov_iter_count(iter);
+	size_t in_count = count;
+	unsigned int front_pad = 0;
+
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, count);
 
 	dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
@@ -455,9 +592,20 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (dreq == NULL)
 		goto out;
 
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
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = iocb->ki_pos;
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
@@ -483,16 +631,24 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
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
index f54030684c97..06a15bf08357 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -990,4 +990,11 @@ struct nfs_direct_req {
 	/* for read */
 #define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
 #define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
+
+	/* State for expanding misaligned IO to be DIO-aligned (for LOCALIO) */
+	struct bio_vec *        start_extra_bvec;
+	loff_t			middle_offset;	/* Offset for start of DIO-aligned middle */
+	loff_t			end_offset;	/* Offset for start of DIO-aligned end */
+	ssize_t			middle_len;	/* Length for DIO-aligned middle */
+	ssize_t			end_len;	/* Length for misaligned last page */
 };
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 334e65d6bc72..a0b9af10a744 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1593,6 +1593,47 @@ DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
 
+TRACE_EVENT(nfs_analyze_dio,
+	TP_PROTO(u32		rw,
+		 u64		offset,
+		 u32		len,
+		 loff_t         start,
+		 loff_t         start_extra,
+		 loff_t		middle,
+		 loff_t		middle_len,
+		 loff_t         end,
+		 loff_t         end_len),
+	TP_ARGS(rw, offset, len, start, start_extra, middle, middle_len, end, end_len),
+	TP_STRUCT__entry(
+		__field(u32, rw)
+		__field(u64, offset)
+		__field(u32, len)
+		__field(loff_t, start)
+		__field(loff_t, start_extra)
+		__field(loff_t, middle)
+		__field(loff_t, middle_len)
+		__field(loff_t, end)
+		__field(loff_t, end_len)
+	),
+	TP_fast_assign(
+		__entry->rw = rw;
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->start = start;
+		__entry->start_extra = start_extra;
+		__entry->middle = middle;
+		__entry->middle_len = middle_len;
+		__entry->end = end;
+		__entry->end_len = end_len;
+	),
+	TP_printk("%s offset=%llu len=%u start=%llu+%llu middle=%llu+%llu end=%llu+%llu",
+		  __entry->rw ? "WRITE" : "READ",
+		  __entry->offset, __entry->len,
+		  __entry->start, __entry->start_extra,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+);
+
 TRACE_EVENT(nfs_fh_to_dentry,
 		TP_PROTO(
 			const struct super_block *sb,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 9ddff27e96e9..8d877360042d 100644
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
index 169b4ae30ff4..2e88dc2ff3fe 100644
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


