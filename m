Return-Path: <linux-nfs+bounces-14052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BCB44B09
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 03:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E2567BB0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C231D61A3;
	Fri,  5 Sep 2025 01:00:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01991D5CEA;
	Fri,  5 Sep 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034000; cv=none; b=H7g3D+ZrVX5rLgaBe1fFsk2my2EKWFH5WdnPg1z01x6OJVMY9/fFyzE37ecdBbPU6jNOU2EmcyfnNRf7wCf414ShFKvKhYTO3Hhz1I3c7e27ZkKySRov8F2e7IITcjVuiGA9x4TfRipUMeJshZS7EIgJbsqsnG+mEQUWUXEFx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034000; c=relaxed/simple;
	bh=3nmBoJepqHa87v4lSyk+bD6O1WoKE2UR1b7yTQAeQbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ls3GBU0n1EOkF0H+tOl5B5ao0Krow/CkQXylIMdtmbVK0RESzIBc5FI9UwnuBmmh/J6BuAnamraoaEcAAdHAm1N7oHL6n93PMnzaUxuPEm0y5epwoujJPRs/lmMJd0sJNbjHil1bnQ1O42WKnoQ5dpDmO/NrGCojTgQDPh/U25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cHyg26BYJz14MWT;
	Fri,  5 Sep 2025 08:59:42 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id A7EE91402DB;
	Fri,  5 Sep 2025 08:59:53 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 08:59:52 +0800
Message-ID: <33e93b5d-9aa4-4752-8b01-c5c6e7e41359@huawei.com>
Date: Fri, 5 Sep 2025 08:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nfsd: remove long-standing revoked delegations by
 force
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<zhangjian496@huawei.com>, <bcodding@redhat.com>
References: <20250903115918.788159-1-lilingfeng3@huawei.com>
 <837da22b428e5a7cbda1f56868cbfe23e89dccf7.camel@kernel.org>
 <ce18bf9b-889c-4746-902c-4f9077b22a32@oracle.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <ce18bf9b-889c-4746-902c-4f9077b22a32@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200013.china.huawei.com (7.202.194.25)


在 2025/9/4 22:08, Chuck Lever 写道:
> On 9/3/25 8:15 AM, Jeff Layton wrote:
>> On Wed, 2025-09-03 at 19:59 +0800, Li Lingfeng wrote:
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
>>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>    Changes in v2:
>>>    1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>>>    2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>>>       rather than by timeout;
>>>    3) Modify the commit message.
>>>   fs/nfsd/nfs4state.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 88c347957da5..bb9e1df4e41f 100644
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
>>> @@ -4326,6 +4331,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>   	int buflen;
>>>   	struct net *net = SVC_NET(rqstp);
>>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> +	struct list_head *pos, *next;
>>> +	struct nfs4_delegation *dp;
>>>   
>> nit: These could be moved inside the if statement below.
>>
>>>   	if (resp->opcnt != 1)
>>>   		return nfserr_sequence_pos;
>>> @@ -4470,6 +4477,19 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>   	default:
>>>   		seq->status_flags = 0;
>>>   	}
>> I wouldn't mind a comment here that explains why we have to do this.
>> This is the sort of thing that will have us all scratching our heads in
>> a few years.
>>
>>> +	if (!list_empty(&clp->cl_revoked)) {
>>> +		spin_lock(&clp->cl_lock);
>>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>>> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
>>> +				list_del_init(&dp->dl_recall_lru);
>>> +				spin_unlock(&clp->cl_lock);
>>> +				nfs4_put_stid(&dp->dl_stid);
>>> +				spin_lock(&clp->cl_lock);
>>> +			}
>>> +		}
>>> +		spin_unlock(&clp->cl_lock);
>>> +	}
>> nit: I'd move the if statement below inside the above if statement. No
>> need to check list_empty() twice if it was empty the first time. Maybe
>> the compiler papers over this and only does it once?
>>
>>>   	if (!list_empty(&clp->cl_revoked))
>>>   		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>>   	if (atomic_read(&clp->cl_admin_revoked))
>> Otherwise, this looks great. Thanks for the patch!
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Li, I'm assuming you are going to address Jeff's additional comments
> here and send another revision of this patch. So I'm waiting for
> another version... let me know if you plan not to send one.
>
Thank you for the reminder. I will send a new patch soon.

Thanks,
Lingfeng


