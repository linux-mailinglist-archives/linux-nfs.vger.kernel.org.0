Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08606308203
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhA1XkJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 18:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhA1XkI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 Jan 2021 18:40:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 943F1AC60;
        Thu, 28 Jan 2021 23:39:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Fri, 29 Jan 2021 10:39:21 +1100
Subject: Re: [PATCH] mount: parse default values correctly
In-Reply-To: <20210106184028.150925-1-steved@redhat.com>
References: <20210106184028.150925-1-steved@redhat.com>
Message-ID: <87o8h8fx7a.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06 2021, Steve Dickson wrote:

> Commit 88c22f92 converted the configfile.c routines
> to use the parse_opt interfaces which broke how
> default values from nfsmount.conf are managed.
>
> Default values can not be added to the mount string
> handed to the kernel. They must be interpreted into
> the correct mount options then passed to the kernel.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1912877
>
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  utils/mount/configfile.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
> index 7934f4f..e865998 100644
> --- a/utils/mount/configfile.c
> +++ b/utils/mount/configfile.c
> @@ -277,8 +277,10 @@ conf_parse_mntopts(char *section, char *arg, struct =
mount_options *options)
>  		}
>  		if (buf[0] =3D=3D '\0')
>  			continue;
> +		if (default_value(buf))
> +			continue;
> +
>  		po_append(options, buf);
> -		default_value(buf);
>  	}
>  	conf_free_list(list);
>  }
> --=20
> 2.29.2

Hi,
 unfortunately this is incorrect.  As the referenced patch said:

    The default_value() call is now made as soon as the option has been
    parsed.  It is left on the options list so that new instances of the
    value are ignored.

 The new code doesn't leave it on the option list, so new instances are
 not ignored.

 conf_get_mntopts() processes options for the mount point, then options
 for the server, then global options.  If there is e.g. a defaultvers
 for both the mountpoint and as a global option, the global option will
 now not be ignored, so it takes precedence.

 The real problem as identified in the bugzilla discussion, is that
   	po_remove_all(options, "default");
 doesn't remove all the "default*" options as was the intent.  Clearly I
 never tested that.
 This is easily fixed with
 -	po_remove_all(options, "default");
 +	while (po_contains_prefix(options, "default", &ptr, 0) =3D=3D PO_FOUND)
 +		po_remove_all(options, ptr);

 which I have tested :-)

 I'll follow up with a patch which reverts the incorrect fix, and adds
 this one.

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmATSyoOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnYpQ//VxJskdcTxqDRlzUG9GRtzw8BupjMg3mvJItU
IBz5ZOLTOrvurUnjizHzuMh01hmriLzX3y4ouzQRdiWnNrjpDrt81XkZKd8ZjoL0
F0Is5cUYd8TSeUbXF2jZzGXQ03xDIWTMgdn2N+3MGj6ij8pvSUMaO2w2MuZOj0xc
Dhq2+fspgBqd8bULl7KkSXX1VN7TSPAcQuHybsRoWb3+g/dR3otQBQgHNnIyojXz
FKigQ2r8rZM2BSCG/PWJpk3CVYi++KOA4YtrGZUxInbHmlwiyFhocMLzlW1FnoB1
H3H17SRQSLnTesbIdZOBt/rFtclX6e6WWFS0RLzhzhVCggEJ3a8KEED7JHiQw7K3
oug9Q2WP/ldmaBQXnnOomhc+vZmdKjIkyPifW4gm6kfvFTo2v/41y6mGZ+7PQxGP
m+aNamHVa0trlD+0yZ9JzEszrkAIuCqy9M4iVBDWEwvWKBens0fXjEUCC4FGkHq9
owP+ZWIzMBAu2bKIMLkhYEhGsStnT3y5XtN6GHj6HyGBuB+86jHWgmgplPOY52RS
po0/lP1CkTAQxq67yqIqGuBf+x5fQJnC15tVlRP1ZuHL+1Dhfeeoqmd3GzdSjRMS
IwcX1SVafGFoV3QlHkon4e+8IB+Pm11o4zFDreCTxANA+4kkVTaWbCSH+0btF4jM
ntPQ0ro=
=+7UE
-----END PGP SIGNATURE-----
--=-=-=--
