Return-Path: <linux-nfs+bounces-13829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E731B2FAC6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746A97A8F5C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A59343D88;
	Thu, 21 Aug 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzy5//Jo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E272343D7A
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783401; cv=none; b=qVQW8XJHV+KV2sgfNuJGQcM8BUGO1iGCMQbCRDqDPjbnkL2AMNkV0zYZPb1jRNnZs8kxdT88bN27+q0MiGboyyg7FOyT+MoFSvKC2pxQlNtwntKc6BEFaFWSR+nZDoM1IYAQidHGvBqi/aFvxLN4sTNr2l2Z28gmlgqCL/NME3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783401; c=relaxed/simple;
	bh=yOlgzwgDllxYSYeDoO0Xhr52naIj4G8G9aOGxKb9Ag0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz4S6szUOX2fTwt9YBG5tCzJb2rMVDExr4rWbdPnX63DyxSUc0y02aY9ZfTDGbowvdax9F1miN0MTKidgoRpfqnQ8SOoJYr1vz+3gyyKNlNo5cKppLQ9AnWYF+AhF6t8s+zFhj40caZ+W/5Vf8MSXmvTmBpzeuRJStBgUuTLAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzy5//Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B6DC4CEED;
	Thu, 21 Aug 2025 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755783400;
	bh=yOlgzwgDllxYSYeDoO0Xhr52naIj4G8G9aOGxKb9Ag0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dzy5//JofErqVXxR5TOk+AdgQqtPSiEjOGwxegKiTaTW8BmDaO+ErR7OdB+Ixum0a
	 gf2tojXuG7TQGmxXD3t9U5KmsyNP6jdG/9ttrmQSHUI9i1XsB3/TfOU0JWRuVum1ga
	 vuc6JjbZRPZvMT7bX5qYefrbWvhfpjpo8z2WQyrMpLFjcV0vlQmx4rDcEusEVXH8xr
	 lc917ycna/JFINbn8I6IvDRfvUQ4uI+aRf8CH32ZAgffLmmXIAhvbML44e7shdpPA8
	 0Uv339dYtYcgAR6iqK3r1xDRHhXMIuJE7VJNt3aOGDwJB+CdqawIqSAtREfDWuEUY6
	 Agu7mpUNoUhZA==
Message-ID: <65dbe447-8528-435f-930f-4a773a85a512@kernel.org>
Date: Thu, 21 Aug 2025 09:36:38 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] NFSD: Delay adding new entries to LRU
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250820142532.89623-1-cel@kernel.org>
 <20250820142532.89623-2-cel@kernel.org>
 <175573005510.2234665.16962394280504152867@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175573005510.2234665.16962394280504152867@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 6:47 PM, NeilBrown wrote:
> On Thu, 21 Aug 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Neil Brown observes:
>>> I would not include RC_INPROG entries in the lru at all - they are
>>> always ignored, and will be added when they are switched to
>>> RCU_DONE.
>>
>> I also removed a stale comment.
>>
>> Suggested-by: NeilBrown <neil@brown.name>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfscache.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>> index ba9d326b3de6..6c06cf24b5c7 100644
>> --- a/fs/nfsd/nfscache.c
>> +++ b/fs/nfsd/nfscache.c
>> @@ -237,10 +237,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
>>  
>>  }
>>  
>> -/*
>> - * Move cache entry to end of LRU list, and queue the cleaner to run if it's
>> - * not already scheduled.
>> - */
>>  static void
>>  lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
>>  {
>> @@ -453,8 +449,6 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
>>  				nn->longest_chain_cachesize,
>>  				atomic_read(&nn->num_drc_entries));
>>  	}
>> -
>> -	lru_put_end(b, ret);
>>  	return ret;
> 
> A result of this change is that entries in the lru never have
>     ->c_state == RC_INPROG
> They are always RC_DONE.
> 
> So this can be added to the patch:
> 
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -272,12 +272,6 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
>  
>  	/* The bucket LRU is ordered oldest-first. */
>  	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
> -		/*
> -		 * Don't free entries attached to calls that are still
> -		 * in-progress, but do keep scanning the list.
> -		 */
> -		if (rp->c_state == RC_INPROG)
> -			continue;
>  
>  		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
>  		    time_before(expiry, rp->c_timestamp))

I didn't add this bit because I couldn't convince myself that it was
impossible for an entry in RC_INPROG state to get into the LRU
somehow. But if you think it is not possible, I'll buy that and add this
snippet.


> With that added:
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> Thanks,
> NeilBrown
> 
> 
>>  }
>>  
>> -- 
>> 2.50.0
>>
>>
> 


-- 
Chuck Lever

