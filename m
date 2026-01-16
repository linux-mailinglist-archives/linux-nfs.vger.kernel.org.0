Return-Path: <linux-nfs+bounces-18011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB9D3310B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D5C315747F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222629B216;
	Fri, 16 Jan 2026 14:52:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262612727FC;
	Fri, 16 Jan 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575130; cv=none; b=rRg4/SRwiDWwcoD5vu4Cft7N+HXPcY2gsch2yHAVVT6VvXqUjhnENL6khvjbneAjnSySdops8iTwe5Upd3axf1vCHaP1WN+nXtDRm7MX2Ya8ICYAu3iRKtyG/0mZXAbxQ0QrchGxKDakPDMJE7VHhtXsF7CZXYO/ISlZ8obI1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575130; c=relaxed/simple;
	bh=a4V11uDIvWsQi9kNavxROqzdTVhf8jDVMnbM7Jhx5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahjjEkPJrR6Rw44v/O5Xcln7S3jOt632oYtxZhFVrXjRoUiVLIrN3CUIN/Ca+PdV0+flho4nF33oElFoNOeNJdasaqk8MiuHZ0svVuRytYb0EFBror405SufWmKV1GnjQRU9EQCKHOaSk2pqgsKaI+XJijSbiF0EPaw6OeV4qKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55907227AAE; Fri, 16 Jan 2026 15:52:06 +0100 (CET)
Date: Fri, 16 Jan 2026 15:52:06 +0100
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
Message-ID: <20260116145206.GB16842@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de> <20260116113310.GF14359@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113310.GF14359@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 01:33:10PM +0200, Leon Romanovsky wrote:
> > Much of this seems to duplicate rdma_rw_init_map_wrs.  I wonder if
> > having a low-level helper that gets either a scatterlist or bvec array
> > (or bvec_iter) and just has different inner loops for them would
> > make more sense?  If not we'll just need to migrate everyone off
> > the scatterlist version ASAP :)
> 
> I had short offline discussion with Jason about this series and both of
> us would be more than happy to get rid of "scatterlist version".

nvmet_rdma_rw_ctx_init is used by isert, srpt, nvmet, ksmbd and
the sunrpc server side.  I don't think any of them should be
super complicated to work, but it will need a fair amount of testing
resources.

