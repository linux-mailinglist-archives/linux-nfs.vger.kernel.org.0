Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2058E3B240E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWXoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 19:44:20 -0400
Received: from mta-101a.oxsus-vadesecure.net ([51.81.61.60]:45311 "EHLO
        oxsus1nmtao01p.internal.vadesecure.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229929AbhFWXoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 19:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=E5T0wMWcwrboeYp2EgstfF6iYPUJF5FWpUUGw6
 JQYtQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1624491699;
 x=1625096499; b=pMufC5tdIfLs9HAl5TIeUmZ/zAApJnfs3j1brCK4ImLaoOsVafwELqq
 excMtth8POz+V9vz862MeIwY5LjrmCWUO8F+H8+ecdXBi8IridI0uSSEJTvS9Iy5Z2cLG3C
 WtsxpUHLv3CSRLgGyCU9i3u5kYiTSZWDyhiIAtFDj9QBrAL9v0/G46nCnlzRDh6SFyXSTXn
 b+0U0dJ4CHk/jDtGd8LWnNv/q+xTEsnUJd28nnmhCdy6eYVOQdtVs2PKg9O3esJFNxpyUHg
 pOm/dB194IKmtXoqyyP7ZsFYhSN8VkOQH+o7RZlhMVf/tVjBJ2WMZY/B/JnM1eZfzAb/1h+
 n7Q==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by oxsus1nmtao01p.internal.vadesecure.com with ngmta
 id d5b3b378-168b5a97d783433d; Wed, 23 Jun 2021 23:41:39 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'NeilBrown'" <neilb@suse.de>,
        "'J. Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Wang Yugui'" <wangyugui@e16-tech.com>,
        <linux-nfs@vger.kernel.org>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>, <20210622112253.DAEE.409509F4@e16-tech.com>, <20210622151407.C002.409509F4@e16-tech.com>, <162440994038.28671.7338874000115610814@noble.neil.brown.name>, <20210623153548.GF20232@fieldses.org>, <162448589701.28671.8402117125966499268@noble.neil.brown.name>, <20210623222559.GI20232@fieldses.org> <162449094105.28671.17150162627927917482@noble.neil.brown.name>
In-Reply-To: <162449094105.28671.17150162627927917482@noble.neil.brown.name>
Subject: RE: any idea about auto export multiple btrfs snapshots?
Date:   Wed, 23 Jun 2021 16:41:37 -0700
Message-ID: <016401d76889$502c5590$f08500b0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGKhRePag7ItfzhWhiazj4GX4MewAFx2SZtAXZ3PcEAzWf2/wKo/B+EAjZSk3MBl9Hk7AJDQjsLq1iF4HA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> > On Thu, Jun 24, 2021 at 08:04:57AM +1000, NeilBrown wrote:
> > > On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> >
> > One other thing I'm not sure about: how do cold cache lookups of
> > filehandles for (possibly not-yet-mounted) subvolumes work?
>=20
> Ahhhh...  that's a good point.  Filehandle lookup depends on the =
target
> filesystem being mounted.  NFS exporting filesystems which are =
auto-mounted
> on demand would be ... interesting.
>=20
> That argues in favour of nfsd treating a btrfs filesystem as a single =
filesystem
> and gaining some knowledge about different subvolumes within a =
filesystem.
>=20
> This has implications for NFS re-export.  If a filehandle is received =
for an NFS
> filesystem that needs to be automounted, I expect it would fail.
>=20
> Or do we want to introduce a third level in the filehandle: =
filesystem, subvol,
> inode.  So just the "filesystem" is used to look things up in =
/proc/mounts, but
> "filesystem+subvol" is used to determine the fsid.
>=20
> Maybe another way to state this is that the filesystem could identify =
a number of
> bytes from the fs-local part of the filehandle that should be mixed in =
to the fsid.
> That might be a reasonably clean interface.

Hmm, and interesting problem I hadn't considered for nfs-ganesha. =
Ganesha can handle a lookup into a filesystem (we treat subvols as =
filesystems) that was not mounted when we started (when we startup we =
scan mnttab and the btrfs subvol list and add any filesystems belonging =
to the configured exports) by re-scanning mnttab and the btrfs subvol =
list.

But what if Ganesha restarted, and then after that, a filesystem that a =
client had a handle for was not mounted at restart time, but is mounted =
by the time the client tries to use the handle... That would be easy for =
us to fix, if a handle specifies an unknown fsid, trigger a filesystem =
rescan.

> > > All we really need is:
> > > 1/ someone to write the code
> > > 2/ someone to review the code
> > > 3/ someone to accept the code
> >
> > Hah.  Still, the special exceptions for btrfs seem to be =
accumulating.
> > I wonder if that's happening outside nfs as well.
>=20
> I have some colleagues who work on btrfs and based on my occasional
> discussions, I think that: yes, btrfs is a bit "special".  There are a =
number of
> corner-cases where it doesn't quite behave how one would hope.
> This is probably inevitable given they way it is pushing the =
boundaries of
> functionality.  It can be a challenge to determine if that "hope" is =
actually
> reasonable, and to figure out a good solution that meets the need =
cleanly
> without imposing performance burdens elsewhere.

What other special cases does btrfs have that cause nfs servers pain? I =
know their handle is big but the only special case code nfs-ganesha has =
at the moment is listing the subvols as part of the filesystem scan.

Frank


