Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1E31287F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBHAAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Feb 2021 19:00:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:37890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBHAAL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Feb 2021 19:00:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52747ACD4;
        Sun,  7 Feb 2021 23:59:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 08 Feb 2021 10:59:24 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
In-Reply-To: <20210205211351.GC32030@fieldses.org>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
 <87wnvre5cy.fsf@notabene.neil.brown.name>
 <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
 <20210205211351.GC32030@fieldses.org>
Message-ID: <871rdre8f7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05 2021, J. Bruce Fields wrote:

> On Fri, Feb 05, 2021 at 08:20:28PM +0000, Chuck Lever wrote:
>> Baby steps.
>>=20
>> Because I'm perverse I started with bulk page freeing. In the course
>> of trying to invent a new API, I discovered there already is a batch
>> free_page() function called release_pages().
>>=20
>> It seems to work as advertised for pages that are truly no longer
>> in use (ie RPC/RDMA pages) but not for pages that are still in flight
>> but released (ie TCP pages).
>>=20
>> release_pages() chains the pages in the passed-in array onto a list
>> by their page->lru fields. This seems to be a problem if a page
>> is still in use.
>
> I thought I remembered reading an lwn article about bulk page
> allocation.  Looking around now all I can see is
>
> 	https://lwn.net/Articles/684616/
> 	https://lwn.net/Articles/711075/

The work in this last one seems to have been merged, without the
alloc_pages_bulk() as foretold in the article.  i.e. __rmqueue_pcp_list
has been split out.

Adding that alloc_page_bulk() for testing should be fairly easy

   http://lkml.iu.edu/hypermail/linux/kernel/1701.1/00732.html

If you can show a benefit in a real use-case, it shouldn't be too hard
to get this API accepted.

> Therefore, IMO concentrating on making svc_alloc_arg() more efficient
> should provide the biggest bang for both socket and RDMA transports.

I agree that this is the best first step. It might make the other steps
irrelevant.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAgftwOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmRPg//SiZzZKRB2wqZBLBj1S82oQxAjG6Vbqu8Fvor
xcRilocTfvPWeWB/8FqbtDUjAOjYpVc5APu5d/OPnR66qJHFN33hMtFZwslw5WtC
fHcajvLb0la1L1eHHtxwVh7DlRB6wM5VyortwN8UA3GovfuJ+zLx9zaahzvEbnyX
ORLcAHkhJo4WJBmTGUyLshyRLXpkLX9mjMklbfRPk29/xiReXOKnN8l6PGDrza4U
WZh8W2cnOFpHNMf9AAqtmKumFk9QSm4D28w3ye5I5EU7Msq1UKzmiOyn0SR/pp6E
mLjCVHSjLRKy4cf8arDvspurcsLpinwt5u6ZFQFOSdgOXcFJuBecN/nqNLQJbNOt
amCIjvum9hmIEtbBZrgCOa2D7f4nC3WFgzP1EVVTyih0egM1bT4MxAz0lCna5D8b
DxLcyoMVUnc/URbNB/XVLpoFfUpxbBrpmk8kSWJDeTMI74olyQv5taWe4OQgVdp8
i338WAT+lH0XsavV3J7gXObox5ZeAhU0MEhiqzYRr5+DAYNCCmLNvZLTLXQCri/M
ItPRdmyLxSfXDydmX8iv4NUj3ryuJa2p3pg7vTu7oVNVqfGdBPVQJ2/RZqwrzwUk
+QaMhzjNI1kN/e5CuijJvzscjl4jlVuyn37OWv9Z+ok4ERMsFoaVMwBJ6XVX1NrK
UdOtmvY=
=02yZ
-----END PGP SIGNATURE-----
--=-=-=--
