Return-Path: <linux-nfs+bounces-9448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12B8A189D5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5460167DF8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 02:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27D2E628;
	Wed, 22 Jan 2025 02:21:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249C13AA31;
	Wed, 22 Jan 2025 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512495; cv=none; b=RXLSj0asHnOGSU/LIK6VF07SYlOzpf37mL7UsqD7Gehua2fb6q47hpLwE0Lyvtjjwdo2Nzh0z066bRqmecY23WK1sdGWrG2kzx6gq5wf+CU1riQS0S4D3Zd+ShBH4rmkwo1zyFWpjLHFE+CURxu3UWOQSwqEXSPuj1sf1N1cLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512495; c=relaxed/simple;
	bh=YIRRyEYKYPbCX7l+V5yQ/p0sgzdExuEfqM5s2ISFdVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ6uvok6wVzLQBBgUdT/SDaSy4JoJa4BbUKMG7OYVLBNj0S2WKANc4SbUdp5CGA1euKKAYHZop3wWoiZWlEACTxKDcr+p1ZJqz5XrnRSxgFXEbx0RfRQuFnvUGX4eSmOxHD4fecLxx/4kxkbH/htKaKMelFie4RZZU5CEbOWB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yd79N13phz4f3jqr;
	Wed, 22 Jan 2025 10:21:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91A301A103F;
	Wed, 22 Jan 2025 10:21:27 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHa18lVpBnQIqJBg--.43478S3;
	Wed, 22 Jan 2025 10:21:27 +0800 (CST)
Message-ID: <e07cd398-4388-470a-b367-cecddaaf4b39@huaweicloud.com>
Date: Wed, 22 Jan 2025 10:21:25 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Li Lingfeng <lilingfeng3@huawei.com>, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <> <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>
 <173750853452.22054.17347206263008180503@noble.neil.brown.name>
 <99567c82-3d15-4ffa-9430-f51cf456ffbc@huawei.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <99567c82-3d15-4ffa-9430-f51cf456ffbc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa18lVpBnQIqJBg--.43478S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW7KFW7CryDAryfJFy8uFg_yoWxCFy8pr
	WrJFyDKFWkJr18Jw17Kw1jqFyrtr4UJw1UXr1rXF15XrsFvr1jvF1UXr1j9ryUJr48Xr1U
	Zr1jqFy7Zw1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2025/1/22 9:43, Li Lingfeng 写道:
>
> 在 2025/1/22 9:15, NeilBrown 写道:
>> On Wed, 22 Jan 2025, Jeff Layton wrote:
>>> On Wed, 2025-01-15 at 10:03 -0500, Chuck Lever wrote:
>>>> On 1/14/25 2:39 PM, Jeff Layton wrote:
>>>>> On Tue, 2025-01-14 at 14:27 -0500, Jeff Layton wrote:
>>>>>> On Mon, 2025-01-13 at 10:59 +0800, Li Lingfeng wrote:
>>>>>>> In nfsd_file_put, after inserting the nfsd_file into the 
>>>>>>> nfsd_file_lru
>>>>>>> list, gc may be triggered in another thread and immediately 
>>>>>>> release this
>>>>>>> nfsd_file, which will lead to a UAF when accessing this 
>>>>>>> nfsd_file again.
>>>>>>>
>>>>>>> All the places where unhash is done will also perform 
>>>>>>> lru_remove, so there
>>>>>>> is no need to do lru_remove separately here. After inserting the 
>>>>>>> nfsd_file
>>>>>>> into the nfsd_file_lru list, it can be released by relying on gc.
>>>>>>>
>>>>>>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the 
>>>>>>> filecache LRU")
>>>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>>> ---
>>>>>>>    fs/nfsd/filecache.c | 12 ++----------
>>>>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>>>> index a1cdba42c4fa..37b65cb1579a 100644
>>>>>>> --- a/fs/nfsd/filecache.c
>>>>>>> +++ b/fs/nfsd/filecache.c
>>>>>>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>>>>            /* Try to add it to the LRU.  If that fails, 
>>>>>>> decrement. */
>>>>>>>            if (nfsd_file_lru_add(nf)) {
>>>>>>>                /* If it's still hashed, we're done */
>>>>>>> -            if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>>>>> +            if (list_lru_count(&nfsd_file_lru))
>>>>>>>                    nfsd_file_schedule_laundrette();
>>>>>>> -                return;
>>>>>>> -            }
>>>>>>>    -            /*
>>>>>>> -             * We're racing with unhashing, so try to remove it 
>>>>>>> from
>>>>>>> -             * the LRU. If removal fails, then someone else 
>>>>>>> already
>>>>>>> -             * has our reference.
>>>>>>> -             */
>>>>>>> -            if (!nfsd_file_lru_remove(nf))
>>>>>>> -                return;
>>>>>>> +            return;
>>>>>>>            }
>>>>>>>        }
>>>>>>>        if (refcount_dec_and_test(&nf->nf_ref))
>>>>>> I think this looks OK. Filecache bugs are particularly nasty 
>>>>>> though, so
>>>>>> let's run this through a nice long testing cycle.
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>> Actually, I take it back. This is problematic in another way.
>>>>>
>>>>> In this case, we're racing with another task that is unhashing the
>>>>> object, but we've put it on the LRU ourselves. What guarantee do we
>>>>> have that the unhashing and removal from the LRU didn't occur before
>>>>> this task called nfsd_file_lru_add()? That's why we attempt to remove
>>>>> it here -- we can't rely on the task that unhashed it to do so at 
>>>>> that
>>>>> point.
>>>>>
>>>>> What might be best is to take and hold the rcu_read_lock() before 
>>>>> doing
>>>>> the nfsd_file_lru_add, and just release it after we do these racy
>>>>> checks. That should make it safe to access the object.
>>>>>
>>>>> Thoughts?
>>>> Holding the RCU read lock will keep the dereferences safe since
>>>> nfsd_file objects are freed only after an RCU grace period. But 
>>>> will the
>>>> logic in nfsd_file_put() work properly on totally dead nfsd_file
>>>> objects? I don't see a specific failure mode there, but I'm not very
>>>> imaginative.
>>>>
>>>> Overall, I think RCU would help.
>>>>
>>>>
>>> To be clear, I think we need to drop e57420be100ab from your nfsd-
>>> testing branch. The race I identified above is quite likely to occur
>>> and could lead to leaks.
>>>
>>> If Li Lingfeng doesn't propose a patch, I'll spin one up tomorrow. I
>>> think the RCU approach is safe.
>> I'm not convinced this is the right approach.
>> I cannot see how nfsd_file_put() can race with unhashing.  If it cannot
>> then we can simply unconditionally call nfsd_file_schedule_laundrette().
>>
>> Can describe how the race can happen - if indeed it can.
> At the beginning, our testing team discovered this issue on 5.10 using
> their own test cases (I'm not clear on how their test cases were
> constructed).
> Then, I found that there might be a problem here, so I reproduced the
> phenomenon in the above way.
> I will ask if their test cases can be shared externally or if they can
> describe what their test cases did.
They used three machines for the test: one server and two clients.
ClientA continuously creates and deletes a file, while ClientB uses fio to
perform random writes on this file.

I found the original stack trace (since I only have a screenshot, I can
only extract some important information from it):
list_del corruption. prev-next should be ffff000052be6828, but was 
ffff000052221e48
WARNING:CPU: 1 PID: 12224at lib/list_debug.c:95 
list_del_entry_valid+Oxe0/0x10
...
Call trace:
  list_del_entry_valid+Oxe0/0x10c
  list_lru_del+0xb4/0x19c
  nfsd_file_put+0x134/0xla0 [nfsd]
  nfsd_read+0xc0/0xldo [nfsd
  nfsd3_proc_read+0xl44/0xla0 [nfsd]
  nfsd_dispatch+0x190/0x254 [nfsd]
  svc_process_common+Ox52c/0x780 [sunrpc]
  svc_process+Ox88/0xe4 [sunrpc]
  nfsd+0xb4/0x160 [nfsd]
  kthread+0x108/0x134
  ret_from_fork+ох10/0xl8
---[ end trace f87713f92e49e854 ]---

refcount_t: underflow;use-after-free.
WARNING:CPU: 1 PID: 12220 at lib/refcount.c:28 
refcount_warn_saturate+0xf4/0xl44
...
Call trace:
  refcount_warn_saturate+0xf4/0x144
  nfsd_file_put+0x160/0xla0 [nfsd]
  nfsd_read+oxco/0xld0 [nfsd]
  nfsd3_proc_read+0xl44/0xla0 [nfsd]
  nfsd_dispatch+0x190/0x254 [nfsd]
  svc_process_common+Ox52c/0x780[sunrpc]
  svc_process+0x88/0xe4_ [sunrpc]
  nfsd+0xb4/0x160 [nfsd]
  kthread+0x108/0x134
  ret_from_fork+0x10/0x18
  ---[ end tracef87713f92e49e853 ]---

After applying this modification, this test case no longer encountered any
issues.
>> Note that we also need rcu protection in nfsd_file_lru_add() so that the
>> nf doesn't get freed after it is added the the lru and before the trace
>> point.  If we don't end up needing rcu round the call, we will need it
>> in the call.
>>
>> Thanks,
>> NeilBrown


