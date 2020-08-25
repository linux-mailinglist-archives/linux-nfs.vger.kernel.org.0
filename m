Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4425232E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYVyb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Aug 2020 17:54:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYVya (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 Aug 2020 17:54:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A508B165;
        Tue, 25 Aug 2020 21:55:00 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Steve Dickson <SteveD@redhat.com>
Date:   Wed, 26 Aug 2020 07:54:22 +1000
Subject: [PATCH nfs-utils] Convert remaining python scripts to python3
cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <87zh6iqtm9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


nfs-utils contains 4 python scripts, two request
 /usr/bin/python3
in their shebang line, two request
 /usr/bin/python

Those latter two run perfectly well with python3 and as python2 is on the
way out, change them so they requrest /usr/bin/python3.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 tools/mountstats/mountstats.py | 2 +-
 tools/nfs-iostat/nfs-iostat.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 1054f698c8e3..00adc96bafeb 100755
=2D-- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -1,4 +1,4 @@
=2D#!/usr/bin/python
+#!/usr/bin/python3
 # -*- python-mode -*-
 """Parse /proc/self/mountstats and display it in human readable form
 """
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 5556f692b7ee..6e59837ee673 100755
=2D-- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -1,4 +1,4 @@
=2D#!/usr/bin/python
+#!/usr/bin/python3
 # -*- python-mode -*-
 """Emulate iostat for NFS mount points using /proc/self/mountstats
 """
=2D-=20
2.28.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl9FiI4ACgkQOeye3VZi
gbkuaw//ThjizsyC2tK/XOuA2aPAm/F5BIYdM7sLEp1V/+r+X+4OgNUQDPu8O7xo
fUvWqAy3DR2mOBQLBY42mcNEiTy8S0ZpAlaRZhu3S/3OXxZ92pNkS2DjbYGJbnam
OXb1WoZvBskhjyY1kxxS8d57rc7zpDgbMmTKq4e4oc3804y3QYz3h/hAr/4KSPRL
qWiqnPVYNrWSd7amUBpdA7njQkT02TayQdF9n9BM1mpVBTTJG8mFwapgg9NDaC1A
17sZoO0hR24wQIlq+kK0212eWsB10Gz0ZpD8ydalj24Lv0T4edR+xMxy/AQi/W24
rNsUrnSOCkGDYwsdLHARWefehc7ElLBS1a24xr/chbVa7p+PkvuSbmFwxfNchl6W
2431hl5DuYcsTbl6md9Rcd0p0dxqF1IEizS8b4QJhizoj7uPBofKqO8k5TCXc6s9
R075+YDfGqA2/PbirqhtHTMNVmmR+FT7srbOQ6ZKBD05zP9dU2Lv6odZnLZtn9FU
ObmvX8u+2euLDQ17qL0AnyyNeYQfmNMFe1LL2aGGDY5JRsnfx/ktIOvubb1T8Sz0
/AvsoHWJH9N3jWtBuTO5rIJggF1YzAPg9BK7OY12GACON6iiCXIJl6/4LaTRAqf3
RQxkTLOJfXcJl1mRrYjq0LMv6LkquXgnUsFss7yXNN4Lfx4y01c=
=3dwc
-----END PGP SIGNATURE-----
--=-=-=--
