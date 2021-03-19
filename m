Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8139E3428CA
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 23:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSWkS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 18:40:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhCSWj2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 18:39:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86BCBAC2E;
        Fri, 19 Mar 2021 22:39:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Sat, 20 Mar 2021 09:39:23 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] mountd/exportd: only log confirmed clients, and poll for
 updates
In-Reply-To: <87sg4rerta.fsf@notabene.neil.brown.name>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87sg4rerta.fsf@notabene.neil.brown.name>
Message-ID: <87eegaepk4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


It is possible (and common with the Linux NFS client) for the nfs server
to receive multiple SET_CLIENT_ID or EXCHANGE_ID requests when starting
a connection.  This results in some clients appearing in
 /proc/fs/nfsd/clients
which never get confirmed.  mountd currently logs these, but they aren't
really helpful.

If the kernel supports the reporting of the confirmation status of
clients, we can suppress the message until a client is confirmed.

With this patch we:
 - record if the client is confirmed, assuming it is if the status is
    not reported
 - don't log unconfirmed clients
 - request MODIFY notification from unconfirmed clients.
 - recheck an info file when it is modified.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 support/export/v4clients.c | 86 +++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/support/export/v4clients.c b/support/export/v4clients.c
index 056ddc9b065d..f2c9bb482ba7 100644
=2D-- a/support/export/v4clients.c
+++ b/support/export/v4clients.c
@@ -48,12 +48,15 @@ void v4clients_set_fds(fd_set *fdset)
 }
=20
 static void *tree_root;
+static int have_unconfirmed;
=20
 struct ent {
 	unsigned long num;
 	char *clientid;
 	char *addr;
 	int vers;
+	int unconfirmed;
+	int wid;
 };
=20
 static int ent_cmp(const void *av, const void *bv)
@@ -89,15 +92,14 @@ static char *dup_line(char *line)
 	return ret;
 }
=20
=2Dstatic void add_id(int id)
+static void read_info(struct ent *key)
 {
 	char buf[2048];
=2D	struct ent **ent;
=2D	struct ent *key;
 	char *path;
+	int was_unconfirmed =3D key->unconfirmed;
 	FILE *f;
=20
=2D	if (asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id) < 0)
+	if (asprintf(&path, "/proc/fs/nfsd/clients/%lu/info", key->num) < 0)
 		return;
=20
 	f =3D fopen(path, "r");
@@ -105,35 +107,64 @@ static void add_id(int id)
 		free(path);
 		return;
 	}
=2D	key =3D calloc(1, sizeof(*key));
=2D	if (!key) {
=2D		fclose(f);
=2D		free(path);
=2D		return;
=2D	}
=2D	key->num =3D id;
+	if (key->wid < 0)
+		key->wid =3D inotify_add_watch(clients_fd, path, IN_MODIFY);
+
 	while (fgets(buf, sizeof(buf), f)) {
=2D		if (strncmp(buf, "clientid: ", 10) =3D=3D 0)
+		if (strncmp(buf, "clientid: ", 10) =3D=3D 0) {
+			free(key->clientid);
 			key->clientid =3D dup_line(buf+10);
=2D		if (strncmp(buf, "address: ", 9) =3D=3D 0)
+		}
+		if (strncmp(buf, "address: ", 9) =3D=3D 0) {
+			free(key->addr);
 			key->addr =3D dup_line(buf+9);
+		}
 		if (strncmp(buf, "minor version: ", 15) =3D=3D 0)
 			key->vers =3D atoi(buf+15);
+		if (strncmp(buf, "status: ", 8) =3D=3D 0 &&
+		    strstr(buf, " unconfirmed") !=3D NULL) {
+			key->unconfirmed =3D 1;
+			have_unconfirmed =3D 1;
+		}
+		if (strncmp(buf, "status: ", 8) =3D=3D 0 &&
+		    strstr(buf, " confirmed") !=3D NULL)
+			key->unconfirmed =3D 0;
 	}
 	fclose(f);
 	free(path);
=20
=2D	xlog(L_NOTICE, "v4.%d client attached: %s from %s",
=2D	     key->vers, key->clientid, key->addr);
+	if (was_unconfirmed && !key->unconfirmed)
+		xlog(L_NOTICE, "v4.%d client attached: %s from %s",
+		     key->vers, key->clientid ?: "-none-",
+		     key->addr ?: "-none-");
+	if (!key->unconfirmed && ent->wid >=3D 0) {
+		inotify_rm_watch(clients_fd, ent->wid);
+		ent->wid =3D -1;
+	}
+}
+
+static void add_id(int id)
+{
+	struct ent **ent;
+	struct ent *key;
+
+	key =3D calloc(1, sizeof(*key));
+	if (!key) {
+		return;
+	}
+	key->num =3D id;
+	key->wid =3D -1;
=20
 	ent =3D tsearch(key, &tree_root, ent_cmp);
=20
 	if (!ent || *ent !=3D key)
 		/* Already existed, or insertion failed */
 		free_ent(key);
+	else
+		read_info(key);
 }
=20
=2Dstatic void del_id(int id)
+static void del_id(unsigned long id)
 {
 	struct ent key =3D {.num =3D id};
 	struct ent **e, *ent;
@@ -143,11 +174,27 @@ static void del_id(int id)
 		return;
 	ent =3D *e;
 	tdelete(ent, &tree_root, ent_cmp);
=2D	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
=2D	     ent->vers, ent->clientid, ent->addr);
+	if (!ent->unconfirmed)
+		xlog(L_NOTICE, "v4.%d client detached: %s from %s",
+		     ent->vers, ent->clientid, ent->addr);
+	if (ent->wid >=3D 0)
+		inotify_rm_watch(clients_fd, ent->wid);
 	free_ent(ent);
 }
=20
+static void check_id(unsigned long id)
+{
+	struct ent key =3D {.num =3D id};
+	struct ent **e, *ent;
+
+	e =3D tfind(&key, &tree_root, ent_cmp);
+	if (!e || !*e)
+		return;
+	ent =3D *e;
+	if (ent->unconfirmed)
+		read_info(ent);
+}
+
 int v4clients_process(fd_set *fdset)
 {
 	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event)))=
);
@@ -172,8 +219,9 @@ int v4clients_process(fd_set *fdset)
 				add_id(id);
 			if (ev->mask & IN_DELETE)
 				del_id(id);
+			if (ev->mask & IN_MODIFY)
+				check_id(id);
 		}
 	}
 	return 1;
 }
=2D
=2D-=20
2.30.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBVKBsOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbldlg//erpCcH8fQbANFVarejGV8kVKC9t+n6WWQBkI
GbaeyHuPiOXXGTN/J44GnBAkGfwbDuPItEt7TztQ19JXsA7q0mb7FkcEulvhtQfP
hoOWngU4bQNV2Xlqz9tFfJuS39ScI9u41rx4TUq7QFDoGubHKcs45ZnmvCG2Bwql
cZWFzMku0HdKydCCVbugdTckORFD5XVsJ3JyJO8veiZYEHBPqjnOYpmRS83miC7H
OEmHvQFJM+vDh/1k/rTecUbTr5HR5o8nPLkZ5wL0IwZ6jIsuIPIDXU6JGXwxdXgz
hHQFCgQ2Y5G9VnegQ0N3QBnfYl8lTg4zpCLEwLuKyzoRJ334RjM0uHiimt4uxhxk
DOATIMlBpfr/b5A+SUNV0qt9fc/rrCL5UUBk0W8n4sgntq2cdLKK6y/2YIfOTyu8
L5g0r6jmGcoPOYk0rEhGX37ZtmixDXf+CThkwom1N+8YmdvMhRDNnwUvkymo+YVh
jr5enelmoIYMGvIzdRnpR7YhqA+vn+2I3m4BLxWM8Iey36VP0hEninIgbourBnCe
LDZ8RVPgJFaD0qpAbVGdJfA/638CuT8H1v8X1VSq3C0/tX5ABiwY64OKZ8FXJ5EO
pf1ihe3FT/eNvfADQNfpNPSCujrKBW2lxH21tdqOmrumRLyg3Ou2NosjwT0MSctl
M6VDP2k=
=XfGJ
-----END PGP SIGNATURE-----
--=-=-=--
