Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE148FD34
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiAPNfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 08:35:42 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49931 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233233AbiAPNfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 08:35:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 185C95C0110
        for <linux-nfs@vger.kernel.org>; Sun, 16 Jan 2022 08:35:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 16 Jan 2022 08:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=khsQXPVp+OvHLJ0ClFdTkdz7Y9NtH
        BO5j3srGihglJI=; b=mGOqipLPKxJax+jgs5LT/1oMjDOtO+O3WXrmsN2Q8vNKg
        I9KAVqPDRkx9vpoHVIWEPlNFYaWJZr7B/trNLDoEj19miydZQwjFg3r1ruYF/wg5
        z1aREgxsLK0VetCg1s9AFXKZbxQhe+kFUSjgqdZLzPzu3QUU7ditXl0eu6y9l5lx
        mSuklP0MwrWXfhUy+Lya8+L4FKJeZkzGkYs25AbeemLtxLNEY8OkAn6PHT8cb9rv
        I3nQONOs8+N6lNIfX0keGGXagun55BzgaquKEheNxiF2BvbQ9iQ+qR9qi21kXmAD
        BpIBEMB5L/8+GDt8DKTrHc1nrb/VSGp3xM83pTxaw==
X-ME-Sender: <xms:LB_kYTPHXhwf6Ot4_-FL3F8DFUmeuKPP_p48KLj0xpY_zLLl3EeXzg>
    <xme:LB_kYd--TGCgggIBqVELbBCTlu9PweO1g_sptEbkdJ4c6AzPsC18AtmVtlPfj9hJB
    KzC7tMN2Fotbhku0w>
X-ME-Received: <xmr:LB_kYST3HUOxCeQdSA46VrHWR-uVil834rmbojX-DxeZnv3zqIOE4PoD4Q3Qjfnb1pt8Kl39KKooqtLqIYNaQK0Enb9OzsSsR5RlgmkpAO109y0iUDFHKOQc2HPqvSJmWNLO5bsGcryS6gspfAQBOYInn0_PgBso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdelgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhtggguffkfffvofesghdtmherhhdtjeenucfhrhhomhepfdffohhrihgrnhcu
    vfgrhihlohhrucdlnfhishhtshdmfdcuoehlihhsthhsseguohhrihgrnhhtrgihlhhorh
    drtghomheqnecuggftrfgrthhtvghrnhepteeukefhgeevfeevgfduudeujeeiteetieej
    udelvdeitefgkeeileelhffgleetnecuffhomhgrihhnpeguohhrihgrnhhtrgihlhhorh
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhsseguohhrihgrnhhtrgihlhhorhdrtghomh
X-ME-Proxy: <xmx:LB_kYXv-39ETSSRG2huxaXoq4qPej5wTFepKiGa-yfcLnBT13mV2KQ>
    <xmx:LB_kYbegqRroicVq_XxHro4OhAI5LerAtGLizJyntWNFZofRUFZXvg>
    <xmx:LB_kYT10OByN9fF9rZJhs__cuu2kBXXgCR6mV2JOBJ1qmKe3QUmG5w>
    <xmx:LR_kYcpt7Wqrj4PBuawMNKUvgfrX9ylIgfhVZNZDM4LDD0XGdEu80Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Sun, 16 Jan 2022 08:35:40 -0500 (EST)
From:   "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4B8FCCFD-EBE6-418A-8CD6-788C120F9A1B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: strange activity on otherwise idle linux client
Message-Id: <439CFB33-94AC-4F60-B737-A0F596B815E3@doriantaylor.com>
Date:   Sun, 16 Jan 2022 08:35:38 -0500
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_4B8FCCFD-EBE6-418A-8CD6-788C120F9A1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

I noticed yesterday that my Linux (Ubuntu 21.10 x86_64, kernel 5.13.0) =
NFS4 mount was causing load on the (also Ubuntu, 20.04 LTS) server and =
when I went to investigate, it seemed like the client was polling the =
server at about 200 operations per second (100 ops read and the other =
100 `nfsiostat` didn=E2=80=99t specify). When I looked at `nfsstat` on =
the server, I saw a profusion of `putfh` (32%), `sequence` (30%), =
`layoutget` (15%), and `layoutreturn` (15%) (`getattr` and `lookup` took =
another 3% between them, and the rest fell below the 1%  threshold, even =
though the total number of operations recorded was on the order of 100 =
million for a day or so of uptime with two clients connected).

The chatty client was had a couple files open in Emacs but I closed them =
and determined that they weren=E2=80=99t being accessed with `lost`, but =
the polling continued. The strangely round number of the polling rate is =
suspicious. Is this normal behaviour?

It looks like the NFS version on the client is 1.3.4-6ubuntu1 and server =
is 1.3.4-2.5ubuntu3.4.

Regards,

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_4B8FCCFD-EBE6-418A-8CD6-788C120F9A1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmHkHyoACgkQirFKO32N
r6PlWg/9Fe1ZBaHwtA+ycd835aB0NCi26NbdgbXsQ1DAS0re2ApyWiN/lV84iKV2
AicpcvvcXubPsTdvWsK9v6V6/jrlIMdnlLajchUY6cqA2QO81YATBcf3SojNWafp
vmyUXM2hHCNJjDhpUZbDDzZdtCdo4xkV5MQYOKWpQ1dtq4tExdFORUFmKtURl9VP
DjlTZjsqaSWkH4RaYhzetxrU6ADkqswAlarmzevf5k+hxVt5D0NFfUUqppsgmsrs
qU+Iap9wPZvdQgDhXqsy5/KG1inLrAK5JS6hKwPeluAi5x/EXVaY3Qf0r4LyAQPH
RH7a9ng+maxSI+P/P8pIlsPvKk0XWtZwfYSml1ZMn3dltJY6EqB8r3JdNJuQCYlk
Wem7lN3+4zHL0JtijX3isJYEq+iIcmDmV6WXyrQdmV+/DeRWBnLPhsXE1QMnVmXY
YHRbQzzKSF9+3E6TkvWRwRUFssIhQTY7cgsNL6X/fflmHs+AoPcD9mh7z7P2AsgL
ZdKOhJXJ4R3hPWyXgvLiSTTdAvM1r9TU/+S/QpRyDlQ1DmhfRzaObwYb4vbe/VaZ
UxbM7rtWXZC32CeCTtji4nXb0YWV3mH0BlsqydygLBAfdIdjcMFXaQ/OHWEJXnk/
mNlR0c4J/ZcMLLHJEbzzrU2Z0TpkgW6NHX441zaRt7Mpt0reyBk=
=t6TB
-----END PGP SIGNATURE-----

--Apple-Mail=_4B8FCCFD-EBE6-418A-8CD6-788C120F9A1B--
