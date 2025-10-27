Return-Path: <linux-nfs+bounces-15665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B93C0DE28
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4997E1897E21
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50DE258ECF;
	Mon, 27 Oct 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKfhlE5m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90531258CE7
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570518; cv=none; b=IwZSHBYOgSzW/fJblagogEYTWDYP/wXlyp6jIzHK0PvigUA7rbC0cn157VGwxJL5jJRBE/9eA5nh4SvNiuxB2yz7dGD+kzTGTZR5QOE8QC/O/leQQqgzktBCg2OjQKzSegUaEA7ouniNiR/TK/N58Ssg51Ex6ZVtpC9vzWE9bZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570518; c=relaxed/simple;
	bh=A2yOU4ADixxfVgA+2FG6uSQEiX4JLsUIGrBQKTrSWIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fViEnYmkdSjJBFak82Vos8q0MLiIpb98GG2lp2lckto295LAzqIHCKQoE8QFTXiv3klOl6kqjggOPGorwmoHZ6JqQ4sXn/wz6HentZiPtDmogmTZu/wSsoI5tl8BJWh7BCr8JOdHyT5nzHdF4JTIv0q6DyjB+Amk4sS18/EZ7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKfhlE5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF366C4CEF1;
	Mon, 27 Oct 2025 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570517;
	bh=A2yOU4ADixxfVgA+2FG6uSQEiX4JLsUIGrBQKTrSWIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKfhlE5mZS/GpYKm7slzkJAAM3+HpNkoDwhvbHawZCcDVAQDw4zRI+Fy1PlHP0IK7
	 wgGw1Dg3mIIgcAGOqTrJHYXKdh+fXTSbG19unPwhmOPwoC33m5PqPhqdKiLprVZrzQ
	 soaKH6yZtWNKePbVBjt/qN1HnZihXiUEoA5tPPDaAZ6NBj3Amn2BBLIGKNVRvwJbkf
	 wD6vQ3IIjKa+lnibOo7VkClSos15C5RTJajEyW/FC6LbefUdW+u9qfIk8WdArc5vs/
	 ggcHKMiNEr+uJX/rsYFHl3wA8A7ZSm0pZ6pqXk8BApTDzDBWkvcfrJ6/Zquoxot8D2
	 vLUuXnkZAIQRg==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
Date: Mon, 27 Oct 2025 09:08:32 -0400
Message-ID: <20251027130833.96571-3-snitzer@kernel.org>
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

Improve completion handling of as many as 3 IOs associated with each
misaligned DIO by using a atomic_t to track completion of each IO.

Update nfs_local_pgio_done() to use precise atomic_t accounting for
remaining iov_iter (up to 3) associated with each iocb, so that each
NFS LOCALIO pgio header is only released after all IOs have completed.
But also allow early return if/when a short read or write occurs.

Fixes reported BUG: KASAN: slab-use-after-free in nfs_local_call_read:
https://lore.kernel.org/linux-nfs/aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com/

Reported-by: Yongcheng Yang <yoyang@redhat.com>
Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 114 ++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 45 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 7c97055bddb1..a5f1eeeef30e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -42,7 +42,7 @@ struct nfs_local_kiocb {
 	/* Begin mostly DIO-specific members */
 	size_t                  end_len;
 	short int		end_iter_index;
-	short int		n_iters;
+	atomic_t		n_iters;
 	bool			iter_is_dio_aligned[NFSLOCAL_MAX_IOS];
 	loff_t                  offset[NFSLOCAL_MAX_IOS] ____cacheline_aligned;
 	struct iov_iter		iters[NFSLOCAL_MAX_IOS];
@@ -407,6 +407,7 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 		iters[n_iters].count = local_dio->start_len;
 		iocb->offset[n_iters] = iocb->hdr->args.offset;
 		iocb->iter_is_dio_aligned[n_iters] = false;
+		atomic_inc(&iocb->n_iters);
 		++n_iters;
 	}
 
@@ -425,6 +426,7 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 		/* Save index and length of end */
 		iocb->end_iter_index = n_iters;
 		iocb->end_len = local_dio->end_len;
+		atomic_inc(&iocb->n_iters);
 		++n_iters;
 	}
 
@@ -448,7 +450,6 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 	}
 	++n_iters;
 
-	iocb->n_iters = n_iters;
 	return n_iters;
 }
 
@@ -474,6 +475,12 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	}
 	len = hdr->args.count - total;
 
+	/*
+	 * For each iocb, iocb->n_iter is always at least 1 and we always
+	 * end io after first nfs_local_pgio_done call unless misaligned DIO.
+	 */
+	atomic_set(&iocb->n_iters, 1);
+
 	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
 		struct nfs_local_dio local_dio;
 
@@ -486,7 +493,6 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	iocb->offset[0] = hdr->args.offset;
 	iov_iter_bvec(&iocb->iters[0], rw, iocb->bvec, v, len);
 	iocb->iter_is_dio_aligned[0] = false;
-	iocb->n_iters = 1;
 }
 
 static void
@@ -506,9 +512,11 @@ nfs_local_pgio_init(struct nfs_pgio_header *hdr,
 		hdr->task.tk_start = ktime_get();
 }
 
-static void
-nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
+static bool
+nfs_local_pgio_done(struct nfs_local_kiocb *iocb, long status, bool force)
 {
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
 	/* Must handle partial completions */
 	if (status >= 0) {
 		hdr->res.count += status;
@@ -519,6 +527,12 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 		hdr->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		hdr->task.tk_status = status;
 	}
+
+	if (force)
+		return true;
+
+	BUG_ON(atomic_read(&iocb->n_iters) <= 0);
+	return atomic_dec_and_test(&iocb->n_iters);
 }
 
 static void
@@ -549,11 +563,11 @@ static inline void nfs_local_pgio_aio_complete(struct nfs_local_kiocb *iocb)
 	queue_work(nfsiod_workqueue, &iocb->work);
 }
 
-static void
-nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
+static void nfs_local_read_done(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct file *filp = iocb->kiocb.ki_filp;
+	long status = hdr->task.tk_status;
 
 	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status == -EINVAL) {
 		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
@@ -574,12 +588,18 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 			status > 0 ? status : 0, hdr->res.eof);
 }
 
+static inline void nfs_local_read_iocb_done(struct nfs_local_kiocb *iocb)
+{
+	nfs_local_read_done(iocb);
+	nfs_local_pgio_release(iocb);
+}
+
 static void nfs_local_read_aio_complete_work(struct work_struct *work)
 {
 	struct nfs_local_kiocb *iocb =
 		container_of(work, struct nfs_local_kiocb, work);
 
-	nfs_local_pgio_release(iocb);
+	nfs_local_read_iocb_done(iocb);
 }
 
 static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
@@ -587,8 +607,10 @@ static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
 	struct nfs_local_kiocb *iocb =
 		container_of(kiocb, struct nfs_local_kiocb, kiocb);
 
-	nfs_local_pgio_done(iocb->hdr, ret);
-	nfs_local_read_done(iocb, ret);
+	/* AIO completion of DIO read should always be last to complete */
+	if (unlikely(!nfs_local_pgio_done(iocb, ret, false)))
+		return;
+
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
 }
 
@@ -599,10 +621,13 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
 	ssize_t status;
+	int n_iters;
 
 	save_cred = override_creds(filp->f_cred);
 
-	for (int i = 0; i < iocb->n_iters ; i++) {
+	n_iters = atomic_read(&iocb->n_iters);
+	for (int i = 0; i < n_iters ; i++) {
+		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
@@ -612,18 +637,14 @@ static void nfs_local_call_read(struct work_struct *work)
 		iocb->kiocb.ki_pos = iocb->offset[i];
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 		if (status != -EIOCBQUEUED) {
-			nfs_local_pgio_done(iocb->hdr, status);
-			if (iocb->hdr->task.tk_status)
+			if (nfs_local_pgio_done(iocb, status, false)) {
+				nfs_local_read_iocb_done(iocb);
 				break;
+			}
 		}
 	}
 
 	revert_creds(save_cred);
-
-	if (status != -EIOCBQUEUED) {
-		nfs_local_read_done(iocb, status);
-		nfs_local_pgio_release(iocb);
-	}
 }
 
 static int
@@ -738,11 +759,10 @@ static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
 	fattr->du.nfs3.used = stat.blocks << 9;
 }
 
-static void
-nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
+static void nfs_local_write_done(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
-	struct inode *inode = hdr->inode;
+	long status = hdr->task.tk_status;
 
 	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
 
@@ -761,28 +781,36 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
 		status = -ENOSPC;
 		/* record -ENOSPC in terms of nfs_local_pgio_done */
-		nfs_local_pgio_done(hdr, status);
+		(void) nfs_local_pgio_done(iocb, status, true);
 	}
 	if (hdr->task.tk_status < 0)
-		nfs_reset_boot_verifier(inode);
+		nfs_reset_boot_verifier(hdr->inode);
 }
 
-static void nfs_local_write_aio_complete_work(struct work_struct *work)
+static inline void nfs_local_write_iocb_done(struct nfs_local_kiocb *iocb)
 {
-	struct nfs_local_kiocb *iocb =
-		container_of(work, struct nfs_local_kiocb, work);
-
+	nfs_local_write_done(iocb);
 	nfs_local_vfs_getattr(iocb);
 	nfs_local_pgio_release(iocb);
 }
 
+static void nfs_local_write_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+
+	nfs_local_write_iocb_done(iocb);
+}
+
 static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 {
 	struct nfs_local_kiocb *iocb =
 		container_of(kiocb, struct nfs_local_kiocb, kiocb);
 
-	nfs_local_pgio_done(iocb->hdr, ret);
-	nfs_local_write_done(iocb, ret);
+	/* AIO completion of DIO write should always be last to complete */
+	if (unlikely(!nfs_local_pgio_done(iocb, ret, false)))
+		return;
+
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
 }
 
@@ -793,13 +821,17 @@ static void nfs_local_call_write(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
 	const struct cred *save_cred;
+	bool force_done = false;
 	ssize_t status;
+	int n_iters;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	save_cred = override_creds(filp->f_cred);
 
 	file_start_write(filp);
-	for (int i = 0; i < iocb->n_iters ; i++) {
+	n_iters = atomic_read(&iocb->n_iters);
+	for (int i = 0; i < n_iters ; i++) {
+		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
@@ -812,35 +844,27 @@ static void nfs_local_call_write(struct work_struct *work)
 			if (unlikely(status >= 0 && status < iocb->iters[i].count)) {
 				/* partial write */
 				if (i == iocb->end_iter_index) {
-					/* Must not account partial end, otherwise, due
-					 * to end being issued before middle: the partial
+					/* Must not account DIO partial end, otherwise (due
+					 * to end being issued before middle): the partial
 					 * write accounting in nfs_local_write_done()
 					 * would incorrectly advance hdr->args.offset
 					 */
 					status = 0;
 				} else {
-					/* Partial write at start or buffered middle,
-					 * exit early.
-					 */
-					nfs_local_pgio_done(iocb->hdr, status);
-					break;
+					/* Partial write at start or middle, force done */
+					force_done = true;
 				}
 			}
-			nfs_local_pgio_done(iocb->hdr, status);
-			if (iocb->hdr->task.tk_status)
+			if (nfs_local_pgio_done(iocb, status, force_done)) {
+				nfs_local_write_iocb_done(iocb);
 				break;
+			}
 		}
 	}
 	file_end_write(filp);
 
 	revert_creds(save_cred);
 	current->flags = old_flags;
-
-	if (status != -EIOCBQUEUED) {
-		nfs_local_write_done(iocb, status);
-		nfs_local_vfs_getattr(iocb);
-		nfs_local_pgio_release(iocb);
-	}
 }
 
 static int
-- 
2.44.0


