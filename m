Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA45551F9B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiFTPCG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiFTPBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:01:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A91836C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 07:29:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3IP5-0007lP-Mu; Mon, 20 Jun 2022 16:29:23 +0200
Message-ID: <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
Date:   Mon, 20 Jun 2022 16:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
 <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
 <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655735369;82cea1f5;
X-HE-SMSGID: 1o3IP5-0007lP-Mu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20.06.22 16:11, Chuck Lever III wrote:
> 
> 
>> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>
>> Dennis, Chuck, I have below issue on the list of tracked regressions.
>> What's the status? Has any progress been made? Or is this not really a
>> regression and can be ignored?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>
>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>> reports and sometimes miss something important when writing mails like
>> this. If that's the case here, don't hesitate to tell me in a public
>> reply, it's in everyone's interest to set the public record straight.
>>
>> #regzbot poke
>> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=215890
> 
> The above link points to an Apple trackpad bug.

Yeah, I know, sorry, should have mentioned: either I or my bot did
something stupid and associated that report with this regression, that's
why I deassociated it with the "unlink" command.

> The bug described all the way at the bottom was the origin problem
> report. I believe this is an NFS client issue. We are waiting for
> a response from the NFS client maintainers to help Dennis track
> this down.

Many thx for the status update. Can anything be done to speed things up?
This is taken quite a long time already -- way longer that outlined in
"Prioritize work on fixing regressions" here:
https://docs.kernel.org/process/handling-regressions.html

Ciao, Thorsten

>> On 17.05.22 16:02, Chuck Lever III wrote:
>>>> On May 17, 2022, at 9:40 AM, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>
>>>> On 5/13/22 10:59 AM, Chuck Lever III wrote:
>>>>>>>
>>>>>>> Ran a test with -rc6 and this time see a hung task trace on the
>>>>>>> console as well
>>>>>>> as an NFS RPC error.
>>>>>>>
>>>>>>> [32719.991175] nfs: RPC call returned error 512
>>>>>>> .
>>>>>>> .
>>>>>>> .
>>>>>>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>>>>>>> than 122 seconds.
>>>>>>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>>>>>>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>>>>> disables this
>>>>>>> message.
>>>>>>> [32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141
>>>>>>> ppid:     2
>>>>>>> flags:0x00004000
>>>>>>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>>>> [32933.324524] Call Trace:
>>>>>>> [32933.327347]  <TASK>
>>>>>>> [32933.329785]  __schedule+0x3dd/0x970
>>>>>>> [32933.333783]  schedule+0x41/0xa0
>>>>>>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>>>>>>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>>>>>>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>>>>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>>>>>>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>>>>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>>>>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>>>>>>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>>>>>>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>>>>>>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>>> [32933.391391]  process_one_work+0x1c8/0x390
>>>>>>> [32933.395975]  worker_thread+0x30/0x360
>>>>>>> [32933.400162]  ? process_one_work+0x390/0x390
>>>>>>> [32933.404931]  kthread+0xd9/0x100
>>>>>>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [32933.413984]  ret_from_fork+0x22/0x30
>>>>>>> [32933.418074]  </TASK>
>>>>>>>
>>>>>>> The call trace shows up again at 245, 368, and 491 seconds. Same
>>>>>>> task, same trace.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> That's very helpful. The above trace suggests that the RDMA code is
>>>>>> leaking a call to xprt_unpin_rqst().
>>>>>
>>>>> IMHO this is unlikely to be related to the performance
>>>>> regression -- none of this code has changed in the past 5
>>>>> kernel releases. Could be a different issue, though.
>>>>>
>>>>> As is often the case in these situations, the INFO trace
>>>>> above happens long after the issue that caused the missing
>>>>> unpin. So... unless Dennis has a reproducer that can trigger
>>>>> the issue frequently, I don't think there's much that can
>>>>> be extracted from that.
>>>>
>>>> To be fair, I've only seen this one time and have had the performance regression
>>>> since -rc1.
>>>>
>>>>> Also "nfs: RPC call returned error 512" suggests someone
>>>>> hit ^C at some point. It's always possible that the
>>>>> xprt_rdma_free() path is missing an unpin. But again,
>>>>> that's not likely to be related to performance.
>>>>
>>>> I've checked our test code and after 10 minutes it does give up trying to do the
>>>> NFS copies and aborts (SIG_INT) the test.
>>>
>>> After sleeping on it, I'm fairly certain the stack trace
>>> above is a result of a gap in how xprtrdma handles a
>>> signaled RPC.
>>>
>>> Signal handling in that code is pretty hard to test, so not
>>> surprising that there's a lingering bug or two. One idea I
>>> had was to add a fault injector in the RPC scheduler to
>>> throw signals at random. I think it can be done without
>>> perturbing the hot path. Maybe I'll post an RFC patch.
>>>
>>>
>>>> So in all my tests and bisect attempts it seems the possibility to hit a slow
>>>> NFS operation that hangs for minutes has been possible for quite some time.
>>>> However in 5.18 it gets much worse.
>>>>
>>>> Any likely places I should add traces to try and find out what's stuck or taking
>>>> time?
>>>
>>> There's been a lot of churn in that area in recent releases,
>>> so I'm not familiar with the existing tracepoints. Maybe
>>> Ben or Trond could provide some guidance.
>>
> 
> --
> Chuck Lever
> 
> 
> 
> 
