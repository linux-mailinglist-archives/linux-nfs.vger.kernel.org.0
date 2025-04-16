Return-Path: <linux-nfs+bounces-11151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9569A90BB7
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A64601B5
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6E21A42F;
	Wed, 16 Apr 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg6E1M8A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F829A5
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829734; cv=none; b=WEvVK45+UE4zGvE1ThUcMgsEZPUDoSCIKYrab2W/GSNqD0m+tnfoKqoFP5qDFPQh353SGVVAggxS1eyy1EeqrlqC1w6/2mT93ZPB2sp7/lOIB6k0eO9K1hcsMIQN/vAweXC3UT2xjJ1AYP6umiIOzPcZMhIlgZ5bb3MDjOtTHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829734; c=relaxed/simple;
	bh=aNNNaiUk0C381mqfllxZ/RXpIOP6srZH8Sfde+iquls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5M42PrXl29hHCWVttkMgN9qT7mf+ZvK6tzS60/xi/VerwR+LRLmCevYFCxqsvXZUNDY0AlZMpzsAipWOW6EREKd29XdTQm7PtAxWXDUiBGoId3lrF8mkug+qpv2zhWmA8B8kyOgHd2qasQRU+Ggx37hivLnXoQvtq/0sBm/PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg6E1M8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6F1C4CEE2;
	Wed, 16 Apr 2025 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744829733;
	bh=aNNNaiUk0C381mqfllxZ/RXpIOP6srZH8Sfde+iquls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cg6E1M8AEUYrVkpefp5RyEZWSXdgZdPFBdPNPJU9Q51lsbrPb02QEDngq5IMJ/uiU
	 FidAklHJMSW+aj2mot8MUGXfGkiFCiz0YK/CfYJ+jBb/mgSviW6uNbFUAYxmoMXtaH
	 HBvc2jUZK6OKcptBiaUUdBcUg2af7Yk3WQZbVgfHtjdmGG4Q2oRqm/OwEXiej3FwVQ
	 DEBmAq4f9plVF/USLTepabE8XEIikt3sg6BJoCZqEotVjuVIuehRlZYWN0VZYez27G
	 SKIf86KdUdtOa5mo/fmDMq4QFbIknw1acmNOC5vvIOb7I9J3yHsxHJusMKHps1DHZH
	 ftu6O9xth0hDg==
Message-ID: <6f41906c28147e802bb2253cf1a9c86329b5a05e.camel@kernel.org>
Subject: Re: [RFC PATCH 1/2] sunrpc: Replace the rq_bvec array with
 dynamically-allocated memory
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Wed, 16 Apr 2025 14:55:31 -0400
In-Reply-To: <8a0fc700-c0bc-42b3-b6c2-86a5ed171534@oracle.com>
References: <20250416152854.15269-1-cel@kernel.org>
	 <20250416152854.15269-2-cel@kernel.org>
	 <1086d2ecc8fc0aed85fc571e8bc4c66f6ff0fb64.camel@kernel.org>
	 <8a0fc700-c0bc-42b3-b6c2-86a5ed171534@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-16 at 14:45 -0400, Chuck Lever wrote:
> On 4/16/25 2:42 PM, Jeff Layton wrote:
> > On Wed, 2025-04-16 at 11:28 -0400, cel@kernel.org wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > As a step towards making NFSD's maximum rsize and wsize variable,
> > > replace the fixed-size rq_bvec[] array in struct svc_rqst with a
> > > chunk of dynamically-allocated memory.
> > >=20
> > > On a system with 8-byte pointers and 4KB pages, pahole reports that
> > > the rq_bvec[] array is 4144 bytes. Replacing it with a single
> > > pointer reduces the size of struct svc_rqst to about 7500 bytes.
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  include/linux/sunrpc/svc.h | 2 +-
> > >  net/sunrpc/svc.c           | 6 ++++++
> > >  net/sunrpc/svcsock.c       | 7 +++----
> > >  3 files changed, 10 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index 74658cca0f38..225c385085c3 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -195,7 +195,7 @@ struct svc_rqst {
> > > =20
> > >  	struct folio_batch	rq_fbatch;
> > >  	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
> > > -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
> > > +	struct bio_vec		*rq_bvec;
> >=20
> > It's a reasonable start.
> >=20
> > What would also be good to do here is to replace the invocations of
> > RPCSVC_MAXPAGES that involve this array with a helper function that
> > returns the length of it.
> >=20
> > For now it could just return RPCSVC_MAXPAGES, but eventually you could
> > add (e.g.) a rqstp->rq_bvec_len field and use that to indicate how many
> > entries there are in rq_bvec.
>=20
> rq_vec, rq_pages, and rq_bvec all have the same entry count (plus or
> minus one) so only one new field is necessary. There are a few other
> places that allocate arrays of size RPCSVC_MAXPAGES that will need
> similar treatment.
>
> Stay tuned for v2.
>=20

Ok. I think I didn't articulate this well. Let me try again:

If you're looking to break the assumption that the length of these
arrays is RPCSVC_MAXPAGES, then the thing to do is to eliminate the
places where we make that assumption.

In particular, the two places where you're adding new RPCSVC_MAXPAGES
invocations would be better replaced with a helper function that we can
change the return value of later.

>=20
> > >  	__be32			rq_xid;		/* transmission id */
> > >  	u32			rq_prog;	/* program number */
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index e7f9c295d13c..db29819716b8 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -673,6 +673,7 @@ static void
> > >  svc_rqst_free(struct svc_rqst *rqstp)
> > >  {
> > >  	folio_batch_release(&rqstp->rq_fbatch);
> > > +	kfree(rqstp->rq_bvec);
> > >  	svc_release_buffer(rqstp);
> > >  	if (rqstp->rq_scratch_page)
> > >  		put_page(rqstp->rq_scratch_page);
> > > @@ -711,6 +712,11 @@ svc_prepare_thread(struct svc_serv *serv, struct=
 svc_pool *pool, int node)
> > >  	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
> > >  		goto out_enomem;
> > > =20
> > > +	rqstp->rq_bvec =3D kcalloc_node(RPCSVC_MAXPAGES, sizeof(struct bio_=
vec),
> > > +				      GFP_KERNEL, node);
> > > +	if (!rqstp->rq_bvec)
> > > +		goto out_enomem;
> > > +
> > >  	rqstp->rq_err =3D -EAGAIN; /* No error yet */
> > > =20
> > >  	serv->sv_nrthreads +=3D 1;
> > > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > > index 72e5a01df3d3..671640933f18 100644
> > > --- a/net/sunrpc/svcsock.c
> > > +++ b/net/sunrpc/svcsock.c
> > > @@ -713,8 +713,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
> > >  	if (svc_xprt_is_dead(xprt))
> > >  		goto out_notconn;
> > > =20
> > > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec,
> > > -				ARRAY_SIZE(rqstp->rq_bvec), xdr);
> > > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, RPCSVC_MAXPAGES, xdr);
> > > =20
> > >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > >  		      count, rqstp->rq_res.len);
> > > @@ -1219,8 +1218,8 @@ static int svc_tcp_sendmsg(struct svc_sock *svs=
k, struct svc_rqst *rqstp,
> > >  	memcpy(buf, &marker, sizeof(marker));
> > >  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> > > =20
> > > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1,
> > > -				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
> > > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, RPCSVC_MAXPAGES,
> > > +				&rqstp->rq_res);
> > >=20
>
> > > =20
> > >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > >  		      1 + count, sizeof(marker) + rqstp->rq_res.len);
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

