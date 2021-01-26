Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1B303C22
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jan 2021 12:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405502AbhAZLw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jan 2021 06:52:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405472AbhAZLv4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 26 Jan 2021 06:51:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DQ4nV6mb8z9s24;
        Tue, 26 Jan 2021 22:51:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1611661874;
        bh=0eQMEVT1gu8ENfr5plp+NINmLwG2I10lGKyNJgzw5vE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GAy6Kjkg6QqVM0ykQfOxUS/GvLwBnPbHCUqpb/7Vud2BiIN9Z6pSmvf38+wjACZUl
         nwjc01rIIfA9aY7/3RZBpiSx2ZDthJREj7htY8vJ3rDHgbtusbu39uyYUtg8KjPrPL
         lyI3kHfLs3t3dpGK+BHZDEDwUtWI96L3ltK/7NcsPjYt6GGl+olzujIkT1kP4Bbk8K
         IZmgDT6bVxCFu0itRIPiayBdcmDdODhVJPWHOJBuu8cJoVdnmE/nUAYEDAVR+aHJ6l
         89ilHgzT3sVa/3/t5mcsMWxlEbCrrIXGz4pvU45LPW0trihzOYOoGyvHCwgM4nHYcQ
         tqWCQMt3XLyaw==
Date:   Tue, 26 Jan 2021 22:51:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: Adding my fscache-next branch to linux-next
Message-ID: <20210126225109.594f3df4@canb.auug.org.au>
In-Reply-To: <2541781.1611611590@warthog.procyon.org.uk>
References: <2541781.1611611590@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/igtUeq_GukrXnQJV32zrjEn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/igtUeq_GukrXnQJV32zrjEn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 25 Jan 2021 21:53:10 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Could you add my fscache-next branch, which is in this repo:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
>=20
> to linux-next please?
>=20
> Note that it might conflict with anything Trond and/or Anna ask you to pu=
ll
> for NFS, in which case I'll drop the NFS patches from it and seek to get =
Trond
> and Anna to take them into the NFS tree.

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/igtUeq_GukrXnQJV32zrjEn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAQAi0ACgkQAVBC80lX
0Gwewgf/W9iXTJLgvqX+o6h/9cNBCUruxn6AQnHP+wwxQ/RRdXuOYKe2MJTPjXYJ
BUVI8esFmg1z7qETiWxaBpluIhB8mZowjZw8jcyV2ulz59PYzek8nQLhPrOBRziM
M95T5dy52HxAcAELaIv42unKsTO8Gwp/W219Q4uv+MP6XXHzmGbSoGLnYIM8TQXb
0yATAV6TouDEK0NcoUql9Mhk3vSQPEsN8ca6b8S4pOVynwjmGCqF60qvKf4jQ6lc
8XnN5pS+mGW393w04i4Rb5kmbpew/IbhkkAGqq/1eNxu2KhY3w6XkG4OiP2vpA0R
HPdLCjk7cBnF1F/rxccWBUOIV8QaTQ==
=Dno6
-----END PGP SIGNATURE-----

--Sig_/igtUeq_GukrXnQJV32zrjEn--
