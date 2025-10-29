Return-Path: <linux-nfs+bounces-15764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC64C1DADA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 00:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC24E043C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335602FD69F;
	Wed, 29 Oct 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuZh+XnL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBC2F3C34
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779972; cv=none; b=ImH/3IUM8Yi1RgqkpS4w/uSGTTgFi8YXSCDJrSAWa5ieobTmAPyi69GincQ6SjNgxtirMQiADInLSKebp9zf9I/rtBknij7nFkkUSr6SYfrhaDTLpzn/2li5GOxdBrmhzvopW7IEBL+lCEHKCkiD4vgbXN4cfmzAwJw7lRWArm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779972; c=relaxed/simple;
	bh=EeHLqNReIf+RdwnyA1CZWafq26ShljDmwC4JY6EDDv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIOUvfowkVIhbTkAD59zprkAp0kORbF+z2N6MbnQFhTwF8idp3EO1C39asYcPA8cyJcBIdJBCWK7EPNUPIJQYIQtn5gUUUMmke+1t900IZ2K5Lc1WqySpP+TPBScK96qfELYbZTxGukIF9gVXSPuC94kHp2xqejQPPA6tJTfWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuZh+XnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59107C4CEF7;
	Wed, 29 Oct 2025 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779971;
	bh=EeHLqNReIf+RdwnyA1CZWafq26ShljDmwC4JY6EDDv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuZh+XnLElE2XukliJd0Hpv6s40pyVsNz5f7rWOezWu4fNoqBHI07G++UJj3fy6gI
	 p5Y2j4sh81mFbou6zOMbZch12zr6Hpy++SIaKx566Jx1sRRgaZIPq3uqz1vjulplP6
	 tgRCpCjrNUljf60W0b4T0ZT+h6dqbVfQq4vKM257zVGQcHabeSRa6FAkKDu8rFgo6X
	 WD9OMGiwDVmP2h/g65FytvzDE6uViz3kzeQGsPc6PhIXvkOQWY5Xszz2QdoNdzvFRz
	 +CzkzaMQeqaK62LYZ7OwjHHlqXAsEY9bk5vpdPrAXH7GmJyENQxYlHGLmxG4RgTFam
	 7I5EWx+h01+mA==
Date: Wed, 29 Oct 2025 19:19:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO
 out-of-order
Message-ID: <aQKhAksYqPjOzUNv@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
 <aPZ-dIObXH8Z06la@kernel.org>
 <aP-xXB_ht8F1i5YQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-xXB_ht8F1i5YQ@kernel.org>

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

Fix this by never issuing misaligned DIO out-of-order. This fix means
the DIO-aligned segment will only use AIO completion if there is no
misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
will be issued without AIO completion to ensure file offset increases
properly for all partial READ or WRITE situations.

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 83 +++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

Anna, apologies for stringing fixes together like this; and that this
same commit c817248fc831 has so many follow-on Fixes is not lost on
me.  But the full series of commit c817248fc831 fixes is composed of:

[v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
[v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
[v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
[v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
[v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO out-of-order

NOTE: PATCH 4/3's use of IOCBD_DSYNC|IOCB_SYNC _is_ conservative, but I
will audit and adjust this further (informed by NFSD Direct's ongoing
evolution for handling this same situaiton) for the v6.19 merge window.

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ca9df8d09c2d..018fa332aae4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -40,7 +40,6 @@ struct nfs_local_kiocb {
 	void (*aio_complete_work)(struct work_struct *);
 	struct nfsd_file	*localio;
 	/* Begin mostly DIO-specific members */
-	size_t                  end_len;
 	short int		end_iter_index;
 	atomic_t		n_iters;
 	bool			iter_is_dio_aligned[NFSLOCAL_MAX_IOS];
@@ -411,27 +410,8 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 		++n_iters;
 	}
 
-	/* Setup misaligned end?
-	 * If so, the end is purposely setup to be issued using buffered IO
-	 * before the middle (which will use DIO, if DIO-aligned, with AIO).
-	 * This creates problems if/when the end results in short read or write.
-	 * So must save index and length of end to handle this corner case.
-	 */
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
+	/* Setup DIO-aligned middle, if there is no misaligned end (below)
+	 * then AIO completion is used, see nfs_local_call_{read,write}
 	 */
 	iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
 	if (local_dio->start_len)
@@ -448,8 +428,21 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 			iocb->hdr->args.offset, len, local_dio);
 		return 0; /* no DIO-aligned IO possible */
 	}
+	iocb->end_iter_index = n_iters;
 	++n_iters;
 
+	/* Setup misaligned end? */
+	if (local_dio->end_len) {
+		iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
+		iocb->offset[n_iters] = local_dio->end_offset;
+		iov_iter_advance(&iters[n_iters],
+			local_dio->start_len + local_dio->middle_len);
+		iocb->iter_is_dio_aligned[n_iters] = false;
+		atomic_inc(&iocb->n_iters);
+		iocb->end_iter_index = n_iters;
+		++n_iters;
+	}
+
 	return n_iters;
 }
 
@@ -636,27 +629,18 @@ static void nfs_local_call_read(struct work_struct *work)
 		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-			iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+			/* Only use AIO completion if DIO-aligned segment is last */
+			if (i == iocb->end_iter_index) {
+				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+			}
 		}
 
 		iocb->kiocb.ki_pos = iocb->offset[i];
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
@@ -854,27 +838,18 @@ static void nfs_local_call_write(struct work_struct *work)
 		/* DIO-aligned middle is always issued last with AIO completion */
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
-			iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+			/* Only use AIO completion if DIO-aligned segment is last */
+			if (i == iocb->end_iter_index) {
+				iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+				iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+			}
 		}
 
 		iocb->kiocb.ki_pos = iocb->offset[i];
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


