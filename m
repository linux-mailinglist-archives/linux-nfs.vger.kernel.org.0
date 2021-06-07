Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5C39D652
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jun 2021 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFGHvV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Jun 2021 03:51:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4493 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGHvV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Jun 2021 03:51:21 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fz56S0l2CzZf7w;
        Mon,  7 Jun 2021 15:46:40 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 15:49:28 +0800
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 15:49:28 +0800
Subject: Re: [PATCH 1/2] NFSv4: Fix deadlock between nfs4_evict_inode() and
 nfs4_opendata_get_inode()
To:     <trondmy@kernel.org>
CC:     <linux-nfs@vger.kernel.org>
References: <20210601173634.243152-1-trondmy@kernel.org>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <49396167-ff9c-9363-ded7-732d14d60a8e@huawei.com>
Date:   Mon, 7 Jun 2021 15:49:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210601173634.243152-1-trondmy@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



ÔÚ 2021/6/2 1:36, trondmy@kernel.org Ð´µÀ:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the inode is being evicted, but has to return a delegation first,
> then it can cause a deadlock in the corner case where the server reboots
> before the delegreturn completes, but while the call to iget5_locked() in
> nfs4_opendata_get_inode() is waiting for the inode free to complete.
> Since the open call still holds a session slot, the reboot recovery
> cannot proceed.
> 
> In order to break the logjam, we can turn the delegation return into a
> privileged operation for the case where we're evicting the inode. We
> know that in that case, there can be no other state recovery operation
> that conflicts.
> 
it's looks good to me.

but i have another confuse, how to ensure no writeback when evict nfs inode?
because flush writes to server when close?
but not all close will flush writes to server.
> Reported-by: zhangxiaoxu (A) <zhangxiaoxu5@huawei.com>
> Fixes: 5fcdfacc01f3 ("NFSv4: Return delegations synchronously in evict_inode")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4_fs.h  |  1 +
>   fs/nfs/nfs4proc.c | 12 +++++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 065cb04222a1..543d916f79ab 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -205,6 +205,7 @@ struct nfs4_exception {
>   	struct inode *inode;
>   	nfs4_stateid *stateid;
>   	long timeout;
> +	unsigned char task_is_privileged : 1;
>   	unsigned char delay : 1,
>   		      recovering : 1,
>   		      retry : 1;
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index d671b2884d5a..673809644981 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -589,6 +589,8 @@ int nfs4_handle_exception(struct nfs_server *server, int errorcode, struct nfs4_
>   		goto out_retry;
>   	}
>   	if (exception->recovering) {
> +		if (exception->task_is_privileged)
> +			return -EDEADLOCK;
>   		ret = nfs4_wait_clnt_recover(clp);
>   		if (test_bit(NFS_MIG_FAILED, &server->mig_status))
>   			return -EIO;
> @@ -614,6 +616,8 @@ nfs4_async_handle_exception(struct rpc_task *task, struct nfs_server *server,
>   		goto out_retry;
>   	}
>   	if (exception->recovering) {
> +		if (exception->task_is_privileged)
> +			return -EDEADLOCK;
>   		rpc_sleep_on(&clp->cl_rpcwaitq, task, NULL);
>   		if (test_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) == 0)
>   			rpc_wake_up_queued_task(&clp->cl_rpcwaitq, task);
> @@ -6417,6 +6421,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
>   	struct nfs4_exception exception = {
>   		.inode = data->inode,
>   		.stateid = &data->stateid,
> +		.task_is_privileged = data->args.seq_args.sa_privileged,
>   	};
>   
>   	if (!nfs4_sequence_done(task, &data->res.seq_res))
> @@ -6540,7 +6545,6 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
>   	data = kzalloc(sizeof(*data), GFP_NOFS);
>   	if (data == NULL)
>   		return -ENOMEM;
> -	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
>   
>   	nfs4_state_protect(server->nfs_client,
>   			NFS_SP4_MACH_CRED_CLEANUP,
> @@ -6571,6 +6575,12 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
>   		}
>   	}
>   
> +	if (!data->inode)
> +		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
> +				   1);
> +	else
> +		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
> +				   0);
>   	task_setup_data.callback_data = data;
>   	msg.rpc_argp = &data->args;
>   	msg.rpc_resp = &data->res;
> 
