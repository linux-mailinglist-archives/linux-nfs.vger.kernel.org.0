Return-Path: <linux-nfs+bounces-6689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAE989283
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7981F22EE1
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 01:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252779C2;
	Sun, 29 Sep 2024 01:45:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01928EF
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727574331; cv=none; b=rWDOME4/Cpg901CRuy0E6FYJVdfaxxqdSoTRBS/tDq3OAL1Hg/i+lHO1j3xYmNdQR2aWQhX4hv4GlgnUTV3unVs81qb1Equr8n7lbqrjCCvA7HBYeidhDLR518UTKbmyvzyFMCmEJAMPpCZi0ZGFwkjx/oPF2JatHtTHb7+ZzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727574331; c=relaxed/simple;
	bh=CywZ3ob/FaskPZ5Aor4xHvkLfQS1ubW0/NQ7Or20EBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i6O8Vvq9iBCXOBMedylyUjU1POhuvDE5iaRo1yFNZcb87HXaR1RL//LcnJ3Z+bGOVFtHQBewdAgtEF76VIHCbQlmF/pPss6yAKvX6etRZaUTk3efG68pvIbr87n3gNdxyvFWm9uidsxBzA/fXs8SAk7uHOUXAE42nw/xTAyIW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XGRnL1pCwz1T7vX;
	Sun, 29 Sep 2024 09:43:50 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id F15A31800D2;
	Sun, 29 Sep 2024 09:45:19 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 29 Sep 2024 09:45:19 +0800
Message-ID: <ec268559-2b29-c7b1-85b8-7a86a4ba228a@huawei.com>
Date: Sun, 29 Sep 2024 09:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] NFSV4: fix rpc_task use-after-free when open concurrently
To: yangerkun <yangerkun@huaweicloud.com>, Anna Schumaker
	<anna.schumaker@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
 <929c8087-e28b-43e9-8973-71d9f1b821d6@oracle.com>
 <965aad29-d119-b3bb-1a19-0c52c28fd376@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <965aad29-d119-b3bb-1a19-0c52c28fd376@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/9/29 9:38, yangerkun 写道:
> 
> 
> 在 2024/9/28 4:58, Anna Schumaker 写道:
>> Hi Yang,
>>
>> On 9/26/24 2:12 AM, Yang Erkun wrote:
>>> From: Yang Erkun <yangerkun@huawei.com>
>>>
>>> Two threads that work with the same cred try to open different files
>>> concurrently, they will utilize the same nfs4_state_owner. And in order
>>> to sequential open request send to server, the second task will fall
>>> into RPC_TASK_QUEUED in nfs_wait_on_sequence since there is already one
>>> work doing the open operation. Furthermore, the second task will wait
>>> until the first task completes its work, call rpc_wake_up_queued_task in
>>> nfs_release_seqid to wake up the second task, allowing it to complete
>>> the remaining open operation.
>>>
>>> The preceding logic does not cause any problems under normal
>>> circumstances. However, when once we force an unmount using `umount -f`,
>>> the function nfs_umount_begin attempts to kill all tasks by calling
>>> rpc_signal_task. This help wake up the second task, but it sets the
>>> status to -ERESTARTSYS. This status prevents `nfs4_open_release` from
>>> calling `nfs4_opendata_to_nfs4_state`. Consequently, while the second
>>> task will be freed, the original tasks will still exist in
>>> sequence->list(see nfs_release_seqid). Latter, when the first thread
>>> calls nfs_release_seqid and attempts to wake up the second task, it will
>>> trigger the uaf.
>>>
>>> To resolve this issue, ensure rpc_task will remove it from
>>> sequence->list by adding nfs_release_seqid in nfs4_open_release.
>>>
>>> ==================================================================
>>> BUG: KASAN: slab-use-after-free in rpc_wake_up_queued_task+0xbb/0xc0
>>> Read of size 8 at addr ff11000007639930 by task bash/792
>>>
>>> CPU: 0 UID: 0 PID: 792 Comm: bash Tainted: G    B   W
>>> 6.11.0-09960-gd10b58fe53dc-dirty #10
>>> Tainted: [B]=BAD_PAGE, [W]=WARN
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> 1.16.1-2.fc37 04/01/2014
>>> Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0xa3/0x120
>>>   print_address_description.constprop.0+0x63/0x510
>>>   print_report+0xf5/0x360
>>>   kasan_report+0xd9/0x140
>>>   __asan_report_load8_noabort+0x24/0x40
>>>   rpc_wake_up_queued_task+0xbb/0xc0
>>>   nfs_release_seqid+0x1e1/0x2f0
>>>   nfs_free_seqid+0x1a/0x40
>>>   nfs4_opendata_free+0xc6/0x3e0
>>>   _nfs4_do_open.isra.0+0xbe3/0x1380
>>>   nfs4_do_open+0x28b/0x620
>>>   nfs4_atomic_open+0x2c6/0x3a0
>>>   nfs_atomic_open+0x4f8/0x1180
>>>   atomic_open+0x186/0x4e0
>>>   lookup_open.isra.0+0x3e7/0x15b0
>>>   open_last_lookups+0x85d/0x1260
>>>   path_openat+0x151/0x7b0
>>>   do_filp_open+0x1e0/0x310
>>>   do_sys_openat2+0x178/0x1f0
>>>   do_sys_open+0xa2/0x100
>>>   __x64_sys_openat+0xa8/0x120
>>>   x64_sys_call+0x2507/0x4540
>>>   do_syscall_64+0xa7/0x240
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> ...
>>>
>>> Allocated by task 767:
>>>   kasan_save_stack+0x3b/0x70
>>>   kasan_save_track+0x1c/0x40
>>>   kasan_save_alloc_info+0x44/0x70
>>>   __kasan_slab_alloc+0xaf/0xc0
>>>   kmem_cache_alloc_noprof+0x1e0/0x4f0
>>>   rpc_new_task+0xe7/0x220
>>>   rpc_run_task+0x27/0x7d0
>>>   nfs4_run_open_task+0x477/0x810
>>>   _nfs4_proc_open+0xc0/0x6d0
>>>   _nfs4_open_and_get_state+0x178/0xc50
>>>   _nfs4_do_open.isra.0+0x47f/0x1380
>>>   nfs4_do_open+0x28b/0x620
>>>   nfs4_atomic_open+0x2c6/0x3a0
>>>   nfs_atomic_open+0x4f8/0x1180
>>>   atomic_open+0x186/0x4e0
>>>   lookup_open.isra.0+0x3e7/0x15b0
>>>   open_last_lookups+0x85d/0x1260
>>>   path_openat+0x151/0x7b0
>>>   do_filp_open+0x1e0/0x310
>>>   do_sys_openat2+0x178/0x1f0
>>>   do_sys_open+0xa2/0x100
>>>   __x64_sys_openat+0xa8/0x120
>>>   x64_sys_call+0x2507/0x4540
>>>   do_syscall_64+0xa7/0x240
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Freed by task 767:
>>>   kasan_save_stack+0x3b/0x70
>>>   kasan_save_track+0x1c/0x40
>>>   kasan_save_free_info+0x43/0x80
>>>   __kasan_slab_free+0x4f/0x90
>>>   kmem_cache_free+0x199/0x4f0
>>>   mempool_free_slab+0x1f/0x30
>>>   mempool_free+0xdf/0x3d0
>>>   rpc_free_task+0x12d/0x180
>>>   rpc_final_put_task+0x10e/0x150
>>>   rpc_do_put_task+0x63/0x80
>>>   rpc_put_task+0x18/0x30
>>>   nfs4_run_open_task+0x4f4/0x810
>>>   _nfs4_proc_open+0xc0/0x6d0
>>>   _nfs4_open_and_get_state+0x178/0xc50
>>>   _nfs4_do_open.isra.0+0x47f/0x1380
>>>   nfs4_do_open+0x28b/0x620
>>>   nfs4_atomic_open+0x2c6/0x3a0
>>>   nfs_atomic_open+0x4f8/0x1180
>>>   atomic_open+0x186/0x4e0
>>>   lookup_open.isra.0+0x3e7/0x15b0
>>>   open_last_lookups+0x85d/0x1260
>>>   path_openat+0x151/0x7b0
>>>   do_filp_open+0x1e0/0x310
>>>   do_sys_openat2+0x178/0x1f0
>>>   do_sys_open+0xa2/0x100
>>>   __x64_sys_openat+0xa8/0x120
>>>   x64_sys_call+0x2507/0x4540
>>>   do_syscall_64+0xa7/0x240
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Once I apply this patch I'm seeing my client hang when running 
>> xfstests generic/451 with NFS v4.0. I was wondering if you could check 
>> if you see the same hang, and please fix it if so?
>>
> 
> I have try to reproduce this with kernel commit:

Forget to say, add this patch too...

> 
> commit abf2050f51fdca0fd146388f83cddd95a57a008d
> Merge: 9ab27b018649 81ee62e8d09e
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Sep 23 15:27:58 2024 -0700
> 
>      Merge tag 'media/v6.12-1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> 
> And for nfs4.0/nfs4.1, all seems ok now...
> 
> Can you provide more info about the 'hang' you meet now?
> 
> 
>> Thanks,
>> Anna
>>
>>>
>>> Fixes: 24ac23ab88df ("NFSv4: Convert open() into an asynchronous RPC 
>>> call")
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>   fs/nfs/nfs4proc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index b8ffbe52ba15..4685621ba469 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -2603,6 +2603,7 @@ static void nfs4_open_release(void *calldata)
>>>       struct nfs4_opendata *data = calldata;
>>>       struct nfs4_state *state = NULL;
>>> +    nfs_release_seqid(data->o_arg.seqid);
>>>       /* If this request hasn't been cancelled, do nothing */
>>>       if (!data->cancelled)
>>>           goto out_free;

