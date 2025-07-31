Return-Path: <linux-nfs+bounces-13363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443F8B1793F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 01:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704FD562A2A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EE16F8E9;
	Thu, 31 Jul 2025 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qutaCdFu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DC153598
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003197; cv=none; b=KJwhHDHynG+h2xSQnWcqmNH9cosCKQQf2gtvzUVUibEK9wKSbEA9n1fKn7OlFcNVTifnF9nTXe8D78MUOV9hom4QpdGuODQvyyrNbrO5DKXZDalq4fj8fXRKLpylGVdpv9FDNsD4WOE5SP10zvX6gqYD6DJklapRfx9OFdVAhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003197; c=relaxed/simple;
	bh=eKuEixWDVq9OldXimEYZ3xtWOL3tdlqcS+iZYvaH3VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1jRKvtsvy4e9QtVnJy4B5zKpPzbcVxI5n2D0ULByH8i7gispFvdYmy/8Usfi0Aqx+jmTEjpDsmd70f+o/f+YKCakWBL7i2pdn8gDQc5733F/7b7RWmRvqaPjO5arfy4EqIvB0d6kPAy7FAYmhA64BbquQ+lSe2adEG8ZHMVBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qutaCdFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4A7C4CEF7;
	Thu, 31 Jul 2025 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003197;
	bh=eKuEixWDVq9OldXimEYZ3xtWOL3tdlqcS+iZYvaH3VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qutaCdFuhfF90WntOS8W+zwpcJQaMS1lTyw1fR1x84eaqutAEfARr2YnjexEBXzRc
	 vVXQW7Clk0/vIwEFcBSjWwqvlgO1DKHVgDiNGTFRN9uvGScPeQMuzGeiDpmGvYF5p2
	 xmFrCp9sLZ1H0fqkj5IO9Us4UC9nAxMicoyS8YkvVTna9IT/mg03mKdv7tku8MMfA2
	 ffcNq7UMg+HDZEu/OYnhFu5VCACQITf+jkipWPpvm1T/bLKt1AF/RV9IQ3AgIUjQGI
	 rYCFmHmCakGFg8NfIe6Dg231WNQGFSHjYV/eqqxF3X1xbk1xkukbPn6fpkjVI04dAe
	 fbxDLCIw8jJXg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
Date: Thu, 31 Jul 2025 19:06:31 -0400
Message-ID: <20250731230633.89983-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731230633.89983-1-snitzer@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 35c29b8ade9c3..edac73349da0f 100644
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
@@ -1399,22 +1402,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
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
-
-	if (stable && fhp->fh_use_wgather) {
-		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0)
+	*cnt = 0;
+	for (int i = 0; i < n_iters; i++) {
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


