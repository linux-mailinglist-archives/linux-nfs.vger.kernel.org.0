Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC020BCFB
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgFZXCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgFZXCE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 19:02:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FFC03E979;
        Fri, 26 Jun 2020 16:02:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49tspJ3d0bz9sSS;
        Sat, 27 Jun 2020 09:02:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593212521;
        bh=ErD3hVx16ib62e9yBwr2mA7G54pnVW1RLR3R14k82q8=;
        h=Date:From:To:Cc:Subject:From;
        b=afknylHD6+QhqS/UHqZNl4BVm+UJT0+WXyvezDX3JtXlzZi3q2cVfeUH5LL65Y1JI
         H098+7xBvnFM2ZwmopGOV/zgVhqIGDq0M4KfAnDmY3AFyT6ZSP6nvovDBS02n2CFNp
         YidRh089N/l97c2AUrxglTxfcsrEJ4XpL6M7sOugwuIobmal71QI8Wyxfe6WVTFFP8
         VWq26twIP0LOIrtskoBs+Tr5zaIUzZwDhNbyia77/Uxw6eIyWUwhZw/taSs49NpHYL
         7iiLGKBA1dWxodsZb/z0DBJk6LHnKuL5of+bO5Vcjd5heQ3F8PJi1cfJki/YV6JuWu
         9xJLfk/FTetyw==
Date:   Sat, 27 Jun 2020 09:01:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20200627090159.1ca4bacc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/shGYtj5aMBh12FUWd6BduR3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/shGYtj5aMBh12FUWd6BduR3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b7ade38165ca ("sunrpc: fixed rollback in rpc_gssd_dummy_populate()")

Fixes tag

  Fixes: commit 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to =
hold open")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/shGYtj5aMBh12FUWd6BduR3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl72fmcACgkQAVBC80lX
0GyiUwf+J7VmBx3wbzlCdrSYY7dXFd0wyLIpsm1r6ZMhRf8HpWhhgStneVzVTHNE
oLbmWDkAGXT0eotXYffQJMd6eS130kVrBBBzqgeLII94WjNQPjq6bmEH0joIqWoB
A6+m1PR7pyHskXGTTwWEi993uSMmI/1QYxkhDEDT1vPblIZVI6WS+0/E1rKGasur
5eAZISj8xeyVH1lyZOdr4wibYqY2hC4TVpCdvNgtqAP7KjayrJv5hVctsR2eaXud
lpdHs2KcdVLkV7jfGiiupu8G/stK+0+SSGgtoTA2pCRTL5ObeqLL9+GgvaD7ZeXd
Crx61+QkcD4peY0orciAtdm0NCqFug==
=uA1S
-----END PGP SIGNATURE-----

--Sig_/shGYtj5aMBh12FUWd6BduR3--
