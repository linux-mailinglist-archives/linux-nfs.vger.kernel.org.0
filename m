Return-Path: <linux-nfs+bounces-21443-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO2MD4ag/WmwgQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21443-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 10:36:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782D4F3C8C
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226CD3006962
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81099382393;
	Fri,  8 May 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qhOtxgCj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CE2D978C;
	Fri,  8 May 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229218; cv=none; b=s9z1aKRsYrRdBE3DNUwkc9IPWhyHLozBZcrRCdEyneenjRq3lFgr3fjfvyGrnIR6aucGVUtN7VnAM5TWwr2R+TtjZvB2xViKUnlx1FRsfh3WhISutQFXI4wiJfOMcQgzMQz84e/fG+7it52ur45qnc4rL5fbW73vmFvl/44yLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229218; c=relaxed/simple;
	bh=ndm9qotnyz85MD2ynikAViwEFwSkkqe/owp4wyOhQu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cr3eEW7DKJ87pERk1yTKBDs8cz1OYvmmNbRgFs6Hf1LYkOLYsaxht1v30LIo9MHcfoEgi8iLzpWcBfLL/tppeHL43KmTMBjGUsymJ7/+Z/NtuwmHxADJ+rKqyizeGQxo9MdqDz3xi5Mxnu4sYTF+QtwwyzPImbCiA4ZYgaW4msc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qhOtxgCj; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I0h0GPxprVTLdB2AuDeIq2HPPUlky6orxuIW+09iwhQ=;
	b=qhOtxgCjVwUGXbmUDhN/glYIcHYXP9D3N1He+vN3w1ZrtRsSnTETgki8OVmOmzeVQkK2odxbL
	4SFTtqnHMKwPVJqaPou0n63LNZMQixIgYfcF7L5lA4Gn8FagKUeGxh3GBraB03SPmq5AmUYFpAZ
	sGcDMVUrKvt5Ef5wAVnN2mI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gBhyt3TfszRhRr;
	Fri,  8 May 2026 16:25:58 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 327D44056A;
	Fri,  8 May 2026 16:33:32 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 16:33:31 +0800
Message-ID: <403e3267-70ef-4fb3-9700-0a14d28abc4c@huawei.com>
Date: Fri, 8 May 2026 16:33:30 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nfs: use nfsi->rwsem to protect traversal of the file
 lock list
To: Jeff Layton <jlayton@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huaweicloud.com>, <lilingfeng3@huawei.com>,
	<zhangjian496@h-partners.com>, <yi.zhang@huawei.com>
References: <20260226012203.3962997-1-yangerkun@huawei.com>
 <dcf0b02002857a6be502e372ebb3e175412d7184.camel@kernel.org>
 <163aebb3-4233-4aaa-872c-c36aa3fcb3af@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <163aebb3-4233-4aaa-872c-c36aa3fcb3af@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 7782D4F3C8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21443-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

Gently ping...

在 2026/4/16 11:01, yangerkun 写道:
> Hi Anna and Trond,
> 
> Could you please help check if there are any issues with this patch, and
> if there are none, could you help merge it in?
> 
> Thanks,
> Erkun.
> 
> 在 2026/3/9 22:09, Jeff Layton 写道:
>> On Thu, 2026-02-26 at 09:22 +0800, Yang Erkun wrote:
>>> Lingfeng identified a bug and suggested two solutions, but both appear
>>> to have issues.
>>>
>>> Generally, we cannot release flc_lock while iterating over the file lock
>>> list to avoid use-after-free (UAF) problems with file locks. However,
>>> functions like nfs_delegation_claim_locks and nfs4_reclaim_locks cannot
>>> adhere to this rule because recover_lock or nfs4_lock_delegation_recall
>>> may take a long time. To resolve this, NFS switches to using nfsi->rwsem
>>> for the same protection, and nfs_reclaim_locks follows this approach.
>>> Although nfs_delegation_claim_locks uses so_delegreturn_mutex instead,
>>> this is inadequate since a single inode can have multiple nfs4_state
>>> instances. Therefore, the fix is to also use nfsi->rwsem in this case.
>>>
>>> Furthermore, after commit c69899a17ca4 ("NFSv4: Update of VFS byte range
>>> lock must be atomic with the stateid update"), the functions
>>> nfs4_locku_done and nfs4_lock_done also break this rule because they
>>> call locks_lock_inode_wait without holding nfsi->rwsem. Simply adding
>>> this protection could cause many deadlocks, so instead, the call to
>>> locks_lock_inode_wait is moved into _nfs4_proc_setlk. Regarding the bug
>>> fixed by commit c69899a17ca4 ("NFSv4: Update of VFS byte range
>>> lock must be atomic with the stateid update"), it has been resolved
>>> after commit 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly 
>>> triggering
>>> state recovery") because all slots are drained before calling
>>> nfs4_do_reclaim, which prevents concurrent stateid changes along this 
>>> path.
>>> Also, nfs_delegation_claim_locks does not cause this concurrency either
>>> since when _nfs4_proc_setlk is called with NFS_DELEGATED_STATE, no 
>>> RPC is
>>> sent, so nfs4_lock_done is not called. Therefore,
>>> nfs4_lock_delegation_recall from nfs_delegation_claim_locks is the first
>>> time the stateid is set.
>>>
>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> Closes: https://lore.kernel.org/all/20250419085709.1452492-1- 
>>> lilingfeng3@huawei.com/
>>> Closes: https://lore.kernel.org/all/20250715030559.2906634-1- 
>>> lilingfeng3@huawei.com/
>>> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be 
>>> atomic with the stateid update")
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>   fs/nfs/delegation.c     |  9 ++++++++-
>>>   fs/nfs/nfs4proc.c       | 22 +++++++++++-----------
>>>   include/linux/nfs_xdr.h |  1 -
>>>   3 files changed, 19 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>>> index 122fb3f14ffb..9546d2195c25 100644
>>> --- a/fs/nfs/delegation.c
>>> +++ b/fs/nfs/delegation.c
>>> @@ -173,6 +173,7 @@ int nfs4_check_delegation(struct inode *inode, 
>>> fmode_t type)
>>>   static int nfs_delegation_claim_locks(struct nfs4_state *state, 
>>> const nfs4_stateid *stateid)
>>>   {
>>>       struct inode *inode = state->inode;
>>> +    struct nfs_inode *nfsi = NFS_I(inode);
>>>       struct file_lock *fl;
>>>       struct file_lock_context *flctx = locks_inode_context(inode);
>>>       struct list_head *list;
>>> @@ -182,6 +183,9 @@ static int nfs_delegation_claim_locks(struct 
>>> nfs4_state *state, const nfs4_state
>>>           goto out;
>>>       list = &flctx->flc_posix;
>>> +
>>> +    /* Guard against reclaim and new lock/unlock calls */
>>> +    down_write(&nfsi->rwsem);
>>>       spin_lock(&flctx->flc_lock);
>>>   restart:
>>>       for_each_file_lock(fl, list) {
>>> @@ -189,8 +193,10 @@ static int nfs_delegation_claim_locks(struct 
>>> nfs4_state *state, const nfs4_state
>>>               continue;
>>>           spin_unlock(&flctx->flc_lock);
>>>           status = nfs4_lock_delegation_recall(fl, state, stateid);
>>> -        if (status < 0)
>>> +        if (status < 0) {
>>> +            up_write(&nfsi->rwsem);
>>>               goto out;
>>> +        }
>>>           spin_lock(&flctx->flc_lock);
>>>       }
>>>       if (list == &flctx->flc_posix) {
>>> @@ -198,6 +204,7 @@ static int nfs_delegation_claim_locks(struct 
>>> nfs4_state *state, const nfs4_state
>>>           goto restart;
>>>       }
>>>       spin_unlock(&flctx->flc_lock);
>>> +    up_write(&nfsi->rwsem);
>>>   out:
>>>       return status;
>>>   }
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 91bcf67bd743..9d6fbca8798b 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -7076,7 +7076,6 @@ static void nfs4_locku_done(struct rpc_task 
>>> *task, void *data)
>>>       switch (task->tk_status) {
>>>           case 0:
>>>               renew_lease(calldata->server, calldata->timestamp);
>>> -            locks_lock_inode_wait(calldata->lsp->ls_state->inode, 
>>> &calldata->fl);
>>>               if (nfs4_update_lock_stateid(calldata->lsp,
>>>                       &calldata->res.stateid))
>>>                   break;
>>> @@ -7344,11 +7343,6 @@ static void nfs4_lock_done(struct rpc_task 
>>> *task, void *calldata)
>>>       case 0:
>>>           renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
>>>                   data->timestamp);
>>> -        if (data->arg.new_lock && !data->cancelled) {
>>> -            data->fl.c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
>>> -            if (locks_lock_inode_wait(lsp->ls_state->inode, &data- 
>>> >fl) < 0)
>>> -                goto out_restart;
>>> -        }
>>>           if (data->arg.new_lock_owner != 0) {
>>>               nfs_confirm_seqid(&lsp->ls_seqid, 0);
>>>               nfs4_stateid_copy(&lsp->ls_stateid, &data->res.stateid);
>>> @@ -7459,11 +7453,10 @@ static int _nfs4_do_setlk(struct nfs4_state 
>>> *state, int cmd, struct file_lock *f
>>>       msg.rpc_argp = &data->arg;
>>>       msg.rpc_resp = &data->res;
>>>       task_setup_data.callback_data = data;
>>> -    if (recovery_type > NFS_LOCK_NEW) {
>>> -        if (recovery_type == NFS_LOCK_RECLAIM)
>>> -            data->arg.reclaim = NFS_LOCK_RECLAIM;
>>> -    } else
>>> -        data->arg.new_lock = 1;
>>> +
>>> +    if (recovery_type == NFS_LOCK_RECLAIM)
>>> +        data->arg.reclaim = NFS_LOCK_RECLAIM;
>>> +
>>>       task = rpc_run_task(&task_setup_data);
>>>       if (IS_ERR(task))
>>>           return PTR_ERR(task);
>>> @@ -7573,6 +7566,13 @@ static int _nfs4_proc_setlk(struct nfs4_state 
>>> *state, int cmd, struct file_lock
>>>       up_read(&nfsi->rwsem);
>>>       mutex_unlock(&sp->so_delegreturn_mutex);
>>>       status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
>>> +    if (status)
>>> +        goto out;
>>> +
>>> +    down_read(&nfsi->rwsem);
>>> +    request->c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
>>> +    status = locks_lock_inode_wait(state->inode, request);
>>> +    up_read(&nfsi->rwsem);
>>>   out:
>>>       request->c.flc_flags = flags;
>>>       return status;
>>> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
>>> index ff1f12aa73d2..9599ad15c3ad 100644
>>> --- a/include/linux/nfs_xdr.h
>>> +++ b/include/linux/nfs_xdr.h
>>> @@ -580,7 +580,6 @@ struct nfs_lock_args {
>>>       struct nfs_lowner    lock_owner;
>>>       unsigned char        block : 1;
>>>       unsigned char        reclaim : 1;
>>> -    unsigned char        new_lock : 1;
>>>       unsigned char        new_lock_owner : 1;
>>>   };
>>
>> Nice work!
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>
>>
> 


