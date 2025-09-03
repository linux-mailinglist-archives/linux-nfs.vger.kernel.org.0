Return-Path: <linux-nfs+bounces-13999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A667B41561
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A6D5403B8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824423817C;
	Wed,  3 Sep 2025 06:45:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0EC231A23;
	Wed,  3 Sep 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881951; cv=none; b=csy/CJuOJwUVQa5mcECVijlxdSi0j+Q4abb7d2Iw8fqHn/HRY13povPnLM/qO+m7oVdV9Sp8E5PyXdq6GfDCcvC7oHxJFKwlQSwnNeGYhYrLIDXSeXnPKlRRKKq/NpOVdfkjOKrNW15QWMB5TksH4B1o4VO1ON02QiGZR9M40DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881951; c=relaxed/simple;
	bh=0G/x6Yyu8MbTFDsbTF+XG7Xg1cnw/exxi5uvAKalT1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGTUjdSoE6Ws1Kk6X3oxcCmtstTEsha+qzkIOMimeIHFjsSj+nEAIkRSdO6lTbKvdhhTADJYHLsU8Cuep8lpnOewGu79msJDUywMJZhJDUFhNNTHyiCXfAA1550b7OpMKuawWcA0xMVjyvU+6Xn8UslV1YRiYUZlOf84r/joK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cGtRG34svzYQvrd;
	Wed,  3 Sep 2025 14:45:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E77981A0F86;
	Wed,  3 Sep 2025 14:45:44 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIwU5LdoMmXpBA--.32590S3;
	Wed, 03 Sep 2025 14:45:42 +0800 (CST)
Message-ID: <efc327e3-5956-4c61-bca5-e41f1e7c3e78@huaweicloud.com>
Date: Wed, 3 Sep 2025 14:45:40 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
To: "zhangjian (CG)" <zhangjian496@huawei.com>,
 Benjamin Coddington <bcodding@redhat.com>,
 Li Lingfeng <lilingfeng3@huawei.com>
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
 <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
 <7bf4275d-a7a0-4dab-8e5f-eb7b6e965377@huawei.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <7bf4275d-a7a0-4dab-8e5f-eb7b6e965377@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIwU5LdoMmXpBA--.32590S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rXr1kJr45WFyDCFW3Jrb_yoW5CF15pF
	ZakF4UKw4DXr1xA392y3WkAryFyrs3Wr4UGr98Gr10yFs8ZFyY9a4q9FWYkFy8Wr4kGr4j
	9an0grZxZ3y5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Hi,

在 2025/9/3 11:46, zhangjian (CG) 写道:
> Hello every experts.
>
> If we can see all delegations on hard-mounted nfs client, which are also
> on server cl_revoked list, changed from
> NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED|NFS_DELEGATION_TEST_EXPIRED
> to NFS_DELEGATION_RETURN_IF_CLOSED|NFS_DELEGATION_REVOKED, can we give
> some hypothesis on this problem ?
>
> By the way, this problem can be cover over by decreasing file count on
> server.
>
> Thanks,
> zhangjian
I think NFS_DELEGATION_TEST_EXPIRED is cleared as follows:
nfs4_state_manager
  nfs4_do_reclaim
   nfs4_reclaim_open_state
    __nfs4_reclaim_open_state // get nfs4_state from sp->so_states
     nfs41_open_expired // status = ops->recover_open
      nfs41_check_delegation_stateid
       test_and_clear_bit // NFS_DELEGATION_TEST_EXPIRED
After the bug in [1] is triggered, although the delegation is no longer on
server->delegations, it can still be obtained by traversing sp->so_states.
However, I cannot find the connection between the number of files on the
server and this issue.

Thanks,
Lingfeng

>
> On 2025/9/2 20:43, Benjamin Coddington wrote:
>> On 2 Sep 2025, at 8:10, Li Lingfeng wrote:
>>
>>> Our expected outcome was that the client would release the abnormal
>>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>>> However, this problematic delegation is no longer present in the
>>> client's server->delegations list—whether due to client-side timeouts or
>>> the server-side bug [1].
>> How does the client timeout TEST_STATEID - are you mounting with 'soft'?
>>
>> We should find the server-side bug and fix it rather than write code to
>> paper over it.  I do think the synchronization of state here is a bit
>> fragile and wish the protocol had a generation, sequence, or marker for
>> setting SEQ4_STATUS_ bits..
>>
>>>> Should we instead just administratively evict the client since it's
>>>> clearly not behaving right in this case?
>>> Thanks for the suggestion. While administratively evicting the client would
>>> certainly resolve the immediate delegation issue, I'm concerned that approach
>>> might be a bit heavy-handed.
>>> The problematic behavior seems isolated to a single delegation. Meanwhile,
>>> the client itself likely has numerous other open files and active state on
>>> the server. Forcing a complete client reconnect would tear down all that
>>> state, which could cause significant application disruption and be perceived
>>> as a service outage from the client's perspective.
>>>
>>> [1] https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com/
>> ^^ in this thread you reference v5.10 - there was a knfsd fix for a
>> cl_revoked leak "3b816601e279", and there have been 3 or 4 fixes to fix
>> problems and optimize the client walk of delegations since then.  Jeff
>> pointed out that there have been fixes in these areas.  Are you finding this
>> problem still with all those fixes included?
>>
>> Ben
>>
>>


