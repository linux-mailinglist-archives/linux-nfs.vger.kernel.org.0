Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2341AB7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 05:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392205AbfFLDcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 23:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392048AbfFLDcQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 23:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A66673084242;
        Wed, 12 Jun 2019 03:32:15 +0000 (UTC)
Received: from [10.72.12.182] (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77EA92CB12;
        Wed, 12 Jun 2019 03:32:14 +0000 (UTC)
Subject: Re: [PATCH] svc_run: make sure only one svc_run loop runs in one
 process
To:     Steve Dickson <SteveD@RedHat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20190409113713.30595-1-xiubli@redhat.com>
 <6a152a89-6de6-f5f2-9c16-5e32fef8cc64@redhat.com>
 <81ba7de8-1301-1ac9-53fb-6e011a592c96@RedHat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d1a7662c-deb1-0fb4-9707-ccfb680ffcbc@redhat.com>
Date:   Wed, 12 Jun 2019 11:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <81ba7de8-1301-1ac9-53fb-6e011a592c96@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 03:32:15 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019/6/11 22:54, Steve Dickson wrote:
> Sorry for the delay....
>
> On 5/15/19 10:55 PM, Xiubo Li wrote:
>> Hey ping.
>>
>> What's the state of this patch and will it make sense here?
> I'm not sure it does make sense.... Shouldn't the mutex lock
> be in the call of svc_run()?

Hi Steve,

Yeah, mutex lock should be in the call of svc_run(). This is exactly 
what I do in this change.

If the libtirpc means to allow only one svc_run() loop in each process, 
so IMO this change is needed. Or if we will allow more than one like the 
glibc version does, so this should be one bug in libtirpc.

Thanks.
BRs
Xiubo


> steved.
>
>> Thanks
>> BRs
>>
>> On 2019/4/9 19:37, xiubli@redhat.com wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> In gluster-block project and there are 2 separate threads, both
>>> of which will run the svc_run loop, this could work well in glibc
>>> version, but in libtirpc we are hitting the random crash and stuck
>>> issues.
>>>
>>> More detail please see:
>>> https://github.com/gluster/gluster-block/pull/182
>>>
>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>> ---
>>>    src/svc_run.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/src/svc_run.c b/src/svc_run.c
>>> index f40314b..b295755 100644
>>> --- a/src/svc_run.c
>>> +++ b/src/svc_run.c
>>> @@ -38,12 +38,17 @@
>>>    #include <string.h>
>>>    #include <unistd.h>
>>>    #include <sys/poll.h>
>>> +#include <syslog.h>
>>> +#include <stdbool.h>
>>>        #include <rpc/rpc.h>
>>>    #include "rpc_com.h"
>>>    #include <sys/select.h>
>>>    +static bool svc_loop_running = false;
>>> +static pthread_mutex_t svc_run_lock = PTHREAD_MUTEX_INITIALIZER;
>>> +
>>>    void
>>>    svc_run()
>>>    {
>>> @@ -51,6 +56,16 @@ svc_run()
>>>      struct pollfd *my_pollfd = NULL;
>>>      int last_max_pollfd = 0;
>>>    +  pthread_mutex_lock(&svc_run_lock);
>>> +  if (svc_loop_running) {
>>> +    pthread_mutex_unlock(&svc_run_lock);
>>> +    syslog (LOG_ERR, "svc_run: svc loop is already running in current process %d", getpid());
>>> +    return;
>>> +  }
>>> +
>>> +  svc_loop_running = true;
>>> +  pthread_mutex_unlock(&svc_run_lock);
>>> +
>>>      for (;;) {
>>>        int max_pollfd = svc_max_pollfd;
>>>        if (max_pollfd == 0 && svc_pollfd == NULL)
>>> @@ -111,4 +126,8 @@ svc_exit()
>>>        svc_pollfd = NULL;
>>>        svc_max_pollfd = 0;
>>>        rwlock_unlock(&svc_fd_lock);
>>> +
>>> +    pthread_mutex_lock(&svc_run_lock);
>>> +    svc_loop_running = false;
>>> +    pthread_mutex_unlock(&svc_run_lock);
>>>    }
>>
>>
>>
>> _______________________________________________
>> Libtirpc-devel mailing list
>> Libtirpc-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/libtirpc-devel


