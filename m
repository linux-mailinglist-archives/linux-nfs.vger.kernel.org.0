Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C9DA17E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfJPWZB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 18:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730762AbfJPWZB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 18:25:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD857AD35;
        Wed, 16 Oct 2019 22:24:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@gmail.com>, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 09:24:53 +1100
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 1/3] SUNRPC: The TCP back channel mustn't disappear while requests are outstanding
In-Reply-To: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
Message-ID: <87pniwpbuy.fsf@notabene.neil.brown.name>
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

On Wed, Oct 16 2019, Trond Myklebust wrote:

> If there are TCP back channel requests either being processed by the
> server threads, then we should hold a reference to the transport
> to ensure it doesn't get freed from underneath us.
>
> Reported-by: Neil Brown <neilb@suse.de>
> Fixes: 2ea24497a1b3 ("SUNRPC: RPC callbacks may be split across several..=
")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/backchannel_rqst.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index 339e8c077c2d..7eb251372f94 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -307,8 +307,8 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
>  		 */
>  		dprintk("RPC:       Last session removed req=3D%p\n", req);
>  		xprt_free_allocation(req);
> -		return;
>  	}
> +	xprt_put(xprt);
>  }
>=20=20
>  /*
> @@ -339,7 +339,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xp=
rt *xprt, __be32 xid)
>  		spin_unlock(&xprt->bc_pa_lock);
>  		if (new) {
>  			if (req !=3D new)
> -				xprt_free_bc_rqst(new);
> +				xprt_free_allocation(new);
>  			break;
>  		} else if (req)
>  			break;
> @@ -368,6 +368,7 @@ void xprt_complete_bc_request(struct rpc_rqst *req, u=
int32_t copied)
>  	set_bit(RPC_BC_PA_IN_USE, &req->rq_bc_pa_state);
>=20=20
>  	dprintk("RPC:       add callback request to list\n");
> +	xprt_get(xprt);
>  	spin_lock(&bc_serv->sv_cb_lock);
>  	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
>  	wake_up(&bc_serv->sv_cb_waitq);
> --=20
> 2.21.0

Looks good.
This and the next two:
 Reviewed-by: NeilBrown <neilb@suse.de>

It would help me if you could add a Fixes: tag to at least the first
two.

BTW, while reviewing I notices that bc_alloc_count and bc_slot_count are
almost identical.  The three places were that are changed separately are
probably (minor) bugs.
Do you recall why there were two different counters?  Has the reason
disappeared?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2nmLUACgkQOeye3VZi
gbm8zg/9Gtc6DroZ/eXpE1Bc8cCLjmtO530p+vPiulWHpfr0LFMDzD/h9kmdiuTS
KEftKsiX7UVwjQmrPqR3fnc9MWTS4e1y1L0xYTET8TrbDNxOJa2Z3C/PhU1FoLRl
zxPuhQOqxv+olkD/0UVzTT3RCIwka/YJSytmv1bcc7W/u8sAX1ILW9QmZdU8OT7R
w1ykOqa60K/zVZZZh3DRXDR4vammbBuvHU9WTlTvCawy141Qr4NRjn9mJgSEUSZV
YxEFeqK3yl61ONxVUOkWdA4JrL6muzbYgixzmdv48JhW8074P83joKFmEJrQPxvj
SDHyUpSp0W7A4ap90VXgJ4fyZu2u2up+OdAS2KqwP9+l5N04i2wtajJT2kqGVVQu
F4lHrSRyE4H1rqi1U5cQrchfNsuJieSubFdsVXTyOy7qOy4les8Sp1L2hmXNVIuK
4/cysUkibfhjJeR6Yx9oXOgRJ2b7PphF1D6laqBpM8cQBy8dK+yD1Uq9Fx6Rplkl
ea9rjrFg2u43f3aGV8F0YXWOBrpZJsSLUtbN3ohxci3OZdNUFgsAvehkhFyT33pP
g5zsRcHi0yM0b8DlRwCMMLApBcKMICXbsPKY5U48Tc1iyIYy9xHqsnrrfSQ/fyr5
fGvszUS19pr8SQ2BKHRiIy3iXvQrNRSxuIgkb0krJMZlJlI8YBQ=
=hLNX
-----END PGP SIGNATURE-----
--=-=-=--
