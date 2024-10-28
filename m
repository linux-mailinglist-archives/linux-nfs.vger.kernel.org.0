Return-Path: <linux-nfs+bounces-7528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B99B2FE7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 13:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EF4282570
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE618E778;
	Mon, 28 Oct 2024 12:12:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEB189B8D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117566; cv=none; b=qJt9CC0T4QSW0tfOK9D9PxjunPaC3IWgUbm56yw3fKbGI8J2DDRu1AHwqojcd7fZowexdpnhU3HeCqV6CeFNNhjQuvzY7Ch7nh4YwVCD9nr2yccmwKHBr5a0FSfqPKpc9EMC2k2dWeJJ84PxDcggQ/QusYOGYs4SmqBZV8dTT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117566; c=relaxed/simple;
	bh=y1VRz3FeKGyJpPaksnkWnOvGexzehAPxf2yFBT4tl3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRejlQHLUDRR35NivO8oVwAlrXkZ5nh78PsiJp8JgCMERtd9a33Hczo9HhopGxkDXE2R5AnFfV/lnvY4tVq2Oei+pHrRTMf7vjuMqLVvNYxuuD/N6raJLeKd8clWgDIwV9SHyNrweUQTP1qjVyG3ZXkBCsYHkTlbAA5njyXUJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcXMC6fgSz4f3prL
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 20:12:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 745091A018D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 20:12:36 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eyfx9nAlq9AA--.15185S3;
	Mon, 28 Oct 2024 20:12:36 +0800 (CST)
Message-ID: <824a7214-8790-3d91-52dc-f3378cf7afe5@huaweicloud.com>
Date: Mon, 28 Oct 2024 20:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] NFSv4: fix rpc_task use-after-free when open
 concurrently
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
References: <20241022122141.2030194-1-yangerkun@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241022122141.2030194-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eyfx9nAlq9AA--.15185S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWrCr1DZF4kur45Xw13urg_yoW3JF13pr
	s5JrWxCr9rJryvqF43Ca1UG34Fy3yrKw1xCrn2yrW2y3WSqrn3Z3WIqw1Ygr4UGrZ5Zay7
	XF1qg3Z0gw4fWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi,

Gently ping for this patch!

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


