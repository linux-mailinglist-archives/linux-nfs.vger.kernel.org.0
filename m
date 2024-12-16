Return-Path: <linux-nfs+bounces-8573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7809F3217
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB66216680B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8720551E;
	Mon, 16 Dec 2024 13:58:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804329CA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357522; cv=none; b=VMZ7v4gr715AVTePqpoZ3DuePY9CUN5OL/5ym/2H4CVft+P7ogPgNqTbLR3FodEXdTaeLJm5pdnkIpd8VdPUdIDJRxgEkwe2KqZcq54BNUbvYKSSyxrlL9e17EDWf9AdaEHBcQ8ZH1O+7fNNWKDV4rAFmNXuR0eh1KgaJcSAweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357522; c=relaxed/simple;
	bh=lDm06dcQ1ONe8rQauRVy1Q79S+PJeWq6qLurUUuVZOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jUm3h4jIkpImnvC+iFpS7eMC5D+0+o6op5L8V1iURedWOxdM8CW633+/KaD3yXTm3YfleACVsPhPAWRZyBCUbt4Mu85QiOVThFlE2UWB7C1wi5D+JMwhFYbvGKiGspFicBhzVpmDzs1ExL4Lrf/YahaeJC5fyyjRsNlinjpxQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YBhNl2R7Hz1JFMw;
	Mon, 16 Dec 2024 21:58:15 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 051A61A0188;
	Mon, 16 Dec 2024 21:58:36 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 21:58:35 +0800
Message-ID: <1d1e1432-80b5-5d41-d202-3dffe61b207b@huawei.com>
Date: Mon, 16 Dec 2024 21:58:34 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: do not use async mode when not in rcu context
To: Chuck Lever <chuck.lever@oracle.com>, yangerkun
	<yangerkun@huaweicloud.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>
CC: <liumingrui@huawei.com>
References: <20241214134916.422488-1-yangerkun@huaweicloud.com>
 <eb4a56e2-d6d2-0491-fcf5-95d5c29cd7ab@huaweicloud.com>
 <c210fba1-181f-4e5a-adf1-4305c7f01ac8@oracle.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <c210fba1-181f-4e5a-adf1-4305c7f01ac8@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/12/16 21:48, Chuck Lever 写道:
> On 12/15/24 10:18 PM, yangerkun wrote:
>>
>>
>> 在 2024/12/14 21:49, Yang Erkun 写道:
>>> From: Yang Erkun <yangerkun@huawei.com>
>>>
>>> shell:
>>>
>>> mkfs.xfs -f /dev/sda
>>> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
>>> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
>>> exportfs -ra
>>> service nfs-server start
>>> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>>> mount /dev/sda /mnt/sda
>>> touch /mnt1/sda/file
>>> exportfs -r
>>> umount /mnt/sda
>>>
>>> Commit f8c989a0c89a ("nfsd: release svc_expkey/svc_export with 
>>> rcu_work")
>>> describe that when we call e_show/c_show, the last reference can down to
>>> 0, and we will call expkey_put/svc_export_put with rcu context, this may
>>> lead uaf or sleep in atomic bug. Finally, we introduce async mode to the
>>> release and fix the bug. However, some other command may also finally 
>>> call
>>> expkey_put/svc_export_put without rcu context, but expect that the sync
>>> mode for the resource release. Like upper shell, before that commit,
>>> exportfs -r will remove all entry with sync mode, and the last umount
>>> /mnt/sda will always success. But after this commit, the umount will 
>>> always
>>> fail, after we add some delay, they will success again. Personally, I 
>>> think
>>> is actually a bug, and need be fixed.
>>>
>>> Use rcu_read_lock_any_held to distinguish does we really under rcu 
>>> context,
>>> and if no, release resource with sync mode.
>>>
>>> Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with 
>>> rcu_work")
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>   fs/nfsd/export.c | 44 ++++++++++++++++++++++++++++++++------------
>>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>> index eacafe46e3b6..25f13e877c2f 100644
>>> --- a/fs/nfsd/export.c
>>> +++ b/fs/nfsd/export.c
>>> @@ -40,11 +40,8 @@
>>>   #define    EXPKEY_HASHMAX        (1 << EXPKEY_HASHBITS)
>>>   #define    EXPKEY_HASHMASK        (EXPKEY_HASHMAX -1)
>>> -static void expkey_put_work(struct work_struct *work)
>>> +static void expkey_release(struct svc_expkey *key)
>>>   {
>>> -    struct svc_expkey *key =
>>> -        container_of(to_rcu_work(work), struct svc_expkey, 
>>> ek_rcu_work);
>>> -
>>>       if (test_bit(CACHE_VALID, &key->h.flags) &&
>>>           !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>>           path_put(&key->ek_path);
>>> @@ -52,12 +49,25 @@ static void expkey_put_work(struct work_struct 
>>> *work)
>>>       kfree(key);
>>>   }
>>> +static void expkey_put_work(struct work_struct *work)
>>> +{
>>> +    struct svc_expkey *key =
>>> +        container_of(to_rcu_work(work), struct svc_expkey, 
>>> ek_rcu_work);
>>> +
>>> +    expkey_release(key);
>>> +}
>>> +
>>>   static void expkey_put(struct kref *ref)
>>>   {
>>>       struct svc_expkey *key = container_of(ref, struct svc_expkey, 
>>> h.ref);
>>> -    INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>>> -    queue_rcu_work(system_wq, &key->ek_rcu_work);
>>> +    if (rcu_read_lock_any_held()) {
>>
>> Emm...
>>
>> This api won't work when we disable CONFIG_PREEMPT_COUNT...
> 
> OK, I assume you will send a v2 :-)

Yes~ V2 will be posted soon.

> 
> Can you include the reviewers listed in MAINTAINERS on the To: line?
> 
> R:      Neil Brown <neilb@suse.de>
> R:      Olga Kornievskaia <okorniev@redhat.com>
> R:      Dai Ngo <Dai.Ngo@oracle.com>
> R:      Tom Talpey <tom@talpey.com>
> 
> Thanks!

Thanks for your reminder!

> 
> 
>>> +        INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>>> +        queue_rcu_work(system_wq, &key->ek_rcu_work);
>>> +    } else {
>>> +        synchronize_rcu();
>>> +        expkey_release(key);
>>> +    }
>>>   }
>>>   static int expkey_upcall(struct cache_detail *cd, struct cache_head 
>>> *h)
>>> @@ -364,11 +374,8 @@ static void export_stats_destroy(struct 
>>> export_stats *stats)
>>>                           EXP_STATS_COUNTERS_NUM);
>>>   }
>>> -static void svc_export_put_work(struct work_struct *work)
>>> +static void svc_export_release(struct svc_export *exp)
>>>   {
>>> -    struct svc_export *exp =
>>> -        container_of(to_rcu_work(work), struct svc_export, 
>>> ex_rcu_work);
>>> -
>>>       path_put(&exp->ex_path);
>>>       auth_domain_put(exp->ex_client);
>>>       nfsd4_fslocs_free(&exp->ex_fslocs);
>>> @@ -378,12 +385,25 @@ static void svc_export_put_work(struct 
>>> work_struct *work)
>>>       kfree(exp);
>>>   }
>>> +static void svc_export_put_work(struct work_struct *work)
>>> +{
>>> +    struct svc_export *exp =
>>> +        container_of(to_rcu_work(work), struct svc_export, 
>>> ex_rcu_work);
>>> +
>>> +    svc_export_release(exp);
>>> +}
>>> +
>>>   static void svc_export_put(struct kref *ref)
>>>   {
>>>       struct svc_export *exp = container_of(ref, struct svc_export, 
>>> h.ref);
>>> -    INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>>> -    queue_rcu_work(system_wq, &exp->ex_rcu_work);
>>> +    if (rcu_read_lock_any_held()) {
>>> +        INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>>> +        queue_rcu_work(system_wq, &exp->ex_rcu_work);
>>> +    } else {
>>> +        synchronize_rcu();
>>> +        svc_export_release(exp);
>>> +    }
>>>   }
>>>   static int svc_export_upcall(struct cache_detail *cd, struct 
>>> cache_head *h)
>>
> 
> 

