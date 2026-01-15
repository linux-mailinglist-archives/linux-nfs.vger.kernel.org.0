Return-Path: <linux-nfs+bounces-17909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982ECD2594B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C83B3013955
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091A345758;
	Thu, 15 Jan 2026 15:58:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304E3AA1A8;
	Thu, 15 Jan 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492688; cv=none; b=XH6yDpuB70NnJ2l5N0PQNLPK7/6GJXLUOs0kXrT5Wf482A2oWnQfk86YS07uDQvcUycMrOgH6rJouLJZPHlMw+OiFwe2e2KBotBGMOmy6wME0K70V6H6knMl7ZY2rL0SQKXLyX/xkBfDYGVrg8i0yweoEDrTevd0MoJPH0jt2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492688; c=relaxed/simple;
	bh=ONYTheqh+JtrHJNHzVLdBd/h0JxAXlS3FbCaorhreT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2EJ4JikLQTA99PJWymddtvVyQ5NYjq6Dd+1nkBGKdtde4NAHUT6i3mrSvf7Qg4DBOi2SmZCnLTFd5fTpag+lHalz+JyfZ5V2LIT6Gr8l5cEFgSPorqrLqVP4uYTrvbLszvIzNX6C4KLvZQ8LsCMduW1jXhPZ3mReLQLSOylUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1719227AAA; Thu, 15 Jan 2026 16:58:02 +0100 (CET)
Date: Thu, 15 Jan 2026 16:58:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 2/4] RDMA/core: use IOVA-based DMA mapping for bvec
 RDMA operations
Message-ID: <20260115155802.GC14083@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-3-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/* Calculate total transfer length */
> +	for (i = 0; i < nr_bvec; i++) {
> +		size_t len = (i == 0 && offset) ?
> +			     bvec[i].bv_len - offset : bvec[i].bv_len;
> +
> +		if (check_add_overflow(total_len, len, &total_len))
> +			return -EINVAL;
> +	}

The caller should usually have that value, so maybe pass it in?
(also using a bvec_iter would fix that)

> +	ctx->nr_ops = DIV_ROUND_UP(nr_bvec, max_sge);

I don't think this part is correct, but see more below.

> +	/* Link all bvecs into the IOVA space */
> +	for (i = 0; i < nr_bvec; i++) {
> +		const struct bio_vec *bv = &bvec[i];
> +		phys_addr_t phys = bvec_phys(bv);
> +		size_t len = bv->bv_len;
> +
> +		if (i == 0 && offset) {
> +			phys += offset;
> +			len -= offset;
> +		}
> +
> +		ret = dma_iova_link(dma_dev, &ctx->iova.state, phys,
> +				    mapped_len, len, dir, 0);
> +		if (ret)
> +			goto out_destroy;
> +
> +		mapped_len += len;

This creates a single contiguous IOVA for all the passed in bvecs,
even if they had non-contiguous host physical addresses.

> +	/* Build SGEs using offsets into the contiguous IOVA range */
> +	mapped_len = 0;
> +	for (i = 0; i < ctx->nr_ops; i++) {
> +		struct ib_rdma_wr *rdma_wr = &ctx->iova.wrs[i];
> +		u32 nr_sge = min(nr_bvec - bvec_idx, max_sge);
> +
> +		if (dir == DMA_TO_DEVICE)
> +			rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
> +		else
> +			rdma_wr->wr.opcode = IB_WR_RDMA_READ;
> +		rdma_wr->remote_addr = remote_addr + mapped_len;
> +		rdma_wr->rkey = rkey;
> +		rdma_wr->wr.num_sge = nr_sge;
> +		rdma_wr->wr.sg_list = sge;

... which means that here you just need a single WR and SGE to register
all of them.  No need to split the IOVA space up again.


