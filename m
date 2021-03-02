Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86032A949
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448437AbhCBSSj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:18:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:36788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574720AbhCBDtT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 22:49:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8FD9ABF4;
        Tue,  2 Mar 2021 03:49:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Tue, 02 Mar 2021 14:49:13 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210302032733.GC16303@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
Message-ID: <871rcyi5ae.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01 2021, J. Bruce Fields wrote:

> On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
>> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>>=20
>> > I've gotten requests for similar functionality, and intended to
>> > implement it using directory notifications on /proc/fs/nfsd/clients.
>>=20
>> I've been exploring this a bit.
>> When I mount a filesystem, 2 clients get created.
>> With NFSv4.0, the second client is immediately deleted, and the first
>> client is deleted one grace period after the filesystem is unmounted.
>> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
>> second client is deleted immediately after the unmount.
>
> Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
> (or EXCHANGE_ID) and then a new "confirmed client" on
> SETCLIENTID_CONFIRM (or CREATE_SESSION).

Of course - the "confirm" step.  That would explain it.

>
> I'm not sure why the ordering's a little different between the 4.0/4.1+
> cases.
>
> The difference on unmount is because 4.1+ clients immediately send a
> DESTROY_CLIENTID on unmount, but that op was new to 4.1.

I thought it would be something like that - a protocol improvements.

>
> (Note of course this isn't precisely mount/unmount, as the same client
> can be used for multiple filesystems.)

True.  It could also be a network disconnect, not an explicit unmount.
Still I think it could be useful to log.

>
> Honestly, I think this is exposing an implementation detail and it's
> dumb.  I'll look into fixing it.

Thanks.

>
> (I don't know if that change itself would cause additional difficulty.)

I doubt it.  You would need to look at "info" in a directory to do
anything useful, and in my simple testing that always said
  cat: /proc/fs/nfsd/clients/41/info: No such file or directory
or similar in the transient directory.  So code is mostly likely to
quickly ignore any such directory.

I'll see how easy it is to add "client added" and "client removed" log
messages to mountd before resending my series.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmA9tbkOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmSBBAAqY9+o0ncai+Y5iX9C5/lG3PssOlOLwbsEopS
IkyKqlTWCi6dXtEDHyqnztp6q29Mc8jBXsrdtZDBxOngadMwAaxcTXOd+MKLizXD
CwrmDQgI6Md08y0/oZ0ltKKIVHfjroP+ESF+eYKWHZRtAnQPONcdWz5Co8U3xxx2
VhkQWnqTWEOJFLst69/V4LUMaGuGVENOgfHl0nrLI17Ir+TMHR0j+xFx9rz8lNVx
frn1Q1ov9xeKcxpjm5CuW6qtCbaSZWdzQqazSm5ILcmmDD7agzKJV6YsTzqB1Lyv
ixiJUxaHJuY1xJogjtSiFW2aJHkkALPgZNOlH701z3QPlicpKILkYNPUFOJcx4Oe
EWiK7+mb5b+gLQjJEUsI0LLOm7SjUR3ntLP9FGiryxqls5m5IlaIBJynnvD+BmSC
Iw+yXe+xWidXnIFEkk54DCD/JMncaw9jBU4oMK+2lPMEDCKcM/SgAHD/OH15kxIB
49YXXT9qYPGPhXiRy/g4AAi9wqsaD5RC0pSNPoOEw9RSntHbN8R2c026jL27zf5A
Ve6h6WK+O6tw7WNFuK67180NA4V52WuLVKpCb9CpEtWVogMn2KRdnRC2gdc3zBUG
MjamZR0ohXVH/qIRDSQAnUUNX7S/pgaCbgDUKuWwndeZ4SM2SNm0OTIkyTNlEPhd
c1Vu8eA=
=Cfqr
-----END PGP SIGNATURE-----
--=-=-=--
