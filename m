Return-Path: <linux-nfs+bounces-6962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5C99596F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8735A1F250DF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3C17DFE1;
	Tue,  8 Oct 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xd/jclao";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZF+dLwNm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xd/jclao";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZF+dLwNm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D015F3FF;
	Tue,  8 Oct 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424086; cv=none; b=kES2oA1TdD0ae6ykt+yZJYhgA7ZHw8Jx1HXBSMZdmPrVihdBHBdKzWXco4CvMCHivOnL2LpWjyQwGp1cKo+C5io50ceBKasmyxxR1g0aYmpJBHgbwo5TiH7gJuOqY+BFAcKq8KnVgDxVHCxBU1Ac1lEP52nQvtlGW7XLrmOtJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424086; c=relaxed/simple;
	bh=jgceC6mqB61RWcp4aeK/udhRQh3H0/B7bwP3AT/qIBo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C66UFRBDf/iETig1m0Okf2pjVR8BuUHKy2r9iZpiwvvn9oWsjgrPRk0yULgG3nghLzp0JfIJp6TZYLdItTkHO+OJoFljt3y1IHmquE435S6eM+FPxNEMRhf7t4D0S+5borvWVAKogqSp+jqxixXaVJ2CrIozXGCa33WczWYSQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xd/jclao; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZF+dLwNm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xd/jclao; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZF+dLwNm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA1FF21DCE;
	Tue,  8 Oct 2024 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoMR0ibmr71loxkFIfQ6vKAgMByeBFlpJA/nnSPdXS8=;
	b=Xd/jclaotRrnKCREZW7wycpUZJ/byvM4lZqIMFhKMMNRosRPu8fopqLOba/22NLzWB+DF7
	dgcQ7vU1I0Nej8U2ir+NvPJj5Q9/Wlnwdn5Gy6tphcTR2g4ImTJO9mNXoLpC1j/6LKQ4WE
	K6ne3cMdNnwTOVtSuR1o956a/+WFb14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoMR0ibmr71loxkFIfQ6vKAgMByeBFlpJA/nnSPdXS8=;
	b=ZF+dLwNmJGsmAOKIR9BBg8vNwEFzD1zcWoFBb2ghnDd9S13AEfjLqzsjqB3+IRJ2/FXHZ1
	zZ6zcjBjRKuE1+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoMR0ibmr71loxkFIfQ6vKAgMByeBFlpJA/nnSPdXS8=;
	b=Xd/jclaotRrnKCREZW7wycpUZJ/byvM4lZqIMFhKMMNRosRPu8fopqLOba/22NLzWB+DF7
	dgcQ7vU1I0Nej8U2ir+NvPJj5Q9/Wlnwdn5Gy6tphcTR2g4ImTJO9mNXoLpC1j/6LKQ4WE
	K6ne3cMdNnwTOVtSuR1o956a/+WFb14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoMR0ibmr71loxkFIfQ6vKAgMByeBFlpJA/nnSPdXS8=;
	b=ZF+dLwNmJGsmAOKIR9BBg8vNwEFzD1zcWoFBb2ghnDd9S13AEfjLqzsjqB3+IRJ2/FXHZ1
	zZ6zcjBjRKuE1+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D6681340C;
	Tue,  8 Oct 2024 21:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5DbwNI+oBWcHHwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 21:47:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
In-reply-to: <ZwWArwU0XO8Y+Ctb@tissot.1015granger.net>
References: <>, <ZwWArwU0XO8Y+Ctb@tissot.1015granger.net>
Date: Wed, 09 Oct 2024 08:47:55 +1100
Message-id: <172842407597.3184596.2141619392088505446@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024, Chuck Lever wrote:
> On Mon, Oct 07, 2024 at 09:13:17AM +1100, NeilBrown wrote:
> > On Mon, 07 Oct 2024, Chuck Lever wrote:
> > > On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> > > > On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> > > > > Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do no=
t bypass
> > > > > only GSS, but bypass any authentication method. This is problem spe=
cially
> > > > > for NFS3 AUTH_NULL-only exports.
> > > > >=20
> > > > > The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> > > > > section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> > > > > authentication. So few procedures which do not expose security risk=
 used
> > > > > during mount time can be called also with AUTH_NONE or AUTH_SYS, to=
 allow
> > > > > client mount operation to finish successfully.
> > > > >=20
> > > > > The problem with current implementation is that for AUTH_NULL-only =
exports,
> > > > > the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX m=
ount
> > > > > attempts which confuse NFS3 clients, and make them think that AUTH_=
UNIX is
> > > > > enabled and is working. Linux NFS3 client never switches from AUTH_=
UNIX to
> > > > > AUTH_NONE on active mount, which makes the mount inaccessible.
> > > > >=20
> > > > > Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT impleme=
ntation
> > > > > and really allow to bypass only exports which have some GSS auth fl=
avor
> > > > > enabled.
> > > > >=20
> > > > > The result would be: For AUTH_NULL-only export if client attempts t=
o do
> > > > > mount with AUTH_UNIX flavor then it will receive access errors, whi=
ch
> > > > > instruct client that AUTH_UNIX flavor is not usable and will either=
 try
> > > > > other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> > > > >=20
> > > > > This should fix problems with AUTH_NULL-only or AUTH_UNIX-only expo=
rts if
> > > > > client attempts to mount it with other auth flavor (e.g. with AUTH_=
NULL for
> > > > > AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> > > >=20
> > > > The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  Wi=
th
> > > > your change it doesn't.  I don't think we want to make that change.
> > >=20
> > > Neil, I'm not seeing this, I must be missing something.
> > >=20
> > > RPC_AUTH_TLS is used only on NULL procedures.
> > >=20
> > > The export's xprtsec=3D setting determines whether a TLS session must
> > > be present to access the files on the export. If the TLS session
> > > meets the xprtsec=3D policy, then the normal user authentication
> > > settings apply. In other words, I don't think execution gets close
> > > to check_nfsd_access() unless the xprtsec policy setting is met.
> >=20
> > check_nfsd_access() is literally the ONLY place that ->ex_xprtsec_modes
> > is tested and that seems to be where xprtsec=3D export settings are store=
d.
> >=20
> > >=20
> > > I'm not convinced check_nfsd_access() needs to care about
> > > RPC_AUTH_TLS. Can you expand a little on your concern?
> >=20
> > Probably it doesn't care about RPC_AUTH_TLS which as you say is only
> > used on NULL procedures when setting up the TLS connection.
> >=20
> > But it *does* care about NFS_XPRTSEC_MTLS etc.
> >=20
> > But I now see that RPC_AUTH_TLS is never reported by OP_SECINFO as an
> > acceptable flavour, so the client cannot dynamically determine that TLS
> > is required.  So there is no value in giving non-tls clients access to
> > xprtsec=3Dmtls exports so they can discover that for themselves.  The
> > client needs to explicitly mount with tls, or possibly the client can
> > opportunistically try TLS in every case, and call back.
> >=20
> > So the original patch is OK.
>=20
> May I add "Reviewed-by: NeilBrown <neilb@suse.de>" ?

Yes, though I would prefer v2.

I also would love it if NFSD_MAY_BYPASS_GSS were renamed to
NFSD_MAY_BYPASS_SEC.
And NFSD_MAY_LOCK should be discarded, and nlm_fopen() should set
NFSD_MAY_BYPASS_SEC.
And I wonder if there is really any value in having
NFSD_MAY_BYPASS_GSS_ON_ROOT being separate from NFSD_MAY_BYPASS_GSS.

But I'm not offering patches - at least not today - and those concerns
don't need to block this patch.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

>=20
>=20
> > NeilBrown
> >=20
> >=20
> > >=20
> > >=20
> > > > I think that what you want to do makes sense.  Higher security can be
> > > > downgraded to AUTH_UNIX, but AUTH_NULL mustn't be upgraded to to
> > > > AUTH_UNIX.
> > > >=20
> > > > Maybe that needs to be explicit in the code.  The bypass is ONLY allo=
wed
> > > > for AUTH_UNIX and only if something other than AUTH_NULL is allowed.
> > > >=20
> > > > Thanks,
> > > > NeilBrown
> > > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/export.c   | 19 ++++++++++++++++++-
> > > > >  fs/nfsd/export.h   |  2 +-
> > > > >  fs/nfsd/nfs4proc.c |  2 +-
> > > > >  fs/nfsd/nfs4xdr.c  |  2 +-
> > > > >  fs/nfsd/nfsfh.c    | 12 +++++++++---
> > > > >  fs/nfsd/vfs.c      |  2 +-
> > > > >  6 files changed, 31 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > > > index 50b3135d07ac..eb11d3fdffe1 100644
> > > > > --- a/fs/nfsd/export.c
> > > > > +++ b/fs/nfsd/export.c
> > > > > @@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cac=
he_detail *cd,
> > > > >  	return exp;
> > > > >  }
> > > > > =20
> > > > > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *=
rqstp)
> > > > > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *=
rqstp, bool may_bypass_gss)
> > > > >  {
> > > > >  	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nfl=
avors;
> > > > >  	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> > > > > @@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *=
exp, struct svc_rqst *rqstp)
> > > > >  	if (nfsd4_spo_must_allow(rqstp))
> > > > >  		return 0;
> > > > > =20
> > > > > +	/* Some calls may be processed without authentication
> > > > > +	 * on GSS exports. For example NFS2/3 calls on root
> > > > > +	 * directory, see section 2.3.2 of rfc 2623.
> > > > > +	 * For "may_bypass_gss" check that export has really
> > > > > +	 * enabled some GSS flavor and also check that the
> > > > > +	 * used auth flavor is without auth (none or sys).
> > > > > +	 */
> > > > > +	if (may_bypass_gss && (
> > > > > +	     rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> > > > > +	     rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> > > > > +		for (f =3D exp->ex_flavors; f < end; f++) {
> > > > > +			if (f->pseudoflavor =3D=3D RPC_AUTH_GSS ||
> > > > > +			    f->pseudoflavor >=3D RPC_AUTH_GSS_KRB5)
> > > > > +				return 0;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  denied:
> > > > >  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> > > > >  }
> > > > > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > > > > index ca9dc230ae3d..dc7cf4f6ac53 100644
> > > > > --- a/fs/nfsd/export.h
> > > > > +++ b/fs/nfsd/export.h
> > > > > @@ -100,7 +100,7 @@ struct svc_expkey {
> > > > >  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> > > > > =20
> > > > >  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> > > > > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *=
rqstp);
> > > > > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *=
rqstp, bool may_bypass_gss);
> > > > > =20
> > > > >  /*
> > > > >   * Function declarations
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index 2e39cf2e502a..0f67f4a7b8b2 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > > > > =20
> > > > >  			if (current_fh->fh_export &&
> > > > >  					need_wrongsec_check(rqstp))
> > > > > -				op->status =3D check_nfsd_access(current_fh->fh_export, rqstp);
> > > > > +				op->status =3D check_nfsd_access(current_fh->fh_export, rqstp,=
 false);
> > > > >  		}
> > > > >  encode_op:
> > > > >  		if (op->status =3D=3D nfserr_replay_me) {
> > > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > > index 97f583777972..b45ea5757652 100644
> > > > > --- a/fs/nfsd/nfs4xdr.c
> > > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > > @@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdi=
r *cd, const char *name,
> > > > >  			nfserr =3D nfserrno(err);
> > > > >  			goto out_put;
> > > > >  		}
> > > > > -		nfserr =3D check_nfsd_access(exp, cd->rd_rqstp);
> > > > > +		nfserr =3D check_nfsd_access(exp, cd->rd_rqstp, false);
> > > > >  		if (nfserr)
> > > > >  			goto out_put;
> > > > > =20
> > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > index dd4e11a703aa..ed0eabfa3cb0 100644
> > > > > --- a/fs/nfsd/nfsfh.c
> > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > @@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, umode_t type, int access)
> > > > >  {
> > > > >  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> > > > >  	struct svc_export *exp =3D NULL;
> > > > > +	bool may_bypass_gss =3D false;
> > > > >  	struct dentry	*dentry;
> > > > >  	__be32		error;
> > > > > =20
> > > > > @@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_f=
h *fhp, umode_t type, int access)
> > > > >  	 * which clients virtually always use auth_sys for,
> > > > >  	 * even while using RPCSEC_GSS for NFS.
> > > > >  	 */
> > > > > -	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
> > > > > +	if (access & NFSD_MAY_LOCK)
> > > > >  		goto skip_pseudoflavor_check;
> > > > > +	/*
> > > > > +	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
> > > > > +	 */
> > > > > +	if (access & NFSD_MAY_BYPASS_GSS)
> > > > > +		may_bypass_gss =3D true;
> > > > >  	/*
> > > > >  	 * Clients may expect to be able to use auth_sys during mount,
> > > > >  	 * even if they use gss for everything else; see section 2.3.2
> > > > > @@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, umode_t type, int access)
> > > > >  	 */
> > > > >  	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
> > > > >  			&& exp->ex_path.dentry =3D=3D dentry)
> > > > > -		goto skip_pseudoflavor_check;
> > > > > +		may_bypass_gss =3D true;
> > > > > =20
> > > > > -	error =3D check_nfsd_access(exp, rqstp);
> > > > > +	error =3D check_nfsd_access(exp, rqstp, may_bypass_gss);
> > > > >  	if (error)
> > > > >  		goto out;
> > > > > =20
> > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > index 29b1f3613800..b2f5ea7c2187 100644
> > > > > --- a/fs/nfsd/vfs.c
> > > > > +++ b/fs/nfsd/vfs.c
> > > > > @@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_=
fh *fhp, const char *name,
> > > > >  	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> > > > >  	if (err)
> > > > >  		return err;
> > > > > -	err =3D check_nfsd_access(exp, rqstp);
> > > > > +	err =3D check_nfsd_access(exp, rqstp, false);
> > > > >  	if (err)
> > > > >  		goto out;
> > > > >  	/*
> > > > > --=20
> > > > > 2.20.1
> > > > >=20
> > > > >=20
> > > >=20
> > >=20
> > > --=20
> > > Chuck Lever
> > >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


