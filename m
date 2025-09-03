Return-Path: <linux-nfs+bounces-13998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB6B41319
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 05:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35917546006
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A82BD03;
	Wed,  3 Sep 2025 03:46:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5ABA4A;
	Wed,  3 Sep 2025 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871203; cv=none; b=PJrIyEAU6Ry0J66bG+lKnrQFTvVRhfnps/JizhaD6SGEW0DT6hZALseEhIPEjr4HgGP6IBwUwWBxpQjNB+GTYh6UEmToyuDInnl22nqFOuBZH1xdGxPwgnKD+ncrX7WbzJmtkel+W3dT2u5/sQuBYQEnvB2e/44epmgo1tis1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871203; c=relaxed/simple;
	bh=uYcpWWqYubMdfXkt3CQc3hGe1T0wSHS1XLaVk5l4aQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sLq6h/4BbZNNRAfCZgzV555TlaRfVWhtc+gloAPhg6n61WGpPvUR+c/vUXAXc71Iz1s8PSCekncKtAwyx/6EuBWL1frJheKbRyaF9GU/d9cTDBdb+KIm0EfW3h23NkFftFCEC9CWShUmBCQZzFiNXfpKnrJlP8Z1iAJO9+ypO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cGpN660v3z13N05;
	Wed,  3 Sep 2025 11:42:46 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id D5806140159;
	Wed,  3 Sep 2025 11:46:37 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 11:46:36 +0800
Message-ID: <7bf4275d-a7a0-4dab-8e5f-eb7b6e965377@huawei.com>
Date: Wed, 3 Sep 2025 11:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
To: Benjamin Coddington <bcodding@redhat.com>, Li Lingfeng
	<lilingfeng3@huawei.com>
CC: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
 <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Hello every experts.

If we can see all delegations on hard-mounted nfs client, which are also
on server cl_revoked list, changed from
NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED|NFS_DELEGATION_TEST_EXPIRED
to NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED, can we give
some hypothesis on this problem ?

By the way, this problem can be cover over by decreasing file count on
server.

Thanks,
zhangjian

On 2025/9/2 20:43, Benjamin Coddington wrote:
> On 2 Sep 2025, at 8:10, Li Lingfeng wrote:
> 
>> Our expected outcome was that the client would release the abnormal
>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>> However, this problematic delegation is no longer present in the
>> client's server->delegations list—whether due to client-side timeouts or
>> the server-side bug [1].
> 
> How does the client timeout TEST_STATEID - are you mounting with 'soft'?
> 
> We should find the server-side bug and fix it rather than write code to
> paper over it.  I do think the synchronization of state here is a bit
> fragile and wish the protocol had a generation, sequence, or marker for
> setting SEQ4_STATUS_ bits..
> 
>>>
>>> Should we instead just administratively evict the client since it's
>>> clearly not behaving right in this case?
>> Thanks for the suggestion. While administratively evicting the client would
>> certainly resolve the immediate delegation issue, I'm concerned that approach
>> might be a bit heavy-handed.
>> The problematic behavior seems isolated to a single delegation. Meanwhile,
>> the client itself likely has numerous other open files and active state on
>> the server. Forcing a complete client reconnect would tear down all that
>> state, which could cause significant application disruption and be perceived
>> as a service outage from the client's perspective.
>>
>> [1] https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com/
> 
> ^^ in this thread you reference v5.10 - there was a knfsd fix for a
> cl_revoked leak "3b816601e279", and there have been 3 or 4 fixes to fix
> problems and optimize the client walk of delegations since then.  Jeff
> pointed out that there have been fixes in these areas.  Are you finding this
> problem still with all those fixes included?
> 
> Ben
> 
> 


