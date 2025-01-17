Return-Path: <linux-nfs+bounces-9329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A7A14845
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 03:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C7188E70F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FF1F63DF;
	Fri, 17 Jan 2025 02:29:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB217084F;
	Fri, 17 Jan 2025 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080979; cv=none; b=ZFnxZIwcOD+RwmYV8fMhJBH0ZXu4JgdzTMeAlLRWjXlkXxl0d75TCgRXnun/7+z4r2wQhzuclQTzTKryEI43H3UYS0+THIuJSW7qEXupHanf13HVlW6WoB4DpKDeKyHxDmYsIs/Ni60fAJu5IIY68f7Jkqw00Ff8Bhb7S6maYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080979; c=relaxed/simple;
	bh=iAnulAQsHBGkAS3rZ7bUQ1TN3luTGy4FNkIZEmYp5Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uSryLkK99GripBfblz7vR2ENeRPnpY1Dhd7HAilzqzxL9of2cl0EaYVpL1v7sHpmt/C5S78ws/MRxf2/edfm2xeXtHAukIZFJgg0+JfLW0utIo/GNo3YFOblDTET3ldTwQQTVBhndsROib1ogAiWMJC0BygIYTzEWLWXVHcel8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YZ3XX5ngDz22lPX;
	Fri, 17 Jan 2025 10:27:08 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 335E71A0188;
	Fri, 17 Jan 2025 10:29:33 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 10:29:31 +0800
Message-ID: <58bf9d83-b58d-e5a6-4096-64eb96f3854a@huawei.com>
Date: Fri, 17 Jan 2025 10:29:31 +0800
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
To: Trond Myklebust <trondmy@hammerspace.com>, "horms@kernel.org"
	<horms@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "lilingfeng3@huawei.com"
	<lilingfeng3@huawei.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"tom@talpey.com" <tom@talpey.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"houtao1@huawei.com" <houtao1@huawei.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
 <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
 <642413c4bdbe296db722f0091ffa5190c992eb8e.camel@hammerspace.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <642413c4bdbe296db722f0091ffa5190c992eb8e.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/1/17 4:52, Trond Myklebust 写道:
> On Thu, 2025-01-16 at 19:43 +0800, yangerkun wrote:
>> Hi,
>>
>> Thanks for the patch.
>>
>> Before 39494194f93b("SUNRPC: Fix races with rpc_killall_tasks()",
>> every
>> time we set RPC_TASK_SIGNALLED, when we go through __rpc_execute,
>> this
>> rpc_task will immediate break and exist.
>>
>> However after that, __rpc_execute won't judge RPC_TASK_SIGNNALED, so
>> for
>> the case like you point out below, even after your commit
>> rpc_check_timeout will help break and exist eventually, but this
>> rpc_task has already do some work. I prefer reintroduce judging
>> RPC_TASK_SIGNNALED in __rpc_execute to help exist immediatly.
>>
> 
> Better yet... Let's get rid of the RPC_TASK_SIGNALLED flag altogether
> and just replace
> 
> #define RPC_TASK_SIGNALLED(task) (READ_ONCE(task->tk_rpc_status) == -ERESTARTSYS)

Hi,

Thanks for your reply! Yeah, if all the places where tk_rpc_status is
updated are by calling rpc_task_set_rpc_status, we can use
task->tk_rpc_status == -ERESTARTSYS to determine whether rpc_task is
RPC_TASK_SIGNALLED. But for the case like Li has provided,
__rpc_restart_call won't do this, and will overwrite tk_rpc_status 
unconditionally. This won't be a stable solution. Maybe it's better to
change __rpc_restart_call calling rpc_task_set_rpc_status too? And
__rpc_execute will be enough to help solve this case.

> 
> There is no good reason to try to maintain two completely separate
> sources of truth to describe the same task state.
> 

