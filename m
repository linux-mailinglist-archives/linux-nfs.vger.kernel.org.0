Return-Path: <linux-nfs+bounces-16117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC446C38EAD
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 03:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4156A188CA21
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CEB45038;
	Thu,  6 Nov 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErAYvK0Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7918EB0
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397436; cv=none; b=A3sa7KexZHIWCOtFrPG/ny28cobZV/AREyYOpy1Ix8BnpaFVRgwX2LAuICVbcHhdMWyTPBat6pZT559ymIij+jahTkJpmbWhLdthVdABtpMPNMid0A7GtN6aLmKwo3AS6/6HeAL+sIph/CtVIhcea7aymP078RBwDxgEXJOqe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397436; c=relaxed/simple;
	bh=c8tT9Y7DT5HMlNfv2N9s+Ym5pQR7RQI0FU50CU2LHnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFY6OSiQ36YEa2wYzwi1UloThXyuexOfKwpXmALiWg9HM9iN2Rz9z7baKEl68ALa8FDHeftTWlklU5BxYvEvMAS6H0l1v8xQEdhjW73jwdRtVk9yXTpy92NTOnY6cZrz2x8/gfToBsAyphCZeB5vca9St5p8LHYdDi4SLnj/lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErAYvK0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40D0C4CEF5;
	Thu,  6 Nov 2025 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762397435;
	bh=c8tT9Y7DT5HMlNfv2N9s+Ym5pQR7RQI0FU50CU2LHnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErAYvK0Y+3o/Zxj+Zxly5GSRSSNUFs2hc3pNt7JhFAslyzCV90vkW6aVxVe8zBEfM
	 dLO6q5nOr33Q3l5afQifAhDCrC1OGPSJpWvV3uEGfEM76uPoIgl2H66ZZ1NUVo6F7D
	 0hjs9LxLyd1UfDNPuftXIfEqidy56da7MxWLwMQA6bRLI3UpBTY56RfER/lTalm4pC
	 bOEBY7msOZ/qrDPY4aEYYqQTxvK4eMpqPMZZJSKosiuiVjbsS4CdCQgPzEcrq0XqeD
	 bfPDzp8UoP+/WiLctK8FwiGCleH3HqDQtGb7eaLSKDxcCrnHYzCl+8/Jc0MhfGISC0
	 s5T6Sxtxz8x7w==
Date: Wed, 5 Nov 2025 21:50:34 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [v6.18-rcX PATCH v2] nfs/localio: do not issue misaligned DIO
 out-of-order
Message-ID: <aQwM-h1QA4SkpLnX@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
 <aPZ-dIObXH8Z06la@kernel.org>
 <aP-xXB_ht8F1i5YQ@kernel.org>
 <aQKhAksYqPjOzUNv@kernel.org>
 <aQQV1Fw7MX-3cdZd@kernel.org>
 <503dacbf-49b1-4ed7-97db-8b92aff9f1c5@oracle.com>
 <aQo_wu1SMGn5RRsy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQo_wu1SMGn5RRsy@kernel.org>

On Tue, Nov 04, 2025 at 01:02:42PM -0500, Mike Snitzer wrote:
> [Hi Anna, here is a fixed v2 of patch 5/3]
> 
> On Fri, Oct 31, 2025 at 09:33:40AM -0400, Anna Schumaker wrote:
> > Hi Mike,
> > 
> > On 10/30/25 9:50 PM, Mike Snitzer wrote:
> > > On Wed, Oct 29, 2025 at 07:19:30PM -0400, Mike Snitzer wrote:
> > >> From https://lore.kernel.org/linux-nfs/aQHASIumLJyOoZGH@infradead.org/
> > >>
> > >> On Wed, Oct 29, 2025 at 12:20:40AM -0700, Christoph Hellwig wrote:
> > >>> On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> > >>>> LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> > >>>> middle (via AIO completion of that aligned middle). So out of order
> > >>>> relative to file offset.
> > >>>
> > >>> That's in general a really bad idea.  It will obviously work, but
> > >>> both on SSDs and out of place write file systems it is a sure way
> > >>> to increase your garbage collection overhead a lot down the line.
> > >>
> > >> Fix this by never issuing misaligned DIO out-of-order. This fix means
> > >> the DIO-aligned segment will only use AIO completion if there is no
> > >> misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
> > >> will be issued without AIO completion to ensure file offset increases
> > >> properly for all partial READ or WRITE situations.
> > >>
> > >> Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
> > >> Reported-by: Christoph Hellwig <hch@lst.de>
> > >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > >> ---
> > >>  fs/nfs/localio.c | 83 +++++++++++++++++-------------------------------
> > >>  1 file changed, 29 insertions(+), 54 deletions(-)
> > >>
> > >> Anna, apologies for stringing fixes together like this; and that this
> > >> same commit c817248fc831 has so many follow-on Fixes is not lost on
> > >> me.  But the full series of commit c817248fc831 fixes is composed of:
> > >>
> > >> [v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
> > >> [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
> > >> [v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
> > >> [v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
> > >> [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO out-of-order
> > >>
> > >> NOTE: PATCH 4/3's use of IOCBD_DSYNC|IOCB_SYNC _is_ conservative, but I
> > >> will audit and adjust this further (informed by NFSD Direct's ongoing
> > >> evolution for handling this same situaiton) for the v6.19 merge window.
> > > 
> > > Hi Anna,
> > > 
> > > Please don't pick up this PATCH 5/3, further testing shows there is
> > > something wrong with it.  I'll circle back once I fix it.  But this
> > > 5/3 patch doesn't impact the other 4.
> > 
> > Thanks for the update! I've already looked at the first 4 patches, but
> > hadn't had a chance too look at 5/3 yet. I'll skip it for now until I
> > hear otherwise from you!
> 
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Wed, 29 Oct 2025 17:41:02 -0400
> Subject: [v6.18-rcX PATCH v2] nfs/localio: do not issue misaligned DIO out-of-order
> 
> From https://lore.kernel.org/linux-nfs/aQHASIumLJyOoZGH@infradead.org/
> 
> On Wed, Oct 29, 2025 at 12:20:40AM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> > > LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> > > middle (via AIO completion of that aligned middle). So out of order
> > > relative to file offset.
> >
> > That's in general a really bad idea.  It will obviously work, but
> > both on SSDs and out of place write file systems it is a sure way
> > to increase your garbage collection overhead a lot down the line.
> 
> Fix this by never issuing misaligned DIO out of order. This fix means
> the DIO-aligned middle will only use AIO completion if there is no
> misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
> will be issued without AIO completion to ensure file offset increases
> properly for all partial READ or WRITE situations.
> 
> Factoring out nfs_local_iter_setup() helps standardize repetitive
> nfs_local_iters_setup_dio() code and is inspired by cleanup work that
> Chuck Lever did on the NFSD Direct code.
> 
> Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 125 +++++++++++++++++++----------------------------
>  1 file changed, 51 insertions(+), 74 deletions(-)
> 


Hi Anna,

I found that this v2 of patch 5/3 had a bug when falling back from DIO
to buffered due to misalignment.  Here is the incremental fix (I'll
also reply with v3 of 5/3 with this fix folded in):

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 985242780abb..5aa903b2b836 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -414,7 +414,6 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 	if (local_dio->start_len) {
 		nfs_local_iter_setup(&iters[n_iters], rw, iocb->bvec,
 				     nvecs, total, 0, local_dio->start_len);
-		atomic_inc(&iocb->n_iters);
 		++n_iters;
 	}
 
@@ -442,11 +441,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 		nfs_local_iter_setup(&iters[n_iters], rw, iocb->bvec,
 				     nvecs, total, local_dio->start_len +
 				     local_dio->middle_len, local_dio->end_len);
-		atomic_inc(&iocb->n_iters);
 		iocb->end_iter_index = n_iters;
 		++n_iters;
 	}
 
+	atomic_set(&iocb->n_iters, n_iters);
 	return n_iters;
 }
 
@@ -473,7 +472,7 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	len = hdr->args.count - total;
 
 	/*
-	 * For each iocb, iocb->n_iter is always at least 1 and we always
+	 * For each iocb, iocb->n_iters is always at least 1 and we always
 	 * end io after first nfs_local_pgio_done call unless misaligned DIO.
 	 */
 	atomic_set(&iocb->n_iters, 1);

