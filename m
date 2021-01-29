Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5396309040
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 23:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhA2WoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jan 2021 17:44:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhA2WoM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Jan 2021 17:44:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A31E7AC48;
        Fri, 29 Jan 2021 22:43:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sat, 30 Jan 2021 09:43:23 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
In-Reply-To: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
Message-ID: <87im7ffjp0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Jan 29 2021, Chuck Lever wrote:

> Hi Neil-
>
> I'd like to reduce the amount of page allocation that NFSD does,
> and was wondering about the release and reset of pages in
> svc_xprt_release(). This logic was added when the socket transport
> was converted to use kernel_sendpage() back in 2002. Do you
> remember why releasing the result pages is necessary?
>

Hi Chuck,
 as I recall, kernel_sendpage() (or sock->ops->sendpage() as it was
 then) takes a reference to the page and will hold that reference until
 the content has been sent and ACKed.  nfsd has no way to know when the
 ACK comes, so cannot know when the page can be re-used, so it must
 release the page and allocate a new one.

 This is the price we pay for zero-copy, and I acknowledge that it is a
 real price.  I wouldn't be surprised if the trade-offs between
 zero-copy and single-copy change over time, and between different
 hardware.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAUj4sOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnL+BAAuzkaasYeGC06W3kY6RDIjXrvKoOTN82PpSm0
Qxmc+D4RrZX8sH8kR+uAWEaaAxZjs5IHWQ1LLGNF5ccI8oGsdjeZv3oalL+wlnQe
1Yga/UQhwEpnVIQjIdzDiALydQgObzt2OQsOyd3kDpAnvujQ+vTnpQSe0gyWoQvr
UHEAla5cgGXgl1xygpeq452QCgLZ1QllBb3RCimL+PkDRQqr32ytdXPGuS9wylOb
KXv/UelNRU6NDMHytMIoQNPQTsn6bSc4CaOfWsaFRfp0GEsnsY7U1eQHOQWwPl1P
tzCF/BjoUipr50WhLimVE5YC7F3mgZ8BeCskUgc+GUsbB/uZ2xjfysuu0GFtIS2G
2VGqZXQNYWEEDw0Y1ozfrSPGEAqVQTTUZnYhQUW2cda+qrTDOHZo5Cj5PisJffav
nPVjsZaWRK6DLByEnKJgN3DaCOdj3SgNmHpcSl8BhGVIafpSMZm/jqBHSOZHgTrM
9b37NlWXnqMXPLTApOmsSUsggosThFvmzRAbEOMizj16NnY3iA6hhtHcBcPjrhSy
amkLR4a7wo0RolCNMEDr73EaWXpcWFWWZqxkT9fyHOYPsINbTOKb0sGwkMVUlIFI
/5JZBxTCIBJzsm5BkaSIkqHggGNlnV9DeG8wF4U40p6AmCaWTth2BS+7hF6qH9B5
j8TRJlU=
=D0gN
-----END PGP SIGNATURE-----
--=-=-=--
