Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD4416B17
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhIXE5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 00:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIXE5Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 00:57:24 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC6C061574;
        Thu, 23 Sep 2021 21:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Date:Message-ID:From:Cc:To;
        bh=K35Y6RRgd6E8Pi0+5eEn871tiwSUjxMbbFGmn0WfGwM=; b=x7csDKOXFy5DOjx8br8VQaL+8Q
        /seMNXnngvLDSJgMv+oo3aI5VlZYy2Yqvvj+EnL7SozR3F289M6y5LdrUxZqtYOhB+6WATWB+uxSL
        ijJk8OzcGc7Ncd32r0yp8TCaMWm9jx4FMmYeNTbRLkxF91JqAjSF2mMOJLiLbMCBNFnv2poYnIRaK
        WJ69MN9kQwp8g5LgdlZ8TbDs8PrXr6ZSmO15GSfk/Qt8qHXunyoXyNrRNtUwswP2R/q5sY3MrDP8M
        bWidlWPYHehFMh/1igsWRceir+rAOt/CGXlS2G0tuycJLdUEVvSCqs+HiHZINaNPoPle1V3z6QGxS
        hNcZLfTLI0j6K8S0H2Czd2EDyKSHy6Uc59puJECx/VaVhLt+QIKvgoAk2SuQDMb+ImQ0Ebm37bO1k
        2XIx5wReQ4iKy4wBwZqURrgVVuZpp/AGSY9hYVb6kQsrmK0d6Roib8sVQTyO1cNT51I2Kkuxj6ZJ0
        lOqhbL+hOGQlmAKAIRN6s+bl;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mTdFT-007cEc-VZ; Fri, 24 Sep 2021 04:55:48 +0000
Subject: Re: Locking issue between NFSv4 and SMB client
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jra@samba.org" <jra@samba.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
 <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
 <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
From:   Ralph Boehme <slow@samba.org>
Message-ID: <16ebef76-05f9-f604-6104-50be0c2cb0a3@samba.org>
Date:   Fri, 24 Sep 2021 06:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1w0DF6h0GDacOWlXK0lT6Da6vYcFa1WX4"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1w0DF6h0GDacOWlXK0lT6Da6vYcFa1WX4
Content-Type: multipart/mixed; boundary="GGLBMnaFDa6mQtSPvS5s6n9LCB1LdUIrp";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>, "jra@samba.org"
 <jra@samba.org>, "dai.ngo@oracle.com" <dai.ngo@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Message-ID: <16ebef76-05f9-f604-6104-50be0c2cb0a3@samba.org>
Subject: Re: Locking issue between NFSv4 and SMB client
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
 <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
 <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
In-Reply-To: <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>

--GGLBMnaFDa6mQtSPvS5s6n9LCB1LdUIrp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 24.09.21 um 06:13 schrieb Trond Myklebust:
> On Fri, 2021-09-24 at 05:46 +0200, Ralph Boehme wrote:
>> leases can be shared among file handles. When someone requests a
>> lease
>> he passes a cookie. Then when he opens the same file with the same
>> cookie the lease is not broken.
>=20
> Right, but that is easily solved in user space by having the cookie act=

> as a key that references the file descriptor that holds the lease. This=

> is how we typically implement NFSv4 delegations as well
yeah. We already track the required state in userspace anyway, so this=20
should be a low hanging fruit (more or less :) ).

-slow

--=20
Ralph Boehme, Samba Team                 https://samba.org/
SerNet Samba Team Lead      https://sernet.de/en/team-samba


--GGLBMnaFDa6mQtSPvS5s6n9LCB1LdUIrp--

--1w0DF6h0GDacOWlXK0lT6Da6vYcFa1WX4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmFNWlIFAwAAAAAACgkQqh6bcSY5nkYe
QRAArvF05m5ZhE2feTfUBGyUqxGqx5UFo+yZaGRs/xji2DwfX05OviKCyaeyc0bDk/Umyg/SpDPZ
A09oMRABy6JNZ7jjZX2swyykJ7yA4rH/TyThaKuKNRKdgX11erFXeV4jQJ3B75YNocDVuEmT0UHm
+KN0Z1aY0YGoUPxf5Wxz7KHOZuegRfgg5PHgyONdO5ISn1YWhM1v52fvehnEvRG3mJ7oSN58rpwC
oJ7iWX5Dm3XnBe83DinwdGNikeLxH+XCqTByj4zecL0N3BBcEg2mE1EY/nGcSt2QtEMkofw5nu6k
E2GyB8J2iraKZ1Kv/zSIv2W+/PBmm4nmtrgiZDSzJjBNaAHZrpdJ7AVGDzUdWcmMSxTM9Ept+IGL
bKCT0lp/9at8ZoLar25WkQ8qdFJFun3M2cAYHvNRBkS7U2H556HohR4OFr0x4n/GKobgOqkgRQl7
8p41VIIZVH10YfpnHC/V0E4W1r1EU5zHhew6NVkR3Ryuemr152r12u7BxjU0b8o8ea4GB3y7qijc
FPm2sJ/8EiSKag0NjVL9FgzKs8cMZN7Y4NrNjnD88ITC+6+1VEaSAe6rq8/nj6phiOmUtwe43DJc
sVHW76817AC/f1311GClDlQenSrsFgyn0KgIV72Tkj5mZ64lCYNkyJTAULJwJIEy4+qMuqkPhAQ/
ZvA=
=WaVU
-----END PGP SIGNATURE-----

--1w0DF6h0GDacOWlXK0lT6Da6vYcFa1WX4--
