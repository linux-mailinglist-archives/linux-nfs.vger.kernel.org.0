Return-Path: <linux-nfs+bounces-10582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7BA5E8E5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 01:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE373B43E6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27617E;
	Thu, 13 Mar 2025 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AKaRfX6v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7h3JFKQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AKaRfX6v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7h3JFKQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7B33D8
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824586; cv=none; b=XJV51GUQvGhg+VNfJafiZtdv0cItu0BggmyAYu1fjx6oPw1F3hQjihn89QVh2tg0QT0d96bx9Q8TTYZ/vq0AfntuhVaXllQR22SV6dr4mZQ0bcwWpwTVPINqtcTJBBKSzfGQV1few8zeJd7OFrAQJuWde/2YoHWwm+zfc5n9viA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824586; c=relaxed/simple;
	bh=xx3eF4QTPhQpawP+eupN0p1Sk0I6YM0+a9SrYKaajzk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JZF7uqRE+yxZJE5BVrGNC6S+Bn/JuVLoTd/zrd45o5/mCXA8djbiEzv9zoK3MFYT/SgSB2MvqK/oDHP/1TPEB1vyQqBQo6513jp/mIiUeqmVbvRL/h8UEJ4WJxmDK8lel2ictaYySI68pqvHOSp4nAstVQJI7Va4+yqxi7DVuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AKaRfX6v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7h3JFKQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AKaRfX6v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7h3JFKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6C6421187;
	Thu, 13 Mar 2025 00:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741824581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVqGgPYNNrx/4RRJz9mGBx8a1235tnza5kQySg802yk=;
	b=AKaRfX6vz66G2+bDZpjJyInTxLoMF7hErxCf/AlEh093m7YxG/MIh2o/2CeDGFWtF0GXRk
	plQ/WsP9JELa46LzAqmLpO91JARnbLXboQNSAbEaR5DKGtO+0tvfIasNL8eowNlU/uNqsx
	67zmpxbegLVvDm7oojl/2j0sVBs4IBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741824581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVqGgPYNNrx/4RRJz9mGBx8a1235tnza5kQySg802yk=;
	b=g7h3JFKQjZ2zTbZ0+B3n1U6pqAeKwhaAhudmj7Mi8OVwpkstZ+OPxyhdk6tG0TtYvsUcSk
	IhohZ/39TuERL4Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741824581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVqGgPYNNrx/4RRJz9mGBx8a1235tnza5kQySg802yk=;
	b=AKaRfX6vz66G2+bDZpjJyInTxLoMF7hErxCf/AlEh093m7YxG/MIh2o/2CeDGFWtF0GXRk
	plQ/WsP9JELa46LzAqmLpO91JARnbLXboQNSAbEaR5DKGtO+0tvfIasNL8eowNlU/uNqsx
	67zmpxbegLVvDm7oojl/2j0sVBs4IBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741824581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVqGgPYNNrx/4RRJz9mGBx8a1235tnza5kQySg802yk=;
	b=g7h3JFKQjZ2zTbZ0+B3n1U6pqAeKwhaAhudmj7Mi8OVwpkstZ+OPxyhdk6tG0TtYvsUcSk
	IhohZ/39TuERL4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4174013797;
	Thu, 13 Mar 2025 00:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CvtQOUIi0mcCIgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 13 Mar 2025 00:09:38 +0000
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
 <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
References:
 <>, <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
Date: Thu, 13 Mar 2025 11:09:32 +1100
Message-id: <174182457214.9342.16141018787964898862@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,umich.edu:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> =
wrote:
> >
> > On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@umic=
h.edu> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> w=
rote:
> > > > > >
> > > > > >
> > > > > > NFSD_MAY_LOCK means a few different things.
> > > > > > - it means that GSS is not required.
> > > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not requ=
ired
> > > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > > >
> > > > > > None of these are specific to locking, they are specific to the N=
LM
> > > > > > protocol.
> > > > > > So:
> > > > > >  - rename to NFSD_MAY_NLM
> > > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fop=
en()
> > > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
> > > > > >    into fh_verify where other special-case tests on the MAY flags
> > > > > >    happen.  nfsd_permission() can be called from other places than
> > > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > > >
> > > > > This patch breaks NLM when used in combination with TLS.
> > > >
> > > > I was too quick to link this to TLS. It's presence of security policy
> > > > so sec=3Dkrb* causes the same problems.
> > > >
> > > > >  If exports
> > > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
> > > > > won't give any locks and client will get "no locks available" error.
> > > > >
> > > > > >
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >
> > > > > > No change from previous patch - the corruption in the email has b=
een
> > > > > > avoided (I hope).
> > > > > >
> > > > > >
> > > > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > >  fs/nfsd/trace.h |  2 +-
> > > > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > > > >  fs/nfsd/vfs.h   |  2 +-
> > > > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > > > --- a/fs/nfsd/lockd.c
> > > > > > +++ b/fs/nfsd/lockd.c
> > > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_=
fh *f, struct file **filp,
> > > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > > >         fh.fh_export =3D NULL;
> > > > > >
> > > > > > +       /*
> > > > > > +        * Allow BYPASS_GSS as some client implementations use AU=
TH_SYS
> > > > > > +        * for NLM even when GSS is used for NFS.
> > > > > > +        * Allow OWNER_OVERRIDE as permission might have been cha=
nged
> > > > > > +        * after the file was opened.
> > > > > > +        * Pass MAY_NLM so that authentication can be completely =
bypassed
> > > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AU=
TH_NULL
> > > > > > +        * for NLM requests.
> > > > > > +        */
> > > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD=
_MAY_READ;
> > > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD=
_MAY_BYPASS_GSS;
> > > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> > > > > >         fh_put(&fh);
> > > > > > -       /* We return nlm error codes as nlm doesn't know
> > > > > > +       /* We return nlm error codes as nlm doesn't know
> > > > > >          * about nfsd, but nfsd does know about nlm..
> > > > > >          */
> > > > > >         switch (nfserr) {
> > > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > > index 40533f7c7297..6a831cb242df 100644
> > > > > > --- a/fs/nfsd/nfsfh.c
> > > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >         if (error)
> > > > > >                 goto out;
> > > > > >
> > > > > > -       /*
> > > > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > > > -        * which clients virtually always use auth_sys for,
> > > > > > -        * even while using RPCSEC_GSS for NFS.
> > > > > > -        */
> > > > > > -       if (access & NFSD_MAY_LOCK)
> > > > > > -               goto skip_pseudoflavor_check;
> > > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NO=
AUTHNLM))
> > > >
> > > > I think this should either be an OR or the fact that "nlm but only
> > > > with insecurelock export option and not other" is the only way to
> > > > bypass checking is wrong. I think it's just a check for NLM that
> > > > stays.
> > >
> > > I don't think that NLM gets a complete bypass unless no_auth_nlm is set.
> > > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is supposed
> > > to make it work.
> > >
> > > I assume the NLM request is arriving with AUTH_SYS authentication?
> >
> > It does.
> >
> > Just to give you a practical example. exports have
> > (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. Then
> > does an flock() on the file. What's more I have just now hit Kasan's
> > out-of-bounds warning on that. I'll have to see if that exists on 6.14
> > (as I'm debugging the matter on the commit of the patch itself and
> > thus on 6.12-rc now).
> >
> > I will layout more reasoning but what allowed NLM to work was this
> > -       /*
> > -        * pseudoflavor restrictions are not enforced on NLM,
> > -        * which clients virtually always use auth_sys for,
> > -        * even while using RPCSEC_GSS for NFS.
> > -        */
> > -       if (access & NFSD_MAY_LOCK)
> > -               goto skip_pseudoflavor_check;
> >
> > but I don't know why the replacement doesn't work.
>=20
> As I mentioned the patch removed the skip_pseudoflavor check (that for
> NLM) would have bypassed calling check_nfsd_access(). Instead, the
> problem is that even though may_bypass_gss is set to true it call into
> nfsd4_spo_must_allow(rqstp) which now wrongly assumes there is
> compound state (struct nfsd4_compound_state *cstate =3D &resp->cstate;)
> ... (but this is NLM). So it proceed to deference it if
> (!cstate->minorversion) causing the KASAN to do the out-of-bound error
> that I mentioned. It most of the time now cause a crash. But on the
> off non-deterministic times when it completes it fails.
>=20
> I really don't think calling into check_nfsd_access() is appropriate for NL=
M.

Why not?  What is there is inherently inappropriate for NLM?

I agree that calling nfsd4_spo_must_allow(rqstp) isn't appropriate for
NLM, but it isn't appropriate for v2 or v3 either.  We should add
version checks either before it is called or before the minorversion
check that it already has.

NeilBrown


>=20
> >
> > > So check_nfsd_access() is being called with may_bypass_gss and this:
> > >
> > >         if (may_bypass_gss && (
> > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> > >                 for (f =3D exp->ex_flavors; f < end; f++) {
> > >                         if (f->pseudoflavor >=3D RPC_AUTH_DES)
> > >                                 return 0;
> > >                 }
> > >         }
> > >
> > > in check_nfsd_access() should succeed.
> > > Can you add some tracing and see what is happening in here?
> > > Maybe the "goto denied" earlier in the function is being reached.  I
> > > don't fully understand the TLS code yet - maybe it needs some test on
> > > may_bypass_gss.
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > > >
> > > > > > +               /* NLM is allowed to fully bypass authentication =
*/
> > > > > > +               goto out;
> > > > > > +
> > > > > >         if (access & NFSD_MAY_BYPASS_GSS)
> > > > > >                 may_bypass_gss =3D true;
> > > > > >         /*
> > > > > > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >         if (error)
> > > > > >                 goto out;
> > > > > >
> > > > > > -skip_pseudoflavor_check:
> > > > > >         /* Finally, check access permissions. */
> > > > > >         error =3D nfsd_permission(cred, exp, dentry, access);
> > > > > >  out:
> > > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > > index b8470d4cbe99..3448e444d410 100644
> > > > > > --- a/fs/nfsd/trace.h
> > > > > > +++ b/fs/nfsd/trace.h
> > > > > > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> > > > > >                 { NFSD_MAY_READ,                "READ" },        =
       \
> > > > > >                 { NFSD_MAY_SATTR,               "SATTR" },       =
       \
> > > > > >                 { NFSD_MAY_TRUNC,               "TRUNC" },       =
       \
> > > > > > -               { NFSD_MAY_LOCK,                "LOCK" },        =
       \
> > > > > > +               { NFSD_MAY_NLM,                 "NLM" },         =
       \
> > > > > >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" =
},     \
> > > > > >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },=
       \
> > > > > >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_RO=
OT" }, \
> > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > index 51f5a0b181f9..2610638f4301 100644
> > > > > > --- a/fs/nfsd/vfs.c
> > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, stru=
ct svc_export *exp,
> > > > > >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> > > > > >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> > > > > >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > > > > > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > > > > > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> > > > > >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride"=
 : "",
> > > > > >                 inode->i_mode,
> > > > > >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > > > > > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, str=
uct svc_export *exp,
> > > > > >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > > >                 return nfserr_perm;
> > > > > >
> > > > > > -       if (acc & NFSD_MAY_LOCK) {
> > > > > > -               /* If we cannot rely on authentication in NLM req=
uests,
> > > > > > -                * just allow locks, otherwise require read permi=
ssion, or
> > > > > > -                * ownership
> > > > > > -                */
> > > > > > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > > > > > -                       return 0;
> > > > > > -               else
> > > > > > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OV=
ERRIDE;
> > > > > > -       }
> > > > > >         /*
> > > > > >          * The file owner always gets access permission for acces=
ses that
> > > > > >          * would normally be checked at open time. This is to make
> > > > > > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > > > > > index 854fb95dfdca..f9b09b842856 100644
> > > > > > --- a/fs/nfsd/vfs.h
> > > > > > +++ b/fs/nfsd/vfs.h
> > > > > > @@ -20,7 +20,7 @@
> > > > > >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_READ =
*/
> > > > > >  #define NFSD_MAY_SATTR                 0x008
> > > > > >  #define NFSD_MAY_TRUNC                 0x010
> > > > > > -#define NFSD_MAY_LOCK                  0x020
> > > > > > +#define NFSD_MAY_NLM                   0x020 /* request is from =
lockd */
> > > > > >  #define NFSD_MAY_MASK                  0x03f
> > > > > >
> > > > > >  /* extra hints to permission and open routines: */
> > > > > >
> > > > > > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > > > > > --
> > > > > > 2.46.0
> > > > > >
> > > > > >
> > > >
>=20


