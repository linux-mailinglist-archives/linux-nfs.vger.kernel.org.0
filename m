Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2802F30A0FE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 06:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBAFBQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Feb 2021 00:01:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:50680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBAFBO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Feb 2021 00:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CADEAC45;
        Mon,  1 Feb 2021 05:00:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Mon, 01 Feb 2021 16:00:27 +1100
Subject: [PATCH nfs-utils v2] mount: fix parsing of default options
In-Reply-To: <87lfccfx5t.fsf@notabene.neil.brown.name>
References: <20210106184028.150925-1-steved@redhat.com>
 <87o8h8fx7a.fsf@notabene.neil.brown.name>
 <87lfccfx5t.fsf@notabene.neil.brown.name>
Message-ID: <875z3cfklw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


A recent patch to change configfile.c to use parse_opt.c contained code
which was intended to remove all "default*" options from the list before
that could be passed to the kernel.  This code didn't work, so default*
options WERE passed to the kernel, and the kernel complained and failed
the mount attempt.

A more recent patch attempted to fix this by not including the
"default*" options in the option list at all.  This resulting in
global-default defaults over-riding per-mount or per-server defaults.

This patch reverse the "more recent" patch, and fixes the original patch
by providing correct code to remove all "default*" options before the
kernel can see them.

Fixes: 88c22f924f1b ("mount: convert configfile.c to use parse_opt.c")
Fixes: 8142542bda28 ("mount: parse default values correctly")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--

I realized that po_remove_all() could free 'ptr' and then compare it
against the next option, which would have undefined results.
So best to strdup and free it.


 utils/mount/configfile.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index e865998dd5a9..3d3684efa186 100644
=2D-- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -277,10 +277,9 @@ conf_parse_mntopts(char *section, char *arg, struct mo=
unt_options *options)
 		}
 		if (buf[0] =3D=3D '\0')
 			continue;
=2D		if (default_value(buf))
=2D			continue;
=20
 		po_append(options, buf);
+		default_value(buf);
 	}
 	conf_free_list(list);
 }
@@ -335,7 +334,11 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	 * Strip out defaults, which have already been handled,
 	 * then join the rest and return.
 	 */
=2D	po_remove_all(options, "default");
+	while (po_contains_prefix(options, "default", &ptr, 0) =3D=3D PO_FOUND) {
+		ptr =3D strdup(ptr);
+		po_remove_all(options, ptr);
+		free(ptr);
+	}
=20
 	po_join(options, &mount_opts);
 	po_destroy(options);
=2D-=20
2.30.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAXiusOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkxAhAAi9v0Jdv1NzjBZmhlYle6KYL51M62ZWgJfDmG
WNnm9V/J/EoQBorKsVmqLtfEQvz7+hrUvJQSmww5Q7y1AFtBYOZX0ZqEMTN0742X
90LTrymjCUt+P6JwZrFgDyuTHZgyJRyNB10YB/+FGVf5zH8+P6jcxrYDxmjssuRk
3I2cMWyIh18F0vepAp5WVV8sp4/aw5JyOrzhb+KEUr7wqYxfzibI13HKZy8s4Umv
j1ILaKdq6KKlwKqp+upzZc8gIdOaxTOXWQNfNCv9w2Dl/jCXrVaUAuAmI4ORVDj6
8PqEaurWLlpL8otSimBd/ik4Ua6fjfTVs4GqN5V3J4n24f1aUDRmqSt3XZbd2umW
l72vTpHixxX8IFTwbKo18hX89UpjyeZgIGjUAWM7NqmQgngRXbrEtBBYkGu0O0gn
lqLXe2Qd4LUMdSGlaB2JnG+TNkQ8PaLFlAZKQRv5zFGn1bvjnIwTz+duaZWuZO5j
IFvNqU6n0Oe4nYDIUK8Z4b4pgrw7HarHAwVvkrotr+74QSU+1jxMtmk8ilKkh4jI
aHXl4Zaf1i49uPNeZYSlYRcW+z4FbyRyDBXkO9HXZR68xMk6IyW8lOJR7HUtp+s2
M0DDxtctbO5wdf5g3qyZrUjSeD1stCix1LIfEfOP5IEkY+pIYzR2mWz/8TWS1zwd
9SXCUpM=
=l9QY
-----END PGP SIGNATURE-----
--=-=-=--
