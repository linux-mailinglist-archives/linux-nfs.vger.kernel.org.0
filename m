Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498A2DF6FF
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2019 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfJUUsf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Oct 2019 16:48:35 -0400
Received: from ozlabs.org ([203.11.71.1]:37709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfJUUsf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 21 Oct 2019 16:48:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46xpdD5d8Nz9sPT;
        Tue, 22 Oct 2019 07:48:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571690912;
        bh=gDF4wkv+s1LYEMnsm7mri2PWEZnHrKXE3Mvc13xEw+M=;
        h=Date:From:To:Cc:Subject:From;
        b=vBHbGbM2zmKQUHpHGS8T2EFXEUSa1TZ/+r/zygDt0weJUnH2julWSx5DHsuWphIgM
         8gXm19ZHfS/EbLNauCW2xxa5Yqy6nW7uFN0sPLdRVTmodvXdZ7c+7NkpgwG7RywS4m
         6u8eTWEHektE7wgRvWSYgTZDAhk24oDyfI3foPiFH9ntQBkW9vKQS7WXuuszIXeKdh
         POr1yW5JQKeBh5JQftIGzJ6WNbOPHrUYltn19AZ1qpH8ybT1vglfXIElmnfMbkejKn
         /bNHRTYcHtMz/UkuxbyAFi0G2TH1M1BTYiFuqrP6rsbxcrd/mMwx3xSsJNpD7QBhY0
         Bc2hRuGK9E7ng==
Date:   Tue, 22 Oct 2019 07:48:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20191022074831.7224318f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/68gQG_2V2_2sR/4huGbTA.T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/68gQG_2V2_2sR/4huGbTA.T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4609f9894ead ("SUNRPC: The TCP back channel mustn't disappear while reque=
sts are outstanding")

Fixes tag

  Fixes: 2ea24497a1b3 ("SUNRPC: RPC callbacks may be split across several..=
")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/68gQG_2V2_2sR/4huGbTA.T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2uGZ8ACgkQAVBC80lX
0GxShwf9HZFLZL0ytbND2qlHxAXWEGH2mDgt6TU/q9XCIaQMqrENoyaerZhWgkXd
vI3BqIsFB45N80yHcQW6XFyoOCY+fVimH0tso9nZfPHqC7ZuUS35wTG2ZZ1M3XaF
UJ6w8mZop0nT5kx+A1VVEB8r2Sdl4WrTEmpPZGzapKZqtIets13Lg6jJqN6nmxK6
fud3wS54fAoMPT9NBYuwZXDO5vhqHK80HTyTMHvDRImu3RpQU9mixmigiIl5mCzC
Pejdih4VN0cssRLVN2vPgbix3MuqRo6C4uRAHe6Ez97dy+MrHO/H1mxaupeVLtWs
O3KJrHHeETHXUm2//ednRroGQLMhvA==
=Cjol
-----END PGP SIGNATURE-----

--Sig_/68gQG_2V2_2sR/4huGbTA.T--
