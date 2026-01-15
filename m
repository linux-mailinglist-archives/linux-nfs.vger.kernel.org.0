Return-Path: <linux-nfs+bounces-17910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B795D25960
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B40304C6F3
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6153ACA62;
	Thu, 15 Jan 2026 15:59:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFC3B8BC4;
	Thu, 15 Jan 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492741; cv=none; b=BjgvjdMt8R1RA8aiJMA//I+i9gv+EBI4/F11ymtuVKALgCqvr3Hujw8R9nIZOnJXENZxF+pWW5KWCTKws8bv//stOISf5xLznhV3xxtWieNRZ0ffpa+uAFDW9wwIMpnMtIebXhvavN1RkmlpmprRg5L75aLAD0j/O70VWCUvcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492741; c=relaxed/simple;
	bh=DL5J6uYUZdEJKIrM//PuTeOleX6Th8U3xf+FGz3RH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ65aSYvHxD5t91ogB63g/SuU8wO4zQ0sdDUTmianIefq2gpqKyyPhKMNaP6XGxugo+xNIOucpdgbIKmqs86gY/DycXx0n+NN6mNpuCmwFIctHV0k2su0F/dORJQ/lf83tcP1vRcYr3yZUNGis3h/KyWeHoXN1LG87sFFPEcIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2F2227AAF; Thu, 15 Jan 2026 16:58:56 +0100 (CET)
Date: Thu, 15 Jan 2026 16:58:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/4] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260115155856.GD14083@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-4-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 09:39:47AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The bvec-based RDMA API currently returns -EOPNOTSUPP when Memory
> Region registration is required. This prevents iWARP devices from
> using the bvec path, since iWARP requires MR registration for RDMA
> READ operations. The force_mr debug parameter is also unusable with
> bvec input.
> 
> Add rdma_rw_init_mr_wrs_bvec() to handle MR registration for bvec
> arrays. The approach creates a synthetic scatterlist populated with
> DMA addresses from the bvecs, then reuses the existing ib_map_mr_sg()
> infrastructure. This avoids driver changes while keeping the
> implementation small.
> 
> The synthetic scatterlist is stored in the rdma_rw_ctx for cleanup.
> On destroy, the MRs are returned to the pool and the bvec DMA
> mappings are released using the stored addresses.

I wish we'd just have a bvec based MR API, and could use that.
But I don't want to hold this work back, because of that.


