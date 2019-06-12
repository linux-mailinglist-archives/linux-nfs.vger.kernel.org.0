Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36F426B5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404836AbfFLMw5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:52:57 -0400
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net ([173.201.193.104]:54653
        "EHLO p3plsmtpa08-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfFLMw5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 08:52:57 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id b2kKhM68t8NbRb2kKh6BvG; Wed, 12 Jun 2019 05:52:57 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     NeilBrown <neilb@suse.com>, Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com>
 <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
 <87a7enwvvs.fsf@notabene.neil.brown.name>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <5f8f4413-ca7a-7e42-4adb-618b9d4d0415@talpey.com>
Date:   Wed, 12 Jun 2019 08:52:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87a7enwvvs.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB9qDcPA43lBIjRCwL4X31Kbp6p3xoIPn3Huz2JALhAcd3rgi4uzvaoTT+rZyZUorirKqx2niEwIFIuXMDsyZcR70Drq9qShtaMyVT/8VjQr79gkRQY2
 VE0VFgv92bbomOK862+aKFz8gaK0ASklKlxt/cNZSEur3wVxp3UynwEaJwQr1egAb9Z18bixEn0XK5kyhLXiTp1DVJSsTu7PocbhzfG6nSPcus41tEvFHMB7
 AqRfxl87tQTJ4gbm3qTvrty4DdwNi2RxUp73Xmrfa9sABzspDlKv8SHG1B4rtamiFs8q994ZaD63B62XAhK0HD/k/oiwZrfE9xwwFkYwAT0=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/11/2019 7:21 PM, NeilBrown wrote:
> On Tue, Jun 11 2019, Tom Talpey wrote:
>>
>> I really hope nconnect is not just a workaround for some undiscovered
>> performance issue. All that does is kick the can down the road.
> 
> This is one of my fears too.
> 
> My current perspective is to ask
>    "What do hardware designers optimise for".
> because the speeds we are looking at really require various bits of
> hardware to be working together harmoniously.
> 
> In context, that question becomes "Do they optimise for single
> connection throughput, or multiple connection throughput".

I assume you mean NIC hardware designers. The answer is both of
course, but there are distinct advantages in the multiple-connection
case. The main feature is RSS - Receive Side Scaling - which computes
a hash of each 5-tuple-based IP flow and spreads interrupts based on
the value. Generally speaking, that's why multiple connections can
speed up a single NIC, on today's high core count machines.

RDMA has a similar capability, by more explicitly directing its
CQs - Completion Queues - to multiple cores. Of course, RDMA has
further abilities to reduce CPU overhead through direct data placement.

> Given the amount of money in web-services, I think multiple connection
> throughput is most likely to provide dollars.
> I also think that is would be a lot easier to parallelise than single
> connection.

Yep, that's another advantage. As you observe, this kind of parallelism
is easier to achieve on the server side. IOW, this helps both ends of
the connection.

> So if we NFS developers want to work with the strengths of the hardware,
> I think multiple connections and increased parallelism is a sensible
> long-term strategy.
> 
> So while I cannot rule out any undiscovered performance issue, I don't
> think this is just kicking the can down the road.

Agreed. But driving this to one or two dozen connections is different.
Typical NICs have relatively small RSS limits, and even if they have
more, the system's core count and MSI-X vectors (interrupt steering)
rarely approach this kind of limit. If you measure the improvement
vs connection count, you'll find it increases sharply at 2 or 4, then
flattens out. At that point, the complexity takes over and you'll only
see the advantage in a lab. In the real world, a very different picture
emerges, and it can be very un-pretty.

Just some advice, that's all.

Tom.
