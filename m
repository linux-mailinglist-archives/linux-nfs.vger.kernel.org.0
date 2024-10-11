Return-Path: <linux-nfs+bounces-7048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23A999E8A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A8628ADC9
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B2207217;
	Fri, 11 Oct 2024 07:52:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DA209F46
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633132; cv=none; b=KPZGU5ewPqw5JVCRms9+CI0hFR9muawhiWOhgoSeHkes5/ss+S5woYcXalzF4ZqW+bexCcwE0rXnthSJUe5gm5nYfxbf2Xq1RUxUnwgQhehUl30jaN3nBtSxQsWwJLCZX/1t/blQAfWF1L3DioWV/I69HKIwfs1QV3Vj+sR6my8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633132; c=relaxed/simple;
	bh=auzecphhn+1BKWFwNF9RO8mWYisUsd2RXpfS/KHjPHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqXR2B4QWl7d7O/Re8m/0+3yFz0sv7ag6VAbQekyq7Y/qOwYbyg9o+OOY7EjBIdE0s2A7kjQXlxRw5vlVxLAdbP1R+fKwI2Y2CjJNI8Q7WnoSQZPqJfpE+AmpkcUpIzpvNcSqtQNF0o5u+4taI8Sw2OgLlTJG4+8VlUa3gQK8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPzNT4244z4f3kkY
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 15:51:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 659D21A08FC
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 15:52:05 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8cj2QhnCD8fDw--.13586S3;
	Fri, 11 Oct 2024 15:52:05 +0800 (CST)
Message-ID: <024ca71a-9789-bf10-8303-632efbd73603@huaweicloud.com>
Date: Fri, 11 Oct 2024 15:52:03 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] NFSV4: fix rpc_task use-after-free when open concurrently
To: yangerkun <yangerkun@huaweicloud.com>,
 Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org"
 <anna@kernel.org>, "anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>
References: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
 <929c8087-e28b-43e9-8973-71d9f1b821d6@oracle.com>
 <965aad29-d119-b3bb-1a19-0c52c28fd376@huaweicloud.com>
 <ec268559-2b29-c7b1-85b8-7a86a4ba228a@huawei.com>
 <086eb949-6d07-e5af-da65-e4bccf84dd1a@huaweicloud.com>
 <edd32ea932f9b24fe188ffbadb28bc8bf4e066dd.camel@hammerspace.com>
 <ee457c3d-4907-1250-d6de-3839203d5ac0@huaweicloud.com>
 <ea13c82610e341af52724b415a8152c313660f0b.camel@hammerspace.com>
 <ae13ac55-a90f-6cfd-f23b-2ae5999d2f8c@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <ae13ac55-a90f-6cfd-f23b-2ae5999d2f8c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8cj2QhnCD8fDw--.13586S3
X-Coremail-Antispam: 1UD129KBjvAXoW3tw45Xw43Wr17uFyrAFWkJFb_yoW8Aw1DAo
	W8uw1fAr15Jr1UKr1UJw1UXr15Jr1UJr1DJr1UKr13Gr1UXF4UJ34UJryUG3y5Jr4rKr1U
	Aw1UJw1UAFykJr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYS7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/10/11 15:08, yangerkun 写道:
> 
> 
> 在 2024/10/10 22:14, Trond Myklebust 写道:
>> On Thu, 2024-10-10 at 21:40 +0800, yangerkun wrote:
>>>

...

>>>>
>>>
>>>
>>> The logic of this place is a little complicated for me. I'd like to
>>> simplify it:
>>>
>>> Actually, for the normal case, we no need call nfs_release_seqid
>>> here.
>>> The second task will wait until the first task completes its work,
>>> call
>>> rpc_wake_up_queued_task in
>>> nfs_release_seqid(_nfs4_do_open->nfs4_opendata_put-
>>>> nfs4_opendata_free->_,
>>> and the first rpc_task already be freed in nfs4_run_open_task) to
>>> wake
>>> up the second task, allowing it to complete the remaining open
>>> operation. So, no use-after-free will happen.
>>>
>>> Based on this, we should only call nfs_release_seqid for the abnormal
>>> case:
>>>
>>>       - nfs4_opendata->cancelled == true: will return directly in
>>> _nfs4_proc_open
>>
>> This test is not needed. The question of whether or not the caller is
>> still waiting for the RPC call to complete is irrelevant to the problem
>> at hand, and just adds unnecessary testing overhead for the 99.9% case
>> where the OPEN is successful and the caller is waiting to complete the
>> call.
> 
> Yes, agree.
> 
>>
>>>
>>>       - **or** nfs4_opendata->rpc_status != 0: the status will be the
>>> return value for nfs4_run_open_task, then _nfs4_proc_open will return
>>> directly
>>
>> This test is relevant. If the RPC call is interrupted, then it might
>> have happened while we were waiting to be given the sequence lock.
> 
> Yes, agree.
> 
>>
>>>
>>>       - **or** nfs4_opendata->rpc_done != true: _nfs4_proc_open will
>>> return directly
>>
>> This test is relevant, but only in conjunction with the test for -
>>> rpc_status != 0.
>>
>> If ->rpc_status == 0, then we know that we already hold the sequence
>> lock and so there is no danger of the use-after-free occurring.
> 
> Please see the latter detail.
> 
>> Furthermore, we want to keep holding that lock so that we can safely
>> call nfs4_try_open_cached() without having to worry about conflicting
>> CLOSE calls (this is only true for NFSv4.0 - NFSv4.1 can resolve
>> conflicts using nfs41_test_and_free_expired_stateid()).
> 
> Yes, agree.
> 
> 
> Thanks a lot for the detail explain, but with latter kernel diff and 
> testcase(sleep in kernel will help increase the recurrence probability), 
> use-after-free can still happen.
> 
> 
> # kernel diff:
> 
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index c2045a2a9d0f..1502f39ee18c 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -250,6 +250,7 @@ struct nfs4_opendata {
>          bool is_recover;
>          bool cancelled;
>          int rpc_status;
> +       struct rpc_task *task;
>   };
> 
>   struct nfs4_add_xprt_data {
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 4685621ba469..04fdc019965e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -2506,6 +2506,9 @@ static void nfs4_open_prepare(struct rpc_task 
> *task, void *calldata)
>          struct nfs_client *clp = sp->so_server->nfs_client;
>          enum open_claim_type4 claim = data->o_arg.claim;
> 
> +       if (!(data->task))
> +               data->task = task;
> +       printk("%s data %llx task %llx\n", __func__, data, task);
>          if (nfs_wait_on_sequence(data->o_arg.seqid, task) != 0)
>                  goto out_wait;
>          /*
> @@ -2603,7 +2606,10 @@ static void nfs4_open_release(void *calldata)
>          struct nfs4_opendata *data = calldata;
>          struct nfs4_state *state = NULL;
> 
> +       printk("%s data %llx task %llx cancelled %d rpc_status %d 
> rpc_done %d tk_status %d\n",
> +               __func__, data, data->task, data->cancelled, 
> data->rpc_status, data->rpc_done, data->task->tk_status);
> +       if (data->rpc_status != 0 && !data->rpc_done)
> +               nfs_release_seqid(data->o_arg.seqid);
>          /* If this request hasn't been cancelled, do nothing */
>          if (!data->cancelled)
>                  goto out_free;
> @@ -2669,12 +2675,14 @@ static int nfs4_run_open_task(struct 
> nfs4_opendata *data,
>          task = rpc_run_task(&task_setup_data);
>          if (IS_ERR(task))
>                  return PTR_ERR(task);
> +       msleep(100);
>          status = rpc_wait_for_completion_task(task);
>          if (status != 0) {
>                  data->cancelled = true;
>                  smp_wmb();
>          } else
>                  status = data->rpc_status;
> +       msleep(100);
>          rpc_put_task(task);
> 
>          return status;
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 877f682b45f2..81d31b7f723f 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1100,6 +1100,7 @@ void nfs_release_seqid(struct nfs_seqid *seqid)
> 
>                  next = list_first_entry(&sequence->list,
>                                  struct nfs_seqid, list);
> +               mdelay(100);
>                  rpc_wake_up_queued_task(&sequence->wait, next->task);
>          }
>          spin_unlock(&sequence->lock);
> 
> 
> 
> 
> # testcase:
> 
> #!/bin/bash
> 
> mkdir /mnt/sda
> mkdir /mnt/sdb
> mkdir /mnt1
> touch /mnt/sda/file
> touch /mnt/sdb/file
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> while true; do umount -f /mnt1; done &
> while true; do
>          echo "will mount"
>          mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>          exec 4<> /mnt1/sda/file &
>          exec 5<> /mnt1/sdb/file &
>          wait
>          umount /mnt1
>          echo "umount ok"
> done
> 
> 
> [   94.159337] nfs4_open_prepare data ff11000006eec800 task 
> ff110000472e9040
> [   94.172653] nfs4_open_prepare data ff11000006eed800 task 
> ff110000472e88c0
> [   94.369424] nfs4_open_release data ff11000006eec800 task 
> ff110000472e9040 cancelled 0 rpc_status -10013 rpc_done 1 tk_status -10013
> [   94.417483] nfs4_open_release data ff11000006eed800 task 
> ff110000472e88c0 cancelled 0 rpc_status -512 rpc_done 1 tk_status -512
> [   94.476518] 
> ==================================================================
> [   94.477340] BUG: KASAN: slab-use-after-free in 
> rpc_wake_up_queued_task+0x2c/0xc0
> [   94.478850] Read of size 8 at addr ff110000472e88f0 by task sh/856
> [   94.479553]
> [   94.479818] CPU: 2 UID: 0 PID: 856 Comm: sh Not tainted 
> 6.11.0-09961-g2db5fff64932-dirty #23
> [   94.481326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS 1.16.1-2.fc37 04/01/2014
> [   94.483107] Call Trace:
> [   94.483683]  <TASK>
> [   94.483924]  dump_stack_lvl+0xa3/0x120
> [   94.484874]  print_address_description.constprop.0+0x63/0x510
> [   94.486651]  print_report+0xf5/0x360
> [   94.490550]  kasan_report+0xd9/0x140
> [   94.491764]  kasan_check_range+0x2d1/0x300
> [   94.492365]  __kasan_check_read+0x21/0x30
> [   94.492817]  rpc_wake_up_queued_task+0x2c/0xc0
> [   94.493377]  nfs_release_seqid+0x1f8/0x300
> [   94.493935]  nfs_free_seqid+0x1a/0x40
> [   94.494421]  nfs4_opendata_free+0xc6/0x3e0
> [   94.495078]  _nfs4_do_open+0xc0a/0x13b0
> [   94.504619]  nfs4_do_open+0x26d/0x5e0
> [   94.507678]  nfs4_atomic_open+0x2c6/0x3a0
> [   94.509928]  nfs_atomic_open+0x4f8/0x1180
> [   94.514713]  atomic_open+0x186/0x4e0
> [   94.515142]  lookup_open.isra.0+0x3e7/0x15b0
> [   94.516519]  open_last_lookups+0x85d/0x1260
> [   94.517032]  path_openat+0x151/0x7b0
> [   94.518016]  do_filp_open+0x1e0/0x310
> [   94.521059]  do_sys_openat2+0x178/0x1f0
> [   94.524375]  do_sys_open+0xa2/0x100
> [   94.526394]  __x64_sys_openat+0xa8/0x120
> [   94.526857]  x64_sys_call+0x2507/0x4540
> [   94.527289]  do_syscall_64+0xa7/0x240
> [   94.527760]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ...
> [   94.536712]
> [   94.536896] Allocated by task 857:
> [   94.537321]  kasan_save_stack+0x3b/0x70
> [   94.537810]  kasan_save_track+0x1c/0x40
> [   94.538330]  kasan_save_alloc_info+0x44/0x70
> [   94.538829]  __kasan_slab_alloc+0xaf/0xc0
> [   94.539298]  kmem_cache_alloc_noprof+0x1e0/0x4f0
> [   94.539903]  rpc_new_task+0xe7/0x220
> [   94.540321]  rpc_run_task+0x27/0x7d0
> [   94.540836]  nfs4_run_open_task+0x477/0x810
> [   94.541380]  _nfs4_proc_open+0xc0/0x6d0
> [   94.541905]  _nfs4_open_and_get_state+0x178/0xc50
> [   94.542476]  _nfs4_do_open+0x4a6/0x13b0
> [   94.542967]  nfs4_do_open+0x26d/0x5e0
> [   94.543473]  nfs4_atomic_open+0x2c6/0x3a0
> [   94.543947]  nfs_atomic_open+0x4f8/0x1180
> [   94.544398]  atomic_open+0x186/0x4e0
> [   94.544862]  lookup_open.isra.0+0x3e7/0x15b0
> [   94.545406]  open_last_lookups+0x85d/0x1260
> [   94.545878]  path_openat+0x151/0x7b0
> [   94.546387]  do_filp_open+0x1e0/0x310
> [   94.546868]  do_sys_openat2+0x178/0x1f0
> [   94.547341]  do_sys_open+0xa2/0x100
> [   94.547799]  __x64_sys_openat+0xa8/0x120
> [   94.548335]  x64_sys_call+0x2507/0x4540
> [   94.548819]  do_syscall_64+0xa7/0x240
> [   94.549317]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   94.549969]
> [   94.550177] Freed by task 857:
> [   94.550603]  kasan_save_stack+0x3b/0x70
> [   94.551101]  kasan_save_track+0x1c/0x40
> [   94.551558]  kasan_save_free_info+0x43/0x80
> [   94.552140]  __kasan_slab_free+0x4f/0x90
> [   94.552587]  kmem_cache_free+0x199/0x4f0
> [   94.553111]  mempool_free_slab+0x1f/0x30
> [   94.553600]  mempool_free+0xdf/0x3d0
> [   94.554072]  rpc_free_task+0x12d/0x180
> [   94.554525]  rpc_final_put_task+0x10e/0x150
> [   94.555022]  rpc_do_put_task+0x63/0x80
> [   94.555532]  rpc_put_task+0x18/0x30
> [   94.556004]  nfs4_run_open_task+0x506/0x810
> [   94.556491]  _nfs4_proc_open+0xc0/0x6d0
> [   94.557008]  _nfs4_open_and_get_state+0x178/0xc50
> [   94.557551]  _nfs4_do_open+0x4a6/0x13b0
> [   94.557982]  nfs4_do_open+0x26d/0x5e0
> [   94.558464]  nfs4_atomic_open+0x2c6/0x3a0
> [   94.558968]  nfs_atomic_open+0x4f8/0x1180
> [   94.559428]  atomic_open+0x186/0x4e0
> [   94.559818]  lookup_open.isra.0+0x3e7/0x15b0
> [   94.560327]  open_last_lookups+0x85d/0x1260
> [   94.560831]  path_openat+0x151/0x7b0
> [   94.561330]  do_filp_open+0x1e0/0x310
> [   94.561770]  do_sys_openat2+0x178/0x1f0
> [   94.562184]  do_sys_open+0xa2/0x100
> [   94.562563]  __x64_sys_openat+0xa8/0x120
> [   94.563057]  x64_sys_call+0x2507/0x4540
> [   94.563532]  do_syscall_64+0xa7/0x240
> [   94.563956]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 
> 
> 
> 
> 
> 
> Things go like this:
> 
> Thread A                            Thread B
> 
> // _nfs4_do_open
> opendata1 and seqid1
> 
> // nfs4_run_open_task
> rpc_task1
>                                     // _nfs4_do_open
>                                     opendata2 and seqid2
> 
>                                     // nfs4_run_open_task
>                                     rpc_task2
> 
> // nfs4_run_open_task
> rpc_task1 free
> 
> 
> -------------------------------------------------------
>                      umount -f generate signal
> -------------------------------------------------------
>                                    // wakeup by signal
>                                    rpc_task2 free, seqid2 still
>                    alive since rpc_status == -512,
>                                    rpc_done == true
> 
> 
> 
> // _nfs4_do_open
> put opendata1 and
> then nfs_free_seqid
> release seqid1, wakeup
> rpc_task2, but task2 has
> been freed, UAF!!!!!!
> 
>                                    // _nfs4_do_open
>                                    put opendata2 and release seqid2,
>                                    but it's too later...
> 
> 
> Actually, once seqid2 can be released correctly, use-after-free may also 
> trigger...
> 
> Thread A                            Thread B
> 
> // _nfs4_do_open
> opendata1 and seqid1
> 
> // nfs4_run_open_task
> rpc_task1
>                                     // _nfs4_do_open
>                                     opendata2 and seqid2
> 
>                                     // nfs4_run_open_task
>                                     rpc_task2
> 
> // nfs4_run_open_task
> rpc_task1 free
> 
> 
> -------------------------------------------------------
>                      umount -f generate signal
> -------------------------------------------------------
>                                    // wakeup by signal
>                                    rpc_task2 free, and nfs_free_seqid
>                                    will be trigger, try to wakeup
>                                    rpc_task1, trigger UAF!!!!
> 
> 
> 
> // _nfs4_do_open
> put opendata1 and
> then nfs_free_seqid
> release seqid1, but
> too later...
>                                    // _nfs4_do_open
>                                    put opendata2 and release seqid2
> 
> 
> 
> How about ping task->tk_count, and not release it until 
> nfs_release_seqid...

After testing, there are some problems with the code here, please ignore it.

> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 877f682b45f2..15eb6ef611fb 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1095,11 +1095,14 @@ void nfs_release_seqid(struct nfs_seqid *seqid)
>          sequence = seqid->sequence;
>          spin_lock(&sequence->lock);
>          list_del_init(&seqid->list);
> +       if (seqid->task)
> +               rpc_put_task(seqid->task);
>          if (!list_empty(&sequence->list)) {
>                  struct nfs_seqid *next;
> 
>                  next = list_first_entry(&sequence->list,
>                                  struct nfs_seqid, list);
> +               mdelay(100);
>                  rpc_wake_up_queued_task(&sequence->wait, next->task);
>          }
>          spin_unlock(&sequence->lock);
> @@ -1181,8 +1184,10 @@ int nfs_wait_on_sequence(struct nfs_seqid *seqid, 
> struct rpc_task *task)
>          sequence = seqid->sequence;
>          spin_lock(&sequence->lock);
>          seqid->task = task;
> -       if (list_empty(&seqid->list))
> +       if (list_empty(&seqid->list)) {
>                  list_add_tail(&seqid->list, &sequence->list);
> +               atomic_inc(&task->tk_count);
> +       }
>          if (list_first_entry(&sequence->list, struct nfs_seqid, list) 
> == seqid)
>                  goto unlock;
>          rpc_sleep_on(&sequence->wait, task, NULL);
> 
> 
> 
> 
> 
>>
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index b8ffbe52ba15..d2d7d84f0ed2 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -2603,6 +2603,8 @@ static void nfs4_open_release(void *calldata)
>>>           struct nfs4_opendata *data = calldata;
>>>           struct nfs4_state *state = NULL;
>>>
>>> +       if (data->cancelled || data->rpc_status != 0 || !data-
>>>> rpc_done)
>>> +               nfs_release_seqid(data->o_arg.seqid);
>>>
>>>           /* If this request hasn't been cancelled, do nothing */
>>>           if (!data->cancelled)
>>>                   goto out_free;
>>>
>>>
>>> Looking forward to your reply!
>>>
>>
>> See inlined comments above. Thanks!
>>


