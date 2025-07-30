Return-Path: <linux-nfs+bounces-13327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9541B1692E
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 01:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA17518C72D5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF004230BEB;
	Wed, 30 Jul 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTklCw55"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EB376
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916729; cv=none; b=qgGbgtAcutd1Sf9wSwVqiBjy1UQ2fgWvZ4Xc/Ffgj6/9gndOb7KJk5TYa06a7VU4nFrtaLJ0pBYLRhns2M3fLGmeBxps8jNtN1OA51n5aFvgsLL2TJURWu9dTYWkoWtSPF4RXohXhj6caOA5DfAcjcybGDApyiVRX7ho/v5gVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916729; c=relaxed/simple;
	bh=miWE5Pg3E6rsaUt4ciR2VL+x0LjH2jA2R79EmMxelEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apmJ+q/BjdYCntscPEQp5OcgGomhQksPuuhBNl5af4/7xVuhvKJ94TM5IZWHPDDnW7jy+V7jQnz84a1K8WGnd6VTU1yA/8bhUpeb69pRZBa0hJBUqjWpvFfSdKQUziFdUQHo7ymRFRuay1/eGM3893BnzyAezJfN/CNQp4S/HfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTklCw55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE0C4CEE3;
	Wed, 30 Jul 2025 23:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916729;
	bh=miWE5Pg3E6rsaUt4ciR2VL+x0LjH2jA2R79EmMxelEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTklCw55m2zIH1+mtdtGCGL61pO4Fxg4WKpEmJDTGhB7vU+wsyjjYZpEDN2GTKQgx
	 OEtUcf+0+7DN0ynJ+nIrh4lUcDppBZ2wzhmcG7QdokOzqX40FvLBP7s7zfGRR3/Fhm
	 /UpMm47ifBAG75TFhLm+KsNQbcVD1I5gKppE6uQ8CF9f9y2vIkfpx7h2JQ4fiwLjOz
	 fbH54zoN+nGAWnPrladkxcyn7KX1mVFEFzTGu/SkvDIT3yRI1ZWoLu6ymZi0f2QLrm
	 eDIYbe8Lg80HedNMfEjLFcTE3UW8EboaG6GOf6cX+Oc8jwqIUqzOFGj5SNiGmW81ZR
	 bDXBRcGtKznxQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
Date: Wed, 30 Jul 2025 19:05:23 -0400
Message-ID: <20250730230524.84976-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250730230524.84976-1-snitzer@kernel.org>
References: <20250730230524.84976-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Refactor nfsd_vfs_write() to support splitting a WRITE into parts
(which will be either misaligned or DIO-aligned).  Doing so in a
preliminary commit just allows for indentation and slight
transformation to be more easily understood and reviewed.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/vfs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0863350c4259..72fd0a11ffa3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1341,7 +1341,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1349,6 +1348,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
+	struct iov_iter		iter_stack[1];
+	struct iov_iter		*iter = iter_stack;
+	unsigned int		n_iters = 0;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1378,14 +1380,15 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb.ki_flags |= IOCB_DSYNC;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+	n_iters++;
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
 		/* direct I/O must be aligned to device logical sector size */
 		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
 		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
-		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
+		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
 					nf->nf_dio_offset_align - 1))
 			kiocb.ki_flags = IOCB_DIRECT;
 		break;
@@ -1396,25 +1399,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		break;
 	}
 
-	since = READ_ONCE(file->f_wb_err);
-	if (verf)
-		nfsd_copy_write_verifier(verf, nn);
-	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
-	if (host_err < 0) {
-		commit_reset_write_verifier(nn, rqstp, host_err);
-		goto out_nfserr;
-	}
-	*cnt = host_err;
-	nfsd_stats_io_write_add(nn, exp, *cnt);
-	fsnotify_modify(file);
-	host_err = filemap_check_wb_err(file->f_mapping, since);
-	if (host_err < 0)
-		goto out_nfserr;
+	*cnt = 0;
+	for (int i = 0; i < n_iters; i++) {
+		since = READ_ONCE(file->f_wb_err);
+		if (verf)
+			nfsd_copy_write_verifier(verf, nn);
 
-	if (stable && fhp->fh_use_wgather) {
-		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0)
+		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
+		if (host_err < 0) {
 			commit_reset_write_verifier(nn, rqstp, host_err);
+			goto out_nfserr;
+		}
+		*cnt += host_err;
+		nfsd_stats_io_write_add(nn, exp, host_err);
+
+		fsnotify_modify(file);
+		host_err = filemap_check_wb_err(file->f_mapping, since);
+		if (host_err < 0)
+			goto out_nfserr;
+
+		if (stable && fhp->fh_use_wgather) {
+			host_err = wait_for_concurrent_writes(file);
+			if (host_err < 0) {
+				commit_reset_write_verifier(nn, rqstp, host_err);
+				goto out_nfserr;
+			}
+		}
 	}
 
 out_nfserr:
-- 
2.44.0


