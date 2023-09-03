Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8F790CC1
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Sep 2023 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjICPXB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 11:23:01 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56596F1
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1693754577;
        bh=sxo5ccr1lY+PT2swNH9zD9KjzRy2UjHSRv9Vo0OLvIM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FK4Yus8OQ9k/2XyxDi+3Jn0+TqJQirritZxV3fJHjKoSi/6ZM0ApwzVGyThKlcq40
         yfVVoeciYldI1qBBu1MccMd5ZE+Qj6PElvyLVQCivM0Ai8b6QWll2ZUxmGKZZLcIm4
         j9EFKhIKaPTV/FkOZhNG8fVmvpmMtD2P4qCVrhqa1Ejcla+8UMqrV4STzowGJj06i8
         v6ZfWswBQ1kO68d+c7sAuYUG4vgQejw6MrP4NZv3r8Frg/hZlInOsL/0+P+CIA5hOK
         xWVi/ZR1kokSbfE23ceS0vHzw30JcZ7enUlBlfnyHwBZH8MPrtBrcuSJlF578Vu/KZ
         /Q/i0h8ZGFDhg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 08CB9B3B0
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 17:22:57 +0200 (CEST)
Date:   Sun, 3 Sep 2023 17:22:55 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH nfs-utils 2/2] testlk: format off_t as llong instead of
 ssize_t
Message-ID: <44adec629186e220ee5d8fd936980ac4a33dc510.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
References: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7f633dn6vbuj36yp"
Content-Disposition: inline
In-Reply-To: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--7f633dn6vbuj36yp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This, naturally, produces a warning on x32 (and other ILP32 platforms
with 64-bit off_t, presumably, but you need to ask for it explicitly
there usually):
gcc -DHAVE_CONFIG_H -I. -I../../support/include  -D_GNU_SOURCE -Wdate-time =
-D_FORTIFY_SOURCE=3D2 -D_GNU_SOURCE -g -O2 -ffile-prefix-map=3D/tmp/nfs-uti=
ls-2.6.3=3D. -specs=3D/usr/share/dpkg/pie-compile.specs -fstack-protector-s=
trong -Wformat -Werror=3Dformat-security -g -O2 -ffile-prefix-map=3D/tmp/nf=
s-utils-2.6.3=3D. -specs=3D/usr/share/dpkg/pie-compile.specs -fstack-protec=
tor-strong -Wformat -Werror=3Dformat-security -c -o testlk-testlk.o `test -=
f 'testlk.c' || echo './'`testlk.c
testlk.c: In function =E2=80=98main=E2=80=99:
testlk.c:84:66: warning: format =E2=80=98%zd=E2=80=99 expects argument of t=
ype =E2=80=98signed size_t=E2=80=99, but argument 4 has type =E2=80=98__off=
_t=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [-Wformat=3D]
   84 |                         printf("%s: conflicting lock by %d on (%zd;=
%zd)\n",
      |                                                                ~~^
      |                                                                  |
      |                                                                  int
      |                                                                %lld
   85 |                                 fname, fl.l_pid, fl.l_start, fl.l_l=
en);
      |                                                  ~~~~~~~~~~
      |                                                    |
      |                                                    __off_t {aka lon=
g long int}
testlk.c:84:70: warning: format =E2=80=98%zd=E2=80=99 expects argument of t=
ype =E2=80=98signed size_t=E2=80=99, but argument 5 has type =E2=80=98__off=
_t=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [-Wformat=3D]
   84 |                         printf("%s: conflicting lock by %d on (%zd;=
%zd)\n",
      |                                                                    =
~~^
      |                                                                    =
  |
      |                                                                    =
  int
      |                                                                    =
%lld
   85 |                                 fname, fl.l_pid, fl.l_start, fl.l_l=
en);
      |                                                              ~~~~~~=
~~
      |                                                                |
      |                                                                __of=
f_t {aka long long int}

Upcast to long long, doesn't really matter.

It does, of course, raise the question of whether other bits of
nfs-utils do something equally broken that just isn't caught by the
format validator.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/locktest/testlk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
index ea51f788..c9bd6bac 100644
--- a/tools/locktest/testlk.c
+++ b/tools/locktest/testlk.c
@@ -81,8 +81,8 @@ main(int argc, char **argv)
 		if (fl.l_type =3D=3D F_UNLCK) {
 			printf("%s: no conflicting lock\n", fname);
 		} else {
-			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
-				fname, fl.l_pid, fl.l_start, fl.l_len);
+			printf("%s: conflicting lock by %d on (%lld;%lld)\n",
+				fname, fl.l_pid, (long long)fl.l_start, (long long)fl.l_len);
 		}
 		return 0;
 	}
--=20
2.40.1

--7f633dn6vbuj36yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmT0pM8ACgkQvP0LAY0m
WPGlaw//Sp1k5Q9ExR8lPwzh7Ib27boQD7lAWEWRnxombn46j18jxur9dBLcJ6h9
+puyN0X0xih2l30x5FOIlgk4BbJv+2UiwwsYCqZqvc81vbFAMU1qlTUSMIVdHGwI
edHTxPDuS2j3NBp5nG79Gob9C4TSQdypV1tvw37KCzsiSX52nStU54CoxroisapH
FN3+wcxP9s9x+Oc7lrUlEgWl6gSvcS5R0+LZ3EL67Dl2h7eEi2wSWxy7eXFePEdo
Lwcch9+8BJRKDkLgSoiqRH+B3gYbxNdqDgJHutXeQ8nqwmocMgP8gINN2XL0JpCH
BQZvwvkBqK/SFGmvdhPVYK5Nlh99lnkbSZEckgfb00rL8/eRX+3wp/L7AM9VzQj8
kq8BByKEOxpJVMERFM75t7Oz3xj8G1CAn5unnC0EvwEugLwDv8cTFGA64KJ6ya3T
nEeM4wb6YhV3vsm7008F0rIBVLRv+fDfxVuML/2kidk1eZhtOlLI6tTuG1SVOIA+
J/PIAetAjAcs487iZtW3VJ0v4Sbl6nBiIyHIEfZ9hSA3ymWTYF/fh18ZxuzcoHXj
EBsztwu4CpNmPcPxsPBQP8V8O+eIyIfBWMkQxqlqkZoZgX+zQKdcid12TbNgCe05
Ki/gFhzfvAfg2Q3qPePfkvCplNmUPsyetlSEOwikf66TF2IY9DU=
=rnQW
-----END PGP SIGNATURE-----

--7f633dn6vbuj36yp--
