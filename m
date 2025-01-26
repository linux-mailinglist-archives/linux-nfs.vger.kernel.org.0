Return-Path: <linux-nfs+bounces-9615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB8A1C630
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 04:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FBB166443
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AA22092;
	Sun, 26 Jan 2025 03:00:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5833FE;
	Sun, 26 Jan 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737860425; cv=none; b=nU4zR0GSv5Ark4BsUIQILTHMo4zHn2V1mPD/xgiKkD7hqYndrBeiwecJBxgR9zgFpaDL6GEk5CKNjxwDwWKcpHt/5k0AcunyhfrORrAnORkgm4PYecB9MBofSRTTlJC2IJk0UibdKAjJXWTRUa8mlgKk5Nqiwe32dXtT86pxFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737860425; c=relaxed/simple;
	bh=6u2LGL+Pff+hU6u9FzgTTO6EosgCng5DZloNo9btRaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HDMZSjH2OYq6b9g+SdFIZFxwr3wUJdDmoabyN54mxAlbMMe6FuJMj5Y+5NNrW8MBrb5o0sxF4psJWCmZPRhlBkgBi9lyD28gP2NFySl5cEuux1Tv56Tbun2Igr7vXZZvSnl0hxwMpBZ6Fh851QVBZ0BLSwPGj5fV3JLAfrGRanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ygblr2Yzfz11PDj;
	Sun, 26 Jan 2025 10:56:08 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 439A61802D1;
	Sun, 26 Jan 2025 11:00:13 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 26 Jan 2025 11:00:12 +0800
Message-ID: <d38a53d6-1f10-4c72-b5f0-88d612093e83@huawei.com>
Date: Sun, 26 Jan 2025 11:00:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] NFSv4: Fix deadlock during the running of state manager
To: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org"
	<anna@kernel.org>
CC: "houtao1@huawei.com" <houtao1@huawei.com>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>
References: <20241213035908.1789132-1-lilingfeng3@huawei.com>
 <baa76c7946676fccafb1dbf658905a0ab3e3bdec.camel@hammerspace.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <baa76c7946676fccafb1dbf658905a0ab3e3bdec.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/12/18 1:00, Trond Myklebust 写道:
> On Fri, 2024-12-13 at 11:59 +0800, Li Lingfeng wrote:
>> Unlinking file may cause the following deadlock in state manager:
>> [root@localhost test]# cat /proc/2943/stack
>> [<0>] rpc_wait_bit_killable+0x1a/0x90
>> [<0>] _nfs4_proc_delegreturn+0x60f/0x760
>> [<0>] nfs4_proc_delegreturn+0x13d/0x2a0
>> [<0>] nfs_do_return_delegation+0xba/0x110
>> [<0>] nfs_end_delegation_return+0x32c/0x620
>> [<0>] nfs_complete_unlink+0xc7/0x290
>> [<0>] nfs_dentry_iput+0x36/0x50
>> [<0>] __dentry_kill+0xaa/0x250
>> [<0>] dput.part.0+0x26c/0x4d0
>> [<0>] __put_nfs_open_context+0x1d9/0x260
>> [<0>] nfs4_open_reclaim+0x77/0xa0
>> [<0>] nfs4_do_reclaim+0x385/0xf40
>> [<0>] nfs4_state_manager+0x762/0x14e0
>> [<0>] nfs4_run_state_manager+0x181/0x330
>> [<0>] kthread+0x1a7/0x1f0
>> [<0>] ret_from_fork+0x34/0x60
>> [<0>] ret_from_fork_asm+0x1a/0x30
>> [root@localhost test]#
>>
>> It can be reproduced by following steps:
>> 1) client: open file
>> 2) client: unlink file
>> 3) server: service restart(trigger state manager in client)
>> 4) client: close file(in nfs4_open_reclaim, between
>> nfs4_do_open_reclaim
>> and put_nfs_open_context)
>>
>> Since the file has been open, unlinking will just set
>> DCACHE_NFSFS_RENAMED
>> for the dentry like this:
>> nfs_unlink
>>   nfs_sillyrename
>>    nfs_async_unlink
>>     // set DCACHE_NFSFS_RENAMED
>>
>> Restarting service will trigger state manager in client.
>> (1) NFS4_SLOT_TBL_DRAINING will be set to nfs4_slot_table since
>> session
>> has been reset.
>> (2) DCACHE_NFSFS_RENAMED is detected in nfs_dentry_iput. Therefore,
>> nfs_complete_unlink is called to trigger delegation return.
>> (3) Due to the slot table being in draining state and sa_privileged
>> being
>> 0, the delegation return will be queued and wait.
>> nfs4_state_manager
>>   nfs4_reset_session
>>    nfs4_begin_drain_session
>>     nfs4_drain_slot_tbl
>>      // set NFS4_SLOT_TBL_DRAINING (1)
>>   nfs4_do_reclaim
>>    nfs4_open_reclaim
>>     __put_nfs_open_context
>>      __dentry_kill
>>       nfs_dentry_iput // check DCACHE_NFSFS_RENAMED (2)
>>        nfs_complete_unlink
>>         nfs_end_delegation_return
>>          nfs_do_return_delegation
>>           nfs4_proc_delegreturn
>>            _nfs4_proc_delegreturn
>>             rpc_run_task
>>              ...
>>              nfs4_delegreturn_prepare
>>               nfs4_setup_sequence
>>                nfs4_slot_tbl_draining // check NFS4_SLOT_TBL_DRAINING
>>                                       // and sa_privileged is 0 (3)
>>                 rpc_sleep_on // set queued and add to slot_tbl_waitq
>>                  // rpc_task is async and wait in __rpc_execute
>>             rpc_wait_for_completion_task
>>              __rpc_wait_for_completion_task
>>               out_of_line_wait_on_bit
>>                rpc_wait_bit_killable // wait for rpc_task to complete
>>   <-------- can not get here to wake up rpc_task -------->
>>   nfs4_end_drain_session
>>    nfs4_end_drain_slot_table
>>     nfs41_wake_slot_table
>>
>> On the one hand, the state manager is blocked by the unfinished
>> delegation
>> return. As a result, nfs4_end_drain_session cannot be invoked to
>> clear
>> NFS4_SLOT_TBL_DRAINING and wake up waiting tasks.
>> On the other hand, since NFS4_SLOT_TBL_DRAINING is not cleared,
>> delegation return can only wait in the queue, resulting in a
>> deadlock.
>>
>> Fix it by turning the delegation return into a privileged operation
>> for
>> the case where the nfs_client is in NFS4CLNT_RECLAIM_REBOOT state.
>>
>> Fixes: 977fcc2b0b41 ("NFS: Add a delegation return into
>> nfs4_proc_unlink_setup()")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/nfs4proc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 405f17e6e0b4..f3b1f2725c4e 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -6878,7 +6878,7 @@ static int _nfs4_proc_delegreturn(struct inode
>> *inode, const struct cred *cred,
>>   		data->res.sattr_res = true;
>>   	}
>>   
>> -	if (!data->inode)
>> +	if (!data->inode || test_bit(NFS4CLNT_RECLAIM_REBOOT,
>> &server->nfs_client->cl_state))
>>   		nfs4_init_sequence(&data->args.seq_args, &data-
>>> res.seq_res, 1,
>>   				   1);
>>   	else
> Rather than make the delegreturn be privileged, it seems better to make
> that delegreturn be asynchronous, just like the unlink itself.

Hi,

In my understanding, the rpc_task in delegreturn has the RPC_TASK_ASYNC
flag set, which means it is already asynchronous.
In the described scenario, delegreturn waiting for this asynchronous
rpc_task to complete caused the deadlock. I'm not entirely clear on what
you mean by 'make that delegreturn be asynchronous.' Could you please
elaborate a bit more on that for better clarity?

Thanks.

>

