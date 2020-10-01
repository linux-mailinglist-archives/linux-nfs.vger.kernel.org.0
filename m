Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796727FD7F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbgJAKgV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 06:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgJAKgV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Oct 2020 06:36:21 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7AB2085B;
        Thu,  1 Oct 2020 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601548580;
        bh=Lx+jpyuPmIgbWVl6AE8kVTzhD6/UM8rO+DdoAkcHPOg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CtbVQqcnv1Flw9ExsK0CM2b94uFBxXZiYu/SKFd/l4GJixTJa6MtGtA4W6VHngjhV
         kZU4NgPlG/YD4uHUk5AHwA78mEKl38XQY0woil4F8vk2hJfQC2/w/j2rZvLE74egQ6
         XGXKfD5cUSkdYoKUF4yvaUaz1LSLtRD4TQYLslYs=
Message-ID: <3243730b0661de0ac0864a9bb5375f894b266220.camel@kernel.org>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Date:   Thu, 01 Oct 2020 06:36:18 -0400
In-Reply-To: <1309604906.55950004.1601510969548.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
         <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
         <1309604906.55950004.1601510969548.JavaMail.zimbra@dneg.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-10-01 at 01:09 +0100, Daire Byrne wrote:
> ----- On 30 Sep, 2020, at 20:30, Jeff Layton jlayton@kernel.org wrote:
> 
> > On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> > > Hi,
> > > 
> > > I just thought I'd flesh out the other two issues I have found with re-exporting
> > > that are ultimately responsible for the biggest performance bottlenecks. And
> > > both of them revolve around the caching of metadata file lookups in the NFS
> > > client.
> > > 
> > > Especially for the case where we are re-exporting a server many milliseconds
> > > away (i.e. on-premise -> cloud), we want to be able to control how much the
> > > client caches metadata and file data so that it's many LAN clients all benefit
> > > from the re-export server only having to do the WAN lookups once (within a
> > > specified coherency time).
> > > 
> > > Keeping the file data in the vfs page cache or on disk using fscache/cachefiles
> > > is fairly straightforward, but keeping the metadata cached is particularly
> > > difficult. And without the cached metadata we introduce long delays before we
> > > can serve the already present and locally cached file data to many waiting
> > > clients.
> > > 
> > > ----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com wrote:
> > > > 2) If we cache metadata on the re-export server using actimeo=3600,nocto we can
> > > > cut the network packets back to the origin server to zero for repeated lookups.
> > > > However, if a client of the re-export server walks paths and memory maps those
> > > > files (i.e. loading an application), the re-export server starts issuing
> > > > unexpected calls back to the origin server again, ignoring/invalidating the
> > > > re-export server's NFS client cache. We worked around this this by patching an
> > > > inode/iversion validity check in inode.c so that the NFS client cache on the
> > > > re-export server is used. I'm not sure about the correctness of this patch but
> > > > it works for our corner case.
> > > 
> > > If we use actimeo=3600,nocto (say) to mount a remote software volume on the
> > > re-export server, we can successfully cache the loading of applications and
> > > walking of paths directly on the re-export server such that after a couple of
> > > runs, there are practically zero packets back to the originating NFS server
> > > (great!). But, if we then do the same thing on a client which is mounting that
> > > re-export server, the re-export server now starts issuing lots of calls back to
> > > the originating server and invalidating it's client cache (bad!).
> > > 
> > > I'm not exactly sure why, but the iversion of the inode gets changed locally
> > > (due to atime modification?) most likely via invocation of method
> > > inode_inc_iversion_raw. Each time it gets incremented the following call to
> > > validate attributes detects changes causing it to be reloaded from the
> > > originating server.
> > > 
> > 
> > I'd expect the change attribute to track what's in actual inode on the
> > "home" server. The NFS client is supposed to (mostly) keep the raw
> > change attribute in its i_version field.
> > 
> > The only place we call inode_inc_iversion_raw is in
> > nfs_inode_add_request, which I don't think you'd be hitting unless you
> > were writing to the file while holding a write delegation.
> > 
> > What sort of server is hosting the actual data in your setup?
> 
> We mostly use RHEL7.6 NFS servers with XFS backed filesystems and a couple of (older) Netapps too. The re-export server is running the latest mainline kernel(s).
> 
> As far as I can make out, both these originating (home) server types exhibit a similar (but not exactly the same) effect on the Linux NFS client cache when it is being re-exported and accessed by other clients. I can replicate it when only using a read-only mount at every hop so I don't think that writes are related.
> 
> Our RHEL7 NFS servers actually mount XFS with noatime too so any atime updates that might be causing this client invalidation (which is what I initially thought) are ultimately a wasted effort.
> 

Ok. I suspect there is a bug here somewhere, but with such a complicated
setup though it's not clear to me where that bug would be though. You
might need to do some packet sniffing and look at what the servers are
sending for change attributes.

nfsd4_change_attribute does mix in the ctime, so your hunch about the
atime may be correct. atime updates imply a ctime update and that could
cause nfsd to continually send a new one, even on files that aren't
being changed.

It might be interesting to doctor nfsd4_change_attribute() to not mix in
the ctime and see whether that improves things. If it does, then we may
want to teach nfsd how to avoid doing that for certain types of
filesystems.

> 
> > > This patch helps to avoid this when applied to the re-export server but there
> > > may be other places where this happens too. I accept that this patch is
> > > probably not the right/general way to do this, but it helps to highlight the
> > > issue when re-exporting and it works well for our use case:
> > > 
> > > --- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27 00:23:03.000000000
> > > +0000
> > > +++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
> > > @@ -1869,7 +1869,7 @@
> > >  
> > >         /* More cache consistency checks */
> > >         if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
> > > -               if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
> > > +               if (inode_peek_iversion_raw(inode) < fattr->change_attr) {
> > >                         /* Could it be a race with writeback? */
> > >                         if (!(have_writers || have_delegation)) {
> > >                                 invalid |= NFS_INO_INVALID_DATA
> > > 
> > > With this patch, the re-export server's NFS client attribute cache is maintained
> > > and used by all the clients that then mount it. When many hundreds of clients
> > > are all doing similar things at the same time, the re-export server's NFS
> > > client cache is invaluable in accelerating the lookups (getattrs).
> > > 
> > > Perhaps a more correct approach would be to detect when it is knfsd that is
> > > accessing the client mount and change the cache consistency checks accordingly?
> > 
> > Yeah, I don't think you can do this for the reasons Trond outlined.
> 
> Yea, I kind of felt like it wasn't quite right, but I didn't know enough about the intricacies to say why exactly. So thanks to everyone for clearing that up for me.
> 
> We just followed the code and found that the re-export server spent a lot of time in this code block when we assumed that we should be able to serve the same read-only metadata requests to multiple clients out of the re-export server's NFS client cache. I guess the patch was more for us to see if we could (incorrectly) engineer our desired behaviour with a dirty hack.
> 
> While the patch definitely helps to better utilise the re-export server's nfs client cache when exporting via knfsd, we do still see many repeat getattrs per minute for the same files on the re-export server when 100s of clients are all reading the same files. So this is probably not the only area where the reading via a knfsd export of an nfs client mount, invalidates the re-export server's nfs client cache. 
>
> Ultimately, I guess we are willing to take some risks with cache coherency (similar to actimeo=large,nocto) if it means that we can do expensive metadata lookups to a remote (WAN) server once and re-export that result to hundreds of (LAN) clients. For read-only or "almost" read-only workloads like ours where we repeatedly read the same files from many clients, it can lead to big savings over the WAN.
> 
> But I accept that it is a coherency and locking nightmare when you want to do writes to shared files.
> 
> Daire

-- 
Jeff Layton <jlayton@kernel.org>

