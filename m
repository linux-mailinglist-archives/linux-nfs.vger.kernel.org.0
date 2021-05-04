Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B3372AF3
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhEDN2I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 May 2021 09:28:08 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:53003
        "EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhEDN2I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 May 2021 09:28:08 -0400
Received: from [192.168.0.100] ([96.237.161.203])
        by :SMTPAUTH: with ESMTPSA
        id dv4xl1bPnlgqpdv4yllS2D; Tue, 04 May 2021 06:27:13 -0700
X-CMAE-Analysis: v=2.4 cv=Es8XEQQA c=1 sm=1 tr=0 ts=60914bb1
 a=Pd5wr8UCr3ug+LLuBLYm7w==:117 a=Pd5wr8UCr3ug+LLuBLYm7w==:17
 a=IkcTkHD0fZMA:10 a=mJjC6ScEAAAA:8 a=XYSjVLlUk7XwVBbOZ04A:9 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: unsharing tcp connections from different NFS mounts
To:     NeilBrown <neilb@suse.de>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
 <20210119222229.GA29488@fieldses.org>
 <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>
 <20210120150737.GA17548@fieldses.org> <20210503200952.GB18779@fieldses.org>
 <162009412979.28954.17703105649506010394@noble.neil.brown.name>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b8c7ab25-fb8e-5c89-5b0b-7cf6fbb36a0b@talpey.com>
Date:   Tue, 4 May 2021 09:27:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <162009412979.28954.17703105649506010394@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEkYSNR/N4kWB3oPOGweh7pa7S8kJwLpJ/97rGLM19zasWC2k+W8e67XWV+RUSsaAw+Cti6wLmFzpKXbjk7tOAIjg1TQ0l6wzf03mYSPaGvqDPPhsPST
 uv+EVTic4zhqNlewcMQ5dEt8bPz1MaDcLwDRCWbS6JfLxcIbagQyGLrGLSLZhXuQr+xsLtMeC4UVw7Tnb9h+vCwF8fOZLDr5FvaqVX1mGVZsCQTIG07iXdCp
 AK0XUKU2ZErJvwOXRgIeKUCL26WUOr4NHIF6i9G6w3DrOVrIcY0eppKd5ENO8CqpxB96RGRbV0/7BdEaeH6yJ5i8/28v9u15yAgRmyWEpDt/wZBbYrmwPg8Z
 mEyEb/LOG5eIX5IdoYltelXv4UAfmBN+Ro07Okwmwhnww17PVvfQpdwb+gg1rxvire58c7YdWu9gwpFD83nOnMwJHYG35w==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/3/2021 10:08 PM, NeilBrown wrote:
> On Tue, 04 May 2021, bfields@fieldses.org wrote:
>> On Wed, Jan 20, 2021 at 10:07:37AM -0500, bfields@fieldses.org wrote:
>>>
>>> So mainly:
>>>
>>>>>> Why is there a performance regression being seen by these setups
>>>>>> when they share the same connection? Is it really the connection,
>>>>>> or is it the fact that they all share the same fixed-slot session?
>>>
>>> I don't know.  Any pointers how we might go about finding the answer?
>>
>> I set this aside and then get bugged about it again.
>>
>> I apologize, I don't understand what you're asking for here, but it
>> seemed obvious to you and Tom, so I'm sure the problem is me.  Are you
>> free for a call sometime maybe?  Or do you have any suggestions for how
>> you'd go about investigating this?
> 
> I think a useful first step would be to understand what is getting in
> the way of the small requests.
>   - are they in the client waiting for slots which are all consumed by
>     large writes?
>   - are they in TCP stream behind megabytes of writes that need to be
>     consumed before they can even be seen by the server?
>   - are they in a socket buffer on the server waiting to be served
>     while all the nfsd thread are busy handling writes?
> 
> I cannot see an easy way to measure which it is.

I completely agree. The most likely scenario is a slot shortage which
might be preventing the client sending new RPCs. And with a round-robin
policy, the first connection with such a shortage will stall them all.

How can we observe whether this is the case?

Tom.


> I guess monitoring how much of the time that the client has no free
> slots might give hints about the first.  If there are always free slots,
> the first case cannot be the problem.
> 
> With NFSv3, the slot management happened at the RPC layer and there were
> several queues (RPC_PRIORITY_LOW/NORMAL/HIGH/PRIVILEGED) where requests
> could wait for a free slot.  Since we gained dynamic slot allocation -
> up to 65536 by default - I wonder if that has much effect any more.
> 
> For NFSv4.1+ the slot management is at the NFS level.  The server sets a
> maximum which defaults to (maybe is limited to) 1024 by the Linux server.
> So there are always free rpc slots.
> The Linux client only has a single queue for each slot table, and I
> think there is one slot table for the forward channel of a session.
> So it seems we no longer get any priority management (sync writes used
> to get priority over async writes).
> 
> Increasing the number of slots advertised by the server might be
> interesting.  It is unlikely to fix anything, but it might move the
> bottle-neck.
> 
> Decreasing the maximum of number of tcp slots might also be interesting
> (below the number of NFS slots at least).
> That would allow the RPC priority infrastructure to work, and if the
> large-file writes are async, they might gets slowed down.
> 
> If the problem is in the TCP stream (which is possible if the relevant
> network buffers are bloated), then you'd really need multiple TCP streams
> (which can certainly improve throughput in some cases).  That is what
> nconnect give you.  nconnect does minimal balancing.  It general it will
> round-robin, but if the number of requests (not bytes) queued on one
> socket is below average, that socket is likely to get the next request.
> So just adding more connections with nconnect is unlikely to help.  You
> would need to add a policy engine (struct rpc_xpr_iter_ops) which
> reserves some connections for small requests.  That should be fairly
> easy to write a proof-of-concept for.
> 
> NeilBrown
> 
> 
>>
>> Would it be worth experimenting with giving some sort of advantage to
>> readers?  (E.g., reserving a few slots for reads and getattrs and such?)
>>
>> --b.
>>
>>> It's easy to test the case of entirely seperate state & tcp connections.
>>>
>>> If we want to test with a shared connection but separate slots I guess
>>> we'd need to create a separate session for each nfs4_server, and a lot
>>> of functions that currently take an nfs4_client would need to take an
>>> nfs4_server?
>>>
>>> --b.
>>
>>
> 
