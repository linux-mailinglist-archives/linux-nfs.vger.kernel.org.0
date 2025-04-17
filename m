Return-Path: <linux-nfs+bounces-11154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BEA91BE3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E87AEC16
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50132241136;
	Thu, 17 Apr 2025 12:24:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F3243953;
	Thu, 17 Apr 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892666; cv=none; b=s7ld89BQU51jqFWBQWY/uG0DLBVRescWL721IA6zbkcfXw18EAogJtxuBaRPs33xIoFl1KCFxj8d+0CgVbbouegH7CPnFfL4wRCSM//5CNY0iiIwyNEKsHFvu1vKtiI823lSAyssa0kX0DwmKZo2wXzWZN/eqA4e6qjkX05Lirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892666; c=relaxed/simple;
	bh=1DlkWNRVVOWBtp4cHwdycVCUOrGc+WAOGwTUMMCKqlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iTl3doSR0SVSGFco/ayoh8KW/7Wj9KrOBLnj5Ig4hkNqiaLEM2bhwkfciCQ4kLcMFEoH/RxDQyhDadcXejCbPFCpCar52VqDsFpQ24lp/8IRApCNlLIg5H4NhQfBcVT6wXCWJZhk2cOpW//Au7jxlGIze2sZCn9a+BOkAazMu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZdcS46mSWz2Cccp;
	Thu, 17 Apr 2025 20:20:52 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ABB541402C4;
	Thu, 17 Apr 2025 20:24:19 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 20:24:18 +0800
Message-ID: <678aae33-3af0-4229-a2ce-d9cef1572f96@huawei.com>
Date: Thu, 17 Apr 2025 20:24:18 +0800
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
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <1c7aa66639d9297dae186181aa3a03ff237be81f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/4/17 18:29, Jeff Layton 写道:
> On Thu, 2025-04-17 at 15:25 +0800, Li Lingfeng wrote:
>> When memory is insufficient, the allocation of nfs_lock_context in
>> nfs_get_lock_context() fails and returns -ENOMEM. If we mistakenly treat
>> an nfs4_unlockdata structure (whose l_ctx member has been set to -ENOMEM)
>> as valid and proceed to execute rpc_run_task(), this will trigger a NULL
>> pointer dereference in nfs4_locku_prepare. For example:
>>
>> BUG: kernel NULL pointer dereference, address: 000000000000000c
>> PGD 0 P4D 0
>> Oops: Oops: 0000 [#1] SMP PTI
>> CPU: 15 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 6.15.0-rc2-dirty #60
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40
>> Workqueue: rpciod rpc_async_schedule
>> RIP: 0010:nfs4_locku_prepare+0x35/0xc2
>> Code: 89 f2 48 89 fd 48 c7 c7 68 69 ef b5 53 48 8b 8e 90 00 00 00 48 89 f3
>> RSP: 0018:ffffbbafc006bdb8 EFLAGS: 00010246
>> RAX: 000000000000004b RBX: ffff9b964fc1fa00 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: fffffffffffffff4 RDI: ffff9ba53fddbf40
>> RBP: ffff9ba539934000 R08: 0000000000000000 R09: ffffbbafc006bc38
>> R10: ffffffffb6b689c8 R11: 0000000000000003 R12: ffff9ba539934030
>> R13: 0000000000000001 R14: 0000000004248060 R15: ffffffffb56d1c30
>> FS: 0000000000000000(0000) GS:ffff9ba5881f0000(0000) knlGS:00000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000000000c CR3: 000000093f244000 CR4: 00000000000006f0
>> Call Trace:
>>   <TASK>
>>   __rpc_execute+0xbc/0x480
>>   rpc_async_schedule+0x2f/0x40
>>   process_one_work+0x232/0x5d0
>>   worker_thread+0x1da/0x3d0
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0x10d/0x240
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x34/0x50
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>> Modules linked in:
>> CR2: 000000000000000c
>> ---[ end trace 0000000000000000 ]---
>>
>> Free the allocated nfs4_unlockdata when nfs_get_lock_context() fails and
>> return NULL to terminate subsequent rpc_run_task, preventing NULL pointer
>> dereference.
>>
>> Fixes: f30cb757f680 ("NFS: Always wait for I/O completion before unlock")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/nfs4proc.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 970f28dbf253..9f5689c43a50 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -7074,10 +7074,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>   	struct nfs4_unlockdata *p;
>>   	struct nfs4_state *state = lsp->ls_state;
>>   	struct inode *inode = state->inode;
>> +	struct nfs_lock_context *l_ctx;
>>   
>>   	p = kzalloc(sizeof(*p), GFP_KERNEL);
>>   	if (p == NULL)
>>   		return NULL;
>> +	l_ctx = nfs_get_lock_context(ctx);
>> +	if (!IS_ERR(l_ctx)) {
>> +		p->l_ctx = l_ctx;
>> +	} else {
>> +		kfree(p);
>> +		return NULL;
>> +	}
>>   	p->arg.fh = NFS_FH(inode);
>>   	p->arg.fl = &p->fl;
>>   	p->arg.seqid = seqid;
>> @@ -7085,7 +7093,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>   	p->lsp = lsp;
>>   	/* Ensure we don't close file until we're done freeing locks! */
>>   	p->ctx = get_nfs_open_context(ctx);
> Not exactly the same problem, but get_nfs_open_context() can fail too.
> Does it need error handling for that as well?

Hi,

IIUC, nfs_open_context is allocated during file open and attached to
filp->private_data. Upon successful file opening, the context remains valid.
Post-lock acquisition, nfs_open_context can be retrieved via
file_lock->file->nfs_open_context chain. Thus get_nfs_open_context() here
should have non-failure guarantee in standard code paths.

Best regards,
Lingfeng

>
>> -	p->l_ctx = nfs_get_lock_context(ctx);
>>   	locks_init_lock(&p->fl);
>>   	locks_copy_lock(&p->fl, fl);
>>   	p->server = NFS_SERVER(inode);
> Good catch:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

