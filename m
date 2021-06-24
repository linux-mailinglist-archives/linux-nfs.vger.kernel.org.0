Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907F3B2422
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 02:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFXAD0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 20:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhFXAD0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 20:03:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED55C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 17:01:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 72DA26208; Wed, 23 Jun 2021 20:01:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 72DA26208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624492867;
        bh=hMSDIWgNGPBdnszO6VQFbx21FPUKlPzPbC1+c6Q9zS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqJLLycrPQ+9vH9HRJULzGfJE3g1Zhs4bMvRiwhuqqK4PhE2vHrRAs88R3xSrgyFi
         29RCjhzph1RWvyOSBkZxIBW2Cg1NMVEcplOE49PL6q5P95tggCcFq5WsfJzT6TmpZ+
         2aRUgGWqSfp5bsfg5KAqLGwtZkeJwesYx4MwntLQ=
Date:   Wed, 23 Jun 2021 20:01:07 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
Message-ID: <20210624000107.GJ20232@fieldses.org>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>
 <20210622112253.DAEE.409509F4@e16-tech.com>
 <20210622151407.C002.409509F4@e16-tech.com>
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>
 <20210623153548.GF20232@fieldses.org>
 <162448589701.28671.8402117125966499268@noble.neil.brown.name>
 <20210623222559.GI20232@fieldses.org>
 <162449094105.28671.17150162627927917482@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162449094105.28671.17150162627927917482@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 24, 2021 at 09:29:01AM +1000, NeilBrown wrote:
> On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> > On Thu, Jun 24, 2021 at 08:04:57AM +1000, NeilBrown wrote:
> > > On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> > 
> > One other thing I'm not sure about: how do cold cache lookups of
> > filehandles for (possibly not-yet-mounted) subvolumes work?
> 
> Ahhhh...  that's a good point.  Filehandle lookup depends on the target
> filesystem being mounted.  NFS exporting filesystems which are
> auto-mounted on demand would be ... interesting.
> 
> That argues in favour of nfsd treating a btrfs filesystem as a single
> filesystem and gaining some knowledge about different subvolumes within
> a filesystem.
> 
> This has implications for NFS re-export.  If a filehandle is received
> for an NFS filesystem that needs to be automounted, I expect it would
> fail.

Yeah, that's why this is on my mind.  Currently we can only re-export
filesystems that are explicitly mounted and exported with an fsid=
option.

I had an idea that it would be interesting to run nfsd in a mode where
all it does is re-export everything exported by one single server.  In
theory then you no longer need to do any encapsulation, so you avoid the
maximum-filehandle-length problem.  When you get an unfamiliar
filehandle, you pass it on to the original server and get back an fsid,
and if it's one you haven't seen before you have to cook up a new
vfsmount and stuff somehow.  I ran aground trying to understand how to
do that in a way that wasn't too complicated.

Anyway.

--b.

> Or do we want to introduce a third level in the filehandle: filesystem,
> subvol, inode.  So just the "filesystem" is used to look things up in
> /proc/mounts, but "filesystem+subvol" is used to determine the fsid.
> 
> Maybe another way to state this is that the filesystem could identify a
> number of bytes from the fs-local part of the filehandle that should be
> mixed in to the fsid.  That might be a reasonably clean interface.
> 
> > 
> > > All we really need is:
> > > 1/ someone to write the code
> > > 2/ someone to review the code
> > > 3/ someone to accept the code
> > 
> > Hah.  Still, the special exceptions for btrfs seem to be accumulating.
> > I wonder if that's happening outside nfs as well.
> 
> I have some colleagues who work on btrfs and based on my occasional
> discussions, I think that: yes, btrfs is a bit "special".  There are a
> number of corner-cases where it doesn't quite behave how one would hope.
> This is probably inevitable given they way it is pushing the boundaries
> of functionality.  It can be a challenge to determine if that "hope" is
> actually reasonable, and to figure out a good solution that meets the
> need cleanly without imposing performance burdens elsewhere.
> 
> NeilBrown
