Return-Path: <linux-nfs+bounces-13966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA9B3E702
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40161899A1C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4033CE9E;
	Mon,  1 Sep 2025 14:25:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9B2773F5;
	Mon,  1 Sep 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736721; cv=none; b=pLmcTw4cuNXnQSIV8Dc2AtUse/5i9o1B9nL5Ij8Ry9EsotsEHMvDqX7cn8yfglUSgAPDPx47wbDncZ+DJX3SC2UUKuCsRaBD30b2WebXJWwreCaS+dQomunbMnUdnO9FlgRim0i4Y8ZA1ZZNVUOKc6iGNxi5P5Trs7APQpb4TF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736721; c=relaxed/simple;
	bh=FVEYjLr4sLvkx1kBl/8+WytZQuo50Q/UtAR5b1LiflU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TPITAI5MMd1RO+uLwKPkcKgwnXTmdpgqiDY8Vph6enrV/NZQT4+Kijn8hslkSm+YJQERpTkl68FMQp0QmIQGNmzbaaI7lfyVoqEzws4eBVrxmZRpiPUjSP1xx5vaW8aQ7Xo+WYPefQbPb/zc/U0FVNxca3i0PYdffIpFM3AWLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFrdC1fVnzdchR;
	Mon,  1 Sep 2025 22:20:47 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id AC714180B69;
	Mon,  1 Sep 2025 22:25:15 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 22:25:14 +0800
Message-ID: <03488bcb-f2c2-4da7-913e-d262ff73ada3@huawei.com>
Date: Mon, 1 Sep 2025 22:25:14 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nfs: fix the race of lock/unlock and open
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <zhangjian496@h-partners.com>,
	<lilingfeng@huaweicloud.com>
References: <20250715030559.2906634-1-lilingfeng3@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250715030559.2906634-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Friendly ping..

Thanks

在 2025/7/15 11:05, Li Lingfeng 写道:
> LOCK may extend an existing lock and release another one and UNLOCK may
> also release an existing lock.
> When opening a file, there may be access to file locks that have been
> concurrently released by lock/unlock operations, potentially triggering
> UAF.
> While certain concurrent scenarios involving lock/unlock and open
> operations have been safeguarded with locks – for example,
> nfs4_proc_unlckz() acquires the so_delegreturn_mutex prior to invoking
> locks_lock_inode_wait() – there remain cases where such protection is not
> yet implemented.
>
> The issue can be reproduced through the following steps:
> T1: open in read-only mode with three consecutive lock operations applied
>      lock1(0~100) --> add lock1 to file
>      lock2(120~200) --> add lock2 to file
>      lock3(50~150) --> extend lock1 to cover range 0~200 and release lock2
> T2: restart nfs-server and run state manager
> T3: open in write-only mode
>      T1                            T2                                T3
>                              start recover
> lock1
> lock2
>                              nfs4_open_reclaim
>                              clear_bit // NFS_DELEGATED_STATE
> lock3
>   _nfs4_proc_setlk
>    lock so_delegreturn_mutex
>    unlock so_delegreturn_mutex
>    _nfs4_do_setlk
>                              recover done
>                                                  lock so_delegreturn_mutex
>                                                  nfs_delegation_claim_locks
>                                                  get lock2
>     rpc_run_task
>     ...
>     nfs4_lock_done
>      locks_lock_inode_wait
>      ...
>       locks_dispose_list
>       free lock2
>                                                  use lock2
>                                                  // UAF
>                                                  unlock so_delegreturn_mutex
>
> Protect file lock by nfsi->rwsem to fix this issue.
>
> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic with the stateid update")
> Reported-by: zhangjian (CG) <zhangjian496@huawei.com>
> Suggested-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
> Changes in v2:
>    Use nfsi->rwsem instead of sp->so_delegreturn_mutex to prevent concurrency.
>
>   fs/nfs/delegation.c | 5 ++++-
>   fs/nfs/nfs4proc.c   | 8 +++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 10ef46e29b25..4467b4f61905 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -149,15 +149,17 @@ int nfs4_check_delegation(struct inode *inode, fmode_t type)
>   static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_stateid *stateid)
>   {
>   	struct inode *inode = state->inode;
> +	struct nfs_inode *nfsi = NFS_I(inode);
>   	struct file_lock *fl;
>   	struct file_lock_context *flctx = locks_inode_context(inode);
>   	struct list_head *list;
>   	int status = 0;
>   
>   	if (flctx == NULL)
> -		goto out;
> +		return status;
>   
>   	list = &flctx->flc_posix;
> +	down_write(&nfsi->rwsem);
>   	spin_lock(&flctx->flc_lock);
>   restart:
>   	for_each_file_lock(fl, list) {
> @@ -175,6 +177,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
>   	}
>   	spin_unlock(&flctx->flc_lock);
>   out:
> +	up_write(&nfsi->rwsem);
>   	return status;
>   }
>   
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 341740fa293d..06f109c7eb2e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7294,14 +7294,18 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
>   	status = -ENOMEM;
>   	if (IS_ERR(seqid))
>   		goto out;
> +	down_read(&nfsi->rwsem);
>   	task = nfs4_do_unlck(request,
>   			     nfs_file_open_context(request->c.flc_file),
>   			     lsp, seqid);
>   	status = PTR_ERR(task);
> -	if (IS_ERR(task))
> +	if (IS_ERR(task)) {
> +		up_read(&nfsi->rwsem);
>   		goto out;
> +	}
>   	status = rpc_wait_for_completion_task(task);
>   	rpc_put_task(task);
> +	up_read(&nfsi->rwsem);
>   out:
>   	request->c.flc_flags = saved_flags;
>   	trace_nfs4_unlock(request, state, F_SETLK, status);
> @@ -7642,7 +7646,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
>   	}
>   	up_read(&nfsi->rwsem);
>   	mutex_unlock(&sp->so_delegreturn_mutex);
> +	down_read(&nfsi->rwsem);
>   	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
> +	up_read(&nfsi->rwsem);
>   out:
>   	request->c.flc_flags = flags;
>   	return status;

