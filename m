Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C073F9B36
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbhH0O7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 10:59:07 -0400
Received: from mta-202a.oxsus-vadesecure.net ([51.81.232.240]:50619 "EHLO
        mta-202a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233712AbhH0O7H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 10:59:07 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 10:59:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; bh=kt68vmkLpCM+gxO56WPOrc0Vl4uZk05/0ykSTB
 sdEOI=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1630075991;
 x=1630680791; b=PUz+ET11UrofSGVcQn0HCwE/+moWzypGN9V/Li1E1agNKWvdmXpKus9
 hGVx0EKhU/4lW64O2ROsgQu/c6JKUr0pgUaovfRy/E/YjdD7pf7SexelEFZ7me3OcctB4i1
 nKP4dRKm0yjgkBypqphabbYqwILAkXCZa/gEzvDK+gIY9JKq2CzIRJmvvLeT2vwEWT2PfTK
 fUY2GeFB12makBEylVQbkid7YRbkDxG5BTzvTKHSdwxgQoAr3RpfSNwt0MzX7J2lt55hUWp
 OnufdSp+1jtTt22/jqqq4YqkxCdQE1qwrs/tLtDutC2jjQ7VTyioHuCr68jjKevG5snEkK6
 ouQ==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 1106967b-169f317a46e6d421; Fri, 27 Aug 2021 14:53:11 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'NeilBrown'" <neilb@suse.de>,
        "'J. Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, "'Josef Bacik'" <josef@toxicpanda.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>, <162995778427.7591.11743795294299207756@noble.neil.brown.name>, <20210826201916.GB10730@fieldses.org> <163001583884.7591.13328510041463261313@noble.neil.brown.name>
In-Reply-To: <163001583884.7591.13328510041463261313@noble.neil.brown.name>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
Date:   Fri, 27 Aug 2021 07:53:11 -0700
Message-ID: <002901d79b53$41ddba40$c5992ec0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIrHUOuRItKwhPpv5iuHWFXVceYzwFdY2wGAcm0L1ICXkcdJaq0P5lw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Fri, 27 Aug 2021, J.  Bruce Fields wrote:
> > On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> > >
> > > [[ Hi Bruce and Chuck,
> > >    I've rebased this patch on the earlier patch I sent which =
allows
> > >    me to use the name "fh_flags".  I've also added a missing =
#include.
> > >    I've added the 'Acked-by' which Joesf provided earlier for the
> > >    btrfs-part.  I don't have an 'ack' for the  stat.h part, but =
no-one
> > >    has complained wither.
> > >    I think it is as ready as it can be, and am keen to know what =
you
> > >    think.
> > >    I'm not *very* keen on testing s_magic in nfsd code (though we
> > >    already have a couple of such tests in nfs3proc.c), but it does =
have
> > >    the advantage of ensuring that no other filesystem can use this
> > >    functionality without landing a patch in fs/nfsd/.
> > >
> > >    Thanks for any review that you can provide,
> > >    NeilBrown
> > > ]]
> >
> > This seems hairy, but *somebody* has hated every single solution
> > proposed, so, argh, I don't know, maybe it's best.
>=20
> People don't like change I guess :-)
> I think we need the fh_flags stuff for almost any fix, else existing =
mounts could
> break when the server is upgraded.  This could be needed for any =
filesystem that
> has flawed NFS export support and needs to seemlessly repair it.
> We *might* be able to avoid that is I xored the uniquifier with the =
fsid instead of
> the fileid (I'd have to test), but that has other problems like =
polluting the client's
> mount table and mounted-on-fileid being hard to manage - especially =
for NFSv3.
> The rest is the minimum that actually achieves something.

Changing the fsid for sub-volumes is Ganesha's solution (before adding =
that, we couldn't even export the sub-volumes at all).

Mangling the fileid is definitely the best solution if there will be =
lots of sub-volumes. For a few sub-volumes changing fsid does create =
additional mount points on the client with some issues, but does =
guarantee there will be no fileid collision.

My gut feel is your solution is the best one and Ganesha may need to =
switch to that solution.

Frank

