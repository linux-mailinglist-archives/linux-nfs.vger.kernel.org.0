Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2C10C2C7
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2019 04:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK1DNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Nov 2019 22:13:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:36718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbfK1DNs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 27 Nov 2019 22:13:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81B1CAF11;
        Thu, 28 Nov 2019 02:56:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Thu, 28 Nov 2019 13:56:43 +1100
Subject: [PATCH] nfsd: check for EBUSY from vfs_rmdir/vfs_unink.
cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <87imn4iu8k.fsf@notabene.neil.brown.name>
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


vfs_rmdir and vfs_unlink can return -EBUSY if the
target is a mountpoint.  This currently gets passed to
nfserrno() by nfsd_unlink(), and that results in a WARNing,
which is not user-friendly.

Possibly the best NFSv4 error is NFS4ERR_FILE_OPEN, because
there is a sense in which the object is currently in use
by some other task.  The Linux NFSv4 client will map this
back to EBUSY, which is an added benefit.

For NFSv3, the best we can do is probably NFS3ERR_ACCES, which isn't
true, but is not less true than the other options.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfsd.h |  3 ++-
 fs/nfsd/vfs.c  | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index af2947551e9c..57b93d95fa5c 100644
=2D-- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -280,7 +280,8 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_union_notsupp		cpu_to_be32(NFS4ERR_UNION_NOTSUPP)
 #define nfserr_offload_denied		cpu_to_be32(NFS4ERR_OFFLOAD_DENIED)
 #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
=2D#define nfserr_badlabel		cpu_to_be32(NFS4ERR_BADLABEL)
+#define nfserr_badlabel			cpu_to_be32(NFS4ERR_BADLABEL)
+#define nfserr_file_open		cpu_to_be32(NFS4ERR_FILE_OPEN)
=20
 /* error codes for internal use */
 /* if a request fails due to kmalloc failure, it gets dropped.
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bd0a385df3fc..fa2acb6a3b5c 100644
=2D-- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1809,7 +1809,17 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *f=
hp, int type,
 out_drop_write:
 	fh_drop_write(fhp);
 out_nfserr:
=2D	err =3D nfserrno(host_err);
+	if (host_err =3D=3D -EBUSY) {
+		/* name is mounted-on. There is no perfect
+		 * error status.
+		 */
+		if (nfsd_v4client(rqstp))
+			err =3D nfserr_file_open;
+		else
+			err =3D nfserr_acces;
+	} else {
+		err =3D nfserrno(host_err);
+	}
 out:
 	return err;
 }
=2D-=20
2.24.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl3fN2wACgkQOeye3VZi
gbmthg/9HCYi/tCc349PfEMxOMrkm4L8d4VsaDShNaj/XJG/8bXJVPu+ZX4PNs0b
VyR6Gd/Ih42gDZBevuOjjIyh5I8Hj+l0JFHwrNV8mCJbCXdPrR7cZYG6qKRs2X7i
PGfZI7pzSEHkBYqOD6UB3fhPdewG7d0yN6FlTskEqh39FWxUQjvjyZgoqwpx1nwc
mOmQ2v+1t6RXX/W/HczvQw5gYVq+r+Sl1KsfdIbwrZmXySYVEHXXmIEqU/bVTBJk
4FZ8It+8s1mx1dWrhZJ5nIRBxTKNAX+201OkUSOa5/qLk0XsZqoMALKgPVVvL4RE
gIHLHgLYQKkXqXKowkilbaZACeWoktFxPKtRZYGN0nATa/jr57dU+ryDoLihCSR1
l2KbW5pdeD9tGLbiPReZ93Y6YD+H2IDWGd2jW0C/CyIYGCHO3MWMQtn07zoRj+Yv
mb6wCydu4zoCXCcCfNdrhggVW+G0z/C02YLtp6m99TMNYAJRKoBUaHFlfd/5Yjde
HN/bqJB/YhyfaQHS3kaMlAj+5rrAs+4946pKK1ltTyBOzCZyKvSUa1PdiYuR7Aoe
4TxOWJaW6yF3AAeL0GO+KWEuXba9eK5NyLcgairQ2UX7Tf8PdMftXUhkoCqPPEeM
oAjIFvvD4uHe63knCt64OnWnWuEhraw6t0h92gY72Cxj1vYKR00=
=NRUj
-----END PGP SIGNATURE-----
--=-=-=--
