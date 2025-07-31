Return-Path: <linux-nfs+bounces-13346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F93AB176BF
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2F81C24885
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B273246793;
	Thu, 31 Jul 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOorJoiU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFD245019
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991093; cv=none; b=n+mBRxeDahsGnZ8x5atF5nVdoTFzVVxbMPWSZTWPmeg4GqTLVssTCVfqqlVRnevERvSbXYvqZha24C1RXWMgeKdLreIXQwC7IPq9PYlkk8xKOi+LHf+2LjgsudvXEDQ/8y60BOtxcZ18ycLVpujGCGT/olc0IncNW+int2MN+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991093; c=relaxed/simple;
	bh=RhU5+Ilsb7ntVQKw6ldTMviDEBQ11kXJ01nSI5kXBiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5x01kXJlzvdCnbcvxVY76qGW9X7Dm7GvJlk7kMslOf09JTui6p+iXb5iE/2nzRzBbYOyU9/pYWPiVauBG/Wb08UmM4Pt/9wSrPQ3kivfc7sh/KaZmfCucRNED0Er6nI9pz0sCcRAwYakDlnT3Zp/zFTz6b4n5aGIACHIiNjJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOorJoiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4999C4CEEF;
	Thu, 31 Jul 2025 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753991093;
	bh=RhU5+Ilsb7ntVQKw6ldTMviDEBQ11kXJ01nSI5kXBiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOorJoiU0sWgI6o/YEeFF1feC02trlh2ushK0Hee2x5FPBSe6Nta/uUapmu+ZH6jg
	 ENv0Xh8hdf7pf4/stFUxJQDBuNK1kit7OPPYX168AKOT2PSasz6FPw2DA2RY9SRKOg
	 76kelbS58LKS3qi7I8dwZXiKpZ49x/ysIMU/KMyXgUdpZ/gde8g1N4xoKsDzTwjdpE
	 ZfkmKQW54HFK4SckqUCXdgL0kevurLMDefti5xTsfAMfH3jkolib5BRQgRYlVL3Yn3
	 PUx0/vNDDCL5KwA/Xl5jMsHl6rgJU4SBpPxJqIzzr/G3aZFWYsKGlFb0iMphbz+zKg
	 ldQB2r2qVyV4w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
Date: Thu, 31 Jul 2025 15:44:46 -0400
Message-ID: <20250731194448.88816-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731194448.88816-1-snitzer@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor nfsd_vfs_write() to support splitting a WRITE into parts
(which will be either misaligned or DIO-aligned).  Doing so in a
preliminary commit just allows for indentation and slight
transformation to be more easily understood and reviewed.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 35c29b8ade9c3..e4855c32dad12 100644
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


