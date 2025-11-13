Return-Path: <linux-nfs+bounces-16337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF2C562E4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E414E1AFD
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D08331219;
	Thu, 13 Nov 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGejnSsL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B8330D32
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021595; cv=none; b=Wj4mP4b2/9/2RKq34QviJLXXlfkjleXsowb5r1VREBxJDOYNbVs0WutYyZSMSfFjtxsVw14JMkhDRFdmAhN8rN19YgCgiMRSCsRFGR58N7xbE+mmkTz4PnfNc0LQ6gMtmfIgCiAIo2AUECq23tHL9m7kE23UTSuF98lpfjvKZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021595; c=relaxed/simple;
	bh=yHLILiyWuyc5l2qgphTjKhmRjI66f36cM3D2fhheQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNttXlz+w8Rxnli3fEPkNSSKGbWSgrEBpTqnyLjegwp8nZCsLgpyAKz4yYGuN+drcRIXkhBBpzpgMPSnKDcl+8SJkZNwZ3Razv/SUM9/QCmvPh9VEgMBnz/FDJ4ZBfYtYR3k6BodvvuLHqg0FCb3KQ9Ef+fGtbEQGg8/ppgMK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VGejnSsL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dUzeGFRtRHmiQ2jJWFQhQ+s537PqrSSckpmmffYGIKM=; b=VGejnSsLxHVTCkJv96+q+0jwpK
	Kr5dDEPXwXEUhYrvXM8shrJ2EySbjSsAKEqqOcSynrBRlVkqIXBvxV2CH1/Lk/wk9Q49fuD+1T1S2
	XS2qRDo2BlcDcTkpFySggnRAtQJcj74EjCKnhhYBDbmVHuYX6FWOUk14k8DCd+yJ9QDVNufw1KuMN
	ZRdr6PWgKU4auVukYK0u0B59H7jecv8CL1JSFAeehP8WEnX2rWB5Tlk6SyYzjMOlWvRMlP6H5bggD
	RRbCmIFzszNMuOrt75vs0nbTfZQHnrNlPlEARnZj9CF8DL1AA0kcKP3buPLELJsNy+OBjm18ehtxY
	q7EXfjiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSS5-0000000A3dX-1TXF;
	Thu, 13 Nov 2025 08:13:09 +0000
Date: Thu, 13 Nov 2025 00:13:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, jonathan.flynn@hammerspace.com
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRWTFQZrmNCMfGtp@infradead.org>
References: <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
 <aRPPikkia5ZVZxJG@kernel.org>
 <aRShjU_Ti7f2Ci7I@infradead.org>
 <aRUUx2c6YNnRYRZ_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUUx2c6YNnRYRZ_@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 12, 2025 at 06:14:15PM -0500, Mike Snitzer wrote:
> > -	 * Check if direct I/O is feasible for this write request.
> > -	 * If alignments are not available, the write is too small,
> > -	 * or no alignment can be found, fall back to buffered I/O.
> > +	 * If the file system doesn't advertise any alignment requirements,
> > +	 * don't try to issue direct I/O.  Fall back to uncached buffered
> > +	 * I/O if possible because we'll assume it is not block based and
> > +	 * doesn't need read-modify-write cycles.
> >  	 */
> 
> Not sure what is implied by "not block based" in this comment.

e.g. re-exporting another network file system or tmpfs.

> > +	/*
> > +	 * If the I/O is smaller than the larger of the memory and logical
> > +	 * offset alignment, it is like to require read-modify-write cycles.
> > +	 * Issue cached buffered I/O.
> > +	 */
> 
> Nit: s/like/likely/ typo.

Thanks.

> > +	if (!middle ||
> > +	    ((prefix || suffix) && middle < PAGE_SIZE * 2))
> >  		goto no_dio;
> >  
> >  	if (prefix)
> 
> Expressing this threshold in terms of PAGE_SIZE might be a
> problem for other archs like ARM (where using 64K the norm for
> performance).

True.

> The "Note:" portion of the above comment might do well to address the
> goal being to avoid using cached buffered for higher order
> allocations. You or Chuck may have solid ideas for refining wording.

Honestly I'm not worried about higher order allocations at all.  Yes,
they used to be very painful in the past, but if we get them here
it means the file system supports large folios, which means we're going
to churn through a lot of them anyway.

> But so you're aware Jon Flynn (who kindly does the heavy lifting of
> performance testing for me) agrees with you: larger will likely be
> beneficial but it'll be hardware dependent.  So I'm going to expose a
> knob for Jon to try various values so we can see.

That does sound useful, thanks!

> Overall this patch looks good.  Would welcome seeing you submit a
> formal patch.  In parallel I'll work with Jon to get this tested on
> Hammerspace's performance cluster to confirm all looks good.

I have no problem fixing up the nits and writing a commit message,
but I have no time to properly test this.  I'm too busy with my
own projects and just stealing some time to help with whiteboard
coding here :)  I'd also be perfectly fine with whoever actually
brings this across taking full credit.


