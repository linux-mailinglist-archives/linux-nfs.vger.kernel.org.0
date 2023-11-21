Return-Path: <linux-nfs+bounces-23-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0177F37E9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 22:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD17CB212C5
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0E05103F;
	Tue, 21 Nov 2023 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="qtcKcdy9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB79E
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1700601288;
	bh=UY/QglsNzKErcVBfqS09kPdYvYOuojG/aj3LgOPNZ1Q=;
	h=Date:From:To:Subject:From;
	b=qtcKcdy998fQ2xvqCm2CBQtNBU07FzP3cVfPjgWtAxuQzzVZZ6FTGJf08cZzFnqBU
	 LCtkdqBLlAKTJcVkPV+Quht0IKNBEIlt1M7g5/WMEbc/ravPqAgKHRlP9Vb+IoYSbh
	 uP1Z6bJz8/o27SIm+c80NkCuFWUD5GlvuXlkq08+lEPU8NAI7IsVD/qcYSNBRCKBY1
	 QsyU6MwjlwgxNPhBO6tUb0hqB84dgxXsZ6iLti6rra8HM3IF13lf5N8/4KLvcTILdm
	 ZS1T1HrmlGckkJQQNcJeYK69TIducs6AVoQnlZC85HYi+lrE3S3FGzncQ7CCNvGXeU
	 fQDKKScPHEm2w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6070811FC6;
	Tue, 21 Nov 2023 22:14:48 +0100 (CET)
Date: Tue, 21 Nov 2023 22:14:48 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	Steve Dickson <steved@redhat.com>
Subject: [PATCH nfs-utils v2 1/2] fsidd: call anonymous sockets by their name
 only, don't fill with NULs to 108 bytes
Message-ID: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3fy3spqaa7dtfxb"
Content-Disposition: inline
User-Agent: NeoMutt/20231103


--r3fy3spqaa7dtfxb
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
v1: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli=
@nabijaczleweli.xyz>
v2 NFC, addr_len declared at top of function

 support/reexport/fsidd.c    | 9 ++++++---
 support/reexport/reexport.c | 8 ++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 3e62b3fc..8a70b78f 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -147,6 +147,7 @@ int main(void)
 {
 	struct event *srv_ev;
 	struct sockaddr_un addr;
+	socklen_t addr_len;
 	char *sock_file;
 	int srv;
=20
@@ -161,10 +162,12 @@ int main(void)
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family =3D AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
-	if (addr.sun_path[0] =3D=3D '@')
+	addr_len =3D sizeof(struct sockaddr_un);
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
@@ -173,7 +176,7 @@ int main(void)
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
index 78516586..0fb49a46 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -21,6 +21,7 @@ static int fsidd_srv =3D -1;
 static bool connect_fsid_service(void)
 {
 	struct sockaddr_un addr;
+	socklen_t addr_len;
 	char *sock_file;
 	int ret;
 	int s;
@@ -33,9 +34,12 @@ static bool connect_fsid_service(void)
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family =3D AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
-	if (addr.sun_path[0] =3D=3D '@')
+	addr_len =3D sizeof(struct sockaddr_un);
+	if (addr.sun_path[0] =3D=3D '@') {
 		/* "abstract" socket namespace */
+		addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_pa=
th);
 		addr.sun_path[0] =3D 0;
+	}
=20
 	s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (s =3D=3D -1) {
@@ -43,7 +47,7 @@ static bool connect_fsid_service(void)
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
2.39.2


--r3fy3spqaa7dtfxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVdHccACgkQvP0LAY0m
WPEz5Q/8D+gwix7am5rAfud72+DeEiYYjwIE+ZVj6uamCrX6G1myepmm2FY5YbZ4
mQdQadeL5aLvCQrQpb0tpljLlmbURtxkXqRuZOjDbhcLTmJSjp9KxQ41QfM3uXRW
Hog0n0dZQbz+y15VpB3UDsndBCqQuy777YjYgoFOqzmrkfYhUTcJAARslWsSHLGC
0J2iOSGWkvzZF7jhw9u1sD6JQGJ7voHHBchjIb3rSD/5n95e7YdW9obY4aDZILxa
hOBt5yPt2m4Jh2OmluFECXbBgKxCwXPaD1Le+fKJwnto0HsQaOgqpy5RMYOMEoW6
kl6ZXyucg00jURtB8QiQziLAm5CVQ8DF0gW/06oW0FnUt8skzWIt0tq7Rl64Dcxy
tqnZEIx8e6Uovt1WQtjSI+IjTpOEXwB9f5GCWJZNNE1wk2n/88xzud2RkfSB2uU9
SPnGSWo6I8mF5tU4H9TWWFODybdDlp35dp2+SzgaKZ+yToL7EF7C5bdDdc3FcNCV
q+X6AwjjT4QIkQLJtsmMoT8+fk3lfhDj/LC8xQcuWok3EkOIK3VAuzw7gFTvbriq
1mtloOdFpEgz58IouDN9YtGqSmA1B7cy1gjBrxihEhC1qsyiio8o1wKF5wEHDTQB
M29oLuCGZ/lN+ODP75QOnEwfGrllAJ8Yi2dfnAZqZ5wgDPKnAPE=
=0j0g
-----END PGP SIGNATURE-----

--r3fy3spqaa7dtfxb--

