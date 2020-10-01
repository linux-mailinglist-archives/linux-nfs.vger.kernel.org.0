Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC328041B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgJAQjo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 12:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbgJAQjo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Oct 2020 12:39:44 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD97C2072E;
        Thu,  1 Oct 2020 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601570383;
        bh=IADk8ebl38/MAJx5nrLp8k98RP86nFcdWAgzzHWJdzk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wxl/GJXTy2jKMfetuTCRml3K72vSg9QcNUc77tYEffuJ7wsXbvzlxmbLL3svgrueM
         E89PohVrkN8cgcedyjHbAisB+AQpSiz3iin/jcOY/KHspWb7PuRB6fWuxQ/pO9hgrm
         LItUEg5Uj4HN2bwR8Y96TPZmsa2m4398AB1ufH5o=
Message-ID: <cab47436d0050570cafaf9c9c4a02ee6202215fd.camel@kernel.org>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "daire@dneg.com" <daire@dneg.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Thu, 01 Oct 2020 12:39:41 -0400
In-Reply-To: <7cdb496a2b77dd62b8e6373c28926f11a4816d49.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
         <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
         <1309604906.55950004.1601510969548.JavaMail.zimbra@dneg.com>
         <3243730b0661de0ac0864a9bb5375f894b266220.camel@kernel.org>
         <7cdb496a2b77dd62b8e6373c28926f11a4816d49.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-10-01 at 12:38 +0000, Trond Myklebust wrote:
> On Thu, 2020-10-01 at 06:36 -0400, Jeff Layton wrote:
> > On Thu, 2020-10-01 at 01:09 +0100, Daire Byrne wrote:
> > > ----- On 30 Sep, 2020, at 20:30, Jeff Layton jlayton@kernel.org
> > > wrote:
> > > 
> > > > On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> > > > > Hi,
> > > > > 
> > > > > I just thought I'd flesh out the other two issues I have found
> > > > > with re-exporting
> > > > > that are ultimately responsible for the biggest performance
> > > > > bottlenecks. And
> > > > > both of them revolve around the caching of metadata file
> > > > > lookups in the NFS
> > > > > client.
> > > > > 
> > > > > Especially for the case where we are re-exporting a server many
> > > > > milliseconds
> > > > > away (i.e. on-premise -> cloud), we want to be able to control
> > > > > how much the
> > > > > client caches metadata and file data so that it's many LAN
> > > > > clients all benefit
> > > > > from the re-export server only having to do the WAN lookups
> > > > > once (within a
> > > > > specified coherency time).
> > > > > 
> > > > > Keeping the file data in the vfs page cache or on disk using
> > > > > fscache/cachefiles
> > > > > is fairly straightforward, but keeping the metadata cached is
> > > > > particularly
> > > > > difficult. And without the cached metadata we introduce long
> > > > > delays before we
> > > > > can serve the already present and locally cached file data to
> > > > > many waiting
> > > > > clients.
> > > > > 
> > > > > ----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com
> > > > > wrote:
> > > > > > 2) If we cache metadata on the re-export server using
> > > > > > actimeo=3600,nocto we can
> > > > > > cut the network packets back to the origin server to zero for
> > > > > > repeated lookups.
> > > > > > However, if a client of the re-export server walks paths and
> > > > > > memory maps those
> > > > > > files (i.e. loading an application), the re-export server
> > > > > > starts issuing
> > > > > > unexpected calls back to the origin server again,
> > > > > > ignoring/invalidating the
> > > > > > re-export server's NFS client cache. We worked around this
> > > > > > this by patching an
> > > > > > inode/iversion validity check in inode.c so that the NFS
> > > > > > client cache on the
> > > > > > re-export server is used. I'm not sure about the correctness
> > > > > > of this patch but
> > > > > > it works for our corner case.
> > > > > 
> > > > > If we use actimeo=3600,nocto (say) to mount a remote software
> > > > > volume on the
> > > > > re-export server, we can successfully cache the loading of
> > > > > applications and
> > > > > walking of paths directly on the re-export server such that
> > > > > after a couple of
> > > > > runs, there are practically zero packets back to the
> > > > > originating NFS server
> > > > > (great!). But, if we then do the same thing on a client which
> > > > > is mounting that
> > > > > re-export server, the re-export server now starts issuing lots
> > > > > of calls back to
> > > > > the originating server and invalidating it's client cache
> > > > > (bad!).
> > > > > 
> > > > > I'm not exactly sure why, but the iversion of the inode gets
> > > > > changed locally
> > > > > (due to atime modification?) most likely via invocation of
> > > > > method
> > > > > inode_inc_iversion_raw. Each time it gets incremented the
> > > > > following call to
> > > > > validate attributes detects changes causing it to be reloaded
> > > > > from the
> > > > > originating server.
> > > > > 
> > > > 
> > > > I'd expect the change attribute to track what's in actual inode
> > > > on the
> > > > "home" server. The NFS client is supposed to (mostly) keep the
> > > > raw
> > > > change attribute in its i_version field.
> > > > 
> > > > The only place we call inode_inc_iversion_raw is in
> > > > nfs_inode_add_request, which I don't think you'd be hitting
> > > > unless you
> > > > were writing to the file while holding a write delegation.
> > > > 
> > > > What sort of server is hosting the actual data in your setup?
> > > 
> > > We mostly use RHEL7.6 NFS servers with XFS backed filesystems and a
> > > couple of (older) Netapps too. The re-export server is running the
> > > latest mainline kernel(s).
> > > 
> > > As far as I can make out, both these originating (home) server
> > > types exhibit a similar (but not exactly the same) effect on the
> > > Linux NFS client cache when it is being re-exported and accessed by
> > > other clients. I can replicate it when only using a read-only mount
> > > at every hop so I don't think that writes are related.
> > > 
> > > Our RHEL7 NFS servers actually mount XFS with noatime too so any
> > > atime updates that might be causing this client invalidation (which
> > > is what I initially thought) are ultimately a wasted effort.
> > > 
> > 
> > Ok. I suspect there is a bug here somewhere, but with such a
> > complicated
> > setup though it's not clear to me where that bug would be though. You
> > might need to do some packet sniffing and look at what the servers
> > are
> > sending for change attributes.
> > 
> > nfsd4_change_attribute does mix in the ctime, so your hunch about the
> > atime may be correct. atime updates imply a ctime update and that
> > could
> > cause nfsd to continually send a new one, even on files that aren't
> > being changed.
> 
> No. Ordinary atime updates due to read() do not trigger a ctime or
> change attribute update. Only an explicit atime update through, e.g. a
> call to utimensat() will do that.
> 

Oh, interesting. I didn't realize that.

> > It might be interesting to doctor nfsd4_change_attribute() to not mix
> > in
> > the ctime and see whether that improves things. If it does, then we
> > may
> > want to teach nfsd how to avoid doing that for certain types of
> > filesystems.
> 
> NACK. That would cause very incorrect behaviour for the change
> attribute. It is supposed to change in all circumstances where you
> ordinarily see a ctime change.


I wasn't suggesting this as a real fix, just as a way to see whether we
understand the problem correctly. I doubt the reexporting machine would
be bumping the change_attr on its own, and this may tell you whether
it's the "home" server changing it. There are other ways to determine it
too though (packet sniffer, for instance).

-- 
Jeff Layton <jlayton@kernel.org>

