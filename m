Return-Path: <linux-nfs+bounces-7895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971A9C5959
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C7B1F226FD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAE15444E;
	Tue, 12 Nov 2024 13:41:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DF70838;
	Tue, 12 Nov 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418873; cv=none; b=FMqskwVxZkTzyZFWA61rJaCw1ES3SqFphsfZmYMPNGVUU1iN6ZhpZnVEjxohI0EMHqjge2RtSJIm0ccPzvWJlAmYpOw6/oMycyghBQda5w49lvDU2yotgyEFfqL7sRHBArQNj/OEEZZjYZMJA8AOVAhFCPogxQwi/o7yEFtsmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418873; c=relaxed/simple;
	bh=jj/chrYWjr7nxg2LWaVCVtXIiuNJmgK9kPy8wNj0X5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i9m4a5sNM9g5lBaWPH6OdDACXF0kf/zre7IzOjkIFDdiDCSn5Z5Ry9EsUyu6dqbIIxCraExE8HnKOG/RktBMe2N/3MKED8JamLRTcS9v6XGjzc3Bf5elLjmoHa68h5cJyRy4djAuQqdikEfSdLDMIUrl0Hm+PMOqg5tSMNrsSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XnnbF4tYlz20t3p;
	Tue, 12 Nov 2024 21:39:53 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E170140257;
	Tue, 12 Nov 2024 21:41:07 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 21:41:05 +0800
Message-ID: <1415c896-7ef5-4000-8e44-6e2b1ad5be8f@huawei.com>
Date: Tue, 12 Nov 2024 21:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
To: NeilBrown <neilb@suse.de>, Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<horms@kernel.org>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>, <okorniev@redhat.com>,
	<pabeni@redhat.com>, <tom@talpey.com>, <trondmy@kernel.org>
References: <173136915454.1734440.13584866019725922631@noble.neil.brown.name>
 <20241112001308.58355-1-kuniyu@amazon.com>
 <173137287362.1734440.10390654443609505654@noble.neil.brown.name>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <173137287362.1734440.10390654443609505654@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/11/12 8:54, NeilBrown 写道:
> On Tue, 12 Nov 2024, Kuniyuki Iwashima wrote:
>> From: "NeilBrown" <neilb@suse.de>
>> Date: Tue, 12 Nov 2024 10:52:34 +1100
>>>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>>>> index 6f272013fd9b..d4330aaadc23 100644
>>>> --- a/net/sunrpc/svcsock.c
>>>> +++ b/net/sunrpc/svcsock.c
>>>> @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>>>>   	newlen = error;
>>>>   
>>>>   	if (protocol == IPPROTO_TCP) {
>>>> +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
>>>> +		sock->sk->sk_net_refcnt = 1;
>>>> +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
>>>> +		sock_inuse_add(net, 1);
>>>
>>> This is really ugly.  These internal details of the network layer have
>>> no place in sunrpc code. There must be a better way.
>>
>> I asked to do this way.  I agree this way is really ugly.  Similar
>> code exists in MPTCP, SMC, CIFS, etc, so I plan to add a new API for
>> this case, but this requires huge change adding a new parameter for
>> ->create() prototype and the changes are not backportable.
>>
>> https://github.com/q2ven/linux/commit/bb8b8814a73b3f50c3fef5eaf8d30d8c1df43e7b
>> https://github.com/q2ven/linux/commits/427_2
>>
>> After my series, we can use the following but cannot backport it to
>> stable.
>>
>>    sock_create_net(net, family, type, protocol);
>>
>>    e.g. commit for MPTCP
>>    https://github.com/q2ven/linux/commit/24a4647561272c1e67a685d8403e27eb863398cf
>>
>> That's why I suggested to go with the ugly way and I will clean them
>> up in the next cycle.
>>
>> So, finally the sunrpc code will be much cleaner and the netns refcnt
>> will be touched only in the core code.
> 
> This fact needs to be spelled out in the commit message:
> 
>     This is an ugly hack which can easily be backported to earlier
>     kernels.  A proper fix which cleans up the interfaces will follow,
>     but will not be so easy to backport.
> 
> or something like that.
Already added to v4, thank you.
> 
> I would still prefer if a little helper were made available so sunrpc
> could just call one function rather than adding 4 cryptic lines.  But I
> won't argue that too strongly.
Let's just leave it at that for now. ):


> Thanks,
> NeilBrown
> 
>>
>>
>>>
>>> Can we pass '0' for the kern arg to __sock_create()?  That should fix
>>> the refcounting issues, but might mess up security labelling.
>>
>> This should be avoided as it's confusing for BPF programs, LSMs, and
>> LOCKDEP.
>>
>>
>>>
>>> Can we wait for something before we call put_net() to release the net.
>>>
>>> Maybe we want to split the "kern" arg t __sock_create() and have
>>> "kern" which affects labeling and "refnet" with affects refcounting the
>>> net.
>>
>> This is exactly what my series does, but again, it's not backport
>> friendly.
>> https://github.com/q2ven/linux/commit/413e867b4aee9e9f60f3c33fb38d2004aeb29c40
>>
>>
>>>
>>> I had a quick look and very nearly every caller of __sock_create()
>>> outside of net/core really does want refcount.  Many callers of
>>> sock_create_kern() possibly don't.
>>
>> Actually, since sock_create_kern() is added, we no longer need to
>> export __sock_create(), so I have a patch to convert them to
>> sock_create_kern().
>>
>> And most of TCP socket does need refcnt, but non-TCP won't.
>> Also, handshake one is exception, which uses TCP but only in init_net,
>> where we need not take care of netns refcnt.
>>
>> https://github.com/q2ven/linux/commit/b56888bbbf327d57ea25a6b97275d6b9b8ad043a
>>
>>
>>
>>>
>>> So I really think this needs to be cleaned up in net/core, not in all
>>> the different network clients in the kernel.
>>
>> Yes, will be done in the next cycle.
>>
> 

