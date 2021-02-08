Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCB31289B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBHAbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Feb 2021 19:31:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:42890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBHAbA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Feb 2021 19:31:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 659E9AB98;
        Mon,  8 Feb 2021 00:30:19 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Mon, 08 Feb 2021 11:30:15 +1100
Subject: Re: [PATCH 2/2] mountd: Add debug processing from nfs.conf
In-Reply-To: <20210201230147.45593-2-steved@redhat.com>
References: <20210201230147.45593-1-steved@redhat.com>
 <20210201230147.45593-2-steved@redhat.com>
Message-ID: <87y2fzcsfc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01 2021, Steve Dickson wrote:

> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  nfs.conf              | 2 +-
>  utils/mountd/mountd.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/nfs.conf b/nfs.conf
> index 186a5b19..9fcf1bf0 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -30,7 +30,7 @@
>  # udp-port=3D0
>  #
>  [mountd]
> -# debug=3D0
> +# debug=3D"all|auth|call|general|parse"
>  # manage-gids=3Dn
>  # descriptors=3D0
>  # port=3D0
> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
> index 988e51c5..a480265a 100644
> --- a/utils/mountd/mountd.c
> +++ b/utils/mountd/mountd.c
> @@ -684,6 +684,9 @@ read_mount_conf(char **argv)
>  	if (s && !state_setup_basedir(argv[0], s))
>  		exit(1);
>=20=20
> +	if ((s =3D conf_get_str("mountd", "debug")) !=3D NULL)
> +		xlog_sconfig(s, 1);
> +

Why is this needed?
A few lines higher up is
  	xlog_from_conffile("mountd");
which calls
 	kinds =3D conf_get_list(service, "debug");
and passes each word that it finds to xlog_sconfig()
??

I just tested setting "debug=3Dall" in the mountd section of nfs.conf,
and it seems to work without this patch.

Thanks,
NeilBrown


>  	/* NOTE: following uses "nfsd" section of nfs.conf !!!! */
>  	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(_rpcprotobits)))
>  		NFSCTL_UDPSET(_rpcprotobits);
> --=20
> 2.29.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCAAuFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAghhcQHG5laWxAYnJv
d24ubmFtZQAKCRA57J7dVmKBudsfD/48XZqjRXqaxzn6QHqPd6UYQay5SD6soKL6
z+d9DYrvksVS/EZknFXp2j1ZAoz/a8U0to9dHF3b43podcZExaYFWn1qrHqHLhqJ
sRcCQVr/nCrsWGux/abRhqFJzHguHBABY6bShTxg+uF5geyiJA13BMVbG5nuN6zb
I8UDs+lNYTWC3NC8NayvWUu8gQVYzJFt0nu1uvoIQkiW7i9vs5eveK9fWujAoC2Q
dKfpS1EG45+miMgjYYqgZ+iMVhGUdBvef7K/nlceOqpTKLIyKhtVQKRwKI28DzkN
1OFZzfgoFeUSht36Rca+F42WbPBNHAKCwoytokprw/fP5RhMk0OyVIwqlrNpEC3u
56fgjK3N+e3VnwR1peqAA5lb7+aUUFckDAlTvE9FA5OsEDl/4Q6ZeiX6sKJuiuCO
MVzeYbCWDqTsW6OVvtgTDtfEvs81x4ivBmaqZPeXsfwCcs6M+DzsTXRYvK0NgMZO
TxC5QiIPjcs3XmSRA41dKRydN2klxjz/hSNOa5gr6i8VgTga7gwDX/mfWW5AqkAu
Rz22eNeEt4o83wRVSzdifLes72Qvb2yBYCtovj92OwVx6ax9/La+5DuUD1WvEqx5
OzwEwCTOQEJGk4btoerQHMqkV1UQYwwIBSrcuT6UZK4+gx+VnO5FfcjdDT2wpIYc
iLzDu3UIhA==
=z1Tf
-----END PGP SIGNATURE-----
--=-=-=--
