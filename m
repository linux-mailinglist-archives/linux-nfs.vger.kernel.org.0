Return-Path: <linux-nfs+bounces-7648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F159BB6D6
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 14:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EBA1C23537
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099AF73501;
	Mon,  4 Nov 2024 13:54:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE41339A4
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728469; cv=none; b=hDxsnAuj6BsguLj7e3WsumwUhXC47/pJuWrljC5df/h8JQHhAdHkZyvWacAUp9TWRXztFyhLzsX251MxjR9xSo4z57H+5A7wieXvaPoRkOkN4NuCADvH+4XQAYucws+poKX2yvRJrQgy+MTPT1BhQn8wTKOPI4H9tJOIRGlH1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728469; c=relaxed/simple;
	bh=IuO/M6vM8fUI1lIGQjpTKXtVel/28rawgJs7NKrwYRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hnw0HBphvN1T7PDr1WOio73CoY3wRpEV+if+lGHkzHIIXzX5uTnbTA1zFvUZD9QBZFP2s4u8OsFzml+UsWUrsvVNInOUah4NaxipkrZCKgavqydrOiA+HpuH6hOrOk1mNjpR7dugm0c+lTIJiMEdm8mk9LAwRUqnudIKRlEaoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XhtFS4KzHzpXtx;
	Mon,  4 Nov 2024 21:52:28 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 215791800A7;
	Mon,  4 Nov 2024 21:54:23 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 21:54:22 +0800
Message-ID: <1a996261-3e3d-80f0-4af5-926733e58fee@huawei.com>
Date: Mon, 4 Nov 2024 21:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: fix nfs4_openowner leak when concurrent nfsd4_open
 occur
To: Jeff Layton <jlayton@kernel.org>, Yang Erkun <yangerkun@huaweicloud.com>,
	<chuck.lever@oracle.com>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <trondmy@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20241104083912.669132-1-yangerkun@huaweicloud.com>
 <3b8234658359a6f528d690272b34d37b70a39e42.camel@kernel.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <3b8234658359a6f528d690272b34d37b70a39e42.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/11/4 21:42, Jeff Layton 写道:
> On Mon, 2024-11-04 at 16:39 +0800, Yang Erkun wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> The action force umount(umount -f) will attempt to kill all rpc_task even
>> umount operation may ultimately fail if some files remain open.
>> Consequently, if an action attempts to open a file, it can potentially
>> send two rpc_task to nfs server.
>>
>>                     NFS CLIENT
>> thread1                             thread2
>> open("file")
>> ...
>> nfs4_do_open
>>   _nfs4_do_open
>>    _nfs4_open_and_get_state
>>     _nfs4_proc_open
>>      nfs4_run_open_task
>>       /* rpc_task1 */
>>       rpc_run_task
>>       rpc_wait_for_completion_task
>>
>>                                      umount -f
>>                                      nfs_umount_begin
>>                                       rpc_killall_tasks
>>                                        rpc_signal_task
>>       rpc_task1 been wakeup
>>       and return -512
>>   _nfs4_do_open // while loop
>>      ...
>>      nfs4_run_open_task
>>       /* rpc_task2 */
>>       rpc_run_task
>>       rpc_wait_for_completion_task
>>
>> While processing an open request, nfsd will first attempt to find or
>> allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
>> marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
>> two rpc_task can attempt to open the same file simultaneously from the
>> client to server, and because two instances of nfsd can run
>> concurrently, this situation can lead to lots of memory leak.
>> Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
>> triggered.
>>
>>                      NFS SERVER
>> nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads
>>
>> nfsd4_open
>>   nfsd4_process_open1
>>    find_or_alloc_open_stateowner
>>     // alloc oo1, stateid1
>>                         nfsd4_open
>>                          nfsd4_process_open1
>>                          find_or_alloc_open_stateowner
>>                          // find oo1, without NFS4_OO_CONFIRMED
>>                           release_openowner
>>                            unhash_openowner_locked
>>                            list_del_init(&oo->oo_perclient)
>>                            // cannot find this oo
>>                            // from client, LEAK!!!
>>                           alloc_stateowner // alloc oo2
>>
>>   nfsd4_process_open2
>>    init_open_stateid
>>    // associate oo1
>>    // with stateid1, stateid1 LEAK!!!
>>    nfs4_get_vfs_file
>>    // alloc nfsd_file1 and nfsd_file_mark1
>>    // all LEAK!!!
>>
>>                           nfsd4_process_open2
>>                           ...
>>
>>                                      write_threads
>>                                       ...
>>                                       nfsd_destroy_serv
>>                                        nfsd_shutdown_net
>>                                         nfs4_state_shutdown_net
>>                                          nfs4_state_destroy_net
>>                                           destroy_client
>>                                            __destroy_client
>>                                            // won't find oo1!!!
>>                                       nfsd_shutdown_generic
>>                                        nfsd_file_cache_shutdown
>>                                         kmem_cache_destroy
>>                                         for nfsd_file_slab
>>                                         and nfsd_file_mark_slab
>>                                         // bark since nfsd_file1
>>                                         // and nfsd_file_mark1
>>                                         // still alive
>>
>> =======================================================================
>> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
>> __kmem_cache_shutdown()
>> -----------------------------------------------------------------------
>>
>> Slab 0xffd4000004438a80 objects=34 used=1 fp=0xff11000110e2ad28
>> flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
>> CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.16.1-2.fc37 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x53/0x70
>>   slab_err+0xb0/0xf0
>>   __kmem_cache_shutdown+0x15c/0x310
>>   kmem_cache_destroy+0x66/0x160
>>   nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>>   nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>>   nfsd_svc+0x125/0x1e0 [nfsd]
>>   write_threads+0x16a/0x2a0 [nfsd]
>>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>   vfs_write+0x1ae/0x6d0
>>   ksys_write+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Disabling lock debugging due to kernel taint
>> Object 0xff11000110e2ac38 @offset=3128
>> Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=1635 cpu=3
>> pid=800
>>   nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
>>   nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
>>   nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
>>   nfsd4_process_open2+0x713/0x1070 [nfsd]
>>   nfsd4_open+0x74b/0x8b0 [nfsd]
>>   nfsd4_proc_compound+0x70b/0xc20 [nfsd]
>>   nfsd_dispatch+0x1b4/0x3a0 [nfsd]
>>   svc_process_common+0x5b8/0xc50 [sunrpc]
>>   svc_process+0x2ab/0x3b0 [sunrpc]
>>   svc_handle_xprt+0x681/0xa20 [sunrpc]
>>   nfsd+0x183/0x220 [nfsd]
>>   kthread+0x199/0x1e0
>>   ret_from_fork+0x31/0x60
>>   ret_from_fork_asm+0x1a/0x30
>>
>> Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
>> break nfsd4_open process to fix this problem.
>>
>> Cc: stable@vger.kernel.org # 2.6
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/nfs4state.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 551d2958ec29..d3b5321d02a5 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1660,6 +1660,12 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>>   	free_ol_stateid_reaplist(&reaplist);
>>   }
>>   
>> +static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
>> +{
>> +	return list_empty(&oo->oo_owner.so_strhash) &&
>> +		list_empty(&oo->oo_owner.so_strhash);
>> +}
>> +
>>   static void unhash_openowner_locked(struct nfs4_openowner *oo)
>>   {
>>   	struct nfs4_client *clp = oo->oo_owner.so_client;
>> @@ -4975,6 +4981,12 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
>>   	spin_lock(&oo->oo_owner.so_client->cl_lock);
>>   	spin_lock(&fp->fi_lock);
>>   
>> +	if (nfs4_openowner_unhashed(oo)) {
>> +		mutex_unlock(&stp->st_mutex);
>> +		stp = NULL;
>> +		goto out_unlock;
>> +	}
>> +
>>   	retstp = nfsd4_find_existing_open(fp, open);
>>   	if (retstp)
>>   		goto out_unlock;
>> @@ -6127,6 +6139,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   
>>   	if (!stp) {
>>   		stp = init_open_stateid(fp, open);
>> +		if (!stp) {
>> +			status = nfserr_jukebox;
>> +			goto out;
>> +		}
>> +
>>   		if (!open->op_stp)
>>   			new_stp = true;
>>   	}
> 

Thanks a lot for your review!


> First, this should only be a problem with v4.0 mounts. v4.1+ openowners
> are always considered CONFIRMED.

Yes, v4.1+ will always be confirmed.

> 
> That does look like a real bug, and your fix seems like it would fix
> it, but I can't help but wonder if the better fix is to change how nfsd
> handles the case of an unconfirmed openowner in
> find_or_alloc_open_stateowner().
> 
> I'd have to go back and read the v4.0 spec again, but maybe it's
> possible to just keep the same stateowner instead of replacing it in
> that function? It's not clear to me why unconfirmed owners are
> discarded there.

Aha, it will be great if we can keep this owners still alive instead of
discarding it!

For normal case of nfs4.0, it won't happend since the second rpc_task of
open will sleep until the first rpc_task been finished. And for the
upper abnormal case, after this patch, we will discarding the fist
owner, but the second owner will keep going and work well to finish the
open work. And based on this, I wrote this patch...

If there's anything wrong with this idea, please be sure to point it
out!

Thanks,
Erkun.

