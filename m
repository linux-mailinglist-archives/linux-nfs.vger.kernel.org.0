Return-Path: <linux-nfs+bounces-5847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB3961FD0
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 08:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0321C20D8A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044212CD8B;
	Wed, 28 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoG9+Kdi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DMc5I++N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoG9+Kdi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DMc5I++N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20F14A4D6
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826617; cv=none; b=beCTfNX9IQ2YtDqCygm+yAtDNVJv9i1rZiY2IhCxpS3QjQIEfrEaAkmKeTCCa9D0Bh09ttUQ4OldYqb8/9h+mrr+iHhw846fsMmcqnqUc8aTVZsZzvoVGQ4Ca5+BRrmdh34An85Tt1ajipWR5vo9hx6O4wFmrmG79XVFzceWCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826617; c=relaxed/simple;
	bh=3Id+8xpHmnX0AyQMyMM4uCPlQSlm1EMqigwuMUcI4ZY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ksLeOoBTcddbxPxFGFxrm01KQUsCSsk4jcxK+jeLyMetmy4Ylr/ZP6RJnz3JkTUWnIQuFFc5xrau6uTiUFdgJTJq7TeLz8Do2Fu45biQWImfvvd7dkBPwI/KkDUv0v1dlOP+ak0VdIZttJISfAGD2pqkONuTVjwYji530orVU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoG9+Kdi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DMc5I++N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoG9+Kdi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DMc5I++N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 329921FBDD;
	Wed, 28 Aug 2024 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu+rHnJoBLvkK4/kuHaCOWyqW86YMvjMZcZqL0Car+s=;
	b=ZoG9+KditZnK2uPUz42lyGu5cxGt/vhBItjB+G1E9UK5di9KpA5QFw251AKB4pu68sEwVe
	cjSbfWWX7yNKU9EsrHGcMwucogoumXXjGQB0ivhMYH/xXC2gKWsSunakiCkksg7YijDC1V
	xbohwCjA+mjP3mN6/7O+PAPMRBnGT8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu+rHnJoBLvkK4/kuHaCOWyqW86YMvjMZcZqL0Car+s=;
	b=DMc5I++N2MLLqyQo7rkDp00+ZG8U0MG9AZUEFdkvhJLubu3SLN/kc/pfTSw/pVdr2XwR7j
	Cry5IEsogll1QADA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZoG9+Kdi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DMc5I++N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu+rHnJoBLvkK4/kuHaCOWyqW86YMvjMZcZqL0Car+s=;
	b=ZoG9+KditZnK2uPUz42lyGu5cxGt/vhBItjB+G1E9UK5di9KpA5QFw251AKB4pu68sEwVe
	cjSbfWWX7yNKU9EsrHGcMwucogoumXXjGQB0ivhMYH/xXC2gKWsSunakiCkksg7YijDC1V
	xbohwCjA+mjP3mN6/7O+PAPMRBnGT8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu+rHnJoBLvkK4/kuHaCOWyqW86YMvjMZcZqL0Car+s=;
	b=DMc5I++N2MLLqyQo7rkDp00+ZG8U0MG9AZUEFdkvhJLubu3SLN/kc/pfTSw/pVdr2XwR7j
	Cry5IEsogll1QADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5DD138D2;
	Wed, 28 Aug 2024 06:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SmJRJ/TDzma6HwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 06:30:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in check_nfsd_access()
In-reply-to: <Zs6SxCUgv8yl9aqg@kernel.org>
References: <>, <Zs6SxCUgv8yl9aqg@kernel.org>
Date: Wed, 28 Aug 2024 16:30:05 +1000
Message-id: <172482660567.4433.10002819732828170761@noble.neil.brown.name>
X-Rspamd-Queue-Id: 329921FBDD
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Wed, 28 Aug 2024, Mike Snitzer wrote:
> On Wed, Aug 28, 2024 at 11:12:00AM +1000, NeilBrown wrote:
> > On Wed, 28 Aug 2024, cel@kernel.org wrote:
> > > From: NeilBrown <neilb@suse.de>
> > >=20
> > > LOCALIO-initiated open operations are not running in an nfsd thread
> > > and thus do not have an associated svc_rqst context.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/export.c | 29 ++++++++++++++++++++++++-----
> > >  1 file changed, 24 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > index 7bb4f2075ac5..46a4d989c850 100644
> > > --- a/fs/nfsd/export.c
> > > +++ b/fs/nfsd/export.c
> > > @@ -1074,10 +1074,29 @@ static struct svc_export *exp_find(struct cache=
_detail *cd,
> > >  	return exp;
> > >  }
> > > =20
> > > +/**
> > > + * check_nfsd_access - check if access to export is allowed.
> > > + * @exp: svc_export that is being accessed.
> > > + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALI=
O).
> > > + *
> > > + * Return values:
> > > + *   %nfs_ok if access is granted, or
> > > + *   %nfserr_wrongsec if access is denied
> > > + */
> > >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqst=
p)
> > >  {
> > >  	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavor=
s;
> > > -	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> > > +	struct svc_xprt *xprt;
> > > +
> > > +	/*
> > > +	 * The target use case for rqstp being NULL is LOCALIO, which
> > > +	 * currently only supports AUTH_UNIX. The behavior for LOCALIO
> > > +	 * is therefore the same as the AUTH_UNIX check below.
> >=20
> > The "AUTH_UNIX check below" only applies if exp->ex_flavours =3D=3D 0.
> > To make "rqstp =3D=3D NULL" mean "treat like AUTH_UNIX" I think we need
> > to confirm that=20
> >   exp->ex_xprtsec_mods & NFSEXP_XPRTSEC_NONE
> > and either
> >   exp->ex_nflavours =3D=3D 0
> > or
> >   one for the exp->ex_flavors->pseudoflavor values is RPC_AUTH_UNIX
> >=20
> > I'm not sure that is all really necessary, but if not then we probably
> > need a better comment...
>=20
> Think extra checks aren't needed (unless you think a NULL rqstp
> _without_ the use of LOCALIO possible?  which could trigger a false
> positive granting of access? seems unlikely but...)
>=20

I agree they aren't needed.  I think we need to have a clear
understanding of why that aren't needed, and to write that understanding
down.  So that if some day someone wants to change this code, they can
understand the consequences.

Maybe the answer is that LOCALIO would never ask for access that isn't
allowed, so there is no need to check.

Maybe the client can determine the relevant xpt_flags from the client
end of the session, so it can pass them reliably to check_nfsd_access().

I don't know what is best, but I think we should have a comment
justifying the short-circuit, and I don't think the current proposed
comment does that correctly.

Thanks,
NeilBrown

