Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB32F30649
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaBp1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 21:45:27 -0400
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:49760
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfEaBp1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 21:45:27 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WWbmhT95vmARFWWbmhBzxG; Thu, 30 May 2019 18:45:27 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
 <CAN-5tyEBb3_TLvuN49FBB6qz2kXSZLPxHYZfQQX0jU4qFt4Z4A@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b4adc48a-5e96-c86d-78ed-27c268df0424@talpey.com>
Date:   Thu, 30 May 2019 21:45:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyEBb3_TLvuN49FBB6qz2kXSZLPxHYZfQQX0jU4qFt4Z4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBnZF4shmGHRRBnnAli2vFBY/pJ4I4ey89dPW3PAdvC/Bfe+kweVcJsjHJSuLvnJnDRTPmAp57RyCC47jSKJvFycj9Gjtn4c+7WuvqKEZQsaKi7lIMrV
 P2YB8/K4VTV3gMvCaNDxjvP8DSqRZooicXjCMZHSu9HmthLs42ugPSY+Nx2lQkff+tdvcEeUICAiUODgdCyBB5lc2G/CzZuNQ24M8XawTSf0CzN+s9YLBuCK
 7NPODG5otMQMVLtt8kq6JA0A6ogyFsmp7TUJTXzqUdV+AoQrBKA9/zDwE71Kc5XN+TCfJM4NSnxd5fxXue9Zyj0zn7/ZTyhzoFFWecuu46I=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/30/2019 2:41 PM, Olga Kornievskaia wrote:
> On Thu, May 30, 2019 at 1:41 PM Tom Talpey <tom@talpey.com> wrote:
>>
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
> For v3 and v4.0 in the current code base with a single connection,
> when it goes down, you are out of luck. When we have multiple
> connections and would like the benefit of using them but not
> sacrifices replay cache correctness, it's a small price to restrict
> the re-transmissions and suffer the consequence of not being able to
> do an operation during network issues.

I agree that the corruption resulting from a blown cache lookup would
be bad. But I'm also saying that users will be frustrated when random
operations time out, even when new ones work. Also, I think it may
lead to application issues.

>> I think a common configuration will be two NICs and two network paths,
> 
> Are you talking about session trunking here?

No, not necessarily. Certianly not when doing what you propose
over NFSv3.

> Why do you think two NICs would be a common configuration. I have
> performance numbers that demonstrate performance improvement for a
> single NIC case. I would say a single NIC with a high speed networks
> (25/40G) would be a common configuration.

They're both common! And sure, it's good for a single NIC because of
RSS (receive side scaling). The multiple connections spread interrupts
over several cores. The same as would happen with multiple NICs.

> 
>> a so-called shotgun. Admins will be quite frustrated to discover it
>> gives no additional robustness, and perhaps even less.
>>
>> Why not simply restrict this to the fully-correct, fully-functional
>> NFSv4.1+ scenario, and not try to paper over the shortcomings?
> 
> I think mainly because customers are still using v3 but want to
> improve performance. I'd love for everybody to switch to 4.1 but
> that's not happening.

Yeah, you and me both. But trying to "fix" NFSv3 with this is not
going to move the world forward, and I predict will cost many woeful
days ahead when it fails to work transparently.

Tom.


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
> 
> 
