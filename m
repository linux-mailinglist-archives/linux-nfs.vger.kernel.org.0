Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9950179DB93
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjILWGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjILWGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 18:06:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEAE10D9;
        Tue, 12 Sep 2023 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694556395;
        bh=7yyEVzv5R5Mek0+GIIAVeF4dyc7smVUviY+uNMqkA7Q=;
        h=Date:From:To:Cc:Subject:From;
        b=Itbevz5qKXhlgJMDxGHH+Sb0cH9osCWi6Ut+jUZb3IDirD6Iq6pn8tsqAPfD3gdAP
         mzzOJ2LX8p9sF615hO/5EroTKNsLicZ8BS4td87yIEMTtfI8+v9S3B5fxDqfR9zINm
         vgqllGL/k6KAJWzTVYeMPyykeV8dsDdD27oKJP6WURTSi913a0nxWxw1en3aH8FM2k
         JoK+umcvgaUZMFfiu805ohDEMcmrttZPEKz4CneYOgOWBDDPdFI6vhhqgHIsUQpFUg
         0f14xirrgK4ymPI4vyDz9NLrDn2JLsoXNHtntprUcbx6tK+arXHsmFyLfd64jZHK17
         l43NoT036ODkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rld2z0qq9z4xNt;
        Wed, 13 Sep 2023 08:06:35 +1000 (AEST)
Date:   Wed, 13 Sep 2023 08:05:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20230913080558.2fefa873@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8684WgscBoc6bHhpm8W4g3l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/8684WgscBoc6bHhpm8W4g3l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4788db30d973 ("NFS: Fix O_DIRECT locking issues")

Fixes tag

  Fixes: 0703dc52ef0b ("NFS: Fix error handling for O_DIRECT write scheduli=
ng")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/8684WgscBoc6bHhpm8W4g3l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUA4MYACgkQAVBC80lX
0GyYdggAj5O5WYzNe17kwWMEHdHAnZjz+rVvGiTIcXUcux8dAFFJUzXzwbG/4gHQ
JhfUFKCCblQZeB7V9Z7t0SPE0NG6XFiAXU1Oc85e+596s//R3nOsag07oi2AJpGD
ganIP9LPNtAo07JYFkHHZ5sCLl8Ov6i5JS82Ziharx4dnpQJub1kgTaG5g1DVoOB
TlEXyGnc+j1VPzlH7T2PVHZz2XgZjbQWq4Ei6s0PkFkk6Vg4IlHHAe6JDto9Hj9C
DBEy7oyDYozg++WXxC+tjzi+w5ByLMrYy6J5vRkXEH6S8+C3aqHp+JhnKdPxIYnz
uHu/bqvkZLXQT0QnVTmumsvHbkEBVw==
=Ez6H
-----END PGP SIGNATURE-----

--Sig_/8684WgscBoc6bHhpm8W4g3l--
