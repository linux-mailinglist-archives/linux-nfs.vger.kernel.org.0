Return-Path: <linux-nfs+bounces-3572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F998FD696
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B483828945F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1914F9E2;
	Wed,  5 Jun 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1uytN83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773014F9DC;
	Wed,  5 Jun 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616092; cv=none; b=f6IbVZHjM7HuhA0YYbIeJ7LynyO5GEpKgVVJHZ4/Ggg4qEG8Q7G3QAcXsLKU0Fq41LwaVs9SsUhgozB/1vrliQVV3HwpLEnb+Z72wW4iI0WrMXt59eQZI8hsQRzAsRkV6vc5RJJzC4N8OkxDwOxbCb+LNT+e6J8EzY4u9yxa+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616092; c=relaxed/simple;
	bh=yVyf1BEIcx2PVrcM0FzZ6v+qCcABJKlb6amnTW2XPss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXGcodu9LUyDMKpUH0dLmqwA6OTpBf9N9YzB2gyVGoQzUV3yjuOg/SzxPq/aQlyfawJLkI2qT6y6qBTQhRLBTs/4dmBwxGlV9ENsddw0TgNP2guzcidEprf6HR/eR4jmZreWD5n9P2GGpEPvi6pnoOCqmoEvIyg9ofRIm9gL3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1uytN83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A3BC2BD11;
	Wed,  5 Jun 2024 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717616092;
	bh=yVyf1BEIcx2PVrcM0FzZ6v+qCcABJKlb6amnTW2XPss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1uytN836kqqNSpPm21fQWQ9tDx8HOwIq7GOSEmweKH9ycOepJ0zCgBofLtT1p/dG
	 cuIX8ZUqnd8bnsCFD0HE9pgHSJi/t2eVMOq6Gt4cq5UnvFfoFI+BcIeMiKzCIYfqSu
	 GBSL3KeleELK9NBb9ei8OAg6Xubr0DXG7VmZOeKdIzJ8Eitj+tsjqP0rNtFsVNVdug
	 gkqli/i0nuQuoDZgdj3YtELuGsXdyYdgLwCEByNMxsOXQKHgXBdWlfdovE79vUPGsD
	 x0Z5eKW1vDm5bGlFp2LexVD1g1rs3BPid9SyXWxqOnKP3KtwFwoYUEwUkhdkvfOdCB
	 iOoIas/6pcuqA==
Date: Wed, 5 Jun 2024 20:34:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] nfsd: allow passing in array of thread counts via
 netlink
Message-ID: <20240605193446.GW791188@kernel.org>
References: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
 <20240604-nfsd-next-v1-3-8df686ae61de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-nfsd-next-v1-3-8df686ae61de@kernel.org>

On Tue, Jun 04, 2024 at 05:07:56PM -0400, Jeff Layton wrote:
> Now that nfsd_svc can handle an array of thread counts, fix up the
> netlink threads interface to construct one from the netlink call
> and pass it through so we can start a pooled server the same way we
> would start a normal one.
> 
> Note that any unspecified values in the array are considered zeroes,
> so it's possible to shut down a pooled server by passing in a short
> array that has only zeros, or even an empty array.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

...

> @@ -1690,15 +1691,22 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	mutex_lock(&nfsd_mutex);
>  
> -	nrpools = nfsd_nrpools(net);
> -	if (nrpools && count > nrpools)
> -		count = nrpools;
> -
> -	/* XXX: make this handle non-global pool-modes */
> -	if (count > 1)
> +	nrpools = max(count, nfsd_nrpools(net));
> +	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
> +	if (!nthreads) {
> +		ret = -ENOMEM;
>  		goto out_unlock;
> +	}
> +
> +	i = 0;
> +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> +		if (nla_type(attr) == NFSD_A_SERVER_THREADS) {
> +			total += nthreads[i++] = nla_get_u32(attr);

Hi Jeff,

A minor nit from my side.

Total is set by otherwise unused in this function.

Flagged by clang-18 W=1 allmodconfig builds.

> +			if (i >= count)
> +				break;
> +		}
> +	}
>  
> -	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_THREADS]);
>  	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
>  	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
>  	    info->attrs[NFSD_A_SERVER_SCOPE]) {

...

