Return-Path: <linux-nfs+bounces-15666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FBC0DDAC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CF4B346CBE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196EE25A33A;
	Mon, 27 Oct 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz6+L0OE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A09259C94
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570518; cv=none; b=UNUXmpct5yL7ZBpyR1X0ox1yW2sqtgh6S7rsMRkRWRDe12aautcyRprC47jKAlYQZYLVGS3AU+EPFgGUgSRBW+Fcl8PqI4zVnZwWllSIbx+9EpUV/mtvKWeMfiqhwKEPUf7qbT8KCfi4hTUo06QFxGzd8v1n+1mpt54uH+M4iTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570518; c=relaxed/simple;
	bh=ZORdBmmNcYFTnNYZYc96AAd7QxcnFlP0iFRA3FrXjec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKyGxkLLxRlAgRvZtjNBGf86JI2tFz9NThFjCY1BG5mH6ekM5KKH/JiPMcvzzgUNBYAKXWZFJw3VE1GKPuPS+CLw5U/pqFHh0fRQdusCPATj8/0j7vOtY2DCkPnSseGjo8OMM14pVaJTFEgfWP5ydceKoCLJohGu9WpDGH1vpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz6+L0OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C76C4CEFF;
	Mon, 27 Oct 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570518;
	bh=ZORdBmmNcYFTnNYZYc96AAd7QxcnFlP0iFRA3FrXjec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kz6+L0OEfVHSEfXalughQVYFrMGYSKNCdWU69kaNWQK+I6Inowyo+PbMLNUZtJdv9
	 wl4KXfRaXngghiT6LyM0p4Xo/mTjiKBUsw08nofS1iWG9qXLcyGiBF37ANhK5oXQXu
	 dqEOLoT9VwGwUutRCT10V2GaZtk2yLbKOde3mCzRwWYeBILr4yq8lg+YVbY35TE0sc
	 op72pUmtMCyRTvHZA8pnKu2fJmm6ldjfVQgxqsTOtKZstlpVU3M9PoY+kJNGBdzrhz
	 KHcsZ9TNbhdBCeUqS3fs6va9NvpDu7kdiv2iMkvBoi1vd3qOVznIloqghGmjg8jBWh
	 elGFKVZ9QCcFQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
Date: Mon, 27 Oct 2025 09:08:33 -0400
Message-ID: <20251027130833.96571-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <aPZ-dIObXH8Z06la@kernel.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misaligned DIO read can be split into 3 IOs, must handle potential for
short read from each component IO (follows same pattern used for
handling partial writes, except upper layer read code handles advancing
offset before retry).

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index a5f1eeeef30e..35e332627168 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -414,7 +414,7 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 	/* Setup misaligned end?
 	 * If so, the end is purposely setup to be issued using buffered IO
 	 * before the middle (which will use DIO, if DIO-aligned, with AIO).
-	 * This creates problems if/when the end results in a partial write.
+	 * This creates problems if/when the end results in short read or write.
 	 * So must save index and length of end to handle this corner case.
 	 */
 	if (local_dio->end_len) {
@@ -580,8 +580,9 @@ static void nfs_local_read_done(struct nfs_local_kiocb *iocb)
 	 */
 	hdr->res.replen = 0;
 
-	if (hdr->res.count != hdr->args.count ||
-	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
+	/* nfs_readpage_result() handles short read */
+
+	if (hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
 		hdr->res.eof = true;
 
 	dprintk("%s: read %ld bytes eof %d.\n", __func__,
@@ -620,6 +621,7 @@ static void nfs_local_call_read(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
+	bool force_done = false;
 	ssize_t status;
 	int n_iters;
 
@@ -637,7 +639,21 @@ static void nfs_local_call_read(struct work_struct *work)
 		iocb->kiocb.ki_pos = iocb->offset[i];
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 		if (status != -EIOCBQUEUED) {
-			if (nfs_local_pgio_done(iocb, status, false)) {
+			if (unlikely(status >= 0 && status < iocb->iters[i].count)) {
+				/* partial read */
+				if (i == iocb->end_iter_index) {
+					/* Must not account DIO partial end, otherwise (due
+					 * to end being issued before middle): the partial
+					 * read accounting in nfs_local_read_done()
+					 * would incorrectly advance hdr->args.offset
+					 */
+					status = 0;
+				} else {
+					/* Partial read at start or middle, force done */
+					force_done = true;
+				}
+			}
+			if (nfs_local_pgio_done(iocb, status, force_done)) {
 				nfs_local_read_iocb_done(iocb);
 				break;
 			}
-- 
2.44.0


