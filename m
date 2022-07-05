Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0085676D0
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGESsc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiGESsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 14:48:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6E17051
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 11:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0658FB818C2
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 18:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C9C341C7;
        Tue,  5 Jul 2022 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657046907;
        bh=4LjFN2K0KdetIqRDoO2DwCRTinT+8SFBMQm7eMvPQiI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xms/iGjrgwIXnZL842rssWOpLgIB6dqotaZWdiNKq7AK43P2i5BsoRb5BdXXFb38+
         +qdeKZ7jSB/wReow8NU0zS4E0BZVWiCOD1Il3Pdye1SValj0uXOjYPsctHfRSdfuoL
         FY43U12aDgUnG199o6FUD6uufmE16QQZsdHr0F80CMX2bDJqVkpCWxrwKcKeJ1060y
         /cAJ/YgpXCuyuilFXH2UDVKHiHs2GJpHKVTGG6UWiiIBImGBeUYmgMY/O/m/UmoLtO
         W3QsCgmJ3JrS3YzzB2thWPBqyW6oKALswAahHGUqQ5OIq4wdRJ41SMQDNzaUiok+Iz
         3uTv1/kHSvs5Q==
Message-ID: <10a4bdd4526fade000f3468b9b8735d2402f5f0d.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 05 Jul 2022 14:48:25 -0400
In-Reply-To: <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
         <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-07-05 at 14:50 +0000, Chuck Lever III wrote:
> Hello Dai -
>=20
> I agree that tackling resource management is indeed an appropriate
> next step for courteous server. Thanks for tackling this!
>=20
> More comments are inline.
>=20
>=20
> > On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> > Currently the idle timeout for courtesy client is fixed at 1 day. If
> > there are lots of courtesy clients remain in the system it can cause
> > memory resource shortage that effects the operations of other modules
> > in the kernel. This problem can be observed by running pynfs nfs4.0
> > CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
> > fails to add new watch:
> >=20
> > rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
> >                No space left on device
> >=20
> > and alloc_inode also fails with out of memory:
> >=20
> > Call Trace:
> > <TASK>
> >        dump_stack_lvl+0x33/0x42
> >        dump_header+0x4a/0x1ed
> >        oom_kill_process+0x80/0x10d
> >        out_of_memory+0x237/0x25f
> >        __alloc_pages_slowpath.constprop.0+0x617/0x7b6
> >        __alloc_pages+0x132/0x1e3
> >        alloc_slab_page+0x15/0x33
> >        allocate_slab+0x78/0x1ab
> >        ? alloc_inode+0x38/0x8d
> >        ___slab_alloc+0x2af/0x373
> >        ? alloc_inode+0x38/0x8d
> >        ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
> >        ? alloc_inode+0x38/0x8d
> >        __slab_alloc.constprop.0+0x1c/0x24
> >        kmem_cache_alloc_lru+0x8c/0x142
> >        alloc_inode+0x38/0x8d
> >        iget_locked+0x60/0x126
> >        kernfs_get_inode+0x18/0x105
> >        kernfs_iop_lookup+0x6d/0xbc
> >        __lookup_slow+0xb7/0xf9
> >        lookup_slow+0x3a/0x52
> >        walk_component+0x90/0x100
> >        ? inode_permission+0x87/0x128
> >        link_path_walk.part.0.constprop.0+0x266/0x2ea
> >        ? path_init+0x101/0x2f2
> >        path_lookupat+0x4c/0xfa
> >        filename_lookup+0x63/0xd7
> >        ? getname_flags+0x32/0x17a
> >        ? kmem_cache_alloc+0x11f/0x144
> >        ? getname_flags+0x16c/0x17a
> >        user_path_at_empty+0x37/0x4b
> >        do_readlinkat+0x61/0x102
> >        __x64_sys_readlinkat+0x18/0x1b
> >        do_syscall_64+0x57/0x72
> >        entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> These details are a little distracting. IMO you can summarize
> the above with just this:
>=20
> > > Currently the idle timeout for courtesy client is fixed at 1 day. If
> > > there are lots of courtesy clients remain in the system it can cause
> > > memory resource shortage. This problem can be observed by running
> > > pynfs nfs4.0 CID5 test in a loop.
>=20
>=20
>=20
> Now I'm going to comment in reverse order here. To add context
> for others on-list, when we designed courteous server, we had
> assumed that eventually a shrinker would be used to garbage
> collect courtesy clients. Dai has found some issues with that
> approach:
>=20
>=20
> > The shrinker method was evaluated and found it's not suitable
> > for this problem due to these reasons:=20
> >=20
> > . destroying the NFSv4 client on the shrinker context can cause
> >  deadlock since nfsd_file_put calls into the underlying FS
> >  code and we have no control what it will do as seen in this
> >  stack trace:
>=20
> [ ... stack trace snipped ... ]
>=20
> I think I always had in mind that only the laundromat would be
> responsible for harvesting courtesy clients. A shrinker might
> trigger that activity, but as you point out, a deadlock is pretty
> likely if the shrinker itself had to do the harvesting.
>=20
>=20
> > . destroying the NFSv4 client has significant overhead due to
> >  the upcall to user space to remove the client records which
> >  might access storage device. There is potential deadlock
> >  if the storage subsystem needs to allocate memory.
>=20
> The issue is that harvesting a courtesy client will involve
> an upcall to nfsdcltracker, and that will result in I/O that
> updates the tracker's database. Very likely this will require
> further allocation of memory and thus it could deadlock the
> system.
>=20
> Now this might also be all the demonstration that we need
> that managing courtesy resources cannot be done using the
> system's shrinker facility -- expiring a client can never
> be done when there is a direct reclaim waiting on it. I'm
> interested in other opinions on that. Neil? Bruce? Trond?
>=20

That is potentially an ugly problem, but if you hit it then you really
are running the host at the redline.

Do you need to "shrink" synchronously? The scan_objects routine is
supposed to return the number of entries freed. We could (in principle)
always return 0, and wake up the laundromat to do the "real" shrinking.
It might not help out as much with direct reclaim, but it might still
help.

>=20
> > . the shrinker kicks in only when memory drops really low, ~<5%.
> >  By this time, some other components in the system already run
> >  into issue with memory shortage. For example, rpc.gssd starts
> >  failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
> >  once the memory consumed by these watches reaches about 1% of
> >  available system memory.
>=20
> Your claim is that a courtesy client shrinker would be invoked
> too late. That might be true on a server with 2GB of RAM, but
> on a big system (say, a server with 64GB of RAM), 5% is still
> more than 3GB -- wouldn't that be enough to harvest safely?
>=20
> We can't optimize for tiny server systems because that almost
> always hobbles the scalability of larger systems for no good
> reason. Can you test with a large-memory server as well as a
> small-memory server?
>=20
> I think the central question here is why is 5% not enough on
> all systems. I would like to understand that better. It seems
> like a primary scalability question that needs an answer so
> a good harvesting heuristic can be derived.
>=20
> One question in my mind is what is the maximum rate at which
> the server converts active clients to courtesy clients, and
> can the current laundromat scheme keep up with harvesting them
> at that rate? The destructive scenario seems to be when courtesy
> clients are manufactured faster than they can be harvested and
> expunged.
>=20
> (Also I recall Bruce fixed a problem recently with nfsdcltracker
> where it was doing three fsync's for every database update,
> which significantly slowed it down. You should look for that
> fix in nfs-utils and ensure the above rate measurement is done
> with the fix applied).
>=20
>=20
> > This patch addresses this problem by:
> >=20
> >   . removing the fixed 1-day idle time limit for courtesy client.
> >     Courtesy client is now allowed to remain valid as long as the
> >     available system memory is above 80%.
> >=20
> >   . when available system memory drops below 80%, laundromat starts
> >     trimming older courtesy clients. The number of courtesy clients
> >     to trim is a percentage of the total number of courtesy clients
> >     exist in the system.  This percentage is computed based on
> >     the current percentage of available system memory.
> >=20
> >   . the percentage of number of courtesy clients to be trimmed
> >     is based on this table:
> >=20
> >     ----------------------------------
> >     |  % memory | % courtesy clients |
> >     | available |    to trim         |
> >     ----------------------------------
> >     |  > 80     |      0             |
> >     |  > 70     |     10             |
> >     |  > 60     |     20             |
> >     |  > 50     |     40             |
> >     |  > 40     |     60             |
> >     |  > 30     |     80             |
> >     |  < 30     |    100             |
> >     ----------------------------------
>=20
> "80% available memory" on a big system means there's still an
> enormous amount of free memory on that system. It will be
> surprising to administrators on those systems if the laundromat
> is harvesting courtesy clients at that point.
>=20
> Also, if a server is at 60-70% free memory all the time due to
> non-NFSD-related memory consumption, would that mean that the
> laundromat would always trim courtesy clients, even though doing
> so would not be needed or beneficial?
>=20
> I don't think we can use a fixed percentage ladder like this;
> it might make sense for the CID5 test (or to stop other types of
> inadvertent or malicious DoS attacks) but the common case
> steady-state behavior doesn't seem very good.
>=20
> I don't recall, are courtesy clients maintained on an LRU so
> that the oldest ones would be harvested first? This mechanism
> seems to harvest at random?
>=20
>=20
> >   . due to the overhead associated with removing client record,
> >     there is a limit of 128 clients to be trimmed for each
> >     laundromat run. This is done to prevent the laundromat from
> >     spending too long destroying the clients and misses performing
> >     its other tasks in a timely manner.
> >=20
> >   . the laundromat is scheduled to run sooner if there are more
> >     courtesy clients need to be destroyed.
>=20
> Both of these last two changes seem sensible. Can they be
> broken out so they can be applied immediately?
>=20

I forget...is there a hard (or soft) cap on the number of courtesy
clients that can be in play at a time? Adding such a cap might be
another option if we're concerned about this.
--=20
Jeff Layton <jlayton@kernel.org>
