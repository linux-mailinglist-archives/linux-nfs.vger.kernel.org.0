Return-Path: <linux-nfs+bounces-12679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001DDAE593D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32E33A1A9D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACA199FAC;
	Tue, 24 Jun 2025 01:31:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 15443189F3B;
	Tue, 24 Jun 2025 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728677; cv=none; b=f3OuulVicS5wH2/twDhGZJxdBl2nVTDK+e9CXLFYKYlQc3yXC3UD16n78N2cSzi3rcw9Pd6yEZ8gphgpIj+/Awgii/nVD42yaBW/I1MA0QmOLhOc6T7Ri618pBvIeUmpZY2y1qXvmY7/4Fnmy82ptJTndFIhJjqktFn23xLovXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728677; c=relaxed/simple;
	bh=izK6xWigpQbVX5kq0ouVraYM2E7Gku1yLtAuADFoTJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=L+M0AkW/4qYkNK3VtxUjOOWEfjYFnsS+L9nWtcN1QhOZMFW3BfCmhz/T9+b3Kd9nGQHqvG7ZS12aar9iU3IEc26fQ9nEpagNz0BlGi4GJofky5ff55Y5IeeTx+RYZyt7P9zm6LJPbS4GfH84t4I46FStB5a57zocIf+x1xbfAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id A15D060105E92;
	Tue, 24 Jun 2025 09:31:01 +0800 (CST)
Message-ID: <2b28f725-03ae-4666-b13b-817cd74ad82e@nfschina.com>
Date: Tue, 24 Jun 2025 09:31:00 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Content-Language: en-US
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <175072435698.2280845.12079422273351211469@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/6/24 08:19, NeilBrown wrote:
> On Mon, 23 Jun 2025, Su Hui wrote:
>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>> more clear. Change the order of the code to let all lock code in the
>> same scope. No functional changes.
> While I agree that this code could usefully be cleaned up and that you
> have made some improvements, I think the use of guard() is a nearly
> insignificant part of the change.  You could easily do exactly the same
> patch without using guard() but having and explicit spin_unlock() before
> the new return.  That doesn't mean you shouldn't use guard(), but it
> does mean that the comment explaining the change could be more usefully
> focused on the "Change the order ..." part, and maybe explain what that
> is important.
Got it. I will focus on "Change the order ..." part in the next v2 patch.
> I actually think there is room for other changes which would make the
> code even better:
> - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
>    take the lock when needed, then drop it, then call
>    nfsd_cacherep_dispose() - and return the count.
> - change nfsd_cache_insert to also skip updating the chain length stats
>    when it finds a match - in that case the "entries" isn't a chain
>    length. So just  lru_put_end(), return.  Have it return NULL if
>    no match was found
> - after the found_entry label don't use nfsd_reply_cache_free_locked(),
>    just free rp.  It has never been included in any rbtree or list, so it
>    doesn't need to be removed.
> - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
>    and call it under rcu_read_lock() - and use RCU to free the cached
>    items.
> - put the chunk of code after the found_entry label into a separate
>    function and instead just return RC_REPLY (and maybe rename that
>    RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
>    that function that has the found_entry code.
>
> I think that would make the code a lot easier to follow.  Would you like
> to have a go at that - I suspect it would be several patches - or shall
> I do it?
>
> Thanks,
> NeilBrown
>
Really thanks for your suggestions!
Yes, I'd like to do it in the next v2 patchset as soon as possible.
I'm always searching some things I can participate in about linux kernel
community, so it's happy for me to do this thing.

regards,
Su Hui

>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>>   1 file changed, 48 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>> index ba9d326b3de6..2d92adf3e6b0 100644
>> --- a/fs/nfsd/nfscache.c
>> +++ b/fs/nfsd/nfscache.c
>> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>   
>>   	if (type == RC_NOCACHE) {
>>   		nfsd_stats_rc_nocache_inc(nn);
>> -		goto out;
>> +		return rtn;
>>   	}
>>   
>>   	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
>> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>   	 */
>>   	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
>>   	if (!rp)
>> -		goto out;
>> +		return rtn;
>>   
>>   	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
>> -	spin_lock(&b->cache_lock);
>> -	found = nfsd_cache_insert(b, rp, nn);
>> -	if (found != rp)
>> -		goto found_entry;
>> -	*cacherep = rp;
>> -	rp->c_state = RC_INPROG;
>> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> -	spin_unlock(&b->cache_lock);
>> +	scoped_guard(spinlock, &b->cache_lock) {
>> +		found = nfsd_cache_insert(b, rp, nn);
>> +		if (found == rp) {
>> +			*cacherep = rp;
>> +			rp->c_state = RC_INPROG;
>> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> +			goto out;
>> +		}
>> +		/* We found a matching entry which is either in progress or done. */
>> +		nfsd_reply_cache_free_locked(NULL, rp, nn);
>> +		nfsd_stats_rc_hits_inc(nn);
>> +		rtn = RC_DROPIT;
>> +		rp = found;
>> +
>> +		/* Request being processed */
>> +		if (rp->c_state == RC_INPROG)
>> +			goto out_trace;
>> +
>> +		/* From the hall of fame of impractical attacks:
>> +		 * Is this a user who tries to snoop on the cache?
>> +		 */
>> +		rtn = RC_DOIT;
>> +		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>> +			goto out_trace;
>>   
>> +		/* Compose RPC reply header */
>> +		switch (rp->c_type) {
>> +		case RC_NOCACHE:
>> +			break;
>> +		case RC_REPLSTAT:
>> +			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
>> +			rtn = RC_REPLY;
>> +			break;
>> +		case RC_REPLBUFF:
>> +			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>> +				return rtn; /* should not happen */
>> +			rtn = RC_REPLY;
>> +			break;
>> +		default:
>> +			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>> +		}
>> +
>> +out_trace:
>> +		trace_nfsd_drc_found(nn, rqstp, rtn);
>> +		return rtn;
>> +	}
>> +out:
>>   	nfsd_cacherep_dispose(&dispose);
>>   
>>   	nfsd_stats_rc_misses_inc(nn);
>>   	atomic_inc(&nn->num_drc_entries);
>>   	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>> -	goto out;
>> -
>> -found_entry:
>> -	/* We found a matching entry which is either in progress or done. */
>> -	nfsd_reply_cache_free_locked(NULL, rp, nn);
>> -	nfsd_stats_rc_hits_inc(nn);
>> -	rtn = RC_DROPIT;
>> -	rp = found;
>> -
>> -	/* Request being processed */
>> -	if (rp->c_state == RC_INPROG)
>> -		goto out_trace;
>> -
>> -	/* From the hall of fame of impractical attacks:
>> -	 * Is this a user who tries to snoop on the cache? */
>> -	rtn = RC_DOIT;
>> -	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>> -		goto out_trace;
>> -
>> -	/* Compose RPC reply header */
>> -	switch (rp->c_type) {
>> -	case RC_NOCACHE:
>> -		break;
>> -	case RC_REPLSTAT:
>> -		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
>> -		rtn = RC_REPLY;
>> -		break;
>> -	case RC_REPLBUFF:
>> -		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>> -			goto out_unlock; /* should not happen */
>> -		rtn = RC_REPLY;
>> -		break;
>> -	default:
>> -		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>> -	}
>> -
>> -out_trace:
>> -	trace_nfsd_drc_found(nn, rqstp, rtn);
>> -out_unlock:
>> -	spin_unlock(&b->cache_lock);
>> -out:
>>   	return rtn;
>>   }
>>   
>> -- 
>> 2.30.2
>>
>>

