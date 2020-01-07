Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40413372C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2020 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgAGXQ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jan 2020 18:16:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:48480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgAGXQ5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 7 Jan 2020 18:16:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B5B0AC66;
        Tue,  7 Jan 2020 23:16:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Wed, 08 Jan 2020 10:16:46 +1100
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
In-Reply-To: <20200107161536.GA944@fieldses.org>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name> <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com> <87v9qdf2gh.fsf@notabene.neil.brown.name> <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com> <87pngkg9ga.fsf@notabene.neil.brown.name> <9f5f220e64245d7f1b0359149876b5dc056dcf12.camel@hammerspace.com> <87lfr7fu9v.fsf@notabene.neil.brown.name> <20200107161536.GA944@fieldses.org>
Message-ID: <87tv56dfhd.fsf@notabene.neil.brown.name>
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

On Tue, Jan 07 2020, J. Bruce Fields wrote:

> On Fri, Dec 20, 2019 at 04:19:56PM +1100, NeilBrown wrote:
>> I was a bit surprised that nfs4_map_atomic_open_claim() exists at all,
>> but given that it did, I assumed it would be used more uniformly.
>>=20
>> So this all implies that Linux NFS server claimed to support NFSv4.1
>> before it actually did - which seems odd.  This is just a bug (which are
>> expected), but a clear ommission.
>
> For what it's worth, I did make some attempt to keep 4.1 by default
> until 3.11 (see d109148111cd "nfsd4: support minorversion 1 by default")
> but probably could have communicated that better.  This isn't the only
> blatant known issue in older code.

Ahh... thanks for that.
Looking more deeply, I see that we (SUSE) left it that way, but there is
a sysconfig option to explicitly enable NFSv4.1 service, and the
customer has explicitly enabled that.
So it is sort-of there fault.
Maybe we shouldn't have given them the option.

Anyway, it is all clear now.  Thanks.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl4VEV8ACgkQOeye3VZi
gbnV7w/+PTghatlAXGE71xURyVRetZ6VBugxmL9EL3c+25ETOQViNGoBzfzIEasb
hkLcsAYucyq4IxLFWT66Ab52kWsS2MsKPgxSsyE8mEj2RqtAOFHJqycmC6MiNYXN
JMNSpbo+cwgDJYo/+AcNo87oJ9VMnOb3OnKfEgzlJEnLp7py8qfQSUewMcYIpiSU
IfRwr1RM90AdWB/gBYco5WyRsUHYndjxPaHBVu+ZdU8VR2mebwRbox5aGpv0iTyu
9CzmAoKbKkvw7UZXa7OGU/1GiPZP/DzUGtHGeP/QbG00o4Stm2GhdjtBpSlsK6Lq
tKMoZ36IOt6suFwGV5Vpyc9/MRmwkyqCJtuQK2dsu8er2YHpuSfTXEK4HajV1c5p
QcZHvCF+liza9bmm738fozVk9CVvgX/30BNh0YPf+Wh4ZX1v9b8jrSKV+AvoLX4S
CFb5uFdMUWkRdFEOvB56CeIV9c7o7b98IhV99id2wWUTGT6htEewaPmQyXcFLyYE
6M1UXXKKGGwOv8ZAUAtAm9jytISlt0h4reHnV4aq6aVwEW18rWY6QYSL3qwRFPyA
+SnnZUZqjgmrCmHtxlr6tXfST+l5E/0+vl1bUF6L4gW8lXN8Jgc2yE5mq+ORU7uh
lxqhGPI2TG8/0Ylj3sw8iy0kgUrxZO/Dt9OJS9S7n5AtMavHTV0=
=BDza
-----END PGP SIGNATURE-----
--=-=-=--
