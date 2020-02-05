Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0D153AEC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEWZZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 17:25:25 -0500
Received: from ozlabs.org ([203.11.71.1]:48275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBEWZZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Feb 2020 17:25:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48CbjZ0ttpz9sRG;
        Thu,  6 Feb 2020 09:25:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580941522;
        bh=FgeBSllH9nOX+H0EnoCoVt3VNC9kkq+gzK8azV5HlWs=;
        h=Date:From:To:Cc:Subject:From;
        b=cza/Yb+Wi4JBkdle8/ZXsgaZqWMVyrW/uQCjG6yxbUi2KZX1aClsnb2yqGlwI6i9F
         NhOzaKMllIhgArj4R7pbPzPoZ7tsnIXWpm0UHIVl4m3/LNpBVry7slTdDAY1unQm/Y
         QZ/e530Dh3zcmNP1zhOVQ3TseEPLkc96KJXiTWvh9V42oxkn1idnwwnyh/Ve6DGmw8
         LzoZ+4i4Nlz4e8Pa/y+n3BT6/ahDkqNDA2qR7/XiRDL51++kvuwrDQTzkyhmQEqhEi
         nrJ6nxlMyxZhnC9ehUMB/4ISNrbo1A1egok5qWIOZWnyKMKMID5Ovdlnfz3Hqj6Yf1
         tNZqnwCR79Xkw==
Date:   Thu, 6 Feb 2020 09:25:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: linux-next: manual merge of the vfs tree with the nfs-anna tree
Message-ID: <20200206092512.5eb304b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/db1mAXHnx/_Rc63UC+p.9fG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/db1mAXHnx/_Rc63UC+p.9fG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/nfs/dir.c

between commit:

  227823d2074d ("nfs: optimise readdir cache page invalidation")

from the nfs-anna tree and commit:

  ef3af2d44331 ("nfs: optimise readdir cache page invalidation")

from the vfs tree.

I fixed it up (I used the nfs-anna tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/db1mAXHnx/_Rc63UC+p.9fG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl47QMgACgkQAVBC80lX
0GyVfwf/T+0uXHU7k55U4Yok50+o+m7JIq2U5y/5z+P7poFOcYoWB0liR3yaosC0
/SPD6womk2pac9Km3xC7xjudcHx2qrgPu4jkgSboEDdrIYgq2EXoRjNZToHBduM0
BsbThvoC4EpuA4vN922VpWe2zUuLoFUTSX/hUruBlMd+jeG90Nf4sczI1IMrlVbm
VaR0oL/Jgf/X0wm2KvxmqAlDcmFmTmE/o6imAEQsaAAbWPpCLdHejCahGSuX0L7d
ywuF5Gh7U641+itfVk2LJkFwr+iAmdyxmAbqXIBVoexEg24f+JzVwcBtOOwulerc
DxplKLs0+sp+RGY9xqInD29ssNCSsg==
=64+8
-----END PGP SIGNATURE-----

--Sig_/db1mAXHnx/_Rc63UC+p.9fG--
