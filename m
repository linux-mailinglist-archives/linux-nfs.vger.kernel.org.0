Return-Path: <linux-nfs+bounces-17903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3BDD23B56
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5201530313CD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000935EDDC;
	Thu, 15 Jan 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tonqnNnj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06435EDAD;
	Thu, 15 Jan 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470664; cv=none; b=Dt2vS8R8o/w3PHH7Nyd8Bu9L0r7n8qUc7tWxoqhTJVUncWTs0fY8GXBb2HLyev+pE07mIfhSUWqR1MApU8nWmBeZXsWSx4gETje4kccOhI2UxtmxwsqXDgm4P0aOX+ZY9oloGOPK70LzAUJAo2ghSzxr+OcNXRZ23bYvHmmvEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470664; c=relaxed/simple;
	bh=t0Mz1QXqjEvcLUzCNWQjw/rIfYPkHY0UFaVM0BkO7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqF2ksfBfV7B93f/RVJ2J0X/MFlFWtSkhK9c02Ym5Bz4mFQHY+ew23zJWGNQz3EGf4vi9WsAIJTHadqdIB3L0M9dIeq/no9a6gYa116o4QamJOkVCuF+HGbkRQF28gKovIaZHLpdmbeTYzgwLslLlZ/GMo5p2lFkD4bJMueZ1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tonqnNnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97680C116D0;
	Thu, 15 Jan 2026 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470664;
	bh=t0Mz1QXqjEvcLUzCNWQjw/rIfYPkHY0UFaVM0BkO7AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tonqnNnjfuz5DW1mDPsuThM7KwaR/3CztyXqGt3PfrZA5mdse15LX6wTrEcphRFw3
	 WGwwuxNIzufHuuKy8iHksBQK4ONcHMl+nit/YzPG7KFcaZpiy1VBYyUxlFgL/16W2K
	 a/SNayngL9x2WBGnPSanwO6ExAa0UIXqcjDiBTqpjkZdnmCjzB45l3v6vMQfCOb0VK
	 yoOG9TWnlmm9CpjXu0Q1m+SBBA7qjxaj9TNubQ8Ih3qOJ63naFYvJO1btKnbqx0rn2
	 6WS6sp1XKRNhjLoZelI+w9vPVhekcFl2mFKzNr7s3VQmL5q7fy6x8AO+vWyojfRP1F
	 KhggY3Ugy30bA==
Date: Thu, 15 Jan 2026 11:51:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Message-ID: <20260115095100.GB14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-5-cel@kernel.org>

On Wed, Jan 14, 2026 at 09:39:48AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Convert svcrdma to the bvec-based RDMA API introduced earlier in
> this series.
> 
> The bvec-based RDMA API eliminates the intermediate scatterlist
> conversion step, allowing direct DMA mapping from bio_vec arrays.
> This simplifies the svc_rdma_rw_ctxt structure by removing the
> inline scatterlist and chained SG table management.
> 
> The structure size reduction is significant: the previous inline
> scatterlist array of RPCSVC_MAXPAGES entries (4KB or more) is
> replaced with a pointer to a dynamically allocated bvec array,
> bringing the fixed structure size down to approximately 100 bytes.
> 
> The bvec API handles all device types internally, including iWARP
> devices which require memory registration. No explicit fallback
> path is needed.
> 
> Signed-off-by: cel@kernel.org

Something went wrong here.

Thanks

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 115 ++++++++++++++----------------
>  1 file changed, 55 insertions(+), 60 deletions(-)

