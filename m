Return-Path: <linux-nfs+bounces-9296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5913A13954
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596293A4B87
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD51DE887;
	Thu, 16 Jan 2025 11:43:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88F1DE4FF;
	Thu, 16 Jan 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027797; cv=none; b=gaVaeuA4xpXEBjRwXmzgq8+EVURA05gdsVHlgy7W5qec8sweYj6A2K8tYr0J5kdT+WeJCbR7tbWes4+CV6F+W2RElpucqcCmd9QfTK8B+oCVAXQTDRzihH+u3RB3u1jlL+zlNe15n7GU1ZHjzXj59T5OFu99t8uW+1WwdjcbVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027797; c=relaxed/simple;
	bh=eIj+V3eF624jD5grwIHMeLFukrAphaI3SnVgjSHt1XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uIK1kG8U3HwPK5m4lsAeRzSBx4IaOwCE0DTLq7ggErbnsXVwW+2ck2FUPResIyQjboVfLxGUiebiK6FtMv17ic2Pm8JpenWrezb8/Ny6GN/tz+Mu4f8STGgNu8YNoJD+Gv7thsSXD3mhCJfpMj6dIoy6Mup8TCND2O09IHLBKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YYgr63j3Hz1W4Dm;
	Thu, 16 Jan 2025 19:39:18 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id A80601800D9;
	Thu, 16 Jan 2025 19:43:10 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jan 2025 19:43:09 +0800
Message-ID: <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
Date: Thu, 16 Jan 2025 19:43:08 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
To: Li Lingfeng <lilingfeng3@huawei.com>, <trondmy@kernel.org>,
	<anna@kernel.org>, <chuck.lever@oracle.com>, <jlayton@kernel.org>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <yukuai1@huaweicloud.com>, <houtao1@huawei.com>,
	<yi.zhang@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20250114144101.2511043-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi,

Thanks for the patch.

Before 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()", every
time we set RPC_TASK_SIGNALLED, when we go through __rpc_execute, this
rpc_task will immediate break and exist.

However after that, __rpc_execute won't judge RPC_TASK_SIGNNALED, so for
the case like you point out below, even after your commit
rpc_check_timeout will help break and exist eventually, but this
rpc_task has already do some work. I prefer reintroduce judging
RPC_TASK_SIGNNALED in __rpc_execute to help exist immediatly.

在 2025/1/14 22:41, Li Lingfeng 写道:
> Commit 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()") adds
> rpc_task_set_rpc_status before setting RPC_TASK_SIGNALLED in
> rpc_signal_task, ensuring that rpc_status is definitely set when
> RPC_TASK_SIGNALLED is set.
> Therefore, it seems unnecessary to set rpc_status again after detecting
> RPC_TASK_SIGNALLED in rpc_check_timeout.
> 
> However, in some exceptional cases, invalid and endlessly looping
> rpc_tasks may be generated. The rpc_call_rpcerror in rpc_check_timeout can
> timely terminate such rpc_tasks. Removing rpc_call_rpcerror may cause the
> rpc_task to fall into an infinite loop.
> 
> For example, in the following situation:
> nfs4_close_done
>   // get err from server
>   nfs4_async_handle_exception
>   // goto out_restart
>                              // umount -f
>                              nfs_umount_begin
>                               rpc_killall_tasks
>                                rpc_signal_task
>                                 rpc_task_set_rpc_status
>                                  task->tk_rpc_status = -ERESTARTSYS
>                                  set_bit
>                                  // set RPC_TASK_SIGNALLED to tk_runstate
>   rpc_restart_call_prepare
>    __rpc_restart_call
>     task->tk_rpc_status = 0
>     // clear tk_rpc_status
>    ...
>    rpc_prepare_task
>     nfs4_close_prepare
>      nfs4_setup_sequence
>       rpc_call_start
>        task->tk_action = call_start
> 
> At this point, an rpc_task with RPC_TASK_SIGNALLED set but tk_rpc_status
> as 0 will be generated. This rpc_task will fall into the following loop:
> call_encode --> call_transmit --> call_transmit_status --> call_status
> --> call_encode.
> 
> Since RPC_TASK_SIGNALLED is set, no request will be sent in call_transmit.
> Similarly, since RPC_TASK_SIGNALLED is set, rq_majortimeo will not be
> updated in call_status --> rpc_check_timeout, which will cause -ETIMEDOUT
> to be directly set to tk_status in call_transmit_status -->
> xprt_request_wait_receive --> xprt_wait_for_reply_request_def -->
> rpc_sleep_on_timeout --> __rpc_sleep_on_priority_timeout.
> 
> Here is the state and loop process of the rpc_task:
> tk_runstate:
> RPC_TASK_RUNNING RPC_TASK_ACTIVE RPC_TASK_NEED_RECV RPC_TASK_SIGNALLED
> tk_xprt->state:
> XPRT_CONNECTED XPRT_BOUND
> tk_flags
> RPC_TASK_ASYNC RPC_TASK_MOVEABLE RPC_TASK_DYNAMIC RPC_TASK_SOFT
> RPC_TASK_NO_RETRANS_TIMEOUT RPC_TASK_CRED_NOREF
> 
> call_encode
>   xprt_request_enqueue_transmit
>    set_bit // RPC_TASK_NEED_XMIT
>   task->tk_action = call_transmit
> 
> call_transmit
>   task->tk_action = call_transmit_status
>   xprt_transmit
>    xprt_request_transmit
>     // check RPC_TASK_SIGNALLED and goto out_dequeue
>     xprt_request_dequeue_transmit
>      xprt_request_dequeue_transmit_locked
>       test_and_clear_bit // RPC_TASK_NEED_XMIT
> 
> call_transmit_status
>   task->tk_action = call_status
>   xprt_request_wait_receive
>    xprt_wait_for_reply_request_def
>     xprt_request_timeout // get timeout
>      req->rq_majortimeo // rq_majortimeo will not be updated
>     rpc_sleep_on_timeout
>      __rpc_sleep_on_priority_timeout
>       task->tk_status = -ETIMEDOUT // set ETIMEDOUT
> 
> call_status
>   task->tk_action = call_encode
>   rpc_check_timeout
>    // check RPC_TASK_SIGNALLED and skip xprt_reset_majortimeo
> 
> Fix it by adding rpc_call_rpcerror back.
> 
> Fixes: 39494194f93b ("SUNRPC: Fix races with rpc_killall_tasks()")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   net/sunrpc/clnt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0090162ee8c3..0acdff19a37c 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2509,8 +2509,10 @@ rpc_check_timeout(struct rpc_task *task)
>   {
>   	struct rpc_clnt	*clnt = task->tk_client;
>   
> -	if (RPC_SIGNALLED(task))
> +	if (RPC_SIGNALLED(task)) {
> +		rpc_call_rpcerror(task, -ERESTARTSYS);
>   		return;
> +	}
>   
>   	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
>   		return;

