Return-Path: <linux-nfs+bounces-17902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BED23B3E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14589300EE6C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012735EDA3;
	Thu, 15 Jan 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH+ihF/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40735E554;
	Thu, 15 Jan 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470605; cv=none; b=fczPcT51xjPQHtGQo//qMWzdPj0EsjlOJQ9/B9Be9bx6R9pcP5BPWwO1+vqyl10ERFYj1CNuVlqy+KE6D0O/WaC3iJrLUILKNqwprb62EKe+wYA7KgLVxAOhPiIHKGh6WN5sztxLhk5MF6mbQq1/Qr/i5ODPmhm/d3zJa9TToSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470605; c=relaxed/simple;
	bh=nWpTNQTecvtAu2Rp9pmV5c6Brq1O6zAz3WjevSE/eVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTTfiWsf+z6fqyYkhi3V8GdPXV99L/oeeffvA8o2G0Tw4tPoBBS7/yxsjBCv3KYIvNIgk3JYvUiLeVk//K8bcH1IiGcWT7FJiRkD458rhzYW6oVAJjeB9qpgOYgM1P2p0VS3Hz3OeArMNoMTQ0nnvZhqbcmcXt8aIY4eyZ/oHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH+ihF/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72086C116D0;
	Thu, 15 Jan 2026 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470605;
	bh=nWpTNQTecvtAu2Rp9pmV5c6Brq1O6zAz3WjevSE/eVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BH+ihF/S/kDKyRJEQnALQoazoUbe53m4KZI3zKvg7ysQoiyiuOzqf6JNyNbVun2LP
	 T4NO+sTd205FcJEz7jyY3pHSNabDPZVHXzN3jlcFeae/eCdfwH4xMBoWThahpoXNYG
	 Ojy0wEmRppDj0yI38z7xz/r/MCG4ueUEww6YRZGhpGlzRSuu7kKxO7ZjV1HcuihvQz
	 jZ6HkIlHQQ8wA4mbg5qe8rYy9Ed+q/NJWA5PumdZeDw2hrL9hMVBkxD4PwQkpzKWCp
	 1WoEErpYDi3t+eO8kkygyMUtBNREdoANZjs97IJAao2kSNPREL29Hzh0nCx0kSr0Za
	 qdMtjBMDpG4BA==
Date: Thu, 15 Jan 2026 11:50:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 0/4] Add a bio_vec based API to core/rw.c
Message-ID: <20260115095000.GA14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114143948.3946615-1-cel@kernel.org>

On Wed, Jan 14, 2026 at 09:39:44AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series introduces a bio_vec based API for RDMA read and write
> operations in the RDMA core, eliminating unnecessary scatterlist
> conversions for callers that already work with bvecs.
> 
> Current users of rdma_rw_ctx_init() must convert their native data
> structures into scatterlists. For subsystems like svcrdma that
> maintain data in bvec format, this conversion adds overhead both in
> CPU cycles and memory footprint. The new API accepts bvec arrays
> directly.
> 
> For hardware RDMA devices, the implementation uses the IOVA-based
> DMA mapping API to reduce IOTLB synchronization overhead from O(n)
> per-page syncs to a single O(1) sync after all mappings complete.
> Software RDMA devices (rxe, siw) continue using virtual addressing.
> 
> The series includes MR registration support for bvec arrays,
> enabling iWARP devices and the force_mr debug parameter. The MR
> path reuses existing ib_map_mr_sg() infrastructure by constructing
> a synthetic scatterlist from the bvec DMA addresses.
> 
> The final patch adds the first consumer for the new API: svcrdma.
> It replaces its scatterlist conversion code, significantly reducing
> the svc_rdma_rw_ctxt structure size. The previous implementation
> embedded a scatterlist array of RPCSVC_MAXPAGES entries (4KB or
> more per context); the new implementation uses a pointer to a
> dynamically allocated bvec array.
> 
> Based on v6.19-rc5.
> 
> Chuck Lever (4):
>   RDMA/core: add bio_vec based RDMA read/write API
>   RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
>   RDMA/core: add MR support for bvec-based RDMA operations
>   svcrdma: use bvec-based RDMA read/write API

Amazing, thanks a lot.

I haven’t done a deep‑dive review yet, but from what I’ve seen so far  
it looks solid and well put together.

Thanks.

> 
>  drivers/infiniband/core/rw.c      | 492 ++++++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h           |  35 +++
>  include/rdma/rw.h                 |  26 ++
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 115 ++++---
>  4 files changed, 608 insertions(+), 60 deletions(-)
> 
> -- 
> 2.52.0
> 

