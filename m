Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAB3B78B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbfFJOiV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 10:38:21 -0400
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:38044
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389938AbfFJOiV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jun 2019 10:38:21 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aLRDhDjc7vXcJaLREhxtGx; Mon, 10 Jun 2019 07:38:20 -0700
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
 <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com>
 <CAN-5tyEUHrDkj7MKfYeN5LsFwZEtaLsHYMX20UQMShHtQa-QsA@mail.gmail.com>
 <52A2AF4C-1858-486E-8A9B-94392E7E18BD@oracle.com>
 <CAN-5tyEBEf4-1mk4wSM1VRTYn-zLvYs2rbHRxHU2cK2zNZ0hXg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <342b90df-47ea-bca3-1852-8d3e68a06825@talpey.com>
Date:   Mon, 10 Jun 2019 10:38:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyEBEf4-1mk4wSM1VRTYn-zLvYs2rbHRxHU2cK2zNZ0hXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH7xwYA6al0bG8WGAgR+Fl/bhzLa3PViTxkMXuLI2fdpnXQLXhx+0cYTnSU35lWpm1V8efrhh19I6qvVcCidDql08brmka+IqbqCr8AXHW99GURkbgUt
 De9v33msdZfoW6GTD/HBDghoaIQCS06UFsk32FRN8U7D47vqJbgBdLW5L3YNiqXhsFhF6z7InfJcw5KOadDGQkjqoEYCAcflR+1PCMS270lOfUlV/dGUSqu9
 QSKiVn6db7a+nYSDO9+jzuQ3+wg+gHopFc1s5cg1cs4=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/7/2019 11:43 AM, Olga Kornievskaia wrote:
> On Thu, Jun 6, 2019 at 2:33 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> ...
>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>>          /* Save client advertised inbound read limit for use later in accept. */
>>          newxprt->sc_ord = param->initiator_depth;
>>
>>          /* Set the local and remote addresses in the transport */
>>          sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>>
>> Can you add a printk to your server to show the port value
>> in cm_id->route.addr.dst_addr?
> 
> What I see printed here isn't not what I see in the network trace in
> wireshark for the UDP port. It's also confusing that
> Connection manager communication (in my case) say between source port
> 55410 (which stays the same on remounts) and dst port 4791. Then NFS
> traffic is between source port 63494 (which changes on remounts) and
> destination port 4791. Yet, NFS reports that source port was 40403 and
> destination port was 20049(!).

This is expected. 4791 is the RoCEv2 protocol destination port, and
it's a constant for all RoCEv2 connections. think of it like a tunnel,
similar to VxLAN.

RoCEv2 then applies its own mapping to demultiplex incoming packets to
the proper queue pair. This is based on the RDMA CM connection service
id's. These are based on the upper layer's requested port.

In other words, you need to apply tracing at the proper layer. Wire
level traces aren't going to be very useful.

Btw, iWARP connections won't remap ports like this. But IB and RoCE
will, since they don't natively have an actual 5-tuple defined.

Tom.

> The code that I looked at (as you pointed) was for the connection
> manager and that port stays constant but for the NFSoRDMA after that
> it's from a new port that changes all the time (even for the Mellanox
> card).
> 
> Looks like there is no way to get the "real" port thru the rdma layers
> on either side.
> 
> 
>>> I also see that there is nothing in the verbs API thru which we
>>> interact with the RDMA drivers will allow us to set the port.
>>
>> I suspect this would be part of the RDMA Connection Manager
>> interface, not part of the RDMA driver code.
>>
>>
>>> Unless
>>> we can ask the linux implementation to augment some structures to
>>> allow us to set and query that port or is that unreasonable because
>>> it's not in the standard API.
>>>
>>>>
>>>>
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> ---
>>>>>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>>>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>>>> index 027a3b0..1b3700b 100644
>>>>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>>>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>>>>>>        /* Save client advertised inbound read limit for use later in accept. */
>>>>>>        newxprt->sc_ord = param->initiator_depth;
>>>>>>
>>>>>> -       /* Set the local and remote addresses in the transport */
>>>>>>        sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>>>>>>        svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>>>>> +       /* The remote port is arbitrary and not under the control of the
>>>>>> +        * ULP. Set it to a fixed value so that the DRC continues to work
>>>>>> +        * after a reconnect.
>>>>>> +        */
>>>>>> +       rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>>>> +
>>>>>>        sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
>>>>>>        svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>>>>>
>>>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>
>> --
>> Chuck Lever
>>
>>
>>
> 
> 
