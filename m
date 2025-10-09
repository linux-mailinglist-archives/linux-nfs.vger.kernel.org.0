Return-Path: <linux-nfs+bounces-15094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED1BC9B2D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702711886C8A
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D52E7F11;
	Thu,  9 Oct 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWCmmCaE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6B3595D;
	Thu,  9 Oct 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022473; cv=none; b=h6IzJnNqTN8nSybIWuRYtphZVELTEwwOf9jhZQXNk538PBIz9ZFK22Dc2e5Trtkm1H9h8X+EHeKFFrHf2orlgHE5BG3mIUefIVtgFDkWnvGmop9id+tZftV17BeubVTByAW/hE25jOdgJ0pIDKmILAmDI0PDCZDtBSq0oW3WiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022473; c=relaxed/simple;
	bh=n/f+UkudxKmaK112kSwrB+SawNJ755RJI4OBmH9AOKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lnCc8vHcm0Cnb2f7T2Rlz7Phc9QG1GeiJFqpNBkKs4hT4709I5uUVQ1KaiYtSR2ugFTBU94Ad7wgxtwbvQ7U446zPrfqXtT7pYp7yVUH5W5OQDLG6EfEBtMWArtYQxHWUow5hAOJCl569jvv/1gOM6F8HyDp3HePQkId0outw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWCmmCaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E2C4CEE7;
	Thu,  9 Oct 2025 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022472;
	bh=n/f+UkudxKmaK112kSwrB+SawNJ755RJI4OBmH9AOKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hWCmmCaEC1JHL12UL8qUbMNQ3go06kQ31Ekh0blvU0drXn3b40p8SXJZZhD9rdTW1
	 mvvxdWHekyYzt47a2wRk91jknksqjHBiy4pw9stihR/lOgjpaAAZ13nKYoDNaHnGGD
	 /3bRoVdpBP7AY0BNGNBQsmghOv/EWC1wnbV6dDXBwIp5Qen5MGunsw/uLzrplBrsEf
	 ccpDYMHn2mRkSpHk08eeN+mgdhcYlFwMB2cdWQGOYmJJ/ydnrCZpN1oPdI1KM3Gnqy
	 k7sVK45TmrFArca78AO8i3pelhI0V9VlOOm5kRSnVRJVtr8r0sbKWoXv4PwkQXDeuY
	 vTSilpk5e1GjA==
Message-ID: <e04c97d9a5fe846b4d4465b4f5d4693de1c8b02b.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP
 record marker
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, David Howells
 <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Oct 2025 11:07:49 -0400
In-Reply-To: <56718ad5-fdb3-4588-bab9-7b9a1879cad0@oracle.com>
References: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
	 <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
	 <56718ad5-fdb3-4588-bab9-7b9a1879cad0@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 11:03 -0400, Chuck Lever wrote:
> On 10/9/25 10:40 AM, Jeff Layton wrote:
> > We've seen some occurrences of messages like this in dmesg on some knfs=
d
> > servers:
> >=20
> >     xdr_buf_to_bvec: bio_vec array overflow
> >=20
> > Usually followed by messages like this that indicate a short send (note
> > that this message is from an older kernel and the amount that it report=
s
> > attempting to send is short by 4 bytes):
> >=20
> >     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutti=
ng down socket
> >=20
> > svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
> > marker. If the send is an unaligned READ call though, then there may no=
t
> > be enough slots in the rq_bvec array in some cases.
> >=20
> > Add a rqstp->rq_bvec_len field and use that to keep track of the length
> > of rq_bvec. Use that in place of rq_maxpages where it's iterating over
> > the bvec.
>=20
> Granted that the number of items in rq_pages and in rq_bvec don't have
> to coincide, they just happen to be the same, historically. And, each
> bvec in rq_bvec doesn't necessarily have to be a page.
>=20
>=20
> > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single soc=
k_sendmsg() call")
> > Tested-by: Brandon Adams <brandona@meta.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c              | 6 +++---
> >  include/linux/sunrpc/svc.h | 1 +
> >  net/sunrpc/svc.c           | 4 +++-
> >  net/sunrpc/svcsock.c       | 4 ++--
> >  4 files changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 77f6879c2e063fa79865100bbc2d1e64eb332f42..6c7224570d2dadae21876e0=
069e0b2e0551af0fa 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> > =20
> >  	v =3D 0;
> >  	total =3D dio_end - dio_start;
> > -	while (total && v < rqstp->rq_maxpages &&
> > +	while (total && v < rqstp->rq_bvec_len &&
> >  	       rqstp->rq_next_page < rqstp->rq_page_end) {
> >  		len =3D min_t(size_t, total, PAGE_SIZE);
> >  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> > @@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> > =20
> >  	v =3D 0;
> >  	total =3D *count;
> > -	while (total && v < rqstp->rq_maxpages &&
> > +	while (total && v < rqstp->rq_bvec_len &&
> >  	       rqstp->rq_next_page < rqstp->rq_page_end) {
> >  		len =3D min_t(size_t, total, PAGE_SIZE - base);
> >  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> > @@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> >  	if (stable && !fhp->fh_use_wgather)
> >  		kiocb.ki_flags |=3D IOCB_DSYNC;
> > =20
> > -	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload=
);
> > +	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, payload=
);
> >  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> >  	since =3D READ_ONCE(file->f_wb_err);
> >  	if (verf)
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 5506d20857c318774cd223272d4b0022cc19ffb8..0ee1f411860e55d5e0131c2=
9766540f673193d5f 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -206,6 +206,7 @@ struct svc_rqst {
> > =20
> >  	struct folio_batch	rq_fbatch;
> >  	struct bio_vec		*rq_bvec;
> > +	u32			rq_bvec_len;
> > =20
> >  	__be32			rq_xid;		/* transmission id */
> >  	u32			rq_prog;	/* program number */
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 4704dce7284eccc9e2bc64cf22947666facfa86a..a6bdd83fba77b13f973da66=
a1bac00050ae922fe 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -706,7 +706,9 @@ svc_prepare_thread(struct svc_serv *serv, struct sv=
c_pool *pool, int node)
> >  	if (!svc_init_buffer(rqstp, serv, node))
> >  		goto out_enomem;
> > =20
> > -	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages,
> > +	/* +1 for the TCP record marker */
> > +	rqstp->rq_bvec_len =3D rqstp->rq_maxpages + 1;
>=20
> What bugs me about this is that svc_prepare_thread() shouldn't have
> specific knowledge about the needs of transports. But I don't have a
> better idea...
>=20

Yeah, it's a minor layering violation. I guess I could phrase it as:

    /* Some transports need an extra bvec. (e.g. TCP needs it for the recor=
d marker) */

...but I'm not sure that's any clearer.

>=20
> > +	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_bvec_len,
> >  				      sizeof(struct bio_vec),
> >  				      GFP_KERNEL, node);
> >  	if (!rqstp->rq_bvec)
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..2075ddec250b3fdb36becca=
4a53f1c0536f8634a 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
> >  	if (svc_xprt_is_dead(xprt))
> >  		goto out_notconn;
> > =20
> > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, xdr);
> > =20
> >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> >  		      count, rqstp->rq_res.len);
> > @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk,=
 struct svc_rqst *rqstp,
> >  	memcpy(buf, &marker, sizeof(marker));
> >  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> > =20
> > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
> > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_bvec_len - 1,
> >  				&rqstp->rq_res);
> > =20
> >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

