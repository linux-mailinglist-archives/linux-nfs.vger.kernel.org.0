Return-Path: <linux-nfs+bounces-18047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01AD38848
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041B23011408
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A02FD69D;
	Fri, 16 Jan 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5bFBM+8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011828C009;
	Fri, 16 Jan 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598670; cv=none; b=ELCEDZ29iZeElbmeh4jqegoiNZQzq6Jz2gfdeTNkOrIOiZ/FmesGrAkei459Eo/+VntIAO4yM4zFIyZVlF4WmU7ptJ9gLC5NwWnCt55XdvMFTmaY0V1jJcxIsvSZGzVEPU6v7koIMs5BylJnes6Kl5mOd50wPI1rggWTXmUzBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598670; c=relaxed/simple;
	bh=W2uy+Hy/9yj0l7eJQqGwJsaDCwJPe31X60DctMsd9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ8bay5DUxaRP14KW5q1NGyfMYtRRUim4z0CBh3WLxKlNVR2Atw1JxjkGRmo0531CU4vuSRq/Paug4fvWEJm0cwhjvKlsg6GzzmYqw+yfmT6afQpAzWlWgPBRDF2uYn+0cM6iWGFmgmdCRQLZ773CuE0Pfu4FLP1Tv6G/7ANI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5bFBM+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F7DC116C6;
	Fri, 16 Jan 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768598670;
	bh=W2uy+Hy/9yj0l7eJQqGwJsaDCwJPe31X60DctMsd9qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5bFBM+8kx0yTUcnfKu/ZjqYjzivsSH7bkk+sA8SpFg/HMivon2DamkmID061f5+t
	 Xsjqwz1DMI5iXDaFRlbmHr6HcSptL0+fHAdTu6ke3jwiF9yeiqOqhPYiz6O7jVYWDP
	 T8RCfAnEL/dUC0Z2sa0acFdCtxXqBmza8pB8BhH8YqncZBkbyVXpfovaEBv4Klio2+
	 IVh8MAUISsK1rTEacPY6KDJGPodbTG80p8OrH9BMkLgsdU4UyYsUUmH6bbhZSTPzzz
	 kOy+je9tIUDX4dtKbnT0ZZFkWFMnWmQRp3YgbsG7iV+KKEY+Yg+e0ssjF7XZjJPdXE
	 Lryz4zeTyne1Q==
Date: Fri, 16 Jan 2026 23:24:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260116212425.GJ14359@unreal>
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

It would also be worthwhile to support P2P scenarios in this flow.

Thanks

