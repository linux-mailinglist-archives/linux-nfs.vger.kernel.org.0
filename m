Return-Path: <linux-nfs+bounces-4928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB21931784
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404B41F22194
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C318EA6F;
	Mon, 15 Jul 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b78LWNtC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393318C35B
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056894; cv=none; b=rTK6BZeIdOjLJpODGYzz4LLGT1VfHGGVnJKqTECOoRH0QxyMyejt9/DXfEbCWl3i76Z7puMVEZJk03H900M80wGK/p3K2z8wCwn1tGwIvrH/w39TnjaHAopd6vSob7Ef2SvHB27QrIH/HJtQlSDa2/DP/PJWenPtU35WSV28AaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056894; c=relaxed/simple;
	bh=JZ33jT8IC8r7jk171HMCeY5ZfAwmlRKd5yUYKLz3nNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgzyozXTeSEXzir38eoPeDqbvfQ9T5/4UBVtwxbTABBheiOdVKxVyqQsg5HtZOFoilHOhf+rC85bklbY1ngC8R6404cqgVJX57RPWOr0efBlBGy5x5oA2iT9aSaH0qbhKRgBSiubSAbGmdr1txnTGAca3f9qckEQ+4yQeGqOZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b78LWNtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766CC4AF0D;
	Mon, 15 Jul 2024 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721056894;
	bh=JZ33jT8IC8r7jk171HMCeY5ZfAwmlRKd5yUYKLz3nNc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b78LWNtCvk5B6l+0KcaioRSwOdo3syIGBmAC1PLRCHA8l5WLOCWq2602OrU/pAGwE
	 9djDzuMSJ1i5Z31bwz8TrQAvQQtvskL7/VyQs5KRBEN8klarWGEdgK8gydbOsQHT6r
	 EnzbYL+OXGfrP1irL11M1olmS4NUnID1nSHqQV7+F2pjYhMLpIP+YzPoPMBet4I5Gq
	 Q9gn/A8XRgbEFnld0qsNUYCe5qSrHowIAQo3zjEFy+ZdPXS5W+wKhVXYhElLDp7w9n
	 g6VhB4tEMkCxpTAZ5yX2foSa7sM6SFHRMLoUISfvOyDBJSKjgQ5SP6zbT8TRLSTEFx
	 uth3oeyCFWO1w==
Message-ID: <c4d862487377da1a8b9a5d48f8cf27b1c9fa95d3.camel@kernel.org>
Subject: Re: [PATCH 09/14] nfsd: return hard failure for OP_SETCLIENTID when
 there are too many clients.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 11:21:32 -0400
In-Reply-To: <20240715074657.18174-10-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-10-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> If there are more non-courteous clients than the calculated limit, we
> should fail the request rather than report a soft failure and
> encouraging the client to retry indefinitely.
>=20
> If there a courteous clients which push us over the limit, then expedite
> their removal.
>=20
> This is not known to have caused a problem is production use, but
> testing of lots of clients reports repeated NFS4ERR_DELAY responses
> which doesn't seem helpful.
>=20
> Also remove an outdated comment - we do use a slab cache.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/nfs4state.c | 23 +++++++++++++----------
> =C2=A01 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..88936f3189e1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2212,21 +2212,20 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net =
*nn)
> =C2=A0	return 1;
> =C2=A0}
> =C2=A0
> -/*=20
> - * XXX Should we use a slab cache ?
> - * This type of memory management is somewhat inefficient, but we use it
> - * anyway since SETCLIENTID is not a common operation.
> - */
> =C2=A0static struct nfs4_client *alloc_client(struct xdr_netobj name,
> =C2=A0				struct nfsd_net *nn)
> =C2=A0{
> =C2=A0	struct nfs4_client *clp;
> =C2=A0	int i;
> =C2=A0
> -	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients) {
> +	if (atomic_read(&nn->nfs4_client_count) -
> +	=C2=A0=C2=A0=C2=A0 atomic_read(&nn->nfsd_courtesy_clients) >=3D nn->nfs=
4_max_clients)
> +		return ERR_PTR(-EREMOTEIO);
> +

nit: I know it gets remapped, but why EREMOTEIO? From nfsd's standpoint
this would seem to imply a problem on the client. Maybe:

#define EUSERS          87      /* Too many users */

...instead?

> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients &&
> +	=C2=A0=C2=A0=C2=A0 atomic_read(&nn->nfsd_courtesy_clients) > 0)
> =C2=A0		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -		return NULL;
> -	}
> +
> =C2=A0	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
> =C2=A0	if (clp =3D=3D NULL)
> =C2=A0		return NULL;
> @@ -3115,8 +3114,8 @@ static struct nfs4_client *create_client(struct xdr=
_netobj name,
> =C2=A0	struct dentry *dentries[ARRAY_SIZE(client_files)];
> =C2=A0
> =C2=A0	clp =3D alloc_client(name, nn);
> -	if (clp =3D=3D NULL)
> -		return NULL;
> +	if (IS_ERR_OR_NULL(clp))
> +		return clp;
> =C2=A0
> =C2=A0	ret =3D copy_cred(&clp->cl_cred, &rqstp->rq_cred);
> =C2=A0	if (ret) {
> @@ -3498,6 +3497,8 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> =C2=A0	new =3D create_client(exid->clname, rqstp, &verf);
> =C2=A0	if (new =3D=3D NULL)
> =C2=A0		return nfserr_jukebox;
> +	if (IS_ERR(new))
> +		return nfserr_resource;
> =C2=A0	status =3D copy_impl_id(new, exid);
> =C2=A0	if (status)
> =C2=A0		goto out_nolock;
> @@ -4416,6 +4417,8 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> =C2=A0	new =3D create_client(clname, rqstp, &clverifier);
> =C2=A0	if (new =3D=3D NULL)
> =C2=A0		return nfserr_jukebox;
> +	if (IS_ERR(new))
> +		return nfserr_resource;
> =C2=A0	spin_lock(&nn->client_lock);
> =C2=A0	conf =3D find_confirmed_client_by_name(&clname, nn);
> =C2=A0	if (conf && client_has_state(conf)) {

Patch looks fine otherwise though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

