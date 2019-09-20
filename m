Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F09B8AF0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393039AbfITGPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 02:15:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393038AbfITGPc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Sep 2019 02:15:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2E2EAFF8;
        Fri, 20 Sep 2019 06:15:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Fri, 20 Sep 2019 16:15:19 +1000
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: handle drc over-allocation gracefully.
In-Reply-To: <20190919184139.GG26654@fieldses.org>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com> <1506345704-9486-3-git-send-email-bfields@redhat.com> <87d0fx9jph.fsf@notabene.neil.brown.name> <20190919162211.GA333@pick.fieldses.org> <20190919171730.GB333@pick.fieldses.org> <20190919184139.GG26654@fieldses.org>
Message-ID: <877e63a3yg.fsf@notabene.neil.brown.name>
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


Since commit de766e570413 ("nfsd: give out fewer session slots as
limit approaches") nfsd4_get_drc_mem() ensures 'avail' is always at
least 'slotsize', so the return value 'num' is always at least 1.

This means that:
1/ nfsd_drc_mem_used could exceed nfsd_drc_max_mem, which becomes
  a problem when we later perform an unsigned subtraction of
  the larger from the smaller to calculate 'total_avail'.
2/ Check the return value of nfsd4_get_drc_mem() against
  zero is pointless - the error code (which isn't actually correct
  according to RFC-5661) is never returned.

So avoid the integer overflow, and discard the check.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942c5ca6..8c09ac49fff2 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1570,11 +1570,21 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
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
 	 * unless it's the only way to give this client a slot:
+	 * Note that we always return at least 1 here, even if
+	 * we have exceeded nfsd_drc_max_mem.
 	 */
 	avail =3D clamp_t(unsigned long, avail, slotsize, total_avail/3);
 	num =3D min_t(int, num, avail / slotsize);
@@ -3169,10 +3179,10 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2EbngACgkQOeye3VZi
gbmJeQ//duOFh6IBpM1JNH4FvoXNs/ozvCKeUs21DReOR3P4jte/+kOhIyjLLeoM
vdoYuItNkirTLgVtajZoeftWIymdpePXbJndRLBPxF2H276dq6q9jzguVJUpK1jm
1UgQ2O3rxUdvK91jOzBC0SLwNbyezoIwpRDK8MEpdPZxD/XwqRAyWgdh8FtHdYH3
Mqd9Oox67Cz5voqC1PQqVpd1cdE/VxSjHssw7wVLH0sRyiFwIAYbLA41cC9fKB91
W9aQ1beib9Eky/hHseqwyG5gDWQ7Cy217JmIJ4i2ZoJqmyraY4y8KVGAuQkxvIYG
U/Cff4lekKUGdGqPmJrb4v4CJxybPL+hXASPIi2/p3DPDzAEiofFHWNkUwwyciL3
kD+iPcYaJKVnwZEEDrQGrBFlNaVBiQje+fPsuc5M2OwFXSf1CIWswH3GlTUgeabo
qK4xBiS/s1OKuFtRgxFWdj6YGV7OXdHivoiPkdIa13GKXcF/z0sEC1A3Zlt8TVq7
UPZP+ix54PW3oRaONp3FmQCN3jwX5ZP0oDApV+DXWoMXPAYLSzaZcTSz00rIyrYe
9Sh6529u/VxLwD1+ush6BNQJDXLolVMxzPhJ///uhQtUkWna7y/9Lrpw9zn00Ph3
1uCHOjnt6dYjLt8RSn4f538GkjsTfehVyqtG8bn5E+Ee57vdNe4=
=sOta
-----END PGP SIGNATURE-----
--=-=-=--
