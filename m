Return-Path: <linux-nfs+bounces-15542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9BBFE4EE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 894974E8648
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682C2798FA;
	Wed, 22 Oct 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2dYJAfD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0088277C9A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168341; cv=none; b=K/8vXKFkxREUSogk+1fd3mgaZQT+SeNaw/QOEfoQ1c5L9m2Gbw89GUsB6iomRsq4+7Oa4tjyEO1lwdD6ioNkfLK++/z0GSWL1uS5LeXyXOjeSrJ4NOz8ngZOkCd3/WWMrXDHiJKA1KF3u/wf9hpPwpiHkrSgHxuZuD9BZokZFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168341; c=relaxed/simple;
	bh=9wZB7A3Ymy4+9jdF4as6jX0kQ33fL/2H3xQ5cqTXGKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3zBZSCH06bGO639xrs4LlWgY3CbeS/OdtcJJSC9gahxctOpu0ZVI+k6rrvxFwlqzxP9J6UwOY2/NjB0mzwtC8v1oyUaxdmH1qh8v8DV6wGfIUnMvFUy0IHix96RoqKnBNcOBXmCpornvLmRDrQCtbk5HJTymE/KuBkEMZBmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2dYJAfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B0FC4CEE7;
	Wed, 22 Oct 2025 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761168341;
	bh=9wZB7A3Ymy4+9jdF4as6jX0kQ33fL/2H3xQ5cqTXGKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2dYJAfDmGCUIWGKWmwqDvFtswW91fYO2E/gU5Djw/ekFDI/8BM5VEYU+8f4FDD6e
	 kD1PWHLpBfdL+ViSojDgdtSSEc4SlXfrdZ9P8iyWIP3vaLfAueVvM+xSiGlYGKv+eI
	 BiXerJXw8za1L4ag0v/c6PYdUao0tyy8CXP6x2c+06ZOAQ///cmzgIweKhE/KMzKrr
	 1bOswQmmfnnVpBMh120p/tn0vrXp95dlaNcUyS44hrog4b+OVdDiHkfqCxHyyBfbk3
	 qz8eYRnNooS/BZN8aoCJz7+lkiT89Jf0v99UbLdEq+TUlrH74bAgKg6MvSZoaZwzhk
	 73ZzxJ3Hq8/9Q==
Date: Wed, 22 Oct 2025 17:25:39 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 5/5] svcrdma: Mark Read chunks
Message-ID: <aPlL0_fIfGwNbZBF@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022192208.1682-6-cel@kernel.org>

On Wed, Oct 22, 2025 at 03:22:08PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The upper layer may want to know when the receive buffer's .pages
> array is guaranteed to contain only an opaque payload. This permits
> the upper layer to optimize its buffer handling.
> 
> NB: Since svc_rdma_recvfrom.c is under net/, we use the comment
> style that is preferred in the networking layer.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index e7e4a39ca6c6..b1a0c72f73de 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -815,6 +815,11 @@ static void svc_rdma_read_complete_one(struct svc_rqst *rqstp,
>  	buf->page_len = length;
>  	buf->len += length;
>  	buf->buflen += length;
> +
> +	/* Transport guarantees that only the chunk payload
> +	 * appears in buf->pages.
> +	 */
> +	buf->flags |= XDRBUF_READ;
>  }
>  
>  /* Finish constructing the RPC Call message in rqstp::rq_arg.
> -- 
> 2.51.0
> 
> 

This patch header leaves me unclear on your thinking for upper layer
optimization that would look for XDRBUF_READ.

I see rpcrdma_marshal_req() is checking XDRBUF_READ but...

I'm left hoping for a clearer payoff on this change's benefit (and
relation to the rest of the patchset).

