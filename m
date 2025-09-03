Return-Path: <linux-nfs+bounces-14020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CDBB42B53
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CFB16E02E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E92E173E;
	Wed,  3 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdzQorm0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DA292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932690; cv=none; b=uZvvjOfUgTb4lQokTO1aLK+5KXMTgzjq3CI8unpZs03DhUIGuBMHYuGPeni6h2DZ3PzjQnPpPQPngPnXAAjdZ+LakXomx5ChUVCbSIfosGovDVNYuF9lnqjutFI0wpemuqh74BaGZYQmaErATA8eG8+Nl3r8z2gAn++b+109sS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932690; c=relaxed/simple;
	bh=jaPkMToLnssS+q0s1+N82V7iTb362zI4WqgVvvafgJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf+YaMJmmRDQlslby3FfZ6tcw4VgpjH9SjFA7B9zJXh6WENOimTberAosNcWudIfo2fICgPcNn4hQmxPiR15+kkloRoMd851bG7vIqw4G6S8B+gVN+XMq+zCsfJ0x7doPfZrwDodjZ1Nwz7JiInO1nDOeVgWHnm0VZth6R+6UwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdzQorm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461EDC4CEE7;
	Wed,  3 Sep 2025 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932689;
	bh=jaPkMToLnssS+q0s1+N82V7iTb362zI4WqgVvvafgJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdzQorm0AFEToiJXJEFrXoqcprVFq/ECDC1rEGq3JGdAUSC4UdCVOIi6vdySrZfwa
	 OaTZ605of1kALyXM6xw07PN2LBLBhQHMJSH8I+BsfOVcejjTEr3kgdIOW3akvIfz50
	 T1t3AE48rp8XByHwC3YYOICcnArzF77rLE8pFECkz+dznmr/JEgJdq0dQSmjm7CXn3
	 7Rx6wReRi9aG29bh3Txyn5B7yyu83jAv+2vw64oSDaLXvl9dCXoWUXce/bwq7b1dO3
	 nK7pQl604twXJuXqVJWHsmI3lplt+2FQGaT0WDykT1dO3WegsNVfltIzxhA3VPpowF
	 L38P46/5HMuvA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 5/9] NFSD: issue READs using O_DIRECT even if IO is misaligned
Date: Wed,  3 Sep 2025 16:51:17 -0400
Message-ID: <20250903205121.41380-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250903205121.41380-1-snitzer@kernel.org>
References: <20250903205121.41380-1-snitzer@kernel.org>
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

Any misaligned READ that is less than 32K won't be expanded to be
DIO-aligned (this heuristic just avoids excess work, like allocating
start_extra_page, for smaller IO that can generally already perform
well using buffered IO).

Suggested-by: Jeff Layton <jlayton@kernel.org>
Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c              | 184 +++++++++++++++++++++++++++++++++++--
 include/linux/sunrpc/svc.h |   5 +-
 2 files changed, 178 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 358d10a0665f6..96ae86419dc80 100644
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
@@ -1073,6 +1074,137 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+struct nfsd_read_dio {
+	loff_t start;
+	loff_t end;
+	unsigned long start_extra;
+	unsigned long end_extra;
+};
+
+static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
+{
+	memset(read_dio, 0, sizeof(*read_dio));
+}
+
+#define NFSD_READ_DIO_MIN_KB (32 << 10)
+
+static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				  struct nfsd_file *nf, loff_t offset,
+				  unsigned long len, unsigned int base,
+				  struct nfsd_read_dio *read_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
+	loff_t middle_end, orig_end = offset + len;
+
+	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
+		return false;
+	if (unlikely(dio_blocksize > PAGE_SIZE))
+		return false;
+	if (unlikely(len < dio_blocksize))
+		return false;
+
+	/* Return early if IO is irreparably misaligned (base not aligned).
+	 * Ondisk alignment is implied by the following code that expands
+	 * misaligned IO to have a DIO-aligned offset and len.
+	 */
+	if ((base & (nf->nf_dio_mem_align-1)) != 0)
+		return false;
+
+	init_nfsd_read_dio(read_dio);
+
+	read_dio->start = round_down(offset, dio_blocksize);
+	read_dio->end = round_up(orig_end, dio_blocksize);
+	read_dio->start_extra = offset - read_dio->start;
+	read_dio->end_extra = read_dio->end - orig_end;
+
+	/*
+	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
+	 * to be DIO-aligned (this heuristic avoids excess work, for smaller IO
+	 * that can generally already perform well using buffered IO).
+	 */
+	if ((read_dio->start_extra || read_dio->end_extra) &&
+	    (len < NFSD_READ_DIO_MIN_KB)) {
+		init_nfsd_read_dio(read_dio);
+		return false;
+	}
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
+	if (!read_dio->start_extra && !read_dio->end_extra)
+		return host_err;
+
+	/* If nfsd_analyze_read_dio() found start_extra (front-pad) page needed it
+	 * must be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
+	 */
+	if (read_dio->start_extra) {
+		*rq_bvec_numpages -= 1;
+		v = *rq_bvec_numpages;
+		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
+			v * sizeof(struct bio_vec));
+	}
+	/* Eliminate any end_extra bytes from the last page */
+	v = *rq_bvec_numpages;
+	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
+
+	if (host_err < 0) {
+		/* Underlying FS will return -EINVAL if DIO is misaligned. */
+		if (unlikely(host_err == -EINVAL))
+			pr_warn_ratelimited("%s: unexpected host_err=%zd\n",
+					    __func__, host_err);
+		return host_err;
+	}
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
+static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
+		unsigned int addr_mask, unsigned int len_mask)
+{
+	const struct bio_vec *bvec = i->bvec;
+	size_t skip = i->iov_offset;
+	size_t size = i->count;
+
+	if (size & len_mask)
+		return false;
+	do {
+		size_t len = bvec->bv_len;
+
+		if (len > size)
+			len = size;
+		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
+			return false;
+		bvec++;
+		size -= len;
+		skip = 0;
+	} while (size);
+
+	return true;
+}
+
 /**
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
@@ -1094,7 +1226,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		      unsigned int base, u32 *eof)
 {
 	struct file *file = nf->nf_file;
-	unsigned long v, total;
+	unsigned long v, total, in_count = *count;
+	struct nfsd_read_dio read_dio;
 	struct iov_iter iter;
 	struct kiocb kiocb;
 	ssize_t host_err;
@@ -1102,13 +1235,34 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	init_sync_kiocb(&kiocb, file);
 
+	v = 0;
+	total = in_count;
+
 	switch (nfsd_io_cache_read) {
 	case NFSD_IO_DIRECT:
-		/* Verify ondisk and memory DIO alignment */
-		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
-		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
-		    (base & (nf->nf_dio_mem_align - 1)) == 0)
-			kiocb.ki_flags = IOCB_DIRECT;
+		/*
+		 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
+		 * the next DIO-aligned block (on either end of the READ).
+		 */
+		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
+					  in_count, base, &read_dio)) {
+			/* trace_nfsd_read_vector() will reflect larger
+			 * DIO-aligned READ.
+			 */
+			offset = read_dio.start;
+			in_count = read_dio.end - offset;
+			total = in_count;
+
+			kiocb.ki_flags |= IOCB_DIRECT;
+			if (read_dio.start_extra) {
+				len = read_dio.start_extra;
+				bvec_set_page(&rqstp->rq_bvec[v],
+					      *(rqstp->rq_next_page++),
+					      len, PAGE_SIZE - len);
+				total -= len;
+				++v;
+			}
+		}
 		break;
 	case NFSD_IO_DONTCACHE:
 		kiocb.ki_flags = IOCB_DONTCACHE;
@@ -1119,8 +1273,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	kiocb.ki_pos = offset;
 
-	v = 0;
-	total = *count;
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
@@ -1131,9 +1283,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
+
+	if ((kiocb.ki_flags & IOCB_DIRECT) &&
+	    !nfsd_iov_iter_aligned_bvec(&iter, nf->nf_dio_mem_align-1,
+					nf->nf_dio_read_offset_align-1))
+		kiocb.ki_flags &= ~IOCB_DIRECT;
+
 	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
+
+	if (in_count != *count) {
+		/* misaligned DIO expanded read to be DIO-aligned */
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


