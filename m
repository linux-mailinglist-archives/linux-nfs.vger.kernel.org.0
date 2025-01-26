Return-Path: <linux-nfs+bounces-9613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC96A1C61F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 03:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D483A876B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9A42AA6;
	Sun, 26 Jan 2025 02:20:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621D8828;
	Sun, 26 Jan 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737858015; cv=none; b=EZxgKDM8fHh5U2G6b+V7J6e8rIs3UjLxxgULH11dC89Shd/L4e8GbUyJuLpMZ6yta+U9/+rMUycW6SLhwbH1oHSPIrTfa4dst9f86RORJK67Ns1etu+Ep9oDNBrV3fop0KZsqfE9LmonVs9KkqOEwHEhFh7mJVRPfRCpD7BDYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737858015; c=relaxed/simple;
	bh=3R9vtvzA2fnGngFx7Exo7oKdsmC2U3/VpD/JY68oUkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PpPHZtIPn5TMtL+zvh9+dnc6MZI17NWAzFel/Uq51UcWnSwDXtov/VUW+vbx0KXKnwYG3QD4zgUneBqH/B/+6L0XHXC450qRNYPkS2ev4GB5bOmr3Tq7ZZu8VMU/CS03YdKsOCrEYbEcbIgARSHFsBRyEis8nUwkQ6Tr3Q9w8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YgZvL0dGVzRlnl;
	Sun, 26 Jan 2025 10:17:34 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 64A861402C1;
	Sun, 26 Jan 2025 10:20:08 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 26 Jan 2025 10:20:06 +0800
Message-ID: <e4510b86-e8d9-4550-bcca-9f8f03769be2@huawei.com>
Date: Sun, 26 Jan 2025 10:20:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
To: Trond Myklebust <trondmy@hammerspace.com>, "tom@talpey.com"
	<tom@talpey.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
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
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <4d3e8d4385a511860ec9018b3ca864e7ef3a7b48.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/17 11:15, Trond Myklebust 写道:
> On Fri, 2025-01-17 at 10:29 +0800, yangerkun wrote:
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
>>> Better yet... Let's get rid of the RPC_TASK_SIGNALLED flag
>>> altogether
>>> and just replace
>>>
>>> #define RPC_TASK_SIGNALLED(task) (READ_ONCE(task->tk_rpc_status) ==
>>> -ERESTARTSYS)

Hi,

I'm not quite clear on how this can resolve the issue.
If we remove the RPC_TASK_SIGNALLED flag and replace setting tk_runstate
to RPC_TASK_SIGNALLED with setting tk_rpc_status to -ERESTARTSYS in
rpc_signal_task, wouldn't setting tk_rpc_status back to 0 in
__rpc_restart_call still lead to an infinite loop in the rpc_task?
Could you please provide a more detailed explanation?

Thanks.

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
> That would break __rpc_restart_call() to the point of rendering it
> completely useless.
> The whole purpose of that call is to give the NFS layer a chance to
> handle errors in the exit callback, and then kick off a fresh call.
> Your suggestion would mean that any RPC level error sticks around, and
> causes the new call to immediately fail.
>
> I see no point in doing anything more than fixing the looping
> behaviour. Eliminating the redundant flag will do that.
>

