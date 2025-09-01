Return-Path: <linux-nfs+bounces-13965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26414B3E6C7
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 16:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342767A1770
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E28340DB9;
	Mon,  1 Sep 2025 14:12:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD072566DD;
	Mon,  1 Sep 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735940; cv=none; b=JVkKVQLPALP2Q4aRppyFxYnqp5KCRYrMNU1vZSQHJYoB78+6c/A3n/6pq3GDx3Ptg1jUw8mfZz08QLH0wxTriKqg3H5TyKJlZ2LOUJw5iPW0MG8nN/9JmTOjQB/YE8DWay97yuSz+LDX2M/6+QXRES74zZYf36bYQTuRrOj5LLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735940; c=relaxed/simple;
	bh=7VYC4GVQ+wJbWCcOh4OjnCUW+Yn9Q6pn2Z0LIg8klIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dqzGlqKMNRi5Y5NrJ3hxFq684QhsHm97W+yF5azMa4zFC2V53HIwFY/I6jJOe68nWdfiNWv2WELI8Zd8QdX1r5p78cmobOhTNaVs28FBeT6uWpkonDfW/Rlp9JfDb7OmeFkgYlK6uVJEXSWIJ7+uBRR/XTCW6nZo0GdeIlihTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cFrQF32xWztTXp;
	Mon,  1 Sep 2025 22:11:17 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 210A31402CF;
	Mon,  1 Sep 2025 22:12:14 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 22:12:13 +0800
Message-ID: <bbfe06eb-125a-4c41-9026-77de56d99286@huawei.com>
Date: Mon, 1 Sep 2025 22:12:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [Question]nfs: never returned delegation
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	"zhangjian (CG)" <zhangjian496@huawei.com>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, Li
 Lingfeng <lilingfeng@huaweicloud.com>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
 <de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com>
 <5664a9dfe03b5ed7ef496a8c03384643023bb63b.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <5664a9dfe03b5ed7ef496a8c03384643023bb63b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi,

在 2025/9/1 19:40, Jeff Layton 写道:
> On Mon, 2025-09-01 at 17:07 +0800, Li Lingfeng wrote:
>> Hi,
>>
>> 在 2025/8/11 21:03, Trond Myklebust 写道:
>>> On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
>>>> Recently, we meet a NFS problem in 5.10. There are so many
>>>> test_state_id request after a non-privilaged request in tcpdump
>>>> result. There are 40w+ delegations in client (I read the delegation
>>>> list from /proc/kcore).
>>>> Firstly, I think state manager cost a lot in
>>>> nfs_server_reap_expired_delegations. But I see they are all in
>>>> NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I
>>>> read this from /proc/kcore too).
>>>> I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure
>>>> meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and
>>>> never return it again. NFS server will keep the revoked delegation in
>>>> clp->cl_revoked forever. This will result in following sequence
>>>> response with RECALLABLE_STATE_REVOKED flag. Client will send
>>>> test_state_id request for all non-revoked delegation.
>>>> This can only be solved by restarting NFS server.
>>>> I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not
>>>> the only case that cause lots of non-terminable test_state_id
>>>> requests after any non-privilaged request.
>>>> Wish NFS experts give some advices on this problem.
>>>>
>>> You have the following options:
>>>
>>>      1. Don't ever use "soft" or "softerr" on the NFS client.
>>>      2. Reboot your server every now and again.
>>>      3. Change the server code to not bother caching revoked state. Doing
>>>         so is rather pointless, since there is nothing a client can do
>>>         differently when presented with NFS4ERR_DELEG_REVOKED vs.
>>>         NFS4ERR_BAD_STATEID.
>>>      4. Change the server code to garbage collect revoked stateids after
>>>         a while.
>>>
>> I found that a server-side bug could also cause such behavior, and I've
>> reproduced the issue based on the master (commit b320789d6883).
>> nfs4_laundromat                       nfsd4_delegreturn
> I think you may be right about the race. The details are a little off
> though. The important bit here is that the laundromat also calls this
> unhash_delegation_locked before doing the list_add/del.
>>    list_add // add dp to reaplist
>>             // by dl_recall_lru
>>    list_del_init // delete dp from
>>                  // reaplist
>>                                          destroy_delegation
>>                                           unhash_delegation_locked
> ...which _should_ make the above unhash_delegation_locked return false,
> so that list_del_init never happens.
Thank you for your correction. The delegreturn indeed does not perform
list_del_init in such concurrent scenarios.
>
>>                                            list_del_init
>>                                            // dp was not added to any list
>>                                            // via dl_recall_lru
>>    revoke_delegation
>>    list_add // add dp to cl_revoked
>>             // by dl_recall_lru
>>
>> The delegation will be left in cl_revoked.
>>
>> I agree with Trond's suggestion to change the server code to fix it.
>>
>>
> ...but there is at least one variation on what you wrote above where it
> could get stuck back on the cl_revoked list after the delegreturn. The
> delegreturn does set the SC_STATUS_CLOSED bit on the stateid, so
> something like this (untested) patch, perhaps?
However, as you noted, since laundromat calls unhash_delegation_locked
first, I think the delegreturn will skip setting SC_STATUS_CLOSED due to
delegation_hashed returning false in unhash_delegation_locked.
>
> ------------8<----------
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d2d5e8e397a4..e594ded49e60 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1506,7 +1506,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>          trace_nfsd_stid_revoke(&dp->dl_stid);
>   
>          spin_lock(&clp->cl_lock);
> -       if (dp->dl_stid.sc_status & SC_STATUS_FREED) {
> +       if (dp->dl_stid.sc_status & (SC_STATUS_FREED | SC_STATUS_CLOSED)) {
>                  list_del_init(&dp->dl_recall_lru);
>                  goto out;
>          }
>
Thanks,
Lingfeng


