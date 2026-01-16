Return-Path: <linux-nfs+bounces-18045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D0CD38831
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC640300815E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABB2FD69D;
	Fri, 16 Jan 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkpNc/eA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08F26CE3F;
	Fri, 16 Jan 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598059; cv=none; b=HETRd7/d1RW4cdQbcWy5gLdB4j/MEKWubpY5EbL6HURQ+FNOUEEUwQpkMAOgPVpzfPlchMVrtxWfdKYwAPwkvZprhXUBjRfx6wS0MmMCcZ/lUtextiNlpi2WdyKDDmQ7xrC9nBzAsvV/QJ2D/WBEKH8zXpPIqlvji/7zF7hPOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598059; c=relaxed/simple;
	bh=sijbnpL9XBVDCYz165hl+AewDEG+1x0EOeW8l0BatnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq6Kh+pmBYVpCC/DzC2jI6jwcWKMCtWq8MZ8HFO3H94UxxhdIIFj7tDHRzlPc9NmX9894EzXVIZkh/dPjVogassCv7tUYkPJYxUx3M9kTaaZRZdDgGSl0qK5TjUwKRkKencJY9Jap1wqPIDOCZr9MUsxdSG2CJ2U6q+/PqC+OtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkpNc/eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40BC116C6;
	Fri, 16 Jan 2026 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768598059;
	bh=sijbnpL9XBVDCYz165hl+AewDEG+1x0EOeW8l0BatnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkpNc/eA2qeSTt0JUpLxtYNfQzu0om0ORxToocorSmE9cFHyNBx10xdL5+5n7Kb/2
	 CLfRnHiS72J/MJyWFt1bT5snUv4OQ32htWRksLuolRKYzrIwa67vJJH5sIUmGyoOsJ
	 Lx6VJ+R1J1JwK2fpeDXNLjwN6GTYUt35ZSSZxc0lC5f2Fbpu2/YDXCLVi2UN6xL8j3
	 NGQywU9Ub/FONNr+Kp8Bu/2aAVzjGOjRGtbULP1T7pcnXkcoZTyM0xiumnZax1l+go
	 1hT1l5z3cAF/elONohxoz6B101FsaLJ7FNEZa1fUPQv9en4IYDXaqyNfZIMKMVI4mw
	 VXDB5ZlJmGl4A==
Date: Fri, 16 Jan 2026 23:14:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260116211413.GH14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org>
 <20260115155334.GB14083@lst.de>
 <20260116113310.GF14359@unreal>
 <20260116145206.GB16842@lst.de>
 <19c34c0c-5391-477b-892c-00ab124e543b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c34c0c-5391-477b-892c-00ab124e543b@app.fastmail.com>

On Fri, Jan 16, 2026 at 09:57:57AM -0500, Chuck Lever wrote:
> 
> 
> On Fri, Jan 16, 2026, at 9:52 AM, Christoph Hellwig wrote:
> > On Fri, Jan 16, 2026 at 01:33:10PM +0200, Leon Romanovsky wrote:
> >> > Much of this seems to duplicate rdma_rw_init_map_wrs.  I wonder if
> >> > having a low-level helper that gets either a scatterlist or bvec array
> >> > (or bvec_iter) and just has different inner loops for them would
> >> > make more sense?  If not we'll just need to migrate everyone off
> >> > the scatterlist version ASAP :)
> >> 
> >> I had short offline discussion with Jason about this series and both of
> >> us would be more than happy to get rid of "scatterlist version".
> >
> > nvmet_rdma_rw_ctx_init is used by isert, srpt, nvmet, ksmbd and
> > the sunrpc server side.  I don't think any of them should be
> > super complicated to work, but it will need a fair amount of testing
> > resources.
> 
> My preference is to keep the scope of this series narrow --
> introduce the new API, and add one consumer for it. The other
> conversions can then each be done by domain experts as they
> have time.

Of course, I'm only outlining the direction in which the RDMA subsystem
is expected to evolve.

> 
> I have no strong feeling for or against eventually removing
> SGL support entirely from rw.c.
> 
> -- 
> Chuck Lever

