Return-Path: <linux-nfs+bounces-7348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D41109A953F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 03:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1571C22035
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC834CDE;
	Tue, 22 Oct 2024 01:08:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3984A35
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559334; cv=none; b=UxpBKxTSuKI02ofoVy7TAo+iWC+oJo8StsjKE70pudPWpGOaq513D8+r/teeUuFH+t6aZHUzIBxA3E1pPJh7zsWx2SFR5n7RDP7uW0uwAkO2q3oj+GqPPw5lVIqjA4QH3pasykWXMy5L2EwyPZUc9lO8TL+GLpnUtQuOOhnnqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559334; c=relaxed/simple;
	bh=5NT3Orafs42Qamv0ZeT5GmoNIS9+I0+dPxp02VO62Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyOs3u6ANR41RiRmWGws9qcxrti+nJZB9t+DFKl+2PDWDJW+EYytXc1NLFukG4rEXm6OccvT5RXlXLzwmDTtyUXfQamp9tfzc70mz7D+Cd5hqPOP2wPIGn2K/3I958qhmkdSRT/CNgg/Y9fr3IGuOpmBpjC7g9Rrs1Iwv3blOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXYw41m0Zz4f3jkV
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:08:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8067A1A0568
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:08:48 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYf+xZn1fwNEw--.17326S3;
	Tue, 22 Oct 2024 09:08:48 +0800 (CST)
Message-ID: <60719c64-bb9c-e96e-f4d3-f614575127f2@huaweicloud.com>
Date: Tue, 22 Oct 2024 09:08:47 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] nfsd: release svc_expkey/svc_export with rcu_work
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
 <20241021142343.3857891-4-yangerkun@huaweicloud.com>
 <ZxaLhaEpa49lsvhw@tissot.1015granger.net>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <ZxaLhaEpa49lsvhw@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYf+xZn1fwNEw--.17326S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4ftry7Wr1kZF17AF4kCrg_yoWxurWDpa
	95JaySkay8XFyUuw4jqa1UXwn3tFsavr1xur1xKF4FqFyYyr1kGF1UZryj9ryYkrW8u3yI
	9F4Uta1Duwn5Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/10/22 1:12, Chuck Lever 写道:
> On Mon, Oct 21, 2024 at 10:23:43PM +0800, Yang Erkun wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> The last reference for `cache_head` can be reduced to zero in `c_show`
>> and `e_show`(using `rcu_read_lock` and `rcu_read_unlock`). Consequently,
>> `svc_export_put` and `expkey_put` will be invoked, leading to two
>> issues:
>>
>> 1. The `svc_export_put` will directly free ex_uuid. However,
>>     `e_show`/`c_show` will access `ex_uuid` after `cache_put`, which can
>>     trigger a use-after-free issue, shown below.
>>
>>     ==================================================================
>>     BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
>>     Read of size 1 at addr ff11000010fdc120 by task cat/870
>>
>>     CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>     1.16.1-2.fc37 04/01/2014
>>     Call Trace:
>>      <TASK>
>>      dump_stack_lvl+0x53/0x70
>>      print_address_description.constprop.0+0x2c/0x3a0
>>      print_report+0xb9/0x280
>>      kasan_report+0xae/0xe0
>>      svc_export_show+0x362/0x430 [nfsd]
>>      c_show+0x161/0x390 [sunrpc]
>>      seq_read_iter+0x589/0x770
>>      seq_read+0x1e5/0x270
>>      proc_reg_read+0xe1/0x140
>>      vfs_read+0x125/0x530
>>      ksys_read+0xc1/0x160
>>      do_syscall_64+0x5f/0x170
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>     Allocated by task 830:
>>      kasan_save_stack+0x20/0x40
>>      kasan_save_track+0x14/0x30
>>      __kasan_kmalloc+0x8f/0xa0
>>      __kmalloc_node_track_caller_noprof+0x1bc/0x400
>>      kmemdup_noprof+0x22/0x50
>>      svc_export_parse+0x8a9/0xb80 [nfsd]
>>      cache_do_downcall+0x71/0xa0 [sunrpc]
>>      cache_write_procfs+0x8e/0xd0 [sunrpc]
>>      proc_reg_write+0xe1/0x140
>>      vfs_write+0x1a5/0x6d0
>>      ksys_write+0xc1/0x160
>>      do_syscall_64+0x5f/0x170
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>     Freed by task 868:
>>      kasan_save_stack+0x20/0x40
>>      kasan_save_track+0x14/0x30
>>      kasan_save_free_info+0x3b/0x60
>>      __kasan_slab_free+0x37/0x50
>>      kfree+0xf3/0x3e0
>>      svc_export_put+0x87/0xb0 [nfsd]
>>      cache_purge+0x17f/0x1f0 [sunrpc]
>>      nfsd_destroy_serv+0x226/0x2d0 [nfsd]
>>      nfsd_svc+0x125/0x1e0 [nfsd]
>>      write_threads+0x16a/0x2a0 [nfsd]
>>      nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>      vfs_write+0x1a5/0x6d0
>>      ksys_write+0xc1/0x160
>>      do_syscall_64+0x5f/0x170
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> 2. We cannot sleep while using `rcu_read_lock`/`rcu_read_unlock`.
>>     However, `svc_export_put`/`expkey_put` will call path_put, which
>>     subsequently triggers a sleeping operation due to the following
>>     `dput`.
>>
>>     =============================
>>     WARNING: suspicious RCU usage
>>     5.10.0-dirty #141 Not tainted
>>     -----------------------------
>>     ...
>>     Call Trace:
>>     dump_stack+0x9a/0xd0
>>     ___might_sleep+0x231/0x240
>>     dput+0x39/0x600
>>     path_put+0x1b/0x30
>>     svc_export_put+0x17/0x80
>>     e_show+0x1c9/0x200
>>     seq_read_iter+0x63f/0x7c0
>>     seq_read+0x226/0x2d0
>>     vfs_read+0x113/0x2c0
>>     ksys_read+0xc9/0x170
>>     do_syscall_64+0x33/0x40
>>     entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>
>> Fix these issues by using `rcu_work` to help release
>> `svc_expkey`/`svc_export`. This approach allows for an asynchronous
>> context to invoke `path_put` and also facilitates the freeing of
>> `uuid/exp/key` after an RCU grace period.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> I'd go with:
> 
> Fixes: 9ceddd9da134 ("knfsd: Allow lockless lookups of the exports")

Hi!

Your advice for this three patches looks good to me, thanks for your review!

> 
> I plan to apply these three to nfsd-next (for v6.13).
> 
> 
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 31 +++++++++++++++++++++++++------
>>   fs/nfsd/export.h |  4 ++--
>>   2 files changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 49aede376d86..6d0455973d64 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -40,15 +40,24 @@
>>   #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>>   #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
>>   
>> -static void expkey_put(struct kref *ref)
>> +static void expkey_put_work(struct work_struct *work)
>>   {
>> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>> +	struct svc_expkey *key =
>> +		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>>   
>>   	if (test_bit(CACHE_VALID, &key->h.flags) &&
>>   	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>   		path_put(&key->ek_path);
>>   	auth_domain_put(key->ek_client);
>> -	kfree_rcu(key, ek_rcu);
>> +	kfree(key);
>> +}
>> +
>> +static void expkey_put(struct kref *ref)
>> +{
>> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>> +
>> +	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>> +	queue_rcu_work(system_wq, &key->ek_rcu_work);
>>   }
>>   
>>   static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
>> @@ -355,16 +364,26 @@ static void export_stats_destroy(struct export_stats *stats)
>>   					    EXP_STATS_COUNTERS_NUM);
>>   }
>>   
>> -static void svc_export_put(struct kref *ref)
>> +static void svc_export_put_work(struct work_struct *work)
>>   {
>> -	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>> +	struct svc_export *exp =
>> +		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
>> +
>>   	path_put(&exp->ex_path);
>>   	auth_domain_put(exp->ex_client);
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
>> +	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>> +	queue_rcu_work(system_wq, &exp->ex_rcu_work);
>>   }
>>   
>>   static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
>> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
>> index 3794ae253a70..081afb68681e 100644
>> --- a/fs/nfsd/export.h
>> +++ b/fs/nfsd/export.h
>> @@ -75,7 +75,7 @@ struct svc_export {
>>   	u32			ex_layout_types;
>>   	struct nfsd4_deviceid_map *ex_devid_map;
>>   	struct cache_detail	*cd;
>> -	struct rcu_head		ex_rcu;
>> +	struct rcu_work		ex_rcu_work;
>>   	unsigned long		ex_xprtsec_modes;
>>   	struct export_stats	*ex_stats;
>>   };
>> @@ -92,7 +92,7 @@ struct svc_expkey {
>>   	u32			ek_fsid[6];
>>   
>>   	struct path		ek_path;
>> -	struct rcu_head		ek_rcu;
>> +	struct rcu_work		ek_rcu_work;
>>   };
>>   
>>   #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
>> -- 
>> 2.39.2
>>
> 


