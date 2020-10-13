Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46D628CB53
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Oct 2020 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgJMJ73 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Oct 2020 05:59:29 -0400
Received: from natter.dneg.com ([193.203.89.68]:45802 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJMJ72 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:59:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 38AF45F99B82;
        Tue, 13 Oct 2020 10:59:27 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2QJx7Qlwh_to; Tue, 13 Oct 2020 10:59:27 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 172CB5F99B63;
        Tue, 13 Oct 2020 10:59:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 082968178CD1;
        Tue, 13 Oct 2020 10:59:27 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Chhs8a4AZDh3; Tue, 13 Oct 2020 10:59:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id DF7E38178CD7;
        Tue, 13 Oct 2020 10:59:26 +0100 (BST)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ubUvb4XBogFZ; Tue, 13 Oct 2020 10:59:26 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id AD65A8178CD3;
        Tue, 13 Oct 2020 10:59:26 +0100 (BST)
Date:   Tue, 13 Oct 2020 10:59:26 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Message-ID: <1855231972.64370906.1602583166516.JavaMail.zimbra@dneg.com>
In-Reply-To: <1106572445.58581277.1601902473249.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com> <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org> <1309604906.55950004.1601510969548.JavaMail.zimbra@dneg.com> <3243730b0661de0ac0864a9bb5375f894b266220.camel@kernel.org> <1106572445.58581277.1601902473249.JavaMail.zimbra@dneg.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: SJYUJ1ENNzjjKc9SpmlFRz6CAFOPCVm47Rau
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 5 Oct, 2020, at 13:54, Daire Byrne daire@dneg.com wrote:
> ----- On 1 Oct, 2020, at 11:36, Jeff Layton jlayton@kernel.org wrote:
> 
>> On Thu, 2020-10-01 at 01:09 +0100, Daire Byrne wrote:
>>> ----- On 30 Sep, 2020, at 20:30, Jeff Layton jlayton@kernel.org wrote:
>>> 
>>> > On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
>>> > > Hi,
>>> > > 
>>> > > I just thought I'd flesh out the other two issues I have found with re-exporting
>>> > > that are ultimately responsible for the biggest performance bottlenecks. And
>>> > > both of them revolve around the caching of metadata file lookups in the NFS
>>> > > client.
>>> > > 
>>> > > Especially for the case where we are re-exporting a server many milliseconds
>>> > > away (i.e. on-premise -> cloud), we want to be able to control how much the
>>> > > client caches metadata and file data so that it's many LAN clients all benefit
>>> > > from the re-export server only having to do the WAN lookups once (within a
>>> > > specified coherency time).
>>> > > 
>>> > > Keeping the file data in the vfs page cache or on disk using fscache/cachefiles
>>> > > is fairly straightforward, but keeping the metadata cached is particularly
>>> > > difficult. And without the cached metadata we introduce long delays before we
>>> > > can serve the already present and locally cached file data to many waiting
>>> > > clients.
>>> > > 
>>> > > ----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com wrote:
>>> > > > 2) If we cache metadata on the re-export server using actimeo=3600,nocto we can
>>> > > > cut the network packets back to the origin server to zero for repeated lookups.
>>> > > > However, if a client of the re-export server walks paths and memory maps those
>>> > > > files (i.e. loading an application), the re-export server starts issuing
>>> > > > unexpected calls back to the origin server again, ignoring/invalidating the
>>> > > > re-export server's NFS client cache. We worked around this this by patching an
>>> > > > inode/iversion validity check in inode.c so that the NFS client cache on the
>>> > > > re-export server is used. I'm not sure about the correctness of this patch but
>>> > > > it works for our corner case.
>>> > > 
>>> > > If we use actimeo=3600,nocto (say) to mount a remote software volume on the
>>> > > re-export server, we can successfully cache the loading of applications and
>>> > > walking of paths directly on the re-export server such that after a couple of
>>> > > runs, there are practically zero packets back to the originating NFS server
>>> > > (great!). But, if we then do the same thing on a client which is mounting that
>>> > > re-export server, the re-export server now starts issuing lots of calls back to
>>> > > the originating server and invalidating it's client cache (bad!).
>>> > > 
>>> > > I'm not exactly sure why, but the iversion of the inode gets changed locally
>>> > > (due to atime modification?) most likely via invocation of method
>>> > > inode_inc_iversion_raw. Each time it gets incremented the following call to
>>> > > validate attributes detects changes causing it to be reloaded from the
>>> > > originating server.
>>> > > 
>>> > 
>>> > I'd expect the change attribute to track what's in actual inode on the
>>> > "home" server. The NFS client is supposed to (mostly) keep the raw
>>> > change attribute in its i_version field.
>>> > 
>>> > The only place we call inode_inc_iversion_raw is in
>>> > nfs_inode_add_request, which I don't think you'd be hitting unless you
>>> > were writing to the file while holding a write delegation.
>>> > 
>>> > What sort of server is hosting the actual data in your setup?
>>> 
>>> We mostly use RHEL7.6 NFS servers with XFS backed filesystems and a couple of
>>> (older) Netapps too. The re-export server is running the latest mainline
>>> kernel(s).
>>> 
>>> As far as I can make out, both these originating (home) server types exhibit a
>>> similar (but not exactly the same) effect on the Linux NFS client cache when it
>>> is being re-exported and accessed by other clients. I can replicate it when
>>> only using a read-only mount at every hop so I don't think that writes are
>>> related.
>>> 
>>> Our RHEL7 NFS servers actually mount XFS with noatime too so any atime updates
>>> that might be causing this client invalidation (which is what I initially
>>> thought) are ultimately a wasted effort.
>>> 
>> 
>> Ok. I suspect there is a bug here somewhere, but with such a complicated
>> setup though it's not clear to me where that bug would be though. You
>> might need to do some packet sniffing and look at what the servers are
>> sending for change attributes.
>> 
>> nfsd4_change_attribute does mix in the ctime, so your hunch about the
>> atime may be correct. atime updates imply a ctime update and that could
>> cause nfsd to continually send a new one, even on files that aren't
>> being changed.
>> 
>> It might be interesting to doctor nfsd4_change_attribute() to not mix in
>> the ctime and see whether that improves things. If it does, then we may
>> want to teach nfsd how to avoid doing that for certain types of
>> filesystems.
> 
> Okay, I started to run back through all my tests again with various combinations
> of server, client mount options, NFS version etc. with the intention of packet
> capturing as Jeff has suggested.
> 
> But I quickly realised that I had mixed up some previous results before I
> reported them here. The summary is that using an NFS RHEL76 server, a client
> mounting with a recent mainline kernel and re-exporting using NFSv4.x all the
> way through does NOT invalidate the re-export server's NFS client cache
> (great!) like I had assumed before. It does when we mount the originating RHEL7
> server using NFSv3 and re-export, but not with any version of NFSv4 on Linux.
> 
> But I think I know how I got confused - the Netapp NFSv4 case is different. When
> we mount our (old) 7-mode Netapp using NFSv4.0 and re-export that, the
> re-export server's client cache is invalidated often in the same way as for an
> NFSv3 server. On top of that, I think I wrongly mistook some of the NFSv4
> client's natural dropping of metadata from page cache as client invalidations
> caused by the re-export and client access (without vfs_cache_pressure=0 and see
> my #3 bullet point).
> 
> Both of these conspired to make me think that both NFSv3 AND NFSv4 re-exporting
> showed the same issue when in fact, it's just NFSv3 and the Netapp's v4.0 that
> require my "hack" to stop the client cache being invalidated. Sorry for any
> confusion (it is indeed a complicated setup!). Let me summarise then once and
> for all:
> 
> rhel76 server (xfs noatime) -> re-export server (vers=4.x,nocto,actimeo=3600,ro;
> vfs_cache_pressure=0) = good client cache metadata performance, my hacky patch
> is not required.
> rhel76 server (xfs noatime) -> re-export server (vers=3,nocto,actimeo=3600,ro;
> vfs_cache_pressure=0) = bad performance (new lookups & getattrs), my hacky
> patch is required for better performance.
> netapp (7-mode) -> re-export server (vers=4.0,nocto,actimeo=3600,ro;
> vfs_cache_pressure=0) = bad performance, my hacky patch is required for better
> performance.
> 
> So for Jeff's original intention of proxying a NFSv3 server -> NFSv4 clients by
> re-exporting, the metadata lookup performance will degrade severely as more
> clients access the same files because the re-export server's client cache is
> not being used as effectively (re-exported) and lookups are happening for the
> same files many times within the re-export server's actimeo even with
> vfs_cache_pressure=0.
> 
> For our particular use case, we could live without NFSv3 (and my horrible hack)
> except for the fact that the Netapp shows similar behaviour with NFSv4.0 (but
> Linux servers do not). I don't know if turning off atime updates on the Netapp
> volume will change anything - I might try it. Of course, re-exporting NFSv3
> with good meatadata cache performance is still a nice thing to have too.
> 
> I'll now see if I can decipher the network calls back to the Netapp (NFSv4.0) as
> suggested by Jeff to see why it is different.

I did a little more digging and the big jump in client ops on the re-export server back to the originating Netapp using NFSv4.0 seems to be mostly because it is issuing lots of READDIR calls. The same workload to a Linux NFS server does not issue a single READDIR/READDIRPLUS call (once cached). As to why these are not cached in the client for repeated lookups (without my hack), I have no idea.

However, I was eventually able to devise a workload that could also cause the NFSv4.2 client cache on the re-export server to unexpectedly "lose" entries such that it needed to reissue calls back to an originating Linux server. A large proportion of these were NFS4ERR_NOENT (but not all) so I don't know if maybe it is something specific to the negative entry cache.

It is really hard following the packets from the re-export's client through the re-export server and on to the originating server, but as far as I can make out, it was mostly issuing access/lookup/getattr for directories (that should already be cached) when the re-export server's clients are issuing calls like readlink (for example resolving a library directory with symlinks).

I have also noticed another couple of new curiosities. If we run a typical small workload against a client mount such that it is all cached for repeat runs and then re-export that same directory to a remote client and run the same workload, the reads that should already be cached are all fetched again from the originating server. Only then are they are cached for repeat runs or for different clients. It's almost like the NFS client cache on the re-export server sees the locally accessed client mount as a different filesystem (and cache) to the knfsd re-exported one. A consequence of embedding the filehandles?

And while looking at the packet traces for this, I also noticed that when re-exported to a client, all the read calls back to the originating server are being chopped up into a maximum of 128k. It's as if I had mounted the originating server using rsize=131072 (it's definitely 1MB). So a client of the re-export server is receiving rsize=1MB reads, but the re-export server is pulling them from the originating server in 128k chunks. This was using NFSV4.2 all the way through.

Is this an expected side-effect of re-exporting? Is it some weird interaction with the nfs client's readahead? It has the effect of large reads requiring 8x more round-trips for re-export clients than if they had just gone direct to the originating server (and gotten 1MB reads).

Daire
