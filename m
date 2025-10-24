Return-Path: <linux-nfs+bounces-15583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373BC06B03
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7131B83265
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79D202C5C;
	Fri, 24 Oct 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOaAWSGP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84731A9FAC
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315883; cv=none; b=pXHp4IMpmkF2YO113JNuKLsCPs1FZszllmaUNTD/iClz+bqRJECIbVz0x0OfBm1z5c6prk6GxRWN04O89En3lxUUsaBbsRFTMDMBZKEcuHhLEQxCIOtkjHe8cxYYSSRFZ+pArJ65kKTV4IQ28F/fOe98KVJXyr+3zgbHro+wANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315883; c=relaxed/simple;
	bh=qEXicKXqTf1BirUKFzcb7O5qyJcjIZtC832cSUhNl64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMCQBlEAg3KbqklrWsKu2XoWC0DpVqgl8vRg7T2fKGi9PbFPIeEsNrdbGwhVTsDGnSiIgBx8h4yxyLSwSaYaGKhQDeXiCytBFQCyKz5JW0r2sDsc40DmiAiELVLAgomOwSq755zLlQUldvuaTQP7tkgBl4ZNT9NN2ijl+EX75Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOaAWSGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC35FC4CEF1;
	Fri, 24 Oct 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761315883;
	bh=qEXicKXqTf1BirUKFzcb7O5qyJcjIZtC832cSUhNl64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HOaAWSGPjP6B6CZBxFk7WewIc5A7RGcaILSJAFY6YV8kR69F14KrZHx4QVHJbTsfy
	 65kZ6T5pAnvd/+vm91K0tsyAxXFVyrugFDzvR/gWAaPy6Xgm6Cz53LQk/Fqpb2wbP5
	 LrIpTAoz8Tkyp7faid6Teca+Z247IE5MRYtJscZSNMRFIynDycE9LpthV35B2JONM1
	 2Ek4n/wtirkcWN0xbgkab0jkSscipGSKzaTvTDL7+p7yBG0w5a6lqXXLchHMZeUlBG
	 LLvXqbWEz8rUzYLidOGOQMV1+lxysvv91M2PAmAlW/kKnCZLKCVi00CiKljQUuPzSV
	 fNYde+BIwvZDg==
Message-ID: <d23cf628-50f4-441b-af65-1553e09ba153@kernel.org>
Date: Fri, 24 Oct 2025 10:24:41 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
 <33ee6dda-6b10-4a85-9346-5fc1bc6f2731@kernel.org>
 <aPqc0TPxVHRwq3og@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPqc0TPxVHRwq3og@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 5:23 PM, Mike Snitzer wrote:
> On Thu, Oct 23, 2025 at 03:37:36PM -0400, Chuck Lever wrote:
>> On 10/22/25 3:22 PM, Chuck Lever wrote:
>>> +struct nfsd_write_dio {
>>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>>> +};
>>> +
>>> +static bool
>>> +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>>> +			   struct nfsd_file *nf,
>>> +			   struct nfsd_write_dio *write_dio)
>>> +{
>>> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
>>> +	loff_t start_end, orig_end, middle_end;
>>> +
>>> +	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
>>> +		return false;
>>> +
>>> +	start_end = round_up(offset, dio_blocksize);
>>> +	orig_end = offset + len;
>>> +	middle_end = round_down(orig_end, dio_blocksize);
>>> +
>>> +	write_dio->start_len = start_end - offset;
>>> +	write_dio->middle_len = middle_end - start_end;
>>> +	write_dio->end_len = orig_end - middle_end;
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static bool
>>> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
>>> +			   unsigned int len_mask)
>>> +{
>>> +	const struct bio_vec *bvec = i->bvec;
>>> +	size_t skip = i->iov_offset;
>>> +	size_t size = i->count;
>>> +
>>> +	if (size & len_mask)
>>> +		return false;
>>> +	do {
>>> +		size_t len = bvec->bv_len;
>>> +
>>> +		if (len > size)
>>> +			len = size;
>>> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
>>> +			return false;
>>> +		bvec++;
>>> +		size -= len;
>>> +		skip = 0;
>>> +	} while (size);
>>> +
>>> +	return true;
>>> +}
>>> +
>>
>> Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
>> would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
>> would return false.
> 
> It is always due to memory alignment (addr_mask check), never due to
> logical alignment (len_mask check).
> 
> So we could remove the len_mask arg and the 'if (size & len_mask)'
> check from nfsd_iov_iter_aligned_bvec

Fair enough.

Another question: why does nfsd_iov_iter_aligned_bvec need to walk the
entire bvec? For current NFSD and SunRPC, the elements of the bvec
array will be contiguous pages. After nfsd_is_write_dio_possible says
"OK", seems like you need to check only the first element in the bvec?

Or, maybe the check isn't necessary at all? I'm just wondering why
nfsd_is_write_dio_possible by itself isn't sufficient. Our network
transports aren't going to hand us arbitrary blobs in the bvec elements.


-- 
Chuck Lever

