Return-Path: <linux-nfs+bounces-14491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A8B59CCB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A515F1BC8473
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A21283CB8;
	Tue, 16 Sep 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqhVLs8o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABF2C08B6
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038497; cv=none; b=JqbBbgC78DDkok7J6ehsEt2c369kvVsx1Zb6RRF8XoM7Byg0ASiVjEsUgwsxdWUJ0V9dbB0vPwk9pzKyDUYPDgka7M0JrUz9zrc0XGAV8yorx1Tq4t1M+doWz6a/XLhpM46fv7/uMDx7jbjd36YK6KDtmgtu2MExLR1ac4QYEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038497; c=relaxed/simple;
	bh=anAV98Fbi/+Yqo/tGtNgBROysGfolUNOpf2Owm6YHng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5kajhwfD4t7nDcGv/W3/lA01zJmfIoOONXBleuBIzLQUCSkie9iPEbV7KcXtl44RwotsMk2zHl/O4eJXX6XrDHEk++dczbUp41i8cfZ5AeTlDtG9yTciQ1X1o8JuhODrnkU+mILtz1MPDz3Fn88HcCZMjd+TUfdYcD3Re8sPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqhVLs8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49D8C4CEEB;
	Tue, 16 Sep 2025 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038497;
	bh=anAV98Fbi/+Yqo/tGtNgBROysGfolUNOpf2Owm6YHng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqhVLs8oGwh0tMWZP/upRDs17AsPPujuZzLktNBrHHEl3erAEFIDb7uR1yswTJfbZ
	 MqcsFlcJQFf3j/JKPU88YmyxR+9iymYTLnR+/FP72EcRNpOKFR+PcUATbW+mK7kg6H
	 DjZTeqlMKS8uTBSHx1JRUdIA7av4OYoT+Oi3a+huxc8MxK/HGT0CTk5Ykpznrt9eCa
	 pIOtnHMsDP/t4togPz+cOjawnGyN8/AFjg2BEqnnRxWbihqAodvo9ZWK2Xq4/Apwrl
	 gkWrpIQ2KlGSHnjLitqtE0q9iuras9rYYn7OIvpXnd3nWfG7+HfI2Mvg+EbqWncBZT
	 ur+mCdKbC268A==
Date: Tue, 16 Sep 2025 12:01:35 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Add array bounds-checking in nfsd_iter_read()
Message-ID: <aMmJ31N8QKqw-YsT@kernel.org>
References: <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>

On Tue, Sep 16, 2025 at 11:24:19AM -0400, Chuck Lever wrote:
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
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks even better.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


> ---
>  fs/nfsd/vfs.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> Changes since v1:
> - Check for overrunning rq_pages as well
> - Move bounds checking to top of the loop
> - Move incrementing to the bottom of the loop
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

