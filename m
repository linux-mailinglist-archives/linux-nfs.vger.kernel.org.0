Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB259B8B2B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 08:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394927AbfITGgw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 02:36:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394926AbfITGgw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Sep 2019 02:36:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0B5DABF6;
        Fri, 20 Sep 2019 06:36:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Fri, 20 Sep 2019 16:36:45 +1000
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH - 2/2] nfsd: degraded slot-count more gracefully as allocation nears
 exhaustion.
In-Reply-To: <8736gra34j.fsf@notabene.neil.brown.name>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com> <1506345704-9486-3-git-send-email-bfields@redhat.com> <87d0fx9jph.fsf@notabene.neil.brown.name> <20190919162211.GA333@pick.fieldses.org> <20190919171730.GB333@pick.fieldses.org> <20190919184139.GG26654@fieldses.org> <877e63a3yg.fsf@notabene.neil.brown.name> <8736gra34j.fsf@notabene.neil.brown.name>
Message-ID: <87zhiz8oea.fsf@notabene.neil.brown.name>
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


This original code in nfsd4_get_drc_mem() would hand out 30
slots (approximately NFSD_MAX_MEM_PER_SESSION bytes at slightly
over 2K per slot) to each requesting client until it ran out
of space, then it would possibly give one last client a reduced
allocation, then fail the allocation.

Since commit de766e570413 ("nfsd: give out fewer session slots as
limit approaches") the last 90 slots to be given to about 12
clients with quickly reducing slot counts (better than just 3
clients).  This still seems unnecessarily hasty.
A subsequent patch allows over-allocation so every client gets
at least one slot, but that might be a bit restrictive.

The requested number of nfsd threads is the best guide we have to the
expected number of clients, so use that - if it is at least 8.

256 threads on a 256Meg machine - which is a lot for a tiny machine -
would result in nfsd_drc_max_mem being 2Meg, so 8K (3 slots) would be
available for the first client, and over 200 clients would get more
than 1 slot.  So I don't think this change will be too debilitating on
poorly configured machines, though it does mean that a sensible
configuration is a little more important.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfs4state.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 084a30d77359..c49af2ba3924 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1563,11 +1563,12 @@ static inline u32 slot_bytes(struct nfsd4_channel_a=
ttrs *ca)
  * re-negotiate active sessions and reduce their slot usage to make
  * room for new connections. For now we just fail the create session.
  */
=2Dstatic u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
+static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_n=
et *nn)
 {
 	u32 slotsize =3D slot_bytes(ca);
 	u32 num =3D ca->maxreqs;
 	unsigned long avail, total_avail;
+	unsigned int scale_factor;
=20
 	spin_lock(&nfsd_drc_lock);
 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
@@ -1581,12 +1582,18 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca)
 		total_avail =3D 0;
 	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
 	/*
=2D	 * Never use more than a third of the remaining memory,
+	 * Never use more than a fraction of the remaining memory,
 	 * unless it's the only way to give this client a slot.
+	 * The chosen fraction is either 1/8 or 1/number of threads,
+	 * whichever is smaller.  This ensures there are adequate
+	 * slots to support multiple clients per thread.
 	 * Give the client one slot even that would require
 	 * over-allocation, it is better than failure.
 	 */
=2D	avail =3D clamp_t(unsigned long, avail, slotsize, total_avail/3);
+	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
+
+	avail =3D clamp_t(unsigned long, avail, slotsize,
+			total_avail/scale_factor);
 	num =3D min_t(int, num, avail / slotsize);
 	num =3D max_t(int, num, 1);
 	nfsd_drc_mem_used +=3D num * slotsize;
@@ -3183,7 +3190,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_ch=
annel_attrs *ca, struct nfs
 	 * Note that we always allow at least one slot, because our
 	 * accounting is soft and provides no guarantees either way.
 	 */
=2D	ca->maxreqs =3D nfsd4_get_drc_mem(ca);
+	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
=20
 	return nfs_ok;
 }
=2D-=20
2.23.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2Ec30ACgkQOeye3VZi
gbnjwRAAhe6NrQ821TI8RiBUWrFeZcvIUg3atw70i/EYvIOcMqr2ZSK4uPiRLWOR
1CCZFBDXvbVUurL9QtUsCFNqrTB0iR/K55RXN1MORDNOsK6WjVhU3K57Nk71/OG5
Es9D6oQ/QcMLnq5Ie9yF3yjzVVYZsdwgz/+tcAurAutPhi7gz87rHqLpjONA5tUn
1sm57A54ve+EKcIx2B+hGbs8aUs206m5+4L1cidtMWfhkjHQ4CpvWHerNAJBToFj
A3JyhkzpG3bi4XkdydPCv43BnPOdHOncGh8FEUtSRxIHyo943ElR9L+/SMY89FNk
cWUaIplW15hgV8NNtLj+aGa0jPcV840L77M90wMkn5EOPXAjWa+aU2vCEEYh+SLU
bDAmnceIYJlXUkANnoEjpJp8T7ECcyEQmdMCD9GA41rQByQ2/1KislYX+w94up/N
jvBO6sAcUrhyVqw3DD2mQnhwlmgwCxT7QhGzGFLzj+uyqH7rdpaavMuGpgQ4yAnl
gPRRedu03xbgEp6h5L6ptjwzfxw2Vz3lMvUF674JObGCjXNdaUpluxbij9EHOQgA
G8jJ4v7M8bC4trK768GCxUPMIfdC/6sD6kS0T5i6cbndoZ/5K60LJoHbJg3vfGsk
tafHG9lEqTm+zJVxRIJsbHEdc2SQv5qEml+rlgNLtaBR6zLrNKY=
=xdvL
-----END PGP SIGNATURE-----
--=-=-=--
