Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F383A6FC7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhFNUGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFNUGD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 16:06:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9287C061574
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 13:04:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B4F456210; Mon, 14 Jun 2021 16:03:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B4F456210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623701039;
        bh=Ve6AYJhgxdkLiplD0K+hpIkyn7gnACOdcA17CJmAxKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYzZyh7/bjgoBhwDA1vAAKeEQ4er6X8AZ0g4iEoZtRcd3vzvh67MhTmiF+jipX2L3
         +Iz7QERuXL1+6ZM2ilHWHQp3dfH8oCt/1EPofxM1nim+y4Msdwoy80Azx/MvwzCrR7
         3I9HdQNTSSuZYNFYOQwUIYiu0bwzVAGvoq6kS4UA=
Date:   Mon, 14 Jun 2021 16:03:59 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Message-ID: <20210614200359.GC16500@fieldses.org>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
 <1623682098-13236-4-git-send-email-bfields@redhat.com>
 <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
 <20210614193409.GA16500@fieldses.org>
 <7b119b40fd29c424ce4e85fa4703b472bf0d379d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b119b40fd29c424ce4e85fa4703b472bf0d379d.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 14, 2021 at 07:53:52PM +0000, Trond Myklebust wrote:
> On Mon, 2021-06-14 at 15:34 -0400, J. Bruce Fields wrote:
> > On Mon, Jun 14, 2021 at 02:56:55PM +0000, Trond Myklebust wrote:
> > > On Mon, 2021-06-14 at 10:48 -0400, J. Bruce Fields wrote:
> > > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > > 
> > > > In the reexport case, nfsd is currently passing along locks with
> > > > the
> > > > reclaim bit set.  The client sends a new lock request, which is
> > > > granted
> > > > if there's currently no conflict--even if it's possible a
> > > > conflicting
> > > > lock could have been briefly held in the interim.
> > > > 
> > > > We don't currently have any way to safely grant reclaim, so for
> > > > now
> > > > let's just deny them all.
> > > > 
> > > > I'm doing this by passing the reclaim bit to nfs and letting it
> > > > fail
> > > > the
> > > > call, with the idea that eventually the client might be able to
> > > > do
> > > > something more forgiving here.
> > > > 
> > > > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > > > ---
> > > >  fs/nfs/file.c       | 3 +++
> > > >  fs/nfsd/nfs4state.c | 3 +++
> > > >  fs/nfsd/nfsproc.c   | 1 +
> > > >  include/linux/fs.h  | 1 +
> > > >  4 files changed, 8 insertions(+)
> > > > 
> > > > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > > > index 1fef107961bc..35a29b440e3e 100644
> > > > --- a/fs/nfs/file.c
> > > > +++ b/fs/nfs/file.c
> > > > @@ -806,6 +806,9 @@ int nfs_lock(struct file *filp, int cmd,
> > > > struct
> > > > file_lock *fl)
> > > >  
> > > >         nfs_inc_stats(inode, NFSIOS_VFSLOCK);
> > > >  
> > > > +       if (fl->fl_flags & FL_RECLAIM)
> > > > +               return -NFSERR_NO_GRACE;
> > > 
> > > NACK. nfs_lock() is required to return a POSIX error. I know that
> > > right
> > > now, nfsd is the only thing setting FL_RECLAIM, but we can't
> > > guarantee
> > > that will always be the case.
> > 
> > Setting FL_RECLAIM tells the filesystem that you're prepared to
> > handle
> > NFSERR_NO_GRACE.  I'm not seeing the risk.
> 
> You are using a function that is exposed to the VFS. On error, that
> function is expected to return a value that is a Linux error between -1
> and -4095.

Or 1, actually (FILE_LOCK_DEFERRED).

> I suggest adding an error value ENOGRACE to include/linux/errno.h.

I can live with that, but I'm still curious what exactly you're worried
about.

--b.
