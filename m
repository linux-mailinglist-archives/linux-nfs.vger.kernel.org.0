Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A924188B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 01:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437001AbfFKXDG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 19:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:58312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436837AbfFKXDG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 19:03:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84132AF21;
        Tue, 11 Jun 2019 23:03:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 12 Jun 2019 09:02:57 +1000
Cc:     Tom Talpey <tom@talpey.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com> <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com> <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com> <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com> <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com> <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
Message-ID: <87d0jjwwri.fsf@notabene.neil.brown.name>
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

On Tue, Jun 11 2019, Olga Kornievskaia wrote:

>
> Neil,
>
> What's your experience with providing "nosharedtransport" option to
> the SLE customers? Were you are having customers coming back and
> complain about the multiple connections issues?

Never had customers come back at all.
Every major SLE release saw a request that we preserve this non-upstream
functionality, but we got very little information about how it was being
used, and how well it performed.

>
> When the connection is having issues, because we have to retransmit
> from the same port, there isn't anything to be done but wait for the
> new connection to be established and add to the latency of the
> operation over the bad connection. There could be smarts added to the
> (new) scheduler to grade the connections and if connection is having
> issues not assign tasks to it until it recovers but all that are
> additional improvement and I don't think we should restrict
> connections right of the bet. This is an option that allows for 8, 10,
> 16 (32) connections but it doesn't mean customer have to set such high
> value and we can recommend for low values.

The current load-balancing code will stop adding new tasks to any
connection that already has more than the average number of tasks
pending.
So if a connection breaks  (which would require lots of packet loss I
think), then it will soon be ignored by new tasks.  Those tasks which
have been assigned to it will just have to wait for the reconnect.

In terms of a maximum number of connections, I don't think it is our place
to stop people shooting themselves in the foot.
Given the limit of 1024 reserved ports, I can justify enforcing a limit
of (say) 256.  Forcing a limit lower than that might just stop people
from experimenting, and I think we want people to experiment.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0AMyEACgkQOeye3VZi
gblMEw/+NOaEMvi+ErADREw2zQveM5B6ztljqJJOGTkgOZ8JxCAwjISYHfNwi5Q3
/PAFSI6d/jCdix5H6qc0ej5e7+hZD2IOjTTCNVounTBhteUSg69i2QvBoS36Ymko
iXDcdEteRnStLD12OZyGSsaBfKdEX/32DoecxAMMEzrjw9r4w9DL6VVo+fChe0sp
yUMuIbqr0xMAfc2QBBBMLaARfhZHG4+sU3FIutFL8gsZ6KZa9urNR/k3T1DNoVal
99bVDLQby7hvvH2sWJ0tDr0oN0vaG/s3jNxwxerxw+D0g6i2c+CNJEezeSzGDUb7
WlQMsPiAFjbSLMUjdKN8LTp0WTIr66M2dmmH7SljIIkKQFoHlRqpctvvvZDSndeh
7LT7MnOCK/p6R8KhZlR6RpfRoykjeYU1pGSykYhCVL1pGN6S2dMXVpeslPxuXLUo
RtYZCkCPLnNmldP8Lye/paAt5qGE64kO1uJpGD4NEWkxuhG/CatSnVBhzR70jh3B
W6QBhgBTgpdrteU7jQFqrHeKQSzNNw3SPIfq26nTKh3+dKhNV/KlJwp96gzD0pP/
kwDVmFtcoh3bUVUpfNjuyvvFENu7+J+CTWmpL/5QuwE3MSIGLhOyqppr+hAqdBRB
PHW7VTHwajWk/BbBmcHluwC1NcQwBapevwnydcHyBm6hg4tU03o=
=+46W
-----END PGP SIGNATURE-----
--=-=-=--
