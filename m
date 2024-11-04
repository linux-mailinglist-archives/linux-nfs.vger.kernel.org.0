Return-Path: <linux-nfs+bounces-7642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA699BAE94
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F98284FD9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058918E364;
	Mon,  4 Nov 2024 08:51:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A231494B1
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710316; cv=none; b=b5v8gEs9JzCPlHhW2R3KHYuaxRNlWBj1U+sURf39Oa/MjvT5YKLOaeG30tG15a0WGcRsH+TiSzLeXjDZHmKkp3NxIiqWFyHgus5Sqsh2AzVimbV2gpa9ysC/c15f0jVTUkQ5PNlMHFflwv/XpgI3WeMFGbHT8WNUuXlbZp9pLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710316; c=relaxed/simple;
	bh=7obj2beYrPTtl1VSpPdTnrlmyjCfGDraiKKHqQGFv8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uDrQrP7S1B4B+MLQSXpWJLiLbzStcXLL5KMDVGJOfa0r7KjqyZEizZxnigVH8YWwjd+gmsVrFl9cOLYKahQuSw3KdMY1bFCe67bN565WthSjAV8oX1zdk+s8K9tgUHuO3O6ChKtHUUi63WEsIWF6KlP7mkRxwsLQWJAzFtwRVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XhlTK0DFGz1HJvV;
	Mon,  4 Nov 2024 16:47:17 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id DBA20140120;
	Mon,  4 Nov 2024 16:51:50 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 16:51:50 +0800
Message-ID: <b9924cd2-253a-6c44-3331-56310f13df0b@huawei.com>
Date: Mon, 4 Nov 2024 16:51:49 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [RFC PATCH] NFSv4: fix rpc_task use-after-free when open
 concurrently
To: Yang Erkun <yangerkun@huaweicloud.com>, <trondmy@kernel.org>,
	<anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
References: <20241022122141.2030194-1-yangerkun@huaweicloud.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20241022122141.2030194-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, we have discovered another similar issue where performing concurrent
operations of opening file B, closing file A, and unmounting while file A
is open can trigger a UAF of rpc_task.

T1: OPEN fileB                     T2: CLOSE fileA T3: UMOUNT
nfs4_do_open
...
  .rpc_call_prepare
  nfs_wait_on_sequence
    // insert to sequence list(T1)
    // This is the first entry,
    // and continue.
                            nfs4_do_close
                             .rpc_call_prepare
                             nfs_wait_on_sequence
                                // insert to sequence list(T2)
                                // This is the second entry,
                                // and wait.
nfs_umount_begin
rpc_killall_tasks
rpc_signal_task // get T2 from clnt->cl_tasks
rpc_wake_up_queued_task_set_status
rpc_wake_up_task_queue_set_status_locked
rpc_wake_up_task_on_wq_queue_action_locked
__rpc_do_wake_up_task_on_wq
rpc_make_runnable
wake_up_bit // wake up T2
...
  rpc_put_task
   // finish rpc_task and free it
                             .rpc_call_done
                             nfs_release_seqid
                              list_first_entry // get T1 from list
                              rpc_wake_up_queued_task // wake up T1, UAF
  _nfs4_open_and_get_state
   _nfs4_open_and_get_state
    _nfs4_opendata_to_nfs4_state
     nfs_release_seqid
      // remove T1 from list

Although the rpc_task corresponding to T1 has been freed, its seqid has
not been removed from the sequence list.
Additionally, even though T2 is the last task in the list, the current
logic of nfs_release_seqid allows T2 to access tasks inserted before it,
which can trigger UAF.
Using nfs_release_seqid_inorder instead of nfs_release_seqid can solve
this problem.
Considering that tasks in the sequence list should not access tasks
inserted before them, would it be better to use nfs_release_seqid_inorder
globally?

在 2024/10/22 20:21, Yang Erkun 写道:
> From: Yang Erkun <yangerkun@huawei.com>
>
> Two threads that work with the same cred try to open different files
> concurrently, they will utilize the same nfs4_state_owner. And in order
> to sequential open request send to server, the second task will fall
> into RPC_TASK_QUEUED in nfs_wait_on_sequence since there is already one
> work doing the open operation. Furthermore, the second task will wait
> until the first task completes its work, call rpc_wake_up_queued_task in
> nfs_release_seqid to wake up the second task, allowing it to complete
> the remaining open operation.
>
> The preceding logic does not cause any problems under normal
> circumstances. However, when once we force an unmount using `umount -f`,
> the function nfs_umount_begin attempts to kill all tasks by calling
> rpc_signal_task. This help wake up the second task, but it sets the
> status to -ERESTARTSYS. This status prevents `nfs4_open_release` from
> calling `nfs4_opendata_to_nfs4_state`. Consequently, while the second
> task will be freed, the original tasks will still exist in
> sequence->list(see nfs_release_seqid). Latter, when the first thread
> calls nfs_release_seqid and attempts to wake up the second task, it will
> trigger the uaf.
>
> To resolve this issue, ensure rpc_task will remove it from
> sequence->list in nfs4_open_release when open failed, besides, we can
> only wakeup the next rpc_task, or use-after-free will happen too since
> privious rpc_task may be released too.
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in rpc_wake_up_queued_task+0xbb/0xc0
> Read of size 8 at addr ff11000007639930 by task bash/792
>
> CPU: 0 UID: 0 PID: 792 Comm: bash Tainted: G    B   W
> 6.11.0-09960-gd10b58fe53dc-dirty #10
> Tainted: [B]=BAD_PAGE, [W]=WARN
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa3/0x120
>   print_address_description.constprop.0+0x63/0x510
>   print_report+0xf5/0x360
>   kasan_report+0xd9/0x140
>   __asan_report_load8_noabort+0x24/0x40
>   rpc_wake_up_queued_task+0xbb/0xc0
>   nfs_release_seqid+0x1e1/0x2f0
>   nfs_free_seqid+0x1a/0x40
>   nfs4_opendata_free+0xc6/0x3e0
>   _nfs4_do_open.isra.0+0xbe3/0x1380
>   nfs4_do_open+0x28b/0x620
>   nfs4_atomic_open+0x2c6/0x3a0
>   nfs_atomic_open+0x4f8/0x1180
>   atomic_open+0x186/0x4e0
>   lookup_open.isra.0+0x3e7/0x15b0
>   open_last_lookups+0x85d/0x1260
>   path_openat+0x151/0x7b0
>   do_filp_open+0x1e0/0x310
>   do_sys_openat2+0x178/0x1f0
>   do_sys_open+0xa2/0x100
>   __x64_sys_openat+0xa8/0x120
>   x64_sys_call+0x2507/0x4540
>   do_syscall_64+0xa7/0x240
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> ...
>
> Allocated by task 767:
>   kasan_save_stack+0x3b/0x70
>   kasan_save_track+0x1c/0x40
>   kasan_save_alloc_info+0x44/0x70
>   __kasan_slab_alloc+0xaf/0xc0
>   kmem_cache_alloc_noprof+0x1e0/0x4f0
>   rpc_new_task+0xe7/0x220
>   rpc_run_task+0x27/0x7d0
>   nfs4_run_open_task+0x477/0x810
>   _nfs4_proc_open+0xc0/0x6d0
>   _nfs4_open_and_get_state+0x178/0xc50
>   _nfs4_do_open.isra.0+0x47f/0x1380
>   nfs4_do_open+0x28b/0x620
>   nfs4_atomic_open+0x2c6/0x3a0
>   nfs_atomic_open+0x4f8/0x1180
>   atomic_open+0x186/0x4e0
>   lookup_open.isra.0+0x3e7/0x15b0
>   open_last_lookups+0x85d/0x1260
>   path_openat+0x151/0x7b0
>   do_filp_open+0x1e0/0x310
>   do_sys_openat2+0x178/0x1f0
>   do_sys_open+0xa2/0x100
>   __x64_sys_openat+0xa8/0x120
>   x64_sys_call+0x2507/0x4540
>   do_syscall_64+0xa7/0x240
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 767:
>   kasan_save_stack+0x3b/0x70
>   kasan_save_track+0x1c/0x40
>   kasan_save_free_info+0x43/0x80
>   __kasan_slab_free+0x4f/0x90
>   kmem_cache_free+0x199/0x4f0
>   mempool_free_slab+0x1f/0x30
>   mempool_free+0xdf/0x3d0
>   rpc_free_task+0x12d/0x180
>   rpc_final_put_task+0x10e/0x150
>   rpc_do_put_task+0x63/0x80
>   rpc_put_task+0x18/0x30
>   nfs4_run_open_task+0x4f4/0x810
>   _nfs4_proc_open+0xc0/0x6d0
>   _nfs4_open_and_get_state+0x178/0xc50
>   _nfs4_do_open.isra.0+0x47f/0x1380
>   nfs4_do_open+0x28b/0x620
>   nfs4_atomic_open+0x2c6/0x3a0
>   nfs_atomic_open+0x4f8/0x1180
>   atomic_open+0x186/0x4e0
>   lookup_open.isra.0+0x3e7/0x15b0
>   open_last_lookups+0x85d/0x1260
>   path_openat+0x151/0x7b0
>   do_filp_open+0x1e0/0x310
>   do_sys_openat2+0x178/0x1f0
>   do_sys_open+0xa2/0x100
>   __x64_sys_openat+0xa8/0x120
>   x64_sys_call+0x2507/0x4540
>   do_syscall_64+0xa7/0x240
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 24ac23ab88df ("NFSv4: Convert open() into an asynchronous RPC call")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   fs/nfs/nfs4_fs.h   |  1 +
>   fs/nfs/nfs4proc.c  |  2 ++
>   fs/nfs/nfs4state.c | 18 ++++++++++++++++++
>   3 files changed, 21 insertions(+)
>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 7d383d29a995..3bbd945a78ca 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -525,6 +525,7 @@ extern struct nfs_seqid *nfs_alloc_seqid(struct nfs_seqid_counter *counter, gfp_
>   extern int nfs_wait_on_sequence(struct nfs_seqid *seqid, struct rpc_task *task);
>   extern void nfs_increment_open_seqid(int status, struct nfs_seqid *seqid);
>   extern void nfs_increment_lock_seqid(int status, struct nfs_seqid *seqid);
> +extern void nfs_release_seqid_inorder(struct nfs_seqid *seqid);
>   extern void nfs_release_seqid(struct nfs_seqid *seqid);
>   extern void nfs_free_seqid(struct nfs_seqid *seqid);
>   extern int nfs4_setup_sequence(struct nfs_client *client,
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index cd2fbde2e6d7..86e093ffb39c 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -2438,6 +2438,8 @@ static void nfs4_open_confirm_release(void *calldata)
>   	struct nfs4_opendata *data = calldata;
>   	struct nfs4_state *state = NULL;
>   
> +	if (data->rpc_status != 0 || !data->rpc_done)
> +		nfs_release_seqid_inorder(data->o_arg.seqid);
>   	/* If this request hasn't been cancelled, do nothing */
>   	if (!data->cancelled)
>   		goto out_free;
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index dafd61186557..df5e7a0b6528 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1075,6 +1075,24 @@ struct nfs_seqid *nfs_alloc_seqid(struct nfs_seqid_counter *counter, gfp_t gfp_m
>   	return new;
>   }
>   
> +void nfs_release_seqid_inorder(struct nfs_seqid *seqid)
> +{
> +	struct nfs_seqid_counter *sequence;
> +
> +	if (seqid == NULL || list_empty(&seqid->list))
> +		return;
> +	sequence = seqid->sequence;
> +	spin_lock(&sequence->lock);
> +	if (!list_is_last(&seqid->list, &sequence->list)) {
> +		struct nfs_seqid *next;
> +
> +		next = list_next_entry(seqid, list);
> +		rpc_wake_up_queued_task(&sequence->wait, next->task);
> +	}
> +	list_del_init(&seqid->list);
> +	spin_unlock(&sequence->lock);
> +}
> +
>   void nfs_release_seqid(struct nfs_seqid *seqid)
>   {
>   	struct nfs_seqid_counter *sequence;

