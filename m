Return-Path: <linux-nfs+bounces-17982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A160D30814
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 12:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2723430FB42A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228A322B72;
	Fri, 16 Jan 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcB0Wuuu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3F313558;
	Fri, 16 Jan 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563196; cv=none; b=JvJhQjRS72H2lT1o7IehbiT8QEKqJd8YmGuU4XnOpseY5vn9gUeySiKUqMeZuTfgr6VgGK6GmPZTXGWWMan1H16lhyfvVevL0YW3CU7il8xIbfhT0MXKQovEQNXnov7BLJagNDC3vxcoc4fmz6fFAKJOM7ummEi3Ojk7AmP93+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563196; c=relaxed/simple;
	bh=3WG21Ebqt/7T+Hf+5Ue6MXAEaDAjCDoJNmNoj2/9qDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSf1sKLT/SVF4ow+IesMD0sv5yycEPMEPHAJAqBuKAy/XgwFRhQTwpvs+eKtOYpN+ZqLNnnCNvaRTlDH6Q8Lha+hLCYm9PizGzD+a7QC6jMmwtEcZdV5BykJlcw/nNyyxNSZa+R1VESQquaGpOxUuo/GJxw8RyjqqGchowam4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcB0Wuuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E8C19421;
	Fri, 16 Jan 2026 11:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768563196;
	bh=3WG21Ebqt/7T+Hf+5Ue6MXAEaDAjCDoJNmNoj2/9qDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcB0WuuuVc9QwF/OANAKxeqW39DtoTtE+wLP3b05OQXX7fpM07Q64tE6VrmTbG6XC
	 8Vv3tNqJvP+Jt2P4zgatFtRnqsiPPXV5Ocg3uyTflg366uznT4Rrqh+eQRqufvN2R0
	 6lFUQAvfqGaG0uu9tMO/XSRzNMSKNL41/ABPLN6btBZ9hzRITh/f27rAWzg6my9ru0
	 2HKxb7Q5HhkUBktFv4A3dVUIp0n65jwQhl1/A1Fo8VjtqFLhSIlgdgBe62aIpYf+Sx
	 DmUvxrPgNB1T7KoSCN/NmF5Lmw1fVLl0AvHGLNndfWnuZsYc7kJXyKXCl01/vOw1kD
	 w7Kg6egResUFw==
Date: Fri, 16 Jan 2026 13:33:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260116113310.GF14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org>
 <20260115155334.GB14083@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115155334.GB14083@lst.de>

On Thu, Jan 15, 2026 at 04:53:34PM +0100, Christoph Hellwig wrote:
> > +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
> > +		struct ib_qp *qp, const struct bio_vec *bvec, u32 offset,
> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> > +{
> > +	struct ib_device *dev = qp->pd->device;
> > +	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
> > +	struct bio_vec adjusted = *bvec;
> > +	u64 dma_addr;
> > +
> > +	ctx->nr_ops = 1;
> > +
> > +	if (offset) {
> > +		adjusted.bv_offset += offset;
> > +		adjusted.bv_len -= offset;
> > +	}
> 
> Hmm, if we need to split/adjust bvecs, it might be better to
> pass a bvec_iter and let the iter handle the iteration?
> 
> > +static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> > +		const struct bio_vec *bvec, u32 nr_bvec, u32 offset,
> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> 
> Much of this seems to duplicate rdma_rw_init_map_wrs.  I wonder if
> having a low-level helper that gets either a scatterlist or bvec array
> (or bvec_iter) and just has different inner loops for them would
> make more sense?  If not we'll just need to migrate everyone off
> the scatterlist version ASAP :)

I had short offline discussion with Jason about this series and both of
us would be more than happy to get rid of "scatterlist version".

Thanks

