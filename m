Return-Path: <linux-nfs+bounces-10581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA03A5E8E4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 01:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CDB188F633
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E73173;
	Thu, 13 Mar 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0npZ3NEB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g1hws9Gx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kuOybqw3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2y0qw/RH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A86FC5
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824401; cv=none; b=at1005/UOiM0CZpUwUKOCxWBCA5WfZzPSuR4WfttZH4vVkKYSxaD0XIw3IfjOHNZGJj2EvqUyhp6OEkizm12a4cNGjIF45WsuIlmVNjSASq/0TRAHt8x7PIM+V7M3sqwrBelQoN7EL6FF5i0gHwndVZsFsqY3NLN/voST9aSd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824401; c=relaxed/simple;
	bh=h4SosV+4UWRJrYJJXaNYVmaxn6iTc+a6hTkHn05Vmq8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k1ZsA5fwHGUHo2mzApYpdOMSgNa5syirUq4bJxGe/XgI8m9Bs8ZQRGZJ2GccAJioc8EpWOmrzHlVdRl+fS0mPWjZlqnyIdSz7DczX9Bn5TI5AGa99JScRoIvVVaBGWdih61FDrCdRplN2mbTTPM/7ZTgJqiaat1lBLUAmNY06P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0npZ3NEB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g1hws9Gx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kuOybqw3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2y0qw/RH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 938221F444;
	Thu, 13 Mar 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741824396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz+azBrA9HsCL00JWOJ42i//QKE04uZozz2mRUydEII=;
	b=0npZ3NEBinKK3RPl8eddOlPiCGKyjnrNBOwSWuOyMpO7dJc+Rz0g77EVTQKBvZknFl5R+l
	e/2eNa8XO9c2i3MCzAUKuwVqyboRCz8wQAXr92D30l87u5NDjTaePvUBw6e0TukYBF5LxR
	MJj7JdTX99r4X5x8imyryVeXcktgNFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741824396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz+azBrA9HsCL00JWOJ42i//QKE04uZozz2mRUydEII=;
	b=g1hws9GxmLqwslMLIg9hPX19VxrMMr4cq0RUWquhP7aaI1KOL+N2eSIrT9neCow1sRh5//
	1KttjDJfM394D1Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kuOybqw3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2y0qw/RH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741824395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz+azBrA9HsCL00JWOJ42i//QKE04uZozz2mRUydEII=;
	b=kuOybqw3UFfKX1QEJb0X8dJOQnX0OSH8wJUmbwjCcyg0Wilw4hrWHJenNkV45lWEr1ywAG
	fUM6eFHye4scpDnFRXJlRksiEY9GU1eqOfqt4tYnWTg7jmoiOgu6Vqbn9WMxNzOheVnFek
	Cmr3BLadCoFXUmsLgB+5eh5LB7MVkm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741824395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz+azBrA9HsCL00JWOJ42i//QKE04uZozz2mRUydEII=;
	b=2y0qw/RHLk8Q6X1JINQ3kxy6euq2Hz+g2thm2tVcVQtzyg1wZc+hCv/SVe3KXIz7zSPxVu
	lw4bZoCoVbpsQVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B04013797;
	Thu, 13 Mar 2025 00:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynoxMIgh0mc3IQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 13 Mar 2025 00:06:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
In-reply-to:
 <CAN-5tyGak9WbYZtU6X_2cVLaMGfxTBsiTr3hZVmRyK3NqixJhg@mail.gmail.com>
References:
 <>, <CAN-5tyGak9WbYZtU6X_2cVLaMGfxTBsiTr3hZVmRyK3NqixJhg@mail.gmail.com>
Date: Thu, 13 Mar 2025 11:06:25 +1100
Message-id: <174182438554.9342.15518701908250172876@noble.neil.brown.name>
X-Rspamd-Queue-Id: 938221F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,umich.edu:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> On Wed, Mar 12, 2025 at 6:27=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> > > On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@um=
ich.edu> wrote:
> > > > > >
> > > > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de>=
 wrote:
> > > > > > >
> > > > > > >
> > > > > > > NFSD_MAY_LOCK means a few different things.
> > > > > > > - it means that GSS is not required.
> > > > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not re=
quired
> > > > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > > > >
> > > > > > > None of these are specific to locking, they are specific to the=
 NLM
> > > > > > > protocol.
> > > > > > > So:
> > > > > > >  - rename to NFSD_MAY_NLM
> > > > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_f=
open()
> > > > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() a=
nd
> > > > > > >    into fh_verify where other special-case tests on the MAY fla=
gs
> > > > > > >    happen.  nfsd_permission() can be called from other places t=
han
> > > > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > > > >
> > > > > > This patch breaks NLM when used in combination with TLS.
> > > > >
> > > > > I was too quick to link this to TLS. It's presence of security poli=
cy
> > > > > so sec=3Dkrb* causes the same problems.
> > > > >
> > > > > >  If exports
> > > > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the serv=
er
> > > > > > won't give any locks and client will get "no locks available" err=
or.
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > > ---
> > > > > > >
> > > > > > > No change from previous patch - the corruption in the email has=
 been
> > > > > > > avoided (I hope).
> > > > > > >
> > > > > > >
> > > > > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > > >  fs/nfsd/trace.h |  2 +-
> > > > > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > > > > >  fs/nfsd/vfs.h   |  2 +-
> > > > > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > > > > --- a/fs/nfsd/lockd.c
> > > > > > > +++ b/fs/nfsd/lockd.c
> > > > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nf=
s_fh *f, struct file **filp,
> > > > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > > > >         fh.fh_export =3D NULL;
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Allow BYPASS_GSS as some client implementations use =
AUTH_SYS
> > > > > > > +        * for NLM even when GSS is used for NFS.
> > > > > > > +        * Allow OWNER_OVERRIDE as permission might have been c=
hanged
> > > > > > > +        * after the file was opened.
> > > > > > > +        * Pass MAY_NLM so that authentication can be completel=
y bypassed
> > > > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use =
AUTH_NULL
> > > > > > > +        * for NLM requests.
> > > > > > > +        */
> > > > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NF=
SD_MAY_READ;
> > > > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NF=
SD_MAY_BYPASS_GSS;
> > > > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> > > > > > >         fh_put(&fh);
> > > > > > > -       /* We return nlm error codes as nlm doesn't know
> > > > > > > +       /* We return nlm error codes as nlm doesn't know
> > > > > > >          * about nfsd, but nfsd does know about nlm..
> > > > > > >          */
> > > > > > >         switch (nfserr) {
> > > > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > > > index 40533f7c7297..6a831cb242df 100644
> > > > > > > --- a/fs/nfsd/nfsfh.c
> > > > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > > >         if (error)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > -       /*
> > > > > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > > > > -        * which clients virtually always use auth_sys for,
> > > > > > > -        * even while using RPCSEC_GSS for NFS.
> > > > > > > -        */
> > > > > > > -       if (access & NFSD_MAY_LOCK)
> > > > > > > -               goto skip_pseudoflavor_check;
> > > > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_=
NOAUTHNLM))
> > > > >
> > > > > I think this should either be an OR or the fact that "nlm but only
> > > > > with insecurelock export option and not other" is the only way to
> > > > > bypass checking is wrong. I think it's just a check for NLM that
> > > > > stays.
> > > >
> > > > I don't think that NLM gets a complete bypass unless no_auth_nlm is s=
et.
> > > > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is suppo=
sed
> > > > to make it work.
> > > >
> > > > I assume the NLM request is arriving with AUTH_SYS authentication?
> > >
> > > It does.
> > >
> > > Just to give you a practical example. exports have
> > > (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. Then
> > > does an flock() on the file. What's more I have just now hit Kasan's
> > > out-of-bounds warning on that. I'll have to see if that exists on 6.14
> > > (as I'm debugging the matter on the commit of the patch itself and
> > > thus on 6.12-rc now).
> > >
> > > I will layout more reasoning but what allowed NLM to work was this
> > > -       /*
> > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > -        * which clients virtually always use auth_sys for,
> > > -        * even while using RPCSEC_GSS for NFS.
> > > -        */
> > > -       if (access & NFSD_MAY_LOCK)
> > > -               goto skip_pseudoflavor_check;
> > >
> > > but I don't know why the replacement doesn't work.
> >
> > Can you see if this fixes it?
> > Maybe we need to bypass tls as well as gss
> >
> > Thanks,
> > NeilBrown
> >
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp,
> >                     test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> >                         goto ok;
> >         }
> > -       goto denied;
> > +       if (!may_bypass_gss)
> > +               goto denied;
> >
>=20
> I don't think this would help in any way as NLM does pass may_bypass_gss...

Yes, so for NLM it won't "goto denied" but will fall through and pass
the other checks.

NeilBrown


>=20
> >  ok:
> >         /* legacy gss-only clients are always OK: */
>=20


