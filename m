Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87561100248
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfKRKVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 05:21:51 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1686 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKRKVv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 05:21:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd270bf0000>; Mon, 18 Nov 2019 02:21:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 02:21:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 02:21:50 -0800
Received: from [10.26.11.241] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 10:21:49 +0000
Subject: Re: [PATCH] SUNRPC: Avoid RPC delays when exiting suspend
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Trond Myklebust <trondmy@gmail.com>
CC:     <linux-nfs@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
 <20191105142133.28741-1-trond.myklebust@hammerspace.com>
 <3f536791-dbd1-cc9a-c88a-ddc26dd57c00@nvidia.com>
Message-ID: <2e0bdb35-a033-55e4-464e-97f3fbb2090c@nvidia.com>
Date:   Mon, 18 Nov 2019 10:21:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3f536791-dbd1-cc9a-c88a-ddc26dd57c00@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574072511; bh=mlJ+00JNu6t9wqpwYKUVITU7CEF2Q12woYSyqRytaFc=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EVBcB8wXkWvgcsv1Osh1ZQq4yh1TJNHkRlYBWHR8JG3bOA47s2Kj7OUXUFn5FdqVX
         KWzhPq2slFXotno/7MckEQ0cNo5sOEI/8l+B68HDz2h4Ky2Oi/MybaCu0bl0P37FN8
         rp6ag8EcPvnqlDTw2x1mLho0AgJPIC7IO1QsbsdX/Di+8uP51IdkXzYA29H/7mRSf9
         Ei5kZQ3qY5xKAxmUt4mKCUVst4Yfs7YcYP9DrJgwuLTZhAhQUmg1caZuXX/X8TNM/a
         4InzCM0WTBzHlhQR77gPCO7MaSgR2Whb7PX8ncYAotNuWXOeU66JobJDvscIT8So0k
         XvIXn2AqZL3Cg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On 06/11/2019 11:15, Jon Hunter wrote:
> 
> On 05/11/2019 14:21, Trond Myklebust wrote:
>> Jon Hunter: "I have been tracking down another suspend/NFS related
>> issue where again I am seeing random delays exiting suspend. The delays
>> can be up to a couple minutes in the worst case and this is causing a
>> suspend test we have to fail."
>>
>> Change the use of a deferrable work to a standard delayed one.
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 7e0a0e38fcfea ("SUNRPC: Replace the queue timer with a delayed work function")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  net/sunrpc/sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index 360afe153193..987c4b1f0b17 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -260,7 +260,7 @@ static void __rpc_init_priority_wait_queue(struct rpc_wait_queue *queue, const c
>>  	rpc_reset_waitqueue_priority(queue);
>>  	queue->qlen = 0;
>>  	queue->timer_list.expires = 0;
>> -	INIT_DEFERRABLE_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
>> +	INIT_DELAYED_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
>>  	INIT_LIST_HEAD(&queue->timer_list.list);
>>  	rpc_assign_waitqueue_name(queue, qname);
>>  }
> 
> Thanks!
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

I see this is now applied in -next, but I am seeing the failures on
mainline. Any chance we could still get this into v5.4?

Cheers
Jon

-- 
nvpublic
