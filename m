Return-Path: <linux-nfs+bounces-9336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE745A14F0E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B011678E1
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32A1FC7FF;
	Fri, 17 Jan 2025 12:16:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04C1BE87B;
	Fri, 17 Jan 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116181; cv=none; b=STLiTRxuSrEW2p8CIT11HIiKbadHM5mDFevs6IeiEaKIofNDLMhpN1UbBRYgipmAoyboA+gvatFN/TtW2D4LC+9NOB97/wjgZEc41yEqXLI0CfN4mNr43VbxqwTf1TjleWA17fu6qPKJoe2/tqY2ctsjHrtZuE52or/XT/JrcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116181; c=relaxed/simple;
	bh=Vuo5GovAjDAOmmkMBMXxTd84L2fzfS9fG/Dv0na1Zjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j68pvJJYLtGThLqZuB/BwBF9iIu6BiQ1iTrkjza394SIyKr42cFwJ9FnNiY/DI284FN/Vj+jZF8c44ZRYRuADPddKad9sGyfUSroc4DCl3fjE6L8Qd1TalQpEf6mFvKGyxoUCnDWAf7W8fV2foaAo4AFL7wmWNZ4qKOHPnv1e+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YZJWn47t3z1W4Jf;
	Fri, 17 Jan 2025 20:12:21 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 116CA14010D;
	Fri, 17 Jan 2025 20:16:15 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 20:16:13 +0800
Message-ID: <3f889f28-907b-67a7-8b12-04e31812daac@huawei.com>
Date: Fri, 17 Jan 2025 20:16:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
To: Trond Myklebust <trondmy@hammerspace.com>, "tom@talpey.com"
	<tom@talpey.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "lilingfeng3@huawei.com" <lilingfeng3@huawei.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org"
	<anna@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
CC: "houtao1@huawei.com" <houtao1@huawei.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
 <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
 <642413c4bdbe296db722f0091ffa5190c992eb8e.camel@hammerspace.com>
 <58bf9d83-b58d-e5a6-4096-64eb96f3854a@huawei.com>
 <4d3e8d4385a511860ec9018b3ca864e7ef3a7b48.camel@hammerspace.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <4d3e8d4385a511860ec9018b3ca864e7ef3a7b48.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/1/17 11:15, Trond Myklebust 写道:
> On Fri, 2025-01-17 at 10:29 +0800, yangerkun wrote:
>>
>>
>> 在 2025/1/17 4:52, Trond Myklebust 写道:
>>> On Thu, 2025-01-16 at 19:43 +0800, yangerkun wrote:
>>>> Hi,
>>>>
>>>> Thanks for the patch.
>>>>
>>>> Before 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()",
>>>> every
>>>> time we set RPC_TASK_SIGNALLED, when we go through __rpc_execute,
>>>> this
>>>> rpc_task will immediate break and exist.
>>>>
>>>> However after that, __rpc_execute won't judge RPC_TASK_SIGNNALED,
>>>> so
>>>> for
>>>> the case like you point out below, even after your commit
>>>> rpc_check_timeout will help break and exist eventually, but this
>>>> rpc_task has already do some work. I prefer reintroduce judging
>>>> RPC_TASK_SIGNNALED in __rpc_execute to help exist immediatly.
>>>>
>>>
>>> Better yet... Let's get rid of the RPC_TASK_SIGNALLED flag
>>> altogether
>>> and just replace
>>>
>>> #define RPC_TASK_SIGNALLED(task) (READ_ONCE(task->tk_rpc_status) ==
>>> -ERESTARTSYS)
>>
>> Hi,
>>
>> Thanks for your reply! Yeah, if all the places where tk_rpc_status is
>> updated are by calling rpc_task_set_rpc_status, we can use
>> task->tk_rpc_status == -ERESTARTSYS to determine whether rpc_task is
>> RPC_TASK_SIGNALLED. But for the case like Li has provided,
>> __rpc_restart_call won't do this, and will overwrite tk_rpc_status
>> unconditionally. This won't be a stable solution. Maybe it's better
>> to
>> change __rpc_restart_call calling rpc_task_set_rpc_status too? And
>> __rpc_execute will be enough to help solve this case.
>>
>>
> 
> That would break __rpc_restart_call() to the point of rendering it
> completely useless.

Aha, agree with you. There maybe case tk_rpc_status != 0 but
rpc_restart_call can also rerun this rpc_task.

The only case we should consider is when we call rpc_signal_task, we
should break this rpc_task unconditionally. Fixing it within
__rpc_execute is enough.

> The whole purpose of that call is to give the NFS layer a chance to
> handle errors in the exit callback, and then kick off a fresh call.
> Your suggestion would mean that any RPC level error sticks around, and
> causes the new call to immediately fail.
> 
> I see no point in doing anything more than fixing the looping
> behaviour. Eliminating the redundant flag will do that.
> 

