Return-Path: <linux-nfs+bounces-15822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E82C22EAD
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 02:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43032345BFE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 01:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ABE25DAFF;
	Fri, 31 Oct 2025 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTHDrVPh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96B27442
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875415; cv=none; b=i8AytqC9Sz2aM3VaFtXoy/e6ANFuiqcLKOVCWWkI/YsqfIh+zICNpD6Acn45z/1w4N9NhL5Yl1KpNnPK2ngoLaYalsMaVZOe6QZwVdbHoO4Nirg771hX7Y1dd6JPZRZLGNDoWmCIsajIxmzT4wlhUY/3oexr2XJ9+BUqqWa0R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875415; c=relaxed/simple;
	bh=GN4oiUoy91vcTYrp/AQMGTnN3nZGGHUWqpTmHbWG3u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLpNC4LAa6VFZA37GglG4gCEbS9fSBwayhNBll1EvWp0XnG5np8wGktVOPqS9R1tShRAn3nDgIiEU7u0xAv2UlwoM8+o1AoKxsJ1D/IbpYaOyoBynEXNKDdi+ag1tGkeC4rhdWUuUO6MqzqhziDSYaunbIq5l5RlIE1vJk+RxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTHDrVPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6630C4CEFD;
	Fri, 31 Oct 2025 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761875413;
	bh=GN4oiUoy91vcTYrp/AQMGTnN3nZGGHUWqpTmHbWG3u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTHDrVPhERVPB0cFK98tQF78DeK6EcTeFIl87HL544CUvFwp3Jv8Clbu8gPP9F92q
	 ev68LKtyueCHkwgInPV+tid4J+UcyrqpvLl+CcWsFEptfOn+PauSYh0Ok7cL4Xxn4t
	 XfbC3PKw2JCDBfoT3oaqfMx2ZgGCI7I+flb7Yw/8kDJPKDEeTE1IQElullnUKcSgPi
	 BTJm2ScwBxLez5ZfLO8tD3SDVA1TyCyLZ+4R12/kk0BMWhIhyslL2R+2/YqBiWB1lW
	 XksUHg6nWIv/XbUfqTXu7BWyuHUwRRzaPabQJD0dP0yp1w8RcgQnmnH7vy9a1F8LsB
	 565ss8rsbjcHw==
Date: Thu, 30 Oct 2025 21:50:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO
 out-of-order
Message-ID: <aQQV1Fw7MX-3cdZd@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
 <aPZ-dIObXH8Z06la@kernel.org>
 <aP-xXB_ht8F1i5YQ@kernel.org>
 <aQKhAksYqPjOzUNv@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKhAksYqPjOzUNv@kernel.org>

On Wed, Oct 29, 2025 at 07:19:30PM -0400, Mike Snitzer wrote:
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
> Fix this by never issuing misaligned DIO out-of-order. This fix means
> the DIO-aligned segment will only use AIO completion if there is no
> misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
> will be issued without AIO completion to ensure file offset increases
> properly for all partial READ or WRITE situations.
> 
> Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 83 +++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 54 deletions(-)
> 
> Anna, apologies for stringing fixes together like this; and that this
> same commit c817248fc831 has so many follow-on Fixes is not lost on
> me.  But the full series of commit c817248fc831 fixes is composed of:
> 
> [v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
> [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
> [v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
> [v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
> [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO out-of-order
> 
> NOTE: PATCH 4/3's use of IOCBD_DSYNC|IOCB_SYNC _is_ conservative, but I
> will audit and adjust this further (informed by NFSD Direct's ongoing
> evolution for handling this same situaiton) for the v6.19 merge window.

Hi Anna,

Please don't pick up this PATCH 5/3, further testing shows there is
something wrong with it.  I'll circle back once I fix it.  But this
5/3 patch doesn't impact the other 4.

Thanks,
Mike

