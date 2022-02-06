Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC14AB230
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Feb 2022 22:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiBFVCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Feb 2022 16:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiBFVCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 16:02:32 -0500
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 13:02:31 PST
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4DBC06173B
        for <linux-nfs@vger.kernel.org>; Sun,  6 Feb 2022 13:02:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsM585k0lz4xcZ;
        Mon,  7 Feb 2022 07:56:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644180989;
        bh=LTwvonFI3NHOe6zUssHtoyLjsi6BGi6tDmxdv6Te+7A=;
        h=Date:From:To:Cc:Subject:From;
        b=FqnpSm0ozP8ynS9D0JrwkHmJfKk5pyvp3Hpub+lwkqmED+MTGOaOZ95r9imVeD8sU
         LD9Ibh9f48zkADkH5yrcK6gUxCKQxVPaPo9mh/dC6jtxKXXw2Xm/CmhNKRd0cd8K5M
         nAEQZ75LZVEcGK/CIuU2T333NPA/V57TR6+FgngQuqfXHH+9Gj7pWFbL+ye3Pb9GNM
         AjF5n86AepQQlX27JLZg8wq1lqklMyDgvi/WkPUjx6E+dZdaPnDJClPMvZVVgybqVb
         UqvIdPPfbQgupL4nptTV8/gNn6HfNsm8voL2iA7RkZ0X+eHn0/rDtJlI3lxWjLOu/0
         TXRI+wgKLayfA==
Date:   Mon, 7 Feb 2022 07:56:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs-anna tree
Message-ID: <20220207075627.1dec35b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NvMxmgrqWFG+QaNX7H1mFsa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/NvMxmgrqWFG+QaNX7H1mFsa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  677c0cebca78 ("NFS: Fix initialisation of nfs_client cl_flags field")

Fixes tag

  Fixes: 87871d990a2c ("NFSv4: Initialise connection to the server in nfs4_=
alloc_client()")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: dd99e9f98fbf ("NFSv4: Initialise connection to the server in nfs4_al=
loc_client()")

--=20
Cheers,
Stephen Rothwell

--Sig_/NvMxmgrqWFG+QaNX7H1mFsa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIANfsACgkQAVBC80lX
0Gy//Qf9E7ERfnQ4ARb6qGTZFzM5nuoKp7L0fl39kgkoBPVkelChvVz2RJ7TIr18
gm9mmowvely+pvrIewILQt+nAY9eZ6HRBX9Q6CUe3Cf9sq9cdZj6EUKgVxcpW96i
g3jq7mN4xNGEl7Yuqkff/EXRue6tVykS+tk01DZ/lw62FWz7ehja9F9TMjzeQM4V
aVs40WxiZ+HAqvsQcMX+eY+wjHZ5pgYM8TFBi/Xy8+/LS93QjYv+gpRXkQmAZYNF
vHjg3RHL+3dpSZTJv0ePNRf03A7ch1vutV9y89d68+08XQ9RQhyRWroKSVv8eKio
2ukx0jRjJ10BrfO35nFd6+lGesDTTg==
=ORjs
-----END PGP SIGNATURE-----

--Sig_/NvMxmgrqWFG+QaNX7H1mFsa--
