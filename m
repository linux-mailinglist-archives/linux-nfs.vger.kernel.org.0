Return-Path: <linux-nfs+bounces-7746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2649C1D97
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA381C227CB
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB41E7C13;
	Fri,  8 Nov 2024 13:05:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E26137E;
	Fri,  8 Nov 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071102; cv=none; b=KdqrfwOKkgMuYMKuGYKHgK/TaJJXUXdMkhf14hviFFD8WvkdwsKL05APHkE01YoNmBNf9ZYcQ/Dk2MYSUlw1qmPk+fq9Z4+2cYixpQ3wJx3py/uQzwrVC2C/5PLTIUZt3wWjXfBLMJj8BgnIj9nOHFmVS4Erto3GGstphoOfRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071102; c=relaxed/simple;
	bh=2AOlYv8ayTsCQQtVAPbIcw2HzPkTXhqQUHLcby5hhMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cG/NLHIJb9eBhRlJPXtphk+EwKYlRizcRuuEikIGFGDMS67tvP2vM6XwJ0dT1GWSiHPi06wyzbG/pC1c/AcG3X5cy5Fl0FiBMJXqD89CRIe5xBnWvdsR/gcQrTvcLqUtC9OwBH82DA7iJRmiP94551dE1GwppEYGjSkTBv+Sghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XlJvM37d5z1JCHw;
	Fri,  8 Nov 2024 21:00:15 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id CB7B51A0188;
	Fri,  8 Nov 2024 21:04:53 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 21:04:52 +0800
Message-ID: <cc33931c-2821-4292-85db-86017de6afeb@huawei.com>
Date: Fri, 8 Nov 2024 21:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<geert+renesas@glider.be>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<linux-nfs@vger.kernel.org>, <neilb@suse.de>, <netdev@vger.kernel.org>,
	<ofir.gal@volumez.com>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>, <trondmy@kernel.org>
References: <78efbd6e-31e5-4e67-a046-2736747b291d@huawei.com>
 <20241107205952.7992-1-kuniyu@amazon.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20241107205952.7992-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/11/8 4:59, Kuniyuki Iwashima 写道:
> From: "liujian (CE)" <liujian56@huawei.com>
> Date: Thu, 7 Nov 2024 20:03:40 +0800
>>>> diff --git a/net/socket.c b/net/socket.c
>>>> index 042451f01c65..e64a02445b1a 100644
>>>> --- a/net/socket.c
>>>> +++ b/net/socket.c
>>>> @@ -1651,6 +1651,34 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
>>>>    }
>>>>    EXPORT_SYMBOL(sock_create_kern);
>>>>    
>>>> +int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res)
>>>> +{
>>>> +	struct sock *sk;
>>>> +	int ret;
>>>> +
>>>> +	if (!maybe_get_net(net))
>>>> +		return -EINVAL;
>>>
>>> Is this really safe ?
>>>
>>> IIUC, maybe_get_net() is safe for a net only when it is fetched under
>>> RCU, then rcu_read_lock() prevents cleanup_net() from reusing the net
>>> by rcu_barrier().
>>>
>>> Otherwise, there should be a small chance that the same slab object is
>>> reused for another netns between fetching the net and reaching here.
>>>
>>> svc_create_socket() is called much later after the netns is fetched,
>>> and _svc_xprt_create() calls try_module_get() before ->xpo_create().
>>> So, it seems the path is not under RCU and maybe_get_net() must be
>>> called much earlier by each call site.
>>>
>>> For this reason, when I write a patch for the same issue in CIFS,
>>> I delayed put_net() to cifsd kthread so that the netns refcnt taken
>>> for each CIFS server info lives until the last __sock_create() attempt
>>> from cifsd.
>>>
>>> https://lore.kernel.org/linux-cifs/20241102212438.76691-1-kuniyu@amazon.com/
>>>
>> Okay, got it. thank you.
>> Looking at the nfs and nfsd processing flow, it seems that the call to
>> __sock_create() to create a TCP socket is always after the mount
>> operation get_net(). So it should be fine to use get_net() directly.
> 
> Is there any chance that a concurrent unmount releases the
> last refcount by put_net() while another thread trying to call
> __sock_create() ?
> 
> CIFS was the case.
> 
> 
>> So
>> here I'm going to change may_get_net() to get_net(), move
>> sock_create_kern_getnet() to the sunrpc module, and rename it to
>> something more appropriate. Is that okay?
> 
> Could you go without adding a helper and do the conversion in sunrpc
> code as CIFS did ?
> 
Ok, I will send v3 as you said.
Looking forward to your changes as described below.
Thank you.

> I plan to resurrect my patch and remove such socket conversion altogether
> in the next cycle after the CIFS fix lands on net-next.
> 
> https://lore.kernel.org/netdev/20240227011041.97375-4-kuniyu@amazon.com/
> https://github.com/q2ven/linux/commits/427_2
> https://github.com/q2ven/linux/commit/2e54a8cc84f1e9ce60a0e4693c79a8e74c3dbeb9
> 
> I inspected all the callers of __sock_create() and friends, and all
> __sock_create() can be replaced with sock_create_kern(), so I will
> unexport __sock_create() and then add a new parameter hold_net to it.
> 
> Then, I'll rename sock_create_kern() to sock_create_net_noref() and add
> a fat comment to catch in-kernel users attention so that they no longer
> use _kern() API blindly without care about netns reference.  Also, I'll
> add sock_create_net() and use it for MPTCP, SMC, CIFS, (and sunrpc) etc.
> 
> RDS uses maybe_net_get() but I think this is still buggy and I need
> to check more.

