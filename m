Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC61EF995
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgFENs6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 09:48:58 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:44887
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgFENs5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 09:48:57 -0400
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id hCiOjfeGIE4KhhCiOj7To0; Fri, 05 Jun 2020 06:48:57 -0700
X-CMAE-Analysis: v=2.3 cv=QpUgIm6d c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=Ttyvi4g-exlmjVYibWUA:9
 a=zBh3vVxrueG1MFmw:21 a=sKJz03POVbth83Jt:21 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: once again problems with interrupted slots
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
 <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
 <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ce227f0a-c97a-2bd9-7321-1193e5fc56b4@talpey.com>
Date:   Fri, 5 Jun 2020 09:48:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF6qzMGbK3wZQJfSceIaArPVuATzHNasRIDHT/OfXo3ghwL2GD5X4n2DsxyYQxfxOmyk4yaXY6jpmb/TiOLKU7sXDk+GQ0oKFt8CknG1xxT362SX7Tmi
 bNt+XITIpRNefCOs5cnw2MmEF6e8k4sRbMnR+ol2+2iFHNpMx0/O0uxm9wYB8lhhQp7sqc2ELhSdDXi+f1F5pb6RID04U2rQiNiyW67CFIExT1CmuWofd59k
 eMHnqa9110ujFeIdfvE58Q==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2020 9:24 AM, Olga Kornievskaia wrote:
> On Fri, Jun 5, 2020 at 8:06 AM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
>>> Hi Trond,
>>>
>>> There is a problem with interrupted slots (yet again).
>>>
>>> We send an operation to the server and it gets interrupted by the a signal.
>>>
>>> We used to send a sole SEQUENCE to remove the problem of having real
>>> operation get an out of the cache reply and failing. Now we are not
>>> doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
>>> calls are interrupted"). So the problem is
>>>
>>> We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.
>>
>> Misordered? It sounds like the client isn't managing the sequence
>> number, or perhaps the server never saw the original request, and
>> is being overly strict.
> 
> Well, both the client and the server are acting appropriately.  I'm
> not arguing against bumping the sequence. Client sent say REMOVE with
> slot=1 seq=5 which got interrupted. So client doesn't know in what
> state the slot is left. So it sends the next operation say READ with
> slot=1 seq=6. Server acts appropriately too, as it's version of the
> slot has seq=4, this request with seq=6 gets SEQ_MISORDERED.

Wait, if the client sent slot=1 seq=5, then unless the connection
breaks, that slot is at seq=5, simple as that. If the operation was
interrupted before sending the request, then the sequence should
not be bumped.

>>> We decrement the number back to the interrupted operation. This gets
>>> us a reply out of the cache. We again fail with REMOTE EIO error.
>>
>> Ew. The client *decrements* the sequence?
> 
> Yes, as client then decides that server never received seq=5 operation
> so it re-sends with seq=5. But in reality seq=5 operation also reached
> the server so it has 2 requests REMOVE/READ both with seq=5 for
> slot=1. This leads to READ failing with some error.

But if the connection didn't break, it's reliable therefore the "resend"
must not be performed. This is a new operation, not a retry. It cannot
use the same slot+seq pair. And decrementing the slot is even sillier,
it's reusing *two* seq's at that point.

> We used to before send a sole SEQUENCE when we have an interrupted
> slot to sync up the seq numbers. But commit 3453d5708 changed that and
> I would like to understand why. As I think we need to go back to
> sending sole SEQUENCE.

Sounds like a hack, frankly. What if the server responds the same
way? The client will start burning the wire.

Closing the connection, or never using that slot again, seems to
me the only correct option, given the other behavior described.

Tom.


>>> Going back to the commit's message. I don't see the logic that the
>>> server can't tell if this is a new call or the old one. We used to
>>> send a lone SEQUENCE as a way to protect reuse of slot by a normal
>>> operation. An interrupted slot couldn't have been another SEQUENCE. So
>>> I don't see how the server can't tell a difference between SEQUENCE
>>> and any other operations.
>>>
>>>
> 
> 
