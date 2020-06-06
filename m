Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE41F041E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2020 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgFFBK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 21:10:56 -0400
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:57585
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbgFFBK4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 21:10:56 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 21:10:55 EDT
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id hNFEjEE1y8WJyhNFEjEQR0; Fri, 05 Jun 2020 18:03:33 -0700
X-CMAE-Analysis: v=2.3 cv=V8MDLtvi c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=hMeEB36ejoHV51OJbWMA:9
 a=WvGRd0HwRvkrXDPj:21 a=DGzJNoSo8r7HM8Kx:21 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: once again problems with interrupted slots
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
 <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
 <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
 <ce227f0a-c97a-2bd9-7321-1193e5fc56b4@talpey.com>
 <CAN-5tyE=0+nvGZtoN-C-1a3guju_TjsAq701AG_Y=TjxQ3iqqg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <c89f0cea-73e2-d234-de7e-bd82d9e23d46@talpey.com>
Date:   Fri, 5 Jun 2020 21:03:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyE=0+nvGZtoN-C-1a3guju_TjsAq701AG_Y=TjxQ3iqqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM82F2bL80Lh2TAhkWtEQF2+QptUh52zCp53+spMqUMrMx0QKHaRuaNIMjIP6A5OQd1S9OoF9OLxoEVe5qu7JNNM/1bLTj6lhCp2IbdRw/HIPdsc6Dsg
 KH5JhqZHqKQGFmLFZ0GG9WewQwp1FkA/BXocr/RDezc5d+0GHugPzGqbqj7t/PQ0D7ai2Zwj0EH3E6/mQ+YWMk30NaHMKthvp4EVDCLytukn8/d1TAaVYGME
 FJfXdBWZmcZSia+UnvDuxQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2020 11:30 AM, Olga Kornievskaia wrote:
> On Fri, Jun 5, 2020 at 9:49 AM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/5/2020 9:24 AM, Olga Kornievskaia wrote:
>>> On Fri, Jun 5, 2020 at 8:06 AM Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
>>>>> Hi Trond,
>>>>>
>>>>> There is a problem with interrupted slots (yet again).
>>>>>
>>>>> We send an operation to the server and it gets interrupted by the a signal.
>>>>>
>>>>> We used to send a sole SEQUENCE to remove the problem of having real
>>>>> operation get an out of the cache reply and failing. Now we are not
>>>>> doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
>>>>> calls are interrupted"). So the problem is
>>>>>
>>>>> We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.
>>>>
>>>> Misordered? It sounds like the client isn't managing the sequence
>>>> number, or perhaps the server never saw the original request, and
>>>> is being overly strict.
>>>
>>> Well, both the client and the server are acting appropriately.  I'm
>>> not arguing against bumping the sequence. Client sent say REMOVE with
>>> slot=1 seq=5 which got interrupted. So client doesn't know in what
>>> state the slot is left. So it sends the next operation say READ with
>>> slot=1 seq=6. Server acts appropriately too, as it's version of the
>>> slot has seq=4, this request with seq=6 gets SEQ_MISORDERED.
>>
>> Wait, if the client sent slot=1 seq=5, then unless the connection
>> breaks, that slot is at seq=5, simple as that. If the operation was
>> interrupted before sending the request, then the sequence should
>> not be bumped.
> 
> Connection doesn't drop. We tried not bumping the sequence (i think
> that was probably how it was originally done). Then you still get into
> the same problem right away. REMOVE and READ will be using seq=5.

Well, if the connection has not dropped, the behavior you describe is
violating the protocol in at least two ways:

- it is retransmitting a request on a reliable transport
- it is sending a second message into a busy slot

The last one also has the possibility of overrunning an RDMA credit
limit too, btw.

I don't think you should expect any correct result to come of these
client behaviors.

>>>>> We decrement the number back to the interrupted operation. This gets
>>>>> us a reply out of the cache. We again fail with REMOTE EIO error.
>>>>
>>>> Ew. The client *decrements* the sequence?
>>>
>>> Yes, as client then decides that server never received seq=5 operation
>>> so it re-sends with seq=5. But in reality seq=5 operation also reached
>>> the server so it has 2 requests REMOVE/READ both with seq=5 for
>>> slot=1. This leads to READ failing with some error.
>>
>> But if the connection didn't break, it's reliable therefore the "resend"
>> must not be performed. This is a new operation, not a retry. It cannot
>> use the same slot+seq pair. And decrementing the slot is even sillier,
>> it's reusing *two* seq's at that point.
> 
> When the slot gets interrupted we don't know when the interruption
> happened. If we got SEQ_MISORDERED, it might be because interruption
> happened before the request was ever sent to the server, so it's valid
> for the seq to stay the same (ie decrementing the seq). I don't see
> how decrementing the seq is reusing 2 seq values: only one value is
> valid and client is trying to figure out which one.

Well, the client code needs to track whether the request was sent, and
use a new slot if so. If not, then it's reusing sequence values because
it's either retransmitting, or sending a different message, on a slot
which has an outstanding (abandoned) request. Again, protocol violation.

Slots can be thought of as single-request mailboxes, which are then
used serially. (To get N parallel operations, you need N slots.) The
sequence is *not* a window. The only valid new value is previous+1.

>>> We used to before send a sole SEQUENCE when we have an interrupted
>>> slot to sync up the seq numbers. But commit 3453d5708 changed that and
>>> I would like to understand why. As I think we need to go back to
>>> sending sole SEQUENCE.
>>
>> Sounds like a hack, frankly. What if the server responds the same
>> way? The client will start burning the wire.
> 
> Sending the SEQUENCE on the same slot/seqid as an interrupted slot
> doesn't lead to any operation failing >
>> Closing the connection, or never using that slot again, seems to
>> me the only correct option, given the other behavior described.
> 
> Not ever using an interrupted slot seems too drastic (we can end up
> with a session where all slots are unusable. or losing slots also
> means losing ability to send more requests in parallel). I thought
> that's given a sequence of events and error codes we should be able to
> re-sync the slot.

The only way to "re-sync the slot" is to wait for the server's reply,
or close the connection.

Yes, it's extreme to stop using the slot, and it means the client will
very likely have to request more slot credits. But, it's what the
protocol requires, short of starting over on a new connection.

Tom.


>>>>> Going back to the commit's message. I don't see the logic that the
>>>>> server can't tell if this is a new call or the old one. We used to
>>>>> send a lone SEQUENCE as a way to protect reuse of slot by a normal
>>>>> operation. An interrupted slot couldn't have been another SEQUENCE. So
>>>>> I don't see how the server can't tell a difference between SEQUENCE
>>>>> and any other operations.
>>>>>
>>>>>
>>>
>>>
> 
> 
