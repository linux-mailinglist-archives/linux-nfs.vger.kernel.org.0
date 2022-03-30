Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E44EC875
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiC3Plv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiC3Plu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 11:41:50 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A6E7E43
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 08:40:03 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9AD47898
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 17:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1648654799;
        bh=FO2icc8q4Lq7Y8waw0rLgDfvRhn5bhBRNHJeNMa+Q74=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VkxcysCR6sgsnU6PHjTlRxeL+8Jppnltb+fyLPcrCIH7G2uIlqT4rozDjjk2P1a7X
         JhI6kTvzvmOjFxrOaATkLiilJhk33dCEOZskS0kq+M4J7CFgAUh1B21wVFafAZggn4
         MFYYIXv9+eVxxthYgnvko93B/w0UMvvdIyolijfeFvjGDGjIIMQ62zoeJRhf24O/A4
         vz+9Hz7rW1XG+7+TNrDjgF623y7FH5N+hdz6W8WJbdv5xYOXoQdsF30GeIaS3gFJgn
         YLmA5qTRBzzOKBpQACgyIIQArXRrHhTWYySgxZ33lZX+vp35hYlOYcUC5KgoKMBbhu
         FV+w7MWgBCHdg==
Date:   Wed, 30 Mar 2022 17:39:58 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: Re: exportfs recursively processes backslash escapes in exports file
Message-ID: <20220330153958.3vmk6pi7qpxjrp5t@tarta.nabijaczleweli.xyz>
References: <20220228193235.2g2uvf7fphj4jdy5@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n32d3cdeqf7dawxg"
Content-Disposition: inline
In-Reply-To: <20220228193235.2g2uvf7fphj4jdy5@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20211029-519-ac10a7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--n32d3cdeqf7dawxg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Following up with more testing:

Given:
  $ mkdir 'a \134053 b' 'a \053 b' 'a + b'
  $ echo a > 'a \134053 b'/a
  $ echo b > 'a \053 b'/b
  $ echo c > 'a + b'/c
(henceforth dubbed a, b, c, respectively), such that, trivially:
  $ ls -lR 'a \134053 b' 'a \053 b' 'a + b'
  'a \053 b':
  total 4
  -rw-r--r-- 1 nabijaczleweli users 2 Mar 30 17:17 b
 =20
  'a \134053 b':
  total 4
  -rw-r--r-- 1 nabijaczleweli users 2 Mar 30 17:17 a
 =20
  'a + b':
  total 4
  -rw-r--r-- 1 nabijaczleweli users 2 Mar 30 17:17 c

And each is exported as such:
  # exportfs -vo fsid=3D100 szarotka:'/tmp/a \134053 b'
  # exportfs -vo fsid=3D200 szarotka:'/tmp/a \053 b'
  # exportfs -vo fsid=3D300 szarotka:'/tmp/a + b'
  exporting szarotka.nabijaczleweli.xyz:/tmp/a \134053 b
  exporting szarotka.nabijaczleweli.xyz:/tmp/a \053 b
  exporting szarotka.nabijaczleweli.xyz:/tmp/a + b

Then:
  If only a is exported, the following state is achieved:
    # exportfs
    /tmp/a + b      szarotka.nabijaczleweli.xyz
    /mnt/filling/machine/1200-S121
                    <world>
    # exportfs -s
    /tmp/a\040+\040b  szarotka.nabijaczleweli.xyz(ro,wdelay,root_squash,no_=
subtree_check,fsid=3D100,sec=3Dsys,ro,secure,root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,crossmnt,no_root_squa=
sh,no_subtree_check,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_sq=
uash)
    $ cat /var/lib/nfs/etab
    /tmp/a\040\134134053\040b       szarotka.nabijaczleweli.xyz(ro,sync,wde=
lay,hide,nocrossmnt,secure,root_squash,no_all_squash,no_subtree_check,secur=
e_locks,acl,no_pnfs,fsid=3D100,anonuid=3D65534,anongid=3D65534,sec=3Dsys,ro=
,secure,root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,hide,crossmnt,secure,=
no_root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,moun=
tpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,no_root_squash,n=
o_all_squash)

  If then b is also exported, the following state is achieved:
    # exportfs
    /tmp/a + b      szarotka.nabijaczleweli.xyz
    /mnt/filling/machine/1200-S121
                    <world>
    # exportfs -s
    /tmp/a\040+\040b  szarotka.nabijaczleweli.xyz(ro,wdelay,root_squash,no_=
subtree_check,fsid=3D100,sec=3Dsys,ro,secure,root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,crossmnt,no_root_squa=
sh,no_subtree_check,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_sq=
uash)
    $ cat /var/lib/nfs/etab
    /tmp/a\040+\040b        szarotka.nabijaczleweli.xyz(ro,sync,wdelay,hide=
,nocrossmnt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,=
acl,no_pnfs,fsid=3D100,anonuid=3D65534,anongid=3D65534,sec=3Dsys,ro,secure,=
root_squash,no_all_squash)
    /tmp/a\040\134053\040b  szarotka.nabijaczleweli.xyz(ro,sync,wdelay,hide=
,nocrossmnt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,=
acl,no_pnfs,fsid=3D200,anonuid=3D65534,anongid=3D65534,sec=3Dsys,ro,secure,=
root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,hide,crossmnt,secure,=
no_root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,moun=
tpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,no_root_squash,n=
o_all_squash)

  If then c is also exported, the following state is achieved:
    # exportfs
    /tmp/a + b      szarotka.nabijaczleweli.xyz
    /mnt/filling/machine/1200-S121
                    <world>
    # exportfs -s
    /tmp/a\040+\040b  szarotka.nabijaczleweli.xyz(ro,wdelay,root_squash,no_=
subtree_check,fsid=3D300,sec=3Dsys,ro,secure,root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,crossmnt,no_root_squa=
sh,no_subtree_check,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_sq=
uash)
    $ cat /var/lib/nfs/etab
    /tmp/a\040+\040b        szarotka.nabijaczleweli.xyz(ro,sync,wdelay,hide=
,nocrossmnt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,=
acl,no_pnfs,fsid=3D300,anonuid=3D65534,anongid=3D65534,sec=3Dsys,ro,secure,=
root_squash,no_all_squash)
    /mnt/filling/machine/1200-S121  *(rw,async,wdelay,hide,crossmnt,secure,=
no_root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,moun=
tpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,no_root_squash,n=
o_all_squash)

Note how a and b were folded into c(?) but not into each other,
which is especially concerning given, that, in /every/ case, regardless
which are exported:
  szarotka$ mkdir a b c
  szarotka# mount -t nfs tarta:'/tmp/a \134053 b' a
  mount.nfs: mounting tarta:/tmp/a \134053 b failed, reason given by server=
: No such file or directory
  szarotka# mount -t nfs tarta:'/tmp/a \053 b' b
  mount.nfs: mounting tarta:/tmp/a \053 b failed, reason given by server: N=
o such file or directory
  szarotka# mount -t nfs tarta:'/tmp/a + b' c
  nabijaczleweli@szarotka:/tmp$ l c
  total 4.0K
  -rw-r--r-- 1 nabijaczleweli users 2 Mar 30 17:17 c

This could be spun as an "accidental exposure" bug or w/e, but this is
primarily just insane. Or, if it's somehow expected and working as
intended, then it warrants a note in the manual, at least.

Best,
=D0=BD=D0=B0=D0=B1

Please keep me in CC, as I'm not subscribed.

--n32d3cdeqf7dawxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJEecsACgkQvP0LAY0m
WPFPYQ/+P6X9+4oOK1N3VhV1Vi/fRZvQZs8lebmG0vo6x7PJRqv+qnbIuPTmBtsn
VWyU1SpFRKUSlaQnsifisBmUfYPUB0rTshnHypkxSukLAWJTvGwmsb40E5On5Qts
TgrUudX1WZMRXrZZcpQvvmLwSKFSIiBQZjZodJJA6G98ei9GZnd7/L07UiEDQIg7
rCJKv4SaBmTdaYpwKC2PWJ5Z8y+bWM89EGhK5LUoNZBp/17zUmSPispqjaMlE77t
3FV6C5qs4eY3+gpTIFvHUr7UhWKQnWJbswgS2LT5zMP43u3VPCHnQd2CsEPSqqFB
H30zY0w8mwaNUguznleF8IwXrfhAWqAFju4Yt1QzFVbV5Lp21pNx0GAu8y8OzAbN
QBxFNwL4+6m/Mqhcgrh00x7OZKhyBDfc6zZbmfeixOBZaUjabblD06B5U8zcZB4r
PhBjzv89FsdXpHpU2IFK2B8uJJ2hjbur7Nj2m+C09Jptmhri1VatnXVsNnIDjj1E
zkWfZTtmeU0juwfhoxkZquYiUAxxyYKuMptYO1UkkYn5SK6WeJSGD191ttSYsngB
zxq5igkCfrlul8nNfsqEHrak+4JQij8iLv89u67hlIPqD1UanUZO9mnHs5kztbq4
bUrkaPRDotCwAUtFoIj7tQr2TpXOSJwQ+lhLaj/zgiB7zSthsQg=
=HFFp
-----END PGP SIGNATURE-----

--n32d3cdeqf7dawxg--
