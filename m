Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DE32C694
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356165AbhCDA3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448227AbhCCPYf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:24:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C020C0613DC
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 07:23:49 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CBF0F2824; Wed,  3 Mar 2021 10:23:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CBF0F2824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614785022;
        bh=ZecVwdAF2q3Qu4UOjZtHg1fZFYa3SMTpiMF2Qtw6RpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUGIVFLH/oxFgYcHA0JgFe9HUQ28MbQSB+sdQBZbXhhRuGYfp9mv1XyYBmt2m3ifF
         gviK59LH4fLehDcu9C56cIHKtoPo6o9axTx8aLkLZaTS5vN/QiKbVWIdgK981sQGK3
         PZfiPZ0NZ1lSiy1R5fCvXdblzy/F0rh+1IRva7a4=
Date:   Wed, 3 Mar 2021 10:23:42 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Message-ID: <20210303152342.GA1282@fieldses.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
> 
> 
> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
> > On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
> >> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
> >> The idea is to allow distros to build a v4 only package
> >> which will have a much smaller footprint than the
> >> entire nfs-utils package.
> >>
> >> exportd uses no RPC code, which means none of the 
> >> code or arguments that deal with v3 was ported, 
> >> this again, makes the footprint much smaller. 
> > 
> > How much smaller?
> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
> need to also come a long. 

Could we get some numbers?

Looks like nfs-utils in F33 is about 1.2M:

$ rpm -qi nfs-utils|grep ^Size
Size        : 1243512

$ strip utils/mountd/mountd
$ ls -lh utils/mountd/mountd
-rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
$ strip utils/exportd/exportd
$ ls -lh utils/exportd/exportd
-rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd

So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
worth it?

> >> The following options were ported:
> >>     * multiple threads
> >>     * state-directory-path option
> >>     * junction support (not tested)
> >>
> >> The rest of the mountd options were v3 only options.
> > 
> > There's also --manage-gids.
> Right... a patch was posted... 
> 
> > 
> > If you want nfsv4-only at runtime, you can always run rpc.mountd with
> > -N2 -N3 to turn off the MOUNT protocol support.
> The end game is not to run mountd at all... 
> 
> > 
> > If you don't even want v2/f3 code on your system, then you may have to
> > do something like this, but why is that important?
> Container friendly... Not bring in all the extra daemons v3
> needs is a good thing... esp rpcbind. 

Looking at the output of
$ for f in $(rpm -ql nfs-utils); do if [ -f $f ]; then ls -ls $f; fi; done|sort -n

It looks like removing statd, sm-notify, showount and their man pages
would free about another 170K.

I think that's about how much we'd save by seperating out a separate
documentation package.

I don't know, what sort of gains are container folks asking for?

--b.

> 
> steved.
> 
> > 
> > --b.
> > 
> >>
> >> V2:
> >>   * Added two systemd services: nfsv4-exportd and nfsv4-server
> >>   * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.
> >>
> >> V3: Changed the name from exportd to nfsv4.exportd
> >>
> >> V4: Added compile flag that will compile in the NFSv4 only server
> >>
> >> Steve Dickson (7):
> >>   exportd: the initial shell of the v4 export support
> >>   exportd: Moved cache upcalls routines into libexport.a
> >>   exportd: multiple threads
> >>   exportd/exportfs: Add the state-directory-path option
> >>   exportd: Enabled junction support
> >>   exportd: systemd unit files
> >>   exportd: Added config variable to compile in the NFSv4 only server.
> >>
> >>  .gitignore                                |   1 +
> >>  configure.ac                              |  14 ++
> >>  nfs.conf                                  |   4 +
> >>  support/export/Makefile.am                |   3 +-
> >>  {utils/mountd => support/export}/auth.c   |   4 +-
> >>  {utils/mountd => support/export}/cache.c  |  46 +++-
> >>  support/export/export.h                   |  34 +++
> >>  {utils/mountd => support/export}/fsloc.c  |   0
> >>  {utils/mountd => support/export}/v4root.c |   0
> >>  {utils/mountd => support/include}/fsloc.h |   0
> >>  systemd/Makefile.am                       |   6 +
> >>  systemd/nfs.conf.man                      |  10 +
> >>  systemd/nfsv4-exportd.service             |  12 +
> >>  systemd/nfsv4-server.service              |  31 +++
> >>  utils/Makefile.am                         |   4 +
> >>  utils/exportd/Makefile.am                 |  65 +++++
> >>  utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
> >>  utils/exportd/exportd.man                 |  81 +++++++
> >>  utils/exportfs/exportfs.c                 |  21 +-
> >>  utils/exportfs/exportfs.man               |   7 +-
> >>  utils/mountd/Makefile.am                  |   5 +-
> >>  21 files changed, 606 insertions(+), 18 deletions(-)
> >>  rename {utils/mountd => support/export}/auth.c (99%)
> >>  rename {utils/mountd => support/export}/cache.c (98%)
> >>  create mode 100644 support/export/export.h
> >>  rename {utils/mountd => support/export}/fsloc.c (100%)
> >>  rename {utils/mountd => support/export}/v4root.c (100%)
> >>  rename {utils/mountd => support/include}/fsloc.h (100%)
> >>  create mode 100644 systemd/nfsv4-exportd.service
> >>  create mode 100644 systemd/nfsv4-server.service
> >>  create mode 100644 utils/exportd/Makefile.am
> >>  create mode 100644 utils/exportd/exportd.c
> >>  create mode 100644 utils/exportd/exportd.man
> >>
> >> -- 
> >> 2.29.2
> > 
