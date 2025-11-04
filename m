Return-Path: <linux-nfs+bounces-16024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C26C32817
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 19:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF124ECE5C
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EA32D0CA;
	Tue,  4 Nov 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIE29MsN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32408329C54
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279365; cv=none; b=CLYdxX/lWrIdLjJChfFQZhC3F5nASWHJENVYA8LMkcuVNcnV5/hyijPeDa3Cmhf9fzQxVqrMimq6nVItd1yOrpjV+SSIPorF+u7uEVDM5hnCTeoGQnOPccPyWtF6QcoRBuOG5jQeypd+OMVoIVdfYNxXUJheNC6fABogIugcKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279365; c=relaxed/simple;
	bh=OIL++Ia2AIP9lkFbZvGKHl6hyWdi40eZgRPdaqM/4M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTFw5IB9/4Oqz4NesuzbPNFq9FS7fvCdWPcAxUXP8FFGI/FsvM6vG0JtvP4Qb5f5ZgvC++wRBSgvbsvQqQrfRkh6y8exjoXVh0aG4WTpqQWSjeq4pQQ/pKM+jQpVLsgXurA6Duwrl8gKRGAgW6e9Fm0N0LWCNzeIUyEJ/aAuG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIE29MsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB68C4CEF8;
	Tue,  4 Nov 2025 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279364;
	bh=OIL++Ia2AIP9lkFbZvGKHl6hyWdi40eZgRPdaqM/4M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIE29MsNnO6WPSQdAPvmmKftVGuOlwuKcLQbA6DgzF+YftygopauNdUSGsxJ5KtIm
	 rJY77YbbwUwnjGaUjrX8kt95ULLIa+SFc9Iozsug9+50x/+r/+u7L+qIY9xR2sbMBK
	 PstD+hkt+SDtr/BiuzK+pmu6wz1yZENMCemuE0jY3q+xl9mtIhNvcOBa5q9JKNkVne
	 o9P1QnTzTLBRFaUGKu91+7w20XI+L8WVyTvIJI1vHF3zlQi9wRfDFBn50rsfSyFqwD
	 LXtyuD/OdpKCkRd74KXHM0vDjb8KXjV0jHB2252JBTlBT0WyYl3tmBkmMTbXcmsSBU
	 v57VORZVVExwg==
Date: Tue, 4 Nov 2025 13:02:42 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH v2] nfs/localio: do not issue misaligned DIO
 out-of-order
Message-ID: <aQo_wu1SMGn5RRsy@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
 <aPZ-dIObXH8Z06la@kernel.org>
 <aP-xXB_ht8F1i5YQ@kernel.org>
 <aQKhAksYqPjOzUNv@kernel.org>
 <aQQV1Fw7MX-3cdZd@kernel.org>
 <503dacbf-49b1-4ed7-97db-8b92aff9f1c5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503dacbf-49b1-4ed7-97db-8b92aff9f1c5@oracle.com>

[Hi Anna, here is a fixed v2 of patch 5/3]

On Fri, Oct 31, 2025 at 09:33:40AM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On 10/30/25 9:50 PM, Mike Snitzer wrote:
> > On Wed, Oct 29, 2025 at 07:19:30PM -0400, Mike Snitzer wrote:
> >> From https://lore.kernel.org/linux-nfs/aQHASIumLJyOoZGH@infradead.org/
> >>
> >> On Wed, Oct 29, 2025 at 12:20:40AM -0700, Christoph Hellwig wrote:
> >>> On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> >>>> LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> >>>> middle (via AIO completion of that aligned middle). So out of order
> >>>> relative to file offset.
> >>>
> >>> That's in general a really bad idea.  It will obviously work, but
> >>> both on SSDs and out of place write file systems it is a sure way
> >>> to increase your garbage collection overhead a lot down the line.
> >>
> >> Fix this by never issuing misaligned DIO out-of-order. This fix means
> >> the DIO-aligned segment will only use AIO completion if there is no
> >> misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
> >> will be issued without AIO completion to ensure file offset increases
> >> properly for all partial READ or WRITE situations.
> >>
> >> Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
> >> Reported-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >> ---
> >>  fs/nfs/localio.c | 83 +++++++++++++++++-------------------------------
> >>  1 file changed, 29 insertions(+), 54 deletions(-)
> >>
> >> Anna, apologies for stringing fixes together like this; and that this
> >> same commit c817248fc831 has so many follow-on Fixes is not lost on
> >> me.  But the full series of commit c817248fc831 fixes is composed of:
> >>
> >> [v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
> >> [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
> >> [v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
> >> [v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
> >> [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO out-of-order
> >>
> >> NOTE: PATCH 4/3's use of IOCBD_DSYNC|IOCB_SYNC _is_ conservative, but I
> >> will audit and adjust this further (informed by NFSD Direct's ongoing
> >> evolution for handling this same situaiton) for the v6.19 merge window.
> > 
> > Hi Anna,
> > 
> > Please don't pick up this PATCH 5/3, further testing shows there is
> > something wrong with it.  I'll circle back once I fix it.  But this
> > 5/3 patch doesn't impact the other 4.
> 
> Thanks for the update! I've already looked at the first 4 patches, but
> hadn't had a chance too look at 5/3 yet. I'll skip it for now until I
> hear otherwise from you!

From: Mike Snitzer <snitzer@kernel.org>
Date: Wed, 29 Oct 2025 17:41:02 -0400
Subject: [v6.18-rcX PATCH v2] nfs/localio: do not issue misaligned DIO out-of-order

From https://lore.kernel.org/linux-nfs/aQHASIumLJyOoZGH@infradead.org/

On Wed, Oct 29, 2025 at 12:20:40AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> > LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> > middle (via AIO completion of that aligned middle). So out of order
> > relative to file offset.
>
> That's in general a really bad idea.  It will obviously work, but
> both on SSDs and out of place write file systems it is a sure way
> to increase your garbage collection overhead a lot down the line.

Fix this by never issuing misaligned DIO out of order. This fix means
the DIO-aligned middle will only use AIO completion if there is no
misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
will be issued without AIO completion to ensure file offset increases
properly for all partial READ or WRITE situations.

Factoring out nfs_local_iter_setup() helps standardize repetitive
nfs_local_iters_setup_dio() code and is inspired by cleanup work that
Chuck Lever did on the NFSD Direct code.

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 125 +++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 74 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 24b0c7d62458..985242780abb 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -44,8 +44,7 @@ struct nfs_local_kiocb {
 	short int		end_iter_index;
 	atomic_t		n_iters;
 	bool			iter_is_dio_aligned[NFSLOCAL_MAX_IOS];
-	loff_t                  offset[NFSLOCAL_MAX_IOS] ____cacheline_aligned;
-	struct iov_iter		iters[NFSLOCAL_MAX_IOS];
+	struct iov_iter		iters[NFSLOCAL_MAX_IOS] ____cacheline_aligned;
 	/* End mostly DIO-specific members */
 };
 
@@ -314,6 +313,7 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->hdr = hdr;
+	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
 	iocb->kiocb.ki_complete = NULL;
 	iocb->aio_complete_work = NULL;
@@ -387,13 +387,24 @@ static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
 	return true;
 }
 
+static void
+nfs_local_iter_setup(struct iov_iter *iter, int rw, struct bio_vec *bvec,
+		     unsigned int nvecs, unsigned long total,
+		     size_t start, size_t len)
+{
+	iov_iter_bvec(iter, rw, bvec, nvecs, total);
+	if (start)
+		iov_iter_advance(iter, start);
+	iov_iter_truncate(iter, len);
+}
+
 /*
  * Setup as many as 3 iov_iter based on extents described by @local_dio.
  * Returns the number of iov_iter that were setup.
  */
 static int
 nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
-			  unsigned int nvecs, size_t len,
+			  unsigned int nvecs, unsigned long total,
 			  struct nfs_local_dio *local_dio)
 {
 	int n_iters = 0;
@@ -401,41 +412,18 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 
 	/* Setup misaligned start? */
 	if (local_dio->start_len) {
-		iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
-		iters[n_iters].count = local_dio->start_len;
-		iocb->offset[n_iters] = iocb->hdr->args.offset;
-		iocb->iter_is_dio_aligned[n_iters] = false;
+		nfs_local_iter_setup(&iters[n_iters], rw, iocb->bvec,
+				     nvecs, total, 0, local_dio->start_len);
 		atomic_inc(&iocb->n_iters);
 		++n_iters;
 	}
 
-	/* Setup misaligned end?
-	 * If so, the end is purposely setup to be issued using buffered IO
-	 * before the middle (which will use DIO, if DIO-aligned, with AIO).
-	 * This creates problems if/when the end results in short read or write.
-	 * So must save index and length of end to handle this corner case.
+	/*
+	 * Setup DIO-aligned middle, if there is no misaligned end (below)
+	 * then AIO completion is used, see nfs_local_call_{read,write}
 	 */
-	if (local_dio->end_len) {
-		iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
-		iocb->offset[n_iters] = local_dio->end_offset;
-		iov_iter_advance(&iters[n_iters],
-			local_dio->start_len + local_dio->middle_len);
-		iocb->iter_is_dio_aligned[n_iters] = false;
-		/* Save index and length of end */
-		iocb->end_iter_index = n_iters;
-		iocb->end_len = local_dio->end_len;
-		atomic_inc(&iocb->n_iters);
-		++n_iters;
-	}
-
-	/* Setup DIO-aligned middle to be issued last, to allow for
-	 * DIO with AIO completion (see nfs_local_call_{read,write}).
-	 */
-	iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
-	if (local_dio->start_len)
-		iov_iter_advance(&iters[n_iters], local_dio->start_len);
-	iters[n_iters].count -= local_dio->end_len;
-	iocb->offset[n_iters] = local_dio->middle_offset;
+	nfs_local_iter_setup(&iters[n_iters], rw, iocb->bvec, nvecs,
+			     total, local_dio->start_len, local_dio->middle_len);
 
 	iocb->iter_is_dio_aligned[n_iters] =
 		nfs_iov_iter_aligned_bvec(&iters[n_iters],
@@ -443,11 +431,22 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 
 	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
 		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
-			iocb->hdr->args.offset, len, local_dio);
+			local_dio->start_len, local_dio->middle_len, local_dio);
 		return 0; /* no DIO-aligned IO possible */
 	}
+	iocb->end_iter_index = n_iters;
 	++n_iters;
 
+	/* Setup misaligned end? */
+	if (local_dio->end_len) {
+		nfs_local_iter_setup(&iters[n_iters], rw, iocb->bvec,
+				     nvecs, total, local_dio->start_len +
+				     local_dio->middle_len, local_dio->end_len);
+		atomic_inc(&iocb->n_iters);
+		iocb->end_iter_index = n_iters;
+		++n_iters;
+	}
+
 	return n_iters;
 }
 
@@ -492,9 +491,7 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	}
 
 	/* Use buffered IO */
-	iocb->offset[0] = hdr->args.offset;
 	iov_iter_bvec(&iocb->iters[0], rw, iocb->bvec, v, len);
-	iocb->iter_is_dio_aligned[0] = false;
 }
 
 static void
@@ -631,30 +628,20 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
-		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-			iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-		}
+			/* Only use AIO completion if DIO-aligned segment is last */
+			if (i == iocb->end_iter_index) {
+				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+			}
+		} else
+			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
-		iocb->kiocb.ki_pos = iocb->offset[i];
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count)) {
-				/* partial read */
-				if (i == iocb->end_iter_index) {
-					/* Must not account DIO partial end, otherwise (due
-					 * to end being issued before middle): the partial
-					 * read accounting in nfs_local_read_done()
-					 * would incorrectly advance hdr->args.offset
-					 */
-					status = 0;
-				} else {
-					/* Partial read at start or middle, force done */
-					force_done = true;
-				}
-			}
+			if (unlikely(status >= 0 && status < iocb->iters[i].count))
+				force_done = true; /* Partial read */
 			if (nfs_local_pgio_done(iocb, status, force_done)) {
 				nfs_local_read_iocb_done(iocb);
 				break;
@@ -849,30 +836,20 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
-		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
-			iocb->aio_complete_work = nfs_local_write_aio_complete_work;
-		}
+			/* Only use AIO completion if DIO-aligned segment is last */
+			if (i == iocb->end_iter_index) {
+				iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+				iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+			}
+		} else
+			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
-		iocb->kiocb.ki_pos = iocb->offset[i];
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
 		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count)) {
-				/* partial write */
-				if (i == iocb->end_iter_index) {
-					/* Must not account DIO partial end, otherwise (due
-					 * to end being issued before middle): the partial
-					 * write accounting in nfs_local_write_done()
-					 * would incorrectly advance hdr->args.offset
-					 */
-					status = 0;
-				} else {
-					/* Partial write at start or middle, force done */
-					force_done = true;
-				}
-			}
+			if (unlikely(status >= 0 && status < iocb->iters[i].count))
+				force_done = true; /* Partial write */
 			if (nfs_local_pgio_done(iocb, status, force_done)) {
 				nfs_local_write_iocb_done(iocb);
 				break;
-- 
2.44.0



