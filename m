Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB71D30464
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 23:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfE3V6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 17:58:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfE3V6j (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 17:58:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FM0X0754z9s4V;
        Fri, 31 May 2019 07:58:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559253516;
        bh=pO6+tsCaXa4Sf/7hycMujzNJySqAMkvnXSPwwGUVOHk=;
        h=Date:From:To:Cc:Subject:From;
        b=Op+fP+LKjDYtyecH57DlJ1IOv9IeAcVWbeOGOAi+E3Nhm2jQBABswYgmD0aJhkPk8
         bWWxQbEMq6fI8S38ZJsQA7WtS7UNlhdWo15t4ZCEfhJs9iPJD4XGlgEFDdmLMxNgkY
         r8jMz764rw5oSPf+ouepsxI5HQZeqD1i7FuNAffKnlos1AxMqpdnP3l0MdexPP52WK
         jEyUOoijiiA1McFwKii+NLsW55tvU3XIcEgLYrF67gpYrIPW4sC1eSQbif2YZhNSnk
         rHsXtW+uHfzIL9hju1uwvI3w3KIRqnMe3u+V8moLX2PFgdKvW4WW8ZEgBC8qlu6ucE
         GRKbXT5qQqbmw==
Date:   Fri, 31 May 2019 07:58:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20190531075834.78bbdeaf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G=V4Jqd3sQno0kV7pCsaf5B"; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/G=V4Jqd3sQno0kV7pCsaf5B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ec6017d90359 ("SUNRPC fix regression in umount of a secure mount")

Fixes tag

  Fixes: c8485e4d63 ("SUNRPC: Handle ECONNREFUSED correctly in xprt_transmi=
t()")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/G=V4Jqd3sQno0kV7pCsaf5B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwUgoACgkQAVBC80lX
0Gw/XggAkpbAg9ArAfpP3jcqqudkDXSoWQkbTb4SnGRQm8LD3f8lIjdf8fifk++J
3r4WNXOaRxkw9CbClcPENnWfrMAOziIzW5hN2XLqcDGTSOGTeYpIQHkbvW4V4FUW
RJw/vDjygqiZPohs6/QadMdePOyw6qT9ODTxrPVfl3SEbsY9m/9mJtMZeXZTpQr9
FbJNST9MDLgwq//ZUa9TdBo561CJ8xnE7NBnHPD32U0UJ1RlWiK6Hp/BfKF26R83
P1H8ew/1YOxYVO7Uko1EcoWqyoByJwoANzTX3v/yR33biIIiLYHcp9fAipKTRnMZ
vHtSejahWOtsrOl6rKL92fdwax1hMQ==
=N/Lv
-----END PGP SIGNATURE-----

--Sig_/G=V4Jqd3sQno0kV7pCsaf5B--
