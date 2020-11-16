Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1042B3B93
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 04:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKPC7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Nov 2020 21:59:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgKPC7H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Nov 2020 21:59:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F2DDABDE;
        Mon, 16 Nov 2020 02:59:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 16 Nov 2020 13:59:00 +1100
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
Message-ID: <87361aovm3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Prior to commit 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
and error from nfs_lookup_verify_inode() other than -ESTALE would result
in nfs_lookup_revalidate() returning that error code (-ESTALE is mapped
to zero).
Since that commit, all errors result in zero being returned.

When nfs_lookup_revalidate() returns zero, the dentry is invalidated
and, significantly, if the dentry is a directory that is mounted on,
that mountpoint is lost.

If you:
 - mount an NFS filesystem which contains a directory
 - mount something (e.g. tmpfs) on that directory
 - use iptables (or scissors) to block traffic to the server
 - ls -l the-mounted-on-directory
 - interrupt the 'ls -l'
you will find that the directory has been unmounted.

This can be fixed by returning the actual error code from
nfs_lookup_verify_inode() rather then zero (except for -ESTALE).

Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cb52db9a0cfb..d24acf556e9e 100644
=2D-- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1350,7 +1350,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct de=
ntry *dentry,
 			 unsigned int flags)
 {
 	struct inode *inode;
=2D	int error;
+	int error =3D 0;
=20
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode =3D d_inode(dentry);
@@ -1372,8 +1372,10 @@ nfs_do_lookup_revalidate(struct inode *dir, struct d=
entry *dentry,
 	    nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU)) {
 		error =3D nfs_lookup_verify_inode(inode, flags);
 		if (error) {
=2D			if (error =3D=3D -ESTALE)
+			if (error =3D=3D -ESTALE) {
 				nfs_zap_caches(dir);
+				error =3D 0;
+			}
 			goto out_bad;
 		}
 		nfs_advise_use_readdirplus(dir);
@@ -1395,7 +1397,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct de=
ntry *dentry,
 out_bad:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
=2D	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
+	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
=20
 static int
=2D-=20
2.29.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+x6vQOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkHHA/6ArBmbcJgnubaMOQu+U5qI40yP8NwiLUOLbbC
8tzWBA1lQoIm6ww98VmxD43iSgmAtqA9tz5Ln3fhEVnypznjnmDOp5TI5cFERXTQ
mR8U8OjBPAM6zMxpX43yGcZYjod0aKqstyIwGb49AieuyWuV3RRE+j7NFiVw0sZu
i15CExoEYH5Z3OVqUSdhY4C2LSQj+JLJOEUqGeJ1t+qaMQ7liT0TMUlGNCMYPCKt
kMn3/ApPQjH73sJnX+YDCl9DAHiHn7BGTp3VxjtxaYEEaZqdbQSgY1m7WErQKCdm
RaLN0ydwGHmgknWLBIzpFtnoP7FBIs4xAPDUHJfnT4UhRHzx1KT/9lDJxmN2aZ0R
btyn4osJzMp1iLcOctKNpkog0Vvin6QjAMCqvqa5CadCO7OEMjEqFywMogoDzDzp
cx6MJvKtSSqk1Z018HgJbXcuijOfU6AGqj3wOpb/q0t5qascBmeqRdoaJg8yjNAo
hwF2Fi/OShobs9w/HCepLcHaxDD+vT4cAgv9YKdA8x/Ce52yeKZRSP1E28Nb+6zT
3rUcH4fpdUY8/rsaNWw0GKdUYD4h3HY/QNrg3t7Ga95xB4AStwTgtcQCncruR16y
nQZJMxV8JROUg5U0Qv7Xyd9K4yRkKv78EaDGo4xAI9BjOOoQqQ6TUSqq/xnbIfSj
B9IG7EM=
=7Ejm
-----END PGP SIGNATURE-----
--=-=-=--
