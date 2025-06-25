Return-Path: <linux-nfs+bounces-12747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99CAE81F9
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E480D1BC47A6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D425D1F1;
	Wed, 25 Jun 2025 11:52:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 18ACE25D1E3;
	Wed, 25 Jun 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852323; cv=none; b=ADTArwB+YmUnCmXW/ken6+a6DO+WkYMJalHP2qJV3QhWcwDh3wyH2S0e9GhS9E/wnz/1uzQicrUtrTm84r1/0aWSi5YGYJJ9xHTgh1s1oIoL1K5gNklCEfm2zzIedoSJJWypWr7RKYngcISnxaWM75VUFDj7m88FwBuFLzkV4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852323; c=relaxed/simple;
	bh=K4eNEdbMuwJkxmj8qBQgm+SCrYQ8WQ8B44GCUzPugwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=FM+zutLxcV6tSx0nLjZ5mCQxq+PoEBGVl6RhzC2NlA79Z1xMgjQibxQ9tTZpvdnWZ/OkmFcoNV3lAFFMdUWX0xln5L3b5Sqej2fNu7FsJRy/JZwXfPIRkminPHzCbH83t5Vvnz5X9GbrsXXWt62xGonHPZ5jy6xrnVAdhOgPLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id C52676032FDF0;
	Wed, 25 Jun 2025 19:51:54 +0800 (CST)
Message-ID: <f1d71897-10d5-4069-87ff-9cb41ad642ec@nfschina.com>
Date: Wed, 25 Jun 2025 19:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Content-Language: en-US
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <175080335129.2280845.12285110458405652015@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/6/25 06:15, NeilBrown wrote:
> On Wed, 25 Jun 2025, Chuck Lever wrote:
>> On 6/23/25 8:19 PM, NeilBrown wrote:
>>> On Mon, 23 Jun 2025, Su Hui wrote:
>>>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>>>> more clear. Change the order of the code to let all lock code in the
>>>> same scope. No functional changes.
>>> While I agree that this code could usefully be cleaned up and that you
>>> have made some improvements, I think the use of guard() is a nearly
>>> insignificant part of the change.  You could easily do exactly the same
>>> patch without using guard() but having and explicit spin_unlock() before
>>> the new return.  That doesn't mean you shouldn't use guard(), but it
>>> does mean that the comment explaining the change could be more usefully
>>> focused on the "Change the order ..." part, and maybe explain what that
>>> is important.
>>>
>>> I actually think there is room for other changes which would make the
>>> code even better:
>>> - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
>>>    take the lock when needed, then drop it, then call
>>>    nfsd_cacherep_dispose() - and return the count.
>>> - change nfsd_cache_insert to also skip updating the chain length stats
>>>    when it finds a match - in that case the "entries" isn't a chain
>>>    length. So just  lru_put_end(), return.  Have it return NULL if
>>>    no match was found
>>> - after the found_entry label don't use nfsd_reply_cache_free_locked(),
>>>    just free rp.  It has never been included in any rbtree or list, so it
>>>    doesn't need to be removed.
>>> - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
>>>    and call it under rcu_read_lock() - and use RCU to free the cached
>>>    items.
>>> - put the chunk of code after the found_entry label into a separate
>>>    function and instead just return RC_REPLY (and maybe rename that
>>>    RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
>>>    that function that has the found_entry code.
>>>
>>> I think that would make the code a lot easier to follow.  Would you like
>>> to have a go at that - I suspect it would be several patches - or shall
>>> I do it?
>> I'm going to counsel some caution.
>>
>> nfsd_cache_lookup() is a hot path. Source code readability, though
>> important, is not the priority in this area.
>>
>> I'm happy to consider changes to this function, but the bottom line is
>> patches need to be accompanied by data that show that proposed code
>> modifications do not negatively impact performance. (Plus the usual
>> test results that show no impact to correctness).
>>
>> That data might include:
>> - flame graphs that show a decrease in CPU utilization
>> - objdump output showing a smaller instruction cache footprint
>>    and/or short instruction path lengths
>> - perf results showing better memory bandwidth
>> - perf results showing better branch prediction
>> - lockstat results showing less contention and/or shorter hold
>>    time on locks held in this path
>>
>> Macro benchmark results are also welcome: equal or lower latency for
>> NFSv3 operations, and equal or higher I/O throughput.
>>
>> The benefit for the scoped_guard construct is that it might make it more
>> difficult to add code that returns from this function with a lock held.
>> However, so far that hasn't been an issue.
>>
>> Thus I'm not sure there's a lot of strong technical justification for
>> modification of this code path. But, you might know of one -- if so,
>> please make sure that appears in the patch descriptions.
>>
>> What is more interesting to me is trying out more sophisticated abstract
>> data types for the DRC hashtable. rhashtable is one alternative; so is
>> Maple tree, which is supposed to handle lookups with more memory
>> bandwidth efficiency than walking a linked list.
>>
> While I generally like rhashtable there is an awkwardness.  It doesn't
> guarantee that an insert will always succeed.  If you get lots of new
> records that hash to the same value, it will start failing insert
> requests until is hash re-hashed the table with a new seed.  This is
> intended to defeat collision attacks.  That means we would need to drop
> requests sometimes.  Maybe that is OK.  The DRC could be the target of
> collision attacks so maybe we really do want to drop requests if
> rhashtable refuses to store them.
>
> I think the other area that could use improvement is pruning old entries.
> I would not include RC_INPROG entries in the lru at all - they are
> always ignored, and will be added when they are switched to RCU_DONE.
> I'd generally like to prune less often in larger batches, but removing
> each of the batch from the rbtree could hold the lock for longer than we
> would like.  I wonder if we could have an 'old' and a 'new' rbtree and
> when the 'old' gets too old or the 'new' get too full, we extract 'old',
> move 'new' to 'old', and outside the spinlock we free all of the moved
> 'old'.
>
> But if we switched to rhashtable, we probably wouldn't need an lru -
> just walk the entire table occasionally - there would be little conflict
> with concurrent lookups.
>
> But as you say, measuring would be useful.  Hopefully the DRC lookup
> would be small contribution to the total request time, so we would need
> to measure just want happens in the code to compare different versions.
>
> NeilBrown
>
>> Anyway, have fun, get creative, and let's see what comes up.
>>
Thanks for the above prompt. I think I need more time to complete this,
both for code and related tests. I will do my best with curiosity and
creativity :).

Regards,
Su Hui

