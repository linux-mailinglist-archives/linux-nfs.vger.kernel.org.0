Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC283731F8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 23:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEDVk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 4 May 2021 17:40:28 -0400
Received: from natter.dneg.com ([193.203.89.68]:49048 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbhEDVk1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 May 2021 17:40:27 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 17:40:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 9362E776F644;
        Tue,  4 May 2021 22:32:36 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oigTSRQ-oaIM; Tue,  4 May 2021 22:32:36 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 6BEFD776858E;
        Tue,  4 May 2021 22:32:36 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 58CC189C7200;
        Tue,  4 May 2021 22:32:36 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eQyWuZvEZJBH; Tue,  4 May 2021 22:32:36 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 386A289C721D;
        Tue,  4 May 2021 22:32:36 +0100 (BST)
X-Virus-Scanned: amavisd-new at zrozimbrai.dneg.com
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SeLDgeu75cdh; Tue,  4 May 2021 22:32:36 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 1880389C720E;
        Tue,  4 May 2021 22:32:36 +0100 (BST)
Date:   Tue, 4 May 2021 22:32:35 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, neilb@suse.de,
        fsorenso@redhat.com, linux-nfs <linux-nfs@vger.kernel.org>,
        aglo@umich.edu, bcodding@redhat.com, jshivers@redhat.com,
        Chuck Lever <chuck.lever@oracle.com>
Message-ID: <1449034832.11389942.1620163955863.JavaMail.zimbra@dneg.com>
In-Reply-To: <20210504165120.GA18746@fieldses.org>
References: <20201007140502.GC23452@fieldses.org> <20210119222229.GA29488@fieldses.org> <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com> <20210120150737.GA17548@fieldses.org> <20210503200952.GB18779@fieldses.org> <162009412979.28954.17703105649506010394@noble.neil.brown.name> <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com> <20210504165120.GA18746@fieldses.org>
Subject: Re: unsharing tcp connections from different NFS mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - GC78 (Linux)/9.0.0_GA_3990)
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: 9tJvXxXuAZdm+t5VWLUO3PyPPWuGQQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

For what it's worth, I mentioned this on the associated redhat bugzilla but I'll replicate it here - I *think* this issue (bulk reads/writes starving getattrs etc) is one of the issues I was trying to describe in my re-export thread:

https://marc.info/?l=linux-nfs&m=160077787901987&w=4

Long story short, when we have already read lots of data into a client's pagecache (or fscache/cachefiles), you can't reuse it again later until you do some metadata lookups to re-validate. But if we are also continually filling the client cache with new data (lots of reads) as fast as possible, we starve the other processes (in my case - knfsd re-export threads) from processing the re-validate lookups/getattrs in a timely manner.

We have lots of previously cached data but we can't use it for a long time because we can't get the getattrs out and replied to quickly.

When I was testing the client behaviour, it didn't seem like nconnect or NFSv3/NFSv4.2 made much difference to the behaviour - metadata lookups from another client process to the same mountpoint slowed to a crawl when a process had reads dominating the network pipe.

I also found that maxing out the client's network bandwidth really showed this effect best. Either by saturating a client's physical network link or, in the case of reads, using an ingress qdisc + htb on the client to simulate a saturated low speed network.

In all cases where the client's network is (read) saturated (physically or using a qdisc), the metadata performance from another process becomes really poor. If I mount a completely different server on the same client, the metadata performance to that new second server is much better despite the ongoing network saturation caused by the continuing reads from the first server.

I don't know if that helps much, but it was my observation when I last looked at this.

I'd really love to see any kind of improvement to this behaviour as it's a real shame we can't serve cached data quickly when all the cache re-validations (getattrs) are stuck behind bulk IO that just seems to plow through everything else.

Daire

----- On 4 May, 2021, at 17:51, bfields bfields@fieldses.org wrote:

> Thanks very much to all of you for the explanations and concrete
> suggestions for things to look at, I feel much less stuck!
> 
> --b.
> 
> On Tue, May 04, 2021 at 02:27:04PM +0000, Trond Myklebust wrote:
>> On Tue, 2021-05-04 at 12:08 +1000, NeilBrown wrote:
>> > On Tue, 04 May 2021, bfields@fieldses.org wrote:
>> > > On Wed, Jan 20, 2021 at 10:07:37AM -0500, bfields@fieldses.org wrote:
>> > > > 
>> > > > So mainly:
>> > > > 
>> > > > > > > Why is there a performance regression being seen by these
>> > > > > > > setups
>> > > > > > > when they share the same connection? Is it really the
>> > > > > > > connection,
>> > > > > > > or is it the fact that they all share the same fixed-slot
>> > > > > > > session?
>> > > > 
>> > > > I don't know.  Any pointers how we might go about finding the
>> > > > answer?
>> > > 
>> > > I set this aside and then get bugged about it again.
>> > > 
>> > > I apologize, I don't understand what you're asking for here, but it
>> > > seemed obvious to you and Tom, so I'm sure the problem is me.  Are
>> > > you
>> > > free for a call sometime maybe?  Or do you have any suggestions for
>> > > how
>> > > you'd go about investigating this?
>> > 
>> > I think a useful first step would be to understand what is getting in
>> > the way of the small requests.
>> >  - are they in the client waiting for slots which are all consumed by
>> >    large writes?
>> >  - are they in TCP stream behind megabytes of writes that need to be
>> >    consumed before they can even be seen by the server?
>> >  - are they in a socket buffer on the server waiting to be served
>> >    while all the nfsd thread are busy handling writes?
>> > 
>> > I cannot see an easy way to measure which it is.
>> 
>> The nfs4_sequence_done tracepoint will give you a running count of the
>> highest slot id in use.
>> 
>> The mountstats 'execute time' will give you the time between the
>> request being created and the time a reply was received. That time
>> includes the time spent waiting for a NFSv4 session slot.
>> 
>> The mountstats 'backlog wait' will tell you the time spent waiting for
>> an RPC slot after obtaining the NFSv4 session slot.
>> 
>> The mountstats 'RTT' will give you the time spend waiting for the RPC
>> request to be received, processed and replied to by the server.
>> 
>> Finally, the mountstats also tell you average per-op bytes sent/bytes
>> received.
>> 
>> IOW: The mountstats really gives you almost all the information you
>> need here, particularly if you use it in the 'interval reporting' mode.
>> The only thing it does not tell you is whether or not the NFSv4 session
>> slot table is full (which is why you want the tracepoint).
>> 
>> > I guess monitoring how much of the time that the client has no free
>> > slots might give hints about the first.  If there are always free
>> > slots,
>> > the first case cannot be the problem.
>> > 
>> > With NFSv3, the slot management happened at the RPC layer and there
>> > were
>> > several queues (RPC_PRIORITY_LOW/NORMAL/HIGH/PRIVILEGED) where requests
>> > could wait for a free slot.  Since we gained dynamic slot allocation -
>> > up to 65536 by default - I wonder if that has much effect any more.
>> > 
>> > For NFSv4.1+ the slot management is at the NFS level.  The server sets
>> > a
>> > maximum which defaults to (maybe is limited to) 1024 by the Linux
>> > server.
>> > So there are always free rpc slots.
>> > The Linux client only has a single queue for each slot table, and I
>> > think there is one slot table for the forward channel of a session.
>> > So it seems we no longer get any priority management (sync writes used
>> > to get priority over async writes).
>> > 
>> > Increasing the number of slots advertised by the server might be
>> > interesting.  It is unlikely to fix anything, but it might move the
>> > bottle-neck.
>> > 
>> > Decreasing the maximum of number of tcp slots might also be interesting
>> > (below the number of NFS slots at least).
>> > That would allow the RPC priority infrastructure to work, and if the
>> > large-file writes are async, they might gets slowed down.
>> > 
>> > If the problem is in the TCP stream (which is possible if the relevant
>> > network buffers are bloated), then you'd really need multiple TCP
>> > streams
>> > (which can certainly improve throughput in some cases).  That is what
>> > nconnect give you.  nconnect does minimal balancing.  It general it
>> > will
>> > round-robin, but if the number of requests (not bytes) queued on one
>> > socket is below average, that socket is likely to get the next request.
>> 
>> It's not round-robin. Transports are allocated to a new RPC request
>> based on a measure of their queue length in order to skip over those
>> that show signs of above average congestion.
>> 
>> > So just adding more connections with nconnect is unlikely to help.
>> > You
>> > would need to add a policy engine (struct rpc_xpr_iter_ops) which
>> > reserves some connections for small requests.  That should be fairly
>> > easy to write a proof-of-concept for.
>> 
>> Ideally we would want to tie into cgroups as the control mechanism so
>> that NFS can be treated like any other I/O resource.
>> 
>> > 
>> > NeilBrown
>> > 
>> > 
>> > > 
>> > > Would it be worth experimenting with giving some sort of advantage
>> > > to
>> > > readers?  (E.g., reserving a few slots for reads and getattrs and
>> > > such?)
>> > > 
>> > > --b.
>> > > 
>> > > > It's easy to test the case of entirely seperate state & tcp
>> > > > connections.
>> > > > 
>> > > > If we want to test with a shared connection but separate slots I
>> > > > guess
>> > > > we'd need to create a separate session for each nfs4_server, and
>> > > > a lot
>> > > > of functions that currently take an nfs4_client would need to
>> > > > take an
>> > > > nfs4_server?
>> > > > 
>> > > > --b.
>> > > 
>> > > 
>> 
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>> 
