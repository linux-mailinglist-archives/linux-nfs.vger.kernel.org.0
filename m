Return-Path: <linux-nfs+bounces-10493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98FA540C8
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA143AEEE5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58718DF89;
	Thu,  6 Mar 2025 02:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8BBE46;
	Thu,  6 Mar 2025 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228842; cv=none; b=K20b3pv5bWoZtQty4CCRe8G/KJk9eOnF3twVh1FHPfz9Hpxfl2AS6BrSqJ3MV4fvIFBmYlFFSLDtb+4Etf78PUndlzUiIlkj8mMK+7itncZ+E6kWgUJpWFt1mAiKCpOUeFy7KVRL+05RRMhURG2jJM0xZsflt/8YXM+/0bjZ/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228842; c=relaxed/simple;
	bh=ONtAi5Sqk5d11lgQN9ofiQ1SwRaBMpb8UpGrlN+B3Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRfvxaY7/04IY01jcuqgSP/S6Z+sykL07mnR86Uop0ZZHoh2PFnh9mTHhvUhAPGP8FE2dNDVpMAWh/tkvOcl8U+Uitlswy4nCKhrMrbghoNN8mjsk8Qqwt9OeJQdASvgRB4eY+T4BB7MwI2YPMuu/QRLl277HE/wMD4oPrVqmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z7YYR135vz4f3lW5;
	Thu,  6 Mar 2025 10:40:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB4DC1A058E;
	Thu,  6 Mar 2025 10:40:34 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl8gC8lnRDSxFg--.7098S3;
	Thu, 06 Mar 2025 10:40:34 +0800 (CST)
Message-ID: <355c8355-a6bc-181f-73e7-1baf7749f984@huaweicloud.com>
Date: Thu, 6 Mar 2025 10:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Bug report] NULL pointer dereference in frwr_unmap_sync()
To: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nfs@vger.kernel.org, trondmy@hammerspace.com, sagi@grimberg.me,
 cel@kernel.org, "wanghai (M)" <wanghai38@huawei.com>, yanhaitao2@huawei.com,
 chengjike.cheng@huawei.com, dingming09@huawei.com
References: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
 <314f60a8-4b0d-45f9-87f4-5a4757d34aea@oracle.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <314f60a8-4b0d-45f9-87f4-5a4757d34aea@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl8gC8lnRDSxFg--.7098S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWkCw1kuw18uFy5Cr4rKrg_yoW8tw15pF
	yktrZ8GrW8Crn5Xr4DZ3WkAa40vFsYy3ZxJr1kGF97AF4DJry2qr4UWFyvgasrGr4xGa1r
	WF1UXa13ur93Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
	AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
	8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/3/5 22:02, Chuck Lever 写道:
> On 3/4/25 9:43 PM, Li Nan wrote:
>> We found a following problem in kernel 5.10, and the same problem should
>> exist in mainline:
>>
>> During NFS mount using 'soft' option over RoCE network, we observed kernel
>> crash with below trace when network issues occur (congestion/disconnect):
>>    nfs: server 10.10.253.211 not responding, timed out
>>    BUG: kernel NULL pointer dereference, address: 00000000000000a0
>>    RIP: 0010:frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>    Call Trace:
>>     ? __die_body.cold+0x8/0xd
>>     ? no_context+0x155/0x230
>>     ? __bad_area_nosemaphore+0x52/0x1a0
>>     ? exc_page_fault+0x2dc/0x550
>>     ? asm_exc_page_fault+0x1e/0x30
>>     ? frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>     xprt_release+0x9e/0x1a0 [sunrpc]
>>     rpc_release_resources_task+0xe/0x50 [sunrpc]
>>     rpc_release_task+0x19/0xa0 [sunrpc]
>>     rpc_async_schedule+0x29/0x40 [sunrpc]
>>     process_one_work+0x1b2/0x350
>>     worker_thread+0x49/0x310
>>     ? rescuer_thread+0x380/0x380
>>     kthread+0xfb/0x140
>>
>> Problem analysis:
>> The crash happens in frwr_unmap_sync() when accessing req->rl_registered
>> list, caused by either NULL pointer or accessing freed MR resources.
>> There's a race condition between:
>> T1
>> __ib_process_cq
>>   wc->wr_cqe->done (frwr_wc_localinv)
>>    rpcrdma_flush_disconnect
>>     rpcrdma_force_disconnect
>>      xprt_force_disconnect
>>       xprt_autoclose
>>        xprt_rdma_close
>>         rpcrdma_xprt_disconnect
>>          rpcrdma_reqs_reset
>>           frwr_reset
>>            rpcrdma_mr_pop(&req->rl_registered)
>> T2
>> rpc_async_schedule
>>   rpc_release_task
>>    rpc_release_resources_task
>>     xprt_release
>>      xprt_rdma_free
>>       frwr_unmap_sync
>>        rpcrdma_mr_pop(&req->rl_registered)
>>                     
>> This problem also exists in function rpcrdma_mrs_destroy().
>>
> 
> Dai, is this the same as the system test problem you've been looking at?
> 

Thank you for looking into it. Is there a patch that needs to be tested? We
are happy to help with the testing.

-- 
Thanks,
Nan


