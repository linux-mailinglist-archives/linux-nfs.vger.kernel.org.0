Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED5D6C1C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfJNXgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 19:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfJNXgg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 19:36:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 040B1AE2A;
        Mon, 14 Oct 2019 23:36:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 15 Oct 2019 10:36:27 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
In-Reply-To: <20191011165603.GD19318@fieldses.org>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name> <20191011165603.GD19318@fieldses.org>
Message-ID: <87imoqrjb8.fsf@notabene.neil.brown.name>
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


The backchannel RPC requests - that are queued waiting
for the reply to be sent by the "NFSv4 callback" thread -
have a pointer to the xprt, but it is not reference counted.
It is possible for the xprt to be freed while there are
still queued requests.

I think this has been a problem since
Commit fb7a0b9addbd ("nfs41: New backchannel helper routines")
when the code was introduced, but I suspect it became more of
a problem after
Commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple transports")
(or there abouts).
Before this second patch, the nfs client would hold a reference to
the xprt to keep it alive.  After multipath was introduced,
a client holds a reference to a swtich, and the switch can have multiple
xprts which can be added and removed.

I'm not sure of all the causal issues, but this patch has
fixed a customer problem were an NFSv4.1 client would run out
of memory with tens of thousands of backchannel rpc requests
queued for an xprt that had been freed.  This was a 64K-page
machine so each rpc_rqst consumed more than 128K of memory.

Fixes: 80b14d5e61ca ("SUNRPC: Add a structure to track multiple transports")
cc: stable@vger.kernel.org (v4.6)
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 net/sunrpc/backchannel_rqst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 339e8c077c2d..c95ca39688b6 100644
=2D-- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -61,6 +61,7 @@ static void xprt_free_allocation(struct rpc_rqst *req)
 	free_page((unsigned long)xbufp->head[0].iov_base);
 	xbufp =3D &req->rq_snd_buf;
 	free_page((unsigned long)xbufp->head[0].iov_base);
+	xprt_put(req->rq_xprt);
 	kfree(req);
 }
=20
@@ -85,7 +86,7 @@ struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt *xprt,=
 gfp_t gfp_flags)
 	if (req =3D=3D NULL)
 		return NULL;
=20
=2D	req->rq_xprt =3D xprt;
+	req->rq_xprt =3D xprt_get(xprt);
 	INIT_LIST_HEAD(&req->rq_bc_list);
=20
 	/* Preallocate one XDR receive buffer */
=2D-=20
2.23.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2lBnsACgkQOeye3VZi
gbkktg//T+OnehuZeD5J3/192d+8xpWsk0q9VIYiuO+O+plTOuNOF2GEfR7vOAZW
5U23Kp/boE97HQXAachRv67FWqrlK3MtTiMv8wuOkqMaOXhbO/RSKSle7QExZvhP
XWuFYCZ0QagUjnpvtEb29Imj7pupjxIlCxSokIqg6PJFh+iMljLxGhneC3c2xf0X
CA4ClyhDV+MWaOtHb2fp9J8f8Ve+65lunW/EaJmR1XKoEpaqALqQbHtzcEc4QyIq
yUH6DG+qIz5raK6i9yWMRRuHEMO+5CEMTrz4K97CCVTlu4tJ5ROb6SWLkwk3kayb
/3+arMuHNDmsT2Jbv6PQ91n90zaF3CMMALgGl6R6Pn1oqYG4nA3zVQfbl5gAVOKA
Q2ldPJmAWQiRgDR1nRsbXMakzEAaEBlAdZhbnKIcAnPEX4NgOCPgh00qtbj+I11L
wPPI62+WBuSkBDyf13nLW00oGCnqInN9w6i/vdPCIHF6e7x8WxmcwEmrz8TYecEM
oI2fNYC78caugclcaETpabTpenXI493rrYU3NCinSGM/GyGqokVRIdClDMYYIUdJ
BEfyoY6bScx2zcs+jXhPWFoNUPIqvgr5Dl2AbmIrc/pXEh2N3XSsAXdGHMp0UjEU
2wEIcRoPAznwBGoF6+1HAlb2K0CpMQRObwStPauhswIBPTBBet8=
=4db9
-----END PGP SIGNATURE-----
--=-=-=--
