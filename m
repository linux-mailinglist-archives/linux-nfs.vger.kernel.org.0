Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E49153AA5
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBEWE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 17:04:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:59466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEWE2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Feb 2020 17:04:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61CA9AFD4;
        Wed,  5 Feb 2020 22:04:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Thu, 06 Feb 2020 09:04:18 +1100
Subject: [PATCH nfs-utils] Allow compilation to succeed with -fno-common
cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <87ftfo8zdp.fsf@notabene.neil.brown.name>
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


When compiled with -fno-common, global variables that are declared
multple times cause an error.  With -fcommon (the default), they are
merged.

Declaring such variable multiple times is probably not a good idea, and
is definitely not necessary.

This patch changes all the global variables defined in include files to
be explicitly "extern", and where necessary, adds the variable
declaration to a suitable .c file.

To test, run
  CFLAGS=3D-fno-common ./configure
  make

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 utils/mountd/v4root.c        |  2 --
 utils/nfsdcld/cld-internal.h | 10 +++++-----
 utils/nfsdcld/nfsdcld.c      |  6 ++++++
 utils/statd/statd.c          |  1 +
 utils/statd/statd.h          |  2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index d735dbfe192d..dd9828eb0c11 100644
=2D-- a/utils/mountd/v4root.c
+++ b/utils/mountd/v4root.c
@@ -28,8 +28,6 @@
 #include "v4root.h"
 #include "pseudoflavors.h"
=20
=2Dint v4root_needed;
=2D
 static nfs_export pseudo_root =3D {
 	.m_next =3D NULL,
 	.m_client =3D NULL,
diff --git a/utils/nfsdcld/cld-internal.h b/utils/nfsdcld/cld-internal.h
index 05f01be2105a..cc283dae9dbf 100644
=2D-- a/utils/nfsdcld/cld-internal.h
+++ b/utils/nfsdcld/cld-internal.h
@@ -35,10 +35,10 @@ struct cld_client {
 	} cl_u;
 };
=20
=2Duint64_t current_epoch;
=2Duint64_t recovery_epoch;
=2Dint first_time;
=2Dint num_cltrack_records;
=2Dint num_legacy_records;
+extern uint64_t current_epoch;
+extern uint64_t recovery_epoch;
+extern int first_time;
+extern int num_cltrack_records;
+extern int num_legacy_records;
=20
 #endif /* _CLD_INTERNAL_H_ */
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index 2ad1001988d2..be6556262504 100644
=2D-- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -69,6 +69,12 @@ static int 		inotify_fd =3D -1;
 static struct event	pipedir_event;
 static bool old_kernel =3D false;
=20
+uint64_t current_epoch;
+uint64_t recovery_epoch;
+int first_time;
+int num_cltrack_records;
+int num_legacy_records;
+
 static struct option longopts[] =3D
 {
 	{ "help", 0, NULL, 'h' },
diff --git a/utils/statd/statd.c b/utils/statd/statd.c
index 8eef2ff24fe8..e4a1df43b73f 100644
=2D-- a/utils/statd/statd.c
+++ b/utils/statd/statd.c
@@ -67,6 +67,7 @@ static struct option longopts[] =3D
 };
=20
 extern void sm_prog_1 (struct svc_req *, register SVCXPRT *);
+stat_chge	SM_stat_chge;
=20
 #ifdef SIMULATIONS
 extern void simulator (int, char **);
diff --git a/utils/statd/statd.h b/utils/statd/statd.h
index 231ac7e0764b..bb1fecbb6a51 100644
=2D-- a/utils/statd/statd.h
+++ b/utils/statd/statd.h
@@ -41,7 +41,7 @@ extern void	load_state(void);
 /*
  * Host status structure and macros.
  */
=2Dstat_chge		SM_stat_chge;
+extern stat_chge	SM_stat_chge;
 #define MY_NAME		SM_stat_chge.mon_name
 #define MY_STATE	SM_stat_chge.state
=20
=2D-=20
2.24.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl47O+MACgkQOeye3VZi
gbkUfA/+IX1v+uQ+tfqEZswer62r0r36/cuL+njw4Fc9/s0+BOPlkLhsJ7tVaM3F
KDMH07dS7gpLAlYH2v0Rm6Lo+7c2Gla4d1B1bXnRJy3jyA4uWsb7dpanvOv7Q45g
GqIe1YdXK/EY3ULe5qPdKXySK2WQH9nYfvHIoEA08aMqFYW+s9I6CWX8q0WLVGMG
0GD4zFZd5b5igJBjjavCl9PRkdILJpVKlOjonIOyFP1lFdD9MhFdbmpGsoIs4Ug6
mtdvVKcGcxn9nhszarYGKZw8ZiaOmQYqrqwzniqkvFpcnL4L50EWGv7eh8SUdBUs
tRKXST/7Btu3MQ/bQMvdpnk1L8ekcuvPl5LTIgV3TFg/UEOSg61bGAgbVU+ZT1DZ
RQngxgVmgZDyNfimQp5fvaXx5yv32wcnTYvOE2vnYtnHnDnc8YfcP2KzpG/LEzPv
j5h+ouaLbXuvMc2PMLayFuKKIEG0tih8mOZtdtoT5D2w4JZurdPKjjl5y5vYg1al
gEEOp0FVzPJpHvewHXYe5UahAQu+7/dv9GLnRaJ9hoE3cB7LYIuifedW5ZDC8pyN
oVAmbcTkismh6VGGseXyPb7gihNUvZCtPEU/oVhgfageXnzE4T2sjFdypGK13swF
pp0e4YAkUn/KZKMGfKRa5mKJonAwjZjDxQclBF0ret8607cyqtM=
=+ffx
-----END PGP SIGNATURE-----
--=-=-=--
