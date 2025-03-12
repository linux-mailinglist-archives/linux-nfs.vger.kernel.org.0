Return-Path: <linux-nfs+bounces-10571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6EA5E768
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A37A5399
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6E1F0E31;
	Wed, 12 Mar 2025 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r+2fYjhM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3fGB7tef";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnrouS7b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpAzMgB6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7C1F03C2
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818426; cv=none; b=HekSB4q6bdXFOWvTIeHNfjneant2zWAfGHLhbOLj79pT8dI7hIicltr8lT7CDOvJ2Kmk+U5zql2230E2t2/KelNiwaVeSOPaZ5VA2ciaXp5Ymk21RZ1FaBcucsd6HCBs+tQkylMjF1bqz2Iu1XCIZIiyUE8fZQ05YWzvUY3+CMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818426; c=relaxed/simple;
	bh=d4xZj0jlTxAck/Lx/d2Vqyh4Np1UCkSHb+2w5LIb5p0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MbEz69CrD6F40N4KdZgQiad6IYas37byBH4XlmC9XAkFRjgOuTRlRXf/pDX68b/Nmc0UxTpaQN50ss5AW5+fLw+WNb9BhQULGSyQcxUbgsr951+NKeM89bc6c3R5sCwVcY0YC+OsTQH8HYLCJ3ci7SzQGaB/GvtX2H/kzkDrHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r+2fYjhM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3fGB7tef; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnrouS7b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpAzMgB6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73F071F388;
	Wed, 12 Mar 2025 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741818422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlHsWswcn2x/x/r5wXCYPCahkPiy1YdStTVunLfOcl8=;
	b=r+2fYjhM5uYCVQnAzxNEU4D3y3D88SVbVbSjrZKuycgjHIl6aMSAuldGlGfSQzqGkTIE7p
	pHYsyyO9o5FWSAKKz2f8lzq2mAwWSXd+X2usjO5gXptb10MauXKxl6NEkZwi1zVZiuYxA7
	yQPFycsPiXv2fqijQd5I8gpdS46X5BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741818422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlHsWswcn2x/x/r5wXCYPCahkPiy1YdStTVunLfOcl8=;
	b=3fGB7tefTjArKQ6sl1SchAcVKvYR66rj1V1zZp/TaNw4Cbw48O36SUrqCNaoeUU8mcLgo7
	m38jNO7DkCxJQAAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HnrouS7b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZpAzMgB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741818421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlHsWswcn2x/x/r5wXCYPCahkPiy1YdStTVunLfOcl8=;
	b=HnrouS7bBr67Vt3KRJKcOT8StBv/NCLzWb/Sh+fIk4td0RCi35aK6kYiQAkJ67thLdfKkY
	bRZZsHfSZBqdBem9/4q1PFWTnOfG5SzqUqYCI0SsvQQUp+VQhS9VhwVveEoQaz6qZglGN0
	xv7FRdQfMZyczGbh3dOA8d0Tu5TqMcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741818421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlHsWswcn2x/x/r5wXCYPCahkPiy1YdStTVunLfOcl8=;
	b=ZpAzMgB6HtJtNW6xJMvoC88MJepTSiqTBrF7SU2/0hRK7nVKoDG7NE1TPFfY+BN05HyXI0
	He7y8CvL2sshaqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F12C31377F;
	Wed, 12 Mar 2025 22:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LahqKDIK0mfhBgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Mar 2025 22:26:58 +0000
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
 <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
References:
 <>, <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
Date: Thu, 13 Mar 2025 09:26:55 +1100
Message-id: <174181841557.33508.11810351442398748810@noble.neil.brown.name>
X-Rspamd-Queue-Id: 73F071F388
X-Spam-Score: -4.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@umich.=
edu> wrote:
> > > >
> > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wro=
te:
> > > > >
> > > > >
> > > > > NFSD_MAY_LOCK means a few different things.
> > > > > - it means that GSS is not required.
> > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not requir=
ed
> > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > >
> > > > > None of these are specific to locking, they are specific to the NLM
> > > > > protocol.
> > > > > So:
> > > > >  - rename to NFSD_MAY_NLM
> > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen=
()
> > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
> > > > >    into fh_verify where other special-case tests on the MAY flags
> > > > >    happen.  nfsd_permission() can be called from other places than
> > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > >
> > > > This patch breaks NLM when used in combination with TLS.
> > >
> > > I was too quick to link this to TLS. It's presence of security policy
> > > so sec=3Dkrb* causes the same problems.
> > >
> > > >  If exports
> > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
> > > > won't give any locks and client will get "no locks available" error.
> > > >
> > > > >
> > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > ---
> > > > >
> > > > > No change from previous patch - the corruption in the email has been
> > > > > avoided (I hope).
> > > > >
> > > > >
> > > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > >  fs/nfsd/trace.h |  2 +-
> > > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > > >  fs/nfsd/vfs.h   |  2 +-
> > > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > > --- a/fs/nfsd/lockd.c
> > > > > +++ b/fs/nfsd/lockd.c
> > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh=
 *f, struct file **filp,
> > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > >         fh.fh_export =3D NULL;
> > > > >
> > > > > +       /*
> > > > > +        * Allow BYPASS_GSS as some client implementations use AUTH=
_SYS
> > > > > +        * for NLM even when GSS is used for NFS.
> > > > > +        * Allow OWNER_OVERRIDE as permission might have been chang=
ed
> > > > > +        * after the file was opened.
> > > > > +        * Pass MAY_NLM so that authentication can be completely by=
passed
> > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH=
_NULL
> > > > > +        * for NLM requests.
> > > > > +        */
> > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_M=
AY_READ;
> > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_M=
AY_BYPASS_GSS;
> > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> > > > >         fh_put(&fh);
> > > > > -       /* We return nlm error codes as nlm doesn't know
> > > > > +       /* We return nlm error codes as nlm doesn't know
> > > > >          * about nfsd, but nfsd does know about nlm..
> > > > >          */
> > > > >         switch (nfserr) {
> > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > index 40533f7c7297..6a831cb242df 100644
> > > > > --- a/fs/nfsd/nfsfh.c
> > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > >         if (error)
> > > > >                 goto out;
> > > > >
> > > > > -       /*
> > > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > > -        * which clients virtually always use auth_sys for,
> > > > > -        * even while using RPCSEC_GSS for NFS.
> > > > > -        */
> > > > > -       if (access & NFSD_MAY_LOCK)
> > > > > -               goto skip_pseudoflavor_check;
> > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAU=
THNLM))
> > >
> > > I think this should either be an OR or the fact that "nlm but only
> > > with insecurelock export option and not other" is the only way to
> > > bypass checking is wrong. I think it's just a check for NLM that
> > > stays.
> >
> > I don't think that NLM gets a complete bypass unless no_auth_nlm is set.
> > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is supposed
> > to make it work.
> >
> > I assume the NLM request is arriving with AUTH_SYS authentication?
>=20
> It does.
>=20
> Just to give you a practical example. exports have
> (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. Then
> does an flock() on the file. What's more I have just now hit Kasan's
> out-of-bounds warning on that. I'll have to see if that exists on 6.14
> (as I'm debugging the matter on the commit of the patch itself and
> thus on 6.12-rc now).
>=20
> I will layout more reasoning but what allowed NLM to work was this
> -       /*
> -        * pseudoflavor restrictions are not enforced on NLM,
> -        * which clients virtually always use auth_sys for,
> -        * even while using RPCSEC_GSS for NFS.
> -        */
> -       if (access & NFSD_MAY_LOCK)
> -               goto skip_pseudoflavor_check;
>=20
> but I don't know why the replacement doesn't work.

Can you see if this fixes it?
Maybe we need to bypass tls as well as gss

Thanks,
NeilBrown

--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct=
 svc_rqst *rqstp,
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
 			goto ok;
 	}
-	goto denied;
+	if (!may_bypass_gss)
+		goto denied;
=20
 ok:
 	/* legacy gss-only clients are always OK: */

