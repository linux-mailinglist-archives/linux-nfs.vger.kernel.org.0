Return-Path: <linux-nfs+bounces-13443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30770B1BA6E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525AF18A60AF
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5A299AAC;
	Tue,  5 Aug 2025 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Cr5koA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EF25394C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419474; cv=none; b=okqTgA+2ZISBWwrWuAasFIYQxNmDdQQjhZdG4t/TKHKecF38eeylzrSqqVotOb+POWgE4UjBUJA6Hig+M6VpU4OV93/T9gfpa4odBInKU2rnN3OwoaP0KodVYOvPUWQih/f4eS7ZPHGI/qMzqYHsLMtYn+w2dzl9y7m/VXSDVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419474; c=relaxed/simple;
	bh=MzzyjDCERJvZSsA9EQVATKmbVx00Zzt76JR7eKjJ1oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+gzoLyyxa4/XfJ9NpuxYLypfeohOkNobasncIQJier1jWbftt/dlOQL7TvK8QLuwppbbxqZR1Hm+P7/WJ5BTak8cc1seE5Hd6bpHuzaIcgSmk6XwMViluZyZdPFfGySK8XQYaiyuWt8uR251dt6S/qcGpUv6eWJNMiAj3HNfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Cr5koA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81EC4CEF0;
	Tue,  5 Aug 2025 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419473;
	bh=MzzyjDCERJvZSsA9EQVATKmbVx00Zzt76JR7eKjJ1oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4Cr5koAKPCsMZZyykHIqe49Nn31b69qsXJIp0Ns46eeQfHLQ1o14lVG9OcXiJjyM
	 2MbHHcyYE2wCSfIjaTx2vBsLux3vSgZ+sMKHoLeklrM6HY6NZobKzVttcrI01aL27J
	 97AEFWaQJCTJl9BHtMqE0Bu2HdeaW9kZzExiWVHovPUfx3kkL2UGDGHJpB2HPo0YEL
	 L0eoqHHOuXWiOAeb3KYPG8AP0jJSGvNQ9vD366YqMQXp8jlBLm7DiS2lJ4q/91Ti27
	 QjimUvZlc6UI6qWfXb4Py/wEDVjo1bti2xSULkett4gH0RR2Yb+uJ3qw0U9ELmxH6x
	 +m2qprO7JEllw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
Date: Tue,  5 Aug 2025 14:44:27 -0400
Message-ID: <20250805184428.5848-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805184428.5848-1-snitzer@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
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
 fs/nfsd/vfs.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 609b85f8bde3e..0d4f9f452d466 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1342,7 +1342,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1350,6 +1349,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
+	struct iov_iter		iter_stack[1];
+	struct iov_iter		*iter = iter_stack;
+	unsigned int		n_iters = 0;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1379,14 +1381,15 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1400,13 +1403,17 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
-	if (host_err < 0) {
-		commit_reset_write_verifier(nn, rqstp, host_err);
-		goto out_nfserr;
+	*cnt = 0;
+	for (int i = 0; i < n_iters; i++) {
+		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
+		if (host_err < 0) {
+			commit_reset_write_verifier(nn, rqstp, host_err);
+			goto out_nfserr;
+		}
+		*cnt += host_err;
+		nfsd_stats_io_write_add(nn, exp, host_err);
 	}
-	*cnt = host_err;
-	nfsd_stats_io_write_add(nn, exp, *cnt);
+
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
-- 
2.44.0


