Return-Path: <linux-nfs+bounces-15539-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27523BFE3D0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0453A31B9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637772FE560;
	Wed, 22 Oct 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjCdQJ9G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA032FDC22
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166710; cv=none; b=kDITEY+D3CMaF7hXMBfZTZl3O0dW6lbgunaYA9R7XCYWYLzQrpdED/ZJ2c8Ueoi14wP6LwWjRa/WFOSGSKPw+aI5pZ7BZ6Jfiht5kPc68EvovrsfEcy5P7PUs+RVnZm2clnBVyj4K2tbj7anvtgE0webDSXMwk8zZUDQZ1q2BY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166710; c=relaxed/simple;
	bh=kg9Yv4GrMR5TwY/PnoOGfXRJxMUH6vYtYADGNONUz5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB/luWrIo98JBQ0daRwvW43yZqXb4hYKEG7L0UVV+VGQoWKkPrZA4TxLicdTTl6wCJFhGEAcFiXY8g0Xcrd0IU103vCQpwBZfAYz9TijDF7pGG+S+nqbTFVIuGSLJCTb/p5ghhd2dSomQdr0lj93HCL13URWu+DzIT4Y6cb+A3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjCdQJ9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D9FC4CEE7;
	Wed, 22 Oct 2025 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166709;
	bh=kg9Yv4GrMR5TwY/PnoOGfXRJxMUH6vYtYADGNONUz5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjCdQJ9Gqd0ST+p5HWk+D1Z2axUWcuauHoTcWuArlBhjC9DtETlau1wGUIbEvjPzH
	 y0MiQL5fOdcHcshNembUyfxSKGLLtIbUegjerq9KTWJg05YWSLZjToPplSrl55eh5M
	 lnTFjqwrrtGc8VyoA09b1oHFu1AsdBLRF7n/j/sDtwrAhMoej8+MKQtBIrVZN1nCAY
	 8PCMxnoX02amOyaWNfsnwl3MI8YOaFvBzIet05vHBkm7D3wB6K+QEJDTJtzCg6Q8q0
	 0DpnJ3rEJWkLv/azdMSybJKpnpRpJgqeaBBjoYnIGHXvj7AmDxrekh6fbtwYkAPDto
	 XivFewhLF/rhg==
Date: Wed, 22 Oct 2025 16:58:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPlFdJHa98jfc3m_@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022192208.1682-5-cel@kernel.org>

On Wed, Oct 22, 2025 at 03:22:07PM -0400, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. An O_SYNC buffered write (with
> preference towards using DONTCACHE) is used for the misaligned extents
> and O_DIRECT is used for the middle DIO-aligned extent.
> 
> nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
> allows the client to drop its dirty data and avoid needing an extra
> COMMIT operation.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |   1 +
>  fs/nfsd/trace.h   |   1 +
>  fs/nfsd/vfs.c     | 181 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 41cd2b53d803..29c29a5111f8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,6 +1254,105 @@ static int wait_for_concurrent_writes(struct file *file)
>  	return err;
>  }
>  
> +struct nfsd_write_dio {
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static bool
> +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> +			   struct nfsd_file *nf,
> +			   struct nfsd_write_dio *write_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> +	loff_t start_end, orig_end, middle_end;
> +

I see you removed this check:

-       if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
-               return false;

Curious why. Seems unsafe because they can be 0.

> +	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
> +		return false;
> +
> +	start_end = round_up(offset, dio_blocksize);
> +	orig_end = offset + len;
> +	middle_end = round_down(orig_end, dio_blocksize);
> +
> +	write_dio->start_len = start_end - offset;
> +	write_dio->middle_len = middle_end - start_end;
> +	write_dio->end_len = orig_end - middle_end;
> +
> +	return true;
> +}

Otherwise, your other changes all seem fine.

Thanks,
Mike

