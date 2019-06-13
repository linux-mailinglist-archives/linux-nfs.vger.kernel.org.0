Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4744744
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfFMQ6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 12:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfFMAuG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 20:50:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5420B30860A7;
        Thu, 13 Jun 2019 00:50:05 +0000 (UTC)
Received: from [10.72.12.182] (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 741745DEDF;
        Thu, 13 Jun 2019 00:50:03 +0000 (UTC)
Subject: Re: [PATCH] svc_run: make sure only one svc_run loop runs in one
 process
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Steve Dickson <SteveD@redhat.com>,
        libtirpc-devel@lists.sourceforge.net,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20190409113713.30595-1-xiubli@redhat.com>
 <6a152a89-6de6-f5f2-9c16-5e32fef8cc64@redhat.com>
 <81ba7de8-1301-1ac9-53fb-6e011a592c96@RedHat.com>
 <d1a7662c-deb1-0fb4-9707-ccfb680ffcbc@redhat.com>
 <CAN-5tyFTR+bu9KTBHpLVdpbXEtXsCc2yLRcaPfMe+u0NKYmHBQ@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <ad70399b-9a77-9f53-061b-a1ef5eafce18@redhat.com>
Date:   Thu, 13 Jun 2019 08:50:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFTR+bu9KTBHpLVdpbXEtXsCc2yLRcaPfMe+u0NKYmHBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 00:50:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019/6/13 0:46, Olga Kornievskaia wrote:
> On Wed, Jun 12, 2019 at 3:45 AM Xiubo Li <xiubli@redhat.com> wrote:
>> On 2019/6/11 22:54, Steve Dickson wrote:
>>> Sorry for the delay....
>>>
>>> On 5/15/19 10:55 PM, Xiubo Li wrote:
>>>> Hey ping.
>>>>
>>>> What's the state of this patch and will it make sense here?
>>> I'm not sure it does make sense.... Shouldn't the mutex lock
>>> be in the call of svc_run()?
>> Hi Steve,
>>
>> Yeah, mutex lock should be in the call of svc_run(). This is exactly
>> what I do in this change.
>>
>> If the libtirpc means to allow only one svc_run() loop in each process,
>> so IMO this change is needed. Or if we will allow more than one like the
>> glibc version does, so this should be one bug in libtirpc.
> Has there been effort into made into investigating what's causing the
> crashes?

Before as our investigation and test, it was that if we ran two 
svc_run() loop in one process, such as in pthread1 and pthread2, it 
seems that pthread1 will receive the RPC connection/request which should 
be handled by pthread2's svc_run loop and vice versa.

Then we can see many random crash for tons of different reasons, like 
use after free and double free..., and almost every time the crash will 
randomly in different places and different libraries, such as the 
libtirpc, glusterfs and gluster-block...

After switching to multi processes instead of running two svc_run loop 
in multi pthreads, this issue has been resolved we didn't dig it further.


>   We perhaps should make an effort to see if svc_run() is
> thread-safe and examine which functions it uses and which might not be
> thread safe. You might be able to allow greater parallelism then 1
> thread in a svc_run() function by just making some not-thread safe
> functions wrapped in pthread locks.

Yeah, make sense.

Thanks.

BRs


>> Thanks.
>> BRs
>> Xiubo
>>
>>
>>> steved.
>>>
>>>> Thanks
>>>> BRs
>>>>
>>>> On 2019/4/9 19:37, xiubli@redhat.com wrote:
>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>
>>>>> In gluster-block project and there are 2 separate threads, both
>>>>> of which will run the svc_run loop, this could work well in glibc
>>>>> version, but in libtirpc we are hitting the random crash and stuck
>>>>> issues.
>>>>>
>>>>> More detail please see:
>>>>> https://github.com/gluster/gluster-block/pull/182
>>>>>
>>>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>>>> ---
>>>>>     src/svc_run.c | 19 +++++++++++++++++++
>>>>>     1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/src/svc_run.c b/src/svc_run.c
>>>>> index f40314b..b295755 100644
>>>>> --- a/src/svc_run.c
>>>>> +++ b/src/svc_run.c
>>>>> @@ -38,12 +38,17 @@
>>>>>     #include <string.h>
>>>>>     #include <unistd.h>
>>>>>     #include <sys/poll.h>
>>>>> +#include <syslog.h>
>>>>> +#include <stdbool.h>
>>>>>         #include <rpc/rpc.h>
>>>>>     #include "rpc_com.h"
>>>>>     #include <sys/select.h>
>>>>>     +static bool svc_loop_running = false;
>>>>> +static pthread_mutex_t svc_run_lock = PTHREAD_MUTEX_INITIALIZER;
>>>>> +
>>>>>     void
>>>>>     svc_run()
>>>>>     {
>>>>> @@ -51,6 +56,16 @@ svc_run()
>>>>>       struct pollfd *my_pollfd = NULL;
>>>>>       int last_max_pollfd = 0;
>>>>>     +  pthread_mutex_lock(&svc_run_lock);
>>>>> +  if (svc_loop_running) {
>>>>> +    pthread_mutex_unlock(&svc_run_lock);
>>>>> +    syslog (LOG_ERR, "svc_run: svc loop is already running in current process %d", getpid());
>>>>> +    return;
>>>>> +  }
>>>>> +
>>>>> +  svc_loop_running = true;
>>>>> +  pthread_mutex_unlock(&svc_run_lock);
>>>>> +
>>>>>       for (;;) {
>>>>>         int max_pollfd = svc_max_pollfd;
>>>>>         if (max_pollfd == 0 && svc_pollfd == NULL)
>>>>> @@ -111,4 +126,8 @@ svc_exit()
>>>>>         svc_pollfd = NULL;
>>>>>         svc_max_pollfd = 0;
>>>>>         rwlock_unlock(&svc_fd_lock);
>>>>> +
>>>>> +    pthread_mutex_lock(&svc_run_lock);
>>>>> +    svc_loop_running = false;
>>>>> +    pthread_mutex_unlock(&svc_run_lock);
>>>>>     }
>>>>
>>>>
>>>> _______________________________________________
>>>> Libtirpc-devel mailing list
>>>> Libtirpc-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/libtirpc-devel
>>

