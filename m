Return-Path: <linux-nfs+bounces-8799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE69FCF55
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 01:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F463A03FD
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DC8821;
	Fri, 27 Dec 2024 00:54:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281019A;
	Fri, 27 Dec 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735260876; cv=none; b=tOjeJ8Ha+GdkbjxqIgD9Jdko5S3bUdT4A+cLjtqoGAoZqnb4OWk9ETZqy6xXkfDVxa4EVCM2uSU78S+5gQZKS9QEr8phiFYhH7kCkopCXbtzgbn+BEyJE+h7IjZC0W47iuItPE7EBFAAvwvMxYd979QBJ+ELA1WwPo4nwd0Dx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735260876; c=relaxed/simple;
	bh=Lplc5YB9MP5FbQHMSh3VBy5pzNH85TIyHxKCSGpQtM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frR0zdDQTby+P4e8oZQasiW31R/Xb980ngnd05FXzTaUlb6saVkltFweEnMarFxJYtOkmAWGKJDdMHu3w30ou28qFvvZ+D1vAbcLZp2wi9Do12ZEsb+ngHa5xBSumIuAPfgoytu1Fsq8ad7nHKDsffs//I+5NOHC9ANjxtTwLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YK6Sp2P0Tz4f3lVL;
	Fri, 27 Dec 2024 08:54:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 337311A0359;
	Fri, 27 Dec 2024 08:54:23 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4e9+m1nd7z0Fg--.31264S3;
	Fri, 27 Dec 2024 08:54:22 +0800 (CST)
Message-ID: <3edb6771-9b61-2efc-1295-48d962af7acc@huaweicloud.com>
Date: Fri, 27 Dec 2024 08:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/4] nfsd: fix UAF when access ex_uuid or ex_stats
To: NeilBrown <neilb@suse.de>, Yang Erkun <yangerkun@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, liumingrui@huawei.com
References: <20241225065908.1547645-1-yangerkun@huawei.com>
 <20241225065908.1547645-5-yangerkun@huawei.com>
 <173525491450.11072.2429748630003567820@noble.neil.brown.name>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <173525491450.11072.2429748630003567820@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4e9+m1nd7z0Fg--.31264S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4fAF4kJryfWr1DWryDKFg_yoWrCFW5pa
	ykJayxCF1kJFW8ArZFy3WUXa4rtFsaqr1I9rn7KF43ZF9xJr1DGFyjvryq9ryjkrW8C3y8
	u3WjyFyDCw1rAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/27 7:15, NeilBrown 写道:
> On Wed, 25 Dec 2024, Yang Erkun wrote:
>> We can access exp->ex_stats or exp->ex_uuid in rcu context(c_show and
>> e_show). All these resources should be released using kfree_rcu. Fix this
>> by using call_rcu, clean them all after a rcu grace period.
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
>> Read of size 1 at addr ff11000010fdc120 by task cat/870
>>
>> CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.16.1-2.fc37 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x53/0x70
>>   print_address_description.constprop.0+0x2c/0x3a0
>>   print_report+0xb9/0x280
>>   kasan_report+0xae/0xe0
>>   svc_export_show+0x362/0x430 [nfsd]
>>   c_show+0x161/0x390 [sunrpc]
>>   seq_read_iter+0x589/0x770
>>   seq_read+0x1e5/0x270
>>   proc_reg_read+0xe1/0x140
>>   vfs_read+0x125/0x530
>>   ksys_read+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Allocated by task 830:
>>   kasan_save_stack+0x20/0x40
>>   kasan_save_track+0x14/0x30
>>   __kasan_kmalloc+0x8f/0xa0
>>   __kmalloc_node_track_caller_noprof+0x1bc/0x400
>>   kmemdup_noprof+0x22/0x50
>>   svc_export_parse+0x8a9/0xb80 [nfsd]
>>   cache_do_downcall+0x71/0xa0 [sunrpc]
>>   cache_write_procfs+0x8e/0xd0 [sunrpc]
>>   proc_reg_write+0xe1/0x140
>>   vfs_write+0x1a5/0x6d0
>>   ksys_write+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Freed by task 868:
>>   kasan_save_stack+0x20/0x40
>>   kasan_save_track+0x14/0x30
>>   kasan_save_free_info+0x3b/0x60
>>   __kasan_slab_free+0x37/0x50
>>   kfree+0xf3/0x3e0
>>   svc_export_put+0x87/0xb0 [nfsd]
>>   cache_purge+0x17f/0x1f0 [sunrpc]
>>   nfsd_destroy_serv+0x226/0x2d0 [nfsd]
>>   nfsd_svc+0x125/0x1e0 [nfsd]
>>   write_threads+0x16a/0x2a0 [nfsd]
>>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>   vfs_write+0x1a5/0x6d0
>>   ksys_write+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
>> Reviewed-by: NeilBrown <neilb@suse.de>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index c6168bccfb6c..0363720280d4 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -355,16 +355,25 @@ static void export_stats_destroy(struct export_stats *stats)
>>   					    EXP_STATS_COUNTERS_NUM);
>>   }
>>   
>> -static void svc_export_put(struct kref *ref)
>> +static void svc_export_release(struct rcu_head *rcu_head)
>>   {
>> -	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>> -	path_put(&exp->ex_path);
>> -	auth_domain_put(exp->ex_client);
>> +	struct svc_export *exp = container_of(rcu_head, struct svc_export,
>> +			ex_rcu);
>> +
>>   	nfsd4_fslocs_free(&exp->ex_fslocs);
>>   	export_stats_destroy(exp->ex_stats);
>>   	kfree(exp->ex_stats);
>>   	kfree(exp->ex_uuid);
>> -	kfree_rcu(exp, ex_rcu);
>> +	kfree(exp);
>> +}
>> +
>> +static void svc_export_put(struct kref *ref)
>> +{
>> +	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>> +
>> +	path_put(&exp->ex_path);
>> +	auth_domain_put(exp->ex_client);
>> +	call_rcu(&exp->ex_rcu, svc_export_release);
>>   }
>>   
> 
> I think that ip_map_put() needs to be fixed for the same reason that
> svc_export_put() needed to be fixed.
> 
> ip_map_put() calls auth_domain_put() in ->im_client immediately, but
> ip_map_show() accesses ->im_client.
> So ip_map_put() needs to delay the auth_domain_put() using rcu.

Thanks for your detail review!

auth_domain_put will eventually call auth_domain_release, which all
.domain_release will call call_rcu to free auth_domain. Maybe it is safe
now?


> 
> These two fixes should really be *before* patch 3/4 as without these
> fixes 3/4 introduces a bug.
> 
> Thanks,
> NeilBrown
> 
> Thanks,


