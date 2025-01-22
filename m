Return-Path: <linux-nfs+bounces-9446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D56A1898C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 02:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EFD166387
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 01:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0C4C9F;
	Wed, 22 Jan 2025 01:33:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C23DE;
	Wed, 22 Jan 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509621; cv=none; b=fWvw9DJ8xPkiL3VfuQbLpkSoUa1DLekWqTZQ+Y7kRMpkck/+Jbg+zyLJecqoHQlImC8CpaoPajtarcO++URswegrdroEe0LAKTpnB6Mg8qtdwJ5ouBZfGKxdoIobEy5l3+S3y/GZdvFGL8MQaBMNVrTOIw6mAph3fZMaXs5Ge8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509621; c=relaxed/simple;
	bh=GD611Br9GiKp8D06BERtLZ9qQ8mXv6qovryeg+cB7P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kE4lmYkUYlqpz7t73bQWpP+ZhlF2P96WkEeKpT4Q7lXBlCnF1wO0ykzzNamhFpn1iFA1VlNFC+3ij573ytHMrJXNep/iIniIzWhsZl6NONdZQZvdyOGcnKHuXI+G4WK77T1RnsYDE+w6fHRFn4HctAfSggnjqJfTL9FORYvA5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yd63X2hQ4z22lks;
	Wed, 22 Jan 2025 09:31:04 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 20EDC14013B;
	Wed, 22 Jan 2025 09:33:34 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 09:33:32 +0800
Message-ID: <240dcf4e-b716-446a-9b9d-d232e26a58b5@huawei.com>
Date: Wed, 22 Jan 2025 09:33:32 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
 <8864761c99553a7f18adc13e98b4ef6255da1d9e.camel@kernel.org>
 <a32d4eefe27757de6ad8761e8de740e8d0968561.camel@kernel.org>
 <a453c201-7dd4-49e7-a90a-5dc4c9359f2b@oracle.com>
 <b8c6a8abc67e2039c374f1178e73208ccf2ce10b.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <b8c6a8abc67e2039c374f1178e73208ccf2ce10b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/15 23:27, Jeff Layton 写道:
> On Wed, 2025-01-15 at 10:03 -0500, Chuck Lever wrote:
>> On 1/14/25 2:39 PM, Jeff Layton wrote:
>>> On Tue, 2025-01-14 at 14:27 -0500, Jeff Layton wrote:
>>>> On Mon, 2025-01-13 at 10:59 +0800, Li Lingfeng wrote:
>>>>> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
>>>>> list, gc may be triggered in another thread and immediately release this
>>>>> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
>>>>>
>>>>> All the places where unhash is done will also perform lru_remove, so there
>>>>> is no need to do lru_remove separately here. After inserting the nfsd_file
>>>>> into the nfsd_file_lru list, it can be released by relying on gc.
>>>>>
>>>>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>> ---
>>>>>    fs/nfsd/filecache.c | 12 ++----------
>>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index a1cdba42c4fa..37b65cb1579a 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>>    		/* Try to add it to the LRU.  If that fails, decrement. */
>>>>>    		if (nfsd_file_lru_add(nf)) {
>>>>>    			/* If it's still hashed, we're done */
>>>>> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>>> +			if (list_lru_count(&nfsd_file_lru))
>>>>>    				nfsd_file_schedule_laundrette();
>>>>> -				return;
>>>>> -			}
>>>>>    
>>>>> -			/*
>>>>> -			 * We're racing with unhashing, so try to remove it from
>>>>> -			 * the LRU. If removal fails, then someone else already
>>>>> -			 * has our reference.
>>>>> -			 */
>>>>> -			if (!nfsd_file_lru_remove(nf))
>>>>> -				return;
>>>>> +			return;
>>>>>    		}
>>>>>    	}
>>>>>    	if (refcount_dec_and_test(&nf->nf_ref))
>>>> I think this looks OK. Filecache bugs are particularly nasty though, so
>>>> let's run this through a nice long testing cycle.
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Actually, I take it back. This is problematic in another way.
>>>
>>> In this case, we're racing with another task that is unhashing the
>>> object, but we've put it on the LRU ourselves. What guarantee do we
>>> have that the unhashing and removal from the LRU didn't occur before
>>> this task called nfsd_file_lru_add()? That's why we attempt to remove
>>> it here -- we can't rely on the task that unhashed it to do so at that
>>> point.
>>>
>>> What might be best is to take and hold the rcu_read_lock() before doing
>>> the nfsd_file_lru_add, and just release it after we do these racy
>>> checks. That should make it safe to access the object.
>>>
>>> Thoughts?
>> Holding the RCU read lock will keep the dereferences safe since
>> nfsd_file objects are freed only after an RCU grace period. But will the
>> logic in nfsd_file_put() work properly on totally dead nfsd_file
>> objects? I don't see a specific failure mode there, but I'm not very
>> imaginative.
>>
>> Overall, I think RCU would help.
>>
> It should be safe to call nfsd_file_lru_add() with the rcu_read_lock()
> held. After that we're just looking at the nf_flags() and the nf_lru
> list head. On a dead file, HASHED will be clear and the
> nfsd_file_lru_remove() call will be a no-op (the list_head will be
> empty).
>
> Li Lingfeng, do you want to propose a patch for this? Unfortunately,
> your reproducer won't work after that, since you can't sleep with the
> rcu_read_lock held.
Sorry for the delay.
Of course I'm willing to do it.
Maybe I can reproduce the problem by changing msleep to mdelay? I will try.

