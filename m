Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B92A9F53
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgKFVqm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 16:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgKFVql (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 16:46:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84971C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 13:46:41 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C82F91C25; Fri,  6 Nov 2020 16:46:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C82F91C25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604699200;
        bh=oW153lG2+05KF1LNE5994hXucYNr+yUdm6JrOctUyx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsGhCcy3VFr5EHudVR1FjxK5tzxCNhzVJEAGSJbJXWe3uXOqQuvI5Vfkeie06FjaI
         fh5jRA7GGGhp/5ObAdU9PV8TSk9rMP8jjTjMCw3oVghlUHr5iPPM9QcwGscsx+SSWF
         nS8jZZ/cXUX09xuLe6Xv3V+IwZc4EIFkZCKydLFM=
Date:   Fri, 6 Nov 2020 16:46:40 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
Subject: Re: Hard linking symlink does not work
Message-ID: <20201106214640.GC26028@fieldses.org>
References: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
 <20201027171240.GA1644@fieldses.org>
 <5dddc4b5-7777-859e-2730-28afc3067c57@math.utexas.edu>
 <CAGj4m+5j1ZK+=-4w6LpRLsnEPvi=UfpO3r8PruRtcJib9gbYyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGj4m+5j1ZK+=-4w6LpRLsnEPvi=UfpO3r8PruRtcJib9gbYyQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 28, 2020 at 10:53:20AM +0200, Vasyl Vavrychuk wrote:
> Thanks for replies about my problem. It is actually a practical one...
> 
> I need to compile Yocto BSP which builds only under older
> distributions. For convenience I have established a Vagrant virtual
> machine which uses NFS to share workspace with the host machine.
> 
> Now coming back to hardlinking symlinks.
> 
> Yocto build system uses hardlinks to prepare sysroot for packages, and
> symlinks are part of that sysroot provided by other packages.

For what it's worth, I can't reproduce the problem, linking a symlink
works fine for me.

What's your server?  (OS, version, exported filesystem?)

--b.

> 
> On Tue, Oct 27, 2020 at 10:03 PM Patrick Goetz <pgoetz@math.utexas.edu> wrote:
> >
> >
> >
> > On 10/27/20 12:12 PM, J. Bruce Fields wrote:
> > > On Fri, Oct 23, 2020 at 01:13:02PM +0300, Vasyl Vavrychuk wrote:
> > >> I have found that hard links for regular files works well for me over NFS:
> > >>
> > >> $ touch bar
> > >> $ ln bar tata
> > >>
> > >> But if I try to make hard link for symlink, then it fails:
> > >>
> > >> $ ln -s foo bar
> > >> $ ln bar tata
> > >> ln: failed to create hard link 'tata' => 'bar': Operation not permitted
> > >
> > > Huh.  I'm not sure I even realized it was possible to hardlink symlinks.
> > > Makes sense, I guess.
> >
> > What's even the use case for hard linking a symlink?  That sounds like
> > asking for trouble...
> >
> >
> > >
> > > I think my first step debugging this would be to watch wireshark while
> > > attempting the "ln", and see what happens.  That should tell us whether
> > > it's the client or server that's failing the operation.
> > >
> > > --b.
> > >
> > >>
> > >> I am using NFSv4 with Vagrant, here is mount entry:
> > >>
> > >> 172.28.128.1:PATH on /vagrant type nfs4
> > >> (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=IP,local_lock=none,addr=IP)
> > >>
> > >> I have also verified that rpc-statd is running on host.
> > >>
> > >> Host machine is Ubuntu 18.04 with NFS packages version 1:1.3.4-2.1ubuntu5.3.
> > >>
> > >> Will appreciate help on this.
> > >>
> > >> Thanks,
> > >> Vasyl
