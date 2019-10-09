Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBDD1A1B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfJIUwt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 16:52:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIUwt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Oct 2019 16:52:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46pRHf28Gzz9s7T;
        Thu, 10 Oct 2019 07:52:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570654366;
        bh=sW/uIIEg3HKL73QILNG9s2yJg+52FrkQF9LHdLytVsU=;
        h=Date:From:To:Cc:Subject:From;
        b=IbJUJaF1BZ0bM152YY+HMES7UXrN8g/WJ5zHBkDKzH9EsqrhG+J6iwu6+5LP45z9C
         9T/tep5hmCe0HvXtFC7xlfz2b2b396prFvRmlrSxNIvjp9ZZna4q/8a3XL943GXVwV
         nv1PYM4eWapVoL5Aiohl+JZ9xAnfeTpofAcqMDB3xv3FtGPluECrlfRu3j25AjATlk
         8O7Ly9dIJj5PEzvs/vwG9+eLO3XRGJFkrMwBRQSPASPMM/EGSpudjV6G6pfP1BBuCz
         u1TU4MdRpjSVxm+6Ql8ePULgYa6w+ViD2iRJ/JkX7+D2216mhZW6dkAgO1jA+Cpa/8
         AscsEdJIa+IDg==
Date:   Thu, 10 Oct 2019 07:52:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the nfs-anna tree
Message-ID: <20191010075239.31b27125@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+TkQYyCh_PTG3H1PY/n+nTN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/+TkQYyCh_PTG3H1PY/n+nTN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cb6aed8363f9 ("SUNRPC: fix race to sk_err after xs_error_report")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/+TkQYyCh_PTG3H1PY/n+nTN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2eSJcACgkQAVBC80lX
0GzZNgf/Wj+VRvFw0dozkQMbZzRnTeXsDdI8zHyjEksp24e11dFu+kE3695cV0Oz
peqDWNsP4L1CcFN9H88oXl2/dHrnq9p2n9fQe84Z2FDB1dXBkou83Z3kZlSG8sB2
BEleGaiUeVwERz+T5pRnNbHK3pBlhokf30OLFlxXKkvouwqGlaFYZC+U4+7A+Gzh
nvTyKWhrVxtUgA2nuFw7W0ZW2UusaS4PKTgdADfWzlFxbdSPsZe4Q4dKiB8JzJVF
IAzvyoj7XWjhfBlb7Ot2/GyY/ATh2GurEGNJzhcDWRKh57uSxSh5Lc0Cz8VXxNhz
u+txOKLnDcCI7OOdKNJminOv0tSGYA==
=LPLe
-----END PGP SIGNATURE-----

--Sig_/+TkQYyCh_PTG3H1PY/n+nTN--
