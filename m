Return-Path: <linux-nfs+bounces-15080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454CBC7335
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BD819E358B
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 02:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C113A3ED;
	Thu,  9 Oct 2025 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DWneFwDE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CD33993;
	Thu,  9 Oct 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977242; cv=none; b=K2KyR1+fNNFVFIVBz+MO1UpOSFlEas2Z2wbOby9Mg/E2hyXG9vki3wYK1BIaqfzcbSle4DxeGW5ua5GQG0ocoa982isf8BJAnXUx029oRa6f/bSqWdtSsz8xfQu/2j6D6VokPd+0qIrpGRWv/IYCxyFDw4epZofU4ocKaExA/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977242; c=relaxed/simple;
	bh=Slq6wtQ2jiodAzwLZC99YnT5dZF0VmddAgOkNz6C2mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GbWa1kc7eZdOswAy1Y6U+wQ4i4JRBlgdOr2bn7MUWBnqOaGhNUJLujpIak0z7YRcoZmDQtKjfyfiEZrSVMC4juaBcxkhTFw/VGGFpxVLfqCMgj9zvMPcQOxWWTGcHB2BtNIZRGHsQhvfbm6Od+sDUayvr0IqyoHWzNTQA9pHU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DWneFwDE; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4jg4y9kliBwoDDM3t1vqNW37HiVAi8SDDYfhaq3bXL8=;
	b=DWneFwDET1Widqwt0t+cNrlk9Ff/Ks2kI1yiH1rvEp7KQnVHQgv61ib0djxZaA6WBgsv+I5Ck
	+/KbWwVOHUbcRGxuTi61ygWiQocjbZ1J8cemMqoR6hg7QXBH+jwmtmufkFzy7JvXKUVZeWayDcH
	BdIOjc0B5dmYEn7iaeQLBJI=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4chv7k5ml3zLlTC;
	Thu,  9 Oct 2025 10:33:38 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B54140278;
	Thu,  9 Oct 2025 10:33:55 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 10:33:54 +0800
Message-ID: <c915e63b-1c7e-40ba-a02f-a003ffc75e20@huawei.com>
Date: Thu, 9 Oct 2025 10:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3] nfsd: remove long-standing revoked delegations by
 force
To: Chuck Lever <chuck.lever@oracle.com>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<zhangjian496@huawei.com>, <bcodding@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<tom@talpey.com>, <Dai.Ngo@oracle.com>, <neil@brown.name>,
	<jlayton@kernel.org>, <okorniev@redhat.com>
References: <20250905024823.3626685-1-lilingfeng3@huawei.com>
 <8646ca56-a1ef-403a-85ce-18b90235ab99@oracle.com>
 <2097dca1-78e1-44d8-aeb6-d46b94a63078@oracle.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <2097dca1-78e1-44d8-aeb6-d46b94a63078@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi,

在 2025/10/2 23:09, Chuck Lever 写道:
> On 9/29/25 3:40 PM, Chuck Lever wrote:
>> On 9/4/25 7:48 PM, Li Lingfeng wrote:
>>> When file access conflicts occur between clients, the server recalls
>>> delegations. If the client holding delegation fails to return it after
>>> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
>>> This causes subsequent SEQUENCE operations to set the
>>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
>>> validate all delegations and return the revoked one.
>>>
>>> However, if the client fails to return the delegation like this:
>>> nfs4_laundromat                       nfsd4_delegreturn
>>>   unhash_delegation_locked
>>>   list_add // add dp to reaplist
>>>            // by dl_recall_lru
>>>   list_del_init // delete dp from
>>>                 // reaplist
>>>                                         destroy_delegation
>>>                                          unhash_delegation_locked
>>>                                           // do nothing but return false
>>>   revoke_delegation
>>>   list_add // add dp to cl_revoked
>>>            // by dl_recall_lru
>>>
>>> The delegation will remain in the server's cl_revoked list while the
>>> client marks it revoked and won't find it upon detecting
>>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
>>> This leads to a loop:
>>> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
>>> client repeatedly tests all delegations, severely impacting performance
>>> when numerous delegations exist.
>>>
>>> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
>>> --> revoke_delegation --> destroy_unhashed_deleg -->
>>> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
>>> requests indefinitely, retaining such a delegation on the server is
>>> unnecessary.
>>>
>>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    Changes in v2:
>>>    1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>>>    2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>>>       rather than by timeout;
>>>    3) Modify the commit message.
>>>
>>>    Changes in v3:
>>>    1) Move variables used for traversal inside the if statement;
>>>    2) Add a comment to explain why we have to do this;
>>>    3) Move the second check of cl_revoked inside the if statement of
>>>       the first check.
>>>   fs/nfsd/nfs4state.c | 35 +++++++++++++++++++++++++++++++++--
>>>   1 file changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 88c347957da5..20fae3449af6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1336,6 +1336,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>>>   
>>>   	spin_lock(&state_lock);
>>>   	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>>> +	/*
>>> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
>>> +	 * delegation is hashed, to mark the current delegation as invalid.
>>> +	 */
>>> +	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
>>>   	spin_unlock(&state_lock);
>>>   	if (unhashed)
>>>   		destroy_unhashed_deleg(dp);
>>> @@ -4470,8 +4475,34 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>   	default:
>>>   		seq->status_flags = 0;
>>>   	}
>>> -	if (!list_empty(&clp->cl_revoked))
>>> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>> +	if (!list_empty(&clp->cl_revoked)) {
>>> +		struct list_head *pos, *next;
>>> +		struct nfs4_delegation *dp;
>>> +
>>> +		/*
>>> +		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
>>> +		 * may add a delegation to cl_revoked even after the
>>> +		 * client has returned it, causing persistent
>>> +		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
>>> +		 * operations.
>>> +		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
>>> +		 * to resolve.
>>> +		 */
>>> +		spin_lock(&clp->cl_lock);
>>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>>> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
>>> +				list_del_init(&dp->dl_recall_lru);
>>> +				spin_unlock(&clp->cl_lock);
>> Does unlocking cl_lock here allow another CPU to free the object
>> that @next is pointing to? That pointer address would then be
>> dereferenced on the next loop iteration.
I understand the problem as follows:
     CPU1                                    CPU2
list: cl_revoked-->dp1-->dp2-->dp3-->...
spin_lock
pos = dp1
next = dp2
list: cl_revoked-->dp2-->dp3-->...
spin_unlock
                                         spin_lock
                                         // remove and free dp2
                                         list: cl_revoked-->dp3-->...
                                         spin_unlock
spin_lock
pos = next = dp2
next = dp2->next // UAF

Apologies for the problem caused by my insufficient understanding of
list_for_each_safe.
>> Might be better to stuff dp onto a local list, then "put" all
>> the items on that list once this loop has terminated and cl_lock
>> has been released.
Thank you for your advice, I will send v4 soon.
> I intended to include this patch in nfsd-next for v6.18, but since I
> haven't gotten a response, I have dropped it for now.
>
> When we get closure on my question above, I am happy to requeue it
> for a later merge window.
Please accept my apologies for the belated reply. I have been on a break
for the National Day holiday and have just returned to work.
>
>>> +				nfs4_put_stid(&dp->dl_stid);
>>> +				spin_lock(&clp->cl_lock);
>>> +			}
>>> +		}
>>> +		spin_unlock(&clp->cl_lock);
>>> +
>>> +		if (!list_empty(&clp->cl_revoked))
>>> +			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>> +	}
>>>   	if (atomic_read(&clp->cl_admin_revoked))
>>>   		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>>>   	trace_nfsd_seq4_status(rqstp, seq);
>>
>
>
>
>

