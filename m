Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3C790C86
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Sep 2023 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjICOlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 10:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjICOlB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 10:41:01 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8254F5
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1693752057;
        bh=UREmBQKBOurSZZlb1Vx5DRDSnn5uwCLiPax0mfeJKHE=;
        h=Date:From:To:Subject:From;
        b=IRSXnsRY8rg9PpMgguZxaxEPKG52p8dnsZ/HX885aKy7qUA+WfDmeBx3B6jWvK3/A
         kZPWEE45d2svENs86OebNvazGsh5LMmAX3Vb2OkSd7niEluLZQLTeGC+HVM2gAuNhN
         ga7A4Lc5U4wWdNEIrJ5OILaPq8k2rfBp5qL9p/GocpHuzOe8Um65NzUbAIxZC+NBzd
         Vt96t3YIq2Dv2q5CEh0N6fBAzoMmx7F96Z8dvye10sxpV4y9IUTkdWEzLuR2dW8cwW
         fM0QT72Cmql4UwEktIB0ZGvqLULUk+O1s/R3mOIpyeTbXc1zJd0Lsyq7+AHd4ioOcA
         owZ+rWL5t2UuQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 88F4FB224
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 16:40:57 +0200 (CEST)
Date:   Sun, 3 Sep 2023 16:40:56 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] Fix broken markup in rpcbind.8 LINUX PORT
Message-ID: <jxmb4chlu75sr7sqzte6kfz2nvxqi7jm7gvcz2k7trkcyc3ctp@yoq5hmy2xcdv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zsqlfg3tr4wrjkwo"
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


--zsqlfg3tr4wrjkwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/rpcbind.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index 9b9fef6..7053d37 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -156,5 +156,5 @@ .Sh NOTES
 .Sh SEE ALSO
 .Xr rpcinfo 8
 .Sh LINUX PORT
-.Bl Aurelien Charbon <aurelien.charbon@bull.net>
-.El
+.An Aurelien Charbon
+.Aq aurelien.charbon@bull.net
--=20
2.40.1

--zsqlfg3tr4wrjkwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmT0mvgACgkQvP0LAY0m
WPHF/BAAj89TqDJ27hCHx4pkEYqqV5ZCcWzdI7749dAr4IBS2MtOELpvG0K+spvI
Avlkw0VipKD+SHBj7wD7muSLusaDnOKWCNaHWMl9hkYMJCJWQjuGJCivO09Th1EI
q/xDLnRiN/Baq9CVRIVx2I5tCPsQ8HAAVtpHJpmMvXwgfwoqEY1qwJWaf/nb6wDS
Be3GbGJs7iC5rKs7ZH6Aw0ahZwp9JLRBVmX69gi9TId4ncB9CZTfoprbRT64i8+V
+cTZn02hQS0koQMY6QF7eBYufJ3hHLVB3mRCpxtMgMmou6T9wPj7ON6wFy2FPD6h
+QSDSGlfg/UY75LRYAJTBrld7lebg6AkXPZighj+ZweOG+aP6TmYG1MvPw36Ydzb
XhkHMq76yaqP/50Bd/XH1gy3EZungXW8mgK+5r1HnCRaOnZgVaxFTPlim4EzApOZ
E/oBNNwTKaOWRQtWKH5JzPJk74+nZ9fS8Qw/sULx6ZfRzmByUL2HQiQJTmPNPzwH
AXij+fmAzcpupBcfX4vGeECSGApNk2o9zquAddzVJdjoTKTrcQTNIF8qDpOgepbC
3VAFeQonsBWocApYe51hEsKyCNTa7C58mm1usold+fXk7P7uu6ZKAvqnzqz0IiMe
KDvguHfrnZgRc3AdI11LHq6k8kv9v3BnrELrQXyJzOFIfUhXvaw=
=7aNp
-----END PGP SIGNATURE-----

--zsqlfg3tr4wrjkwo--
