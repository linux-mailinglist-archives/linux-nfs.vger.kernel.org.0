Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9FE34138B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 04:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhCSDif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 23:38:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCSDib (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 23:38:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B86CFAC1F;
        Fri, 19 Mar 2021 03:38:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 19 Mar 2021 14:38:25 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mountd/exportd: only log confirmed clients, and poll for
 updates
In-Reply-To: <87v99neruh.fsf@notabene.neil.brown.name>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
Message-ID: <87sg4rerta.fsf@notabene.neil.brown.name>
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
 - check all unconfirmed clients each time any event is processed,
 - if there are unconfirmed clients, we request a wakeup after a
   exponentially decreasing time, and check again

This requires updating the two event loops to allow a timeout to be
specified.

When there is no other activity, but there are unconfirmed clients,
timeout for repeat checks are after 1, 2, 4 ... 512 seconds.
If any wait is interrupted, the next wait time is still chosen, so we
might advance quickly through the list.  But if there is lots of
activity, we don't really need the timeout.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 support/export/cache.c     |  7 ++-
 support/export/export.h    |  2 +-
 support/export/v4clients.c | 92 ++++++++++++++++++++++++++++++--------
 utils/mountd/svc_run.c     |  7 ++-
 4 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 3e4f53c0a32e..687b3aef27a1 100644
=2D-- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1524,6 +1524,7 @@ void cache_process_loop(void)
 {
 	fd_set	readfds;
 	int	selret;
+	struct timeval tv =3D { 60*60, 0 };
=20
 	FD_ZERO(&readfds);
=20
@@ -1533,8 +1534,10 @@ void cache_process_loop(void)
 		v4clients_set_fds(&readfds);
=20
 		selret =3D select(FD_SETSIZE, &readfds,
=2D				(void *) 0, (void *) 0, (struct timeval *) 0);
+				(void *) 0, (void *) 0, &tv);
=20
+		tv.tv_sec =3D 60*60;
+		tv.tv_usec =3D 0;
=20
 		switch (selret) {
 		case -1:
@@ -1546,7 +1549,7 @@ void cache_process_loop(void)
=20
 		default:
 			cache_process_req(&readfds);
=2D			v4clients_process(&readfds);
+			v4clients_process(&readfds, &tv);
 		}
 	}
 }
diff --git a/support/export/export.h b/support/export/export.h
index 8d5a0d3004ef..71d3ed39bd28 100644
=2D-- a/support/export/export.h
+++ b/support/export/export.h
@@ -24,7 +24,7 @@ void		cache_process_loop(void);
=20
 void		v4clients_init(void);
 void		v4clients_set_fds(fd_set *fdset);
=2Dint		v4clients_process(fd_set *fdset);
+int		v4clients_process(fd_set *fdset, struct timeval *tv);
=20
 struct nfs_fh_len *
 		cache_get_filehandle(nfs_export *exp, int len, char *p);
diff --git a/support/export/v4clients.c b/support/export/v4clients.c
index 056ddc9b065d..04cec3136876 100644
=2D-- a/support/export/v4clients.c
+++ b/support/export/v4clients.c
@@ -48,12 +48,15 @@ void v4clients_set_fds(fd_set *fdset)
 }
=20
 static void *tree_root;
+static int have_unconfirmed;
+static time_t unconfirmed_wait =3D 1;
=20
 struct ent {
 	unsigned long num;
 	char *clientid;
 	char *addr;
 	int vers;
+	int unconfirmed;
 };
=20
 static int ent_cmp(const void *av, const void *bv)
@@ -89,15 +92,13 @@ static char *dup_line(char *line)
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
 	FILE *f;
=20
=2D	if (asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id) < 0)
+	if (asprintf(&path, "/proc/fs/nfsd/clients/%lu/info", key->num) < 0)
 		return;
=20
 	f =3D fopen(path, "r");
@@ -105,32 +106,56 @@ static void add_id(int id)
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
+	if (!key->unconfirmed)
+		xlog(L_NOTICE, "v4.%d client attached: %s from %s",
+		     key->vers, key->clientid ?: "-none-",
+		     key->addr ?: "-none-");
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
=20
 	ent =3D tsearch(key, &tree_root, ent_cmp);
=20
 	if (!ent || *ent !=3D key)
 		/* Already existed, or insertion failed */
 		free_ent(key);
+	else {
+		read_info(key);
+		if (key->unconfirmed)
+			unconfirmed_wait =3D 1;
+	}
 }
=20
 static void del_id(int id)
@@ -143,18 +168,43 @@ static void del_id(int id)
 		return;
 	ent =3D *e;
 	tdelete(ent, &tree_root, ent_cmp);
=2D	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
=2D	     ent->vers, ent->clientid, ent->addr);
+	if (!ent->unconfirmed)
+		xlog(L_NOTICE, "v4.%d client detached: %s from %s",
+		     ent->vers, ent->clientid, ent->addr);
 	free_ent(ent);
 }
=20
=2Dint v4clients_process(fd_set *fdset)
+static void check_one(const void *ventp, VISIT which, int depth)
+{
+	struct ent * const *ep =3D ventp;
+	struct ent *ent;
+
+	if (depth >=3D 0 && /* Silence "unused paramter" warning */
+	    which !=3D preorder && which !=3D leaf)
+		return;
+
+	ent =3D *ep;
+	if (ent->unconfirmed)
+		read_info(ent);
+}
+
+static void check_unconfirmed(void)
+{
+	if (!have_unconfirmed)
+		return;
+	have_unconfirmed =3D 0;
+	twalk(tree_root, check_one);
+}
+
+int v4clients_process(fd_set *fdset, struct timeval *tv)
 {
 	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event)))=
);
 	const struct inotify_event *ev;
 	ssize_t len;
 	char *ptr;
=20
+	check_unconfirmed();
+
 	if (clients_fd < 0 ||
 	    !FD_ISSET(clients_fd, fdset))
 		return 0;
@@ -174,6 +224,12 @@ int v4clients_process(fd_set *fdset)
 				del_id(id);
 		}
 	}
+	if (have_unconfirmed && tv->tv_sec > unconfirmed_wait) {
+		tv->tv_sec =3D unconfirmed_wait;
+		tv->tv_usec =3D 0;
+		if (unconfirmed_wait < 300)
+			unconfirmed_wait <<=3D 1;
+	}
 	return 1;
 }
=20
diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
index 167b9757bde2..042bed8957b9 100644
=2D-- a/utils/mountd/svc_run.c
+++ b/utils/mountd/svc_run.c
@@ -95,6 +95,7 @@ my_svc_run(void)
 {
 	fd_set	readfds;
 	int	selret;
+	struct timeval tv =3D { 60*60, 0 };
=20
 	for (;;) {
=20
@@ -103,8 +104,10 @@ my_svc_run(void)
 		v4clients_set_fds(&readfds);
=20
 		selret =3D select(FD_SETSIZE, &readfds,
=2D				(void *) 0, (void *) 0, (struct timeval *) 0);
+				(void *) 0, (void *) 0, &tv);
=20
+		tv.tv_sec =3D 60*60;
+		tv.tv_usec =3D 0;
=20
 		switch (selret) {
 		case -1:
@@ -116,7 +119,7 @@ my_svc_run(void)
=20
 		default:
 			selret -=3D cache_process_req(&readfds);
=2D			selret -=3D v4clients_process(&readfds);
+			selret -=3D v4clients_process(&readfds, &tv);
 			if (selret)
 				svc_getreqset(&readfds);
 		}
=2D-=20
2.30.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBUHLEOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblNTA//dVSvAY2a5OgpNH6NDBANjgKDTLjmzcKxK48G
qTp2jr2OmGpkF1DTE85qHsKAYoxcdwcP47hb7oMUWWBKENTNsiXI7wAJ4woQOMWd
uLmgZR0O3pOoy6LJrEWOj6x3TrALKiuZxkFD+9n4fLV4ODYDdKkQpVt2FO07l9kA
C7UAX/oln8MFBURDH49lymMBYNKZ8j4pi0W3w/09kjqsGVkzUgJt/y/+hUVyFXRD
5EvxK9yfpQcjp3ajJenXhSqJ5QaryV8EiQcFtZE/ZVGaQ/QkDkugHaAWIwofk09y
RHiFSECd9Ir9nd7Vp7Ad8MbzduWmvyZ0GOET2y3UW3q8bL8EM1fsGT/iQn+ZpGRb
DxEFe4rRTDiNaWReRS5eTxMRqvqk7c1JXyzBKwfgd9G66E/e/CqUpWvRxaLvg8q3
V6XPUirPeLl9Mbc/lFrT+NU3ncq7tHxjbiwld2pLfHhmxDOq7QXYlHWSJYmtpHba
o9BAmE66XKPf73WghmQsgspqng1wt3VmuC6gBmRQZVu7faKFNGxXl1BsQh1cOo05
g50UblphC8k2GJMBq0mKNF3cETAyiebtoV4t4fH5of2xPotXo15KXP+4aqJ3qm8v
jojIvI2n1oavx/uiWaqy5zTtJVRLmm67E6Ia/fSESbjSUaS2xcjXDUtprNoqy0ru
HgNhfeQ=
=Swh+
-----END PGP SIGNATURE-----
--=-=-=--
