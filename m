Return-Path: <linux-nfs+bounces-11195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088FA94A8C
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 03:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C3B16DD8E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD401E503D;
	Mon, 21 Apr 2025 01:57:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E6645;
	Mon, 21 Apr 2025 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745200631; cv=none; b=TfyUwRCbnpg3KVAwJLRA/L7Z2Yuurc/u/Qd/DrNTQ8DwWOpxrdbOoFvV8x82Uhg3A1Y9l7/iK0nZVcdhgp7ULA4Vvol4tJ41P34z/ZjjSiqZW/gHmiKZicAFdXSyaGuh55dLIZIqBS+ZyTc7QNmUQ8LL1at5qbGhmswmDNF9GHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745200631; c=relaxed/simple;
	bh=MVjvNl4PBcxCl3avfF2/vYbnNTlgkjDbtbxOGMWH79w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hyo7JXq7FortUpee4sIxnhhu/kdwUSvqnIPx1SsRGXwsFO3XeEyYlsmMGY64LBkzp9lFDB4fkgtTu2Spp9EIp+Z8I98wQYg77PTp6WKmaDQ2laH5kutq0vYhk1oJa9+jF781qSDyEs4Yu8MmqLC90AJmo5aAjMEk6BaN6nY+8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZgpKc1jNRzvWq6;
	Mon, 21 Apr 2025 09:52:52 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E2CB180B49;
	Mon, 21 Apr 2025 09:57:00 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 09:56:59 +0800
Message-ID: <40d40603-f9a9-4eaa-aaa6-d5ce31445aa4@huawei.com>
Date: Mon, 21 Apr 2025 09:56:58 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 2/2] nfs: handle failure of get_nfs_open_context
To: Jeff Layton <jlayton@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250419085355.1451457-1-lilingfeng3@huawei.com>
 <20250419085355.1451457-3-lilingfeng3@huawei.com>
 <828b70d9f1c0a34966aeda8198d80046dcd2bba2.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <828b70d9f1c0a34966aeda8198d80046dcd2bba2.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/4/19 20:34, Jeff Layton 写道:
> On Sat, 2025-04-19 at 16:53 +0800, Li Lingfeng wrote:
>> During initialization of unlockdata or lockdata structures, if acquiring
>> the nfs_open_context fails, the current operation must be aborted to
>> ensure the nfs_open_context remains valid after initialization completes.
>> This is critical because both lock and unlock release callbacks
>> dereference the nfs_open_context - an invalid context could lead to null
>> pointer dereference.
>>
>> Fixes: faf5f49c2d9c ("NFSv4: Make NFS clean up byte range locks asynchronously")
>> Fixes: a5d16a4d090b ("NFSv4: Convert LOCK rpc call into an asynchronous RPC call")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/nfs4proc.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 9f5689c43a50..d76cf0f79f9c 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -7075,24 +7075,27 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>   	struct nfs4_state *state = lsp->ls_state;
>>   	struct inode *inode = state->inode;
>>   	struct nfs_lock_context *l_ctx;
>> +	struct nfs_open_context *open_ctx;
>>   
>>   	p = kzalloc(sizeof(*p), GFP_KERNEL);
>>   	if (p == NULL)
>>   		return NULL;
>>   	l_ctx = nfs_get_lock_context(ctx);
>> -	if (!IS_ERR(l_ctx)) {
>> +	if (!IS_ERR(l_ctx))
>>   		p->l_ctx = l_ctx;
>> -	} else {
>> -		kfree(p);
>> -		return NULL;
>> -	}
>> +	else
>> +		goto out_free;
>> +	/* Ensure we don't close file until we're done freeing locks! */
>> +	open_ctx = get_nfs_open_context(ctx);
>>
>>
> Sorry for the confusion. Now that I look more closely, I think I was
> wrong before.
>
> This can't fail, because the caller holds a reference to ctx, so the
> refcount must be non-zero. Instead of this patch, could you add a
> comment in there to that effect to make this clear in the future?
Hi Jeff,

Thank you for the feedback.
Adding a comment instead of this patch may be better.

However, I’d like to seek your guidance on a broader question: For
scenarios where an error condition ​currently cannot occur but would lead
to severe consequences (e.g., NULL pointer dereference, data corruption)
if it ever did happen (e.g., due to future code changes or bugs), do you
recommend proactively adding error handling as a defensive measure?

My rationale:
​Current code: No code path triggers this condition today --> Handling
code would be "dead" for now.
​Future risks: If a bug introduced later allows the condition to occur,
silent failure or crashes could result.
Is there a kernel/dev policy on such preemptive safeguards? Or should we
address these only when the triggering scenarios materialize?

Your insight would help me align with the project’s practices.
Thanks in advance!

Best regards,
Lingfeng
>
>
>> +	if (open_ctx)
>> +		p->ctx = open_ctx;
>> +	else
>> +		goto out_free;
> If we did decide to keep the error handling however, this would leak
> l_ctx. That reference would also need to be put if open_ctx was NULL
> here.
>
>>   	p->arg.fh = NFS_FH(inode);
>>   	p->arg.fl = &p->fl;
>>   	p->arg.seqid = seqid;
>>   	p->res.seqid = seqid;
>>   	p->lsp = lsp;
>> -	/* Ensure we don't close file until we're done freeing locks! */
>> -	p->ctx = get_nfs_open_context(ctx);
>>   	locks_init_lock(&p->fl);
>>   	locks_copy_lock(&p->fl, fl);
>>   	p->server = NFS_SERVER(inode);
>> @@ -7100,6 +7103,9 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>>   	nfs4_stateid_copy(&p->arg.stateid, &lsp->ls_stateid);
>>   	spin_unlock(&state->state_lock);
>>   	return p;
>> +out_free:
>> +	kfree(p);
>> +	return NULL;
>>   }
>>   
>>   static void nfs4_locku_release_calldata(void *data)
>> @@ -7327,6 +7333,8 @@ static struct nfs4_lockdata *nfs4_alloc_lockdata(struct file_lock *fl,
>>   	p->lsp = lsp;
>>   	p->server = server;
>>   	p->ctx = get_nfs_open_context(ctx);
>> +	if (!p->ctx)
>> +		goto out_free_seqid;
>>   	locks_init_lock(&p->fl);
>>   	locks_copy_lock(&p->fl, fl);
>>   	return p;

