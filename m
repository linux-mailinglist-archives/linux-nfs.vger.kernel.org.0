Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65933D06D3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfJIFPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 01:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730107AbfJIFPM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Oct 2019 01:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77EF4AD35
        for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2019 05:15:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 09 Oct 2019 16:15:04 +1100
Subject: NFSv4.1 backchannel xprt problems.
Message-ID: <87tv8iqz3b.fsf@notabene.neil.brown.name>
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


Hi,
 I have a customer with a 4.12-based kernel who is experiencing memory
 exhaustion.

 There are over 100,000 rpc_rqst structures queue on sv_cb_list for
 handing by the NFSv4 callback, which is idle.

 The rpc_rqst.rq_xprt pointer points to freed memory.

 I notice that that server code calls svc_xprt_get() on the xprt
 before storing it in rq_xprt, but the client/backchannel code doesn't.

 I'm wondering if the following might be useful.

 I plan to explore the code a bit more tomorrow and if this  still seems
 likely I get the customer to test this change, but I thought I would
 ask here as well incase someone more knowledgeable can give me any
 pointers.

Thanks,
NeilBrown

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

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2dbNgACgkQOeye3VZi
gblpuQ/+Jh/tGxTLEiHJ6lp/+VCA43b2eYub+wit/+mfvIE8Z+AidYilQhWRPHZr
OV6bLCNv/1pOFkGwsilg2x3ZvtO0kxuk0Rj+9NUWPZuBtYB7oeOFFCLnvr5vt3eY
KVrQ5czw4IKuGXtssl60ewamyLfAAjcF7Drbigvxe52NkPX2WkGOKPYvITSvOAWz
271wEai4HvPOI27xVgZOX/ZY4REVr1r0F3o3e3mMi34vn0vWeQtfQ73KftrLFSjq
WfGs5DvVNpugrOaDJTvou7r6+C4d3KBSIIPOQK90qYeA2cvbatMFM8d9+FzSv/vi
aFe/NofIfgkVgeadNcGH88HgEvZmuOby6mBXxTscdoO/mVq1Qs5/d6nXxpkp6GTR
ArNZ1KMtsQD0hAWiRNxPb6yT+oyaatucnRZ8rLQzRHQHo1rUZzUOqo8/v5R0ET1U
/4u7HD1qSI2i1Fu1FMOikTzF0Hb3AMdjqx2FcNiQh4mwSMmhS+J2+x3L2bQln8v/
4iBBbLSqfpQCpcsDQSY/LNuVn0VLCXlWZRUsNG0nA7afhcjzh/w/ihgRtwvb860O
PV9vsZTTBNo8S2cFjf5yYw45VYAVDdSyzARH4/yBtf5+NtVcNnYCKIIjVSBv8+P3
ZpNuhYURdmTJ+U6YCQkrzItT9nB3xKBK6XMO1e3qri8F5QFyV+A=
=4Eno
-----END PGP SIGNATURE-----
--=-=-=--
