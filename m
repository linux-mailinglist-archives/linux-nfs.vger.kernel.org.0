Return-Path: <linux-nfs+bounces-7663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7999BC257
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 02:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F160B21CF4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6B125B9;
	Tue,  5 Nov 2024 01:10:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D00B65C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769019; cv=none; b=bPXeeGcUMBE5fmAnmGnhLnf1qpyNv9PTswFp2/TT0YAt/lKkkC9O856qXoocnBkHb62mzN+FyHSDjp0nk0v/hgg/z4eIX/zlb3JhhftEwUhLJCqYhKt0EKO0TTn/g4WPpO3Jit5ILJ7GnZ9Zv5msuJaxJZPjRDhfx0eN2QcVVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769019; c=relaxed/simple;
	bh=6uQyvi04cU69CWzmgc8L1gwRBJEqBPKP9VdNYQywFvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns8+SU1HxR0/WLid60AdtJPKiY4tFSdWDnZtRnlLuHlchgiWgYOdP8cm4H9BgTaZ5f5vxGKE33cWSbzvQ0xMdcjSDJtSjTd0Glj8IfYgFi4WF4F57g6DLBF0R0RZN79+JMv6uoHKm4LGo+VnVhx5PS6qqcnnaXEYxLd9oQpzrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xj9H44gwvz4f3lfk
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 09:09:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6FD5E1A0194
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 09:10:11 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4dxcClnlTSEAw--.50968S3;
	Tue, 05 Nov 2024 09:10:11 +0800 (CST)
Message-ID: <8a41a675-0a24-91c0-bfdc-ec63fb3deda5@huaweicloud.com>
Date: Tue, 5 Nov 2024 09:10:09 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] nfsd: fix nfs4_openowner leak when concurrent
 nfsd4_open occur
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
References: <20241104121843.1589284-1-yangerkun@huaweicloud.com>
 <d0278add82aec4d5b660cf76df6dd3ce061302b4.camel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <d0278add82aec4d5b660cf76df6dd3ce061302b4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4dxcClnlTSEAw--.50968S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr43WF18Ary5Kr45uFyxAFb_yoWxGFW3pF
	Z3ta4fGF1rX3srtrW7Ca1jka4UKrsYqr1UXrn5trWSvF40vrn5XF1jgryFvrWDGrWrAr4x
	X3WDta42qw4rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/11/4 22:23, Jeff Layton 写道:
> On Mon, 2024-11-04 at 20:18 +0800, Yang Erkun wrote:
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
>> v1->v2: fix mistake in nfs4_openowner_unhashed
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 551d2958ec29..bc175bafc4d7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1660,6 +1660,12 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>>   	free_ol_stateid_reaplist(&reaplist);
>>   }
>>   
>> +static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
>> +{
> 
> Can we add a lockdep_assert_held() for the cl_lock here?

Yeah, this function should be protected by cl_lock.

> 
>> +	return list_empty(&oo->oo_owner.so_strhash) &&
>> +		list_empty(&oo->oo_perclient);
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
> Nice analysis!
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org


