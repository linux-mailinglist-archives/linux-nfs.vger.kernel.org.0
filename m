Return-Path: <linux-nfs+bounces-15701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BBC0F1A4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F27184EC1CD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848C31A811;
	Mon, 27 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4uv14cQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433331A80E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580002; cv=none; b=GqA1zwKRGPJWx5icg63yvgEMoR4kc4OoPUdAtLPv48f0G+3ZHg3yNjqet2b5whf02Quizigw/CxxNLV4fLx6l9sQdkwN8Hpn2Cx9pw925CemCP76Hd7lKpPllCPzIIVS56ttMvuIsMKNa8c6kZonSGIm+q6iNyKbYCRsffkz6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580002; c=relaxed/simple;
	bh=Q3G76FDbDEtM+Wfnhzjn66xrEejSw+JRfQSosuXvlyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joKb3fGgy1ZPJb8iHyUDljo5sQMQSM+q/bT92BSpYWPK/wgDCNPBzk3Hot8IM5kbc3dWTpItPPa+GsGL8zZ1SgLRadz0I8+n2Wt358ygrq6jWJuu679X66tF11WVYyV/8Mkij6MDHeUMUyV4cN73/QqvbUqknSg0T/47IGjP/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4uv14cQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2A5C4CEF1;
	Mon, 27 Oct 2025 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580002;
	bh=Q3G76FDbDEtM+Wfnhzjn66xrEejSw+JRfQSosuXvlyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4uv14cQT/DXpMXt9O85fFHCX5ci21LiDVPk2JGumPeSoCwffKaYB64+9P7t14rkx
	 iAEebzzTSZRsXLSgOVQZP5ltEoiQnkCaAq7/0Gpamk4gLerdxUhgDxF8CZiDn0Tbc1
	 hVWFM/B4myNnEs9/n/2ZnSx+IbJnzIs56TF7MLo9UGfQULj7iHdLnqkQYnazYe9pWV
	 anZhy57F8TGAr3V19lAXQQDB9RfW57b0RP/U4sZY5haaL1wJumhdBqyQv8C0q2mCNA
	 JCeVkGe17KvlfaIEoLW16rm3cZHykGkLbQFtbDme7aGztjLGGJPbGKgwra5LXjk/Td
	 Kl8lBUvM2qVSw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment for direct I/O
Date: Mon, 27 Oct 2025 11:46:27 -0400
Message-ID: <20251027154630.1774-10-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Currently, nfsd_is_write_dio_possible() only considers file offset
alignment (nf_dio_offset_align) when splitting an NFS WRITE request
into segments. This leaves accounting for memory buffer alignment
(nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
second check fails, the code falls back to cached I/O entirely,
wasting the opportunity to use direct I/O for the bulk of the
request.

Enhance the logic to find a beginning segment size that satisfies
both alignment constraints simultaneously. The search algorithm
starts with the file offset alignment requirement and steps through
multiples of offset_align, checking memory alignment at each step.
The search is bounded by lcm(offset_align, mem_align) to ensure that
it always terminates.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/filecache.c |   5 ++
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/vfs.c       | 119 +++++++++++++++++++++++++++++---------------
 3 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a238b6725008..89adc4ab5b24 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
 #include <linux/nfslocalio.h>
+#include <linux/lcm.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -234,6 +235,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	nf->nf_dio_mem_align = 0;
 	nf->nf_dio_offset_align = 0;
 	nf->nf_dio_read_offset_align = 0;
+	nf->nf_dio_align_lcm = 0;
 	return nf;
 }
 
@@ -1071,6 +1073,9 @@ nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
 	if (stat.result_mask & STATX_DIOALIGN) {
 		nf->nf_dio_mem_align = stat.dio_mem_align;
 		nf->nf_dio_offset_align = stat.dio_offset_align;
+		if (stat.dio_mem_align && stat.dio_offset_align)
+			nf->nf_dio_align_lcm = lcm(stat.dio_mem_align,
+						   stat.dio_offset_align);
 	}
 	if (stat.result_mask & STATX_DIO_READ_ALIGN)
 		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e3d6ca2b6030..2648aaab5a1b 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -58,6 +58,7 @@ struct nfsd_file {
 	u32			nf_dio_mem_align;
 	u32			nf_dio_offset_align;
 	u32			nf_dio_read_offset_align;
+	unsigned long		nf_dio_align_lcm;
 };
 
 int nfsd_file_cache_init(void);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 37353fb48d58..a872be300c9f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1261,49 +1261,73 @@ struct nfsd_write_dio_seg {
 
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
-	size_t				first, middle, last;
 	unsigned int			nsegs;
 	struct nfsd_write_dio_seg	segment[3];
 };
 
+/*
+ * Find the minimum offset within the write request that aligns both
+ * the file offset and memory buffer for direct I/O.
+ *
+ * Returns the size of the unaligned prefix, or SIZE_MAX if no alignment
+ * is possible within reasonable bounds.
+ */
+static size_t
+nfsd_find_dio_aligned_offset(struct nfsd_file *nf, loff_t file_offset,
+			     unsigned long mem_offset, size_t total_len)
+{
+	u32 offset_align = nf->nf_dio_offset_align;
+	u32 mem_align = nf->nf_dio_mem_align;
+	unsigned long search_limit;
+	size_t first;
+
+	/* Start with the file offset alignment requirement */
+	first = round_up(file_offset, offset_align) - file_offset;
+
+	/* Quick check: does this also satisfy memory alignment? */
+	if (((mem_offset + first) & (mem_align - 1)) == 0)
+		return first;
+
+	/*
+	 * Search for a value that satisfies both constraints by stepping
+	 * through multiples of offset_align. Limit search to one period
+	 * of the LCM. We need to check up through the search_limit to
+	 * cover all possible alignments within the LCM period.
+	 */
+	search_limit = min_t(unsigned long, nf->nf_dio_align_lcm, total_len);
+
+	for (; first <= search_limit && first < total_len; first += offset_align) {
+		if (((mem_offset + first) & (mem_align - 1)) == 0)
+			return first;
+	}
+
+	return SIZE_MAX;  /* No alignment found */
+}
+
+/*
+ * Check if the underlying file system implements direct I/O.
+ */
 static bool
 nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 			   struct nfsd_write_dio_args *args)
 {
-	u32 dio_blocksize = args->nf->nf_dio_offset_align;
-	loff_t first_end, orig_end, middle_end;
+	u32 offset_align = args->nf->nf_dio_offset_align;
+	u32 mem_align = args->nf->nf_dio_mem_align;
 
-	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
-		return false;
-	if (unlikely(len < dio_blocksize))
+	if (unlikely(!mem_align || !offset_align))
 		return false;
 
-	first_end = round_up(offset, dio_blocksize);
-	orig_end = offset + len;
-	middle_end = round_down(orig_end, dio_blocksize);
+	/*
+	 * Need enough data to potentially find an aligned segment.
+	 * In the worst case, we might need up to
+	 * lcm(offset_align, mem_align) bytes for the prefix.
+	 */
+	if (unlikely(len < max(offset_align, mem_align)))
+		return false;
 
-	args->first = first_end - offset;
-	args->middle = middle_end - first_end;
-	args->last = orig_end - middle_end;
 	return true;
 }
 
-/*
- * Check if the bvec iterator is aligned for direct I/O.
- *
- * bvecs generated from RPC receive buffers are contiguous: After the first
- * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
- * Therefore, only the first bvec is checked.
- */
-static bool
-nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
-{
-	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
-	const struct bio_vec *bvec = i->bvec;
-
-	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);
-}
-
 static void
 nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 			struct bio_vec *bvec, unsigned int nvecs,
@@ -1318,29 +1342,45 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 
 static bool
 nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
-			   unsigned long total,
+			   loff_t offset, unsigned long total,
 			   struct nfsd_write_dio_args *args)
 {
+	u32 offset_align = args->nf->nf_dio_offset_align;
+	unsigned long mem_offset = bvec->bv_offset;
+	loff_t prefix_end, orig_end, middle_end;
+	size_t prefix, middle, suffix;
+
 	args->nsegs = 0;
 
-	if (args->first) {
+	prefix = nfsd_find_dio_aligned_offset(args->nf, offset, mem_offset,
+					     total);
+	if (prefix == SIZE_MAX)
+		return false;	/* No alignment possible */
+
+	prefix_end = offset + prefix;
+	orig_end = offset + total;
+	middle_end = round_down(orig_end, offset_align);
+
+	middle = middle_end - prefix_end;
+	suffix = orig_end - middle_end;
+
+	if (prefix) {
 		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
-					nvecs, total, 0, args->first);
+					nvecs, total, 0, prefix);
 		++args->nsegs;
 	}
 
+	if (!middle)
+		return false;	/* No aligned region for DIO */
+
 	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
-				total, args->first, args->middle);
-	if (!nfsd_iov_iter_aligned_bvec(args->nf,
-					&args->segment[args->nsegs].iter))
-		return false;	/* no DIO-aligned IO possible */
+				total, prefix, middle);
 	args->segment[args->nsegs].use_dio = true;
 	++args->nsegs;
 
-	if (args->last) {
+	if (suffix) {
 		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
-					nvecs, total, args->first +
-					args->middle, args->last);
+					nvecs, total, prefix + middle, suffix);
 		++args->nsegs;
 	}
 
@@ -1373,7 +1413,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
 	ssize_t host_err;
 	unsigned int i;
 
-	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
+	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
+					*cnt, args))
 		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
 
 	/*
-- 
2.51.0


