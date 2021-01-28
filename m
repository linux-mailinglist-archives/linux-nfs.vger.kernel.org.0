Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05BD308207
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 00:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhA1XlG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 18:41:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:58620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhA1XlA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 Jan 2021 18:41:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0699ABC4;
        Thu, 28 Jan 2021 23:40:18 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Fri, 29 Jan 2021 10:40:14 +1100
Subject: [PATCH nfs-utils] mount: fix parsing of default options
In-Reply-To: <87o8h8fx7a.fsf@notabene.neil.brown.name>
References: <20210106184028.150925-1-steved@redhat.com>
 <87o8h8fx7a.fsf@notabene.neil.brown.name>
Message-ID: <87lfccfx5t.fsf@notabene.neil.brown.name>
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
 utils/mount/configfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index e865998dd5a9..ab386d08b031 100644
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
@@ -335,7 +334,8 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	 * Strip out defaults, which have already been handled,
 	 * then join the rest and return.
 	 */
=2D	po_remove_all(options, "default");
+	while (po_contains_prefix(options, "default", &ptr, 0) =3D=3D PO_FOUND)
+		po_remove_all(options, ptr);
=20
 	po_join(options, &mount_opts);
 	po_destroy(options);
=2D-=20
2.30.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmATS14OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblVPRAAi85XuQwaUB12qEYJ/YRQWxKPDu+fuobhFnm7
acepOsR5SJ9hThsKcG23aeaPJYRdTJOssum+93CmQuKze+5gHSfJBm+SAKGN85BZ
SBKUw9Vc0bkZQF0Ca4QJX/Cw69VVRXTwWavw1EHVdkqgX9JLsKe++guLZhRrlV9i
rHOVVMlmTxNHy44OEmZSaNQYUBhQeDu6CMyhWmwKGVdFGbXW2TlDWuS3tLMSm2Fv
K51YVexWs7TciFRndCHWH7QShucQueC7QACnQKF7gnuqiv2zI2Y2fqFdfgMVeJ+0
/0nEbxgrOulwJyYvKDOI05Wnd8+0MSf5gxShJvVe+gz4Rr2hPZeJhGV/jpT/zu1S
rkKHrLfLBWvs/JQ3ahIoh9H6xL1cbnzIelRRblDwHc6J4kMq01fQMV/OK2Mh89U6
k/md1pb1kZmTQLhieXdhV+7ZLVlMt8BkB7ml+FlcYLDIKr7F1geyCarbNtJKtGqo
7dS0ZVsidG1K/CTuWOfdk/OO1VERFPhxCnjUjfJdevtV4sQhMtv7jP75IxAMoyy2
0NtDdX6ZdcWRX1SP6gwKMvNAYwHyqP1AahV6Q+c/01udDrt+SplVKvcY8Ltr6pZk
lFvaLvbr+u6U/aYZGMsxhHxjI0DRZTYLwyQTzOWlZTlkq+lQxRQzz6ZrANBTrgv2
ikflgLw=
=szlP
-----END PGP SIGNATURE-----
--=-=-=--
