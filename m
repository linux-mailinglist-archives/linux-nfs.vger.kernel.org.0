Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08951698AEA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 04:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBPDFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 22:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPDFX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 22:05:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90082006F;
        Wed, 15 Feb 2023 19:05:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHKZ35GHgz4x7s;
        Thu, 16 Feb 2023 14:05:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676516716;
        bh=3FPnf+07xD0ONPxXpK97iOyQGqkBz83fZ1Nfp+k0cnU=;
        h=Date:From:To:Cc:Subject:From;
        b=NZtKpkQ1uBbI4sOG/Ay6CQTP20fBMqtsb5scM1i2xn3OM+68ma9u0a4DxNmbChIbI
         pYS4JDNFBVAgNKYCvxzWCq/b9DbBaKtysiEEG1RP7dmBMqB3kx1q82v6e1m8pBiDKR
         LYnRUBRYlHMJGH/YMYT1da7c/Y+pyvtxkn++q25QrL7Bhyfnl78dQ2U1AmZmpgZmzj
         GRyu1RAmZy67QJCDA1xvek3tLYHb5Eld9RCMc/t2+VGVtbvbxshAoWtkMj9C+a0SKg
         GHGjK4MVlLeh+5uM/X3Hiv0NrTknZjfNXiKDNXJVKOeds1qhENBJq8X+0R8v60mtT4
         VG8nROC4GJtaw==
Date:   Thu, 16 Feb 2023 14:05:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Cc:     NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: linux-next: manual merge of the mm-stable tree with the nfs-anna
 tree
Message-ID: <20230216140514.631bcca1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qdgU71WLDhPmzVBHko2q0C_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/qdgU71WLDhPmzVBHko2q0C_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  fs/nfs/write.c

between commit:

  0c493b5cf16e ("NFS: Convert buffered writes to use folios")

from the nfs-anna tree and commit:

  d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfs/write.c
index b508c985eb14,9d6432cb3f44..f4cca8f00c0c
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@@ -688,15 -689,14 +688,14 @@@ int nfs_writepage(struct page *page, st
  	return ret;
  }
 =20
- static int nfs_writepages_callback(struct page *page,
+ static int nfs_writepages_callback(struct folio *folio,
 -		struct writeback_control *wbc, void *data)
 +				   struct writeback_control *wbc, void *data)
  {
- 	struct folio *folio =3D page_folio(page);
  	int ret;
 =20
 -	ret =3D nfs_do_writepage(&folio->page, wbc, data);
 +	ret =3D nfs_do_writepage(folio, wbc, data);
  	if (ret !=3D AOP_WRITEPAGE_ACTIVATE)
- 		unlock_page(page);
+ 		folio_unlock(folio);
  	return ret;
  }
 =20

--Sig_/qdgU71WLDhPmzVBHko2q0C_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtnWoACgkQAVBC80lX
0GwLcQf/aGPPu+a5LaK31tdtkX85mxVDeAPhP1rR2RRnAAuhX8M/OgMwfX/TfQ6e
6hgbBrPPHAJoZNLynciotlVCxSHEdc50IglBDG5u5oH2QB8CvktdgH0XB7j7lk6D
rGwfOO73mbbeobuVLS7CZqbSMd9jKK7zAq7Kyb4p56zk9Sza7LIEvaMZYrX+JFVb
fcb5rU8B3+lncGMiOZVZHUx2zSQlRoZixYwAHiwpIGtODeKKzZzl4tea2hy3cXn0
dRYS/Zc55KDIvoxD+BmYbjhLY8nqUrOjHsSSLOm58au/ZWOMGANzEZ7RvcHvIHgB
GQf6B/r9n86Fkbn630bRTcbs6yEISQ==
=xkMY
-----END PGP SIGNATURE-----

--Sig_/qdgU71WLDhPmzVBHko2q0C_--
