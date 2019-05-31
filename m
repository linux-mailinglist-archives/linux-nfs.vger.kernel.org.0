Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77F30658
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 03:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaBsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 21:48:03 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:58605
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfEaBsD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 21:48:03 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WWeHh87gcXGbMWWeHhO5Nu; Thu, 30 May 2019 18:48:02 -0700
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
From:   Tom Talpey <tom@talpey.com>
Message-ID: <f44dd718-6e4c-d068-f24a-9949cda5c2e8@talpey.com>
Date:   Thu, 30 May 2019 21:48:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87pnnztvo1.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJZdJhC30wxVdSw4Q5qUSHP+MrUFM1I3PlfD00TP9MJAst4cVSVcedgQMeNX0KBQa3RRe4KSlYEVu/ZMO7kZjWpb0BEzkUxJuJ6oPhZG+bVMSTmauwyF
 bmUFc/XztviY52AfXEV9ycY931uIfR6eqTE1mQiznXIbNHWeCQhtYy61Hv8kEepWxpqBMt/l0ZFzkiJtyttfeGgBlhjjDm0eTSPrOp26H81lrPE7i18VlI5j
 WLZkKdvQ0+C2OOePncrXBwvv88HZ+MoB5CntTIgJUC9H2SuTK84lyeTcSXqI9OUJqqyaEiEie6Me71ka028xM9XGRdcylwk4X75VaZd2UP4=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/30/2019 6:38 PM, NeilBrown wrote:
> On Thu, May 30 2019, Tom Talpey wrote:
> 
>> On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
>>> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>>> I've also re-arrange the patches a bit, merged two, and remove the
>>>>> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>>>> these restrictions were not needed, I can see no need.
>>>>
>>>> I believe the need is for the correctness of retries. Because NFSv2,
>>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>>> duplicate request caches are important (although often imperfect).
>>>> These caches use client XID's, source ports and addresses, sometimes
>>>> in addition to other methods, to detect retry. Existing clients are
>>>> careful to reconnect with the same source port, to ensure this. And
>>>> existing servers won't change.
>>>
>>> Retries are already bound to the same connection so there shouldn't be
>>> an issue of a retransmission coming from a different source port.
>>
>> So, there's no path redundancy? If any connection is lost and can't
>> be reestablished, the requests on that connection will time out?
> 
> Path redundancy happens lower down in the stack.  Presumably a bonding
> driver will divert flows to a working path when one path fails.
> NFS doesn't see paths at all.  It just sees TCP connections - each with
> the same source and destination address.  How these are associated, from
> time to time, with different hardware is completely transparent to NFS.

But, you don't propose to constrain this to bonded connections. So
NFS will create connections on whatever collection of NICs which are
locally, and if these aren't bonded, well, the issues become visible.

BTW, RDMA NICs are never bonded.

Tom.

> 
>>
>> I think a common configuration will be two NICs and two network paths,
>> a so-called shotgun. Admins will be quite frustrated to discover it
>> gives no additional robustness, and perhaps even less.
>>
>> Why not simply restrict this to the fully-correct, fully-functional
>> NFSv4.1+ scenario, and not try to paper over the shortcomings?
> 
> Because I cannot see any shortcomings in using it for v3 or v4.0.
> 
> Also, there are situations where NFSv3 is a measurably better choice
> than NFSv4.1.  Al least it seems to allow a quicker failover for HA.
> But that is really a topic for another day.
> 
> NeilBrown
> 
>>
>> Tom.
>>
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
>>>
>>>
