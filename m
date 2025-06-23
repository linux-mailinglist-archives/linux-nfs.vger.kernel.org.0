Return-Path: <linux-nfs+bounces-12676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB7AE491F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26523A1B54
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2126D4F7;
	Mon, 23 Jun 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UG5DegPJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FC25F98E
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693654; cv=none; b=jqr2vJBC+N0wSu2rnCm8fchqNv2hk3nsV7YUwSynNPD2DeEvO6wNuFwqFZR42BOM6Ec01b8Ta35WxuReARAKuDhGP+ckZNHC8EQK8plHC8H2dUPV8XLShuiuf3Gz+qLX+0jMMtXqXFuWWIiRScOCxjhlSHNrRyO3a19/OVD4Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693654; c=relaxed/simple;
	bh=EKG14ZOQzaaYGD3X0xzYAfmF2d6RXXI1/3I7QMJPo/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfEWo2pBjoe2QOySbC81MHKbVXj5+4fSZg4ARZeHA242ciKN8MEN83GZJkLT88CZHEvNMFpRvDgXwBTbSS3VeZqOk4K8jnHRgslqC/fR+0f/cyA9DbVo0qybcUMxfT4a4JH0soMrdeMdiFHEuI1kDhrkGHEAy+idbMkVTtYoMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UG5DegPJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4067b7d7e52so891723b6e.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750693651; x=1751298451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e19ex1p/1LBOnXetMuCg5KYZZ6yY9+nHnj0I40BuyDg=;
        b=UG5DegPJVq+xw1Nc4wanJ/3/PRJ0GCy0+gIuLP0s5v9DhBYWtThZIPoOLukvJclAB+
         MFTYd2YJOu8sSj7ib6bJ556pVMUeAyHTRQpEaUumGGfl65PspzMllXH40nrQiDUVa7uM
         io5RuJ4EVaqGfoUqxNQPCDi5Zd9Ai7kFnA2WPn3GDwUKCY3bDVDSK0nJpcVU9Cbhfryo
         L09+Y4/TAMf2sWITydkotyU9Ne2eGo2oy/8hbBu4K/qP93MerRdokkuuSomYVYdYNceN
         y3OanasJ6FODGWbMip5KAYLrptivE+573UC3MeAVXqZ0BlU/eZ5H5JwMatYtflaXu8gH
         XKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693651; x=1751298451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e19ex1p/1LBOnXetMuCg5KYZZ6yY9+nHnj0I40BuyDg=;
        b=p5YeMh5ZAtPv6Aqq+2AVCCBKOdBxVG1ltfsyTEBaXYQKNsa6+Zdcbcizqtf3d9So4p
         y8+cUMvPpMzLl5ny9c8g7T8Q0NTgLZeZVMbZV750LmyzeHvzxygCbF5Cx2Dn6h+Ib11c
         q456bg3XC4SZWJ4tegjQZWWG0CAYoXn9DrVztNzjEo6N94SV834GDC9BkbOYaXMtmluQ
         xBhPdU18TEhRF+gnKFsXYHBYlASxMURO4+9D+qeEGu/xl7QLCAW9om4wSQ12rAsO6zII
         /Z2bCnziqCASeUYOS6VOGKtG7PeIR+p8m5Aep83OoAS2f2lljl1BopKV9WSnFZEGUfTE
         C82A==
X-Forwarded-Encrypted: i=1; AJvYcCXnmcYYE6/z6rpqFmaBzVpp7JnZTtK+Atzf+0dZa1LnQ/LJ04k5CR5H2McWNw8j+LI1Ek96v49MqJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6i+W6nk8YqQ839u2m8ECZ9OZONiMD1aTMC7ftQD3uzI+O9gv
	SNaJh2Ws7lMrZPgI2OaPfKG0Bpu/xaz95yHOIz/gjR76TCEXivdIWYidmJ8E/zvQzUY=
X-Gm-Gg: ASbGncvDkyIUdnSbADou2Ltt7OwJ/ND71dXrdhJNDWIzMQFWNBwKcsqmHgUvPnhbBL6
	blxELJ7OzNRI/eSFNuRLpHOOGUZHFUVlK1zR6RrvGmi5T0sBAEqw2IqogqbM+ipe5vp8Fizm6rU
	xtKfvf/HEmL4aQtI1w0kZGQCk50L7+NSTMY5tNHeBit9OayBOgOeIgyoXtS63Rwj+krj3LM8vrU
	DgApgvN990Yyn9ghi0sFlD2Gs82AIGdWXaIqMflBzHzGLtTlh4Ha+YtgkUg9zg/5adZhWRqWC5U
	x9Ub2jqzUoP1/cZQHvDW7yV7Rk7H1u+s+ubl0Pi9Wd2b9XxmU4X5jfwkksgQuuDlKApcYg==
X-Google-Smtp-Source: AGHT+IEouOoMNRNSuGf/ZMWbMPa3V8T1EO2Pbz1snAOvKwdQBof5o9MTJimT5y50shcK8/7BDOdy9A==
X-Received: by 2002:a05:6808:1717:b0:406:5a47:a081 with SMTP id 5614622812f47-40ac7053a9dmr10755047b6e.13.1750693651415;
        Mon, 23 Jun 2025 08:47:31 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8c3f:8b5f:5c74:76a9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6cf03a7sm1411227b6e.25.2025.06.23.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:47:30 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:47:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Message-ID: <148c69b4-4cf7-4112-97e8-6a5c23505638@suswa.mountain>
References: <20250623122226.3720564-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623122226.3720564-1-suhui@nfschina.com>

On Mon, Jun 23, 2025 at 08:22:27PM +0800, Su Hui wrote:
> Using guard() to replace *unlock* label. guard() makes lock/unlock code
> more clear. Change the order of the code to let all lock code in the
> same scope. No functional changes.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index ba9d326b3de6..2d92adf3e6b0 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>  
>  	if (type == RC_NOCACHE) {
>  		nfsd_stats_rc_nocache_inc(nn);
> -		goto out;
> +		return rtn;
>  	}
>  
>  	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>  	 */
>  	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
>  	if (!rp)
> -		goto out;
> +		return rtn;
>  
>  	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
> -	spin_lock(&b->cache_lock);
> -	found = nfsd_cache_insert(b, rp, nn);
> -	if (found != rp)
> -		goto found_entry;
> -	*cacherep = rp;
> -	rp->c_state = RC_INPROG;
> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> -	spin_unlock(&b->cache_lock);
> +	scoped_guard(spinlock, &b->cache_lock) {
> +		found = nfsd_cache_insert(b, rp, nn);
> +		if (found == rp) {
> +			*cacherep = rp;
> +			rp->c_state = RC_INPROG;
> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> +			goto out;

It took me a while to figure out why we've added a goto here.  In the
original code this "goto out;" was a "spin_unlock(&b->cache_lock);".
The spin_unlock() is more readable because you can immediately see that
it's trying to drop the lock where a "goto out;" is less obvious about
the intention.

I think this patch works fine, but I'm not sure it's an improvement.

regards,
dan carpenter

> +		}
> +		/* We found a matching entry which is either in progress or done. */
> +		nfsd_reply_cache_free_locked(NULL, rp, nn);
> +		nfsd_stats_rc_hits_inc(nn);
> +		rtn = RC_DROPIT;
> +		rp = found;
> +
> +		/* Request being processed */
> +		if (rp->c_state == RC_INPROG)
> +			goto out_trace;
> +
> +		/* From the hall of fame of impractical attacks:
> +		 * Is this a user who tries to snoop on the cache?
> +		 */
> +		rtn = RC_DOIT;
> +		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> +			goto out_trace;
>  
> +		/* Compose RPC reply header */
> +		switch (rp->c_type) {
> +		case RC_NOCACHE:
> +			break;
> +		case RC_REPLSTAT:
> +			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> +			rtn = RC_REPLY;
> +			break;
> +		case RC_REPLBUFF:
> +			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> +				return rtn; /* should not happen */
> +			rtn = RC_REPLY;
> +			break;
> +		default:
> +			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> +		}
> +
> +out_trace:
> +		trace_nfsd_drc_found(nn, rqstp, rtn);
> +		return rtn;
> +	}
> +out:
>  	nfsd_cacherep_dispose(&dispose);
>  
>  	nfsd_stats_rc_misses_inc(nn);
>  	atomic_inc(&nn->num_drc_entries);
>  	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
> -	goto out;
> -
> -found_entry:
> -	/* We found a matching entry which is either in progress or done. */
> -	nfsd_reply_cache_free_locked(NULL, rp, nn);
> -	nfsd_stats_rc_hits_inc(nn);
> -	rtn = RC_DROPIT;
> -	rp = found;
> -
> -	/* Request being processed */
> -	if (rp->c_state == RC_INPROG)
> -		goto out_trace;
> -
> -	/* From the hall of fame of impractical attacks:
> -	 * Is this a user who tries to snoop on the cache? */
> -	rtn = RC_DOIT;
> -	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> -		goto out_trace;
> -
> -	/* Compose RPC reply header */
> -	switch (rp->c_type) {
> -	case RC_NOCACHE:
> -		break;
> -	case RC_REPLSTAT:
> -		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> -		rtn = RC_REPLY;
> -		break;
> -	case RC_REPLBUFF:
> -		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> -			goto out_unlock; /* should not happen */
> -		rtn = RC_REPLY;
> -		break;
> -	default:
> -		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> -	}
> -
> -out_trace:
> -	trace_nfsd_drc_found(nn, rqstp, rtn);
> -out_unlock:
> -	spin_unlock(&b->cache_lock);
> -out:
>  	return rtn;
>  }
>  
> -- 
> 2.30.2
> 

