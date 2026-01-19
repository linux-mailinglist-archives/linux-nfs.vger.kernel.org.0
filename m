Return-Path: <linux-nfs+bounces-18091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D9D39F16
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06173035260
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05A287505;
	Mon, 19 Jan 2026 06:52:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287822459EA;
	Mon, 19 Jan 2026 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805538; cv=none; b=u+fOfAjbv85IDMHCL15t/26bstqmeA3EvoVOxrmvWsMfTeDQaOXrgHLkF7aY11gcP/Zi20jtWd8TSitQhEIwKOBO9gv7ywxEHoaT1y08OQiy6k7nKmQecxg4tD8MFytzQVwM/7P4dARgsoLUbwPJS2keVNevZzPZlzJUXFpXxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805538; c=relaxed/simple;
	bh=Q753m7de5nYqusEsxRM43A55ThTcgAVg3CD6Dyp3Kpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opjcLBI/Q74qULJ2b/iOxQ/L5dC2PFb78WYqZR/+MZtJsQsfzZ+dzbX9xv987iW4lmEyVrEvcdWkM74SRZS13bSkDAblh+hplmKDyMJwMS31Y4p7quX+YW14LHFbXhKK87oGzvQUiQdPkdh9YV1Jutq337NSphGb0T38fInUJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB433227AA8; Mon, 19 Jan 2026 07:52:12 +0100 (CET)
Date: Mon, 19 Jan 2026 07:52:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260119065212.GA1423@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de> <20260116212425.GJ14359@unreal> <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 04:49:06PM -0500, Chuck Lever wrote:
> >> Hmm, if we need to split/adjust bvecs, it might be better to
> >> pass a bvec_iter and let the iter handle the iteration?
> >
> > It would also be worthwhile to support P2P scenarios in this flow.
> 
> I can add some code to this series to do that, but I don't believe
> I have facilities to test it.

Please don't add untested code.  If Leon wants the P2P support and
volunteers to test it, sure.  But let's not merge it without being
tested.  And at least for NFS I don't really see how P2P would easily
fit in anyway.


