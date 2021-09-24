Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD13416A97
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbhIXDsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 23:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbhIXDsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 23:48:06 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE476C061574;
        Thu, 23 Sep 2021 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Date:Message-ID:From:Cc:To;
        bh=Sbgu+PDdj8sUBBEgHwKfITOQmtfWkyWwRRNn/xC/ppM=; b=J+MmzSzGMejbuE03ZW/RHaUxmS
        LXHmu88tnWpCCYGkRoGZzn5SSVunyDswNuYq7/XhArr1hx4IEXxaomgOv5KHWHlybIWSjTRNJ76o8
        CTmxGudXSaiqMrLYxF/9rge/YbWjiTc+fDeWG/4HSlRXYoCoNgiyRYRnz3j9Lg4BfgCsvzOPYtj8J
        hJ1wokFrAFNqaDxsytzJ/Y5OQM0JmMe2/c8fhEk+B7CBR3cV5xc84fJqaCPxCy3QwzxD2NXXM6Wjd
        eINALLUsBxUTa8FPH4yszcVgPN1VlEsmVjjDxkDKounjhDv7xEGq8ow8NwKOwxoxz6CI49Lo5qcz3
        utK8ns2tkSlLbJxTfhRgvRWzSw0qzOwP5yqFirhWDb3kYzuEioggRcEhUVV2wMRth2G9uM66Rgcn9
        7+LEeb5Bpap4Ivny1EwwrYeTSwRv5VYbyNvxM9a3X/o9nk6TzrYqqyaFnknCK8xyuk8PYZOLfeEve
        iGwhiGI0Smcjsr8pj65TIDVX;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mTcAP-007bo2-38; Fri, 24 Sep 2021 03:46:29 +0000
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
From:   Ralph Boehme <slow@samba.org>
Message-ID: <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
Date:   Fri, 24 Sep 2021 05:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FtgIWRAI2xlKZ1VU95BtsQNLaEcX1k27K"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtgIWRAI2xlKZ1VU95BtsQNLaEcX1k27K
Content-Type: multipart/mixed; boundary="PhGYvjtXBOG0AOTM71SQRZBZQP0Zn1QFi";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>, "jra@samba.org"
 <jra@samba.org>, "dai.ngo@oracle.com" <dai.ngo@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Message-ID: <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
Subject: Re: Locking issue between NFSv4 and SMB client
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
In-Reply-To: <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>

--PhGYvjtXBOG0AOTM71SQRZBZQP0Zn1QFi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 24.09.21 um 05:35 schrieb Trond Myklebust:
> Not if you set the "kernel oplocks" parameter in the smb.conf file. We
> just added support for this in the Linux 5.14 kernel NFSv4 client.
>=20
> Now that said, "kernel oplocks" will currently only support basic level=

> I oplocks, and cannot support level II or leases. According to the
> smb.conf manpage, this is due to some incompleteness in the current VFS=

> lease implementation.
>=20
> I'd love to get some more info from the Samba team about what is
> missing from the kernel lease implementation that prevents us from
> implementing these more advanced oplock/lease features. From the
> description in Microsoft's docs, I'm pretty sure that NFSv4 delegations=

> should be able to provide all the guarantees that are required.

leases can be shared among file handles. When someone requests a lease=20
he passes a cookie. Then when he opens the same file with the same=20
cookie the lease is not broken.

Maybe others can comment on the level II oplock problem. Afaik this was=20
more a lack of testing.

-slow

--=20
Ralph Boehme, Samba Team                 https://samba.org/
SerNet Samba Team Lead      https://sernet.de/en/team-samba


--PhGYvjtXBOG0AOTM71SQRZBZQP0Zn1QFi--

--FtgIWRAI2xlKZ1VU95BtsQNLaEcX1k27K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmFNShQFAwAAAAAACgkQqh6bcSY5nkYF
lRAAh+16eSQTyw2jfcITG+SkMYbBN1HABsiUnYEoIqylIeJn/n/4f8bJ273Gt1GL85rdaxfl7SrY
tKKSQvtxYAJcZIX/xx4+6FFXGrNpr/GSPviNZJUgVDnzGJkxMlZW9R1JoEgyA+N21dCeskvjr+hD
QvpFG7u2iSwJ/fYrxMQsv2x3MdRbnVUAfZkKn037QB9mVY64nVjePBMlwotveYsfoenOQLF/gk7g
zEoi5i73oJ465Mtms8luN1m49UxapwP91vsIEPy7Nn9ekiTWYTIm1cTs3CvXPx5nbRIxO4V4GgAb
/ToMy9E2SuNt23ftLgr8NBmRNyHLxs7bF4dG9NIvZwcyxCNZ8cWVCZScfpO9i0/BkZ70spsss3Ka
Pgw0Jvl/okW2aghQTkvlbYYfIN2YcH/ve8rbu8wJMhHlXnT+1LhuXzYt+8bisLmoJy4wjolNUf0U
5b1zcDyV3U7qFZmh8oEb5CsbL4BaH2LP3c/uHA49ZjELrO/tjG8uDJg1HB3QG5ambes9NlFn87oU
KE8QvE584kkZqOyShX83FVA598nguFBqBQKRBa5XUW2RyPlr+W9QkTzXf81oaXq26dhQEoEwlyQd
uuJiQvj6LeTX2UbNGktiqaX0lyz0CfM7Pdk8HdYRfMt9o6AYOQNZM9EGx4+9AbDRR4WzIbcL6cdu
Vh8=
=xm2j
-----END PGP SIGNATURE-----

--FtgIWRAI2xlKZ1VU95BtsQNLaEcX1k27K--
