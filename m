Return-Path: <linux-nfs+bounces-2196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0708710DF
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF801C21EF6
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B357C0A8;
	Mon,  4 Mar 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzoV06iW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FD7B3FA
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593492; cv=none; b=b7qFytKzdft7sAZRAuDGZZnKMr6Pa2AI8BJsck3oYuzRfghyouXdhLaOTedHKWCBRwIG1jyqtX2r3VTWDD1qynnXePFm2XGfHQNQBzTVZVmDGw4CzhkEyGuWKsjrD3WgFQdHx02CNAgPeXOBgrDk07Pl8tqM/6TK6OZ7vPTnwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593492; c=relaxed/simple;
	bh=ruGeabapgkruV2Sfonwxk4y86qnmId8daVWvZu9Gn2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+HltnvYeaxeACKeO1fIivysCLMc3+C78jyOjUE1gDHZwIVX6JnbeU4JisO4lWtYrnp3iip8Nm9Vam6LMNpdce5WFqNzRq2M4PvwtToHr9inIzuV0pOjNjZNjaKj5ckH7ss6WdcXYIHMaX87FLL5UdJdUnw95Pd7HSnToRiw8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzoV06iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE2C433F1;
	Mon,  4 Mar 2024 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593492;
	bh=ruGeabapgkruV2Sfonwxk4y86qnmId8daVWvZu9Gn2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mzoV06iW8Vs/Rl2T4Qt/8LDxlEHEHAp0lKe5rwge1Aa4/g0Z0vF4iDphcJhwTQcBq
	 sVGlr972/4yPqmMrBHzNgWGNh0dgpJP5rscnSfXpykWtLmpdEAgG3uj6345Ip1YRJB
	 XRBXfGYW/EN463Au5OUKijH4bFIe3tJ6O6i4/zsSs7ej2Ttr+rIUNQVKm49skoffDi
	 yovmKWkV4pDTjOr/7bAStaEizVWpDwmA0ABfEDnpDDysU9GTH223SjCPdizjEBN9F7
	 cJikTVKN5f+tX3TtZHto2Y8lRyA/WsBBEy/8QM6qQUpG70VhrgTcsypX1kmAM4gtXp
	 n7Y16Gte+0UhA==
Message-ID: <7b60dc89044de2a973282cf76033940c24a6d814.camel@kernel.org>
Subject: Re: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in
 the one place.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Date: Mon, 04 Mar 2024 18:04:50 -0500
In-Reply-To: <170958848677.24797.14503972307018020397@noble.neil.brown.name>
References: <20240304044304.3657-1-neilb@suse.de>
	, <20240304044304.3657-3-neilb@suse.de>
	, <5de242d62709e11a18406981b189c0476b5da5ca.camel@kernel.org>
	 <170958848677.24797.14503972307018020397@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 08:41 +1100, NeilBrown wrote:
> On Mon, 04 Mar 2024, Jeff Layton wrote:
> > On Mon, 2024-03-04 at 15:40 +1100, NeilBrown wrote:
> > > Currently find_openstateowner_str looks are done both in
> > > nfsd4_process_open1() and alloc_init_open_stateowner() - the latter
> > > possibly being a surprise based on its name.
> > >=20
> > > It would be easier to follow, and more conformant to common patterns,=
 if
> > > the lookup was all in the one place.
> > >=20
> > > So replace alloc_init_open_stateowner() with
> > > find_or_alloc_open_stateowner() and use the latter in
> > > nfsd4_process_open1() without any calls to find_openstateowner_str().
> > >=20
> > > This means all finds are find_openstateowner_str_locked() and
> > > find_openstateowner_str() is no longer needed.  So discard
> > > find_openstateowner_str() and rename find_openstateowner_str_locked()=
 to
> > > find_openstateowner_str().
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 93 +++++++++++++++++++------------------------=
--
> > >  1 file changed, 40 insertions(+), 53 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 2f1e465628b1..690d0e697320 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -539,7 +539,7 @@ same_owner_str(struct nfs4_stateowner *sop, struc=
t xdr_netobj *owner)
> > >  }
> > > =20
> > >  static struct nfs4_openowner *
> > > -find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_op=
en *open,
> > > +find_openstateowner_str(unsigned int hashval, struct nfsd4_open *ope=
n,
> > >  			struct nfs4_client *clp)
> > >  {
> > >  	struct nfs4_stateowner *so;
> > > @@ -556,18 +556,6 @@ find_openstateowner_str_locked(unsigned int hash=
val, struct nfsd4_open *open,
> > >  	return NULL;
> > >  }
> > > =20
> > > -static struct nfs4_openowner *
> > > -find_openstateowner_str(unsigned int hashval, struct nfsd4_open *ope=
n,
> > > -			struct nfs4_client *clp)
> > > -{
> > > -	struct nfs4_openowner *oo;
> > > -
> > > -	spin_lock(&clp->cl_lock);
> > > -	oo =3D find_openstateowner_str_locked(hashval, open, clp);
> > > -	spin_unlock(&clp->cl_lock);
> > > -	return oo;
> > > -}
> > > -
> > >  static inline u32
> > >  opaque_hashval(const void *ptr, int nbytes)
> > >  {
> > > @@ -4588,34 +4576,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4=
_file *fp, struct nfsd4_open *open)
> > >  }
> > > =20
> > >  static struct nfs4_openowner *
> > > -alloc_init_open_stateowner(unsigned int strhashval, struct nfsd4_ope=
n *open,
> > > -			   struct nfsd4_compound_state *cstate)
> > > +find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_=
open *open,
> > > +			      struct nfsd4_compound_state *cstate)
> > >  {
> > >  	struct nfs4_client *clp =3D cstate->clp;
> > > -	struct nfs4_openowner *oo, *ret;
> > > +	struct nfs4_openowner *oo, *new =3D NULL;
> > > =20
> > > -	oo =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
> > > -	if (!oo)
> > > -		return NULL;
> > > -	oo->oo_owner.so_ops =3D &openowner_ops;
> > > -	oo->oo_owner.so_is_open_owner =3D 1;
> > > -	oo->oo_owner.so_seqid =3D open->op_seqid;
> > > -	oo->oo_flags =3D 0;
> > > -	if (nfsd4_has_session(cstate))
> > > -		oo->oo_flags |=3D NFS4_OO_CONFIRMED;
> > > -	oo->oo_time =3D 0;
> > > -	oo->oo_last_closed_stid =3D NULL;
> > > -	INIT_LIST_HEAD(&oo->oo_close_lru);
> > > -	spin_lock(&clp->cl_lock);
> > > -	ret =3D find_openstateowner_str_locked(strhashval, open, clp);
> > > -	if (ret =3D=3D NULL) {
> > > -		hash_openowner(oo, clp, strhashval);
> > > -		ret =3D oo;
> > > -	} else
> > > -		nfs4_free_stateowner(&oo->oo_owner);
> > > +	while (1) {
> > > +		spin_lock(&clp->cl_lock);
> > > +		oo =3D find_openstateowner_str(strhashval, open, clp);
> > > +		if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> > > +			/* Replace unconfirmed owners without checking for replay. */
> > > +			release_openowner(oo);
> > > +			oo =3D NULL;
> > > +		}
> > > +		if (oo) {
> > > +			spin_unlock(&clp->cl_lock);
> > > +			if (new)
> > > +				nfs4_free_stateowner(&new->oo_owner);
> > > +			return oo;
> > > +		}
> > > +		if (new) {
> > > +			hash_openowner(new, clp, strhashval);
> > > +			spin_unlock(&clp->cl_lock);
> > > +			return new;
> > > +		}
> > > +		spin_unlock(&clp->cl_lock);
> > > =20
> > > -	spin_unlock(&clp->cl_lock);
> > > -	return ret;
> > > +		new =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
> > > +		if (!new)
> > > +			return NULL;
> > > +		new->oo_owner.so_ops =3D &openowner_ops;
> > > +		new->oo_owner.so_is_open_owner =3D 1;
> > > +		new->oo_owner.so_seqid =3D open->op_seqid;
> > > +		new->oo_flags =3D 0;
> > > +		if (nfsd4_has_session(cstate))
> > > +			new->oo_flags |=3D NFS4_OO_CONFIRMED;
> > > +		new->oo_time =3D 0;
> > > +		new->oo_last_closed_stid =3D NULL;
> > > +		INIT_LIST_HEAD(&new->oo_close_lru);
> > > +	}
> >=20
> > The while (1) makes the control flow a little weird here, but the logic
> > seems correct.
>=20
> Would you prefer a goto?  That is more consistent with common patterns.
> I'll do that.
>=20

Ok, that works. I don't have a strong preference either way, so whatever
you think is easiest on the eyes.

> >=20
> > >  }
> > > =20
> > >  static struct nfs4_ol_stateid *
> > > @@ -5064,28 +5064,15 @@ nfsd4_process_open1(struct nfsd4_compound_sta=
te *cstate,
> > >  	clp =3D cstate->clp;
> > > =20
> > >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> > > -	oo =3D find_openstateowner_str(strhashval, open, clp);
> > > +	oo =3D find_or_alloc_open_stateowner(strhashval, open, cstate);
> > >  	open->op_openowner =3D oo;
> > >  	if (!oo)
> > > -		goto new_owner;
> > > -	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> > > -		/* Replace unconfirmed owners without checking for replay. */
> > > -		release_openowner(oo);
> > > -		open->op_openowner =3D NULL;
> > > -		goto new_owner;
> > > -	}
> > > +		return nfserr_jukebox;
> > >  	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid)=
;
> > >  	if (status)
> > >  		return status;
> > > -	goto alloc_stateid;
> > > -new_owner:
> > > -	oo =3D alloc_init_open_stateowner(strhashval, open, cstate);
> > > -	if (oo =3D=3D NULL)
> > > -		return nfserr_jukebox;
> > > -	open->op_openowner =3D oo;
> > > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > > -alloc_stateid:
> > > +
> > >  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
> > >  	if (!open->op_stp)
> > >  		return nfserr_jukebox;
> >=20
> > Nice cleanup overall:
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Thanks.
> BTW I've moved this to the start of the series - but kept your SoB.
> That avoid having one patch add code that the next patch removes.
>=20

Sounds good.
--=20
Jeff Layton <jlayton@kernel.org>

