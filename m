Return-Path: <linux-nfs+bounces-13977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D04B4069D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D9B542D63
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E283064BC;
	Tue,  2 Sep 2025 14:21:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9F307AD7;
	Tue,  2 Sep 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822904; cv=none; b=qTY1sJe3QlPV4V3+WVh0Izuf/7v6dSM3PU9Noysh79RKFLuPOwTlCHHbQxGp56hEPNUAF1XVxnQ7h1e6mINzoQE+AS0O8JebFQlHR8cI9U7eTkupz/WbpqCJhtExWvzi4oVm77z8knS1S+dknqt6hcfJdiJhu/jNBx7nS2EdA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822904; c=relaxed/simple;
	bh=DkTnSQvy/EE4OQO+08Hs50mxKf3HXYnhPH7uddPQ+yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BLVXurKoiEoYtbURecsDI0IYKSIU2Jpf0JWzdFYR8V/pczfVm7YyoxY9iE6HKXwoeZlvhC2RLEI1n7qaCOLdvX/rliLUW8ziX2p45ZoHvKKDesEpQNLtow4bW5S9QbDba2ClYAqbEYoqpcZvFhbcoffW8A2dIZd73WJdHT6jlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cGSXG4mHxz1R8yL;
	Tue,  2 Sep 2025 22:18:38 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id AB60814011B;
	Tue,  2 Sep 2025 22:21:37 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 22:21:36 +0800
Message-ID: <c5869e23-5294-4757-a757-868748b3bc65@huawei.com>
Date: Tue, 2 Sep 2025 22:21:36 +0800
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
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <d12ffd7c35e84b2d09bd91644bee8d88ce08cd2d.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200013.china.huawei.com (7.202.194.25)


在 2025/9/2 21:40, Jeff Layton 写道:
> On Tue, 2025-09-02 at 20:10 +0800, Li Lingfeng wrote:
>> Hi,
>>
>> 在 2025/9/2 18:21, Jeff Layton 写道:
>>> On Tue, 2025-09-02 at 10:22 +0800, Li Lingfeng wrote:
>>>> When file access conflicts occur between clients, the server recalls
>>>> delegations. If the client holding delegation fails to return it after
>>>> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
>>>> This causes subsequent SEQUENCE operations to set the
>>>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
>>>> validate all delegations and return the revoked one.
>>>>
>>>> However, if the client fails to return the delegation due to a timeout
>>>> after receiving the recall or a server bug, the delegation remains in the
>>>> server's cl_revoked list. The client marks it revoked and won't find it
>>>> upon detecting SEQ4_STATUS_RECALLABLE_STATE_REVOKED. This leads to a loop:
>>>> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
>>>> client repeatedly tests all delegations, severely impacting performance
>>>> when numerous delegations exist.
>>>>
>>> It is a performance impact, but I don't get the "loop" here. Are you
>>> saying that this problem compounds itself? That testing all delegations
>>> causes others to be revoked?
>> The delegation will be removed from server->delegations in client after
>> NFSPROC4_CLNT_DELEGRETURN is performed.
>> nfs4_delegreturn_done
>>    nfs_delegation_mark_returned
>>     nfs_detach_delegation
>>      nfs_detach_delegation_locked
>>       list_del_rcu // remove delegation from server->delegations
>>
>>   From the client's perspective, the delegation has been returned, but on
>> the server side, it is left in the cl_revoked list.[1].
>>
>> Subsequently, every sequence from the client will be flagged with
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED as long as cl_revoked remains
>> non-empty.
>> nfsd4_sequence
>>    seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED
>>
>> When the client detects SEQ4_STATUS_RECALLABLE_STATE_REVOKED while
>> processing a sequence result, it sets NFS_DELEGATION_TEST_EXPIRED for all
>> delegations and wakes up the state manager for handling.
>> nfs41_sequence_done
>>    nfs41_sequence_process
>>     nfs41_handle_sequence_flag_errors
>>      nfs41_handle_recallable_state_revoked
>>       nfs_test_expired_all_delegations
>>        nfs_mark_test_expired_all_delegations
>>         nfs_delegation_mark_test_expired_server
>>          // set NFS_DELEGATION_TEST_EXPIRED for delegations in
>> server->delegations
>>        nfs4_schedule_state_manager
>>
>> The state manager tests all delegations except the one that was returned,
>> as it is no longer in server->delegations.
>> nfs4_state_manager
>>    nfs4_begin_drain_session
>>    nfs_reap_expired_delegations
>>     nfs_server_reap_expired_delegations
>>      // test delegations in server->delegations
>>
>> There may be a loop:
>> 1) send a sequence(client)
>> 2) return SEQ4_STATUS_RECALLABLE_STATE_REVOKED(server)
>> 3) set NFS_DELEGATION_TEST_EXPIRED for all delegations(client)
>> 4) test all delegations by state manager(client)
>> 5) send another sequence(client)
>>
>> The state manager's traversal of delegations occurs between
>> nfs4_begin_drain_session and nfs4_end_drain_session. Non-privileged requests
>> will be blocked because the NFS4_SLOT_TBL_DRAINING flag is set. If there are
>> many delegations to traverse, this blocking time can be relatively long.
>>>> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
>>>> --> revoke_delegation --> destroy_unhashed_deleg -->
>>>> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
>>>> requests indefinitely, retaining such a delegation on the server is
>>>> unnecessary.
>>>>
>>>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>>>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>>>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 88c347957da5..aa65a685dbb9 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -4326,6 +4326,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>    	int buflen;
>>>>    	struct net *net = SVC_NET(rqstp);
>>>>    	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>> +	struct list_head *pos, *next;
>>>> +	struct nfs4_delegation *dp;
>>>>    
>>>>    	if (resp->opcnt != 1)
>>>>    		return nfserr_sequence_pos;
>>>> @@ -4470,6 +4472,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>    	default:
>>>>    		seq->status_flags = 0;
>>>>    	}
>>>> +	if (!list_empty(&clp->cl_revoked)) {
>>>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>>>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>>>> +			if (dp->dl_time < (ktime_get_boottime_seconds() - 2 * nn->nfsd4_lease)) {
>>>> +				list_del_init(&dp->dl_recall_lru);
>>>> +				nfs4_put_stid(&dp->dl_stid);
>>>> +			}
>>>> +		}
> FYI: this list is protected by the clp->cl_lock. You need to hold it to
> do this list walk.
>
>>>> +	}
>>>>    	if (!list_empty(&clp->cl_revoked))
>>>>    		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>>>    	if (atomic_read(&clp->cl_admin_revoked))
>>> This seems like a violation of the spec. AIUI, the server is required
>>> to hang onto a record of the delegation until the client does the
>>> TEST_STATEID/FREE_STATEID dance to remove it. Just discarding them like
>>> this seems wrong.
>> Our expected outcome was that the client would release the abnormal
>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>> However, this problematic delegation is no longer present in the
>> client's server->delegations list—whether due to client-side timeouts or
>> the server-side bug [1].
>>> Should we instead just administratively evict the client since it's
>>> clearly not behaving right in this case?
>> Thanks for the suggestion. While administratively evicting the client would
>> certainly resolve the immediate delegation issue, I'm concerned that
>> approach
>> might be a bit heavy-handed.
>> The problematic behavior seems isolated to a single delegation. Meanwhile,
>> the client itself likely has numerous other open files and active state on
>> the server. Forcing a complete client reconnect would tear down all that
>> state, which could cause significant application disruption and be perceived
>> as a service outage from the client's perspective.
>>
>> [1]
>> https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com/
>>
>> Thanks,
>> Lingfeng
> Ok, I get the problem, but I still disagree with the solution. I don't
> think we can just time these things out. Ideally we'd close the race
> window, but the sc_status field is protected by the global state_lock
> and I don't think we want to take it in revoke_delegation.
>
> The best solution I can see is to have destroy_delegation()
> unconditionally set SC_STATUS_CLOSED, and then you can do the list walk
> above, but checking for that flag instead of testing for a timeout.
This might potentially affect the normal TEST_STATEID/FREE_STATEID flow,
as nfsd4_free_stateid() branches differently based on whether
SC_STATUS_CLOSED is set. Alternatively, I was wondering if you could
suggest a workaround to avoid this issue?

Thanks,
Lingfeng

>
> I'm still not thrilled with this solution though. It makes SEQUENCE a
> bit more heavyweight than I'd like. I'm starting to think that we need
> to rework the overall delegation locking, but that's an ugly problem to
> tackle.

