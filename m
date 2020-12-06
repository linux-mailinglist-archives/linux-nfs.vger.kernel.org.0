Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505062D080A
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Dec 2020 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgLFXcf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Dec 2020 18:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFXcf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Dec 2020 18:32:35 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE8C0613D0;
        Sun,  6 Dec 2020 15:31:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cq2lV1tJjz9sW0;
        Mon,  7 Dec 2020 10:31:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607297511;
        bh=veDtRoJjNpeoUhwU9xkUV0ECvQ2G/BDfl8peuJgxMaw=;
        h=Date:From:To:Cc:Subject:From;
        b=JQWY4q1Y542c2L6rqkdeQn8NkOrK2CyJt73RBiX7VBJM+FW+lPbJHZmUe4hAnFnik
         zE+13t0imSJ5oINuKrbh8z/jch7Cg4pVOj/7RsnxJXrbmBEOhF5z7PEJ87ZPFDsPLa
         xPmgHHqy5SlY92CkDXr9wWVbHctu7JaCoxypBXCUf6m1wGUOeiZ7JHIKAtcf8X9SW8
         m/Kc51B5hP2WHNFpONI/E3WNST7U8InwJ8jMrCwyThHdZGO2jBCE/13x/DYYncPj/+
         aFsZVXf07nsSEhkvukrhkiuNlpAUZNb2qHRD9aXAOW+HZPephSYk2JM518ygLtH0+X
         AO9Ss6a+O+Xqw==
Date:   Mon, 7 Dec 2020 10:31:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: linux-next: manual merge of the nfs-anna tree with the nfs tree
Message-ID: <20201207103147.4173f701@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FEc4XiccDvzt=g__qd+9su1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/FEc4XiccDvzt=g__qd+9su1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfs-anna tree got a conflict in:

  net/sunrpc/xdr.c

between commit:

  0279024f2270 ("SUNRPC: Fix up xdr_set_page()")

from the nfs tree and commit:

  861b1da5a534 ("SUNRPC: Keep buf->len in sync with xdr->nwords when expand=
ing holes")

from the nfs-anna tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/sunrpc/xdr.c
index c852d199c789,5b848fe65c81..000000000000
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@@ -1316,8 -1326,8 +1317,8 @@@ uint64_t xdr_expand_hole(struct xdr_str
  					bytes);
  	_zero_pages(buf->pages, buf->page_base + offset, length);
 =20
- 	buf->len +=3D length - (from - offset) - truncated;
+ 	buf->len +=3D length - (from - offset);
 -	xdr_set_page(xdr, offset + length, PAGE_SIZE);
 +	xdr_set_page(xdr, offset + length, xdr_stream_remaining(xdr));
  	return length;
  }
  EXPORT_SYMBOL_GPL(xdr_expand_hole);

--Sig_/FEc4XiccDvzt=g__qd+9su1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/NaeMACgkQAVBC80lX
0GxsDwf+ORDGRAgOuGsbhng9xdqrHgGwevSU0VSPVS2J2FPIJ92rFXOre75yVUsh
JuSTDtd6agkND902qicMUvsk5k3l/hBqXyL2YVKzBT7TbQTMa0Go3rglD450qQ6c
VYJ/4qnAQ9nwMoaV/Snt2pE4IWeOkkWmOhzEpMyPDNpr7udi8NfNzKcmYk8XYuAP
nfDDUxxoIh/WmPGRnQQoqcWU443jki8fUnHhOy7iZ542BklQ1slm8Ir6CA/61Hoz
t56ZIqar3ps9BR9/YP5NprQMW2Pq1qFOouxfx6offK+SCYMhU6eD+UKm9M97kuEy
/cBgzxSaNcm+S3WDWSf+JvDH8dSoHw==
=DIUD
-----END PGP SIGNATURE-----

--Sig_/FEc4XiccDvzt=g__qd+9su1--
