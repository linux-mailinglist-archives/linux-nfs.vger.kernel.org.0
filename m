Return-Path: <linux-nfs+bounces-11171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A612A9423E
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 10:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA817415E
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072031A5B9C;
	Sat, 19 Apr 2025 08:28:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58451A254C;
	Sat, 19 Apr 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051330; cv=none; b=n2JCwcosUI2SIj/tuzDsMQNU1VKDt01j/V312XT2dKGrBYdyh2+CSF8pOEhxwcwBiHNfmFGyPxKhuLBbaNb/OCKxlnUcwWsSWa3+u1L79yolI+Wk1seZGYyHjx0Dk6D3Lp7UBEKfNJWTDw9Yg1BV9WsDgAt50bHarDS1v9UnxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051330; c=relaxed/simple;
	bh=G9y+lG16rIgiZl8Rp3w1VzmoSlJOMaSlDc8bZM/MDIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JKqFXgCGq/O0YlKAzYBrWq+ri5j7ruShNt2kPaT93CokMrQ8V/GJOjV+EIvZOcHg+/vq/53TJhJz2UovH41FByZIyHSTA9ULyp9o2TAPt07djrpFpuTJanb91HdRJ8Wx+ZJU7owJomqPE5otjZSIAGDTAizELU32ZRqZhtHSQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zfl6s2fcfz5vMZ;
	Sat, 19 Apr 2025 16:24:53 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id E02A9180B49;
	Sat, 19 Apr 2025 16:28:42 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Apr 2025 16:28:41 +0800
Message-ID: <21817f2c-2971-4568-9ae4-1ccc25f7f1ef@huawei.com>
Date: Sat, 19 Apr 2025 16:28:41 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfs: handle failure of nfs_get_lock_context in unlock
 path
To: Jeff Layton <jlayton@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250417072508.3850532-1-lilingfeng3@huawei.com>
 <1c7aa66639d9297dae186181aa3a03ff237be81f.camel@kernel.org>
 <678aae33-3af0-4229-a2ce-d9cef1572f96@huawei.com>
 <a53ddece5d8deb77f6e6a37e4358dd3eb93401ba.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <a53ddece5d8deb77f6e6a37e4358dd3eb93401ba.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/4/17 20:43, Jeff Layton 写道:
> On Thu, 2025-04-17 at 20:24 +0800, Li Lingfeng wrote:
>> 在 2025/4/17 18:29, Jeff Layton 写道:
>>> On Thu, 2025-04-17 at 15:25 +0800, Li Lingfeng wrote:
>>>> When memory is insufficient, the allocation of nfs_lock_context in
>>>> nfs_get_lock_context() fails and returns -ENOMEM. If we mistakenly treat
>>>> an nfs4_unlockdata structure (whose l_ctx member has been set to -ENOMEM)
>>>> as valid and proceed to execute rpc_run_task(), this will trigger a NULL
>>>> pointer dereference in nfs4_locku_prepare. For example:
>>>>
>>>> BUG: kernel NULL pointer dereference, address: 000000000000000c
>>>> PGD 0 P4D 0
>>>> Oops: Oops: 0000 [#1] SMP PTI
>>>> CPU: 15 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 6.15.0-rc2-dirty #60
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40
>>>> Workqueue: rpciod rpc_async_schedule
>>>> RIP: 0010:nfs4_locku_prepare+0x35/0xc2
>>>> Code: 89 f2 48 89 fd 48 c7 c7 68 69 ef b5 53 48 8b 8e 90 00 00 00 48 89 f3
>>>> RSP: 0018:ffffbbafc006bdb8 EFLAGS: 00010246
>>>> RAX: 000000000000004b RBX: ffff9b964fc1fa00 RCX: 0000000000000000
>>>> RDX: 0000000000000000 RSI: fffffffffffffff4 RDI: ffff9ba53fddbf40
>>>> RBP: ffff9ba539934000 R08: 0000000000000000 R09: ffffbbafc006bc38
>>>> R10: ffffffffb6b689c8 R11: 0000000000000003 R12: ffff9ba539934030
>>>> R13: 0000000000000001 R14: 0000000004248060 R15: ffffffffb56d1c30
>>>> FS: 0000000000000000(0000) GS:ffff9ba5881f0000(0000) knlGS:00000000
>>>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 000000000000000c CR3: 000000093f244000 CR4: 00000000000006f0
>>>> Call Trace:
>>>>    <TASK>
>>>>    __rpc_execute+0xbc/0x480
>>>>    rpc_async_schedule+0x2f/0x40
>>>>    process_one_work+0x232/0x5d0
>>>>    worker_thread+0x1da/0x3d0
>>>>    ? __pfx_worker_thread+0x10/0x10
>>>>    kthread+0x10d/0x240
>>>>    ? __pfx_kthread+0x10/0x10
>>>>    ret_from_fork+0x34/0x50
>>>>    ? __pfx_kthread+0x10/0x10
>>>>    ret_from_fork_asm+0x1a/0x30
>>>>    </TASK>
>>>> Modules linked in:
>>>> CR2: 000000000000000c
>>>> ---[ end trace 0000000000000000 ]---
>>>>
>>>> Free the allocated nfs4_unlockdata when nfs_get_lock_context() fails and
>>>> return NULL to terminate subsequent rpc_run_task, preventing NULL pointer
>>>> dereference.
>>>>
>>>> Fixes: f30cb757f680 ("NFS: Always wait for I/O completion before unlock")
>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>> ---
>>>>    fs/nfs/nfs4proc.c | 9 ++++++++-
>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>> index 970f28dbf253..9f5689c43a50 100644
>>>> --- a/fs/nfs/nfs4proc.c
>>>> +++ b/fs/nfs/nfs4proc.c
>>>> @@ -7074,10 +7074,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>>>    	struct nfs4_unlockdata *p;
>>>>    	struct nfs4_state *state = lsp->ls_state;
>>>>    	struct inode *inode = state->inode;
>>>> +	struct nfs_lock_context *l_ctx;
>>>>    
>>>>    	p = kzalloc(sizeof(*p), GFP_KERNEL);
>>>>    	if (p == NULL)
>>>>    		return NULL;
>>>> +	l_ctx = nfs_get_lock_context(ctx);
>>>> +	if (!IS_ERR(l_ctx)) {
>>>> +		p->l_ctx = l_ctx;
>>>> +	} else {
>>>> +		kfree(p);
>>>> +		return NULL;
>>>> +	}
>>>>    	p->arg.fh = NFS_FH(inode);
>>>>    	p->arg.fl = &p->fl;
>>>>    	p->arg.seqid = seqid;
>>>> @@ -7085,7 +7093,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>>>    	p->lsp = lsp;
>>>>    	/* Ensure we don't close file until we're done freeing locks! */
>>>>    	p->ctx = get_nfs_open_context(ctx);
>>> Not exactly the same problem, but get_nfs_open_context() can fail too.
>>> Does it need error handling for that as well?
>> Hi,
>>
>> IIUC, nfs_open_context is allocated during file open and attached to
>> filp->private_data. Upon successful file opening, the context remains valid.
>> Post-lock acquisition, nfs_open_context can be retrieved via
>> file_lock->file->nfs_open_context chain. Thus get_nfs_open_context() here
>> should have non-failure guarantee in standard code paths.
>
> I'm not so sure. This function can get called from the rpc_release
> callback for a LOCK request:
>
> ->rpc_release
>      nfs4_lock_release
> 	nfs4_do_unlck
> 	    nfs4_alloc_unlockdata
>
> Can that happen after the open_ctx->lock_context.count goes to 0?
>
> Given that we have a safe failure path in this code, it seems like we
> ought to check for that here, just to be safe. If it really shouldn't
> happen like you say, then we could throw in a WARN_ON_ONCE() too.
Thank you for raising this concern.
During file open, the nfs_open_context is allocated, and
open_ctx->lock_context.count is initialized to 1. Based on the current
flow, I think it's unlikely for this counter to reach 0 during lock/unlock
operations since its decrement is tied to file closure.

However, I agree with your suggestion to add checks when
get_nfs_open_context fails. Furthermore, this check might also be
necessary not only in the unlock path but potentially in the lock path if
get_nfs_open_contextb fails there as well.

Additionally, I noticed that both the lock and unlock release callbacks
dereference nfs_open_context. If get_nfs_open_context were to fail
(assuming such a scenario is possible), this could lead to a NULL pointer
dereference. Instead of relying solely on WARN_ON_ONCE(), it might be
safer to halt the operation immediately upon detecting a failure in
get_nfs_open_context.

// unlock
nfs4_locku_release_calldata
  put_nfs_open_context
    __put_nfs_open_context
     // dereference nfs_open_context

// lock
nfs4_lock_release
  nfs4_do_unlck
   // dereference nfs_open_context
  put_nfs_open_context
   // dereference nfs_open_context

I'll incorporate your feedback and send a patchset soon.
>
>>>> -	p->l_ctx = nfs_get_lock_context(ctx);
>>>>    	locks_init_lock(&p->fl);
>>>>    	locks_copy_lock(&p->fl, fl);
>>>>    	p->server = NFS_SERVER(inode);
>>> Good catch:
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>

