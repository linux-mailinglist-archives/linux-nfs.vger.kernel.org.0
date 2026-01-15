Return-Path: <linux-nfs+bounces-17908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE5D25820
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763AD3011433
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6297350A05;
	Thu, 15 Jan 2026 15:53:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D621FF1B5;
	Thu, 15 Jan 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492420; cv=none; b=Lzr2eh0isN1MOtu1gG7thHN5XcJqvQIQtBYqrI5ovEVNzArcbZAIA4eQbBT0SzamqrKUqnyQ4E7ORopyqGGOGPF961fk6chDGpwWBELDh+6d7dt4wZUL5dq/EaRgG/3YrJfdTLYyoLzM0x39XoH/H3Z3YW1bR7Y6WI3zNAuM0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492420; c=relaxed/simple;
	bh=4M3gi+6LjIiiNnYKFq26ltk00DM4YAmxvMhhdVnCm80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3/cMpQzHpi4ZQv4DfUsXp1eGMvxMgy5JHzKuYsXyfmO8cHIScWcwh69u00bLR31Tz1IVvjSGLBNcEoK0MFTSNQBxqWljbZbbfnuYKoVimYs18W1CzayoSpao9mrS0j+29jXNDCIaMgtDoN1ZcUjiRZFwhLpVzmDa72mPbd2E2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C505227AAA; Thu, 15 Jan 2026 16:53:35 +0100 (CET)
Date: Thu, 15 Jan 2026 16:53:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260115155334.GB14083@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-2-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
> +		struct ib_qp *qp, const struct bio_vec *bvec, u32 offset,
> +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> +{
> +	struct ib_device *dev = qp->pd->device;
> +	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
> +	struct bio_vec adjusted = *bvec;
> +	u64 dma_addr;
> +
> +	ctx->nr_ops = 1;
> +
> +	if (offset) {
> +		adjusted.bv_offset += offset;
> +		adjusted.bv_len -= offset;
> +	}

Hmm, if we need to split/adjust bvecs, it might be better to
pass a bvec_iter and let the iter handle the iteration?

> +static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> +		const struct bio_vec *bvec, u32 nr_bvec, u32 offset,
> +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)

Much of this seems to duplicate rdma_rw_init_map_wrs.  I wonder if
having a low-level helper that gets either a scatterlist or bvec array
(or bvec_iter) and just has different inner loops for them would
make more sense?  If not we'll just need to migrate everyone off
the scatterlist version ASAP :)


