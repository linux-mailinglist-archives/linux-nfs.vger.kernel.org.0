Return-Path: <linux-nfs+bounces-7665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB029BC28A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 02:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DEB1C21F88
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D728399;
	Tue,  5 Nov 2024 01:27:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659F11CA9
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770039; cv=none; b=uNg7cLAZ4yHQ1XakAstEc/elQtqMn8WO9EFOm3rWbfa7vp0eGZg0OU3opoyvGlYT0VZLGTkhxVMMvJ1T4in/SiaD+TzqiXU9iwwO8R9oQZ64GkFhxWmdM/tGRbwnHX+0H83s6wC1s3NpEFGkVkVvXERGK1eB9EA4ZO2uXAuPALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770039; c=relaxed/simple;
	bh=cAgd4qy/3f0nx92G1rmtSZkkqU4tPhQM2uelL3vjwE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2O0nBMQfnZo0sqNrr67lkIRiP2H4ZkHMglL++0j7qS8iFbz5IAeGlEEbtWB3c7hiQXemyXtAT/a40bQHxtdeF+mHjmC07mn7ansrYv9FAEIYNIpX/4CXJ5Md0GfxgQ9E8GgQZ2V0HdK0AtRROAZJqi0PsmdKEvJRTtQI8BzSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xj9fk0pjbz4f3jdW
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 09:26:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B4021A058E
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 09:27:12 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVudClnqluFAw--.46261S3;
	Tue, 05 Nov 2024 09:27:11 +0800 (CST)
Message-ID: <5f48b66b-7a31-122f-69dc-27e86dabeac7@huaweicloud.com>
Date: Tue, 5 Nov 2024 09:27:10 +0800
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
To: Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
 chuck.lever@oracle.com, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com
References: <20241104083912.669132-1-yangerkun@huaweicloud.com>
 <3b8234658359a6f528d690272b34d37b70a39e42.camel@kernel.org>
 <1a996261-3e3d-80f0-4af5-926733e58fee@huawei.com>
 <c2da4004d3ae67d51f319d356da211b1956658ca.camel@kernel.org>
 <8273166e607502792c8465b0a95f8d9a81b99085.camel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <8273166e607502792c8465b0a95f8d9a81b99085.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVudClnqluFAw--.46261S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CF1DJFW3XF47JFW3WFW5Awb_yoWDWF45pF
	Z3ta47CF45Jr9Fyr42k3Wjga4Utrs7tr1UXrn5trWFyr4qvrn3XF1j9ryUuryDGryrAr4U
	XF1UtasrXw1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/11/4 23:07, Jeff Layton 写道:
> On Mon, 2024-11-04 at 09:22 -0500, Jeff Layton wrote:
>> On Mon, 2024-11-04 at 21:54 +0800, yangerkun wrote:
>>>
>>> 在 2024/11/4 21:42, Jeff Layton 写道:
>>>> On Mon, 2024-11-04 at 16:39 +0800, Yang Erkun wrote:
>>>>> From: Yang Erkun <yangerkun@huawei.com>
>>>>>
>>>>> The action force umount(umount -f) will attempt to kill all rpc_task even
>>>>> umount operation may ultimately fail if some files remain open.
>>>>> Consequently, if an action attempts to open a file, it can potentially
>>>>> send two rpc_task to nfs server.
>>>>>
>>>>>                      NFS CLIENT
>>>>> thread1                             thread2
>>>>> open("file")
>>>>> ...
>>>>> nfs4_do_open
>>>>>    _nfs4_do_open
>>>>>     _nfs4_open_and_get_state
>>>>>      _nfs4_proc_open
>>>>>       nfs4_run_open_task
>>>>>        /* rpc_task1 */
>>>>>        rpc_run_task
>>>>>        rpc_wait_for_completion_task
>>>>>
>>>>>                                       umount -f
>>>>>                                       nfs_umount_begin
>>>>>                                        rpc_killall_tasks
>>>>>                                         rpc_signal_task
>>>>>        rpc_task1 been wakeup
>>>>>        and return -512
>>>>>    _nfs4_do_open // while loop
>>>>>       ...
>>>>>       nfs4_run_open_task
>>>>>        /* rpc_task2 */
>>>>>        rpc_run_task
>>>>>        rpc_wait_for_completion_task
>>>>>
>>>>> While processing an open request, nfsd will first attempt to find or
>>>>> allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
>>>>> marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
>>>>> two rpc_task can attempt to open the same file simultaneously from the
>>>>> client to server, and because two instances of nfsd can run
>>>>> concurrently, this situation can lead to lots of memory leak.
>>>>> Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
>>>>> triggered.
>>>>>
>>>>>                       NFS SERVER
>>>>> nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads
>>>>>
>>>>> nfsd4_open
>>>>>    nfsd4_process_open1
>>>>>     find_or_alloc_open_stateowner
>>>>>      // alloc oo1, stateid1
>>>>>                          nfsd4_open
>>>>>                           nfsd4_process_open1
>>>>>                           find_or_alloc_open_stateowner
>>>>>                           // find oo1, without NFS4_OO_CONFIRMED
>>>>>                            release_openowner
>>>>>                             unhash_openowner_locked
>>>>>                             list_del_init(&oo->oo_perclient)
>>>>>                             // cannot find this oo
>>>>>                             // from client, LEAK!!!
>>>>>                            alloc_stateowner // alloc oo2
>>>>>
>>>>>    nfsd4_process_open2
>>>>>     init_open_stateid
>>>>>     // associate oo1
>>>>>     // with stateid1, stateid1 LEAK!!!
>>>>>     nfs4_get_vfs_file
>>>>>     // alloc nfsd_file1 and nfsd_file_mark1
>>>>>     // all LEAK!!!
>>>>>
>>>>>                            nfsd4_process_open2
>>>>>                            ...
>>>>>
>>>>>                                       write_threads
>>>>>                                        ...
>>>>>                                        nfsd_destroy_serv
>>>>>                                         nfsd_shutdown_net
>>>>>                                          nfs4_state_shutdown_net
>>>>>                                           nfs4_state_destroy_net
>>>>>                                            destroy_client
>>>>>                                             __destroy_client
>>>>>                                             // won't find oo1!!!
>>>>>                                        nfsd_shutdown_generic
>>>>>                                         nfsd_file_cache_shutdown
>>>>>                                          kmem_cache_destroy
>>>>>                                          for nfsd_file_slab
>>>>>                                          and nfsd_file_mark_slab
>>>>>                                          // bark since nfsd_file1
>>>>>                                          // and nfsd_file_mark1
>>>>>                                          // still alive
>>>>>
>>>>> =======================================================================
>>>>> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
>>>>> __kmem_cache_shutdown()
>>>>> -----------------------------------------------------------------------
>>>>>
>>>>> Slab 0xffd4000004438a80 objects=34 used=1 fp=0xff11000110e2ad28
>>>>> flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
>>>>> CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>>> 1.16.1-2.fc37 04/01/2014
>>>>> Call Trace:
>>>>>    <TASK>
>>>>>    dump_stack_lvl+0x53/0x70
>>>>>    slab_err+0xb0/0xf0
>>>>>    __kmem_cache_shutdown+0x15c/0x310
>>>>>    kmem_cache_destroy+0x66/0x160
>>>>>    nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>>>>>    nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>>>>>    nfsd_svc+0x125/0x1e0 [nfsd]
>>>>>    write_threads+0x16a/0x2a0 [nfsd]
>>>>>    nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>>>>    vfs_write+0x1ae/0x6d0
>>>>>    ksys_write+0xc1/0x160
>>>>>    do_syscall_64+0x5f/0x170
>>>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> Disabling lock debugging due to kernel taint
>>>>> Object 0xff11000110e2ac38 @offset=3128
>>>>> Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=1635 cpu=3
>>>>> pid=800
>>>>>    nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
>>>>>    nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
>>>>>    nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
>>>>>    nfsd4_process_open2+0x713/0x1070 [nfsd]
>>>>>    nfsd4_open+0x74b/0x8b0 [nfsd]
>>>>>    nfsd4_proc_compound+0x70b/0xc20 [nfsd]
>>>>>    nfsd_dispatch+0x1b4/0x3a0 [nfsd]
>>>>>    svc_process_common+0x5b8/0xc50 [sunrpc]
>>>>>    svc_process+0x2ab/0x3b0 [sunrpc]
>>>>>    svc_handle_xprt+0x681/0xa20 [sunrpc]
>>>>>    nfsd+0x183/0x220 [nfsd]
>>>>>    kthread+0x199/0x1e0
>>>>>    ret_from_fork+0x31/0x60
>>>>>    ret_from_fork_asm+0x1a/0x30
>>>>>
>>>>> Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
>>>>> break nfsd4_open process to fix this problem.
>>>>>
>>>>> Cc: stable@vger.kernel.org # 2.6
>>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>>> ---
>>>>>    fs/nfsd/nfs4state.c | 17 +++++++++++++++++
>>>>>    1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 551d2958ec29..d3b5321d02a5 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -1660,6 +1660,12 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>>>>>    	free_ol_stateid_reaplist(&reaplist);
>>>>>    }
>>>>>    
>>>>> +static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
>>>>> +{
>>>>> +	return list_empty(&oo->oo_owner.so_strhash) &&
>>>>> +		list_empty(&oo->oo_owner.so_strhash);
>>>>> +}
>>>>> +
>>>>>    static void unhash_openowner_locked(struct nfs4_openowner *oo)
>>>>>    {
>>>>>    	struct nfs4_client *clp = oo->oo_owner.so_client;
>>>>> @@ -4975,6 +4981,12 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
>>>>>    	spin_lock(&oo->oo_owner.so_client->cl_lock);
>>>>>    	spin_lock(&fp->fi_lock);
>>>>>    
>>>>> +	if (nfs4_openowner_unhashed(oo)) {
>>>>> +		mutex_unlock(&stp->st_mutex);
>>>>> +		stp = NULL;
>>>>> +		goto out_unlock;
>>>>> +	}
>>>>> +
>>>>>    	retstp = nfsd4_find_existing_open(fp, open);
>>>>>    	if (retstp)
>>>>>    		goto out_unlock;
>>>>> @@ -6127,6 +6139,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>>>    
>>>>>    	if (!stp) {
>>>>>    		stp = init_open_stateid(fp, open);
>>>>> +		if (!stp) {
>>>>> +			status = nfserr_jukebox;
>>>>> +			goto out;
>>>>> +		}
>>>>> +
>>>>>    		if (!open->op_stp)
>>>>>    			new_stp = true;
>>>>>    	}
>>>>
>>>
>>> Thanks a lot for your review!
>>>
>>>
>>>> First, this should only be a problem with v4.0 mounts. v4.1+ openowners
>>>> are always considered CONFIRMED.
>>>
>>> Yes, v4.1+ will always be confirmed.
>>>
>>>>
>>>> That does look like a real bug, and your fix seems like it would fix
>>>> it, but I can't help but wonder if the better fix is to change how nfsd
>>>> handles the case of an unconfirmed openowner in
>>>> find_or_alloc_open_stateowner().
>>>>
>>>> I'd have to go back and read the v4.0 spec again, but maybe it's
>>>> possible to just keep the same stateowner instead of replacing it in
>>>> that function? It's not clear to me why unconfirmed owners are
>>>> discarded there.
>>>
>>> Aha, it will be great if we can keep this owners still alive instead of
>>> discarding it!
>>>
>>> For normal case of nfs4.0, it won't happend since the second rpc_task of
>>> open will sleep until the first rpc_task been finished. And for the
>>> upper abnormal case, after this patch, we will discarding the fist
>>> owner, but the second owner will keep going and work well to finish the
>>> open work. And based on this, I wrote this patch...
>>>
>>> If there's anything wrong with this idea, please be sure to point it
>>> out!
>>
>> I think the deal here is that with v4.0, the client is required to
>> serialize opens using the same openowner, at least until that openowner
>> is confirmed. The reason for this is because an unconfirmed openowner
>> is associated with the specific stateid under which it was created and
>> its seqid in the OPEN_CONFIRM must match that.
>>
>> RFC7530, 16.18.5 says:
>>
>>     Second, the client sends another OPEN request with a sequence id that
>>     is incorrect for the open_owner4 (out of sequence).  In this case,
>>     the server assumes the second OPEN request is valid and the first one
>>     is a replay.  The server cancels the OPEN state of the first OPEN
>>     request, establishes an unconfirmed OPEN state for the second OPEN
>>     request, and responds to the second OPEN request with an indication
>>     that an OPEN_CONFIRM is needed.
>>
>> ...so I think we are required to abort the old openowner in this case.
>>
> 
> To follow up, RFC 7530 section 9.1.7 makes this very clear:
> 
>     Note that for requests that contain a sequence number, for each
>     state-owner, there should be no more than one outstanding request.
> 
> So, if a v4.0 client is sending concurrent seqid morphing requests for
> the same stateowner, then it's misbehaving.
> 
> I still think we need to guard against this situation for the reasons
> you outlined. Your v2 patch is probably the best we can do here.

Thank you for your patient explanation of rfc7530, it helped me a lot in
thinking deeply about this question!

> 
> 
>> It seems though like the client isn't serializing OPENs correctly? It's
>> spamming the server with multiple OPEN requests for an unconfirmed
>> openowner. Then again, maybe the client just forgot an earlier,
>> confirmed openowner and now it's just starting to try to use it again
>> and isn't expecting it to need confirmation?
>>
>> How did you reproduce this? Were you using the Linux NFS client or
>> something else?
>>
>> In any case, I suspect your v2 fix is probably what we'll need...
>> --
>> Jeff Layton <jlayton@kernel.org>
>>
> 


