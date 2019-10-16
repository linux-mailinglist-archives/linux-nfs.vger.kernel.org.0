Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE39D878B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 06:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJPEi1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 00:38:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfJPEi1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 00:38:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 637D8B1DB;
        Wed, 16 Oct 2019 04:38:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@gmail.com>,
        "bfields\@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>
Date:   Wed, 16 Oct 2019 15:38:16 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
In-Reply-To: <8ac0b07bd523e4a040b4dc5e53639e1ea3b68db6.camel@hammerspace.com>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name> <20191011165603.GD19318@fieldses.org> <87imoqrjb8.fsf@notabene.neil.brown.name> <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com> <87a7a1r3t2.fsf@notabene.neil.brown.name> <8ac0b07bd523e4a040b4dc5e53639e1ea3b68db6.camel@hammerspace.com>
Message-ID: <874l09qp8n.fsf@notabene.neil.brown.name>
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

> On Wed, 2019-10-16 at 10:23 +1100, NeilBrown wrote:
>> On Tue, Oct 15 2019, Trond Myklebust wrote:
>>=20
>> > Hi Neil,
>> >=20
>> > On Tue, 2019-10-15 at 10:36 +1100, NeilBrown wrote:
>> > > The backchannel RPC requests - that are queued waiting
>> > > for the reply to be sent by the "NFSv4 callback" thread -
>> > > have a pointer to the xprt, but it is not reference counted.
>> > > It is possible for the xprt to be freed while there are
>> > > still queued requests.
>> > >=20
>> > > I think this has been a problem since
>> > > Commit fb7a0b9addbd ("nfs41: New backchannel helper routines")
>> > > when the code was introduced, but I suspect it became more of
>> > > a problem after
>> > > Commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> > > transports")
>> > > (or there abouts).
>> > > Before this second patch, the nfs client would hold a reference
>> > > to
>> > > the xprt to keep it alive.  After multipath was introduced,
>> > > a client holds a reference to a swtich, and the switch can have
>> > > multiple
>> > > xprts which can be added and removed.
>> > >=20
>> > > I'm not sure of all the causal issues, but this patch has
>> > > fixed a customer problem were an NFSv4.1 client would run out
>> > > of memory with tens of thousands of backchannel rpc requests
>> > > queued for an xprt that had been freed.  This was a 64K-page
>> > > machine so each rpc_rqst consumed more than 128K of memory.
>> > >=20
>> > > Fixes: 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> > > transports")
>> > > cc: stable@vger.kernel.org (v4.6)
>> > > Signed-off-by: NeilBrown <neilb@suse.de>
>> > > ---
>> > >  net/sunrpc/backchannel_rqst.c | 3 ++-
>> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > >=20
>> > > diff --git a/net/sunrpc/backchannel_rqst.c
>> > > b/net/sunrpc/backchannel_rqst.c
>> > > index 339e8c077c2d..c95ca39688b6 100644
>> > > --- a/net/sunrpc/backchannel_rqst.c
>> > > +++ b/net/sunrpc/backchannel_rqst.c
>> > > @@ -61,6 +61,7 @@ static void xprt_free_allocation(struct
>> > > rpc_rqst
>> > > *req)
>> > >  	free_page((unsigned long)xbufp->head[0].iov_base);
>> > >  	xbufp =3D &req->rq_snd_buf;
>> > >  	free_page((unsigned long)xbufp->head[0].iov_base);
>> > > +	xprt_put(req->rq_xprt);
>> > >  	kfree(req);
>> > >  }
>> >=20
>> > Would it perhaps make better sense to move the xprt_get() to
>> > xprt_lookup_bc_request() and to release it in xprt_free_bc_rqst()?=20
>>=20
>> ... maybe ...
>>=20
>> > Otherwise as far as I can tell, we will have freed slots on the
>> > xprt-
>> > > bc_pa_list that hold a reference to the transport itself, meaning
>> > > that
>> > the latter never gets released.
>>=20
>> Apart from cleanup-on-error paths, xprt_free_allocation() is called:
>>  - in xprt_destroy_bc() - at most 'max_reqs' times.
>>  - in xprt_free_bc_rqst(), if the bc_alloc_count >=3D bc_alloc_max
>>=20
>> So when xprt_destroy_bc() is called (from nfs4_destroy_session, via
>> xprt_destroy_backchannel()), bc_alloc_max() is reduced, and possibly
>> the requests are freed and bc_alloc_count is reduced accordingly.
>> If the requests were busy, they won't have been freed then, but will
>> then be freed when xprt_free_bc_reqst is called - because
>> bc_alloc_max
>> has been reduced.
>>=20
>> Once nfs4_destroy_session() has been called on all session, and
>> xprt_free_bc_rqst() has been called on all active requests, I think
>> they should be no requests left to be holding a reference to
>> the xprt.
>>=20
>> And if there were requests left, and if we change the refcount code
>> (like you suggest) so that they weren't holding a reference, then
>> they
>> would never be freed. - freeing an xprt doesn't clean out the
>> bc_pa_list.
>>=20
>> Though ... the connection from a session to an xprt isn't permanent
>> (I
>> guess, based on the rcu_read_lock in nfs4_destroy_session... which
>> itself seems a bit odd as it doesn't inc a refcount while holding the
>> lock).
>>=20
>> So maybe the counts can get out of balance.
>>=20
>> Conclusion: I'm not sure the ref counts are entirely correct, but I
>>    cannot see a benefit from moving the xprt_get/put requests like
>> you
>>    suggest.
>>=20
>
> I don't buy that conclusion.
>
> Nothing stops me from changing the value of NFS41_BC_MIN_CALLBACKS to
> zero. Why should that affect the existence or not of the transport by
> changing the number of references held? That parameter is supposed to
> determine the number of pre-allocated requests and nothing else.

If you reduce NFS41_BC_MIN_CALLBACKS to zero, bc_alloc_max won't be
increased and will remain at zero.  So xprt_get_bc_request() will
always need to allocate a new request (bc_pa_list will be empty),
and xprt_free_bc_rqst() will always free the request - never putting it
on the bc_pa_list.

Maybe it would make sense to do exactly that, get rid of bc_pa_list, and
possibly use a mempool if there is any concern about delays when
allocating.

I agree that it is a little odd for requests on the pa list to hold a
reference to the xprt, and I don't object at all to changing that.
My only point is that I think my patch as it stands is correct, that it
doesn't introduce new problems (and so might be the simplest thing for
=2Dstable).

Thanks,
NeilBrown


>
> I do agree with your assessment that destroying the xprt does not
> currrently destroy the contents of xprt->bc_pa_list if they are non-
> zero, but that would be a bug, and an easy one to fix.
>
>
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2mnrgACgkQOeye3VZi
gbl5eQ/8Cu8lIlIWE99AhZwE3vQhNur2n61xZNa2hkqCTv9X5cPGnhC/qCxBO4mX
ieoZWUkLmdeq8M3of9GdpoeCmj51h+PoWNeT1y3SHtbuxrkTcKLOYiw9qJBJX17x
UJl5AoCe5eYMiUlJgHdb6X3svxlZvORGAXkVFl9kPT0GEcuYaNGgO90uKbnbZugn
ufTPDNvQYaiKEUen5pyVIVBjnMfCixiUSmG76YQJxfxzRpUwePjtIWB+mv1V+ZDZ
dfy/Y4cJzCPVlABVlC9c6XLjTTQV9NN2XjzN0YsjZ/czLh9i2V6Yq3+s3kZc0LV0
EBJf1MetKhfbhkLSxNxyvhFfNQbAgQUfb48nZ4Jbcsa5ETKPY4TG74pE6X2fTljr
m3flGEiBqsxo/wshWDEewD+WtNcI7b/sM0P1z/YUnBMVV/gan7zUb6Rr2u1NI6k/
CzbtXtasiGkxjOyQa4cxZE4z/aEAmstieml35daBP0ru8jYEfj2+lrQHA6rU7Jfa
XRkjoEUkrweFoWp+4fqZ6uJYZkp+grEMjKVsGWwgGVMJuVenxpbLdQ5u/UjYzn2/
tVeq4aSctbxB8MLeyjSb79CGUqKjgyRyJIod4+rZk1rnpKZIK6JMk8RSmfdB5QJf
ls4toPQoZh+5sfN/isyn8kiu4ZP2HYZXBLKxNjLubIRnzaSxTSg=
=5huO
-----END PGP SIGNATURE-----
--=-=-=--
