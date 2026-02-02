Return-Path: <linux-nfs+bounces-18639-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECn+IiGJgGnO9wIAu9opvQ
	(envelope-from <linux-nfs+bounces-18639-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 12:23:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB0CB938
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD43C300421D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Feb 2026 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C72BF00B;
	Mon,  2 Feb 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WY50BY1V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEF21D3D2;
	Mon,  2 Feb 2026 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031365; cv=none; b=WNy1eTN0eswXPkfGZ7v+DXFjoD3+cZ0SSj6I5uZX9+bTB2hNmJJB2gyW9i7b5+Rqg6SPDyblpmFmNAWCsjnR4LV2h9opIop7VS37iSd6q6im/WuVOkFtfDhvRUHspP2kBM9KGTEYD1EQ6gZVLK4IbzU7CMyF1pud4FAQ0XuxPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031365; c=relaxed/simple;
	bh=7ZrkoYkR85WFMFJOVJuKUolbfkZoLFOUFJmH6eKPNcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lAKKiyT05USqzKjKsCiKkoSDz7Dvtco/V0lWhT4qAlplqe1I6nJMq3Uu/FEIwkAX68J9mJq8TqlUku8FWaZWvu/aZ0zdHORrUY5vDzz9dIbPiGOh1ZcLXv0MZRUziIO5/BG8USvmSxJ/oAA/L/4vbF3ky05fV9cTObV12DK9tiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WY50BY1V; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dnudor1+PjufLXd/vlakWHRDkDSW6uLzP+Z+ageqCeQ=;
	b=WY50BY1VHn7JD7vzJ8Sp/E6447NihmKpPfr+Mi3Y7Q8/ZaRReZuetWVCGbb8sM/MJIxrsWC6t
	wUJ5SFeYIwEbLiL4d91Qs7am7XC5YvwE8Dpl2Bl9r9UnM+YFm61Pm4NafHsbVwFVNmqv/0eoT2B
	tFxmT3B1qb/mF1Krv0bMdXk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f4PHM6sWNz1K96Y;
	Mon,  2 Feb 2026 19:18:07 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 91E864056C;
	Mon,  2 Feb 2026 19:22:38 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 19:22:37 +0800
Message-ID: <9c108a8e-4d74-4a79-978a-41790592a49d@huawei.com>
Date: Mon, 2 Feb 2026 19:22:37 +0800
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
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<zhangjian496@h-partners.com>, <lilingfeng@huaweicloud.com>
References: <20250715030559.2906634-1-lilingfeng3@huawei.com>
 <03488bcb-f2c2-4da7-913e-d262ff73ada3@huawei.com>
 <5e9ea3a8-d3ab-4fdf-9365-502866c9224d@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <5e9ea3a8-d3ab-4fdf-9365-502866c9224d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200013.china.huawei.com (7.202.194.25)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lilingfeng3@huawei.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-18639-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: E0DB0CB938
X-Rspamd-Action: no action

Hi,

I tried separating the local VFS lock update from the RPC completion path
(performing an unlock if the VFS lock update fails), and then using
nfsi->rwsem to protect the file lock to prevent UAF.

Split local VFS lock update from RPC completion path:
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 491fbe65e644..41d66e34851b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6887,7 +6887,7 @@ static struct rpc_task *nfs4_do_unlck(struct 
file_lock *fl,
         return rpc_run_task(&task_setup_data);
  }

-static int nfs4_proc_unlck(struct nfs4_state *state, struct file_lock 
*request)
+static int nfs4_proc_unlck(struct nfs4_state *state, struct file_lock 
*request, int remote_only)
  {
         struct inode *inode = state->inode;
         struct nfs4_state_owner *sp = state->owner;
@@ -6906,7 +6906,7 @@ static int nfs4_proc_unlck(struct nfs4_state 
*state, struct file_lock *request)
         mutex_lock(&sp->so_delegreturn_mutex);
         /* Exclude nfs4_reclaim_open_stateid() - note nesting! */
         down_read(&nfsi->rwsem);
-       if (locks_lock_inode_wait(inode, request) == -ENOENT) {
+       if (!remote_only && locks_lock_inode_wait(inode, request) == 
-ENOENT) {
                 up_read(&nfsi->rwsem);
                 mutex_unlock(&sp->so_delegreturn_mutex);
                 goto out;
@@ -7044,11 +7044,6 @@ static void nfs4_lock_done(struct rpc_task *task, 
void *calldata)
         case 0:
renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
                                 data->timestamp);
-               if (data->arg.new_lock && !data->cancelled) {
-                       data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
-                       if (locks_lock_inode_wait(lsp->ls_state->inode, 
&data->fl) < 0)
-                               goto out_restart;
-               }
                 if (data->arg.new_lock_owner != 0) {
                         nfs_confirm_seqid(&lsp->ls_seqid, 0);
                         nfs4_stateid_copy(&lsp->ls_stateid, 
&data->res.stateid);
@@ -7254,7 +7249,7 @@ static int _nfs4_proc_setlk(struct nfs4_state 
*state, int cmd, struct file_lock
         struct nfs_inode *nfsi = NFS_I(state->inode);
         struct nfs4_state_owner *sp = state->owner;
         unsigned char fl_flags = request->fl_flags;
-       int status;
+       int status, ret;

         request->fl_flags |= FL_ACCESS;
         status = locks_lock_inode_wait(state->inode, request);
@@ -7274,6 +7269,16 @@ static int _nfs4_proc_setlk(struct nfs4_state 
*state, int cmd, struct file_lock
         up_read(&nfsi->rwsem);
         mutex_unlock(&sp->so_delegreturn_mutex);
         status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
+       if (status != 0)
+               goto out;
+
+       request->fl_flags = fl_flags & ~(FL_SLEEP | FL_ACCESS);
+       status = locks_lock_inode_wait(state->inode, request);
+       if (status) {
+               ret = nfs4_proc_unlck(state, request, 1);
+               status = ret ? ret : status;
+               dprintk("%s: cancelling lock!\n", __func__);
+       }
  out:
         request->fl_flags = fl_flags;
         return status;
@@ -7428,7 +7433,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct 
file_lock *request)

         if (request->fl_type == F_UNLCK) {
                 if (state != NULL)
-                       return nfs4_proc_unlck(state, request);
+                       return nfs4_proc_unlck(state, request, 0);
                 return 0;
         }

Protect file lock by nfsi->rwsem:
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index c2eb01e5eeab..251a0b196d05 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -145,15 +145,17 @@ int nfs4_check_delegation(struct inode *inode, 
fmode_t flags)
  static int nfs_delegation_claim_locks(struct nfs4_state *state, const 
nfs4_stateid *stateid)
  {
         struct inode *inode = state->inode;
+       struct nfs_inode *nfsi = NFS_I(inode);
         struct file_lock *fl;
         struct file_lock_context *flctx = inode->i_flctx;
         struct list_head *list;
         int status = 0;

         if (flctx == NULL)
-               goto out;
+               return status;

         list = &flctx->flc_posix;
+       down_write(&nfsi->rwsem);
         spin_lock(&flctx->flc_lock);
  restart:
         list_for_each_entry(fl, list, fl_list) {
@@ -171,6 +173,7 @@ static int nfs_delegation_claim_locks(struct 
nfs4_state *state, const nfs4_state
         }
         spin_unlock(&flctx->flc_lock);
  out:
+       up_write(&nfsi->rwsem);
         return status;
  }

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 41d66e34851b..e763423c81ec 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6770,18 +6770,23 @@ static void nfs4_locku_done(struct rpc_task 
*task, void *data)
                 .stateid = &calldata->arg.stateid,
         };
         int status;
+       struct nfs_inode *nfsi;

         if (!nfs4_sequence_done(task, &calldata->res.seq_res))
                 return;
         switch (task->tk_status) {
                 case 0:
+                       nfsi = NFS_I(calldata->lsp->ls_state->inode);
                         renew_lease(calldata->server, calldata->timestamp);
+                       down_read(&nfsi->rwsem);
                         status = 
locks_lock_inode_wait(calldata->lsp->ls_state->inode,
  &calldata->fl);
                         if (status && (status != -ENOENT)) {
+                               up_read(&nfsi->rwsem);
                                 rpc_restart_call_prepare(task);
                                 break;
                         }
+                       up_read(&nfsi->rwsem);
                         if (nfs4_update_lock_stateid(calldata->lsp,
&calldata->res.stateid))
                                 break;
@@ -7273,7 +7278,9 @@ static int _nfs4_proc_setlk(struct nfs4_state 
*state, int cmd, struct file_lock
                 goto out;

         request->fl_flags = fl_flags & ~(FL_SLEEP | FL_ACCESS);
+       down_read(&nfsi->rwsem);
         status = locks_lock_inode_wait(state->inode, request);
+       up_read(&nfsi->rwsem);
         if (status) {
                 ret = nfs4_proc_unlck(state, request, 1);
                 status = ret ? ret : status;

However, this partially reverts the logic from commit c69899a17ca4
('NFSv4: Update of VFS byte range lock must be atomic with the stateid
update'), making the VFS lock update non-atomic with the stateid update.
I'm not sure if this might cause any issues.

Does anyone have any thoughts on this solution, or perhaps alternative
approaches?

Thanks,
Lingfeng.

在 2026/1/7 19:07, Li Lingfeng 写道:
> Hi,
>
> Recently, we found that this solution can introduce a deadlock issue:
>         T1
> nfs_flock
>  do_unlk
>   nfs4_proc_lock
>    nfs4_proc_unlck
>     down_read // holding &nfsi->rwsem
>     nfs4_do_unlck
>     rpc_wait_for_completion_task // waiting for the rpc_task to complete
>
> // .rpc_call_done
> nfs4_locku_done
>  nfs4_async_handle_exception
>   nfs4_do_handle_exception
>    exception->recovering = 1
>   rpc_sleep_on // the rpc_task sleeps on &clp->cl_rpcwaitq, waiting to 
> be woken up by T2
>
>         T2
> nfs4_state_manager
>  nfs4_do_reclaim
>   nfs4_reclaim_open_state
>    __nfs4_reclaim_open_state
>     nfs4_reclaim_locks
>      down_write // tries to acquire &nfsi->rwsem and gets stuck
>
> It seems that using &nfsi->rwsem to protect file locks is not a good 
> idea.
> Does anyone have a viable approach to address this UAF issue?
>
> Thanks,
> Lingfeng.
>
> 在 2025/9/1 22:25, Li Lingfeng 写道:
>> Friendly ping..
>>
>> Thanks
>>
>> 在 2025/7/15 11:05, Li Lingfeng 写道:
>>> LOCK may extend an existing lock and release another one and UNLOCK may
>>> also release an existing lock.
>>> When opening a file, there may be access to file locks that have been
>>> concurrently released by lock/unlock operations, potentially triggering
>>> UAF.
>>> While certain concurrent scenarios involving lock/unlock and open
>>> operations have been safeguarded with locks – for example,
>>> nfs4_proc_unlckz() acquires the so_delegreturn_mutex prior to invoking
>>> locks_lock_inode_wait() – there remain cases where such protection 
>>> is not
>>> yet implemented.
>>>
>>> The issue can be reproduced through the following steps:
>>> T1: open in read-only mode with three consecutive lock operations 
>>> applied
>>>      lock1(0~100) --> add lock1 to file
>>>      lock2(120~200) --> add lock2 to file
>>>      lock3(50~150) --> extend lock1 to cover range 0~200 and release 
>>> lock2
>>> T2: restart nfs-server and run state manager
>>> T3: open in write-only mode
>>>      T1 T2                                T3
>>>                              start recover
>>> lock1
>>> lock2
>>>                              nfs4_open_reclaim
>>>                              clear_bit // NFS_DELEGATED_STATE
>>> lock3
>>>   _nfs4_proc_setlk
>>>    lock so_delegreturn_mutex
>>>    unlock so_delegreturn_mutex
>>>    _nfs4_do_setlk
>>>                              recover done
>>>                                                  lock 
>>> so_delegreturn_mutex
>>> nfs_delegation_claim_locks
>>>                                                  get lock2
>>>     rpc_run_task
>>>     ...
>>>     nfs4_lock_done
>>>      locks_lock_inode_wait
>>>      ...
>>>       locks_dispose_list
>>>       free lock2
>>>                                                  use lock2
>>>                                                  // UAF
>>>                                                  unlock 
>>> so_delegreturn_mutex
>>>
>>> Protect file lock by nfsi->rwsem to fix this issue.
>>>
>>> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be 
>>> atomic with the stateid update")
>>> Reported-by: zhangjian (CG) <zhangjian496@huawei.com>
>>> Suggested-by: yangerkun <yangerkun@huawei.com>
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>> Changes in v2:
>>>    Use nfsi->rwsem instead of sp->so_delegreturn_mutex to prevent 
>>> concurrency.
>>>
>>>   fs/nfs/delegation.c | 5 ++++-
>>>   fs/nfs/nfs4proc.c   | 8 +++++++-
>>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>>> index 10ef46e29b25..4467b4f61905 100644
>>> --- a/fs/nfs/delegation.c
>>> +++ b/fs/nfs/delegation.c
>>> @@ -149,15 +149,17 @@ int nfs4_check_delegation(struct inode *inode, 
>>> fmode_t type)
>>>   static int nfs_delegation_claim_locks(struct nfs4_state *state, 
>>> const nfs4_stateid *stateid)
>>>   {
>>>       struct inode *inode = state->inode;
>>> +    struct nfs_inode *nfsi = NFS_I(inode);
>>>       struct file_lock *fl;
>>>       struct file_lock_context *flctx = locks_inode_context(inode);
>>>       struct list_head *list;
>>>       int status = 0;
>>>         if (flctx == NULL)
>>> -        goto out;
>>> +        return status;
>>>         list = &flctx->flc_posix;
>>> +    down_write(&nfsi->rwsem);
>>>       spin_lock(&flctx->flc_lock);
>>>   restart:
>>>       for_each_file_lock(fl, list) {
>>> @@ -175,6 +177,7 @@ static int nfs_delegation_claim_locks(struct 
>>> nfs4_state *state, const nfs4_state
>>>       }
>>>       spin_unlock(&flctx->flc_lock);
>>>   out:
>>> +    up_write(&nfsi->rwsem);
>>>       return status;
>>>   }
>>>   diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 341740fa293d..06f109c7eb2e 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -7294,14 +7294,18 @@ static int nfs4_proc_unlck(struct nfs4_state 
>>> *state, int cmd, struct file_lock *
>>>       status = -ENOMEM;
>>>       if (IS_ERR(seqid))
>>>           goto out;
>>> +    down_read(&nfsi->rwsem);
>>>       task = nfs4_do_unlck(request,
>>> nfs_file_open_context(request->c.flc_file),
>>>                    lsp, seqid);
>>>       status = PTR_ERR(task);
>>> -    if (IS_ERR(task))
>>> +    if (IS_ERR(task)) {
>>> +        up_read(&nfsi->rwsem);
>>>           goto out;
>>> +    }
>>>       status = rpc_wait_for_completion_task(task);
>>>       rpc_put_task(task);
>>> +    up_read(&nfsi->rwsem);
>>>   out:
>>>       request->c.flc_flags = saved_flags;
>>>       trace_nfs4_unlock(request, state, F_SETLK, status);
>>> @@ -7642,7 +7646,9 @@ static int _nfs4_proc_setlk(struct nfs4_state 
>>> *state, int cmd, struct file_lock
>>>       }
>>>       up_read(&nfsi->rwsem);
>>>       mutex_unlock(&sp->so_delegreturn_mutex);
>>> +    down_read(&nfsi->rwsem);
>>>       status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
>>> +    up_read(&nfsi->rwsem);
>>>   out:
>>>       request->c.flc_flags = flags;
>>>       return status;

