Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABCD8469
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfJOXXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 19:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbfJOXXr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Oct 2019 19:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5585AF24;
        Tue, 15 Oct 2019 23:23:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields\@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>
Date:   Wed, 16 Oct 2019 10:23:37 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
In-Reply-To: <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name> <20191011165603.GD19318@fieldses.org> <87imoqrjb8.fsf@notabene.neil.brown.name> <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
Message-ID: <87a7a1r3t2.fsf@notabene.neil.brown.name>
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

On Tue, Oct 15 2019, Trond Myklebust wrote:

> Hi Neil,
>
> On Tue, 2019-10-15 at 10:36 +1100, NeilBrown wrote:
>> The backchannel RPC requests - that are queued waiting
>> for the reply to be sent by the "NFSv4 callback" thread -
>> have a pointer to the xprt, but it is not reference counted.
>> It is possible for the xprt to be freed while there are
>> still queued requests.
>>=20
>> I think this has been a problem since
>> Commit fb7a0b9addbd ("nfs41: New backchannel helper routines")
>> when the code was introduced, but I suspect it became more of
>> a problem after
>> Commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> transports")
>> (or there abouts).
>> Before this second patch, the nfs client would hold a reference to
>> the xprt to keep it alive.  After multipath was introduced,
>> a client holds a reference to a swtich, and the switch can have
>> multiple
>> xprts which can be added and removed.
>>=20
>> I'm not sure of all the causal issues, but this patch has
>> fixed a customer problem were an NFSv4.1 client would run out
>> of memory with tens of thousands of backchannel rpc requests
>> queued for an xprt that had been freed.  This was a 64K-page
>> machine so each rpc_rqst consumed more than 128K of memory.
>>=20
>> Fixes: 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> transports")
>> cc: stable@vger.kernel.org (v4.6)
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>  net/sunrpc/backchannel_rqst.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/backchannel_rqst.c
>> b/net/sunrpc/backchannel_rqst.c
>> index 339e8c077c2d..c95ca39688b6 100644
>> --- a/net/sunrpc/backchannel_rqst.c
>> +++ b/net/sunrpc/backchannel_rqst.c
>> @@ -61,6 +61,7 @@ static void xprt_free_allocation(struct rpc_rqst
>> *req)
>>  	free_page((unsigned long)xbufp->head[0].iov_base);
>>  	xbufp =3D &req->rq_snd_buf;
>>  	free_page((unsigned long)xbufp->head[0].iov_base);
>> +	xprt_put(req->rq_xprt);
>>  	kfree(req);
>>  }
>
> Would it perhaps make better sense to move the xprt_get() to
> xprt_lookup_bc_request() and to release it in xprt_free_bc_rqst()?=20

... maybe ...

>
> Otherwise as far as I can tell, we will have freed slots on the xprt-
>>bc_pa_list that hold a reference to the transport itself, meaning that
> the latter never gets released.

Apart from cleanup-on-error paths, xprt_free_allocation() is called:
 - in xprt_destroy_bc() - at most 'max_reqs' times.
 - in xprt_free_bc_rqst(), if the bc_alloc_count >=3D bc_alloc_max

So when xprt_destroy_bc() is called (from nfs4_destroy_session, via
xprt_destroy_backchannel()), bc_alloc_max() is reduced, and possibly
the requests are freed and bc_alloc_count is reduced accordingly.
If the requests were busy, they won't have been freed then, but will
then be freed when xprt_free_bc_reqst is called - because bc_alloc_max
has been reduced.

Once nfs4_destroy_session() has been called on all session, and
xprt_free_bc_rqst() has been called on all active requests, I think
they should be no requests left to be holding a reference to
the xprt.

And if there were requests left, and if we change the refcount code
(like you suggest) so that they weren't holding a reference, then they
would never be freed. - freeing an xprt doesn't clean out the bc_pa_list.

Though ... the connection from a session to an xprt isn't permanent (I
guess, based on the rcu_read_lock in nfs4_destroy_session... which
itself seems a bit odd as it doesn't inc a refcount while holding the
lock).

So maybe the counts can get out of balance.

Conclusion: I'm not sure the ref counts are entirely correct, but I
   cannot see a benefit from moving the xprt_get/put requests like you
   suggest.

Thanks,
NeilBrown


>
>>=20=20
>> @@ -85,7 +86,7 @@ struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt
>> *xprt, gfp_t gfp_flags)
>>  	if (req =3D=3D NULL)
>>  		return NULL;
>>=20=20
>> -	req->rq_xprt =3D xprt;
>> +	req->rq_xprt =3D xprt_get(xprt);
>>  	INIT_LIST_HEAD(&req->rq_bc_list);
>>=20=20
>>  	/* Preallocate one XDR receive buffer */
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2mVPoACgkQOeye3VZi
gbkcIw//bukcQ6jKef7+zo1fj5ahCUp5jLK7ZFroERa8a8UhHEPe392o37dQrhiR
DWMDV6giKQmWgwbM8zNQzJNniwdPd3q32k/rb8av2IM8Ba2jY+SKqvaENRcP+gVf
eZxMTg798aRn1UPpslltLK/gDVnybvXAD4HPWSbcz7HWYAVnLR39U5WDfJNrmQ0s
B6DvAUSpB7SYW7fD/5nt2GBv6FAzeooEnhrQ12oWZS2Dp9vn0dGauUSKpH9/Gz2f
2FIR/CdInWl+bZyQnsnNdtIff18v/e+2pRQVQpPKdIdTjmIaStfAzYMfZyXmCAAO
z+9ETAPE4cOvNyrEjFNLpV7cG1Rj+GdwI7s9qkdNjIDQqJH9yd2ZB7801GUxE7Xx
R67QBDpW7+C9I3hhp4jzyeemN7kgLAMH2A2ud9yBWYXn9rCC9OOvpjeInPSa6sh3
wTO737oFgcDLDqRO3o0eTbbHXpWDcxZste22gfdo1lzcnj4rHgo9YlNPDCQTQLwz
h3feXfCWT21dRe/SbSN+ztCKaYz6KTWSvLwMsWnA5ZFVchw1/3ss2Luzgv4DWZ6e
i8G/m2s1sq4NwBVoMMQ/wH6EE+WLS2L7rojgoi9dlCTYUPmJX4+CWV/wGBCOJsg8
uHhai2YZrTw4J0k+F4uL07RgdSnD2Uobcd66xVhWG9TSZYovkSE=
=18T+
-----END PGP SIGNATURE-----
--=-=-=--
