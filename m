Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5480BB7055
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 03:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfISBIU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 21:08:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfISBIU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Sep 2019 21:08:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07114AC31;
        Thu, 19 Sep 2019 01:08:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Date:   Thu, 19 Sep 2019 11:08:10 +1000
Subject: Re: [PATCH 2/2] nfsd: give out fewer session slots as limit approaches
In-Reply-To: <1506345704-9486-3-git-send-email-bfields@redhat.com>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com> <1506345704-9486-3-git-send-email-bfields@redhat.com>
Message-ID: <87d0fx9jph.fsf@notabene.neil.brown.name>
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

On Mon, Sep 25 2017, J. Bruce Fields wrote:

> From: "J. Bruce Fields" <bfields@redhat.com>
>
> Instead of granting client's full requests until we hit our DRC size
> limit and then failing CREATE_SESSIONs (and hence mounts) completely,
> start granting clients smaller slot tables as we approach the limit.
>
> The factor chosen here is pretty much arbitrary.

Hi Bruce....
 I've been looking at this patch - and the various add-ons that fix it :-(
 There seems to be another problem though.
 Prior to this patch, avail would never exceed
    nfsd_drc_max_mem - nfsd_drc_mem_used
 since this patch, avail will never be less than slotsize, so it could
 exceed the above.
 This means that 'num' will never be less than 1 (i.e. never zero).
 num * slotsize might exceed
    nfsd_drc_max_mem - nfsd_drc_mem_used
 and then nfsd_drc_mem_used would exceed nfsd_drc_max_mem

 When that happens, the next call to nfsd4_get_drc_mem() will evaluate

	total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;

 which will be very large (unsigned long) indeed.  Maybe not the intention.

 I would have sent a patch to fix this, except that it bothers me that
 nfsd4_get_drc_mem() could ever return 0 (it cannot at the moment, but
 would after a "fix").  That would result in check_forechannel_attrs()
 returning nfserr_jukebox, and the client retrying indefinitely (which
 is exactly the symptom I have reported by a customer with a 4.12
 kernel).
 This isn't nice behaviour.

 Given that the server makes no attempt to reclaim slot memory for
 clients, would NFS4ERR_RESOURCE be a better error here?

 Also, I'd like to suggest that the '1/3' heuristic be change to 1/16.
 Assuming 30 slots get handed out normally (which my testing shows -
 about 2k each, with an upper limit of 64k):
   When 90 slots left, we hand out
    30 (now 60 left)
    20 (now 40 left)
    13 (now 27 left)
     9 (now 18 left)
     6 (now 12 left)
     4 (now 8 left)
     2 (now 6 left)
     2 (now 4 left)
     1
     1
     1
     1
 which is a rapid decline as clients are added.
 With 16, we hand out 30 at a time until 480 slots are left (30Meg)
 then: 30 28 26 24 23 21 20 19 18 6 15 15 14 13 12 11 10 10 9 9 8 8 7 7
    6 6 5 5 5 5 4 4 4 3 3 3 3 3 3 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1
    1 1
 slots per session

 Am I convincing?

To make it more concrete: this is what I'm thinking of.  Which bits do
you like?

Thanks,
NeilBrown

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942c5ca6..5d11ceaee998 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1573,11 +1573,15 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca)
 	total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
 	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
 	/*
=2D	 * Never use more than a third of the remaining memory,
+	 * Never use more than a 1/16 of the remaining memory,
 	 * unless it's the only way to give this client a slot:
 	 */
=2D	avail =3D clamp_t(unsigned long, avail, slotsize, total_avail/3);
+	avail =3D clamp_t(unsigned long, avail, slotsize, total_avail/16);
 	num =3D min_t(int, num, avail / slotsize);
+	if (nfsd_drc_mem_used + num * slotsize > nfsd_drc_max_mem)
+		/* Completely out of space - sorry */
+		num =3D 0;
+
 	nfsd_drc_mem_used +=3D num * slotsize;
 	spin_unlock(&nfsd_drc_lock);
=20
@@ -3172,7 +3176,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_ch=
annel_attrs *ca, struct nfs
 	 */
 	ca->maxreqs =3D nfsd4_get_drc_mem(ca);
 	if (!ca->maxreqs)
=2D		return nfserr_jukebox;
+		return nfserr_resource;
=20
 	return nfs_ok;
 }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2C1PsACgkQOeye3VZi
gblz4g//dVzoLD+R92bYp+s28+K1LjFLNcNjUiqYf6IRThpwWkn1Kwmk2eNhg1aJ
+r7hndV9mxML2SCNv/U2ARfG7xVdtoryu8uAds8swnUhk6QRBsWYNPjyByw+tyvC
z3EIvtJQdDRyHP7YeJtYgYDsWQFO8394kz24M1/HiJJcM/aCOv0ZZ+dW/7uhWwUC
CI9YGKaVQlEuHce/L4csQTqrsBbjXVfssnPOqUEjNa8IQD38KIvv/m0n9lz0Zeot
It6mWoD+QE6XqZJBUVn2po6Du0v9AEmBXZNZZRJl5bnzYzbbwLEaJacqYzqoMkc5
7v+WOHcwV9vD83ym/bTUUyD+/7y+3LLnF9j6S3KOXfwj017EkYbZR/fvaOXrz6XG
D9z23PnbufYBeBqnyk50gmfQ8BZhTTm2V4yHZRM+pMbU9r17RxOq4jFbyhqAhgTC
RWKD8dr2JrLRoLxk3fzgKkm/BTpoYJNgii+8qMQ5zAvelcVJ/3Ongpe+hrgmP0hW
eWxbY0qC6Kohx2OiKs+P2/7vaFXcQIh+ZZy/cOECaz4dmY6rq6toEmU1KEBdR3C5
KHs/8ijcNYPiBAtO/DdSvv5VAfUCvY8eXVUZqv2JKW78SDVoYGF+Vfq1n4HaHy5i
YefqC0R+/B+Qa5HFFJ04wDADpQrcOCb5rKLaLtaStjOp7fZZM7U=
=dgaK
-----END PGP SIGNATURE-----
--=-=-=--
