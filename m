Return-Path: <linux-nfs+bounces-15616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A5C07866
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272014F14B7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98536342CA4;
	Fri, 24 Oct 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6U5hJit"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA831B806
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326547; cv=none; b=kjJTVS5eWoCef8qavbga9WbWdjxQWhsc4fLoTkE+gLoTXjnI3Ia/MS05BHKWWWu1W+n76t7I1gM5nSMcFnwYDTQTea3zWfFZ7EZRk9NRNbDq3+6f/OgsaK/Nykb/QGWr408cRNxQzx+gG2m9wo4U4EkjZX1NxHohG39ixEaKTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326547; c=relaxed/simple;
	bh=DYrZKz5PVxe/vvdreSozrLA2p4BeXUkciGQG7yTNf+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMvR5qR6BcSKBQuxTg73yuf7xflzsNSGJwmTr0L1ESPPHY7JlI9iv/Va003qVCRmitDPpj4brI2iXR9M9aehlZvfAKrr5qWhLO7aRdDnxiaHEpdSEqIMeaKVMZpaffyurBxfQDM2nBn65yyGn4r/nLJpfY6iS3cWyr1PGTiJT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6U5hJit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E04C4CEFB;
	Fri, 24 Oct 2025 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326546;
	bh=DYrZKz5PVxe/vvdreSozrLA2p4BeXUkciGQG7yTNf+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6U5hJitYNgEohUMv/Hgqi2haoc6Y80rmXPdQh6lopSRKdlZgKP9evuXsQsm9Ea3+
	 NHKykia4Q5MaEvOhBb7eDGG8XqioazUSgXHeKy5vtjTGoOh6NtXoqh48GhIz8khd+x
	 3YjUh6Rjb6aXN3rHxSVmY/JfWcnj4eHNxEc/EdHz0TYUf48KnG56d1efcvbV1/2HtS
	 74y0S1RhPGmQbZ8nr9dyPJR03+zzqvZCpY2cvJvVydCode7XTlJjl++zH4U1LBhujD
	 ag/Dh7aldL64qZzWdjs38CYN7Snrju3eZJNYr5LsuIYppBgWZwScn2BcvEk36aqgsA
	 zulRuCDW+sMjg==
Message-ID: <526167e4-d0b4-4fa7-8438-c9f13b19cc55@kernel.org>
Date: Fri, 24 Oct 2025 13:22:25 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] NFSD: Remove the len_mask check
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-10-cel@kernel.org> <aPu0hR_DOU2fLkWd@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPu0hR_DOU2fLkWd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 1:16 PM, Mike Snitzer wrote:
> On Fri, Oct 24, 2025 at 10:43:01AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Mike says:
>>>> Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
>>>> would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
>>>> would return false.
>>>
>>> It is always due to memory alignment (addr_mask check), never due to
>>> logical alignment (len_mask check).
>>>
>>> So we could remove the len_mask arg and the 'if (size & len_mask)'
>>> check from nfsd_iov_iter_aligned_bvec
>>
>> Suggested-by: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 465d4d091f3d..f6810630bb65 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1285,15 +1285,12 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>>  }
>>  
>>  static bool
>> -nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
>> -			   unsigned int len_mask)
>> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask)
>>  {
>>  	const struct bio_vec *bvec = i->bvec;
>>  	size_t skip = i->iov_offset;
>>  	size_t size = i->count;
>>  
>> -	if (size & len_mask)
>> -		return false;
>>  	do {
>>  		size_t len = bvec->bv_len;
>>  
>> -- 
>> 2.51.0
>>
>>
> 
> Just a bisect-ability nit, the call to nfsd_iov_iter_aligned_bvec()
> needs to remove the len_mask arg.

Fixed, thanks.


> 
> Otherwise:
> 
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>




-- 
Chuck Lever

