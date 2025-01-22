Return-Path: <linux-nfs+bounces-9447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A4A189A6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 02:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B200F3AA9C6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FE126BFA;
	Wed, 22 Jan 2025 01:43:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C979139CEF;
	Wed, 22 Jan 2025 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510233; cv=none; b=o2qeR7s4Tl3SPjkwfhaA0hwoc8hYPlcERrkO8mH1PQwWLk7zMU+2ygxmmlDwpHfCA8ZBOvOhv+t+FRtN25Oqt3lI1bcNcb4NVKO1XQUj+RrUViPpPIY/qhlVQmPAIAcgpbfk8HE7IEyhuBclZTPPaMexuoxGXusglxq+AubP8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510233; c=relaxed/simple;
	bh=6sbR2YtH0F9tJC5Nswlwshdv/7ppgf3PTuQjKVnYxSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pfTuEov0ZZe58OuG89c5uNpL4FT7W/wCvEOlSTiPZuLA6l6Izr5aE9yDwPsobsU1wdVxCyZxjaZ2tl5F+Tazgn9C78A7S2l+vsnjnY/gEbI7kW9SPPtoaoDiv6WEiU2rxTPPTC3j/q7oASjVEFCp9TmqhVVkz9JuyXfqyXg9c7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yd6GX0p6nzgc5m;
	Wed, 22 Jan 2025 09:40:36 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CF4318010A;
	Wed, 22 Jan 2025 09:43:47 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 09:43:46 +0800
Message-ID: <99567c82-3d15-4ffa-9430-f51cf456ffbc@huawei.com>
Date: Wed, 22 Jan 2025 09:43:44 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>
References: <> <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>
 <173750853452.22054.17347206263008180503@noble.neil.brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <173750853452.22054.17347206263008180503@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/22 9:15, NeilBrown 写道:
> On Wed, 22 Jan 2025, Jeff Layton wrote:
>> On Wed, 2025-01-15 at 10:03 -0500, Chuck Lever wrote:
>>> On 1/14/25 2:39 PM, Jeff Layton wrote:
>>>> On Tue, 2025-01-14 at 14:27 -0500, Jeff Layton wrote:
>>>>> On Mon, 2025-01-13 at 10:59 +0800, Li Lingfeng wrote:
>>>>>> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
>>>>>> list, gc may be triggered in another thread and immediately release this
>>>>>> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
>>>>>>
>>>>>> All the places where unhash is done will also perform lru_remove, so there
>>>>>> is no need to do lru_remove separately here. After inserting the nfsd_file
>>>>>> into the nfsd_file_lru list, it can be released by relying on gc.
>>>>>>
>>>>>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
>>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>> ---
>>>>>>    fs/nfsd/filecache.c | 12 ++----------
>>>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>>> index a1cdba42c4fa..37b65cb1579a 100644
>>>>>> --- a/fs/nfsd/filecache.c
>>>>>> +++ b/fs/nfsd/filecache.c
>>>>>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>>>    		/* Try to add it to the LRU.  If that fails, decrement. */
>>>>>>    		if (nfsd_file_lru_add(nf)) {
>>>>>>    			/* If it's still hashed, we're done */
>>>>>> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>>>> +			if (list_lru_count(&nfsd_file_lru))
>>>>>>    				nfsd_file_schedule_laundrette();
>>>>>> -				return;
>>>>>> -			}
>>>>>>    
>>>>>> -			/*
>>>>>> -			 * We're racing with unhashing, so try to remove it from
>>>>>> -			 * the LRU. If removal fails, then someone else already
>>>>>> -			 * has our reference.
>>>>>> -			 */
>>>>>> -			if (!nfsd_file_lru_remove(nf))
>>>>>> -				return;
>>>>>> +			return;
>>>>>>    		}
>>>>>>    	}
>>>>>>    	if (refcount_dec_and_test(&nf->nf_ref))
>>>>> I think this looks OK. Filecache bugs are particularly nasty though, so
>>>>> let's run this through a nice long testing cycle.
>>>>>
>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>> Actually, I take it back. This is problematic in another way.
>>>>
>>>> In this case, we're racing with another task that is unhashing the
>>>> object, but we've put it on the LRU ourselves. What guarantee do we
>>>> have that the unhashing and removal from the LRU didn't occur before
>>>> this task called nfsd_file_lru_add()? That's why we attempt to remove
>>>> it here -- we can't rely on the task that unhashed it to do so at that
>>>> point.
>>>>
>>>> What might be best is to take and hold the rcu_read_lock() before doing
>>>> the nfsd_file_lru_add, and just release it after we do these racy
>>>> checks. That should make it safe to access the object.
>>>>
>>>> Thoughts?
>>> Holding the RCU read lock will keep the dereferences safe since
>>> nfsd_file objects are freed only after an RCU grace period. But will the
>>> logic in nfsd_file_put() work properly on totally dead nfsd_file
>>> objects? I don't see a specific failure mode there, but I'm not very
>>> imaginative.
>>>
>>> Overall, I think RCU would help.
>>>
>>>
>> To be clear, I think we need to drop e57420be100ab from your nfsd-
>> testing branch. The race I identified above is quite likely to occur
>> and could lead to leaks.
>>
>> If Li Lingfeng doesn't propose a patch, I'll spin one up tomorrow. I
>> think the RCU approach is safe.
> I'm not convinced this is the right approach.
> I cannot see how nfsd_file_put() can race with unhashing.  If it cannot
> then we can simply unconditionally call nfsd_file_schedule_laundrette().
>
> Can describe how the race can happen - if indeed it can.
At the beginning, our testing team discovered this issue on 5.10 using
their own test cases (I'm not clear on how their test cases were
constructed).
Then, I found that there might be a problem here, so I reproduced the
phenomenon in the above way.
I will ask if their test cases can be shared externally or if they can
describe what their test cases did.
> Note that we also need rcu protection in nfsd_file_lru_add() so that the
> nf doesn't get freed after it is added the the lru and before the trace
> point.  If we don't end up needing rcu round the call, we will need it
> in the call.
>
> Thanks,
> NeilBrown

