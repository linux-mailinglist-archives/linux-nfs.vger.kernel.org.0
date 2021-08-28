Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2853FA31F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhH1CWu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 22:22:50 -0400
Received: from mta-102a.oxsus-vadesecure.net ([51.81.61.66]:34781 "EHLO
        mta-102a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhH1CWu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 22:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=bWrqTCbgUjFFLdDsfkRwCDh174NAcnsQ87QSWT
 YIdsc=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1630117320;
 x=1630722120; b=QmrTqC+vi5yPswtAs2qib6Z768gWRyf0d6dEj/9Jyg3n/Mv4AbYHMqf
 tC5L9XGL9vP1l1N+o6PV6vT9S1RCYSEBjOxCDBDj9PB73XPsDY+i9q8meJEO2EEDeA3C2I9
 Ssnl7HbdOem1/DBawuCkHji3gifPU9+Gep1JTZueWCsNSDkqeo/3lM73MMhDtpWHcs/VMAN
 B19OXiHq+25OprPP3bQ/9MkwNbLhygZmy8eZZWC/4Eh5CjOiOrVpK5KZ1qsra0m8KUNEGfL
 z6EV0oLj6cY/ZY+VEHItzk6LxTTEHKbUCwTpvDP7t2obwAUOhMmBdnDcig3r3Bz+c5ofTo7
 T1Q==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id b7b0e6dd-169f5710af155910; Sat, 28 Aug 2021 02:21:59 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'NeilBrown'" <neilb@suse.de>
Cc:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, "'Josef Bacik'" <josef@toxicpanda.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>, <162995778427.7591.11743795294299207756@noble.neil.brown.name>, <20210826201916.GB10730@fieldses.org>, <163001583884.7591.13328510041463261313@noble.neil.brown.name>, <002901d79b53$41ddba40$c5992ec0$@mindspring.com>, <163010502766.7591.10398654528737145909@noble.neil.brown.name>, <005801d79b9d$b8437b80$28ca7280$@mindspring.com> <163010850148.7591.14454473128413118273@noble.neil.brown.name>
In-Reply-To: <163010850148.7591.14454473128413118273@noble.neil.brown.name>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
Date:   Fri, 27 Aug 2021 19:21:59 -0700
Message-ID: <005d01d79bb3$7b914c10$72b3e430$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIrHUOuRItKwhPpv5iuHWFXVceYzwFdY2wGAcm0L1ICXkcdJQIF8dZtApre6XMCCRVTjQEBoISGqnej5NA=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Sat, 28 Aug 2021, Frank Filz wrote:
>=20
> > > On Sat, 28 Aug 2021, Frank Filz wrote:
> > > >
> > > > Changing the fsid for sub-volumes is Ganesha's solution (before
> > > > adding that, we couldn't even export the sub-volumes at all).
> > >
> > > What does Ganesha use for the mounted-on-fileid? There doesn't =
seem
> > > to be an "obvious" answer so I wonder what was chosen.
> >
> > We only make mounted_on_fileid different from fileid on our export
> > boundaries, and even then, it's not a terribly correct thing for
> > FSAL_VFS (our module for interfacing with kernel filesystems) since
> > user space to my knowledge has no way to get any information on an
> > inode that serves as a mount point.
>=20
> It is possible to see the mounted-on inode number by doing a readdir() =
of the
> parent directory and looking at d_ino.  It is a bit round-about.

Ahh, I'll have to keep that in mind, I'm not totally sure, but I think =
AIX mostly used/got the mounted_on_fileid during a READDIR which if that =
translates into a readdir to the underlying filesystem (via getdents in =
our case) then we have the d_ino to fill in mounted_on_fileid. I think =
it's less likely a situation with a LOOKUP. I think AIX used it when it =
got NFS4ERR_WRONGSEC when doing a READDIR, it would then go back and do =
a READDIR just asking for mounted_on_fileid (which as a property of the =
owning directory, we decided was OK to give for an inode that was in a =
new export with different security flavor requirements). I think AIX =
used the mounted_on_fileid to instantiate some kind of junction inode in =
the directory.

> >
> > What clients actually do anything with mounted_on_fileid, and what
> > sorts of things do they do with it? I know the AIX client was
> > interested in it (from having worked on security negotiation back in
> > 2006), but I have never been able to test Ganesha with an AIX =
client.
> > For normal Linux client operations, what Ganesha does seems to work
> > OK.
>=20
> On the Linux client, if you stat() a directory that is a mountpoint on =
the server,
> you will see a directory with the inode number being the =
mounted-on-fileid.
> That directory is an automount-point, and when you access anything in =
it, the
> 'real' directory gets mounted and the mounted-on-fileid disappears.
> So if you reported a mounted-on-fileid the same as the fileid, which =
would be
> 256 on btrfs, du and find can get confused.  To be safe, the =
mounted-of-fileid
> needs to be different to all ancestors.
>=20
> NeilBrown

Frank

