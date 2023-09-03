Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AB2790C58
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Sep 2023 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjICOGN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjICOGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 10:06:13 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0FF3
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1693749964;
        bh=xgc52zZIxI01oKwEbknw+2RkKh2Y5OWJ9LpZsTuCmuk=;
        h=Date:From:To:Subject:From;
        b=ftlolQC2GUoGSpzwTkf6M80sTh6//nTN4tB5unpAmKOtvY6TiGrK31orw7eElALix
         ZpQ+O5dM7X2RRR0dWjGg79ddtm5wlSJ1aTsA6cC2UQor9TavWRPsxF0S6ipVTIILw5
         RXd+1SNCZJ5XshDn9MP/Sq74Mof8aMEsCP+iFt2bioba/bp6DIMc8+wVMobzLd/7Y1
         RZFhN48dihUaaGoxJ0EtxFmEXziD2ffVVzU+XNPzW7u4CUueHWOaF4M6DRk2oI2zxy
         pU5juYiOPDFHspK63qJ3/m4q7JosqV5cFPLpxungTbZakZLFEhoGuyb/5fZdnD5MvQ
         W+erBGottsj2Q==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 896B7AF72
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 16:06:04 +0200 (CEST)
Date:   Sun, 3 Sep 2023 16:06:03 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: "defunct" nfsv4 and pnfs list archives on linux-nfs.org 404,
 nfs4-acl-tools manuals all point to nfsv4@linux-nfs.org in CONTACT,
 linux-nfs.org doesn't accept mail at all
Message-ID: <bl46czx6zdb7khjnrme2cpotpqjm4cs27e6hfg5phsytpt2oxj@l7xknuik2q3e>
User-Agent: NeoMutt/20230517
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6yor3hdrfsatset"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--t6yor3hdrfsatset
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

All manuals in nfs4-acl-tools have a
-- >8 --
CONTACT
       Please send bug reports, feature requests, and comments to <nfsv4@li=
nux-nfs.org>.
-- >8 --
stanza.

linux-nfs.org says=20
-- >8 --
Development
    Mailing lists:
        linux-nfs@vger.kernel.org (archive)
        linux-fsdevel@vger.kernel.org (archive)
        linux-kernel@vger.kernel.org (archive)
        defunct pnfs list archive
        defunct nfsv4 list archive=20
-- >8 --

Additionally,
-- >8 --
$ host linux-nfs.org
linux-nfs.org has address 104.238.116.91
$ telnet linux-nfs.org smtp
Trying 104.238.116.91...
telnet: Unable to connect to remote host: No route to host
-- >8 --
so you can't send mail there if you tried.

Probably replace it with
-- >8 --
CONTACT
       http://linux-nfs.org
-- >8 --
or whatever, that page has links to bugzillas &c.?


Also, the archive links point to
  http://linux-nfs.org/pipermail/pnfs/
  http://linux-nfs.org/pipermail/nfsv4/
both of which return
-- >8 --

Not Found

The requested URL /pipermail/nfsv4/ was not found on this server.
Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips PHP/5.4.16 mod_perl/2.0.11 Perl/v=
5.16.3 Server at linux-nfs.org Port 80
-- >8 --
which isn't all that exciting (sans broadcasting a January 2017 OpenSSL ver=
sion)
and definitely not the right answer.

/pipermail returns identically.

Are the archives, well, archived? Or are they lost forever?

Best,

--t6yor3hdrfsatset
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmT0kssACgkQvP0LAY0m
WPHzDw//eTIkqjxjCOD6YbeMn4aGVgxIRE75yYfZNHUaYYoK8qu1ZXLtFHFfopTH
4ndn+hT9epmoeUTagkh3LPbnwi+0tyMdq1o449a702rUFbmRSaMfq0nR/XVxUINX
JW1FObGLgO6RrsR4oOdoDEV3YF637eFfJ4bTCvRD/HURtjqp+jzb4/RuqxXov/xk
CxDwd+IBryrbnwroW+eRHJxCqirMQyL6orDNC7BP/ccWRc0kid0EPjj/bY8Bs9oX
sQElgH85NzWj0stsEdW4KQ+NuxsrYNcwZMzrBFJL3jJ2mW9zCK8bo1zekS/0KZQ8
dIPOdnAP9cQ7jwmubYFCG3qjbC7kqwTcBvLoPJTyP3woUii2zHZnWDb5YQp6+72M
nYkDm5Hb3TpZ5qopfkH54cLW7MnjzoDmYMSVQEyaTyn8nOq6zve/LQ3tAXYF5ZXA
o84HoTsm+tAoi5EdDK+UzjeI33C+DgEMcLP2JphCBJrHTOMMfAa7QIH6+6QjbQB5
qdyv2PqO1xdVGyw5kMheqyFxr4P4idb7TGLYWWwWwDHt9QDa1X3vCuTHYAdmlZoU
tDTiAUf5lhnwon4OVKB7Z7mIq4BWO6c2u9UOqJKXQwHzmJQt8R9qWL2xWq6Ac31b
I5O7DWoUsK5Nfxf0jVAGf7Sfc7gKz6Ocm5eilyZQ8eB8fPgaNI0=
=glYh
-----END PGP SIGNATURE-----

--t6yor3hdrfsatset--
