Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6112641878
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 00:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436970AbfFKWzv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 18:55:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436750AbfFKWzv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 18:55:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FC91AF0C;
        Tue, 11 Jun 2019 22:55:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Tom Talpey <tom@talpey.com>, Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 12 Jun 2019 08:55:40 +1000
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <e33a22ef-b335-36e1-ea7f-2d2b5b2ed390@talpey.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com> <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com> <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com> <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com> <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com> <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com> <e33a22ef-b335-36e1-ea7f-2d2b5b2ed390@talpey.com>
Message-ID: <87ftofwx3n.fsf@notabene.neil.brown.name>
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

On Tue, Jun 11 2019, Tom Talpey wrote:

> On 6/11/2019 5:10 PM, Olga Kornievskaia wrote:
...
>>=20
>> Solaris has it, Microsoft has it and linux has been deprived of it,
>> let's join the party.
>
> Let me be clear about one thing - SMB3 has it because the protocol
> is designed for it. Multichannel leverages SMB2 sessions to allow
> retransmit on any active bound connection. NFSv4.1 (and later) have
> a similar capability.
>
> NFSv2 and NFSv3, however, do not, and I've already stated my concerns
> about pushing them too far. I agree with your sentiment, but for these
> protocols, please bear in mind the risks.

NFSv2 and NFSv3 were designed to work with UDP.  That works a lot like
one-connection-per-message.   I don't think there is any reason to think
NFSv2,3 would have any problems with multiple connections.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0AMWwACgkQOeye3VZi
gbmWMBAAgjh/jOHmBNhvFuLJDfiF7Vr21xsAa5L0z+WW1nJVloibzL+daWXuKXF9
J4OGW/NesYfpMV9REgrrRFVgwx3qhXk6+w+5HPJCq9uzeNXNPVtIeLELlhlJX++f
kWlCyWCG611v15zFRJX7ZCPQ0espqVOk3MlZmIDqaBynJZNeSZnAl9ehKdj2mvNl
V+rVdq5l4cndp0KXGxSyl30CvRjc81+C9/+E1OjB3iG29/ukAw72AG/UH/5NBFf6
mB+48Lb4ZquoLyI693NO+/xO2i0YdNPw9/JmXV5gpYF/ZDiBdd/4qs1JHlD0hAqK
jwK1nBICg4W0COTw37WncgjJJJzFCbF0xmg0UAevGMYL9wMgYHSfVGZJCY5h+pp6
HGE46lJ0qI0F+G0/L7VWdzrHMPlpmZhzi+qAKMn2Qj6xK93yC29AO0kcG8gOPDRG
PThT/1gbzLfDwcEqpGTfhgalnSfK0Mm0uh8iEERd9GTKYZdcMaGSlLn3i8X7sROp
brPa3OtAyuXWYwpyanyfjloOCGX+fywq0cot+63h0eoxEYxeG0Me8upWFqkfql4/
W5jkaqTmQqSp1lI7bu1hXgwucm8bmSy6zq3jaJApHD7pIdLwxlkaGkAWLqImKAU2
YNGGcLTAsro0G+r5j6gzRlFeitgGYsUP890qTOU4qLIdy7bjfp8=
=NxyM
-----END PGP SIGNATURE-----
--=-=-=--
