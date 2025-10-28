Return-Path: <linux-nfs+bounces-15720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1FC129D6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 03:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185D63A6DEE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD751917D0;
	Tue, 28 Oct 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BUI2N4Fd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4gHPPSV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00213D8B1
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616916; cv=none; b=lnqsF3jWlyQNCVwl7Ikidoxdaq4fRilFBFqMrBkZYYxmLmBIHiZONhJigpmYEURS2I/pceVJ/bAE5ndhNvLQ+/1QTq6InixKI+5kg5Y56T8oEecy+7NyGa7Dwh+HBkerfy67U6GMOc+s2a/NSFLHgaNDSm7Fg7DxZd8EoC+qEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616916; c=relaxed/simple;
	bh=n2xhZ37Ya4jvoIkROEUMCvnhybA4bKVMlCYyFhzCbmQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=g5ba9U4R3mW7xKtAkpFzvkYze1lUSqgM6epqkloymyu4E9+bC1J+vhCxqQwp+HdoIG7yDq/NS5EwbiV+NixUV7N4Z5MXBwfpVBU5iU2T9zkrQwtbt1UsqMHjj/Ch3SJREmfgkxGw3m1kOnyulWe0/+XOD/yahQIFj4AJTkalYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BUI2N4Fd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4gHPPSV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A9B16EC0209;
	Mon, 27 Oct 2025 22:01:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 22:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761616912; x=1761703312; bh=2fVXsf9OVHl99KcTtECZdfVyZLSm0M0zUSD
	yu8Nf2Fg=; b=BUI2N4Fdv5R1QdzX5ez758F6+p2oSIWrcchjKhlliTAi1RX9zEY
	jP1Fp3gPbuLdc5iduwZlwjkOk6Ju+BAFbn6rmr4oGTrZUjFKyKwmKHvqul7XA/Sk
	PTtGVQJVahm15f6RYMG8tvCDj9WqUqSfp722bwDRGKKTYdMbl6gVcAS13LxZdHSW
	hiS0bv2VW7N1lO5QoNFfvxwjgN4EOEhQfobLwB6AuPIWS2Muxvzk1Mh4FsJYzpxn
	r+kT7MHR0z0/Ah99BTLWTP6FPChS0qwuCzVS7KW1XBkzsjDWgwQu8ZKl8YUX+iXJ
	Kv2k0s3wAmTmWafVYcC6vmuemwQqv15/Qug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761616912; x=
	1761703312; bh=2fVXsf9OVHl99KcTtECZdfVyZLSm0M0zUSDyu8Nf2Fg=; b=G
	4gHPPSVntvYO3RVFOIa2UzHvkA88C/BpBfcpVpijN49ePuWQxvHYjEohuauQW/2e
	kfy1HbgquwFO2DQSlNoBgUE8TGM5eXcbaKsavYCslq7fBwsacQ3IXYFeWyLFat7w
	m8Otd7qpcVrGA1Uo3Oipv/oqXGIAcF7DGZ3unDoPPbvxDL341Dc8Ww7bS1e8dzrv
	tkWx4SqjQXI1q3+nUPNKrYlyqr70cDpHkFT1g8CprkN7PffkNpERALvYB9y1yq4E
	8g4SYNdpppCQECN2vn9rsFeoObbHNECeRXltzbvgHfn9v8CpRupDq25A1D+Di5mj
	z7kQ2VfHmJNbauycx1hBg==
X-ME-Sender: <xms:ECQAaZP3BluyS9cfee_puu4IVMImQroF1HYfCFvj9bf72VGj8n4wHA>
    <xme:ECQAafq8WrHhNti6QHK6LI8sKfcmEICckOOL6oFQbSXWfdeM02OHgXAA5J4mkD3pa
    9emcPGQtEdyPt3Q6_3k2qZPPZOILWVB4Vy8_E3cCocnOoPk>
X-ME-Received: <xmr:ECQAaSFtplRFpYGwG_3j3AKEg0862cSg7KRSBks6t0syB3SbJwTVe2EdBlWz7J7WZsqucbiU_-v73OfBo3pnD_wikV0UtQyB9hQJzCNYSSqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheelheelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ECQAacqMQa2ua62x9khCCzJ1QcioB0yNVCvY6pfOFvo78Ap53zntYQ>
    <xmx:ECQAaTY9FAZ6AoqEpxenNnErVhSb16393_c60v8Q5jg1w2A0xfs_nw>
    <xmx:ECQAadWylJYb6xo2oxlJop55u66nV2wzAZy6DITkjS0m7a5n2HIWXw>
    <xmx:ECQAaU_5X1bukxDXeCsDrz5051k4wAc03dDQGwmpUZ631Lu60BB_uw>
    <xmx:ECQAacZVrAVWM3W_T0Ij1MGSWvPqph5-pEgkXu6xvYhE13qCESOYQNE8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 22:01:50 -0400 (EDT)
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
Subject: Re: [PATCH v3 04/10] nfsd: prepare XXX_current_stateid() functions to
 be non-static
In-reply-to: <37433325-0bc4-449f-93c5-fa747af7f7f0@oracle.com>
References: <20251026222655.3617028-1-neilb@ownmail.net>,
 <20251026222655.3617028-5-neilb@ownmail.net>,
 <e7d0dcf25d578c64634ec841a551b6463954a29b.camel@kernel.org>,
 <37433325-0bc4-449f-93c5-fa747af7f7f0@oracle.com>
Date: Tue, 28 Oct 2025 13:01:38 +1100
Message-id: <176161689881.1793333.6227216051661923047@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 28 Oct 2025, Chuck Lever wrote:
> On 10/27/25 8:48 AM, Jeff Layton wrote:
> > On Mon, 2025-10-27 at 09:23 +1100, NeilBrown wrote:
> >> +void
> >> +nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid=
_t *stateid)
> >=20
> > nit: consider a different verb from "get" here. Maybe "fetch" or even
> > "restore"?
> >=20
> > We have a lot of get/put functions in nfsd that refer to refcounting,
> > so this looks like it's going to take a reference to something even
> > when it doesn't.
>=20
> How about:
>=20
>  - "copy current stateid"

This is the difficult one to name as the behaviour of the function is
conditional.
if the given state-id is the special "current stateid" then use the
saved "current stateid".

Also there is potential confusion of what "current stateid" means.
It primarily means the stateid stored from a previous op, but we are
also using the term to also mean the special stateid which the RFC
describes as "designating the current stateid".

The RFC has text like:
  but the current stateid set by the previous operation is actually used
  when the operation is evaluated.

which suggests "use_current_stateid()" might be appropriate, but as we
only do that if the given stateid designates the current stateid then
maybe
   cond_use_current_stateid()
which is a bit clumsy.

Maybe a different approach could improve things.  With the exception of
FREE_STATEID, every op (I think) passes that stateid to
nfsd4_lookup_stateid() as the first usage.  So we could do without a
separate function for this task.  We could use
   if (is_current_stateid(stateid))
           use_current_stateid(cstate, stateid);

or similar.

BTW I noticed that if the op isn't CLOSE or OPEN_DOWNGRADE, when when we
use the current stateid we are supposed to clear si_generation.  I
wonder why as the existing generation should still be valid...

NeilBrown


>=20
>  - "change current stateid" or "update current stateid"
>=20
>  - "clear current stateid"
>=20
> Roughly, this is the terminology used by Section 16.2.3.1.2.
>=20
>=20
> >>  {
> >> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> >> +	if (nfsd4_has_session(cstate) &&
> >> +	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> >>  	    IS_CURRENT_STATEID(stateid))
> >>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
> >>  }
> >> =20
> >> -static void
> >> -put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *state=
id)
> >> +/**
> >> + * nfsd41_save_current_stated - const saved a v4.1 stateid for future o=
perations
> >> + * @cstate - the state of the current COMPOUND procedure
> >> + * @stateid - the stateid field of the current operation
> >> + *
> >> + * This should be called from operations which create or update a state=
id
> >> + * that should be available for future v4.1 ops in the same COMPOUND.
> >> + * It saves the stateid and records that there is a saved stateid.
> >> + * It is safe to call this with any states including v4.0.  v4.0 states
> >> + * will simply be ignored.
> >> + */
> >> +void
> >> +nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, const =
stateid_t *stateid)
> >>  {
> >> -	if (cstate->minorversion) {
> >> -		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> >> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> >> -	}
> >> +	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> >> +	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> >>  }
> >> =20
> >> -void
> >> -clear_current_stateid(struct nfsd4_compound_state *cstate)
> >> +/**
> >> + * nfsd41_clear_current_stated - clear the saved v4.1 stateid
> >> + * @cstate - the state of the current COMPOUND procedure
> >> + *
> >> + * Store the anon_stateid in the current_stateid as required by
> >> + * RFC 8881 section 16.2.3.1.2 when the current filehandle changes
> >> + * without a regular stateid being available.
> >> + */
> >> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
> >>  {
> >> -	put_stateid(cstate, &anon_stateid);
> >> +	nfsd41_save_current_stateid(cstate, &anon_stateid);
> >>  }
> >> =20
> >>  /*
> >> @@ -9113,28 +9140,28 @@ void
> >>  nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	put_stateid(cstate, &u->open_downgrade.od_stateid);
> >> +	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	put_stateid(cstate, &u->open.op_stateid);
> >> +	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	put_stateid(cstate, &u->close.cl_stateid);
> >> +	nfsd41_save_current_stateid(cstate, &u->close.cl_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	put_stateid(cstate, &u->lock.lk_resp_stateid);
> >> +	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
> >>  }
> >> =20
> >>  /*
> >> @@ -9145,56 +9172,56 @@ void
> >>  nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->open_downgrade.od_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->open_downgrade.od_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->delegreturn.dr_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->delegreturn.dr_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->free_stateid.fr_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->free_stateid.fr_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->setattr.sa_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->setattr.sa_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->close.cl_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->close.cl_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->locku.lu_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->locku.lu_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->read.rd_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->read.rd_stateid);
> >>  }
> >> =20
> >>  void
> >>  nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> >>  		union nfsd4_op_u *u)
> >>  {
> >> -	get_stateid(cstate, &u->write.wr_stateid);
> >> +	nfsd41_get_current_stateid(cstate, &u->write.wr_stateid);
> >>  }
> >> =20
> >>  /**
> >> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> >> index ae75846b3cd7..e2a5fb926848 100644
> >> --- a/fs/nfsd/xdr4.h
> >> +++ b/fs/nfsd/xdr4.h
> >> @@ -202,6 +202,12 @@ static inline bool nfsd4_has_session(struct nfsd4_c=
ompound_state *cs)
> >>  	return cs->slot !=3D NULL;
> >>  }
> >> =20
> >> +void nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate,
> >> +				stateid_t *stateid);
> >> +void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
> >> +				 const stateid_t *stateid);
> >> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate);
> >> +
> >>  struct nfsd4_change_info {
> >>  	u32		atomic;
> >>  	u64		before_change;
> >=20
> > Otherwise the patch is fine though.
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
>=20
> --=20
> Chuck Lever
>=20


