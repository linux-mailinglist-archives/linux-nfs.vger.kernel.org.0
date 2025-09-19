Return-Path: <linux-nfs+bounces-14591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3930B87924
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 03:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B5F3A5989
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524A1DDC2C;
	Fri, 19 Sep 2025 01:11:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42D273F9;
	Fri, 19 Sep 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244314; cv=none; b=sJtp1qHXdthJyo2XjTvvwqJFls5mSfsnQAyr9R009TnQNvL7STVYv17kGh+FK6tTyEzfMXmOwFjvX68P4zbr0ZNYje2rCMDUZuKtaJ8ghEHB6dxGcb53UQhHTG8Fq5MJLrIkIRV0l9YUA+2ZsOl5jITc+Zh2chZsdllz/5nx+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244314; c=relaxed/simple;
	bh=BH6kj5AUGNTEtsGG4OGlsF8iFmoT1YT9LJrDxQP9J/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RGVIiyuL6MELaEktQ7u/cGJhqK+bVsinmDWe8TjPOhuR/Yny/smw8kK9RcERr4PrO8CZkT3A1IWQSwMnUegZ/rCI2inScJIqH6v8h286AmDM/cpH6BK94FzvvFVKXCGfAaFRDvx+lsKPOlpFV/2SCMSwrfQQXLLMzdoj6iyn6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cSZ9B1SPwzRk6H;
	Fri, 19 Sep 2025 09:07:10 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 02CFC180087;
	Fri, 19 Sep 2025 09:11:48 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 09:11:46 +0800
Message-ID: <764628ca-e047-4309-8b51-0a740af5cc68@huawei.com>
Date: Fri, 19 Sep 2025 09:11:46 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [Question] nfsd: possible reordering between nf->nf_file
 assignment and NFSD_FILE_PENDING clearing?
To: NeilBrown <neil@brown.name>,
	<34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Tom
 Talpey <tom@talpey.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, yangerkun <yangerkun@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "yukuai (C)"
	<yukuai3@huawei.com>, <leo.lilong@huawei.com>
References: <e27254b5-22cf-4578-9623-d2d8de54aeca@huaweicloud.com>
 <175823636555.1696783.2385271688831175643@noble.neil.brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <175823636555.1696783.2385271688831175643@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200013.china.huawei.com (7.202.194.25)


在 2025/9/19 6:59, NeilBrown 写道:
> On Fri, 19 Sep 2025, 34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com wrote:
>> Hi,
> You probably need to backport
>
> Commit: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")
>
> NeilBrown
>
Thank you for the reply, we will try it.

Thanks,
Lingfeng

>> On 2025/9/18 21:57, Li Lingfeng wrote:
>>> Recently, we encountered a null pointer dereference on a relatively old
>>> 5.10 kernel that does not include commit c4c649ab413ba ("NFSD: Convert
>>> filecache to rhltable"), which exhibited the same behavior as described
>>> in [1]. I was wondering if it might be caused by the reordering between
>>> the assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING.
>>>
>>> Just to mention, I don't believe the analysis in [1] is entirely accurate,
>>> since hlist_add_head_rcu includes a write barrier.
>>>
>>> We haven't encountered this issue on newer kernel versions, but the
>>> assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING appear
>>> consistent across different versions.
>>>
>>> Our expected outcome should be like this:
>>>                  T1                                    T2
>>> nfsd_read
>>>   nfsd_file_acquire_gc
>>>    nfsd_file_do_acquire
>>>     nfsd_file_lookup_locked
>>>      // get nfsd_file from nfsd_file_rhltable
>>>                                          nfsd_read
>>>                                           nfsd_file_acquire_gc
>>>                                            nfsd_file_do_acquire
>>>                                             nfsd_file_alloc
>>>                                              nf->nf_flags // set NFSD_FILE_PENDING
>>>                                             rhltable_insert // insert to nfsd_file_rhltable
>>>                                             nf->nf_file = file // set nf_file
>>>     wait_on_bit
>>>     // wait NFSD_FILE_PENDING to be cleared
>>>                                             clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>>>     // get file after being awakened
>>>   file = nf->nf_file
>>>
>>> Or like this:
>>>                  T1                                    T2
>>> nfsd_read
>>>   nfsd_file_acquire_gc
>>>    nfsd_file_do_acquire
>>>     nfsd_file_lookup_locked
>>>      // get nfsd_file from nfsd_file_rhltable
>>>                                          nfsd_read
>>>                                           nfsd_file_acquire_gc
>>>                                            nfsd_file_do_acquire
>>>                                             nfsd_file_alloc
>>>                                              nf->nf_flags // set NFSD_FILE_PENDING
>>>                                             rhltable_insert // insert to nfsd_file_rhltable
>>>                                             nf->nf_file = file // set nf_file
>>>                                             clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>>>     // get file directly
>>>   file = nf->nf_file
>>>
>>> But is it possible that due to reordering, it ends up like this:
>>>                  T1                                    T2
>>> nfsd_read
>>>   nfsd_file_acquire_gc
>>>    nfsd_file_do_acquire
>>>     nfsd_file_lookup_locked
>>>      // get nfsd_file from nfsd_file_rhltable
>>>                                          nfsd_read
>>>                                           nfsd_file_acquire_gc
>>>                                            nfsd_file_do_acquire
>>>                                             nfsd_file_alloc
>>>                                              nf->nf_flags // set NFSD_FILE_PENDING
>>>                                             rhltable_insert // insert to nfsd_file_rhltable
>>>                                             clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>>>     // get file directly
>>>   file = nf->nf_file
>>>                                             nf->nf_file = file // set nf_file
>>>   // Null dereference due to uninitialized file pointer.
>>>
>>> [1]: https://lore.kernel.org/all/20230818065507.1280625-1-haydenw.kernel@gmail.com/
>>>
>>> Any suggestion will be appreciated.
>>>
>>> Thanks,
>>> Lingfeng.
>>>
>> I would like to provide a reproducible test case, though it might not be
>> entirely precise.
>>
>> The test case mimics the nfsd_file_acquire workflow and consists of three
>> threads: main thread, thread1, and thread2, where:
>>
>> * Thread1 acts as the writer, simulating the open_file workflow.
>> * Thread2 acts as the reader, simulating the wait_for_construction workflow.
>> * The main thread runs multiple iterations to ensure that thread1 and thread2
>>    can execute concurrently in each round.
>>
>> The test case is as follows:
>>
>>
>> // writer
>> static int thread_func1(void *data)
>> {
>> 	struct foo *nf;
>> 	void *file;
>>
>> 	nf = &global_nf;
>>
>> 	while (!kthread_should_stop()) {
>> 		wait_for_completion(&comp_start1);
>> 		if (kthread_should_stop()) break;
>>
>> 		/* Simulate the open_file process in nfsd_file_acquire() */
>> 		__set_bit(FOO_PENDING, &nf->nf_flags);
>> 		hlist_add_head_rcu(&nf->nf_node, &foo_hashtbl[ghashval].nfb_head);
>> 		file = foo_filp_open();
>>
>> 		/* Test whether the following two lines of code will cause memory reordering */
>> 		nf->nf_file = file;
>> 		clear_bit_unlock(FOO_PENDING, &nf->nf_flags);
>>
>> 		smp_mb__after_atomic();
>> 		wake_up_bit(&nf->nf_flags, FOO_PENDING);
>>
>> 		complete(&comp_end1);
>> 	}
>> 	if (file)
>> 		kfree(file);
>> 	pr_info("thread_func1: exit\n");
>> 	return 0;
>> }
>>
>> // reader
>> static int thread_func2(void *data)
>> {
>> 	void *file;
>> 	struct foo *nf;
>>
>> 	nf = &global_nf;
>>
>> 	while (!kthread_should_stop()) {
>> 		wait_for_completion(&comp_start2);
>> 		if (kthread_should_stop()) break;
>>
>> 		/* Simulate the wait_for_construction process in nfsd_file_acquire() */
>> retry:
>> 		rcu_read_lock();
>> 		nf = foo_find_locked(ghashval);
>> 		rcu_read_unlock();
>> 		if (!nf)
>> 			goto retry;
>>
>> 		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
>> 		file = nf->nf_file;
>> 		if (!file)
>> 			WARN_ON(1);
>> 		else
>> 			kfree(file);
>>
>> 		complete(&comp_end2);
>> 	}
>> 	pr_info("thread_func2: exit\n");
>> 	return 0;
>> }
>>
>> static int main_thread_func(void *data)
>> {
>> 	u64 iters = 0;
>>
>> 	while (!kthread_should_stop()) {
>> 		iters++;
>> 		if (iters % 1000000 == 0)
>> 			pr_info("main_thread_func: started %llu iterations\n", iters);
>>
>> 		/* Start both threads */
>> 		complete(&comp_start1);
>> 		complete(&comp_start2);
>> 		/* wait for both to finish */
>> 		wait_for_completion(&comp_end1);
>> 		wait_for_completion(&comp_end2);
>>
>> 		/* Reset completions */
>> 		reinit_completion(&comp_end1);
>> 		reinit_completion(&comp_end2);
>> 		reinit_completion(&comp_start1);
>>          	reinit_completion(&comp_start2);
>>
>> 		hlist_del_rcu(&global_nf.nf_node);
>>                  global_nf.nf_file = 0;
>>                  global_nf.nf_flags = 0;
>> 	}
>>
>> 	pr_info("main_thread_func: exit\n");
>>
>> 	return 0;
>> }
>>
>>
>> I compiled and executed this test case on ARM64. The experimental results show that
>> after approximately 6,000,000 rounds, the "file is null" warning in thread2 was
>> triggered, indicating that reordering occurred between the file assignment and flag
>> clearance operations in thread1.
>>
>>
>> [107632.795543] My module is being loaded
>> [107632.800255] Threads started successfully
>> [107637.656469] main_thread_func: started 1000000 iterations
>> [107642.520876] main_thread_func: started 2000000 iterations
>> [107646.919550] main_thread_func: started 3000000 iterations
>> [107651.545742] main_thread_func: started 4000000 iterations
>> [107655.577054] main_thread_func: started 5000000 iterations
>> [107660.507772] main_thread_func: started 6000000 iterations
>> [107663.212711] ------------[ cut here ]------------
>> [107663.218265] WARNING: CPU: 26 PID: 10603 at /path/to/nfsd/mod3/order_test.c:142 thread_func2+0xa0/0xe0 [order_test]
>>
>>
>> When I placed an smp_mb() between 'wait_on_bit' and 'file = nf->nf_file' in thread2,
>> the warning *no longer* occurred.
>>
>> 		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
>> +		smp_mb();
>> 		file = nf->nf_file;
>>
>> I hope this test case proves helpful for investigating the aforementioned memory
>> reordering issue.
>>
>> Best regards,
>> Tengda
>>
>>

