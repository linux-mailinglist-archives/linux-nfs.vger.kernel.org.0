Return-Path: <linux-nfs+bounces-14021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58926B42B52
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056CC1A86B8A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015392E426A;
	Wed,  3 Sep 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bif7NCLq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0E292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932690; cv=none; b=BjQEye6Njf0wMVKxOfMRlwIbG5mUNIKRuHsa8cnv0StOdnS3CdC6iP87TugAxeXqhMU0dAeabDtjiEtCqate3VMwhBr7VpEE0UH24cMAF8/fSC236bayt7HjwTqlVykWEzoiGPwTQQlXLvjfQrLyek4BUkHVycKq2oL/zpf5fIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932690; c=relaxed/simple;
	bh=L7FHtSpJ1ikwJgr4xHWiwLuS2W5TFDBuIkaqL2dSXd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjzbeCXFSgSF6FgClbhHTe7oToWKu4EfpdTgo2+KnnKcWAHg5N4FVQtLJXsM4qEGy+x7DWKEPxvxn0GH7TUNUHznBJC/PMEgnJms5q9SuSJ3PuRsi1+tG10MAymiD6YrPAVMMxfkQbkjDBXhrG+3VcNOqNkuH0lkYTlk7rqWb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bif7NCLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A7BC4CEF4;
	Wed,  3 Sep 2025 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932690;
	bh=L7FHtSpJ1ikwJgr4xHWiwLuS2W5TFDBuIkaqL2dSXd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bif7NCLqL6UByrbh1MZ2LP/f3wl7EX91gAgDXJdOhyHlybUwVN1ocTxJF/2fBDMGU
	 L6VZNdApXYJm8+YYd8Q9WyZ8J5zE0QIMc+vAOQQN4yonVQUJAA1/sICSenpd6AzTbT
	 sVTR/A2LTw7nlGNc8KfCPx6gPh/VZg6ZeAPJtHFefpgNawlsoOFKc5+1ck0eKEwjFu
	 OYGQAJ7IORvdD8vKqOe/PF8AmaKpVwc56CSaDpp1lZKaL8NDTpQ0LLrzCcEW5p4NR6
	 CTdAAhxADhv++WuEMN4e6DmANXNYcVKFjQ11wEJSb5//srHBaKSMq6GPY0P+8UokxW
	 +jvyxYQx52qqg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 6/9] NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
Date: Wed,  3 Sep 2025 16:51:18 -0400
Message-ID: <20250903205121.41380-7-snitzer@kernel.org>
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

If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
middle and end as needed. The large middle extent is DIO-aligned and
the start and/or end are misaligned. Buffered IO is used for the
misaligned extents and O_DIRECT is used for the middle DIO-aligned
extent.

If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
invalidate the page cache on behalf of the DIO WRITE, then
nfsd_issue_write_dio() will fall back to using buffered IO.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 183 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 96ae86419dc80..c163afe13ab35 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1338,6 +1338,183 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+struct nfsd_write_dio {
+	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
+	loff_t end_offset;	/* Offset for start of DIO-aligned end */
+	ssize_t	start_len;	/* Length for misaligned first extent */
+	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
+	ssize_t	end_len;	/* Length for misaligned last extent */
+};
+
+static bool
+nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		       struct nfsd_file *nf, loff_t offset,
+		       unsigned long len, struct nfsd_write_dio *write_dio)
+{
+	const u32 dio_blocksize = nf->nf_dio_offset_align;
+	loff_t orig_end, middle_end, start_end, start_offset = offset;
+	ssize_t start_len = len;
+
+	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
+		return false;
+	if (unlikely(dio_blocksize > PAGE_SIZE))
+		return false;
+	if (unlikely(len < dio_blocksize))
+		return false;
+
+	memset(write_dio, 0, sizeof(*write_dio));
+
+	if (((offset | len) & (dio_blocksize-1)) == 0) {
+		/* already DIO-aligned, no misaligned head or tail */
+		write_dio->middle_offset = offset;
+		write_dio->middle_len = len;
+		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
+		start_offset = 0;
+		start_len = 0;
+		return true;
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
+
+	return true;
+}
+
+/*
+ * Setup as many as 3 iov_iter based on extents described by @write_dio.
+ * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
+ * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
+ * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
+ * @nvecs: number of segments in @rq_bvec
+ * @cnt: size of the request in bytes
+ * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
+ *
+ * Returns the number of iov_iter that were setup.
+ */
+static int
+nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
+			   struct bio_vec *rq_bvec, unsigned int nvecs,
+			   unsigned long cnt, struct nfsd_write_dio *write_dio)
+{
+	int n_iters = 0;
+	struct iov_iter *iters = *iterp;
+
+	/* Setup misaligned start? */
+	if (write_dio->start_len) {
+		iter_is_dio_aligned[n_iters] = false;
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iters[n_iters].count = write_dio->start_len;
+		++n_iters;
+	}
+
+	/* Setup DIO-aligned middle */
+	iter_is_dio_aligned[n_iters] = true;
+	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+	if (write_dio->start_len)
+		iov_iter_advance(&iters[n_iters], write_dio->start_len);
+	iters[n_iters].count -= write_dio->end_len;
+	++n_iters;
+
+	/* Setup misaligned end? */
+	if (write_dio->end_len) {
+		iter_is_dio_aligned[n_iters] = false;
+		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
+		iov_iter_advance(&iters[n_iters],
+				 write_dio->start_len + write_dio->middle_len);
+		++n_iters;
+	}
+
+	return n_iters;
+}
+
+static int
+nfsd_issue_write_buffered(struct svc_rqst *rqstp, struct file *file,
+			  unsigned int nvecs, unsigned long *cnt,
+			  struct kiocb *kiocb)
+{
+	struct iov_iter iter;
+	int host_err;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
+	if (host_err < 0)
+		return host_err;
+	*cnt = host_err;
+
+	return 0;
+}
+
+static noinline int
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct nfsd_file *nf, loff_t offset,
+		     unsigned int nvecs, unsigned long *cnt,
+		     struct kiocb *kiocb)
+{
+	struct nfsd_write_dio write_dio;
+	struct file *file = nf->nf_file;
+
+	/* Any buffered IO issued here will be misaligned, use
+	 * IOCB_SYNC to ensure it has completed before returning.
+	 */
+	kiocb->ki_flags |= IOCB_SYNC;
+
+	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset, *cnt, &write_dio))
+		return nfsd_issue_write_buffered(rqstp, file, nvecs, cnt, kiocb);
+	else {
+		bool iter_is_dio_aligned[3];
+		struct iov_iter iter_stack[3];
+		struct iov_iter *iter = iter_stack;
+		unsigned int n_iters = 0;
+		unsigned long in_count = *cnt;
+		loff_t in_offset = kiocb->ki_pos;
+		ssize_t host_err;
+
+		n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
+				rqstp->rq_bvec, nvecs, *cnt, &write_dio);
+		*cnt = 0;
+		for (int i = 0; i < n_iters; i++) {
+			if (iter_is_dio_aligned[i] &&
+			    nfsd_iov_iter_aligned_bvec(&iter[i], nf->nf_dio_mem_align-1,
+						       nf->nf_dio_offset_align-1))
+				kiocb->ki_flags |= IOCB_DIRECT;
+			else
+				kiocb->ki_flags &= ~IOCB_DIRECT;
+
+			host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
+			if (host_err < 0) {
+				/* VFS will return -ENOTBLK if DIO WRITE fails to
+				 * invalidate the page cache. Retry using buffered IO.
+				 */
+				if (unlikely(host_err == -ENOTBLK)) {
+					kiocb->ki_flags &= ~IOCB_DIRECT;
+					*cnt = in_count;
+					kiocb->ki_pos = in_offset;
+					return nfsd_issue_write_buffered(rqstp, file,
+									 nvecs, cnt, kiocb);
+				}
+				/* Underlying FS will return -EINVAL if DIO is misaligned. */
+				if (unlikely(host_err == -EINVAL))
+					pr_warn_ratelimited("%s: unexpected host_err=%zd\n",
+							    __func__, host_err);
+				return host_err;
+			}
+			*cnt += host_err;
+			if (host_err < iter[i].count) /* partial write? */
+				return *cnt;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1365,7 +1542,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1402,30 +1578,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb.ki_flags |= IOCB_DSYNC;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
-		/* direct I/O must be aligned to device logical sector size */
-		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
-		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0))
-			kiocb.ki_flags |= IOCB_DIRECT;
+		host_err = nfsd_issue_write_dio(rqstp, fhp, nf, offset,
+						nvecs, cnt, &kiocb);
 		break;
 	case NFSD_IO_DONTCACHE:
 		kiocb.ki_flags |= IOCB_DONTCACHE;
-		break;
+		fallthrough; /* must call nfsd_issue_write_buffered */
 	case NFSD_IO_BUFFERED:
+		host_err = nfsd_issue_write_buffered(rqstp, file,
+						nvecs, cnt, &kiocb);
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
2.44.0


