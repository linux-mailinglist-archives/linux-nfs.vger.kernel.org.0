Return-Path: <linux-nfs+bounces-15377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52688BEDC72
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9414E12BD
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394527FB05;
	Sat, 18 Oct 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="yaN4Oz4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SllUNUV6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98761A9F8C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760826780; cv=none; b=d6k0oY7chCFRrMFmGRYd4KGWWAGVWyh3/fNBRQOoZkgWxW4tsJJiAcW2PaQrhJl9QpYs3rMv4RJ2aGC7HFPibPXTV+p4OqiUaJdBU77c50CDIJCAXElR90g1Wq6TqkRghnjJI9TTH/B0g3FyB9wcvtevPv53CtP6SFnYZuRgWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760826780; c=relaxed/simple;
	bh=NeSHhB5Wl4NVI5HR046tO7+jTFytuTmJjU0gWgDdGXk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tnu1h7XQdMtq7As/vvR+IvzemamMfdXMOW9pZFdRexjiJmUK+217H2e9sjOxGestDrhOmH4TqgClEDuCjxqc3Mptwt5aF0WX7rbUibC3ueT3bAqmqk3P0NgNWynNOrmgqYOTZBdn6uG9+jr6iuWTueesddbF0uxhi7pzsENGx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=yaN4Oz4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SllUNUV6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A929F7A0081;
	Sat, 18 Oct 2025 18:32:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 18 Oct 2025 18:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760826777; x=1760913177; bh=SaH+lcfMoVqmGUbmVZaTEdxW7qmEDUNn5Mh
	xrVR0n20=; b=yaN4Oz4GYmKRSINvSRdfBdYRAmKCpmdotGAavvOT0LHFJRB66si
	wju5/pYlAetsUYAjTmzy4di/nKIhO4Kl5D32029vMGL5MLXThRTqltnMsPJiymjr
	giAbIsG0l8xKOiGnNV7/ZVYQdYkcNwJAGqZEGbLDZDdSm3JIjokRTroEXzGcmUzu
	Xe09iw+ovvx8t1aAXk6Jm4tCG7b5erAzL92EZQVQpGzBGmCKcWYxqz9/83+iIA90
	hdj/XKYjb2qOW7Kq2AGP7poYy11pkJ6gxTEq2C+bvouekNUzErvHlQh/CcpgjM/P
	ey6whsE/l/FKqxLY4EKtHwkRH8WW3mnYC4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760826777; x=
	1760913177; bh=SaH+lcfMoVqmGUbmVZaTEdxW7qmEDUNn5MhxrVR0n20=; b=S
	llUNUV6K8vLpFNg5RfV4xT6lyW5U1+XG0dPyDCkNh+PTWDJSj68lobT2w6BOf8I9
	4y5qkqqrgkcGI8SXdan9PoLx6tRn2vib+n61/yc12TZmH16lR4q3lsqXvvP4iFUc
	7blxZ8tGs16c/VevQLvVouCs0SlVwGluBEotNJ6QA4LYK+8UgyQRJO6k7O1QCvIe
	pRKV8vlnlFxkI1fjtHVxNeuVWVwUWJ5tVZWj2bTqnr5TqRfBSgf1h0ODRf0Cowh9
	rg64bRujrwvbtGbzcGFGjQenoHxrruoKk0kOsvvWHXRgw+i+vBfzhBSCiDnPL32c
	D2Ap4oQrHOHkJyBOYOk/A==
X-ME-Sender: <xms:mRX0aKQzJmmkuk6f9-k2iHyc6Nyv7swiANhWCaXN8FdjuPiHos4IOA>
    <xme:mRX0aDeWSuLbDiFDesOt3Gmq33RbCozYgEunr78-DEEISDn_u-S4lXndYS1g2a8z7
    Vd_1O03AjndAmP7uJt0l12iNlShSNvY6pL2n6lSBW0k491MFw>
X-ME-Received: <xmr:mRX0aBq6LtIIvAcTrl268zW_dJctqEt6m77znQl8LW-ktjO_gHSBArWgwXXgfeOOBGv_NBR-GrjmW_KZoqlK9LUHqUUqi5SE-Qquo1uvX_ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mRX0aM8I_njRTq0zqGon5TPvnYehCJyl4ULinjfX0DWuvZ7l-FGJww>
    <xmx:mRX0aFeJXceiw2cWsVQBgj9xZnNYsnYRPbTCvUiqK9dhf8deswhgxA>
    <xmx:mRX0aOLCm4mSEzhQiKLxWfycFV3wONqNLJA9jtGWQfGd8FCVhz0YdQ>
    <xmx:mRX0aNh8yTrTJlulr-TlKPymJonVA1EYiZrXqIjq8dYFAafDQHZHoA>
    <xmx:mRX0aLx50UCu482IRkZDNuB8npBPr5qTElVjhfVlnf1VekPYExrya9dk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 18:32:55 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/7] nfsd: discard ->op_set_currentstateid()
In-reply-to: <88778ac6-b616-4a1b-9607-4112a059bf1e@oracle.com>
References: <20251018000553.3256253-1-neilb@ownmail.net>,
 <20251018000553.3256253-4-neilb@ownmail.net>,
 <88778ac6-b616-4a1b-9607-4112a059bf1e@oracle.com>
Date: Sun, 19 Oct 2025 09:32:52 +1100
Message-id: <176082677222.1793333.12167530477548233033@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Chuck Lever wrote:
> On 10/17/25 8:02 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > It is not clear that the indirection provided by op_set_currentstateid()
> > adds any value.
> > It is only called immediately after the only call to ->op_func() if that
> > function call returned 0.
> >=20
> > This patch discards op_set_currentstateid() and instead interpolates the
> > contents (each a single call to put_stateid()) into each relevant op_func=
()
> >=20
> > Previously the put_stateid() call was only made on success.  While it is
> > only needed on success it is not harmful do make the call in the error
> > code.  It simply copies a stateid (which could be invalid) into a place
> > from where it will never be used, as after and error, no further ops are
> > attempted.
> >=20
> > So the new code calls put_state() without checking 'status'.
>=20
> What kind of testing can be done to ensure this part of the refactoring
> is safe to do?

I don't think there is any focussed testing that would help.
The hypothesis is that in the cases where behaviour is changed, the
behaviour is irrelevant.  The stored stateid will never be used, so we
can store anything or nothing there and it won't have any effect.

To test that hypothesis I can only think of running all normal tests and
seeing if any behaviour changes.

>=20
> One more comment below.
>=20
>=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/current_stateid.h | 12 +----------
> >  fs/nfsd/nfs4proc.c        |  8 +-------
> >  fs/nfsd/nfs4state.c       | 43 +++++++--------------------------------
> >  fs/nfsd/xdr4.h            |  2 --
> >  4 files changed, 9 insertions(+), 56 deletions(-)
> >=20
> > diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> > index 7c6dfd6c88e7..8eb0f689b3e3 100644
> > --- a/fs/nfsd/current_stateid.h
> > +++ b/fs/nfsd/current_stateid.h
> > @@ -7,16 +7,6 @@
> > =20
> >  void clear_current_stateid(struct nfsd4_compound_state *cstate);
> >  void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > -/*
> > - * functions to set current state id
> > - */
> > -extern void nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *,
> > -		union nfsd4_op_u *);
> > -extern void nfsd4_set_openstateid(struct nfsd4_compound_state *,
> > -		union nfsd4_op_u *);
> > -extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
> > -		union nfsd4_op_u *);
> > -extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
> > -		union nfsd4_op_u *);
> > +void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > =20
> >  #endif   /* _NFSD4_CURRENT_STATE_H */
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 41a8db955aa3..5b41a5cf548b 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -644,6 +644,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> >  	}
> >  	nfsd4_cleanup_open_state(cstate, open);
> >  	nfsd4_bump_seqid(cstate, status);
> > +	put_stateid(cstate, &u->open.op_stateid);
> >  	return status;
> >  }
> > =20
> > @@ -2928,9 +2929,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> >  			goto out;
> >  		}
> >  		if (!op->status) {
> > -			if (op->opdesc->op_set_currentstateid)
> > -				op->opdesc->op_set_currentstateid(cstate, &op->u);
> > -
> >  			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
> >  				clear_current_stateid(cstate);
> > =20
> > @@ -3367,7 +3365,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  		.op_flags =3D OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_CLOSE",
> >  		.op_rsize_bop =3D nfsd4_status_stateid_rsize,
> > -		.op_set_currentstateid =3D nfsd4_set_closestateid,
> >  	},
> >  	[OP_COMMIT] =3D {
> >  		.op_func =3D nfsd4_commit,
> > @@ -3411,7 +3408,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  				OP_NONTRIVIAL_ERROR_ENCODE,
> >  		.op_name =3D "OP_LOCK",
> >  		.op_rsize_bop =3D nfsd4_lock_rsize,
> > -		.op_set_currentstateid =3D nfsd4_set_lockstateid,
> >  	},
> >  	[OP_LOCKT] =3D {
> >  		.op_func =3D nfsd4_lockt,
> > @@ -3447,7 +3443,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  		.op_flags =3D OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_OPEN",
> >  		.op_rsize_bop =3D nfsd4_open_rsize,
> > -		.op_set_currentstateid =3D nfsd4_set_openstateid,
> >  	},
> >  	[OP_OPEN_CONFIRM] =3D {
> >  		.op_func =3D nfsd4_open_confirm,
> > @@ -3460,7 +3455,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  		.op_flags =3D OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_OPEN_DOWNGRADE",
> >  		.op_rsize_bop =3D nfsd4_status_stateid_rsize,
> > -		.op_set_currentstateid =3D nfsd4_set_opendowngradestateid,
> >  	},
> >  	[OP_PUTFH] =3D {
> >  		.op_func =3D nfsd4_putfh,
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 18c8d3529d55..59abe1ab490d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7738,6 +7738,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
> >  	nfs4_put_stid(&stp->st_stid);
> >  out:
> >  	nfsd4_bump_seqid(cstate, status);
> > +	put_stateid(cstate, &u->open_downgrade.od_stateid);
> >  	return status;
> >  }
> > =20
> > @@ -7822,6 +7823,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >  	/* put reference from nfs4_preprocess_seqid_op */
> >  	nfs4_put_stid(&stp->st_stid);
> >  out:
> > +	put_stateid(cstate, &close->cl_stateid);
> >  	return status;
> >  }
> > =20
> > @@ -8457,6 +8459,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	nfsd4_bump_seqid(cstate, status);
> >  	if (conflock)
> >  		locks_free_lock(conflock);
> > +	put_stateid(cstate, &lock->lk_resp_stateid);
> > +
> >  	return status;
> >  }
> > =20
> > @@ -9082,13 +9086,11 @@ get_stateid(struct nfsd4_compound_state *cstate, =
stateid_t *stateid)
> >  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
> >  }
> > =20
> > -static void
> > +void
> >  put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
> >  {
> > -	if (cstate->minorversion) {
> > -		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> > -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> > -	}
> > +	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> > +	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>=20
> I'm not following why the above change is needed or safe ?

I didn't mean to remove that test but I think I can see how I did it
accidentally.
But having done it, I think I like it.  I would need to change
get_stateid() to test for ->minorversion instead but I think the test
makes more sense there.

But I don't need to make that change, and it doesn't really fit with the
main purpose of the patch, so I'll restore the current behaviour.

Thanks,
NeilBrown



>=20
> I'm OK with removing op_set_currentstateid, but let's dig into these
> two issues to ensure that this patch handles all the corner cases
> properly.
>=20
>=20
> >  }
> > =20
> >  void
> > @@ -9097,37 +9099,6 @@ clear_current_stateid(struct nfsd4_compound_state =
*cstate)
> >  	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> >  }
> > =20
> > -/*
> > - * functions to set current state id
> > - */
> > -void
> > -nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
> > -		union nfsd4_op_u *u)
> > -{
> > -	put_stateid(cstate, &u->open_downgrade.od_stateid);
> > -}
> > -
> > -void
> > -nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
> > -		union nfsd4_op_u *u)
> > -{
> > -	put_stateid(cstate, &u->open.op_stateid);
> > -}
> > -
> > -void
> > -nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
> > -		union nfsd4_op_u *u)
> > -{
> > -	put_stateid(cstate, &u->close.cl_stateid);
> > -}
> > -
> > -void
> > -nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
> > -		union nfsd4_op_u *u)
> > -{
> > -	put_stateid(cstate, &u->lock.lk_resp_stateid);
> > -}
> > -
> >  /**
> >   * nfsd4_vet_deleg_time - vet and set the timespec for a delegated times=
tamp update
> >   * @req: timestamp from the client
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index b94408601203..368bad2c7efe 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -1043,8 +1043,6 @@ struct nfsd4_operation {
> >  	/* Try to get response size before operation */
> >  	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
> >  			const struct nfsd4_op *op);
> > -	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
> > -			union nfsd4_op_u *);
> >  };
> > =20
> >  struct nfsd4_cb_recall_any {
>=20
>=20
> --=20
> Chuck Lever
>=20


