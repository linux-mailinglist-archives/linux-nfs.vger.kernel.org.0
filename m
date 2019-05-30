Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122D430125
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfE3Rlb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 13:41:31 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:35986
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbfE3Rla (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 13:41:30 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WP3Rh9Xstb5uOWP3RhJl1C; Thu, 30 May 2019 10:41:30 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
Date:   Thu, 30 May 2019 13:41:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCaGtFKeHr68geR4zP2Gn897LFsINAcADJoTJw0FZcC+QgMHJiut2ZCdIm/FW2zGJ4UH7IWsw3YriA6sJ22JIXoBpAWftcJCO+HRKpquNnrFE1lpmiQx
 0GUeMBEz1OqetFFdpRy7gWpn0WW7eU6svQlycXmy0is0yMM0uRxWBxh1fC4AFjAXmznun6LgU0VK84RBqfePNeRMJ8YLSxdA4L1zr7ka051CQIG5Wy8JhqIn
 rtgte4lkj/t6jeZhKeQRqdlNPs3Orup97Gk01svxWwAiPGIxiaw5qulaF6LRpUY74D7OMKDoWMr/wjIvWV1dcGNZg9BZglVzwHZKQDNP4bA=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>> I've also re-arrange the patches a bit, merged two, and remove the
>>> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>> these restrictions were not needed, I can see no need.
>>
>> I believe the need is for the correctness of retries. Because NFSv2,
>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>> duplicate request caches are important (although often imperfect).
>> These caches use client XID's, source ports and addresses, sometimes
>> in addition to other methods, to detect retry. Existing clients are
>> careful to reconnect with the same source port, to ensure this. And
>> existing servers won't change.
> 
> Retries are already bound to the same connection so there shouldn't be
> an issue of a retransmission coming from a different source port.

So, there's no path redundancy? If any connection is lost and can't
be reestablished, the requests on that connection will time out?

I think a common configuration will be two NICs and two network paths,
a so-called shotgun. Admins will be quite frustrated to discover it
gives no additional robustness, and perhaps even less.

Why not simply restrict this to the fully-correct, fully-functional
NFSv4.1+ scenario, and not try to paper over the shortcomings?

Tom.

> 
>> Multiple connections will result in multiple source ports, and possibly
>> multiple source addresses, meaning retried client requests may be
>> accepted as new, rather than having any chance of being recognized as
>> retries.
>>
>> NFSv4.1+ don't have this issue, but removing the restrictions would
>> seem to break the downlevel mounts.
>>
>> Tom.
>>
> 
> 
