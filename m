Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9A372E43
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEDQwT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 May 2021 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhEDQwS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 May 2021 12:52:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DDC061574
        for <linux-nfs@vger.kernel.org>; Tue,  4 May 2021 09:51:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5B57C5047; Tue,  4 May 2021 12:51:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5B57C5047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620147080;
        bh=G50LlsyiBAyw0EHBP8O4WNvAiz8M/h4lrOuvua2uqEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsQFxzHKIYNm5P7Mbrmv4ExtU584BA9RZhJ/kNwi2QhWvGeJQdSOwvuFGraqbZFMw
         T3VhngTezIMcgXmDsJ+eGLPS5D2FzQDGuxEiRoWwfFCuLfOdV24B61FLvAreOE3uyq
         4icZL7UWhep5dCNkHSZqfRUG9IUvl+TybRvwY0W8=
Date:   Tue, 4 May 2021 12:51:20 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20210504165120.GA18746@fieldses.org>
References: <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
 <20210119222229.GA29488@fieldses.org>
 <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>
 <20210120150737.GA17548@fieldses.org>
 <20210503200952.GB18779@fieldses.org>
 <162009412979.28954.17703105649506010394@noble.neil.brown.name>
 <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks very much to all of you for the explanations and concrete
suggestions for things to look at, I feel much less stuck!

--b.

On Tue, May 04, 2021 at 02:27:04PM +0000, Trond Myklebust wrote:
> On Tue, 2021-05-04 at 12:08 +1000, NeilBrown wrote:
> > On Tue, 04 May 2021, bfields@fieldses.org wrote:
> > > On Wed, Jan 20, 2021 at 10:07:37AM -0500, bfields@fieldses.org wrote:
> > > > 
> > > > So mainly:
> > > > 
> > > > > > > Why is there a performance regression being seen by these
> > > > > > > setups
> > > > > > > when they share the same connection? Is it really the
> > > > > > > connection,
> > > > > > > or is it the fact that they all share the same fixed-slot
> > > > > > > session?
> > > > 
> > > > I don't know.  Any pointers how we might go about finding the
> > > > answer?
> > > 
> > > I set this aside and then get bugged about it again.
> > > 
> > > I apologize, I don't understand what you're asking for here, but it
> > > seemed obvious to you and Tom, so I'm sure the problem is me.  Are
> > > you
> > > free for a call sometime maybe?  Or do you have any suggestions for
> > > how
> > > you'd go about investigating this?
> > 
> > I think a useful first step would be to understand what is getting in
> > the way of the small requests.
> >  - are they in the client waiting for slots which are all consumed by
> >    large writes?
> >  - are they in TCP stream behind megabytes of writes that need to be
> >    consumed before they can even be seen by the server?
> >  - are they in a socket buffer on the server waiting to be served
> >    while all the nfsd thread are busy handling writes?
> > 
> > I cannot see an easy way to measure which it is.
> 
> The nfs4_sequence_done tracepoint will give you a running count of the
> highest slot id in use.
> 
> The mountstats 'execute time' will give you the time between the
> request being created and the time a reply was received. That time
> includes the time spent waiting for a NFSv4 session slot.
> 
> The mountstats 'backlog wait' will tell you the time spent waiting for
> an RPC slot after obtaining the NFSv4 session slot.
> 
> The mountstats 'RTT' will give you the time spend waiting for the RPC
> request to be received, processed and replied to by the server.
> 
> Finally, the mountstats also tell you average per-op bytes sent/bytes
> received.
> 
> IOW: The mountstats really gives you almost all the information you
> need here, particularly if you use it in the 'interval reporting' mode.
> The only thing it does not tell you is whether or not the NFSv4 session
> slot table is full (which is why you want the tracepoint).
> 
> > I guess monitoring how much of the time that the client has no free
> > slots might give hints about the first.  If there are always free
> > slots,
> > the first case cannot be the problem.
> > 
> > With NFSv3, the slot management happened at the RPC layer and there
> > were
> > several queues (RPC_PRIORITY_LOW/NORMAL/HIGH/PRIVILEGED) where requests
> > could wait for a free slot.  Since we gained dynamic slot allocation -
> > up to 65536 by default - I wonder if that has much effect any more.
> > 
> > For NFSv4.1+ the slot management is at the NFS level.  The server sets
> > a
> > maximum which defaults to (maybe is limited to) 1024 by the Linux
> > server.
> > So there are always free rpc slots.
> > The Linux client only has a single queue for each slot table, and I
> > think there is one slot table for the forward channel of a session.
> > So it seems we no longer get any priority management (sync writes used
> > to get priority over async writes).
> > 
> > Increasing the number of slots advertised by the server might be
> > interesting.  It is unlikely to fix anything, but it might move the
> > bottle-neck.
> > 
> > Decreasing the maximum of number of tcp slots might also be interesting
> > (below the number of NFS slots at least). 
> > That would allow the RPC priority infrastructure to work, and if the
> > large-file writes are async, they might gets slowed down.
> > 
> > If the problem is in the TCP stream (which is possible if the relevant
> > network buffers are bloated), then you'd really need multiple TCP
> > streams
> > (which can certainly improve throughput in some cases).  That is what
> > nconnect give you.  nconnect does minimal balancing.  It general it
> > will
> > round-robin, but if the number of requests (not bytes) queued on one
> > socket is below average, that socket is likely to get the next request.
> 
> It's not round-robin. Transports are allocated to a new RPC request
> based on a measure of their queue length in order to skip over those
> that show signs of above average congestion.
> 
> > So just adding more connections with nconnect is unlikely to help. 
> > You
> > would need to add a policy engine (struct rpc_xpr_iter_ops) which
> > reserves some connections for small requests.  That should be fairly
> > easy to write a proof-of-concept for.
> 
> Ideally we would want to tie into cgroups as the control mechanism so
> that NFS can be treated like any other I/O resource.
> 
> > 
> > NeilBrown
> > 
> > 
> > > 
> > > Would it be worth experimenting with giving some sort of advantage
> > > to
> > > readers?  (E.g., reserving a few slots for reads and getattrs and
> > > such?)
> > > 
> > > --b.
> > > 
> > > > It's easy to test the case of entirely seperate state & tcp
> > > > connections.
> > > > 
> > > > If we want to test with a shared connection but separate slots I
> > > > guess
> > > > we'd need to create a separate session for each nfs4_server, and
> > > > a lot
> > > > of functions that currently take an nfs4_client would need to
> > > > take an
> > > > nfs4_server?
> > > > 
> > > > --b.
> > > 
> > > 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
