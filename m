Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A510568E39
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiGFPum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiGFPuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 11:50:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065026AF8
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 08:46:11 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E89DD6135; Wed,  6 Jul 2022 11:46:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E89DD6135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657122369;
        bh=Gg3teNCOXop1YT4elnErKKnSZb/IJbZHDgkmY+lgCjI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=H5aiPljiquCg49Bm5sdFg5ibKE1OnXPBMXzq5k0sshUPGs6Pby00ootJmEdWc4Osy
         AbiJRztlOEm0qp1MMlLg6GdBZfmtCr/pCHfQm6MyhQjP5I9jXgLxc7F52JC8dhfXOq
         tQjQp3emObVgVy18uFhffuWAgPo7CImIbIsyfT/s=
Date:   Wed, 6 Jul 2022 11:46:09 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Message-ID: <20220706154609.GA29941@fieldses.org>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
 <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
 <61f067af-f634-e9fd-a0e5-4ee70c9e0887@oracle.com>
 <B9CE5633-5A78-4F94-B653-D6348B8A229D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9CE5633-5A78-4F94-B653-D6348B8A229D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 05, 2022 at 07:08:32PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 5, 2022, at 2:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > 
> > On 7/5/22 7:50 AM, Chuck Lever III wrote:
> >> Hello Dai -
> >> 
> >> I agree that tackling resource management is indeed an appropriate
> >> next step for courteous server. Thanks for tackling this!
> >> 
> >> More comments are inline.
> >> 
> >> 
> >>> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>> 
> >>> Currently the idle timeout for courtesy client is fixed at 1 day. If
> >>> there are lots of courtesy clients remain in the system it can cause
> >>> memory resource shortage that effects the operations of other modules
> >>> in the kernel. This problem can be observed by running pynfs nfs4.0
> >>> CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
> >>> fails to add new watch:
> >>> 
> >>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
> >>> No space left on device
> >>> 
> >>> and alloc_inode also fails with out of memory:
> >>> 
> >>> Call Trace:
> >>> <TASK>
> >>> dump_stack_lvl+0x33/0x42
> >>> dump_header+0x4a/0x1ed
> >>> oom_kill_process+0x80/0x10d
> >>> out_of_memory+0x237/0x25f
> >>> __alloc_pages_slowpath.constprop.0+0x617/0x7b6
> >>> __alloc_pages+0x132/0x1e3
> >>> alloc_slab_page+0x15/0x33
> >>> allocate_slab+0x78/0x1ab
> >>> ? alloc_inode+0x38/0x8d
> >>> ___slab_alloc+0x2af/0x373
> >>> ? alloc_inode+0x38/0x8d
> >>> ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
> >>> ? alloc_inode+0x38/0x8d
> >>> __slab_alloc.constprop.0+0x1c/0x24
> >>> kmem_cache_alloc_lru+0x8c/0x142
> >>> alloc_inode+0x38/0x8d
> >>> iget_locked+0x60/0x126
> >>> kernfs_get_inode+0x18/0x105
> >>> kernfs_iop_lookup+0x6d/0xbc
> >>> __lookup_slow+0xb7/0xf9
> >>> lookup_slow+0x3a/0x52
> >>> walk_component+0x90/0x100
> >>> ? inode_permission+0x87/0x128
> >>> link_path_walk.part.0.constprop.0+0x266/0x2ea
> >>> ? path_init+0x101/0x2f2
> >>> path_lookupat+0x4c/0xfa
> >>> filename_lookup+0x63/0xd7
> >>> ? getname_flags+0x32/0x17a
> >>> ? kmem_cache_alloc+0x11f/0x144
> >>> ? getname_flags+0x16c/0x17a
> >>> user_path_at_empty+0x37/0x4b
> >>> do_readlinkat+0x61/0x102
> >>> __x64_sys_readlinkat+0x18/0x1b
> >>> do_syscall_64+0x57/0x72
> >>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >> These details are a little distracting. IMO you can summarize
> >> the above with just this:
> >> 
> >>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
> >>>> there are lots of courtesy clients remain in the system it can cause
> >>>> memory resource shortage. This problem can be observed by running
> >>>> pynfs nfs4.0 CID5 test in a loop.
> >> 
> >> 
> >> Now I'm going to comment in reverse order here. To add context
> >> for others on-list, when we designed courteous server, we had
> >> assumed that eventually a shrinker would be used to garbage
> >> collect courtesy clients. Dai has found some issues with that
> >> approach:
> >> 
> >> 
> >>> The shrinker method was evaluated and found it's not suitable
> >>> for this problem due to these reasons:
> >>> 
> >>> . destroying the NFSv4 client on the shrinker context can cause
> >>> deadlock since nfsd_file_put calls into the underlying FS
> >>> code and we have no control what it will do as seen in this
> >>> stack trace:
> >> [ ... stack trace snipped ... ]
> >> 
> >> I think I always had in mind that only the laundromat would be
> >> responsible for harvesting courtesy clients. A shrinker might
> >> trigger that activity, but as you point out, a deadlock is pretty
> >> likely if the shrinker itself had to do the harvesting.
> >> 
> >> 
> >>> . destroying the NFSv4 client has significant overhead due to
> >>> the upcall to user space to remove the client records which
> >>> might access storage device. There is potential deadlock
> >>> if the storage subsystem needs to allocate memory.
> >> The issue is that harvesting a courtesy client will involve
> >> an upcall to nfsdcltracker, and that will result in I/O that
> >> updates the tracker's database. Very likely this will require
> >> further allocation of memory and thus it could deadlock the
> >> system.
> >> 
> >> Now this might also be all the demonstration that we need
> >> that managing courtesy resources cannot be done using the
> >> system's shrinker facility -- expiring a client can never
> >> be done when there is a direct reclaim waiting on it. I'm
> >> interested in other opinions on that. Neil? Bruce? Trond?
> >> 
> >> 
> >>> . the shrinker kicks in only when memory drops really low, ~<5%.
> >>> By this time, some other components in the system already run
> >>> into issue with memory shortage. For example, rpc.gssd starts
> >>> failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
> >>> once the memory consumed by these watches reaches about 1% of
> >>> available system memory.
> >> Your claim is that a courtesy client shrinker would be invoked
> >> too late. That might be true on a server with 2GB of RAM, but
> >> on a big system (say, a server with 64GB of RAM), 5% is still
> >> more than 3GB -- wouldn't that be enough to harvest safely?
> >> 
> >> We can't optimize for tiny server systems because that almost
> >> always hobbles the scalability of larger systems for no good
> >> reason. Can you test with a large-memory server as well as a
> >> small-memory server?
> > 
> > I don't have a system with large memory configuration, my VM has
> > only 6GB of memory.
> 
> Let's ask internally. Maybe Barry's group has a big system it
> can lend us.
> 
> 
> >> I think the central question here is why is 5% not enough on
> >> all systems. I would like to understand that better. It seems
> >> like a primary scalability question that needs an answer so
> >> a good harvesting heuristic can be derived.
> >> 
> >> One question in my mind is what is the maximum rate at which
> >> the server converts active clients to courtesy clients, and
> >> can the current laundromat scheme keep up with harvesting them
> >> at that rate? The destructive scenario seems to be when courtesy
> >> clients are manufactured faster than they can be harvested and
> >> expunged.
> > 
> > That seems to be the case. Currently the laundromat destroys idle
> > courtesy clients after 1 day and running CID5 in a loop generates
> > a ton of courtesy clients. Before the 1-day expiration occurs,
> > memory already drops to almost <1% and problems with rpc.gssd and
> > memory allocation were seen as mentioned above.
> 
> The issue is not the instantaneous amount of memory available,
> it's the change in free memory. If available memory is relatively
> constant, even if it's at 25%, there's no reason to trim the
> courtesy list. The problem arises when the number of courtesy
> clients is increasing quickly.
> 
> 
> > 
> >> 
> >> (Also I recall Bruce fixed a problem recently with nfsdcltracker
> >> where it was doing three fsync's for every database update,
> >> which significantly slowed it down. You should look for that
> >> fix in nfs-utils and ensure the above rate measurement is done
> >> with the fix applied).
> > 
> > will do.
> > 
> >> 
> >> 
> >>> This patch addresses this problem by:
> >>> 
> >>> . removing the fixed 1-day idle time limit for courtesy client.
> >>> Courtesy client is now allowed to remain valid as long as the
> >>> available system memory is above 80%.
> >>> 
> >>> . when available system memory drops below 80%, laundromat starts
> >>> trimming older courtesy clients. The number of courtesy clients
> >>> to trim is a percentage of the total number of courtesy clients
> >>> exist in the system. This percentage is computed based on
> >>> the current percentage of available system memory.
> >>> 
> >>> . the percentage of number of courtesy clients to be trimmed
> >>> is based on this table:
> >>> 
> >>> ----------------------------------
> >>> | % memory | % courtesy clients |
> >>> | available | to trim |
> >>> ----------------------------------
> >>> | > 80 | 0 |
> >>> | > 70 | 10 |
> >>> | > 60 | 20 |
> >>> | > 50 | 40 |
> >>> | > 40 | 60 |
> >>> | > 30 | 80 |
> >>> | < 30 | 100 |
> >>> ----------------------------------
> >> "80% available memory" on a big system means there's still an
> >> enormous amount of free memory on that system. It will be
> >> surprising to administrators on those systems if the laundromat
> >> is harvesting courtesy clients at that point.
> > 
> > at 80% and above there is no harvesting going on.
> 
> You miss my point. Even 30% available on a big system is still
> a lot of memory and not a reason (in itself) to start trimming.
> 
> 
> >> Also, if a server is at 60-70% free memory all the time due to
> >> non-NFSD-related memory consumption, would that mean that the
> >> laundromat would always trim courtesy clients, even though doing
> >> so would not be needed or beneficial?
> > 
> > it's true that there is no benefit to harvest courtesy clients
> > at 60-70% if the available memory stays in this range. But we
> > don't know whether available memory will stay in this range or
> > it will continue to drop (as in my test case with CID5). Shouldn't
> > we start harvest some of the courtesy clients at this point to
> > be on the safe side?
> 
> The Linux philosophy is to let the workload take as many resources
> as it can. The common case is that workload resident sets nearly
> always reside comfortably within available resources, so garbage
> collection that happens too soon is wasted effort and can even
> have negative impact.

In this particular case (pynfs with repeated CID5), I think each client
is an NFSv4.0 client with a single open.  I wonder how much memory that
ends up using per client?  The client itself is only 1k, the inode,
file, dentry, nfs4 stateid, etc., probably add a few more k.  If you're
filling up gigabytes of memory with that, then you may be talking about
10s-hundreds of thousands of clients, which your server probably can't
handle well anyway, and the bigger problem may be that at a synchronous
file write per client you're going to be waiting a long time to expire
them all.

I wonder what more realistic cases might look like?

In the 4.1 case you'll probably run into the session limits first.
Maybe nfsd4_get_drc_mem should be able to suggest purging courtesy
clients?

In the 4.0 case maybe we're more at risk of blowing up the nfs4 file
cache?

> The other side of that coin is that when we hit the knee, a Linux
> system is easy to push into thrashing because then it will start
> pushing things out desperately. That's kind of the situation I
> would like to avoid, but I don't think trimming when there is
> more than half of memory available is the answer.

I dunno, a (possibly somewhat arbitrary) limit on the number of courtesy
clients doesn't sound so bad to me, especially since we know the IO
required to expire them is proportional to that number.

--b.
