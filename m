Return-Path: <linux-nfs+bounces-7649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9C9BB734
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F82A1F22528
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878713AD06;
	Mon,  4 Nov 2024 14:09:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753B7083E;
	Mon,  4 Nov 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729345; cv=none; b=WS8h/kwPC7cICQPIGJ2AMVDlVglJYtGiyL1c7EcT9V24QRLO7g/+vc4Yzt+QPd00Od8OIH0I0TtyxaKszvp3/GRMvO/BR995ZZ21Nk0ozb1k7ykkHRnjxWu3+jUJCicGQn0dMXfBV/KtCGMU2CusmO5qVZv6h2eXDyZYDtQvTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729345; c=relaxed/simple;
	bh=7Q0cJe8PItkaL5vd/U4BMNXn/rUVax/BGhq7+6ZuWDc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KoCgNQPC4fUboTJb0XNNopyK1G+4H5O2U5zOXAFxU6DFbVjKlQ2s+Ez0R7WHJaP4NPaKEc12FC+zNB29XMG8yIHXy7/Rz0D1p9+DpDFThz39wt7HWVLPAVS+jnJ593COmdhDio9hxysVQN4k3vPvoFgwdWrFEsMyTATvA/X1qzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XhtcF6L7Kz4f3lXX;
	Mon,  4 Nov 2024 22:08:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A922A1A0568;
	Mon,  4 Nov 2024 22:08:58 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZ41ShnSQtYAw--.31047S3;
	Mon, 04 Nov 2024 22:08:58 +0800 (CST)
Subject: Re: [PATCH] svcrdma: fix miss destroy percpu_counter in
 svc_rdma_proc_init()
To: Chuck Lever <chuck.lever@oracle.com>, Simon Horman <horms@kernel.org>
References: <20241024015520.1448198-1-yebin@huaweicloud.com>
 <20241101115511.GA1845794@kernel.org>
 <ZyUBYpOuHHHc2NoZ@tissot.1015granger.net>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, joel.granados@kernel.org, linux@weissschuh.net,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, yebin10@huawei.com,
 zhangxiaoxu5@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <6728D578.8070809@huaweicloud.com>
Date: Mon, 4 Nov 2024 22:08:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyUBYpOuHHHc2NoZ@tissot.1015granger.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHIoZ41ShnSQtYAw--.31047S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW7Jw1Uuw4rGF4fuF45Wrg_yoWrJrWrpa
	47KFyUtr1qgrn3Cr4avwnrZFy0ya1xXF1fWwn2yr13Z3Wqyr98tF18Ww45GFykurWxXr40
	qFyUWanxua95A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2024/11/2 0:27, Chuck Lever wrote:
> On Fri, Nov 01, 2024 at 11:55:11AM +0000, Simon Horman wrote:
>> On Thu, Oct 24, 2024 at 09:55:20AM +0800, Ye Bin wrote:
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> There's issue as follows:
>>> RPC: Registered rdma transport module.
>>> RPC: Registered rdma backchannel transport module.
>>> RPC: Unregistered rdma transport module.
>>> RPC: Unregistered rdma backchannel transport module.
>>> BUG: unable to handle page fault for address: fffffbfff80c609a
>>> PGD 123fee067 P4D 123fee067 PUD 123fea067 PMD 10c624067 PTE 0
>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>> RIP: 0010:percpu_counter_destroy_many+0xf7/0x2a0
>>> Call Trace:
>>>   <TASK>
>>>   __die+0x1f/0x70
>>>   page_fault_oops+0x2cd/0x860
>>>   spurious_kernel_fault+0x36/0x450
>>>   do_kern_addr_fault+0xca/0x100
>>>   exc_page_fault+0x128/0x150
>>>   asm_exc_page_fault+0x26/0x30
>>>   percpu_counter_destroy_many+0xf7/0x2a0
>>>   mmdrop+0x209/0x350
>>>   finish_task_switch.isra.0+0x481/0x840
>>>   schedule_tail+0xe/0xd0
>>>   ret_from_fork+0x23/0x80
>>>   ret_from_fork_asm+0x1a/0x30
>>>   </TASK>
>>>
>>> If register_sysctl() return NULL, then svc_rdma_proc_cleanup() will not
>>> destroy the percpu counters which init in svc_rdma_proc_init().
>>> If CONFIG_HOTPLUG_CPU is enabled, residual nodes may be in the
>>> 'percpu_counters' list. The above issue may occur once the module is
>>> removed. If the CONFIG_HOTPLUG_CPU configuration is not enabled, memory
>>> leakage occurs.
>>> To solve above issue just destroy all percpu counters when
>>> register_sysctl() return NULL.
>>>
>>> Fixes: 1e7e55731628 ("svcrdma: Restore read and write stats")
>>> Fixes: 22df5a22462e ("svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter")
>>> Fixes: df971cd853c0 ("svcrdma: Convert rdma_stat_recv to a per-CPU counter")
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>   net/sunrpc/xprtrdma/svc_rdma.c | 18 +++++++++++++-----
>>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
>>> index 58ae6ec4f25b..11dff4d58195 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
>>> @@ -233,25 +233,33 @@ static int svc_rdma_proc_init(void)
>>>   
>>>   	rc = percpu_counter_init(&svcrdma_stat_read, 0, GFP_KERNEL);
>>>   	if (rc)
>>> -		goto out_err;
>>> +		goto err;
>>>   	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
>>>   	if (rc)
>>> -		goto out_err;
>>> +		goto err_read;
>>>   	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
>>>   	if (rc)
>>> -		goto out_err;
>>> +		goto err_recv;
>>>   	rc = percpu_counter_init(&svcrdma_stat_write, 0, GFP_KERNEL);
>>>   	if (rc)
>>> -		goto out_err;
>>> +		goto err_sq;
>>>   
>>>   	svcrdma_table_header = register_sysctl("sunrpc/svc_rdma",
>>>   					       svcrdma_parm_table);
>>> +	if (!svcrdma_table_header)
>> Hi Ye Bin,
>>
>> Should rc be set to a negative error value here,
>> as is the case for other error cases above?
>>
>> Flagged by Smatch.
> I can add "rc = -ENOMEM;" to the applied patch.
>
I'm sorry for the late reply. Thank you very much for your revision.
>>> +		goto err_write;
>>> +
>>>   	return 0;
>>>   
>>> -out_err:
>>> +err_write:
>>> +	percpu_counter_destroy(&svcrdma_stat_write);
>>> +err_sq:
>>>   	percpu_counter_destroy(&svcrdma_stat_sq_starve);
>>> +err_recv:
>>>   	percpu_counter_destroy(&svcrdma_stat_recv);
>>> +err_read:
>>>   	percpu_counter_destroy(&svcrdma_stat_read);
>>> +err:
>>>   	return rc;
>>>   }
>>>   
>>> -- 
>>> 2.34.1
>>>


