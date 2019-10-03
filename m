Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD90C95AE
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2019 02:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJCA1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 20:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729866AbfJCA1a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1046CAF22;
        Thu,  3 Oct 2019 00:27:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Thu, 03 Oct 2019 10:27:21 +1000
Cc:     Neil F Brown <nfbrown@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: remounting hard -> soft
In-Reply-To: <489FAE7A-F9CC-46A9-84FC-127487ADC0B3@oracle.com>
References: <489FAE7A-F9CC-46A9-84FC-127487ADC0B3@oracle.com>
Message-ID: <87y2y265cm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02 2019, Chuck Lever wrote:

> Hi Trond-
>
> We (Oracle) had another (fairly rare) instance of a weekend maintenance
> window where an NFS server's IP address changed while there were mounted
> clients. It brought up the issue again of how we (the Linux NFS community)
> would like to deal with cases where a client administrator has to deal
> with a moribund mount (like that alliteration :-).

What exactly is the problem that this caused?

As I understand it, a moribund mount can still be unmounted with "-l"
and processes accessing it can still be killed ... except....
There are some waits the VFS/MM which are not TASK_KILLABLE and
probably should be.  I think that "we" definitely want "someone" to
track them down and fix them.

>
> Does remounting with "soft" work today? That seems like the most direct
> way to deal with this particular situation.

I don't think this does work, and it would be non-trivial (but maybe not
impossible) to mark all the outstanding RPCs as also "soft".
If we wanted to follow a path like this (and I suspect we don't), I
would hope that we could expose the server connection (shared among
multiple mounts) in sysfs somewhere, and could then set "soft" (or
"dead") on that connection, rather than having to do it on every mount
from the particular server.

NeilBrown

>
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2VQGkACgkQOeye3VZi
gbmTBhAAo+iXH6JqhgxPY5kpn+3XfeSy3pYC47KNU9EW27UZt6iNFrxrDNSTdzms
ZuA2xpo5RuTwa/HyVgjYcOTv4qOd6NC/xCuByfQenD/Sw6gakU19+fElwmGf8oVA
Zpd4h1EUAmrxXIYPrjd4LNrHTcIDaFghm3CklESS72S90E29uh1VrK3HA1haA7Yp
re3LHLTWzhcbwbToHG2bEk679DaET26LNwolCh2FM8wGaVXdqDj4UECUEkdfAnV6
42TeVifI7D/VQ+YmAk5eTSuK96sf+Ps5mztlxtKvMHYJl2d9Q24UNoN/TmDStAHZ
yqdl/ogRVS0ihkWIb7lJ2ZJwE9vmCegLdD2Fi8ieqQGCf/T66ns255mTNpSNIWk5
O59cDMsPtBs7KRDpxzE46XiEAIu8qfkucurJxsLuD0PV4Ics+gjsmvFlPMNe08SU
hDfYYumJVIBYI/BwL4lMmvjCSfX6/6NWq71qZQgT+oLW2JULE3sTeAY0J7origB3
63bofO5wJcqqa71tzavuEunuIwYh7yLr0Brii6gQ5biq3BzG+GSzskHNTZDO1GK/
8FCMMC09BksPm7A0KGJCNo31bQ3KumzLEATxKxTNeqfjeiaBoazwv6CpbQydQ7qO
M2HwQamfyiDfssD1PwKrGO6vz0t/Lrbc74U8jvcYDj2W6A+FGZU=
=w+um
-----END PGP SIGNATURE-----
--=-=-=--
