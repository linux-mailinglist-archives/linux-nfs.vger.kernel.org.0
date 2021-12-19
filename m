Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E37147A232
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhLSVJv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 16:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhLSVJu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 16:09:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CADDC061574;
        Sun, 19 Dec 2021 13:09:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHFj52HGfz4xdH;
        Mon, 20 Dec 2021 08:09:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639948185;
        bh=FssGIj1LwRP3+G663Zfjwz+rySdBA0uHSttyY5d25vI=;
        h=Date:From:To:Cc:Subject:From;
        b=di3BI0qbqNscDngHI8m1/iTUVcLqAo48YPM6b2RU/Pgk2/ZRUyYeosywH7CoAKiMe
         /bp/sSJxdDJcxT98lQmgOsWusERHqE0CZSOQfUEgHYnpSFLrPrOLtS48M3RPkoL/2G
         Mv0MIMD5tdrIKkIQf5QiqsZ4EoT9quje7xJ6Ea54WCo3QluG2hIe5bsneWmMDHHyNF
         6V5lhjxkjNCBr5bWwsM+Jz60zXl2Jq985EBGj7Okc2Sftc0zVVhJuYiUYq479lnm8n
         tUlXnHni8vCXdu+JYdSlrotC8il6R9x8p3htZLolhdFzqoO/qujPWb+nifCY9wMvSL
         y4TO2arBekSOQ==
Date:   Mon, 20 Dec 2021 08:09:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the nfs-anna tree
Message-ID: <20211220080942.3419e1b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/apw/DhuIpO69.FCc/8b_al2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/apw/DhuIpO69.FCc/8b_al2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  9db96eaaf44a ("vdpa: Consider device id larger than 31")
  7cb22b50d812 ("virtio/vsock: fix the transport to work with VMADDR_CID_AN=
Y")
  d0d9066f1daa ("virtio_ring: Fix querying of maximum DMA mapping size for =
virtio device")
  856f8e666474 ("virtio: always enter drivers/virtio/")
  6b7982ff16ae ("vduse: check that offset is within bounds in get_config()")
  ba5a66b197f9 ("vdpa: check that offsets are within bounds")
  085c1e990ab6 ("vduse: fix memory corruption in vduse_dev_ioctl()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/apw/DhuIpO69.FCc/8b_al2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/n5YACgkQAVBC80lX
0GxNJgf/c9QQtdTtoiU/waMAxcuYOUJ3amaxGAfKDKUuu83ZHlQyK0lfjCBcwYlP
WOEz7e+lfh3orfl2l2KSztvWe2WhjKNrosQ4+euIUb1GJb4DKA1pXdtAEdNi3QWY
MGsPbFW/Iebvf2YiYe/Cq7TAWR5AWm3UHPW4HdEs8m2ZRsPJDWao5jjfbPYlm/Jg
Iue2+cUBUTuZ+K2a/leLOYmCEGgTmATDGpZyPK3cJVdQ+ibu+rAVQ8HcjW9XLa22
lNRnuFarL40hLVR34D3ZzV6Nsl3hzlzk6ofOMr7kfSYxUa4nL3R2tBLYzOyyhTKd
M/iaqBRPltxkxofWnQsaFDlbtN0uSA==
=sRbo
-----END PGP SIGNATURE-----

--Sig_/apw/DhuIpO69.FCc/8b_al2--
