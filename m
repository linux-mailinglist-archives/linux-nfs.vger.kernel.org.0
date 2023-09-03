Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC7790C85
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Sep 2023 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbjICOkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjICOkr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 10:40:47 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17606F5
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1693752040;
        bh=uw0c+ncHDZ3t7Otnt8uN/o/c2pMSydMQ2hU1ovayNeg=;
        h=Date:From:To:Subject:From;
        b=SHSrkGrkBYKUFFjH/aK/EJ7NS6RFgKnjLcnHJHjv1F11oLnRawVTZCXTnXWpigaQZ
         L1lUHICTyytUvFxdlz64IbLoV+JxSUpfprqhc97nzQMc834mkm8adQzV0LoCYTqQXB
         J5XMGaYcNDPy8Vck1TvM8m8mHTIdFKTuzDfTxYkgbHxw13x/ELVK1nSJ3ZGN/mb14l
         EPgrS2lK4UYeprbnRhiSJXv/6gqhUlcNF5hols9Bo6MdpsCgysGnIRK8tJyYLJQ6ca
         865z2t2c+mx42xA0x+NBlLyFTaZELz9c3D8Z+kXnc44S9ottlPVzRIF9N+ulveF0u7
         PIbHaL0AlAMjA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C31BAB222
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 16:40:40 +0200 (CEST)
Date:   Sun, 3 Sep 2023 16:40:39 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH rpcbind] Remove spurious blank line in rpcbind.8 (and empty
 lines + additional header from rpcbind-fr.8)
Message-ID: <rrlvgbrrue5opwjd4y7sxtlezgbeidmo7ebue3xrt4idvbyn4m@gfb63is3alih>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5gnxqbufpgwly5x"
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


--o5gnxqbufpgwly5x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/rpcbind-fr.8 | 4 ----
 man/rpcbind.8    | 1 -
 2 files changed, 5 deletions(-)

diff --git a/man/rpcbind-fr.8 b/man/rpcbind-fr.8
index 7db39e7..5e1236a 100644
--- a/man/rpcbind-fr.8
+++ b/man/rpcbind-fr.8
@@ -3,10 +3,6 @@
 .\" Copyright 1991 Sun Microsystems, Inc.
 .\" $FreeBSD: src/usr.sbin/rpcbind/rpcbind.8,v 1.5 2002/11/27 15:33:47 ru =
Exp $
 .\" Linux:=20
-
-.TH "RPCBIND" "8" "13 aout 2004" "rpcbind" ""
-
-
 .Dd September 14, 1992
 .Dt RPCBIND 8
 .Os
diff --git a/man/rpcbind.8 b/man/rpcbind.8
index fbf0ace..9b9fef6 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -2,7 +2,6 @@
 .\" Copyright 1989 AT&T
 .\" Copyright 1991 Sun Microsystems, Inc.
 .\" $FreeBSD: src/usr.sbin/rpcbind/rpcbind.8,v 1.5 2002/11/27 15:33:47 ru =
Exp $
-
 .Dd September 14, 1992
 .Dt RPCBIND 8
 .Os
--=20
2.40.1

--o5gnxqbufpgwly5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmT0muQACgkQvP0LAY0m
WPFoFBAAhmpzRz06aW9/Y+xdmpIxO5iaaHFje2xJeZftRWAaI8V+cR5UMo74LTMP
vRRinL6LfrXxR1d2SWN3/1XKtBumAQDHiUfO4KsyYBkJH5lAl1VxY2HLnNvvs/uz
odXV2DH1RxwTU9LNVLrKfmQ4G0iJHpcekiHKmxYjFmqVaBjGReHyclGTAEvpmgNL
71REitayNVAwZcZIJ5KTZphbkYidYVYymSdyMfBUyhMMeF3Kj3e4sEXt5vLIlMCG
B8i+nLpN2aL6gKEcfyiPdZUx/Hn7JFQKu/9rgHCb1Aimrt4RVTAaREPW+KjCQzGC
Ca7GvdcyLTcz8p3SQ1+B6hTlMLKxXtmIErB3Q9zlkVm7mIdGoQEOSGI81jhoIsv1
o4L+KnIPYZ4UFzELHWYjEVXgChr9y8RMBbflo9Iazo2NWDKbBs49KT7OCB7frraE
fD1/apYCqBUk+Rb7TimQjqlCAgqmtrDd/QbWUmfps/LgOyNRT9eww+JrILyaKwN3
xhfT7Lm+inQ8ks9EuwhF7kCJMJDFYptn8qcY+QuuN9aS+FwoLxlXbTLFFRc6ApY4
ycZ8tfiujsILQZ4p51zbvo0WgOS3ZyisyJUmwacaAhezkdxmbzpC2iB7nuyFriF4
09pw+/ve0tgGoc1VQPoAZtebfRHAN7uWPK/SZjOxr8Dldwoh1dE=
=VdMV
-----END PGP SIGNATURE-----

--o5gnxqbufpgwly5x--
