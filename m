Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE344F0160
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Apr 2022 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiDBMPp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Apr 2022 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiDBMPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Apr 2022 08:15:44 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BB872DD7
        for <linux-nfs@vger.kernel.org>; Sat,  2 Apr 2022 05:13:50 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5200B58A;
        Sat,  2 Apr 2022 14:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1648901627;
        bh=0DpUJOVO3LhygFbZzCVKOwsMgMF3SsdwV9xhUR6eGO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUUONvAhPrYBBzeKf3kKYEgdG+744dp6NHkNvMYyCSzm9BStL5EYXcmdSl2XAkjiP
         aaayA4nfPx8GeorxC9eDO1F7dM3Hsxj/iz6w2cZZZDSxzpPXU5b8aiitFS0Lm5LALk
         Ge++V0DWMKQ4hP1Q6RJ6ypZmZ+2+GDGg5r7w5frS/tG54GVDv2g6lQMklUxRZJHUxq
         7MjrJyGFRGA6yPbCkHBbtS0B3u7aQ2VT6yuXwpcgKfi38MNOIn0GLjpL1Qfi5ZpN2k
         27GhgNjyGWb0RknSTZAJlecUOY0eG3TAFxAD0AR2Pm/tdzmk4OWPOegkOCnUJqz3oo
         3LibtgzYGw+Gw==
Date:   Sat, 2 Apr 2022 14:13:46 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: exportfs recursively processes backslash escapes in exports file
Message-ID: <20220402121346.vslpgiwh7zd5ilc4@tarta.nabijaczleweli.xyz>
References: <20220228193235.2g2uvf7fphj4jdy5@tarta.nabijaczleweli.xyz>
 <20220330153958.3vmk6pi7qpxjrp5t@tarta.nabijaczleweli.xyz>
 <60160726-09D9-4963-B7D4-888D306B433A@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhdz42pbcil3fq5v"
Content-Disposition: inline
In-Reply-To: <60160726-09D9-4963-B7D4-888D306B433A@oracle.com>
User-Agent: NeoMutt/20211029-519-ac10a7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--uhdz42pbcil3fq5v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 01, 2022 at 07:53:30PM +0000, Chuck Lever III wrote:
> It's likely an issue in exportfs itself, so Cc: Steve.
>=20
> You can see what the kernel thinks is its reality with:
>=20
> # cat /proc/net/rpc/nfsd.export/content
> #path domain(flags)
> /export/tmp	*(rw,insecure,no_root_squash,async,wdelay,no_subtree_check,uu=
id=3D6682b258:02a54061:815cee14:242ddfc2,sec=3D1:390003:390004:390005)

Thanks, this is what I was missing!
As expected from the results, in each case, the line is
  /tmp/a\040+\040b	*,szarotka.nabijaczleweli.xyz(ro,root_squash,sync,wdelay=
,no_subtree_check,fsid=3D300,sec=3D1)
with the first fsid=3D exported, except if c was ever exported,
in which case it remains 300.

=D0=BD=D0=B0=D0=B1

--uhdz42pbcil3fq5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJIPfUACgkQvP0LAY0m
WPE9FA/8DoPf+NZ3BMl80SlRn7pwIckten2X/es1zes0xTVfIGqjWsftuLzS0rRy
ogar/NQjT07BqPe9fST5OjaVoXrxGkWFG1GwizuraZI6pZyaCAGyG1orPq4xnrHR
NSut5lfTRjc7UOg4OHS8qo2bxPpcBncYSEA6+FeWiKH9IK/l1LbFRXVgawHo08B9
w3tUExO5DGOdw9lTDHOuxMZPlrFYeQBNSxPri61mHPF4q/yN90p/tZhgr4pUFnts
r4PF2vXrZeEvaLIAoYM+uuhKovAMjX/a0zWhgbNOxUsDKijt6TpVQMUx8nrz1GI6
tqU/lozqwgJt2Y9NdTF2RnK6yYoPzEhvG0NWBXE+04sxNhJ6XUGiK8Tvs/UarDrq
nKA2CVf1LwqJvL3j1y36HT3RNn/flbSXW0Indq4MD/QN+2PDnNHertoXvx7bRQQj
zikv0m4JayaltmCYB7hzSZQ5AEo2b2QsnW/wBJXNV6tjJLHyve2CUicza4+pJS7a
LMd4acY/pZY4zo3zEgfkmff9cJyhEmkaNM10/aheNWWE54K/6+MkmwGgZlInMS1g
yVYb8FurGDRIw0/4JaH8yLFbLy98+InFJjwvFrB2RPkKOvmze26gYPCytSu6zQtp
3EVSecA5kS9G5AhZazNVm+3rgEwNsv2z0qu+uxXbWFLPuazDo6E=
=BWCD
-----END PGP SIGNATURE-----

--uhdz42pbcil3fq5v--
