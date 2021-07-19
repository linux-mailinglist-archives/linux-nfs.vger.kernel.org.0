Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576843CE2CA
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhGSPcG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbhGSPaN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 11:30:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633DC025476;
        Mon, 19 Jul 2021 08:22:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8978869C3; Mon, 19 Jul 2021 11:49:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8978869C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626709747;
        bh=ti8Lix6DTW58HSt/kKrKpzmA8A16cLxRx7tBsW4gCcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+7IBwT4bCVh4ZkXH6Pfu7BgB2qcElqNyADOVa5xC43rFJ4vsYfF0EWd8NkZG5Kir
         PFmx/3LYVqkCXmYBT5pdxjKMxDA5uFyKsRrrzm6YkaPz01WWTYcoPOwRc9V/w4xYx4
         pDg5hxPqnR+UYHhNZOPJO4xeCz88ha+peHkes0Iw=
Date:   Mon, 19 Jul 2021 11:49:07 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <20210719154907.GA28482@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
 <162638862766.13764.8566962032225976326@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162638862766.13764.8566962032225976326@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 16, 2021 at 08:37:07AM +1000, NeilBrown wrote:
> On Fri, 16 Jul 2021, Josef Bacik wrote:
> > On 7/15/21 1:24 PM, Christoph Hellwig wrote:
> > > On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
> > >> Because there's no alternative.  We need a way to tell userspace they've
> > >> wandered into a different inode namespace.  There's no argument that what
> > >> we're doing is ugly, but there's never been a clear "do X instead".  Just a
> > >> lot of whinging that btrfs is broken.  This makes userspace happy and is
> > >> simple and straightforward.  I'm open to alternatives, but there have been 0
> > >> workable alternatives proposed in the last decade of complaining about it.
> > > 
> > > Make sure we cross a vfsmount when crossing the "st_dev" domain so
> > > that it is properly reported.   Suggested many times and ignored all
> > > the time beause it requires a bit of work.
> > > 
> > 
> > You keep telling me this but forgetting that I did all this work when you 
> > originally suggested it.  The problem I ran into was the automount stuff 
> > requires that we have a completely different superblock for every vfsmount. 
> > This is fine for things like nfs or samba where the automount literally points 
> > to a completely different mount, but doesn't work for btrfs where it's on the 
> > same file system.  If you have 1000 subvolumes and run sync() you're going to 
> > write the superblock 1000 times for the same file system.  You are going to 
> > reclaim inodes on the same file system 1000 times.  You are going to reclaim 
> > dcache on the same filesytem 1000 times.  You are also going to pin 1000 
> > dentries/inodes into memory whenever you wander into these things because the 
> > super is going to hold them open.
> > 
> > This is not a workable solution.  It's not a matter of simply tying into 
> > existing infrastructure, we'd have to completely rework how the VFS deals with 
> > this stuff in order to be reasonable.  And when I brought this up to Al he told 
> > me I was insane and we absolutely had to have a different SB for every vfsmount, 
> > which means we can't use vfsmount for this, which means we don't have any other 
> > options.  Thanks,
> 
> When I was first looking at this, I thought that separate vfsmnts
> and auto-mounting was the way to go "just like NFS".  NFS still shares a
> lot between the multiple superblock - certainly it shares the same
> connection to the server.
> 
> But I dropped the idea when Bruce pointed out that nfsd is not set up to
> export auto-mounted filesystems.

Yes.  I wish it was....  But we'd need some way to look a
not-currently-mounted filesystem by filehandle:

> It needs to be able to find a
> filesystem given a UUID (extracted from a filehandle), and it does this
> by walking through the mount table to find one that matches.  So unless
> all btrfs subvols were mounted all the time (which I wouldn't propose),
> it would need major work to fix.
> 
> NFSv4 describes the fsid as having a "major" and "minor" component.
> We've never treated these as having an important meaning - just extra
> bits to encode uniqueness in.  Maybe we should have used "major" for the
> vfsmnt, and kept "minor" for the subvol.....

So nfsd would use the "major" ID to find the parent export, and then
btrfs would use the "minor" ID to identify the subvolume?

--b.

> The idea for a single vfsmnt exposing multiple inode-name-spaces does
> appeal to me.  The "st_dev" is just part of the name, and already a
> fairly blurry part.  Thanks to bind mounts, multiple mounts can have the
> same st_dev.  I see no intrinsic reason that a single mount should not
> have multiple fsids, provided that a coherent picture is provided to
> userspace which doesn't contain too many surprises.
