Return-Path: <linux-nfs+bounces-18145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC74D3B5E0
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 19:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08253043F6C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851238735A;
	Mon, 19 Jan 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyrNY74r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4932AABF;
	Mon, 19 Jan 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847665; cv=none; b=mIJ5+r+oeRsAykZFyk45YNb97kiBLwb92GBJRPa0s7pIQCWm4+kxdfL5fiasfL+N4xwFnvvxXvLrTx+3kA6FUK/NJrMt3VXDNl0A/3K+iVjUcN3rgeaqrD9hLYY6iHv10io8UrIgzbVrs1YNXVQ9z9zugryhEcL5c/rRMufB7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847665; c=relaxed/simple;
	bh=kC7Zj4+slaVhN0XLjBUuk1dKiurvs5ZgBe29k50UZRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWPGNa/s0v7Du6/IPP3HHb5R13xYjd0tatStyvV4YH1TrJBulnagomPvWblsuyoNsAC1mXnZfnRWiUqCPP7CQM7RzMzf97hcU4i51tkaHxG6V/7rRF11pvFmhYGr//MhoJQ4TVYVDBqAcWLGch32pm/LHYSCbw0k11+GUe5asLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyrNY74r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D4C116C6;
	Mon, 19 Jan 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847664;
	bh=kC7Zj4+slaVhN0XLjBUuk1dKiurvs5ZgBe29k50UZRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyrNY74rnQ8quiv1V36gkrSUEMAZPyVcfAypqAIuMGU+tRwLVTtudqQp7vwcHpn0N
	 W/0nWK/dE9uLMhIYIVjLV5siiGjiDeQwEqG6QGv0KUmJMVoDfqPS7TSaP+N/oXU2Wo
	 nlpW2tbC7HGgEPqjidHXTSHwl3mFWnq1GMuumzXD2bls0fV1eXY1m5jU+3+3K4iIoH
	 A9cOvRal599V2P1ZSk/OyaPMQQ+5XFybuWpUdmrEkgSMFFJ77dERGfjMOXJaQqo8yY
	 h81HTtQa+LKoJxrP3NcJHooUTdc3cLQQ+Azz4EwcCzODnvtdzuIVuYKXRE9awS0AI9
	 WsIAZxCjf4bbQ==
Date: Mon, 19 Jan 2026 20:34:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260119183420.GP13201@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org>
 <20260115155334.GB14083@lst.de>
 <20260116212425.GJ14359@unreal>
 <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
 <20260119065212.GA1423@lst.de>
 <20260119102857.GI13201@unreal>
 <20260119120311.GA23572@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119120311.GA23572@lst.de>

On Mon, Jan 19, 2026 at 01:03:11PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 12:28:57PM +0200, Leon Romanovsky wrote:
> > > > I can add some code to this series to do that, but I don't believe
> > > > I have facilities to test it.
> > > 
> > > Please don't add untested code.  If Leon wants the P2P support and
> > > volunteers to test it, sure.
> > 
> > I can do it with the help of how to setup the system.
> > 
> > > But let's not merge it without being tested.  And at least for NFS I don't
> > > really see how P2P would easily fit in anyway.
> > 
> > Chuck is proposing a new IB/core API that will also be used by NVMe too.
> 
> Hopefully eventually, yes.  Not in this series, though.

Fair enough.

> 
> > Wouldn't p2p be useful in the general case
> 
> Well, P2P into a CMB might work in nfsd in theory now that there is
> direct I/O support, but it'll require a lot of work.
> 
> So if you want to help to convert nvmet, the series to do that would
> be the right place to add P2P support, as with that we can actually
> test it.

If both of you plan to attend LSF/MM this year, and I receive an
invitation as well, we can discuss the future p2p roadmap in person
and how we want to move forward.

Most of the items from our discussion last year [1] have already been
completed or are on track for this or the next development cycle. The
remaining big item which is left is removing SG from RDMA.

Thanks

[1] https://lore.kernel.org/all/20250122071600.GC10702@unreal/


> 

