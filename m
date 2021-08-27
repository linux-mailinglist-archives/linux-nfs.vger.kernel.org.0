Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2427C3FA1EB
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhH0XrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:47:06 -0400
Received: from mta-202a.oxsus-vadesecure.net ([51.81.232.240]:39863 "EHLO
        mta-202a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232354AbhH0XrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=0i9aQdbDO8ks0bCK/A+r6narC3jZD9keCdHdRe
 Pli1A=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1630107972;
 x=1630712772; b=MifO8Bf8bQhb95kT7K/ZLzBeV7+yR8NHJyKD80IEqwtYjECnSC5B9If
 dWH+L6NDF9YS9YQuVYPPHVVICgcnnRo4W0glMGhCbHKS5jMzxhE0AI1eqI8avb5DH8dTlPj
 mz/c9DqL3XOa4F6AcEulNyVwN1SDtNVby8eNT3yeNGLVQrDS3jN6sOoG/RX5PV8DO0hn0z9
 s3U6VfQeNb9LLyG3Ij/fH1Wf1Nc/zHkkuu312I6vvIn50GMXHN5GgwLTpV+A6VPdiBpQx6y
 pGzklmIjWVe0LK+uPLw8uFiF/bbLLCJ7zCJy0YGasxWyrAuMvmBaYKWnxZUAovsqeuW11ur
 7XQ==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 967ea5f6-169f4e9080a5b3d6; Fri, 27 Aug 2021 23:46:12 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'NeilBrown'" <neilb@suse.de>
Cc:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, "'Josef Bacik'" <josef@toxicpanda.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>, <162995778427.7591.11743795294299207756@noble.neil.brown.name>, <20210826201916.GB10730@fieldses.org>, <163001583884.7591.13328510041463261313@noble.neil.brown.name>, <002901d79b53$41ddba40$c5992ec0$@mindspring.com> <163010502766.7591.10398654528737145909@noble.neil.brown.name>
In-Reply-To: <163010502766.7591.10398654528737145909@noble.neil.brown.name>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
Date:   Fri, 27 Aug 2021 16:46:12 -0700
Message-ID: <005801d79b9d$b8437b80$28ca7280$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIrHUOuRItKwhPpv5iuHWFXVceYzwFdY2wGAcm0L1ICXkcdJQIF8dZtApre6XOqj8wKwA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Sat, 28 Aug 2021, Frank Filz wrote:
> >
> > Changing the fsid for sub-volumes is Ganesha's solution (before =
adding
> > that, we couldn't even export the sub-volumes at all).
>=20
> What does Ganesha use for the mounted-on-fileid? There doesn't seem to =
be an
> "obvious" answer so I wonder what was chosen.

We only make mounted_on_fileid different from fileid on our export =
boundaries, and even then, it's not a terribly correct thing for =
FSAL_VFS (our module for interfacing with kernel filesystems) since user =
space to my knowledge has no way to get any information on an inode that =
serves as a mount point.

What clients actually do anything with mounted_on_fileid, and what sorts =
of things do they do with it? I know the AIX client was interested in it =
(from having worked on security negotiation back in 2006), but I have =
never been able to test Ganesha with an AIX client. For normal Linux =
client operations, what Ganesha does seems to work OK.

> >
> > Mangling the fileid is definitely the best solution if there will be =
lots of sub-
> volumes. For a few sub-volumes changing fsid does create additional =
mount
> points on the client with some issues, but does guarantee there will =
be no fileid
> collision.
> >
> > My gut feel is your solution is the best one and Ganesha may need to =
switch to
> that solution.
>=20
> Thanks for the encouragement.  Changing the fsid does seem easier is =
many
> ways, but I don't really like the consequences or implications.

Yea, there really isn't a good solution here.

Probably really client applications need to do something different to =
detect infinite loops and not care so much about unique fileids.

Frank

