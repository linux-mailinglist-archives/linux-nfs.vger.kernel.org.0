Return-Path: <linux-nfs+bounces-14000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219CB41B25
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B49E542389
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BB92E8B6C;
	Wed,  3 Sep 2025 10:06:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFB284662;
	Wed,  3 Sep 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894016; cv=none; b=H6TxdPV/79yTF4PxzkX7pwpUVgolHbdyzlxuuJXopEjzUC5tUjHwrQI4TVGDhwEBE8FTrX2sXBW8G6ULFHdgEJ7vYokL6aSJNK3lLQX/GQE/zUEAW5mbGgOIHMCrZD/6XRN3AE4Owy80Od3qTgMG0IGHDhskM0up16JySuzzReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894016; c=relaxed/simple;
	bh=w3rrRgxL8XX4w+Qn1VTb5bjSpAfsAzv2+cSbOQIjKA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kD0vBEGucI+kXi9PYRo23RBdFO8bwg4qyNO2oP+d0VGQZQa5BJ4Zu3Kg5CFC3+qEqCp72pqM1RABnuhm+xm5azUdR1XiuhY5PKCxH7J+kK/gOc3qP0xI07FmlFKXH+GGaVnpZbecBlsLkLBZYNkg5etvHrVt0uWrp2CeHDVytts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cGywS61WXz2nGNL;
	Wed,  3 Sep 2025 18:07:52 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id EB87B18005F;
	Wed,  3 Sep 2025 18:06:44 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 18:06:43 +0800
Message-ID: <1e3ec8c3-631d-4193-b039-15bcf911fd16@huawei.com>
Date: Wed, 3 Sep 2025 18:06:43 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
To: Li Lingfeng <lilingfeng@huaweicloud.com>, Benjamin Coddington
	<bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
 <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
 <7bf4275d-a7a0-4dab-8e5f-eb7b6e965377@huawei.com>
 <efc327e3-5956-4c61-bca5-e41f1e7c3e78@huaweicloud.com>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <efc327e3-5956-4c61-bca5-e41f1e7c3e78@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp200004.china.huawei.com (7.202.195.99)



On 2025/9/3 14:45, Li Lingfeng wrote:
> Hi,
> 
> 在 2025/9/3 11:46, zhangjian (CG) 写道:
>> Hello every experts.
>>
>> If we can see all delegations on hard-mounted nfs client, which are also
>> on server cl_revoked list, changed from
>> NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED|
>> NFS_DELEGATION_TEST_EXPIRED
>> to NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED, can we give
>> some hypothesis on this problem ?
>>
>> By the way, this problem can be cover over by decreasing file count on
>> server.
>>
>> Thanks,
>> zhangjian
> I think NFS_DELEGATION_TEST_EXPIRED is cleared as follows:
> nfs4_state_manager
>  nfs4_do_reclaim
>   nfs4_reclaim_open_state
>    __nfs4_reclaim_open_state // get nfs4_state from sp->so_states
>     nfs41_open_expired // status = ops->recover_open
>      nfs41_check_delegation_stateid
>       test_and_clear_bit // NFS_DELEGATION_TEST_EXPIRED
> After the bug in [1] is triggered, although the delegation is no longer on
> server->delegations, it can still be obtained by traversing sp->so_states.
> However, I cannot find the connection between the number of files on the
> server and this issue.
> 
> Thanks,
> Lingfeng
> 
Thanks a lot.

NFS_DELEGATION_TEST_EXPIRED can only be set when
delegation->stateid.type != NFS4_INVALID_STATEID_TYPE. But when
NFS_DELEGATION_REVOKED is set, delegation->stateid.type will be
NFS4_INVALID_STATEID_TYPE in nfs_mark_delegation_revoked.
This implies the order could be like:
1. Deleg A is in server cl_revoked list
2. Deleg B is marked as NFS_DELEGATION_TEST_EXPIRED in client
3. Deleg B is revoked by server callback procedure and server meet [1].
deleg B is added to cl_revoked list
4. Deleg B is marked as NFS_DELEGATION_REVOKED in client

Why the first deleg A is in server cl_revoked list? Is [1] only
condition? Why this can only happen when file count is large.
I used to see 700 delegations in server but 40w+ delegations in client.
May this give some clue on the problem?
>>
>> On 2025/9/2 20:43, Benjamin Coddington wrote:
>>> On 2 Sep 2025, at 8:10, Li Lingfeng wrote:
>>>
>>>> Our expected outcome was that the client would release the abnormal
>>>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>>>> However, this problematic delegation is no longer present in the
>>>> client's server->delegations list—whether due to client-side
>>>> timeouts or
>>>> the server-side bug [1].
>>> How does the client timeout TEST_STATEID - are you mounting with 'soft'?
>>>
>>> We should find the server-side bug and fix it rather than write code to
>>> paper over it.  I do think the synchronization of state here is a bit
>>> fragile and wish the protocol had a generation, sequence, or marker for
>>> setting SEQ4_STATUS_ bits..
>>>
>>>>> Should we instead just administratively evict the client since it's
>>>>> clearly not behaving right in this case?
>>>> Thanks for the suggestion. While administratively evicting the
>>>> client would
>>>> certainly resolve the immediate delegation issue, I'm concerned that
>>>> approach
>>>> might be a bit heavy-handed.
>>>> The problematic behavior seems isolated to a single delegation.
>>>> Meanwhile,
>>>> the client itself likely has numerous other open files and active
>>>> state on
>>>> the server. Forcing a complete client reconnect would tear down all
>>>> that
>>>> state, which could cause significant application disruption and be
>>>> perceived
>>>> as a service outage from the client's perspective.
>>>>
>>>> [1] https://lore.kernel.org/all/de669327-c93a-49e5-a53b-
>>>> bda9e67d34a2@huawei.com/
>>> ^^ in this thread you reference v5.10 - there was a knfsd fix for a
>>> cl_revoked leak "3b816601e279", and there have been 3 or 4 fixes to fix
>>> problems and optimize the client walk of delegations since then.  Jeff
>>> pointed out that there have been fixes in these areas.  Are you
>>> finding this
>>> problem still with all those fixes included?
>>>
>>> Ben
>>>
>>>
> 


