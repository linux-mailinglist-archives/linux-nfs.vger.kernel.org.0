Return-Path: <linux-nfs+bounces-22797-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IrgWJ9xCO2rCUwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22797-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 04:37:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EC6BAF21
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 04:37:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22797-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22797-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8813023F8A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 02:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193462F7F0A;
	Wed, 24 Jun 2026 02:37:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C01A3160;
	Wed, 24 Jun 2026 02:37:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782268633; cv=none; b=VeM+dHmRMAS4Ioggci6PNDf8LcIpvnHU2pTjS/BYZfqvXMTJuj+IqkMSkJyIsB7sc98WohpHKpqgjGyWFGOIzXHJgS9XBH1h9pYYBy7fEroKYCCO0J6jyiBVnvFDTck8e3gfq0jpGtQnYkaLNvKc2jSE4tcGCgI9jPEVFXe5EP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782268633; c=relaxed/simple;
	bh=toChljM5J+1Q9hPupt4sU9AKm3KQxXi1+sR3Ofx1Z10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvV9TJWak/VO5G5UOrDXaT3p4Wi+07Ek6o1x1wrjcDtrpjmVOWLyMfeZ9PE1FBTOW5G1oIkY4yIxZM+Tm596BZZwTbwQNAuk0VX7Xk8QlzIr3Wb37+uZNDFI5av6pCxBUoWYDm/uk3A+U1iUNur6+6fLiEXL/s/JapdkNSfSNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4glQzn3DSfzYQts9;
	Wed, 24 Jun 2026 10:36:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3A792408E6;
	Wed, 24 Jun 2026 10:37:03 +0800 (CST)
Received: from [10.174.176.240] (unknown [10.174.176.240])
	by APP1 (Coremail) with SMTP id cCh0CgA3hzzJQjtqRbqUCw--.49590S3;
	Wed, 24 Jun 2026 10:36:59 +0800 (CST)
Message-ID: <a12a6847-b74c-4fe8-9ad8-b1e0c607bc9d@huaweicloud.com>
Date: Wed, 24 Jun 2026 10:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nfs: use nfsi->rwsem to protect traversal of the file
 lock list
To: Anna Schumaker <anna@kernel.org>, yangerkun <yangerkun@huawei.com>,
 Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 lilingfeng3@huawei.com, zhangjian496@h-partners.com, yi.zhang@huawei.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260226012203.3962997-1-yangerkun@huawei.com>
 <dcf0b02002857a6be502e372ebb3e175412d7184.camel@kernel.org>
 <163aebb3-4233-4aaa-872c-c36aa3fcb3af@huawei.com>
 <403e3267-70ef-4fb3-9700-0a14d28abc4c@huawei.com>
 <9b27efad-f22a-45b9-b080-1552acf50016@huawei.com>
 <261c255e-2cc5-4f27-8239-e708f1c9f95a@app.fastmail.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <261c255e-2cc5-4f27-8239-e708f1c9f95a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3hzzJQjtqRbqUCw--.49590S3
X-Coremail-Antispam: 1UD129KBjvJXoWfGr45urykCFy5ur18WF1xXwb_yoWDWr4fpF
	ykJFW5GrW5Xr18Jr12gw1UZryjyr1UGw1UXr1UJFyxArsrtr1Fgr1UXryq9r1UJr48Jr4U
	Xr15JrW3u34UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22797-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:yangerkun@huawei.com,m:jlayton@kernel.org,m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lilingfeng3@huawei.com,m:zhangjian496@h-partners.com,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yangerkun@huaweicloud.com,linux-nfs@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huaweicloud.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:mid,huaweicloud.com:from_mime,linux-nfs.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 978EC6BAF21



在 2026/6/24 3:52, Anna Schumaker 写道:
> Hi Erkun,
> 
> On Tue, Jun 23, 2026, at 3:37 AM, yangerkun wrote:
>> Gently ping...
>>
>> This patch has been reviewed, but leave alone here for a long time...
> 
> The patch is in my linux-next branch right here: https://git.linux-nfs.org/?p=anna/linux-nfs.git;a=commit;h=4837fb36219e6c08b666bc31a86841bad8526358

Aha, thanks for this! MAINTAINERS only point 
git://git.linux-nfs.org/projects/trondmy/linux-nfs.git and I did not 
found this commit exists. Sorry for the noise....

> 
> Anna
> 
>>
>> 在 2026/5/8 16:33, yangerkun 写道:
>>> Gently ping...
>>>
>>> 在 2026/4/16 11:01, yangerkun 写道:
>>>> Hi Anna and Trond,
>>>>
>>>> Could you please help check if there are any issues with this patch, and
>>>> if there are none, could you help merge it in?
>>>>
>>>> Thanks,
>>>> Erkun.
>>>>
>>>> 在 2026/3/9 22:09, Jeff Layton 写道:
>>>>> On Thu, 2026-02-26 at 09:22 +0800, Yang Erkun wrote:
>>>>>> Lingfeng identified a bug and suggested two solutions, but both appear
>>>>>> to have issues.
>>>>>>
>>>>>> Generally, we cannot release flc_lock while iterating over the file
>>>>>> lock
>>>>>> list to avoid use-after-free (UAF) problems with file locks. However,
>>>>>> functions like nfs_delegation_claim_locks and nfs4_reclaim_locks cannot
>>>>>> adhere to this rule because recover_lock or nfs4_lock_delegation_recall
>>>>>> may take a long time. To resolve this, NFS switches to using nfsi-
>>>>>>> rwsem
>>>>>> for the same protection, and nfs_reclaim_locks follows this approach.
>>>>>> Although nfs_delegation_claim_locks uses so_delegreturn_mutex instead,
>>>>>> this is inadequate since a single inode can have multiple nfs4_state
>>>>>> instances. Therefore, the fix is to also use nfsi->rwsem in this case.
>>>>>>
>>>>>> Furthermore, after commit c69899a17ca4 ("NFSv4: Update of VFS byte
>>>>>> range
>>>>>> lock must be atomic with the stateid update"), the functions
>>>>>> nfs4_locku_done and nfs4_lock_done also break this rule because they
>>>>>> call locks_lock_inode_wait without holding nfsi->rwsem. Simply adding
>>>>>> this protection could cause many deadlocks, so instead, the call to
>>>>>> locks_lock_inode_wait is moved into _nfs4_proc_setlk. Regarding the bug
>>>>>> fixed by commit c69899a17ca4 ("NFSv4: Update of VFS byte range
>>>>>> lock must be atomic with the stateid update"), it has been resolved
>>>>>> after commit 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly
>>>>>> triggering
>>>>>> state recovery") because all slots are drained before calling
>>>>>> nfs4_do_reclaim, which prevents concurrent stateid changes along
>>>>>> this path.
>>>>>> Also, nfs_delegation_claim_locks does not cause this concurrency either
>>>>>> since when _nfs4_proc_setlk is called with NFS_DELEGATED_STATE, no
>>>>>> RPC is
>>>>>> sent, so nfs4_lock_done is not called. Therefore,
>>>>>> nfs4_lock_delegation_recall from nfs_delegation_claim_locks is the
>>>>>> first
>>>>>> time the stateid is set.
>>>>>>
>>>>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>> Closes: https://lore.kernel.org/all/20250419085709.1452492-1-
>>>>>> lilingfeng3@huawei.com/
>>>>>> Closes: https://lore.kernel.org/all/20250715030559.2906634-1-
>>>>>> lilingfeng3@huawei.com/
>>>>>> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be
>>>>>> atomic with the stateid update")
>>>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>>>> ---
>>>>>>    fs/nfs/delegation.c     |  9 ++++++++-
>>>>>>    fs/nfs/nfs4proc.c       | 22 +++++++++++-----------
>>>>>>    include/linux/nfs_xdr.h |  1 -
>>>>>>    3 files changed, 19 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>>>>>> index 122fb3f14ffb..9546d2195c25 100644
>>>>>> --- a/fs/nfs/delegation.c
>>>>>> +++ b/fs/nfs/delegation.c
>>>>>> @@ -173,6 +173,7 @@ int nfs4_check_delegation(struct inode *inode,
>>>>>> fmode_t type)
>>>>>>    static int nfs_delegation_claim_locks(struct nfs4_state *state,
>>>>>> const nfs4_stateid *stateid)
>>>>>>    {
>>>>>>        struct inode *inode = state->inode;
>>>>>> +    struct nfs_inode *nfsi = NFS_I(inode);
>>>>>>        struct file_lock *fl;
>>>>>>        struct file_lock_context *flctx = locks_inode_context(inode);
>>>>>>        struct list_head *list;
>>>>>> @@ -182,6 +183,9 @@ static int nfs_delegation_claim_locks(struct
>>>>>> nfs4_state *state, const nfs4_state
>>>>>>            goto out;
>>>>>>        list = &flctx->flc_posix;
>>>>>> +
>>>>>> +    /* Guard against reclaim and new lock/unlock calls */
>>>>>> +    down_write(&nfsi->rwsem);
>>>>>>        spin_lock(&flctx->flc_lock);
>>>>>>    restart:
>>>>>>        for_each_file_lock(fl, list) {
>>>>>> @@ -189,8 +193,10 @@ static int nfs_delegation_claim_locks(struct
>>>>>> nfs4_state *state, const nfs4_state
>>>>>>                continue;
>>>>>>            spin_unlock(&flctx->flc_lock);
>>>>>>            status = nfs4_lock_delegation_recall(fl, state, stateid);
>>>>>> -        if (status < 0)
>>>>>> +        if (status < 0) {
>>>>>> +            up_write(&nfsi->rwsem);
>>>>>>                goto out;
>>>>>> +        }
>>>>>>            spin_lock(&flctx->flc_lock);
>>>>>>        }
>>>>>>        if (list == &flctx->flc_posix) {
>>>>>> @@ -198,6 +204,7 @@ static int nfs_delegation_claim_locks(struct
>>>>>> nfs4_state *state, const nfs4_state
>>>>>>            goto restart;
>>>>>>        }
>>>>>>        spin_unlock(&flctx->flc_lock);
>>>>>> +    up_write(&nfsi->rwsem);
>>>>>>    out:
>>>>>>        return status;
>>>>>>    }
>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>> index 91bcf67bd743..9d6fbca8798b 100644
>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>> @@ -7076,7 +7076,6 @@ static void nfs4_locku_done(struct rpc_task
>>>>>> *task, void *data)
>>>>>>        switch (task->tk_status) {
>>>>>>            case 0:
>>>>>>                renew_lease(calldata->server, calldata->timestamp);
>>>>>> -            locks_lock_inode_wait(calldata->lsp->ls_state->inode,
>>>>>> &calldata->fl);
>>>>>>                if (nfs4_update_lock_stateid(calldata->lsp,
>>>>>>                        &calldata->res.stateid))
>>>>>>                    break;
>>>>>> @@ -7344,11 +7343,6 @@ static void nfs4_lock_done(struct rpc_task
>>>>>> *task, void *calldata)
>>>>>>        case 0:
>>>>>>            renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
>>>>>>                    data->timestamp);
>>>>>> -        if (data->arg.new_lock && !data->cancelled) {
>>>>>> -            data->fl.c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
>>>>>> -            if (locks_lock_inode_wait(lsp->ls_state->inode, &data-
>>>>>>> fl) < 0)
>>>>>> -                goto out_restart;
>>>>>> -        }
>>>>>>            if (data->arg.new_lock_owner != 0) {
>>>>>>                nfs_confirm_seqid(&lsp->ls_seqid, 0);
>>>>>>                nfs4_stateid_copy(&lsp->ls_stateid, &data->res.stateid);
>>>>>> @@ -7459,11 +7453,10 @@ static int _nfs4_do_setlk(struct nfs4_state
>>>>>> *state, int cmd, struct file_lock *f
>>>>>>        msg.rpc_argp = &data->arg;
>>>>>>        msg.rpc_resp = &data->res;
>>>>>>        task_setup_data.callback_data = data;
>>>>>> -    if (recovery_type > NFS_LOCK_NEW) {
>>>>>> -        if (recovery_type == NFS_LOCK_RECLAIM)
>>>>>> -            data->arg.reclaim = NFS_LOCK_RECLAIM;
>>>>>> -    } else
>>>>>> -        data->arg.new_lock = 1;
>>>>>> +
>>>>>> +    if (recovery_type == NFS_LOCK_RECLAIM)
>>>>>> +        data->arg.reclaim = NFS_LOCK_RECLAIM;
>>>>>> +
>>>>>>        task = rpc_run_task(&task_setup_data);
>>>>>>        if (IS_ERR(task))
>>>>>>            return PTR_ERR(task);
>>>>>> @@ -7573,6 +7566,13 @@ static int _nfs4_proc_setlk(struct nfs4_state
>>>>>> *state, int cmd, struct file_lock
>>>>>>        up_read(&nfsi->rwsem);
>>>>>>        mutex_unlock(&sp->so_delegreturn_mutex);
>>>>>>        status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
>>>>>> +    if (status)
>>>>>> +        goto out;
>>>>>> +
>>>>>> +    down_read(&nfsi->rwsem);
>>>>>> +    request->c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
>>>>>> +    status = locks_lock_inode_wait(state->inode, request);
>>>>>> +    up_read(&nfsi->rwsem);
>>>>>>    out:
>>>>>>        request->c.flc_flags = flags;
>>>>>>        return status;
>>>>>> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
>>>>>> index ff1f12aa73d2..9599ad15c3ad 100644
>>>>>> --- a/include/linux/nfs_xdr.h
>>>>>> +++ b/include/linux/nfs_xdr.h
>>>>>> @@ -580,7 +580,6 @@ struct nfs_lock_args {
>>>>>>        struct nfs_lowner    lock_owner;
>>>>>>        unsigned char        block : 1;
>>>>>>        unsigned char        reclaim : 1;
>>>>>> -    unsigned char        new_lock : 1;
>>>>>>        unsigned char        new_lock_owner : 1;
>>>>>>    };
>>>>>
>>>>> Nice work!
>>>>>
>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>


