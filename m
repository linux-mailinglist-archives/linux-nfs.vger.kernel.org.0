Return-Path: <linux-nfs+bounces-24-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AD7F37EA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 22:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C2B1C209F3
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5754660;
	Tue, 21 Nov 2023 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Z1ZRQtZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB49E
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1700601312;
	bh=V/2u98MfntNlmRi0sX9orXGuHbp4wNeb3u9jKOAH7eM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Z1ZRQtZDlbDaTIWZtESXF50et2S6s2JupI3VokslgADaVEp6Q7WPxqd7XT+qZpkBt
	 QheyFOBb3m5I/YRCxuJ2/0IKl9GCIzk5VRQmlgho4uEwwjkV6E8u9jSvfL/1NIb/Ab
	 Z1eVs7LIHdxuytPhfWQ7LBo9jg5nCgqES2WLogSjB3ovAx8nphBTJvj4yJhtB4vYoW
	 l04eLk3NPEnPTpFmXpEOR0Ej4oqQ/P+CR/nvzS3fsLZqu1q62/8WBWHYCxJo/2wTg3
	 UrBAHO6a4voy6YOEL5/cJU28z9fgZ5VrRmQWAldWuKZ7Evh56WI1C4M9n9eHnlKvG/
	 Ht6QvzTM5Ij8w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 242CD12400;
	Tue, 21 Nov 2023 22:15:12 +0100 (CET)
Date: Tue, 21 Nov 2023 22:15:12 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	Steve Dickson <steved@redhat.com>
Subject: [PATCH nfs-utils v2 2/2] testlk: format off_t as llong instead of
 ssize_t
Message-ID: <9d2b8bdc146a1fb48b391ae1adda0b6249ba9c5b.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
References: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxkx66smp4tdocgz"
Content-Disposition: inline
In-Reply-To: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103


--gxkx66smp4tdocgz
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
Same as v1: <44adec629186e220ee5d8fd936980ac4a33dc510.1693754442.git.nabija=
czleweli@nabijaczleweli.xyz>

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
2.39.2

--gxkx66smp4tdocgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVdHd8ACgkQvP0LAY0m
WPEiqw//ePjCClOu9oYids8fkvHnwrLOu5bqLbsEHCKNSCp1h586XOAW4wG9CzsE
Sy2dKCi0LVwuNUMpi1awog9TQvGE27LA/EImgbK/RjLQOiIiUmYZ230k/DK+jiFq
HmOgcuCaKN2G8xnDlkuLeSbJ7xCz0HSeMb1+G6BTCLmGJLPxKsC+E6axFN72cCc2
Wrn08n1OL6/EC61VKa0bNhEAWxVn3Atn4j2c+IfgwuEFbccny2ay2Nsxj0xw5M+D
7rqC82VHc/IdvxLXaOzhJqgMpFEbY98cZff/hb8p2vDCPFIMhfjD8qXFAstZ75Di
wYB7padx/BqNk7+9mPMhHe/sSXGqubyI2LMep3PobrWE6q8Mu6OxmRT2aa31yJJA
qpXiy/MTE3JWlv1l+kOuZdeM3gylLH+4M/hjuXMzHCeAtdvTcDsJpB2Y3HiF+JVy
EoDiA65mc1WnxVpWipiHQhscU9CIzlRAI2c2v1eN6OvsaF/l0QBCUnbZWDmFPLh7
3zSoEb4Mg3pkSZadz+yNKRurUtNFmLZzSsWBNjXfWZf/EQr4eBQYoGUs2wd8PmhC
pkpQD6kjLVUXTJ+zI8AAL4xQzi1u2fPqwVtxWXkCZGTzXGp/ovmRYc4vsu2/Auwl
Sttrn/YbCh+3Ye4cIoWN7i5pXdSfkawP+XtRS6ZDLoVWtEPTJoA=
=fc2/
-----END PGP SIGNATURE-----

--gxkx66smp4tdocgz--

