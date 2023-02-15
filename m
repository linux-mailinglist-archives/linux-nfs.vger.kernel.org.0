Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960806988D6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBOXmW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 18:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXmT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 18:42:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3743908
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 15:42:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jk14so312715plb.8
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DBXI3A4VMn/UByfny6Ly7FxaSmt72ZlI3k/lVTMPgq8=;
        b=qV624G81IyXTKWmRSgt1T5g7/fUxu7uKghc4rQJwHyp3mkv8Sy34YwdIML8VR1xH0E
         FoetztXFGp2HuHnJuSvDRLauDhNS6XH8z9nsC5VXibCu7TwgrmfGhuHHk4zFi25o9jAq
         7ltxIb4XaFGT9gDyZtkYMcb8vyHS8YJ7MbRgZ5xOCi/JHnRgnztDqEAw25BQq64y+y8x
         ieJZIs79II71I04zPWNxBFI1W5cUtCsP5DEn0N0Lpiur7wRZwxe1FbTtmZuB7YQZOLy1
         wHhL7KlkbFBm7YgpNPaL+rr6a73huxiKpb6t/bjqg9JFkUapJacFSU+kWkljmCu3n804
         q6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBXI3A4VMn/UByfny6Ly7FxaSmt72ZlI3k/lVTMPgq8=;
        b=ceQ1+0NCXyudfhK242J/8mE6r3lQC8sHOih0+VAfXj4TlmwqhWz20CaOpYIoMf1X4H
         eZUHZ7jo8DGQuD5zKgOtErHc1p4DoaJvmWVFTaUuMyB8yRgNw4Ehtz8+mfVGtGBKxtzY
         8NkQV8hQ9JvxZ3wIIR21n5+3S7AjgfG51Q3iVdhyc7pL4ThMBK8YoSkC+7vJaGAhLKzN
         Ur+Olpzfhn906p3TIcKJLxcVzsSfDEBx6KYuyWzkdZpWxQPvRhe6+dTndnQwPHNWyQd/
         fo28K4YYbG8FI5I3CH3mMULgvGN9/5eZJYsD4BWf3I3Z0MTYzxeDA4PFmvSBsXy15YD7
         dvhg==
X-Gm-Message-State: AO0yUKXCMBmug+K8L0H3DPJRuV80YNE1gu1626Q+sOWCfcJWDYzSIS5q
        Or1/4MftJrw8170gVNCP+hY=
X-Google-Smtp-Source: AK7set8AXc8sqMF35RSwmbJkLNqKL4Pa54OwjQ3fSjWOh8G3/4QDi7EJOfZdQCZfjbQO56SNLpEI2g==
X-Received: by 2002:a17:903:234a:b0:19a:bbd0:c5ca with SMTP id c10-20020a170903234a00b0019abbd0c5camr5162139plh.48.1676504538337;
        Wed, 15 Feb 2023 15:42:18 -0800 (PST)
Received: from smtpclient.apple (c-73-19-52-228.hsd1.wa.comcast.net. [73.19.52.228])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b0019a6cce2060sm10210859plb.57.2023.02.15.15.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:42:17 -0800 (PST)
From:   Enji Cooper <yaneurabeya@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6FB3B8A1-7C3A-4129-AC7B-707530D31CA6";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Require ply to build/install pynfs
Message-Id: <344E9D63-9EEB-4D7F-9282-D091A2E7650F@gmail.com>
Date:   Wed, 15 Feb 2023 15:42:07 -0800
Cc:     linux-nfs@vger.kernel.org
To:     bfields@fieldses.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_6FB3B8A1-7C3A-4129-AC7B-707530D31CA6
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_EC37B852-39C5-4F7D-8468-B0235DA704D2"


--Apple-Mail=_EC37B852-39C5-4F7D-8468-B0235DA704D2
Content-Disposition: attachment;
	filename=0002-Require-ply-to-build-install-pynfs.patch
Content-Type: application/octet-stream;
	name=0002-Require-ply-to-build-install-pynfs.patch;
	x-unix-mode=0644
Content-Transfer-Encoding: quoted-printable

=46rom=20a2ebd5b08a659c0a3367fbed7d62cad8ee9d273c=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Enji=20Cooper=20<yaneurabeya@gmail.com>=0A=
Date:=20Wed,=2015=20Feb=202023=2016:21:29=20-0800=0ASubject:=20[PATCH=20=
17/17]=20Require=20ply=20to=20build/install=20pynfs=0A=0AThis=20=
particular=20change=20enforces=20the=20build/install=20check=20at=20two=20=
different=0Alevels=20to=20ensure=20that=20the=20subdirectory's=20=
dependencies=20are=20explicitly=0Acalled=20out,=20and=20the=20overall=20=
build/install=20will=20halt=20if=20ply=20isn't=20present.=0A=0ASponsored=20=
by:=20Dell=20EMC=20Isilon=0ASigned-off-by:=20Enji=20Cooper=20=
<yaneurabeya@gmail.com>=0A---=0A=20setup.py=20=20=20=20=20|=20=207=20=
+++++++=0A=20xdr/setup.py=20|=2010=20+++++++---=0A=202=20files=20=
changed,=2014=20insertions(+),=203=20deletions(-)=0A=0Adiff=20--git=20=
a/setup.py=20b/setup.py=0Aindex=204ec5d92..99155bd=20100755=0A---=20=
a/setup.py=0A+++=20b/setup.py=0A@@=20-6,6=20+6,13=20@@=20import=20os=0A=20=
import=20subprocess=0A=20import=20sys=0A=20=0A+try:=0A+=20=20=20=20=
import=20ply=0A+except=20ImportError:=0A+=20=20=20=20#=20Avoid=20=
confusing=20cascading=20failures=20due=20to=20how=20xdrgen=20is=20=
imported=20via=0A+=20=20=20=20#=20setup.py=20files=20in=20subdirs.=0A+=20=
=20=20=20sys.exit("You=20must=20install=20ply=20first.")=0A+=0A=20=
DESCRIPTION=20=3D=20"""=0A=20pynfs=0A=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0Adiff=20--git=20a/xdr/setup.py=20b/xdr/setup.py=0Aindex=20=
3acb8a2..b5007c0=20100644=0A---=20a/xdr/setup.py=0A+++=20b/xdr/setup.py=0A=
@@=20-1,6=20+1,6=20@@=0A=20#!/usr/bin/env=20python3=0A=20=0A-from=20=
distutils.core=20import=20setup=0A+from=20setuptools=20import=20setup=0A=20=
=0A=20DESCRIPTION=20=3D=20"""=0A=20xdrgen=0A@@=20-16,8=20+16,12=20@@=20=
setup(name=20=3D=20"xdrgen",=0A=20=20=20=20=20=20=20scripts=20=3D=20=
["xdrgen.py"],=20#=20FIXME=20-=20make=20small=20script=20that=20calls=20=
module=0A=20=20=20=20=20=20=20description=20=3D=20"Generate=20python=20=
code=20from=20.x=20files",=0A=20=20=20=20=20=20=20long_description=20=3D=20=
DESCRIPTION,=0A-=20=20=20=20=20=20#requires=20=3D=20"ply=20(>=3D2.0)",=0A=
-=0A+=20=20=20=20=20=20install_requires=3D[=0A+=20=20=20=20=20=20=20=20=20=
=20"ply=20>=3D=202.0",=0A+=20=20=20=20=20=20],=0A+=20=20=20=20=20=20=
setup_requires=3D[=0A+=20=20=20=20=20=20=20=20=20=20"ply=20>=3D=202.0",=0A=
+=20=20=20=20=20=20],=0A=20=20=20=20=20=20=20#=20These=20will=20be=20the=20=
same=0A=20=20=20=20=20=20=20author=20=3D=20"Fred=20Isaman",=0A=20=20=20=20=
=20=20=20author_email=20=3D=20"iisaman@citi.umich.edu",=0A--=20=0A2.39.0=0A=
=0A=

--Apple-Mail=_EC37B852-39C5-4F7D-8468-B0235DA704D2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



--Apple-Mail=_EC37B852-39C5-4F7D-8468-B0235DA704D2--

--Apple-Mail=_6FB3B8A1-7C3A-4129-AC7B-707530D31CA6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtvtxN6kOllEF3nmX5JFNMZeDGN4FAmPtbc8ACgkQ5JFNMZeD
GN56CBAAjp+AmMPBS/Tl4Gvu6I5gpsFADpTUZBQvXZpsCm/RFDUK4hXFvy/n4L+h
WXJgjdFkR5aiWGL4wDgztPM+zc2aJCXM8W/NxoTbOBX6t3QXgjjL0RqMhqFO0e7T
gGmIln+IG6yI/unO4oSgI/DWkGDWbX1DgjzO4Gfloq9rzC2jm/s9zVAOaJY1U8AP
/jLq8boXUsGJXnzysaDgC5DNMOvq/o/iWivtfi/BKY1v0Yj++Gf1CW5QzOaXRZar
IsO9tPAMe+51TjaoD0ZYFVQDrA64icpGrXhgBXz2STkv1yb9dAzwFONsRshi9ftp
233hIPkT7zTosmyh5Caf6Ya/DyDEVdB6VP3itREkt8bCS7+BInJcLwGEFIM9C9ZM
uzL9gF0hoS9kK7eMDCw09BFsaU4nOTd4j5BU4urSdYE4qrC5zrbddgzAEblp1IDX
0Jung95zMNFfwJmAsq+9iPHyDJUTGbw62jCXpOuiF3sZes3h4t5G9XSzhyztGYD+
tHvpmXIHnbAAPJsFf4Lb+SjpKblqA+8k4R8ZugB/kAUBOwYBVn49Ok1zfBqQF6cz
sTu28Gd28extNdcLFvIb46u54XjxSpKe4bc3SXpWA70sDndJEMbTrUPV5JDC94jz
iJ+wYTFYIMK1yre6p589r8lx7lZ1czB2+T3BWZ6OqMi7052q934=
=vZit
-----END PGP SIGNATURE-----

--Apple-Mail=_6FB3B8A1-7C3A-4129-AC7B-707530D31CA6--
