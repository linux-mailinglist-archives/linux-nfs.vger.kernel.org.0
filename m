Return-Path: <linux-nfs+bounces-14569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA79B859A5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543EA3A69CF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742330DD0A;
	Thu, 18 Sep 2025 15:26:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7F243951;
	Thu, 18 Sep 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209201; cv=none; b=ksJcEEZIC41k5jAWrkZDAz4TL2fQShqk0CNw4nejgmovZiBp/ZiBmlhi+TTUsutqlHe7KrD6WSQ+rszxn65HATjVh1WSeiBVkC3c6h0s3F3uk5KK4AgVS8LM9ZpmebQ0SrSEohvKjmxr3mxKWAOEvUF6RUW7YfGl7j5hqiwHGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209201; c=relaxed/simple;
	bh=VKAYKLQrxUsJo0+Ph4IN0UIq4I25sBDCBgS1MW9feCM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jQ5S5tOApxQUiF8xrgjpzNAEzn1ehN6vRNMnaA6WmHN4h0gIlXhb8+gezzVDdoagXQI2eInubPDSCySa/GqLUDmbyFf4jPCD9qEVt+ui6iVrLRpUkqaFJmlykFeFwXw0xuDj+0qfcn9vmrcxtAtkokJa7UeoTprQukh16xC00Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cSKHJ6lp3zYQvSJ;
	Thu, 18 Sep 2025 23:26:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8E3131A07BB;
	Thu, 18 Sep 2025 23:26:35 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCXMUCoJMxoqFUQAA--.34287S2;
	Thu, 18 Sep 2025 23:26:33 +0800 (CST)
Message-ID: <e27254b5-22cf-4578-9623-d2d8de54aeca@huaweicloud.com>
Date: Thu, 18 Sep 2025 23:26:31 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Lingfeng <lilingfeng3@huawei.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 Hou Tao <houtao1@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>, leo.lilong@huawei.com
Reply-To: 34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com
From: Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [Question] nfsd: possible reordering between nf->nf_file
 assignment and NFSD_FILE_PENDING clearing?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCXMUCoJMxoqFUQAA--.34287S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw47Aw4xtrWDXFy7Kry8Zrb_yoWxWr13pr
	WYgFyUGrW8J3ykAwnFka1Dur1Y9r4xuF4aqr9Ygws3JryjgrZYvFW8KFyUZFWrGrWkAFyr
	Zr4YgrZrXa1vy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrP
	EfUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

On 2025/9/18 21:57, Li Lingfeng wrote:
> Recently, we encountered a null pointer dereference on a relatively old
> 5.10 kernel that does not include commit c4c649ab413ba ("NFSD: Convert
> filecache to rhltable"), which exhibited the same behavior as described
> in [1]. I was wondering if it might be caused by the reordering between
> the assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING.
> 
> Just to mention, I don't believe the analysis in [1] is entirely accurate,
> since hlist_add_head_rcu includes a write barrier.
> 
> We haven't encountered this issue on newer kernel versions, but the
> assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING appear
> consistent across different versions.
> 
> Our expected outcome should be like this:
>                 T1                                    T2
> nfsd_read
>  nfsd_file_acquire_gc
>   nfsd_file_do_acquire
>    nfsd_file_lookup_locked
>     // get nfsd_file from nfsd_file_rhltable
>                                         nfsd_read
>                                          nfsd_file_acquire_gc
>                                           nfsd_file_do_acquire
>                                            nfsd_file_alloc
>                                             nf->nf_flags // set NFSD_FILE_PENDING
>                                            rhltable_insert // insert to nfsd_file_rhltable
>                                            nf->nf_file = file // set nf_file
>    wait_on_bit
>    // wait NFSD_FILE_PENDING to be cleared
>                                            clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>    // get file after being awakened
>  file = nf->nf_file
> 
> Or like this:
>                 T1                                    T2
> nfsd_read
>  nfsd_file_acquire_gc
>   nfsd_file_do_acquire
>    nfsd_file_lookup_locked
>     // get nfsd_file from nfsd_file_rhltable
>                                         nfsd_read
>                                          nfsd_file_acquire_gc
>                                           nfsd_file_do_acquire
>                                            nfsd_file_alloc
>                                             nf->nf_flags // set NFSD_FILE_PENDING
>                                            rhltable_insert // insert to nfsd_file_rhltable
>                                            nf->nf_file = file // set nf_file
>                                            clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>    // get file directly
>  file = nf->nf_file
> 
> But is it possible that due to reordering, it ends up like this:
>                 T1                                    T2
> nfsd_read
>  nfsd_file_acquire_gc
>   nfsd_file_do_acquire
>    nfsd_file_lookup_locked
>     // get nfsd_file from nfsd_file_rhltable
>                                         nfsd_read
>                                          nfsd_file_acquire_gc
>                                           nfsd_file_do_acquire
>                                            nfsd_file_alloc
>                                             nf->nf_flags // set NFSD_FILE_PENDING
>                                            rhltable_insert // insert to nfsd_file_rhltable
>                                            clear_and_wake_up_bit // clear NFSD_FILE_PENDING
>    // get file directly
>  file = nf->nf_file
>                                            nf->nf_file = file // set nf_file
>  // Null dereference due to uninitialized file pointer.
> 
> [1]: https://lore.kernel.org/all/20230818065507.1280625-1-haydenw.kernel@gmail.com/
> 
> Any suggestion will be appreciated.
> 
> Thanks,
> Lingfeng.
> 

I would like to provide a reproducible test case, though it might not be
entirely precise.

The test case mimics the nfsd_file_acquire workflow and consists of three
threads: main thread, thread1, and thread2, where:

* Thread1 acts as the writer, simulating the open_file workflow.
* Thread2 acts as the reader, simulating the wait_for_construction workflow.
* The main thread runs multiple iterations to ensure that thread1 and thread2
  can execute concurrently in each round.

The test case is as follows:


// writer
static int thread_func1(void *data)
{
	struct foo *nf;
	void *file;

	nf = &global_nf;

	while (!kthread_should_stop()) {
		wait_for_completion(&comp_start1);
		if (kthread_should_stop()) break;

		/* Simulate the open_file process in nfsd_file_acquire() */
		__set_bit(FOO_PENDING, &nf->nf_flags);
		hlist_add_head_rcu(&nf->nf_node, &foo_hashtbl[ghashval].nfb_head);
		file = foo_filp_open();

		/* Test whether the following two lines of code will cause memory reordering */
		nf->nf_file = file;
		clear_bit_unlock(FOO_PENDING, &nf->nf_flags);

		smp_mb__after_atomic();
		wake_up_bit(&nf->nf_flags, FOO_PENDING);

		complete(&comp_end1);
	}
	if (file)
		kfree(file);
	pr_info("thread_func1: exit\n");
	return 0;
}

// reader
static int thread_func2(void *data)
{
	void *file;
	struct foo *nf;

	nf = &global_nf;

	while (!kthread_should_stop()) {
		wait_for_completion(&comp_start2);
		if (kthread_should_stop()) break;

		/* Simulate the wait_for_construction process in nfsd_file_acquire() */
retry:
		rcu_read_lock();
		nf = foo_find_locked(ghashval);
		rcu_read_unlock();
		if (!nf)
			goto retry;

		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
		file = nf->nf_file;
		if (!file)
			WARN_ON(1);
		else
			kfree(file);

		complete(&comp_end2);
	}
	pr_info("thread_func2: exit\n");
	return 0;
}

static int main_thread_func(void *data)
{
	u64 iters = 0;

	while (!kthread_should_stop()) {
		iters++;
		if (iters % 1000000 == 0)
			pr_info("main_thread_func: started %llu iterations\n", iters);

		/* Start both threads */
		complete(&comp_start1);
		complete(&comp_start2);
		/* wait for both to finish */
		wait_for_completion(&comp_end1);
		wait_for_completion(&comp_end2);

		/* Reset completions */
		reinit_completion(&comp_end1);
		reinit_completion(&comp_end2);
		reinit_completion(&comp_start1);
        	reinit_completion(&comp_start2);

		hlist_del_rcu(&global_nf.nf_node);
                global_nf.nf_file = 0;
                global_nf.nf_flags = 0;
	}

	pr_info("main_thread_func: exit\n");

	return 0;
}


I compiled and executed this test case on ARM64. The experimental results show that
after approximately 6,000,000 rounds, the "file is null" warning in thread2 was
triggered, indicating that reordering occurred between the file assignment and flag
clearance operations in thread1.


[107632.795543] My module is being loaded
[107632.800255] Threads started successfully
[107637.656469] main_thread_func: started 1000000 iterations
[107642.520876] main_thread_func: started 2000000 iterations
[107646.919550] main_thread_func: started 3000000 iterations
[107651.545742] main_thread_func: started 4000000 iterations
[107655.577054] main_thread_func: started 5000000 iterations
[107660.507772] main_thread_func: started 6000000 iterations
[107663.212711] ------------[ cut here ]------------
[107663.218265] WARNING: CPU: 26 PID: 10603 at /path/to/nfsd/mod3/order_test.c:142 thread_func2+0xa0/0xe0 [order_test]


When I placed an smp_mb() between 'wait_on_bit' and 'file = nf->nf_file' in thread2,
the warning *no longer* occurred.

		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
+		smp_mb();
		file = nf->nf_file;

I hope this test case proves helpful for investigating the aforementioned memory
reordering issue.

Best regards,
Tengda


