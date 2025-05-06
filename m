Return-Path: <linux-nfs+bounces-11497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8CAAC6EF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854857AA47B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AC281341;
	Tue,  6 May 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ez9CggRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762A280A3D
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539395; cv=none; b=tssECVllCOoIPYeWO2dbw0+jq/rm1wREMzLP5dKg17v121ectAYsuQ8lKyJj1MwFgyDu9AVtUJw1XUYRdqtsvHcOxGB8tygwjIqJFWc9zv9AVZNS+CPrv1DPQxMUMOISVie6+2DXI7TqD3je9cZAjbKKHBafHuIphfc7xmV0PP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539395; c=relaxed/simple;
	bh=VJXpMmgdSksrcCKld79sALDerI+Qh0bP01mcYh/ZUy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeSdsJwaubV77nyKYCVJmXuof1sodk9FRbkNZ4iIBUZLwTcA+Aszz+PIJPky1yhrplU56crQGcT1yGkVTJFHtzEpW5NBiWEdmTZ45yTGTuYm17c+FFgATPaPbXq65gXrzvJdtHukBv+1Ts4xdROp/vpBomZmcyRwS1ggiuyKask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ez9CggRq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LMDydSAMumBk5tv+0wVK226ipfhVHSBy9ypV9xc4JRs=; b=Ez9CggRqVcI5Pn3ET3AANNc3jb
	LPlraEQAkk6ShcO6thiiIb1A3JrE2amcmVs6/u2CjvoB6Inxt5SMsie/7w9vEf4+UCdhkkFAqAFTR
	KQvQPOyRq6l00Z6DYIA8FKOsn7rtddFUfwpd0ZCQ78Lqr/De2Ij4cAO1DdQlG/g2YaGn/QiUIAAw7
	DYHLkATq4kQpvg+k4gKWO/D/nyOkWI7Blc3guybXY5ex3mnyc3yckSSJxw9SLnhkORBaYco49DqoH
	i+wF81r9DrhaAYq3kCYXHFOA0eXwUoTdTYIS60BW1hw5/waZYykW7NWsldHQc1+4mEWi9/X5F2OF0
	oEJ1TMXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIgC-0000000CCVb-1PYc;
	Tue, 06 May 2025 13:49:52 +0000
Date: Tue, 6 May 2025 06:49:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Message-ID: <aBoTgFTJ2rPB3Hsk@infradead.org>
References: <20250427163914.5053-1-cel@kernel.org>
 <aBnD6Wj1yq9MP8ZB@infradead.org>
 <1fb2ff54-9e49-4697-9485-5323791a0f9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb2ff54-9e49-4697-9485-5323791a0f9b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 09:45:56AM -0400, Chuck Lever wrote:
> On 5/6/25 4:10 AM, Christoph Hellwig wrote:
> > On Sun, Apr 27, 2025 at 12:39:14PM -0400, cel@kernel.org wrote:
> >> NFSD can return 0 here, as at least one client implementation we
> >> are aware of (the Linux NFS client) treats 0 as meaning "CLONE has
> >> no alignment restrictions".
> > 
> > Usually clone does have a restriction, though.
> 
> Then should this patch extract that block size and report it? Pointer
> to sample code would kickstart me to get that done.

I think reporting 0 as unknown makes perfect sense, just don't claim
that there is no limitation.

The generic remap range checks for file system block size alignment:

	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
		return -EINVAL;

in generic_remap_checks.


