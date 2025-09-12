Return-Path: <linux-nfs+bounces-14369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC2B54F70
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6018888FE
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6A3019A3;
	Fri, 12 Sep 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axbYgUZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52764249E5
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683511; cv=none; b=gJZRb2L0HQBDAW35vf3a3i8Ntu0BbZmtPIcxAFCK/xkheqhDSnW2N05DLN6V59snWeii3xFUofU46A8oEpYvm1mtVcaAhnlgvKU2hZ1n9/6/HdTDGHhqkaeiGGsPhnTKO3ZtmHRKrVKVXHD7+w77lO/xFSX7nuh5ucpSMD/q+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683511; c=relaxed/simple;
	bh=z+i4aKClbvD8AdchaPgLr43QK+eYF+yfdjBvsfXXm/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhuQENKRVh79EyKKRh6LtNKj+GvTBFgtXvD50PkxD1kMkrdQwHtdzbjonI0uYWbgjDltpM2I2PbYKffmMq+Tf+KDE/o+rGCKz7T4UQKXcjtYX0D5rVVkwy+kAoASnonSu6zWxPeZSw0zDVE7DIVm2bCo3HU5ezXeTykpdMMiTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axbYgUZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A57C4CEF1;
	Fri, 12 Sep 2025 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683510;
	bh=z+i4aKClbvD8AdchaPgLr43QK+eYF+yfdjBvsfXXm/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axbYgUZBhifqd1+ndLsAw8vYYsy61d/ogYUoVA6imo48cO5myG1w+am1zlh9YDpp9
	 H+QTyP4GQsES+Vh50zpZeH/C3OFZAd6ZAXKsRonSUyJ4qVcnPO2RKhZJIxym8R2aSI
	 z5r7Zdsf6uLyOUio32AeUEV8I29veBbWLTKVnq9ubkGgZ2UgIRqIZ69PUse8o7oHAc
	 iciItQl7WDYMc24PHNTXXe6NL1hjtQYrILTSFFjzPBdym3T8nSbIHv7iHrKBihR3oN
	 hJKtkd78o767IYNfiuCPDAiSJz2In2Ui1tUSzZe+45HW0TFfPupMsoEYQpySQivYdl
	 RGhGQfB3G4Lqg==
Date: Fri, 12 Sep 2025 09:25:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Remove WARN_ON_ONCE in nfsd_iter_read()
Message-ID: <aMQfNdriH1BG-Y6R@kernel.org>
References: <20250911201858.1630-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911201858.1630-1-cel@kernel.org>

On Thu, Sep 11, 2025 at 04:18:58PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The *count parameter does not appear to be explicitly restricted
> to being smaller than rsize, so it might be possible to overrun
> the rq_bvec array.
> 
> Rather than overrunning the array (damage done!) and then WARNING
> once, let's harden the loop so that it terminates before the end of
> rq_bvec. This should result in a short read, which is OK (clients
> recover by sending additional READ requests for the remaining unread
> bytes).
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> There might be a similar issue with rq_next_page in this loop?
> 
> Suppose that nfsd4_encode_readv() encounters a second READ operation
> in a COMPOUND, and the two READ operations together comprise more
> than "rsize" total bytes of payload. Each rq_bvec is under the page
> limit, but the total number of pages consumed from rq_pages might
> exceed rq_maxpages.

This concern would appear well-founded; but probably best to deal with
it independently.
 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 714777c221ed..e2f0fe3f82c0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1120,13 +1120,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>  			      len, base);
>  		total -= len;
> -		++v;
>  		base = 0;
> +		if (++v >= rqstp->rq_maxpages)
> +			break;

Shouldn't this be == instead of >= ?
Not seeing how it could ever become greater without first being equal.

Other than that, this patch is a welcome obvious improvement:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

>  	}
> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>  
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> +	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
>  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
> -- 
> 2.50.0
> 
> 

