Return-Path: <linux-nfs+bounces-15576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78414C03324
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249C73AE0C6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978B2327A3;
	Thu, 23 Oct 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VawOnitw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2E153BED
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248259; cv=none; b=sZHCIn8HxJOWUMPUe/akCaPW4qjL6f5ni6Wfsdqv+0g4ndU5hyz2L/ZinMRg/A06/kBSnOQ4QL+mUfPlFBSYYsL0eNK+Zf0eX3md1htvKstOrMz8YD4YQSjeIXKqYBwObMkzPTcpU9wMk1EKnbe9nBLuGFTWEvxEu58XySXCUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248259; c=relaxed/simple;
	bh=QeF/a12+cyk1Re4h0g2olyXrjPZ01Oivn24WFZ/03HE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XvDF48U1tVh+p1ln8xD1gGHPs4O22bUiSpSiOTwsvgkETMJ69bwRsl75RmsrsFH8PGmRLS7NXNwvKZsiZlO4t7m3fRzRyfCw5ibUkpVGuEMA0UIiIt8SBqMJ31EyYeDxrGdkbMd3iNQguJfkAfg+ODuDbgetJBQ2c9r9mw1M96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VawOnitw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D8C4CEE7;
	Thu, 23 Oct 2025 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761248258;
	bh=QeF/a12+cyk1Re4h0g2olyXrjPZ01Oivn24WFZ/03HE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VawOnitwo+sVrd0DY2dkCDlvia6cBYtZ3qa9xN9hnqOQZBjOMJFPSYIiZwMjOk/Xw
	 daBXDN4JlxXe+lHScV47CqogTt5SMSXbs9H5qZuLBuzoPg0aWNvqEkfyYTqaMDYbau
	 SXtOJkjSqSC2djhf68EiP+dwp1vT0z0Ej6GBairNHCuHJc/VSAtwEuD2Gb9TLsEJYl
	 3nX1G1nMdL6O0nr5Wx63v5vkyOSVk/HMj3JB4Lh727/MVdvM6sIDPUXYDPP1zX23px
	 2/q+ok6Y3+1n3QxL3Hea8cB57URh53gQ/xLJvVzOQf5YnlZX/jIWEfkG2tiMo1T+vs
	 O3JWnXe1eIk+g==
Message-ID: <33ee6dda-6b10-4a85-9346-5fc1bc6f2731@kernel.org>
Date: Thu, 23 Oct 2025 15:37:36 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
From: Chuck Lever <cel@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251022192208.1682-5-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 3:22 PM, Chuck Lever wrote:
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
> +
> +static bool
> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> +			   unsigned int len_mask)
> +{
> +	const struct bio_vec *bvec = i->bvec;
> +	size_t skip = i->iov_offset;
> +	size_t size = i->count;
> +
> +	if (size & len_mask)
> +		return false;
> +	do {
> +		size_t len = bvec->bv_len;
> +
> +		if (len > size)
> +			len = size;
> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> +			return false;
> +		bvec++;
> +		size -= len;
> +		skip = 0;
> +	} while (size);
> +
> +	return true;
> +}
> +

Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
would return false.


-- 
Chuck Lever


