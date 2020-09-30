Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1073927E0ED
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Sep 2020 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgI3GSe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Sep 2020 02:18:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI3GSe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:18:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DA76AC3C;
        Wed, 30 Sep 2020 06:18:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@redhat.com>
Date:   Wed, 30 Sep 2020 16:18:26 +1000
Subject: [PATCH nfs-utils] nfsdcld: update tool name in man page.
cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <87y2krhjnx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


clddb-tool was recently renamed to nfsdclddb.
Unfortunately the nfsdcld man page wasn't told.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 utils/nfsdcld/nfsdcld.man | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.man b/utils/nfsdcld/nfsdcld.man
index 4c2b1e80a2a8..861f1c49efec 100644
=2D-- a/utils/nfsdcld/nfsdcld.man
+++ b/utils/nfsdcld/nfsdcld.man
@@ -209,12 +209,12 @@ not necessary after upgrading \fBnfsdcld\fR, however =
\fBnfsd\fR will not use a l
 version until restart.  A restart of \fBnfsd is necessary\fR after downgra=
ding \fBnfsdcld\fR,
 to ensure that \fBnfsd\fR does not use an upcall version that \fBnfsdcld\f=
R does not support.
 Additionally, a downgrade of \fBnfsdcld\fR requires the schema of the on-d=
isk database to
=2Dbe downgraded as well.  That can be accomplished using the \fBclddb-tool=
\fR(8) utility.
+be downgraded as well.  That can be accomplished using the \fBnfsdclddb\fR=
(8) utility.
 .SH FILES
 .TP
 .B /var/lib/nfs/nfsdcld/main.sqlite
 .SH SEE ALSO
=2D.BR nfsdcltrack "(8), " clddb-tool (8)
+.BR nfsdcltrack "(8), " nfsdclddb (8)
 .SH "AUTHORS"
 .IX Header "AUTHORS"
 The nfsdcld daemon was developed by Jeff Layton <jlayton@redhat.com>
=2D-=20
2.28.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl90IzIOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblGWQ//XEei3Ip23WvQLOcNxKql8379249UkLQY5m0D
vEvC6kaC/KfDn+Ri1EGvwg7jbAFtWo9PN/0IJ+QAveZIxD1ourdy8PIl5qS7JqhR
WIlee7d04dRIv6k1btd5BzcVIzE2vi7OZCItBT8SWUs0oFc7jwMsW7lB4XBfN30+
Y8KzSI56Fil/o6Cdrykya1vWbe8Uc/KSXe3lTHlWjME70Jpa4z/FPDNnpGLIMCIT
wTRA0yJ76bZA8+zayniHP8JToc0/5EifY4zc8C+oH68c+hKmNDTMSZSOystPKV+k
9aNiOT2jksQVVNWPhYfAB0ZiKF5q6+XiOxmwNnH1+cjgy8PjV7cWAKSmTLLNgbA2
DatkoW0nRg2ofm8ZcQhrXbccPenq57LW0KHCI30d1RyXfCUeyQW2zV9opi5u66dy
ylP3tSMyUQliNdOj7ImP3Lmntgy18BCHWxSrSNEFVCFVhyiUTknjvn31G8h5emtJ
tx31aHr1WP/48M5G5w9thqXeAkx9fGI/D7j9YgljJumwHnCygHumoXnpryDHg57L
vtaAKKMfAtDkZagJ8jB36a9fVHRLSAtybj96sQrFOLiuI5dZ6W6gtr984irlDdy5
xsJSZ5wZSHw1TVfQ4XA4j8Z3zU7IOZ1e10/Mp+yRxecQruCz7qfp+EmHttyhwx9S
grhsZD4=
=JiV1
-----END PGP SIGNATURE-----
--=-=-=--
