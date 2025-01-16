Return-Path: <linux-nfs+bounces-9304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154AEA13C49
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD633A69B2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB3C22B59C;
	Thu, 16 Jan 2025 14:32:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136424A7C9;
	Thu, 16 Jan 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037939; cv=none; b=tbvR0kB89BpYPSzIHUJ2rVEu9k4QwC21V54c+uTt+UdUzPhL6uyY2vrvwJdqnWAl6bKL8Q3ycEQ1bNsfm/p1d849mh8eZK98O+gpPWr30IGz5+xj3PSp1euYPsU9c9uhbsAndnoPi1QLtHichfTcTZrf3cRnVUFJkqxs90EN5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037939; c=relaxed/simple;
	bh=a+J4RqokX+OyBvlrm7FDmekCYwN+zCu6y5izBNDqtjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFhnNDwlUjk8YErWYmLRHJvyItzOKx6QEPuUztztiB1s9C7T9lrAkJmB6xbQBWYRRXyKDcMBt7LHL+Bi/Z2SJtu9XCrFukwOOjD6OjLFYPcz8wDRGXYKuxxInVEJ7OVpB3WrrBjdleKV3lrBrMDPhYyHrjFe2PumWhenxPV9CHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YYlc40QVBzbnp0;
	Thu, 16 Jan 2025 22:29:08 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A571E180101;
	Thu, 16 Jan 2025 22:32:11 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jan 2025 22:32:09 +0800
Message-ID: <751d31cc-640f-47fc-bb5e-1f9fbdd6316b@huawei.com>
Date: Thu, 16 Jan 2025 22:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
To: yangerkun <yangerkun@huawei.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <yukuai1@huaweicloud.com>, <houtao1@huawei.com>,
	<yi.zhang@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
 <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

在 2025/1/16 19:43, yangerkun 写道:
> Hi,
>
> Thanks for the patch.
>
> Before 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()", every
> time we set RPC_TASK_SIGNALLED, when we go through __rpc_execute, this
> rpc_task will immediate break and exist.
>
> However after that, __rpc_execute won't judge RPC_TASK_SIGNNALED, so for
> the case like you point out below, even after your commit
> rpc_check_timeout will help break and exist eventually, but this
> rpc_task has already do some work. I prefer reintroduce judging
> RPC_TASK_SIGNNALED in __rpc_execute to help exist immediatly.
Thanks for your advice, I will send v2 soon.
>
> 在 2025/1/14 22:41, Li Lingfeng 写道:
>> Commit 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()") adds
>> rpc_task_set_rpc_status before setting RPC_TASK_SIGNALLED in
>> rpc_signal_task, ensuring that rpc_status is definitely set when
>> RPC_TASK_SIGNALLED is set.
>> Therefore, it seems unnecessary to set rpc_status again after detecting
>> RPC_TASK_SIGNALLED in rpc_check_timeout.
>>
>> However, in some exceptional cases, invalid and endlessly looping
>> rpc_tasks may be generated. The rpc_call_rpcerror in 
>> rpc_check_timeout can
>> timely terminate such rpc_tasks. Removing rpc_call_rpcerror may cause 
>> the
>> rpc_task to fall into an infinite loop.
>>
>> For example, in the following situation:
>> nfs4_close_done
>>   // get err from server
>>   nfs4_async_handle_exception
>>   // goto out_restart
>>                              // umount -f
>>                              nfs_umount_begin
>>                               rpc_killall_tasks
>>                                rpc_signal_task
>>                                 rpc_task_set_rpc_status
>>                                  task->tk_rpc_status = -ERESTARTSYS
>>                                  set_bit
>>                                  // set RPC_TASK_SIGNALLED to 
>> tk_runstate
>>   rpc_restart_call_prepare
>>    __rpc_restart_call
>>     task->tk_rpc_status = 0
>>     // clear tk_rpc_status
>>    ...
>>    rpc_prepare_task
>>     nfs4_close_prepare
>>      nfs4_setup_sequence
>>       rpc_call_start
>>        task->tk_action = call_start
>>
>> At this point, an rpc_task with RPC_TASK_SIGNALLED set but tk_rpc_status
>> as 0 will be generated. This rpc_task will fall into the following loop:
>> call_encode --> call_transmit --> call_transmit_status --> call_status
>> --> call_encode.
>>
>> Since RPC_TASK_SIGNALLED is set, no request will be sent in 
>> call_transmit.
>> Similarly, since RPC_TASK_SIGNALLED is set, rq_majortimeo will not be
>> updated in call_status --> rpc_check_timeout, which will cause 
>> -ETIMEDOUT
>> to be directly set to tk_status in call_transmit_status -->
>> xprt_request_wait_receive --> xprt_wait_for_reply_request_def -->
>> rpc_sleep_on_timeout --> __rpc_sleep_on_priority_timeout.
>>
>> Here is the state and loop process of the rpc_task:
>> tk_runstate:
>> RPC_TASK_RUNNING RPC_TASK_ACTIVE RPC_TASK_NEED_RECV RPC_TASK_SIGNALLED
>> tk_xprt->state:
>> XPRT_CONNECTED XPRT_BOUND
>> tk_flags
>> RPC_TASK_ASYNC RPC_TASK_MOVEABLE RPC_TASK_DYNAMIC RPC_TASK_SOFT
>> RPC_TASK_NO_RETRANS_TIMEOUT RPC_TASK_CRED_NOREF
>>
>> call_encode
>>   xprt_request_enqueue_transmit
>>    set_bit // RPC_TASK_NEED_XMIT
>>   task->tk_action = call_transmit
>>
>> call_transmit
>>   task->tk_action = call_transmit_status
>>   xprt_transmit
>>    xprt_request_transmit
>>     // check RPC_TASK_SIGNALLED and goto out_dequeue
>>     xprt_request_dequeue_transmit
>>      xprt_request_dequeue_transmit_locked
>>       test_and_clear_bit // RPC_TASK_NEED_XMIT
>>
>> call_transmit_status
>>   task->tk_action = call_status
>>   xprt_request_wait_receive
>>    xprt_wait_for_reply_request_def
>>     xprt_request_timeout // get timeout
>>      req->rq_majortimeo // rq_majortimeo will not be updated
>>     rpc_sleep_on_timeout
>>      __rpc_sleep_on_priority_timeout
>>       task->tk_status = -ETIMEDOUT // set ETIMEDOUT
>>
>> call_status
>>   task->tk_action = call_encode
>>   rpc_check_timeout
>>    // check RPC_TASK_SIGNALLED and skip xprt_reset_majortimeo
>>
>> Fix it by adding rpc_call_rpcerror back.
>>
>> Fixes: 39494194f93b ("SUNRPC: Fix races with rpc_killall_tasks()")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   net/sunrpc/clnt.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 0090162ee8c3..0acdff19a37c 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2509,8 +2509,10 @@ rpc_check_timeout(struct rpc_task *task)
>>   {
>>       struct rpc_clnt    *clnt = task->tk_client;
>>   -    if (RPC_SIGNALLED(task))
>> +    if (RPC_SIGNALLED(task)) {
>> +        rpc_call_rpcerror(task, -ERESTARTSYS);
>>           return;
>> +    }
>>         if (xprt_adjust_timeout(task->tk_rqstp) == 0)
>>           return;

