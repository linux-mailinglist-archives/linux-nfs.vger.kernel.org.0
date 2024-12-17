Return-Path: <linux-nfs+bounces-8619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70699F3FA9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 02:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8891649C9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 01:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683571B95B;
	Tue, 17 Dec 2024 01:05:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA01C687;
	Tue, 17 Dec 2024 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397516; cv=none; b=tMJdrTo4Y1nN+OCeiYWB3lvJEQ3Vmy9VAfeDFmRfZ0CsY181wZjBUeC+8WMraBSl9lykFHfVvbncclpadzOHzd4ptjfdFzh8sx38YQIIieR4IfjsVZIZUjU1OPCgD2RQ2pGiKzUkeE3S/SJFod+0dYSzZQ46By9dd2hzaB1QmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397516; c=relaxed/simple;
	bh=AvZdtb9/Hz/Mhjyq8HktNmB9tLJDbXQL8KufMQ1EF6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAxURyefx04NFPRigYX7ge5YsupuIBIls+Hh8vk8G0WfpaaR1IChmPIEiUzuLsbBPzy0PZTLak1SDDDYrc9AmTqdkNEiwKfiLp3HMT3C+X75/lmorYDAXS0IQ8i4Y1Rn8BzsT8nORMP9kgIvM5hg0/EaIEgejPcKxMgZ33LXZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBz9z6lxDz4f3jqb;
	Tue, 17 Dec 2024 09:04:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E51F1A018C;
	Tue, 17 Dec 2024 09:05:10 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVEzmBnq4tCEw--.13295S3;
	Tue, 17 Dec 2024 09:05:10 +0800 (CST)
Message-ID: <e457414e-f106-3c69-a27f-056101c9cbd9@huaweicloud.com>
Date: Tue, 17 Dec 2024 09:05:08 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 1/5] nfsd: Revert "nfsd: release svc_expkey/svc_export
 with rcu_work"
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: yangerkun@huawei.com, yi.zhang@huawei.com
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
 <20241216142156.4133267-2-yangerkun@huaweicloud.com>
 <4cfae0e3-c5dc-4726-bbc8-dc0b5395d8cd@oracle.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <4cfae0e3-c5dc-4726-bbc8-dc0b5395d8cd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVEzmBnq4tCEw--.13295S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW7Jw17Aw4kXryktr1DZFb_yoW7Cw4rpa
	ykJayYk3y8XF18Wr4UJw1UX345trn0v3WkGw18JayYyrn8Ar10gF1UZryq9ryYyr48W3yx
	Ar10qrnru348XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/16 22:52, Chuck Lever 写道:
> On 12/16/24 9:21 AM, Yang Erkun wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> This reverts commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d.
> 
> The reverted commit is in v6.13-rc1, looks like. Should I apply 1/5 to
> v6.13-rc ?
> 
> The remaining patches in this series will need review and testing,
> so I would like to reserve them for a later merge window, if that
> is OK with you.

Thanks, it's ok to me!

> 
> 
>> Before this commit, svc_export_put or expkey_put will call path_put with
>> sync mode. After this commit, path_put will be called with async mode.
>> And this can lead the unexpected results show as follow.
>>
>> mkfs.xfs -f /dev/sda
>> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
>> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
>> exportfs -ra
>> service nfs-server start
>> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>> mount /dev/sda /mnt/sda
>> touch /mnt1/sda/file
>> exportfs -r
>> umount /mnt/sda # failed unexcepted
>>
>> The touch will finally call nfsd_cross_mnt, add refcount to mount, and
>> then add cache_head. Before this commit, exportfs -r will call
>> cache_flush to cleanup all cache_head, and path_put in
>> svc_export_put/expkey_put will be finished with sync mode. So, the
>> latter umount will always success. However, after this commit, path_put
>> will be called with async mode, the latter umount may failed, and if
>> we add some delay, umount will success too. Personally I think this bug
>> and should be fixed. We first revert before bugfix patch, and then fix
>> the original bug with a different way.
>>
>> Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 31 ++++++-------------------------
>>   fs/nfsd/export.h |  4 ++--
>>   2 files changed, 8 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index eacafe46e3b6..aa4712362b3b 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -40,24 +40,15 @@
>>   #define    EXPKEY_HASHMAX        (1 << EXPKEY_HASHBITS)
>>   #define    EXPKEY_HASHMASK        (EXPKEY_HASHMAX -1)
>> -static void expkey_put_work(struct work_struct *work)
>> +static void expkey_put(struct kref *ref)
>>   {
>> -    struct svc_expkey *key =
>> -        container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>> +    struct svc_expkey *key = container_of(ref, struct svc_expkey, 
>> h.ref);
>>       if (test_bit(CACHE_VALID, &key->h.flags) &&
>>           !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>           path_put(&key->ek_path);
>>       auth_domain_put(key->ek_client);
>> -    kfree(key);
>> -}
>> -
>> -static void expkey_put(struct kref *ref)
>> -{
>> -    struct svc_expkey *key = container_of(ref, struct svc_expkey, 
>> h.ref);
>> -
>> -    INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>> -    queue_rcu_work(system_wq, &key->ek_rcu_work);
>> +    kfree_rcu(key, ek_rcu);
>>   }
>>   static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
>> @@ -364,26 +355,16 @@ static void export_stats_destroy(struct 
>> export_stats *stats)
>>                           EXP_STATS_COUNTERS_NUM);
>>   }
>> -static void svc_export_put_work(struct work_struct *work)
>> +static void svc_export_put(struct kref *ref)
>>   {
>> -    struct svc_export *exp =
>> -        container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
>> -
>> +    struct svc_export *exp = container_of(ref, struct svc_export, 
>> h.ref);
>>       path_put(&exp->ex_path);
>>       auth_domain_put(exp->ex_client);
>>       nfsd4_fslocs_free(&exp->ex_fslocs);
>>       export_stats_destroy(exp->ex_stats);
>>       kfree(exp->ex_stats);
>>       kfree(exp->ex_uuid);
>> -    kfree(exp);
>> -}
>> -
>> -static void svc_export_put(struct kref *ref)
>> -{
>> -    struct svc_export *exp = container_of(ref, struct svc_export, 
>> h.ref);
>> -
>> -    INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>> -    queue_rcu_work(system_wq, &exp->ex_rcu_work);
>> +    kfree_rcu(exp, ex_rcu);
>>   }
>>   static int svc_export_upcall(struct cache_detail *cd, struct 
>> cache_head *h)
>> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
>> index 6f2fbaae01fa..4d92b99c1ffd 100644
>> --- a/fs/nfsd/export.h
>> +++ b/fs/nfsd/export.h
>> @@ -75,7 +75,7 @@ struct svc_export {
>>       u32            ex_layout_types;
>>       struct nfsd4_deviceid_map *ex_devid_map;
>>       struct cache_detail    *cd;
>> -    struct rcu_work        ex_rcu_work;
>> +    struct rcu_head        ex_rcu;
>>       unsigned long        ex_xprtsec_modes;
>>       struct export_stats    *ex_stats;
>>   };
>> @@ -92,7 +92,7 @@ struct svc_expkey {
>>       u32            ek_fsid[6];
>>       struct path        ek_path;
>> -    struct rcu_work        ek_rcu_work;
>> +    struct rcu_head        ek_rcu;
>>   };
>>   #define EX_ISSYNC(exp)        (!((exp)->ex_flags & NFSEXP_ASYNC))
> 
> 


