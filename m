Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ACA1B146B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgDTSYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 14:24:19 -0400
Received: from orion.archlinux.org ([88.198.91.70]:55972 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgDTSYS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 14:24:18 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 0DD7D1B2061FD0;
        Mon, 20 Apr 2020 18:24:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on orion.archlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=ALL_TRUSTED=-1,BAYES_00=-1,
        DKIMWL_WL_HIGH=-0.001,DKIM_SIGNED=0.1,DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1,T_DMARC_POLICY_NONE=0.01 autolearn=ham
        autolearn_force=no version=3.4.4
X-Spam-BL-Results: 
Received: from [IPv6:2600:1700:57f0:ca20:763a:c795:fcf6:91ea] (unknown [IPv6:2600:1700:57f0:ca20:763a:c795:fcf6:91ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: eschwartz)
        by orion.archlinux.org (Postfix) with ESMTPSA id 80DAD1B2061FCE;
        Mon, 20 Apr 2020 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archlinux.org;
        s=orion; t=1587407054;
        bh=b8yE6SfrC+k/c1tP0sv8YlPvmvjOTPQ+2+fGALhfSRs=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=bye5kf+r31YcJH+i3ZJaxrcV8W4Lh7MpLj6iVgLyGVbQ65aCmFEvKh+hb3GWZKybs
         7K4yenCHU2vyYf7bqMySu4OwSFRydyICyTanMH+y47ZkSYy2O8jZ3WGcdfwAJF4dgv
         4DIheO1lcwW0k5MjZp58kd6EoZZcGWyGajYT1xFZJ/12zchqKuM+slZT2falUARTFR
         TKNpyXSEAg5tUOexIwLyQXLalTLRFmwMbe9qUQLydhLmfiN0mBGOakUg/91SCdmuqY
         mCa9GxKfNYKaJi8Ola2JfWuB0bk08eGNu4+8/RYNapWaF6WDCx+kRuqtnm/3bMASFO
         JYDG/0z3tlsU/AOeDv8MlQQJxfOYUO02bnzT4IPoK2ZRRFQQDMPEqd+wr7cE72B8EL
         Wse+8WkqU5yS9XmNW5blC/JXCiuH953gDXQ8pyDkLItqy92Fs0IQfdqz+Kct3XCDzM
         3GFib+qSnNZK+nMorys5NykvljQqNuz28wkpj331ohpaeFqnPmblw3B1gOinmnb+IS
         eFkWc6QqTGiCaB8cAfS02tQXWWPvO0tUjsQ1d72x4+gWKR4MJTB7tQAYX7l/igJaN4
         t9rwtl3lXj2ciVW9ya7nKUiABNyHtp+mcbsKKvyNKST1/dF52PueRC4vhlb469besT
         Mrv4eGDDPI18djxWDjbvVjkU=
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Re: [Libtirpc-devel] [PATCH] pkg-config: use the correct replacements
 for libdir/includedir
To:     Steve Dickson <SteveD@RedHat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20200419075201.1161001-1-eschwartz@archlinux.org>
 <3c90187c-8b02-9d74-3890-63dd36c2c56f@RedHat.com>
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <2ac668b0-6005-0ec3-fb3f-611e2c2d818f@archlinux.org>
Date:   Mon, 20 Apr 2020 14:24:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3c90187c-8b02-9d74-3890-63dd36c2c56f@RedHat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J6XDgm42pv8vPP2RO6qIrmn6jkamlnw7C"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J6XDgm42pv8vPP2RO6qIrmn6jkamlnw7C
Content-Type: multipart/mixed; boundary="Pz9wL8TXpFwWDIem62S4Ux8ZD8F1rlh4V"

--Pz9wL8TXpFwWDIem62S4Ux8ZD8F1rlh4V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 4/20/20 1:47 PM, Steve Dickson wrote:
> Hello,
>=20
> On 4/19/20 3:52 AM, Eli Schwartz wrote:
>> They are defined pkg-config variables for a reason, let's reuse them a=
s
>> is the intended usage of pkg-config. This ensures various pkg-config
>> features continue to work as expected.
> Just curious... What pkg-config feature does this fix?

--define-variable might be used to remap paths.

But I see I forgot to git add -p all changes. :(

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--Pz9wL8TXpFwWDIem62S4Ux8ZD8F1rlh4V--

--J6XDgm42pv8vPP2RO6qIrmn6jkamlnw7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvSewel70XCra9w4EhIGKaBmvSpsFAl6d6MoACgkQhIGKaBmv
SpvijRAAsHWMf1T7D4YPldc4VgZ0FjjiEjKpitrHp3XN0ugqTyr6N51MFCU0jEgY
SJwKHnx9iRLpl4xc1tCWL+gSNG2Uw8WxyoBU3vkvi2aSCz5dBEK130G4Ym6MwxPU
d5RGBcVr+Kae6ed8SVoElwv2264CzcDuONavBGcwuLYSjY/KLEZOFttuJLLeSu7q
esUwOScfkF2XtBK61729qW/jarWVDFhZXFRytcDupc2jWmJxSe4V7xDZuuwVzbiQ
0HiVmV+kka/vMnXWFI44Vri9F3HOJuCFom99bKisTb7ktvZdn70IKo81wvZuh3rS
aJuJVBmBBEm8VcdJ24ORFCUq03zUoEdo3ivI9ImNJjHh7p7xG8VvvUOinGFC532v
8eQ7Lx0FqrEu0bR1fcgPuENt0xXReC0m/CM6ov/EKEMAPzQilv/gVM8s+7nIWvKv
uSVy/d8fATQiRuRm1ddLMjd8JdtmlMAZ3Lu51G43lqBdSt/MlJjYk7KFRFFKkXhI
U7mc0EcC9TnkIhPeTuSIHmARs6YzQd/w8R1dX4qpeE6aPzQnzktBlUMGQKVTHp1S
3KZXjGp9VkHJCifU7c8kwwcld9vLaCqQz8rlrN6iHfexKfEqTLUxKqkHNatvhvBk
6MtocJjkWR1ZesoIUtFo/Oso1zBhIvEFR6kuAOZutQg7wJTnmOeJAjMEAQEKAB0W
IQRgQRMEwJ02YoNA7v/OsWfvtXIr1gUCXp3oywAKCRDOsWfvtXIr1qPrD/48V9A7
/tVfojRopqGE1N2/soL6Y2Mn9ZA4xvBDpCwk/yw15MJT0jQwpCCHrOhUAeZAY4kb
3zgWf5bNBjgHVDk4eP6fxBM+OtHo0YpLHM1GylWFeJyZl5bWZkSXqmTQ5t2o4dRn
fIm5BNX4H4iqBNDrupmppJ8xk6PxvADvYqcmyNRhiWQqKDzrWEE1FuaVOj9cpbiv
BJgIeVjt5sKHwlBrT8nLqU873T1Hwv9xsMcAH2miAK4TewKA8xPrbVUp2pI+jmOG
ECuLhc3ZjbVsersihbnl5HdXY1lHACMCIg4NnSJdp1RVVXXE0Ddr7UVl/fnh6dZI
VKCQ6bsnYRXW7m/UpL1XAVbxOUl/hlzf98sPnLReBuld2VPcaYCn8vYQlvW8Fzdu
Vfq7MGwU6PGMt7AgC4q0YsjYFpaR7QC/bqa7lJQgsp8By2XkGmLzRqqTJ0iZ45Oo
ToOLO4gbHgBdHwlGO+ZG+y9ySev297N/T9IViZ1AHlXFN6LXt+hrIucXhUh3XEJT
xN1kpz1zOqZqpSSZ/qDZ6bUTy304lItxxSYc/GPEKflufjg6ktlwvW8mhX/pa0dz
5I64HlZBLA99ur99N4FgSoYoIqw1WBeMzENGWTijgrUDLf9K+xHRmQARzxcqy8fE
EWch3uVmGJL43HykRxJdV/MwpBTKU1+o3b2bIg==
=CWSb
-----END PGP SIGNATURE-----

--J6XDgm42pv8vPP2RO6qIrmn6jkamlnw7C--
