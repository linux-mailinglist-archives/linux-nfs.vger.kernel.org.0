Return-Path: <linux-nfs+bounces-18075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DED38FBB
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADDF9300646B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDE1DFE22;
	Sat, 17 Jan 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkbD9D6I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F61CBEB9;
	Sat, 17 Jan 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666863; cv=none; b=BTiE9o14GHeR6DOEDkEhgssFSFKCyA6BNgMct+bpGW+4VkDTGetod7mfyW+KqDjozt3NNhxwKa+VoeZQ3MVMPmMjoybPFk1VZMmg4DI/tkdT7RFBX86x/F5EFikwzlBFYGfBnXsAw07FEJdXOlLKYWt+qBVhN73xlTDyKVe2Wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666863; c=relaxed/simple;
	bh=sRXEST3Md9NKabX8+tV6FEXGznunHpmfHxng/9coMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ/t5e38YaG4h6YH9WbxmYuDIsE4Hd9iDGgb4J/MMNmEgJVtcoJ6HxzAWDpyQO8FXTwFt/XVCaDMjYhtuhC401HeTfDAFaGm2EpwKrrvv2GNTprDfKY9L90LKPFAWCAA1uGsPyfGiU2U+hevGxYx/JGP3BMh0AmEk1tOT3hqZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkbD9D6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66783C4CEF7;
	Sat, 17 Jan 2026 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768666863;
	bh=sRXEST3Md9NKabX8+tV6FEXGznunHpmfHxng/9coMas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkbD9D6IG4dua8VJJV1QmtU8feqZX28mmbKnPaZpZ+gnILyJZV0c5KDqFI4vPOYa9
	 Cz5zf0o0NzC0mDcKuwP3Z2lmQE/oUg5y78uFns7YcPVrD70jkx+Flze6u7HMcXvREp
	 0h3G/al3nieFRSqgQo/k5diHew1xnxZFl6W5o+v5HQxkWsOHKfnQInSBCi2AIdyedB
	 YTev55rAi30J+SnNCR+M7PQZYJ/ktw2ewj0+ceQcRI0n+83ZLTF9JYCwwUiWYpmBnT
	 SEe5uY74zYAWLZftiidIvdkuFFAuCKZIpSItuT/3YFi5qDTftAq5fXS/EID08qozGp
	 c4dmFydSbhYHQ==
Date: Sat, 17 Jan 2026 18:20:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260117162056.GK14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org>
 <20260115155334.GB14083@lst.de>
 <20260116212425.GJ14359@unreal>
 <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>

On Fri, Jan 16, 2026 at 04:49:06PM -0500, Chuck Lever wrote:
> 
> 
> On Fri, Jan 16, 2026, at 4:24 PM, Leon Romanovsky wrote:
> > On Thu, Jan 15, 2026 at 04:53:34PM +0100, Christoph Hellwig wrote:
> >> > +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
> >> > +		struct ib_qp *qp, const struct bio_vec *bvec, u32 offset,
> >> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> >> > +{
> >> > +	struct ib_device *dev = qp->pd->device;
> >> > +	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
> >> > +	struct bio_vec adjusted = *bvec;
> >> > +	u64 dma_addr;
> >> > +
> >> > +	ctx->nr_ops = 1;
> >> > +
> >> > +	if (offset) {
> >> > +		adjusted.bv_offset += offset;
> >> > +		adjusted.bv_len -= offset;
> >> > +	}
> >> 
> >> Hmm, if we need to split/adjust bvecs, it might be better to
> >> pass a bvec_iter and let the iter handle the iteration?
> >
> > It would also be worthwhile to support P2P scenarios in this flow.
> 
> I can add some code to this series to do that, but I don't believe
> I have facilities to test it.

If it is possible, let's add.

Thanks

> 
> -- 
> Chuck Lever

