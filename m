Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774F414D3F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhIVPlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:41:53 -0400
Received: from mta-102a.oxsus-vadesecure.net ([51.81.61.66]:39269 "EHLO
        mta-102a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhIVPlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=c4mNjWnKOiZa7zmpnNwlJCGMWy9PgXej2zQz3K
 gaCT4=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1632321123;
 x=1632925923; b=PwTpJjsWAasLHue/2ieYgZAuO0A+gBOS1mCPshBNH47A8RXYM8MWVGO
 EQKS8CXB0HLUyU2BygWQmLNKv3w0l5DZDS9aCG20lYAybEnouqJTPzKoNo/wZok/X+h2zjK
 vuhVCOrtgodT9oe3sCY7Gn+5zTj6PCZaKA+wl78z+CaTfa7i/TRpF8zKi2FcHVYY05E4Lzq
 lWl577pL7A+eddy57pXy3m3QWOEZTno2kcF4GpzndAAVeFpciQNV4MxROr+io0DXwyhqdjX
 /VOFqO7HIjNt0COp1RtUmiAyuIUv+sge8CaCM+sehH16RDEJVtcBGA2KYWLpvvcbO/4IN9Y
 Cvw==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id f58ae779-16a72b69b636fa24; Wed, 22 Sep 2021 14:32:03 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Daire Byrne'" <daire@dneg.com>,
        "'Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <20210921143259.GB21704@fieldses.org> <37851433-48C9-4585-9B68-834474AA6E06@oracle.com> <20210921160030.GC21704@fieldses.org> <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com>
In-Reply-To: <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com>
Subject: RE: [PATCH] nfs: reexport documentation
Date:   Wed, 22 Sep 2021 07:32:02 -0700
Message-ID: <01c901d7afbe$9cb5dbd0$d6219370$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHaPmxrNtjQ+kQkvcxH7DV+BmtjZwK315yQATRhzjcB4dNh36t8iYGA
Content-Language: en-us
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Daire Byrne [mailto:daire@dneg.com]
> Sent: Wednesday, September 22, 2021 2:48 AM
> To: Bruce Fields <bfields@fieldses.org>
> Cc: Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List =
<linux-
> nfs@vger.kernel.org>
> Subject: Re: [PATCH] nfs: reexport documentation
>=20
> On Tue, 21 Sept 2021 at 17:00, Bruce Fields <bfields@fieldses.org> =
wrote:
> >
> > > Any recommended workarounds? Or does this simply mean that
> > > administrators need to notify client users to unmount (or at least
> > > stop their workloads) before rebooting the proxy?
> >
> > I think so.
> >
> > If you don't use any file locking or delegations I suppose you're =
also
> > OK.  Delegations might be useful, though.
> >
> > I'd expect reexport to be useful mainly for data that changes very
> > rarely, if that helps.
> >
> > --b.
>=20
> Firstly, it's great to see this documentation and the well maintained =
wiki page
> for something we use in production (a lot) - thanks Bruce!
>=20
> I can only draw on our experience to say:
> * if the nfs re-export server doesn't crash, we rarely have cause to =
reboot it.
> * we re-export read-only software repositories to WAN/cloud instances =
(an
> ideal use case).
> * we also re-export read/write production storage but every client =
process is
> writing unique files - there are no writes to the same
> file(s) from any clients of the re-export server.
>=20
> We don't use or need crossmnt functionality, but I know from chatting =
to others
> within our industry that the fsid/crossmnt limitation causes them the =
most grief
> and confusion. I think in the case of Netapps, there are similar =
problems with
> trying to re-export a namespace made up of different volumes?
>=20
> As noted on the wiki, the only way around that is probably to have a =
"proxy"
> mode (similar to what ganesha does?).

I'm glad to see this documentation also. It helps to have a common =
understanding of the challenges of re-export.

Ganesha's proxy mode would be different from what Bruce is proposing due =
to how Ganesha constructs handles. It adds an export ID to the export =
configuration which leads to the specific back end (FSAL) that is =
exporting that handle. It may or may not also encode an fsid into the =
handle (proxy does so only to the extent the re-exported server put an =
fsid into the handle, Ganesha's proxy doesn't distinguish between the =
filesystems on the re-exported server). Ganesha can proxy and serve =
local file systems because it's proxy isn't a re-export of an NFS mount, =
but a separate back end module (two actually, one for NFSv3 and one for =
NFSv4) that talk directly to the proxied server while local file systems =
resolve handles pretty much the same way knfsd does (use the fsid to =
find the right filesystem and then use open_by_handle to find the inode =
within that filesystem - open_by_handle is a user space interface to the =
same exportfs interface that knfsd uses, with all the same limitations).

What Bruce is proposing is a bit more like a proxy mode I have =
considered for Ganesha that would allow both a proxied Ganesha server =
and the Ganesha proxy to use the same handles. Basically the export IDs =
would be shared between the two servers, though even that could be =
constructed in a way to allow multiple proxied servers (they just would =
be required to have non-overlapping export IDs) as well as still export =
local file systems.

Frank

