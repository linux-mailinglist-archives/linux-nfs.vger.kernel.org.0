Return-Path: <linux-nfs+bounces-14516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F56B813A9
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427561B248BD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9012FE048;
	Wed, 17 Sep 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgcyxd4G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392892FE045
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131465; cv=none; b=mrkOTcfDEPrBNuxYjvQgi0QO1NDNwpvribroFHnKjmYrhGlDPhQBlFF6K0Qjd4LBazyJqtvQ7hzmLhr+GqfoKCY46FpgPXcV+rSgRfbLXU4iwV7zwpk/Bi+75ykYOWtmlfJJZZiG5G3Dcqehd6/BdgGlHdyH1IX8lFzWM0vop+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131465; c=relaxed/simple;
	bh=uDlP9HZsURHmu52s/C9GDd5jADfJhLAIn3fYDRyKGR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtFhBxDayXrdNSqzwc6H72iP00ow/vnn4SJIfzi+q9QqB/pRUHdKqqkRNEKYJslDqtrQkpioj4Vh7IGAU6YYUlyOFY+ClLniSeCLMzy9/mBT1LgD6jPaTp85lXCqK+8buuSoFP7Aezpkp4jGA+SpsVPH6Sc8BaBneXXOIVG50KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgcyxd4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823EAC4CEF7;
	Wed, 17 Sep 2025 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758131464;
	bh=uDlP9HZsURHmu52s/C9GDd5jADfJhLAIn3fYDRyKGR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sgcyxd4G8/NdWYBV23pyFx0mVU5ATkWapkrdeuMgQ151WwXHaJlCs3w2pfbB3vCx6
	 uQaTfve1yIW4Wueb/B9AWFBcpEIff5HfhXgxZl0ZB8nR+uD0lGpwvZXp0T5UXh0WW5
	 a78VLt+a29fGEBg4zPpwltxXJSHAZPCfcUKaIK1BIeFFFSeWG38OW+T0uRT05VB1p+
	 I94RsXWC3NsSi6sTPsZ19jgrPMM+AhGLkwhy3TApOrknXhrQOdwU/hEtgv4WZj+Pxe
	 tHXtXfwn4bktbJ0n4uzrBktFDAyB4mtaH+rYOSwFHBCdrJsathL+o0v+W0ilimq8QR
	 tBcQ8hB49f1Iw==
Date: Wed, 17 Sep 2025 13:51:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] NFSD: Add array bounds-checking in
 nfsd_iter_read()
Message-ID: <aMr1BxbTbN6dYRyp@kernel.org>
References: <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
 <175811950060.19474.9133241842109562565.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175811950060.19474.9133241842109562565.stgit@91.116.238.104.host.secureserver.net>

On Wed, Sep 17, 2025 at 10:31:40AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The *count parameter does not appear to be explicitly restricted
> to being smaller than rsize, so it might be possible to overrun
> the rq_bvec or rq_pages arrays.
> 
> Rather than overrunning these arrays (damage done!) and then WARNING
> once, let's harden the loop so that it terminates before the end of
> the arrays are reached. This should result in a short read, which is
> OK -- clients recover by sending additional READ requests for the
> remaining unread bytes.
> 
> Reported-by: NeilBrown <neil@brown.name>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Neil and I both gave our Reviewed-by on this one yesterday (when you
posted it on its own), but for good measure:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Thanks.


> ---
>  fs/nfsd/vfs.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 714777c221ed..2026431500ec 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1115,18 +1115,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	v = 0;
>  	total = *count;
> -	while (total) {
> +	while (total && v < rqstp->rq_maxpages &&
> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
> -		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
>  			      len, base);
> +
>  		total -= len;
> +		++rqstp->rq_next_page;
>  		++v;
>  		base = 0;
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
> 
> 
> 

