Return-Path: <linux-nfs+bounces-18099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18843D3A516
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F17E304C92B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEF33B96B;
	Mon, 19 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6cInx9L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84C3009D2;
	Mon, 19 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818542; cv=none; b=ks6UosvvUgIg2F1gP3iq/okCcLQW76iUCDHFxoDVxu9CSCuPfI78TzR8BWvyWJaBjdmI7bJ5PadNH3uTTKGTL50UKLWY5216FdsYPhMlzMrfAwtlVqoCN62/u+xtZmCZKoO6Txw6jpvDCDyR9TK6Vj3h6vtY1G3UfGejuPjLhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818542; c=relaxed/simple;
	bh=JFte37+nWfx9d3aoqalLh5+SJkBFQF3RzJyuAQQN5ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw5KQpNUWHalJxP1KagVyh2xPWsjMAxLvqf3b9H4Lrw29xFySQYW9xtrt1aWJ5JbSnRdsZwaQjJY6DbXK75UUmHZ2CxepqLtJkp6LXrjtvQ7hs7fb8ARf5GrTHh5BIbRQAKN9pv8wAo8YQzlSnEfbuezDCU12VAPImFSATk4B1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6cInx9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DEEC116C6;
	Mon, 19 Jan 2026 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768818542;
	bh=JFte37+nWfx9d3aoqalLh5+SJkBFQF3RzJyuAQQN5ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6cInx9LgaXNDQDOOojsgnXWe31Vs73S1igaVj1+oimpn8vlhQeHvTmZbwEAoqjQN
	 rX6vlOAObGvBUsjD01LF8A2NPVphfjYRVRa7pr4NDSWhkU0ZX5O4gpzMeEpLwZ6ode
	 /3hyxIhhBOcQsQL1F31WaJfPrw9KWCHb+Fj5YK+Vl3gCj8nivRDkTkV+2BJeTeJtZr
	 Xs8KmSUwdrzrzqldV0VbmFXCa2obdf8zbOnd9CxjWa/aaM+9iayhhWRQ1bi4JXJ9UF
	 Fi7yM3JM7j4RbJ9Z8xmVp54iuCsIkY235oSPSGNgx8riDRjUXYKWNB1+V9zQgev2If
	 zWbb0uJp/rAeg==
Date: Mon, 19 Jan 2026 12:28:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260119102857.GI13201@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org>
 <20260115155334.GB14083@lst.de>
 <20260116212425.GJ14359@unreal>
 <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
 <20260119065212.GA1423@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119065212.GA1423@lst.de>

On Mon, Jan 19, 2026 at 07:52:12AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 04:49:06PM -0500, Chuck Lever wrote:
> > >> Hmm, if we need to split/adjust bvecs, it might be better to
> > >> pass a bvec_iter and let the iter handle the iteration?
> > >
> > > It would also be worthwhile to support P2P scenarios in this flow.
> > 
> > I can add some code to this series to do that, but I don't believe
> > I have facilities to test it.
> 
> Please don't add untested code.  If Leon wants the P2P support and
> volunteers to test it, sure.

I can do it with the help of how to setup the system.

> But let's not merge it without being tested.  And at least for NFS I don't
> really see how P2P would easily fit in anyway.

Chuck is proposing a new IB/core API that will also be used by NVMe too.
Wouldn't p2p be useful in the general case

Thanks

> 
> 

