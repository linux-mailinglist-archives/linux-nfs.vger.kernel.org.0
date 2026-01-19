Return-Path: <linux-nfs+bounces-18100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CBD3A7B8
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B024301D5CB
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DE358D0B;
	Mon, 19 Jan 2026 12:03:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE22D060E;
	Mon, 19 Jan 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824198; cv=none; b=CsAaLS2rY4je7fRKV84cVzk30G7+7fKsHNwkRqpZ/zqsFMcyABWrjRyBrtRfWOLHN9MFHsq09Qg8jzwVj5t9PAtYBxd5nKXbWITLunq5g5G3cyugE5exleoKU227MtQ7En4iocgQD1+p2gRbXNYBB7fcFYYoXTe3CptQI2zoR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824198; c=relaxed/simple;
	bh=XqGBPFlJdxLj9splqUfTN5Cfiy4SlE2QEAk+PnSoUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7skFjZDlPzEp/8FsOBHO5nc1BydH3wKeGXhcd+3nuX+TRMWgP5zafZBam7ujPuV4OjP7RjSG9R5HbbSijooS3hFjTT2cwbwPiNvJ+Atfeta3eNd573iiEnA7G7YWUG8pOw3Kdwy2XT/U0V3//y+Tfb00v/suHrJMk+f2d0/kpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68664227AAA; Mon, 19 Jan 2026 13:03:11 +0100 (CET)
Date: Mon, 19 Jan 2026 13:03:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260119120311.GA23572@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de> <20260116212425.GJ14359@unreal> <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com> <20260119065212.GA1423@lst.de> <20260119102857.GI13201@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119102857.GI13201@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 12:28:57PM +0200, Leon Romanovsky wrote:
> > > I can add some code to this series to do that, but I don't believe
> > > I have facilities to test it.
> > 
> > Please don't add untested code.  If Leon wants the P2P support and
> > volunteers to test it, sure.
> 
> I can do it with the help of how to setup the system.
> 
> > But let's not merge it without being tested.  And at least for NFS I don't
> > really see how P2P would easily fit in anyway.
> 
> Chuck is proposing a new IB/core API that will also be used by NVMe too.

Hopefully eventually, yes.  Not in this series, though.

> Wouldn't p2p be useful in the general case

Well, P2P into a CMB might work in nfsd in theory now that there is
direct I/O support, but it'll require a lot of work.

So if you want to help to convert nvmet, the series to do that would
be the right place to add P2P support, as with that we can actually
test it.


