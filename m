Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD65F37C1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJCV37 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJCV3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 17:29:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417451415;
        Mon,  3 Oct 2022 14:21:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhDL73PTFz4x1V;
        Tue,  4 Oct 2022 08:21:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664832111;
        bh=j5DSA769cU7i2A5deVngRTuAXvvllrnC4PD3JhG36oo=;
        h=Date:From:To:Cc:Subject:From;
        b=G/IKqGu/F7MC4FABkDTW8EbkgzYWmLXVVq/hCMWzDptBRwdFw+VkpA8f1ykrRyrQQ
         IQTQV5TK8mhhy+8Jl2TFwuCFNK1yeoiLQI5xo5+kKPWzFRXambDgqX0FSonHzf3kAm
         glcoCqqw5HKBqknVPnc/SkLLtTyk9mRAAatqg0kGuIbxk3KUSR309WenD9X2lo5//b
         MvtDcaiYPNJh+f3jz+0J0seUPhtINU2hxc7xSa6u/LAOho8j7y9l1X/GGamYCNoG0S
         f32YoJS/ek9WL2g+4gkvVD2C+PIe3QFCfuFRBfmLnYznH0+CiXqOISYkboBsUAeWLr
         2ErkkFe3JEdOQ==
Date:   Tue, 4 Oct 2022 08:21:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20221004082150.5bccd2c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CQkawqiFl6kP8KIui9//BII";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/CQkawqiFl6kP8KIui9//BII
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a3569716d183 ("xprtrdma: Fix uninitialized variable")

Fixes tag

  Fixes: 6919549677909c ('xprtrdma: MR-related memory allocation should be =
allowed to fail')

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d8cf39a280c3 ("xprtrdma: MR-related memory allocation should be allo=
wed to fail")

--=20
Cheers,
Stephen Rothwell

--Sig_/CQkawqiFl6kP8KIui9//BII
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7Um4ACgkQAVBC80lX
0GwaNQf/Sm5ZXwXo0GrTwpV9GlYvdIJEhpvcIpcswpopcq/Mxdnyr2B62ExqbDAT
NCYbcXoi4pM22KVku+SVHcyiB6nTVhts4yRI2k/5Rgy46F0ita8t7dy0zzHsfywW
5SK4X2IQNhU2ByfMxQ75PCR/vPhNNoaYtbxye3Xmn1UhVbgPp3+8j28Hx2jfr5Vp
95Al4y6smuAYC4salAUw++NunhiVza8Wqh/DDbd/npEIBExOoCakTXkx84dlwdcp
eFhulsLCBrtXZnFMBxBN4RZTNUXMnI69nELw3tf614taQI2RrxEAwcLrx9OHeb8I
JCAtaGXytjUM0KAaP7LlldjtmX0w/Q==
=UL9Q
-----END PGP SIGNATURE-----

--Sig_/CQkawqiFl6kP8KIui9//BII--
