Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA1790CC0
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Sep 2023 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjICPWB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPWB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 11:22:01 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67491F1
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1693754513;
        bh=QMeZnV04dYfGiix7AosDHMUI3cZ6F+Vt4zBwig3niN8=;
        h=Date:From:To:Subject:From;
        b=pqk2GZEup8UyGYH4bRlbMqRp3WPaCkgJuGPQvF5Dl4HnYBgyAGsVLbFkKOh6vJgCO
         pYTH6NRwziCvGqyq9gavF9AJHC1LqjQJ5PKyJrg7RvfKO7X0KAmnqWOpCLTNo42RCv
         jjHUNvHfenTsGV2AJXidnAhkESqTrIymeoTq0teKrQ56CF7WexCUeccepUyWfrk+ul
         MY/w/+phxl9YrnQiMmvpoFjNcmbwv2VzNWcYvm8F2OVV3u8NjfD9e/+NVl59T0poXt
         P67oMmsfEOvJ0sRcU9+UyEnqFYmJBELLspJL7UJZSZLjtBiCOp+okBeloVgQdqwOlo
         yXmU4rMOcF0GQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9B989B434
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 17:21:53 +0200 (CEST)
Date:   Sun, 3 Sep 2023 17:21:52 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH nfs-utils 1/2] fsidd: call anonymous sockets by their name
 only, don't fill with NULs to 108 bytes
Message-ID: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aoy7vmz74ya75bx2"
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--aoy7vmz74ya75bx2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
  u_seq               LISTEN                0                     5        =
                            @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379     =
                                                  * 0
with fsidd pushing all the addresses to 108 bytes wide, which is deeply
egregious if you don't filter it out and recolumnate.

This is because, naturally (unix(7)), "Null bytes in the name have
no special significance": abstract addresses are binary blobs, but
paths automatically terminate at the first NUL byte, since paths
can't contain those.

So just specify the correct address length when we're using the abstract do=
main:
unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_pat=
h) + 1"
for paths, but we don't want to include the terminating NUL, so it's just
"offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
This brings the width back to order:
-- >8 --
$ ss -la | grep @
u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-api=
-timesync 18500238                            * 18501249
u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-ap=
i-network 18495452                            * 18494406
u_seq LISTEN    0      5                                             @/run/=
fsid.sock 27168796                            * 0
u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-logi=
nd/system 19406                               * 15153
u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus-a=
pi-system 18494353                            * 18495334
u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd/b=
us-system 26930876                            * 26930003
-- >8 --

Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
 better default socket name.")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 support/reexport/fsidd.c    | 8 +++++---
 support/reexport/reexport.c | 7 +++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index d4b245e8..4c377415 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -171,10 +171,12 @@ int main(void)
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family =3D AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
-	if (addr.sun_path[0] =3D=3D '@')
+	socklen_t addr_len =3D sizeof(struct sockaddr_un);
+	if (addr.sun_path[0] =3D=3D '@') {
 		/* "abstract" socket namespace */
+		addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_pa=
th);
 		addr.sun_path[0] =3D 0;
-	else
+	} else
 		unlink(sock_file);
=20
 	srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
@@ -183,7 +185,7 @@ int main(void)
 		return 1;
 	}
=20
-	if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un))=
 =3D=3D -1) {
+	if (bind(srv, (const struct sockaddr *)&addr, addr_len) =3D=3D -1) {
 		xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
 		return 1;
 	}
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index d9a700af..b7ee6f46 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -40,9 +40,12 @@ static bool connect_fsid_service(void)
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family =3D AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
-	if (addr.sun_path[0] =3D=3D '@')
+	socklen_t addr_len =3D sizeof(struct sockaddr_un);
+	if (addr.sun_path[0] =3D=3D '@') {
 		/* "abstract" socket namespace */
+		addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_pa=
th);
 		addr.sun_path[0] =3D 0;
+	}
=20
 	s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (s =3D=3D -1) {
@@ -50,7 +53,7 @@ static bool connect_fsid_service(void)
 		return false;
 	}
=20
-	ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct sockaddr=
_un));
+	ret =3D connect(s, (const struct sockaddr *)&addr, addr_len);
 	if (ret =3D=3D -1) {
 		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_fi=
le);
 		return false;
--=20
2.40.1


--aoy7vmz74ya75bx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmT0pI4ACgkQvP0LAY0m
WPGd2A//elhUHyLHrMXiEfRiLshSMoI1HR+PIShp6YnKL+gc7ZNl8/FogQls0xk/
57Hlk8Cj9SnhaXnPCCcu70/BlQtAvZfEx4Q3Lj3kI1mk5WiLXVccz1lgteW6Q7/C
wZBLgwuhPVhl8Gj3Ps7VTLxckGVOmJRDxgc580kngHCIPauDSfNMH9nxlcCJIHTb
JdJDU7ZXzHq48WqRrbzMiPE0JyHpxQ8LNZ7bgb6qS7UmgADbOAwIVjL3u+LENl17
PPkx2XtIRx/FPijwPpYYr6/167dBq0vrzJC60NLaDYZr9GHr2PFwx/tAn9mLrh1F
RkT84ihDtOO9ngziRurV/4Chq5VtZSCQCZp7lijdY4vNUG/zOamPfOrxx72iGyVO
ZK9FyDojKt6ByggW/6SlOb+iK6XGRj/YhnTUfOfXiZ00KfuC/W1Yxr8DXgrsmbBJ
EKKLt4AFY9XuHam0uE5qC1Rvbi04aCAZpepY4+oSt84M8GC3PNZB+z+e5TfVr1m7
dElUW8XZKLVKIpF04cFdANcFB6eUqzxm2zqJpMapH4dAuff4NkHlg/qP604y1y9O
i3/GU+0Wm3AqVobwFwXGYjONhHS7EqoHEszaY52lfqkNQlR/luy+SX21uh7PW4RR
KOLfjFIYXds5l/4vW55BYFVm8UwQ4JQXkp6lq64XcipZ6xP3bsM=
=Tg3r
-----END PGP SIGNATURE-----

--aoy7vmz74ya75bx2--
