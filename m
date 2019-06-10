Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A33B7BC
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbfFJOuk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 10:50:40 -0400
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:58548
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390122AbfFJOuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jun 2019 10:50:39 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aLd8hbTzLd9U0aLd8hA472; Mon, 10 Jun 2019 07:50:38 -0700
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <9E0019E1-1C1B-465C-B2BF-76372029ABD8@talpey.com>
 <955993A4-0626-4819-BC6F-306A50E2E048@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <4b05cdf7-2c2d-366f-3a29-1034bfec2941@talpey.com>
Date:   Mon, 10 Jun 2019 10:50:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <955993A4-0626-4819-BC6F-306A50E2E048@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIo8/2pz+e9fabIO+IuUP3I1YHCK/5+0EX6gw6vq52ousb+NvHacvP8GTldpDzdlWA0bl71jUts1IfC3x+EZsboddBCD0WbROwVEqbaJzPjs7y4OPyjX
 Vh94xpo2BFs0kcSvxdhcXCFvh8HHnz1fJgDtYajNis2l5wFYJ1CXLv+PSZOhA9zYB6TFHPgzepCetI3JhJglkqQT7pxpQNP4uicTQe1JHdJGnuWDXgBIvy/w
 q3ehekPTCjrL9zSiW6j/Fw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2019 1:25 PM, Chuck Lever wrote:
> Hi Tom-
> 
>> On Jun 5, 2019, at 12:43 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/5/2019 8:15 AM, Chuck Lever wrote:
>>> The DRC is not working at all after an RPC/RDMA transport reconnect.
>>> The problem is that the new connection uses a different source port,
>>> which defeats DRC hash.
>>>
>>> An NFS/RDMA client's source port is meaningless for RDMA transports.
>>> The transport layer typically sets the source port value on the
>>> connection to a random ephemeral port. The server already ignores it
>>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
>>> client's source port on RDMA transports").
>>
>> Where does the entropy come from, then, for the server to not
>> match other requests from other mount points on this same client?
> 
> The first ~200 bytes of each RPC Call message.
> 
> [ Note that this has some fun ramifications for calls with small
> RPC headers that use Read chunks. ]

Ok, good to know. I forgot that the Linux server implemented this.
I have some concerns abot it, honestly, and it's important to remember
that it's not the same on all servers. But for the problem you're
fixing, it's ok I guess and certainly better than today. Still, the
errors are goingto be completely silent, and can lead to data being
corrupted. Well, welcome to the world of NFSv3.

>> Any time an XID happens to match on a second mount, it will trigger
>> incorrect server processing, won't it?
> 
> Not a risk for clients that use only a single transport per
> client-server pair.

I just want to interject here that this is completely irrelevant.
The server can't know what these clients are doing, or expecting.
One case that might work is not any kind of evidence, and is not
a workaround.

>> And since RDMA is capable of
>> such high IOPS, the likelihood seems rather high.
> 
> Only when the server's durable storage is slow enough to cause
> some RPC requests to have extremely high latency.
> 
> And, most clients use an atomic counter for their XIDs, so they
> are also likely to wrap that counter over some long-pending RPC
> request.
> 
> The only real answer here is NFSv4 sessions.
> 
> 
>> Missing the cache
>> might actually be safer than hitting, in this case.
> 
> Remember that _any_ retransmit on RPC/RDMA requires a fresh
> connection, that includes NFSv3, to reset credit accounting
> due to the lost half of the RPC Call/Reply pair.
> 
> I can very quickly reproduce bad (non-deterministic) behavior
> by running a software build on an NFSv3 on RDMA mount point
> with disconnect injection. If the DRC issue is addressed, the
> software build runs to completion.

Ok, good. But I have a better test.

In the Connectathon suite, there's a "Special" test called "nfsidem".
I wrote this test in, like, 1989 so I remember it :-)

This test performs all the non-idempotent NFv3 operations in a loop,
and each loop element depends on the previous one, so if there's
any failure, the test imemdiately bombs.

Nobody seems to understand it, usually when it gets run people will
run it without injecting errors, and it "passes" so they decide
everything is ok.

So my suggestion is to run your flakeway packet-drop harness while
running nfsidem in a huge loop (nfsidem 10000). The test is slow,
owing to the expensive operations it performs, so you'll need to
run it for a long time.

You'll almost definitely get a failure or two, since the NFSv3
protocol is flawed by design. But you can compare the behaviors,
and even compute a likelihood. I'd love to see some actual numbers.

> IMO we can't leave things the way they are.

Agreed!

Tom.


>>> I'm not sure why I never noticed this before.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> index 027a3b0..1b3700b 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>>>   	/* Save client advertised inbound read limit for use later in accept. */
>>>   	newxprt->sc_ord = param->initiator_depth;
>>>
>>> -	/* Set the local and remote addresses in the transport */
>>>   	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>>>   	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>> +	/* The remote port is arbitrary and not under the control of the
>>> +	 * ULP. Set it to a fixed value so that the DRC continues to work
>>> +	 * after a reconnect.
>>> +	 */
>>> +	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>> +
>>>   	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
>>>   	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>>
>>>
>>>
>>>
> 
> --
> Chuck Lever
> 
> 
> 
> 
> 
