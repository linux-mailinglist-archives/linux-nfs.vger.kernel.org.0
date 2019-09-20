Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96CB8B11
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfITGdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 02:33:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387829AbfITGdZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Sep 2019 02:33:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9AA5ADD9;
        Fri, 20 Sep 2019 06:33:22 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Fri, 20 Sep 2019 16:33:16 +1000
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2 - vers2] nfsd: handle drc over-allocation gracefully.
In-Reply-To: <877e63a3yg.fsf@notabene.neil.brown.name>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com> <1506345704-9486-3-git-send-email-bfields@redhat.com> <87d0fx9jph.fsf@notabene.neil.brown.name> <20190919162211.GA333@pick.fieldses.org> <20190919171730.GB333@pick.fieldses.org> <20190919184139.GG26654@fieldses.org> <877e63a3yg.fsf@notabene.neil.brown.name>
Message-ID: <8736gra34j.fsf@notabene.neil.brown.name>
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


Currently, if there are more clients than allowed for by the
space allocation in set_max_drc(), we fail a SESSION_CREATE
request with NFS4ERR_DELAY.
This means that the client retries indefinitely, which isn't
a user-friendly response.

The RFC requires NFS4ERR_NOSPC, but that would at best result in a
clean failure on the client, which is not much more friendly.

The current space allocation is a best-guess and doesn't provide any
guarantees, we could still run out of space when trying to allocate
drc space.

So fail more gracefully - always give out at least one slot.
If all clients used all the space in all slots, we might start getting
memory pressure, but that is possible anyway.

So ensure 'num' is always at least 1, and remove the test for it
being zero.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfs4state.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Sorry, but I was confused about clamp_t().
If the 'max' is smaller than the 'min', then the 'max' wins, so
'avail' will never be more than total_avail/3.
I might have believed the comment here instead of the code there.

So the current code cannot overflow, but I think we agree that
failure is not good.  So this patch avoids failure.
NeilBrown


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942c5ca6..084a30d77359 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1570,14 +1570,25 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca)
 	unsigned long avail, total_avail;
=20
 	spin_lock(&nfsd_drc_lock);
=2D	total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
+	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
+		total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
+	else
+		/* We have handed out more space than we chose in
+		 * set_max_drc() to allow.  That isn't really a
+		 * problem as long as that doesn't make us thing we
+		 * have lots more due to integer overflow.
+		 */
+		total_avail =3D 0;
 	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
 	/*
 	 * Never use more than a third of the remaining memory,
=2D	 * unless it's the only way to give this client a slot:
+	 * unless it's the only way to give this client a slot.
+	 * Give the client one slot even that would require
+	 * over-allocation, it is better than failure.
 	 */
 	avail =3D clamp_t(unsigned long, avail, slotsize, total_avail/3);
 	num =3D min_t(int, num, avail / slotsize);
+	num =3D max_t(int, num, 1);
 	nfsd_drc_mem_used +=3D num * slotsize;
 	spin_unlock(&nfsd_drc_lock);
=20
@@ -3169,10 +3180,10 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
 	 * performance.  When short on memory we therefore prefer to
 	 * decrease number of slots instead of their size.  Clients that
 	 * request larger slots than they need will get poor results:
+	 * Note that we always allow at least one slot, because our
+	 * accounting is soft and provides no guarantees either way.
 	 */
 	ca->maxreqs =3D nfsd4_get_drc_mem(ca);
=2D	if (!ca->maxreqs)
=2D		return nfserr_jukebox;
=20
 	return nfs_ok;
 }
=2D-=20
2.23.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2Ecq0ACgkQOeye3VZi
gbmglw/9G4r7T2Tp5ctCpzBdsCjTXc9iBa6n5SbbxFtkXDFkjhNYGb0ZLjgcvLSV
hWU/+1O+FS11h1156kDnBIxjomp+mJ7kBYdaC8xHKF+LyS2lfk3F/oGGBsRINxr/
9kLenNLryuEoEwpQPAOZjB2PxqpMK6podgb4+pThGCk3UFp6RCadKx8wxXETQHxf
yo2pN3/nObPEq6wMFG4XGwHMMj5KQ7vTf9OLnjgoaJzHnZFeb20TjctJ222PvwOO
d0OKeF7ny82RXsKEfl1IW4HIkB9nGuzHm6gt3huMqoIJzi3Im9qnjfBb9Nz82bQb
gxGzLwepEHAb+bfycKdm9FLk/a+hoX78eR40JR7/jlVISmpwVO2OoU08/0KxbpGj
jSsuEKHrmYwkZCjate3L4Hdmkvjtr1keSZ6zCR6uFgHhVRuynF1lDcaqpBZabOJ/
GB9K8FDwyxkGnLfoiaOhee2AZmMiUisJ8A1OowiQpU0PNzmaxTii4LSlnUZI0fqd
bCfpZsxfzykleU5pHGM3rRnLqoLQqIBEnSjnDJaMceZzImRIKXaNXrD4SQAVXpkb
vCG0F//wRlfTRTFZE06Z+m31b3oSbvHLjtPDPx/TT4pmMB8j6nkMrmT+n/DZ+bSD
kiGXB2IyUid/MkgCZWjY+uFoBVhNEmwNgxDsondXAEnavyKWCwo=
=7WWd
-----END PGP SIGNATURE-----
--=-=-=--
