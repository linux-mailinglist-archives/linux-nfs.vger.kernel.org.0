Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3854630E40
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEaMoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 08:44:17 -0400
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:42353
        "EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfEaMoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 May 2019 08:44:17 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WgmIhIEjHmMHzWgmIhFLhZ; Fri, 31 May 2019 05:36:59 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Rick Macklem <rmacklem@uoguelph.ca>, NeilBrown <neilb@suse.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
 <87h89bxwr2.fsf@notabene.neil.brown.name>
 <QB1PR01MB2643E05DF1A13967BB21B1C3DD190@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <4031093f-2044-da8b-9ba7-7b2a2000847c@talpey.com>
Date:   Fri, 31 May 2019 08:36:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <QB1PR01MB2643E05DF1A13967BB21B1C3DD190@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNb1qx1Er+Tu/bEXWmvjG5owWkGg+tKu3C6RVarrTYAJqFZpurqRrOlA4XFfkyWcO3uFXbwvSBSRU/nE7MjKui6Nw7ABT3qxO4757pqb7u11uhk37n9L
 6gPrbpVtCpQsSEyWJ0gnAayZm5tqgO1HezPOraIULAQWKx6fY4e+0ritwB0WklbINSQ44UbFbmlI4v1trqA+r5lTtYPdGodm7nvGi3LIQ6L6XbtOSO5TCDTc
 B6gBEo/EStbjuciTHqQ6veKUsgqeAr26E9TJ+Y4SoJU+/qPKV9RlKlKocnasvY2dKUBxNY6j/2JCUGT3oRGnqUQWKE75jiKMowlyL3+DtgPaFhu5qfjbj1co
 7TH7GRq/
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/30/2019 10:20 PM, Rick Macklem wrote:
> NeilBrown wrote:
>> On Thu, May 30 2019, Rick Macklem wrote:
>>
>>> Olga Kornievskaia wrote:
>>>> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>>>
>>>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>>>> I've also re-arrange the patches a bit, merged two, and remove the
>>>>>> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>>>>> these restrictions were not needed, I can see no need.
>>>>>
>>>>> I believe the need is for the correctness of retries. Because NFSv2,
>>>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>>>> duplicate request caches are important (although often imperfect).
>>>>> These caches use client XID's, source ports and addresses, sometimes
>>>>> in addition to other methods, to detect retry. Existing clients are
>>>>> careful to reconnect with the same source port, to ensure this. And
>>>>> existing servers won't change.
>>>>
>>>> Retries are already bound to the same connection so there shouldn't be
>>>> an issue of a retransmission coming from a different source port.
>>> I don't think the above is correct for NFSv4.0 (it may very well be true for NFSv3).
>>
>> It is correct for the Linux implementation of NFS, though the term
>> "xprt" is more accurate than "connection".
>>
>> A "task" is bound it a specific "xprt" which, in the case of tcp, has a
>> fixed source port.  If the TCP connection breaks, a new one is created
>> with the same addresses and ports, and this new connection serves the
>> same xprt.
> Ok, that's interesting. The FreeBSD client side krpc uses "xprt"s too
> (I assume they came from some old Sun open sources for RPC)
> but it just creates a new socket and binds it to any port# available.
> When this happens in the FreeBSD client, the old connection is sometimes still
> sitting around in some FIN_WAIT state. My TCP is pretty minimal, but I didn't
> think you could safely create a new connection using the same port#s at that point,
> or at least the old BSD TCP stack code won't allow it.
> 
> Anyhow, the FreeBSD client doesn't use same source port# for the new connection.
> 
>>> Here's what RFC7530 Sec. 3.1.1 says:
>>> 3.1.1.  Client Retransmission Behavior
>>>
>>>     When processing an NFSv4 request received over a reliable transport
>>>     such as TCP, the NFSv4 server MUST NOT silently drop the request,
>>>     except if the established transport connection has been broken.
>>>     Given such a contract between NFSv4 clients and servers, clients MUST
>>>     NOT retry a request unless one or both of the following are true:
>>>
>>>     o  The transport connection has been broken
>>>
>>>     o  The procedure being retried is the NULL procedure
>>>
>>> If the transport connection is broken, the retry needs to be done on a new TCP
>>> connection, does it not? (I'm assuming you are referring to a retry of an RPC here.)
>>> (My interpretation of "broken" is "can't be fixed, so the client must use a different
>>>   TCP connection.)
>>
>> Yes, a new connection.  But the Linux client makes sure to use the same
>> source port.
> Ok. I guess my DRC code that expects "different source port#" for NFSv4.0 is
> broken. It will result in a DRC miss, which isn't great, but is always possible for
> any DRC design. (Not nearly as bad as a false hit.)
> 
>>>
>>> Also, NFSv4.0 cannot use Sun RPC over UDP, whereas some DRCs only
>>> work for UDP traffic. (The FreeBSD server does have DRC support for TCP, but
>>> the algorithm is very different than what is used for UDP, due to the long delay
>>> before a retried RPC request is received. This can result in significant server
>>> overheads, so some sites choose to disable the DRC for TCP traffic or tune it
>>> in such a way as it becomes almost useless.)
>>> The FreeBSD DRC code for NFS over TCP expects the retry to be from a different
>>> port# (due to a new connection re: the above) for NFSv4.0. For NFSv3, my best
>>> recollection is that it doesn't care what the source port# is. (It basically uses a
>>> hash on the RPC request excluding TCP/IP header to recognize possible
>>> duplicates.)
>>
>> Interesting .... hopefully the hash is sufficiently strong.
> It doesn't just use the hash (it still expects same xid, etc), it just doesn't use the TCP
> source port#.
> 
> To be honest, when I played with this many years ago, unless the size of the DRC
> is very large and entries persist in the cache for a long time, they always fall out
> of the cache before the retry happens over TCP. At least for the cases I tried back
> then, where the RPC retry timeout for TCP was pretty large.
> (Sites that use FreeBSD servers under heavy load usually find the DRC grows too
>   large and tune it down until it no longer would work for TCP anyhow.)
> 
> My position is that this all got fixed by sessions and if someone uses NFSv4.0 instead
> of NFSv4.1, they may just have to live with the limitations of no "exactly once"
> semantics. (Personally, NFSv4.0 should just be deprecated. I know people still have good uses for NFSv3, but I have trouble believing NFSv4.0 is preferred over NFSv4.1,
> although Bruce did note a case where there was a performance difference.)
> 
>> I think it is best to assume same source port, but there is no formal
>> standard.
> I'd say you can't assume "same port#" or "different port#', since there is no standard.
> But I would agree that "assuming same port#" will just result in false misses for
> clients that don't use the same port#.

Hey Rick. I think the best summary is to say the traditional DRC is
deeply flawed and can't fully protect this. Many of us, you and I
included, have tried various ways to fix this, with varying degrees
of success.

My point here is not perfection however. My point is, there are servers
out there which will behave quite differently in the face of this
proposed client behavior, and I'm raising the issue.

Tom.


> 
> rick
> 
>> Thanks,
>> NeilBrown
>>
>>
>>
>>> I don't know what other NFS servers choose to do w.r.t. the DRC for NFS over TCP,
>>> however for some reason I thought that the Linux knfsd only used a DRC for UDP?
>>> (Someone please clarify this.)
>>>
>>> rick
>>>
>>>> Multiple connections will result in multiple source ports, and possibly
>>>> multiple source addresses, meaning retried client requests may be
>>>> accepted as new, rather than having any chance of being recognized as
>>>> retries.
>>>>
>>>> NFSv4.1+ don't have this issue, but removing the restrictions would
>>>> seem to break the downlevel mounts.
>>>>
>>>> Tom.
>>>>
> 
> 
