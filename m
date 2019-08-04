Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A180CDC
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 00:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfHDWIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Aug 2019 18:08:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11347 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDWIQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Aug 2019 18:08:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d47574d0000>; Sun, 04 Aug 2019 15:08:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 04 Aug 2019 15:08:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 04 Aug 2019 15:08:15 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 4 Aug
 2019 22:08:12 +0000
Subject: Re: [PATCH] NFSv4: Fix a potential sleep while atomic in
 nfs4_do_reclaim()
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20190803144042.15187-1-trond.myklebust@hammerspace.com>
 <f90372ee-272b-5bbb-e99a-796bccfa787a@nvidia.com>
 <47e39b00da52c3b873f6f23b420cbc8b3ad9139e.camel@hammerspace.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d128c179-29ab-b57f-ea75-5e5c2c1cd3ce@nvidia.com>
Date:   Sun, 4 Aug 2019 15:08:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <47e39b00da52c3b873f6f23b420cbc8b3ad9139e.camel@hammerspace.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564956496; bh=v677hrxlPeLshJiXI80y6YO+c3xmiuK/L7QylOvvo1Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dPnqfpD8u8y6IjPAHAMTC51Rr0Br9/fCUmIX8x9YTh733HzgdRvelxh6ko0rYziMi
         OAoOjh0ao04QzZsMMlOVCf9nSufsbUY1mam/9mxGMQgDF5f53gxDqKD9gPcWkjfKTz
         jx74VF91zQccu+j5pdEo6NtISA04E1m6dEy2hDanp+bieL+c6qijuJPJhY9NLqLusd
         4EkoZwD/6IYcv48ReELu6AuwxWsc/RI+/qYHQwD3OKe6nWunTfHf9wH3myZ7j8Ej1x
         1Xo1BA3lBI5qVcISlJapcDPIqPA55OyQkBWj2yhjGpSHqRw5UFyvcNYOi9JJN1vDKl
         u86IyiSFn0wLQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8/3/19 3:22 PM, Trond Myklebust wrote:
> On Sat, 2019-08-03 at 12:07 -0700, John Hubbard wrote:
>> On 8/3/19 7:40 AM, Trond Myklebust wrote:
>>> John Hubbard reports seeing the following stack trace:
>>>
>>> nfs4_do_reclaim
>>>    rcu_read_lock /* we are now in_atomic() and must not sleep */
>>>        nfs4_purge_state_owners
>>>            nfs4_free_state_owner
>>>                nfs4_destroy_seqid_counter
>>>                    rpc_destroy_wait_queue
>>>                        cancel_delayed_work_sync
>>>                            __cancel_work_timer
>>>                                __flush_work
>>>                                    start_flush_work
>>>                                        might_sleep:
>>>                                         (kernel/workqueue.c:2975:
>>> BUG)
>>>
>>> The solution is to separate out the freeing of the state owners
>>> from nfs4_purge_state_owners(), and perform that outside the atomic
>>> context.
>>>
>>
>> All better now--this definitely fixes it. I can reboot the server,
>> and
>> of course that backtrace is gone. Then the client mounts hang, so I
>> do
>> a mount -a -o remount, and after about 1 minute, the client mounts
>> start working again, with no indication of problems. I assume that
>> the
>> pause is by design--timing out somewhere, to recover from the server
>> going missing for a while. If so, then all is well.
>>
> 
> Thanks very much for the report, and for testing!
> 
> With regards to the 1 minute delay, I strongly suspect that what you
> are seeing is the NFSv4 "grace period".
> 
> After a NFSv4.x server reboot, the clients are given a certain amount
> of time in which to recover the file open state and lock state that
> they may have held before the reboot. All non-recovery opens, locks and
> all I/O are stopped while this recovery process is happening to ensure
> that locking conflicts do not occur. This ensures that all locks can
> survive server reboots without any loss of atomicity.
> 
> With NFSv4.1 and NFSv4.2, the server can determine when all the clients
> have finished recovering state and end the grace period early, however
> I've recently seen cases where that was not happening. I'm not sure yet
> if that is a real server regression.
> 

Aha, thanks for explaining. It's great to see such refined behavior now
from NFS, definitely enjoying v4! :)


thanks,
-- 
John Hubbard
NVIDIA
