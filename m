Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6E30E35
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaMmI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 08:42:08 -0400
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net ([68.178.252.238]:41579
        "EHLO p3plsmtpa12-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfEaMmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 May 2019 08:42:08 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 08:42:08 EDT
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id Wgp6hEKUtP4EqWgp6hef4J; Fri, 31 May 2019 05:39:53 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     NeilBrown <neilb@suse.com>, Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
 <87pnnztvo1.fsf@notabene.neil.brown.name>
 <f44dd718-6e4c-d068-f24a-9949cda5c2e8@talpey.com>
 <87ef4fxsm1.fsf@notabene.neil.brown.name>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b4795a49-4941-2b71-8219-626e49bd40da@talpey.com>
Date:   Fri, 31 May 2019 08:39:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87ef4fxsm1.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBbeEY/qsg59fQP+U4sNvThsEdE0g2pslBA9vhP5eMeP3EHweah2KKO/D6QSVJhfkuNBnR7M76NorHLLN6aWSWeWHEsQ30QU5xeU8edL8c8t26+awbqZ
 +ruzeoDj24ngaaAgOkGk338os+t++MXCI0GMkSCqiDTKk0EqiC/L0WDk+rtw6Kj1gT6o7XHBDMT0h2GZmVwDBYN5i8IRSpddsaxa/e4O4r/K1WAE7kBJYEFB
 YkAnvYnv4I4CiGaHN0oNlQRWHGju9wj/Ab39OSJh+CB/9OSUJ5xbGaYnZUYSwSbdPi9rdmgllWCva6FccVN7qbSTyWN3iQFArVzs7UN/rV8=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/30/2019 10:31 PM, NeilBrown wrote:
> On Thu, May 30 2019, Tom Talpey wrote:
> 
>> On 5/30/2019 6:38 PM, NeilBrown wrote:
>>> On Thu, May 30 2019, Tom Talpey wrote:
>>>
>>>> On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
>>>>> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>>>>
>>>>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>>>>> I've also re-arrange the patches a bit, merged two, and remove the
>>>>>>> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>>>>>> these restrictions were not needed, I can see no need.
>>>>>>
>>>>>> I believe the need is for the correctness of retries. Because NFSv2,
>>>>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>>>>> duplicate request caches are important (although often imperfect).
>>>>>> These caches use client XID's, source ports and addresses, sometimes
>>>>>> in addition to other methods, to detect retry. Existing clients are
>>>>>> careful to reconnect with the same source port, to ensure this. And
>>>>>> existing servers won't change.
>>>>>
>>>>> Retries are already bound to the same connection so there shouldn't be
>>>>> an issue of a retransmission coming from a different source port.
>>>>
>>>> So, there's no path redundancy? If any connection is lost and can't
>>>> be reestablished, the requests on that connection will time out?
>>>
>>> Path redundancy happens lower down in the stack.  Presumably a bonding
>>> driver will divert flows to a working path when one path fails.
>>> NFS doesn't see paths at all.  It just sees TCP connections - each with
>>> the same source and destination address.  How these are associated, from
>>> time to time, with different hardware is completely transparent to NFS.
>>
>> But, you don't propose to constrain this to bonded connections. So
>> NFS will create connections on whatever collection of NICs which are
>> locally, and if these aren't bonded, well, the issues become visible.
> 
> If a client had multiple network interfaces with different addresses,
> and several of them had routes to the selected server IP, then this
> might result in the multiple connections to the server having different
> local addresses (as well as different local ports) - I don't know the
> network layer well enough to be sure if this is possible, but it seems
> credible.
> 
> If one of these interfaces then went down, and there was no automatic
> routing reconfiguration in place to restore connectivity through a
> different interface, then the TCP connection would timeout and break.
> The xprt would then try to reconnect using the same source port and
> destination address - it doesn't provide an explicit source address, but
> lets the network layer provide one.
> This would presumably result in a connection with a different source
> address.  So requests would continue to flow on the xprt, but they might
> miss the DRC as the source address would be different.
> 
> If you have a configuration like this (multi-homed client with
> multiple interfaces that can reach the server with equal weight), then
> you already have a possible problem of missing the DRC if one interface
> goes down a new connection is established from another one.  nconnect
> doesn't change that.
> 
> So I still don't see any problem.
> 
> If I've misunderstood you, please provide a detailed description of the
> sort of configuration where you think a problem might arise.

You nailed it. But, I disagree that there won't be a problem. NFSv4.1
and up will be fine, but NFS versions which rely on a heuristic, space
limited DRC, will not.

Tom.


> 
>>
>> BTW, RDMA NICs are never bonded.
> 
> I've come across the concept of "Multi-Rail", but I cannot say that I
> fully understand it yet.  I suspect you would need more than nconnect to
> make proper use of multi-rail RDMA
> 
> Thanks,
> NeilBrown
> 
