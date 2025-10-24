Return-Path: <linux-nfs+bounces-15614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D303C07833
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8119A4330
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060D267B94;
	Fri, 24 Oct 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbA7oPrb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB11C5D57
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326215; cv=none; b=C3n2xeLEfqQ3lk16zLcofWTUcT2a05ZeXDA4iWEfatWz/3Jb49LAzPcXZc2lzRj55yVg1t0lpeCxGy40W5lVUnsuaAIa6g5v/Kae0wP7e4bn1RpeslgN0d5/4SeW8+kZeiOuh++lQpQtGazrnVG+nU9jot7m035BhVZ6nE05GPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326215; c=relaxed/simple;
	bh=mh+BraKohD9VktVmiB1oJHJkqQdnR6hdo2HCaYRkmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/C3xR1QG9mVOXLzwWVLNshnvJeqob5u+y9KdIVIINWYsDLYcDFRfWN4wJpVHBqsa9e7zoaJjHhj5q7UwmR/523dltU+lgoUyIBaQ1Y2e4qJFXuL40y9u6qVEDSDus3AgJuZ3jp5r/K5aRZw3c+zzRne0b6ONRn+vkiQn/AKxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbA7oPrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D66C4CEF1;
	Fri, 24 Oct 2025 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326215;
	bh=mh+BraKohD9VktVmiB1oJHJkqQdnR6hdo2HCaYRkmHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbA7oPrbGc5tqGQ3xI96Ui0AluyOcos6mrxA6KgqN1vS1xg9LTxsnsv89hZLdzQ6x
	 KwhS2tsAmHBbbsAyVpUdfcw179iufZneLuzefv8EZcejeHqT/N+wDCIY+DwgDq8BhG
	 Pkq5ETEkFg4kL/2cbEW9OqigGfMEWEe5E4MXMX0Puh2UI6PoUyC/8EBUdFPBQlJZkS
	 UwhVEv58f6Sr9HQSmvV+oy7HA9HTgzIb/V1NsuTb/8iMiLn0MLoa64US3GVamp5ICj
	 EoL417PLSjP2AlYPe6NYqb4s6o3lm6wjmt1zPi9fSRa6S21GSRYKRRs98fkJ6XckpP
	 nmh8+U+YlRy+g==
Date: Fri, 24 Oct 2025 13:16:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 09/14] NFSD: Remove the len_mask check
Message-ID: <aPu0hR_DOU2fLkWd@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-10-cel@kernel.org>

On Fri, Oct 24, 2025 at 10:43:01AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Mike says:
> > > Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
> > > would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
> > > would return false.
> >
> > It is always due to memory alignment (addr_mask check), never due to
> > logical alignment (len_mask check).
> >
> > So we could remove the len_mask arg and the 'if (size & len_mask)'
> > check from nfsd_iov_iter_aligned_bvec
> 
> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 465d4d091f3d..f6810630bb65 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1285,15 +1285,12 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>  }
>  
>  static bool
> -nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> -			   unsigned int len_mask)
> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask)
>  {
>  	const struct bio_vec *bvec = i->bvec;
>  	size_t skip = i->iov_offset;
>  	size_t size = i->count;
>  
> -	if (size & len_mask)
> -		return false;
>  	do {
>  		size_t len = bvec->bv_len;
>  
> -- 
> 2.51.0
> 
> 

Just a bisect-ability nit, the call to nfsd_iov_iter_aligned_bvec()
needs to remove the len_mask arg.

Otherwise:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

