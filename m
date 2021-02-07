Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D031286D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 00:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBGXmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Feb 2021 18:42:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:34294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBGXmx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Feb 2021 18:42:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 403FDAC6E;
        Sun,  7 Feb 2021 23:42:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 08 Feb 2021 10:42:08 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
In-Reply-To: <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
 <87wnvre5cy.fsf@notabene.neil.brown.name>
 <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
Message-ID: <874kine97z.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Feb 05 2021, Chuck Lever wrote:
>
> Baby steps.
>
> Because I'm perverse I started with bulk page freeing. In the course
> of trying to invent a new API, I discovered there already is a batch
> free_page() function called release_pages().
>
> It seems to work as advertised for pages that are truly no longer
> in use (ie RPC/RDMA pages) but not for pages that are still in flight
> but released (ie TCP pages).
>
> release_pages() chains the pages in the passed-in array onto a list
> by their page->lru fields. This seems to be a problem if a page
> is still in use.

But if a page is still in use, it is not put on the list.

		if (!put_page_testzero(page))
			continue;

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAgetAOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmVig//SRaYwWMTFaUFnWyv+sdBcSJLWsoh3IYDVYVh
m/nDlyX7MGT4lQg2tJs5+CaC/vVNdUEOSXXc7wGN9geuWqyzvXtVgnt6UaZsSX52
bBz6wBolrwK9EvKi3qBAzz9lu6V/7OHy99sqW7G8cPwIaJ0UeZAKalb1kkVdDBRI
st+QjXfOmDMdKDbqy3lRGUFzEkiVAOOSr+uEO98xkjG9cephJBxpTgo3RE+10br+
Z1Jm7MtsYGwf3Qj5zJlYXqDAfSDGgqs5lJdbq4s//ySt+okb5cY3nOb6LMG9eQbI
ENAYA3avkyf83UR9HqcaCwwDH8I5jFPvJJ+9dZDh5l7k9bv2d+BkQdlaf1W+YmRB
3R5B4eRtoCZrdVLipatYBpVMCSmzfmKBrtN1D+kE+U2XXMiUM1QMFd1+qHbINW73
b1ELs2OOETIDOlnpxluJvUZoCCm8PO3AO919SD4RkcAl7tPcUzJyXI9Z/ZGsCNlC
Zp4ZdLlHHevXsApznEgu3ZW2koF18TkChGLRrktGLBTCmKSYHShDCc1GvDMzIT/J
PbGzN2EXvTC5Tqg1vi75pvLioVnhX/0vji7mdB9vjVfiwbKUiUgSKbkAwbGiAaii
KbskgIOlejC7vtKmUIW6AJeltYGQW79AtZN9Nl0/FI37uezoN1W5O4XnjwEcH1ue
CX7mGjg=
=Z+jB
-----END PGP SIGNATURE-----
--=-=-=--
