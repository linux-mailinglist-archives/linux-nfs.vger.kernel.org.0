Return-Path: <linux-nfs+bounces-13996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D127B411FA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AD71B6251E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05151C862D;
	Wed,  3 Sep 2025 01:35:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C71684B4;
	Wed,  3 Sep 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863311; cv=none; b=np+wMEeQS4UZZ7J7Bog2HFq5ARMTqmeu2Y2mbZmomTgQUbZKzbylIYSWvg3ND/85pISxsgveKbISThRH8Wp84Mh7FBxqM3bNr6zJwmyvGYm1nGPYUaLNTo/ybZlFb1KfANEwmvxBp//l9nz/vaLGYKWCi6XMdD/n4IaKTjQjPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863311; c=relaxed/simple;
	bh=D+LmNApU+3cFKSf6ASdgOGI8pDKVvfqM/RUAgEBQ5js=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FVs5DqW5/DfvFhff/QB8yxIg0ZF9wyTEiubzvM3q2kDpWfF1UaJiEkeV1OQ6CTgMhnsiBeKqhvbW6P5MWyqDJ9gzwpbAQeGWYpCORC+4Sinx5va/Vha1og7Ffm239YN/kWq7qrXwUwfgc6zjmLu43wVELuFqiEdVVSPwqfpISSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cGlRV5H6Dz2CfTV;
	Wed,  3 Sep 2025 09:30:30 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 992CD1A016C;
	Wed,  3 Sep 2025 09:34:59 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 09:34:58 +0800
Message-ID: <d38db7cd-7e2c-412d-8d41-8deb938670e6@huawei.com>
Date: Wed, 3 Sep 2025 09:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
To: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<zhangjian496@huawei.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
 <d12ffd7c35e84b2d09bd91644bee8d88ce08cd2d.camel@kernel.org>
 <c5869e23-5294-4757-a757-868748b3bc65@huawei.com>
 <7f0c2dfbcebcacef8afa0b8d7cbdd6d84296cbcb.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <7f0c2dfbcebcacef8afa0b8d7cbdd6d84296cbcb.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200013.china.huawei.com (7.202.194.25)


在 2025/9/2 22:29, Jeff Layton 写道:
> On Tue, 2025-09-02 at 22:21 +0800, Li Lingfeng wrote:
>> 在 2025/9/2 21:40, Jeff Layton 写道:
>>> On Tue, 2025-09-02 at 20:10 +0800, Li Lingfeng wrote:
>>>> Hi,
>>>>
>>>> 在 2025/9/2 18:21, Jeff Layton 写道:
>>>>> On Tue, 2025-09-02 at 10:22 +0800, Li Lingfeng wrote:
>>>>>> When file access conflicts occur between clients, the server recalls
>>>>>> delegations. If the client holding delegation fails to return it after
>>>>>> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
>>>>>> This causes subsequent SEQUENCE operations to set the
>>>>>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
>>>>>> validate all delegations and return the revoked one.
>>>>>>
>>>>>> However, if the client fails to return the delegation due to a timeout
>>>>>> after receiving the recall or a server bug, the delegation remains in the
>>>>>> server's cl_revoked list. The client marks it revoked and won't find it
>>>>>> upon detecting SEQ4_STATUS_RECALLABLE_STATE_REVOKED. This leads to a loop:
>>>>>> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
>>>>>> client repeatedly tests all delegations, severely impacting performance
>>>>>> when numerous delegations exist.
>>>>>>
>>>>> It is a performance impact, but I don't get the "loop" here. Are you
>>>>> saying that this problem compounds itself? That testing all delegations
>>>>> causes others to be revoked?
>>>> The delegation will be removed from server->delegations in client after
>>>> NFSPROC4_CLNT_DELEGRETURN is performed.
>>>> nfs4_delegreturn_done
>>>>     nfs_delegation_mark_returned
>>>>      nfs_detach_delegation
>>>>       nfs_detach_delegation_locked
>>>>        list_del_rcu // remove delegation from server->delegations
>>>>
>>>>    From the client's perspective, the delegation has been returned, but on
>>>> the server side, it is left in the cl_revoked list.[1].
>>>>
>>>> Subsequently, every sequence from the client will be flagged with
>>>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED as long as cl_revoked remains
>>>> non-empty.
>>>> nfsd4_sequence
>>>>     seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED
>>>>
>>>> When the client detects SEQ4_STATUS_RECALLABLE_STATE_REVOKED while
>>>> processing a sequence result, it sets NFS_DELEGATION_TEST_EXPIRED for all
>>>> delegations and wakes up the state manager for handling.
>>>> nfs41_sequence_done
>>>>     nfs41_sequence_process
>>>>      nfs41_handle_sequence_flag_errors
>>>>       nfs41_handle_recallable_state_revoked
>>>>        nfs_test_expired_all_delegations
>>>>         nfs_mark_test_expired_all_delegations
>>>>          nfs_delegation_mark_test_expired_server
>>>>           // set NFS_DELEGATION_TEST_EXPIRED for delegations in
>>>> server->delegations
>>>>         nfs4_schedule_state_manager
>>>>
>>>> The state manager tests all delegations except the one that was returned,
>>>> as it is no longer in server->delegations.
>>>> nfs4_state_manager
>>>>     nfs4_begin_drain_session
>>>>     nfs_reap_expired_delegations
>>>>      nfs_server_reap_expired_delegations
>>>>       // test delegations in server->delegations
>>>>
>>>> There may be a loop:
>>>> 1) send a sequence(client)
>>>> 2) return SEQ4_STATUS_RECALLABLE_STATE_REVOKED(server)
>>>> 3) set NFS_DELEGATION_TEST_EXPIRED for all delegations(client)
>>>> 4) test all delegations by state manager(client)
>>>> 5) send another sequence(client)
>>>>
>>>> The state manager's traversal of delegations occurs between
>>>> nfs4_begin_drain_session and nfs4_end_drain_session. Non-privileged requests
>>>> will be blocked because the NFS4_SLOT_TBL_DRAINING flag is set. If there are
>>>> many delegations to traverse, this blocking time can be relatively long.
>>>>>> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
>>>>>> --> revoke_delegation --> destroy_unhashed_deleg -->
>>>>>> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
>>>>>> requests indefinitely, retaining such a delegation on the server is
>>>>>> unnecessary.
>>>>>>
>>>>>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>>>>>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>>>>>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4state.c | 11 +++++++++++
>>>>>>     1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 88c347957da5..aa65a685dbb9 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -4326,6 +4326,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>     	int buflen;
>>>>>>     	struct net *net = SVC_NET(rqstp);
>>>>>>     	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>>>> +	struct list_head *pos, *next;
>>>>>> +	struct nfs4_delegation *dp;
>>>>>>     
>>>>>>     	if (resp->opcnt != 1)
>>>>>>     		return nfserr_sequence_pos;
>>>>>> @@ -4470,6 +4472,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>     	default:
>>>>>>     		seq->status_flags = 0;
>>>>>>     	}
>>>>>> +	if (!list_empty(&clp->cl_revoked)) {
>>>>>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>>>>>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>>>>>> +			if (dp->dl_time < (ktime_get_boottime_seconds() - 2 * nn->nfsd4_lease)) {
>>>>>> +				list_del_init(&dp->dl_recall_lru);
>>>>>> +				nfs4_put_stid(&dp->dl_stid);
>>>>>> +			}
>>>>>> +		}
>>> FYI: this list is protected by the clp->cl_lock. You need to hold it to
>>> do this list walk.
>>>
>>>>>> +	}
>>>>>>     	if (!list_empty(&clp->cl_revoked))
>>>>>>     		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>>>>>     	if (atomic_read(&clp->cl_admin_revoked))
>>>>> This seems like a violation of the spec. AIUI, the server is required
>>>>> to hang onto a record of the delegation until the client does the
>>>>> TEST_STATEID/FREE_STATEID dance to remove it. Just discarding them like
>>>>> this seems wrong.
>>>> Our expected outcome was that the client would release the abnormal
>>>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>>>> However, this problematic delegation is no longer present in the
>>>> client's server->delegations list—whether due to client-side timeouts or
>>>> the server-side bug [1].
>>>>> Should we instead just administratively evict the client since it's
>>>>> clearly not behaving right in this case?
>>>> Thanks for the suggestion. While administratively evicting the client would
>>>> certainly resolve the immediate delegation issue, I'm concerned that
>>>> approach
>>>> might be a bit heavy-handed.
>>>> The problematic behavior seems isolated to a single delegation. Meanwhile,
>>>> the client itself likely has numerous other open files and active state on
>>>> the server. Forcing a complete client reconnect would tear down all that
>>>> state, which could cause significant application disruption and be perceived
>>>> as a service outage from the client's perspective.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com/
>>>>
>>>> Thanks,
>>>> Lingfeng
>>> Ok, I get the problem, but I still disagree with the solution. I don't
>>> think we can just time these things out. Ideally we'd close the race
>>> window, but the sc_status field is protected by the global state_lock
>>> and I don't think we want to take it in revoke_delegation.
>>>
>>> The best solution I can see is to have destroy_delegation()
>>> unconditionally set SC_STATUS_CLOSED, and then you can do the list walk
>>> above, but checking for that flag instead of testing for a timeout.
>> This might potentially affect the normal TEST_STATEID/FREE_STATEID flow,
>> as nfsd4_free_stateid() branches differently based on whether
>> SC_STATUS_CLOSED is set. Alternatively, I was wondering if you could
>> suggest a workaround to avoid this issue?
>>
> I can't think of any workarounds other than turning off delegations
> altogether.
>
> I guess your concern is that TEST_STATEID and FREE_STATEID would return
> BAD_STATEID in this case, even though the entry was still (technically)
> on the cl_revoked list? That seems like correct behavior. The client
> did send DELEGRETURN, after all.
Sorry for the noice. I was mistaken.
I was originally concerned that after setting SC_STATUS_CLOSED via
nfsd4_delegreturn --> destroy_delegation, if the client initiated a
FREE_STATEID, the server would skip the SC_TYPE_DELEG branch in
nfsd4_free_stateid() that would normally be executed.
However, in reality, after the client completes DELEGRETURN, it will not
perform FREE_STATEID for this delegation again since the delegation is
no longer in server->delegations.

Thanks,
Lingfeng

>
>>> I'm still not thrilled with this solution though. It makes SEQUENCE a
>>> bit more heavyweight than I'd like. I'm starting to think that we need
>>> to rework the overall delegation locking, but that's an ugly problem to
>>> tackle.

