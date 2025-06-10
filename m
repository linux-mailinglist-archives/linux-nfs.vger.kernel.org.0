Return-Path: <linux-nfs+bounces-12279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF99AD3FD6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6717CEFC
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF223AE96;
	Tue, 10 Jun 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd67YFqi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08E23504C
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749574908; cv=none; b=gE7oivUym8wRcKm1zjmZ8sBpGNY5JMD4WBwfoNLEmjqGzjDqUqLu+WSBb8UaUusuZCideErJmNV40IQNhk6dEgswZBPoAmobaQbw3W25wJsBucq+DDu6icxycl/j76ZQPr0qvZ+0+DNPV0jLS5g7W8eFTzaibrJtFcfNPeCsbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749574908; c=relaxed/simple;
	bh=or+U/v6zYYMSY/pzcgD97UzYtCbS4pUqtXxf18N519A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwGEIZ4bjXk//OKW1UTWg+cfdRsdArbPOYfVikuzz1fZao79DuesbqCK5GS9DpHGMInsEjD2EpxiGPXnb8Ier9yTLo79D1JVHbYi6ao5hFeXtwrKSUEEPNIfxQZa2f47FnXS3sbCxhTZ0AO/j6rjvOb2rC54830CZgvBUw/m2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd67YFqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C37AC4CEED;
	Tue, 10 Jun 2025 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749574907;
	bh=or+U/v6zYYMSY/pzcgD97UzYtCbS4pUqtXxf18N519A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dd67YFqiD3DgW6IuyukCLkROaB9Cf+VNbfOOoHgjp8lUP+ddSEv6DwB+rXWys4Ggz
	 1VufIO1AkxdYRDUjnt8l45HKyckOYrdcsLxnCI93pWL9OBYrUBC/Ox4x0uNTYNlDnU
	 yX1TX97ktPiv3S0VqYHEPINXDgPr9iKJNttKbiAMzaxLe/RqV2gPyYQnQEmCxfhqxE
	 xWXBIemGuoO55H88cBdNO7xCvrQKl2RPGV2Odkshp+5BzTiSI7OSGKYKkz22YKkhYB
	 WOo+2ruajQCunsApysnKfgLHly8ORnHMBNoRM4IYbCwIjwUCEII4vgHJfnzMdgRXIj
	 1X/3YxxE+QguQ==
Message-ID: <2155635c72f3bf440d25f74fd7924694389fb378.camel@kernel.org>
Subject: Re: [RFC PATCH 3/3] NFSD: Remove the cap on number of operations
 per NFSv4 COMPOUND
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 10 Jun 2025 13:01:46 -0400
In-Reply-To: <20250610160509.97599-4-cel@kernel.org>
References: <20250610160509.97599-1-cel@kernel.org>
	 <20250610160509.97599-4-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 12:05 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> This limit has always been a sanity check; in nearly all cases a
> large COMPOUND is a sign of a malfunctioning client. The only real
> limit on COMPOUND size and complexity is the size of NFSD's send
> and receive buffers.
>=20
> However, there are a few cases where a large COMPOUND is sane. For
> example, when a client implementation wants to walk down a long file
> pathname in a single round trip.
>=20
> A small risk is that now a client can construct a COMPOUND request
> that can keep a single nfsd thread busy for quite some time.
>=20

You're right about the risk there. I wonder what we could do to
mitigate that?

Maybe get a timestamp at the start of the compound and then check vs.
that after every operation? If the compound is taking longer than a
some timeout, give up and return an error on the next operation?

Also, while I did suggest it, we should consider not removing this
limit altogether, and rather just increase it to something like a max
practical limit:

For instance, we have limits in the channel_attrs for ca_maxrequestsize
and ca_maxresponsesize. What's the smallest operation? If we had a
compound comprised of just those operations, how many would fit?

That would at least act as a sanity check against compounds that are
clearly nonsensical.
 =20
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  | 14 ++------------
>  fs/nfsd/nfs4state.c |  1 -
>  fs/nfsd/nfs4xdr.c   |  4 +---
>  fs/nfsd/nfsd.h      |  3 ---
>  fs/nfsd/xdr4.h      |  1 -
>  5 files changed, 3 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f13abbb13b38..f4edf222e00e 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2842,20 +2842,10 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> =20
>  	rqstp->rq_lease_breaker =3D (void **)&cstate->clp;
> =20
> -	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_opcnt)=
;
> +	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
>  	while (!status && resp->opcnt < args->opcnt) {
>  		op =3D &args->ops[resp->opcnt++];
> =20
> -		if (unlikely(resp->opcnt =3D=3D NFSD_MAX_OPS_PER_COMPOUND)) {
> -			/* If there are still more operations to process,
> -			 * stop here and report NFS4ERR_RESOURCE. */
> -			if (cstate->minorversion =3D=3D 0 &&
> -			    args->client_opcnt > resp->opcnt) {
> -				op->status =3D nfserr_resource;
> -				goto encode_op;
> -			}
> -		}
> -
>  		/*
>  		 * The XDR decode routines may have pre-set op->status;
>  		 * for example, if there is a miscellaneous XDR error
> @@ -2932,7 +2922,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			status =3D op->status;
>  		}
> =20
> -		trace_nfsd_compound_status(args->client_opcnt, resp->opcnt,
> +		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
>  					   status, nfsd4_op_name(op->opnum));
> =20
>  		nfsd4_cstate_clear_replay(cstate);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86f..4b6ae8e54cd2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3872,7 +3872,6 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
>  	ca->headerpadsz =3D 0;
>  	ca->maxreq_sz =3D min_t(u32, ca->maxreq_sz, maxrpc);
>  	ca->maxresp_sz =3D min_t(u32, ca->maxresp_sz, maxrpc);
> -	ca->maxops =3D min_t(u32, ca->maxops, NFSD_MAX_OPS_PER_COMPOUND);
>  	ca->maxresp_cached =3D min_t(u32, ca->maxresp_cached,
>  			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
>  	ca->maxreqs =3D min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 3afcdbed6e14..ea91bad4eee2 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2500,10 +2500,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *a=
rgp)
> =20
>  	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
>  		return false;
> -	if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
> +	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
>  		return false;
> -	argp->opcnt =3D min_t(u32, argp->client_opcnt,
> -			    NFSD_MAX_OPS_PER_COMPOUND);
> =20
>  	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
>  		argp->ops =3D vcalloc(argp->opcnt, sizeof(*argp->ops));
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 570065285e67..54a96042f5ac 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -57,9 +57,6 @@ struct readdir_cd {
>  	__be32			err;	/* 0, nfserr, or nfserr_eof */
>  };
> =20
> -/* Maximum number of operations per session compound */
> -#define NFSD_MAX_OPS_PER_COMPOUND	50
> -
>  struct nfsd_genl_rqstp {
>  	struct sockaddr		rq_daddr;
>  	struct sockaddr		rq_saddr;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aa2a356da784..a23bc56051ca 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -870,7 +870,6 @@ struct nfsd4_compoundargs {
>  	char *				tag;
>  	u32				taglen;
>  	u32				minorversion;
> -	u32				client_opcnt;
>  	u32				opcnt;
>  	bool				splice_ok;
>  	struct nfsd4_op			*ops;

--=20
Jeff Layton <jlayton@kernel.org>

