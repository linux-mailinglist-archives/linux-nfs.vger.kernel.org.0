Return-Path: <linux-nfs+bounces-7326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31369A6BE8
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6511F20F07
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB625760;
	Mon, 21 Oct 2024 14:18:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC475A79B
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520288; cv=none; b=GHC558+jikxMakIjqBZJNjkorfAzQk6dkQonjdKPxK/SZCYMPfQlV2QR/UFzKFS4ZRJeWdA7on3+x/qbvV3KGn2uIMO7yfLoYfMZfFeIbAMSkmGfdUq0TymmX+r02FrSKWQBFqBond0VqMiTz/BH6egq5B4yk/YSe3OKjZ3SrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520288; c=relaxed/simple;
	bh=ht9dBNhLasHlnHxfl3EhYgEOnU+IzALykME5fP+p5xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L40Cq9Nq6iBZfX4kQUKQA5t92bLnQo5YdFcNAB2AWDmxrnWu6p/lS/bqW6ebbcItt9HwfjGTo+kUGMqkkPl3S5vYT7FP4ZIIAg7v/d1vD1vCm9wMtUi66oVmcxB8ILoyunUlogGrPSvOVOKt+JE7RwBLUcfx6Ptvpla0qH8Zjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXHQX3mFqzfdPJ;
	Mon, 21 Oct 2024 22:15:32 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id F413B1800DB;
	Mon, 21 Oct 2024 22:18:01 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 22:18:01 +0800
Message-ID: <2e5c039a-fde0-de3c-c15f-5405a5507c8b@huawei.com>
Date: Mon, 21 Oct 2024 22:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in
 nfs4_state_shutdown_net
To: Chuck Lever <chuck.lever@oracle.com>, Yang Erkun
	<yangerkun@huaweicloud.com>
CC: <jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
 <ZxZeZB51iwVgVZt6@tissot.1015granger.net>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <ZxZeZB51iwVgVZt6@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/10/21 22:00, Chuck Lever 写道:
> On Mon, Oct 21, 2024 at 04:25:40PM +0800, Yang Erkun wrote:
>> In the normal case, when we excute `echo 0 > /proc/fs/nfsd/threads`, the
>> function `nfs4_state_destroy_net` in `nfs4_state_shutdown_net` will
>> release all resources related to the hashed `nfs4_client`. If the
>> `nfsd_client_shrinker` is running concurrently, the `expire_client`
>> function will first unhash this client and then destroy it. This can
>> lead to the following warning. Additionally, numerous use-after-free
>> errors may occur as well.
>>
>> nfsd_client_shrinker         echo 0 > /proc/fs/nfsd/threads
>>
>> expire_client                nfsd_shutdown_net
>>    unhash_client                ...
>>                                 nfs4_state_shutdown_net
>>                                   /* won't wait shrinker exit */
>>    /*                             cancel_work(&nn->nfsd_shrinker_work)
>>     * nfsd_file for this          /* won't destroy unhashed client1 */
>>     * client1 still alive         nfs4_state_destroy_net
>>     */
>>
>>                                 nfsd_file_cache_shutdown
>>                                   /* trigger warning */
>>                                   kmem_cache_destroy(nfsd_file_slab)
>>                                   kmem_cache_destroy(nfsd_file_mark_slab)
>>    /* release nfsd_file and mark */
>>    __destroy_client
>>
>> ====================================================================
>> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
>> __kmem_cache_shutdown()
>> --------------------------------------------------------------------
>> CPU: 4 UID: 0 PID: 764 Comm: sh Not tainted 6.12.0-rc3+ #1
>>
>>   dump_stack_lvl+0x53/0x70
>>   slab_err+0xb0/0xf0
>>   __kmem_cache_shutdown+0x15c/0x310
>>   kmem_cache_destroy+0x66/0x160
>>   nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>>   nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>>   nfsd_svc+0x125/0x1e0 [nfsd]
>>   write_threads+0x16a/0x2a0 [nfsd]
>>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>   vfs_write+0x1a5/0x6d0
>>   ksys_write+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> ====================================================================
>> BUG nfsd_file_mark (Tainted: G    B   W         ): Objects remaining
>> nfsd_file_mark on __kmem_cache_shutdown()
>> --------------------------------------------------------------------
>>
>>   dump_stack_lvl+0x53/0x70
>>   slab_err+0xb0/0xf0
>>   __kmem_cache_shutdown+0x15c/0x310
>>   kmem_cache_destroy+0x66/0x160
>>   nfsd_file_cache_shutdown+0xc8/0x210 [nfsd]
>>   nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>>   nfsd_svc+0x125/0x1e0 [nfsd]
>>   write_threads+0x16a/0x2a0 [nfsd]
>>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>>   vfs_write+0x1a5/0x6d0
>>   ksys_write+0xc1/0x160
>>   do_syscall_64+0x5f/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> To resolve this issue, cancel `nfsd_shrinker_work` using synchronous
>> mode in nfs4_state_shutdown_net.
>>
>> Fixes: 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory condition")
> 
> I think like:
> 
> Fixes: 7c24fa225081 ("NFSD: replace delayed_work with work_struct for nfsd_client_shrinker")

Hi,

Thanks a lot for your review! Before this, will this problem exist too
since the cocurrently run between upper two threads can happen too?

> 
> a little better.
> 
> I'm very curious how you stumbled across this one!

Our excellent test team has recently performed a lot of fault injection
tests on nfs/nfsd, which helps us find many nfs/nfsd problems. This
problem is only one of them. There will be some bugfixes for other
problems later.

> 
> 
>> Signed-off-by: Yang Erkun <yangerkun@huaweicloud.com>
>> ---
>>   fs/nfsd/nfs4state.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 56b261608af4..158d67186777 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8684,7 +8684,7 @@ nfs4_state_shutdown_net(struct net *net)
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>   
>>   	shrinker_free(nn->nfsd_client_shrinker);
>> -	cancel_work(&nn->nfsd_shrinker_work);
>> +	cancel_work_sync(&nn->nfsd_shrinker_work);
>>   	cancel_delayed_work_sync(&nn->laundromat_work);
>>   	locks_end_grace(&nn->nfsd4_manager);
>>   
>> -- 
>> 2.39.2
>>
> 

