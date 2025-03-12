Return-Path: <linux-nfs+bounces-10562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B239A5DDD7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 14:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6028B3A765D
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490F245027;
	Wed, 12 Mar 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dmu1e3Hg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DC243951
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785773; cv=none; b=HIj6PN0c/b+1VvOPQxATLikXjqXv8CtLpX/CkL6IMbMsIZoshGzoeaL5eMi3Fn62m9uTvI6Dna755nT9FziS354rpzPxrRc95u54ILBgUo0t//X+ntjzNc8tyGqaLNcK39ZV4oxPmf+tcNh44hFh1MNDt/NfAExZGbZkF/P5ZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785773; c=relaxed/simple;
	bh=mplocUEQubEWsXVyMLze838V1xVyign9V+UvoBt2Dho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2BZO07ziRewUiXMSv4V/5+8/99YqKStFXQURnozJpXudDMk43FixrXSAyGknzr026f5j14qIa5wzjrh4vA1AbeVk8zmMSfyUR+tUcgp4S6Icy41Ul8AptR2xbMdFEpWtnZ8ilGijkRM6R+XEVHcMrAFYFzZxVM/HSuFYDl9T7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=dmu1e3Hg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c091b54aaso42249421fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741785769; x=1742390569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw7dKcGFzGJkW3IBMitbQFnsQ7sx/nKwPOz+ojjzDEQ=;
        b=dmu1e3HgKgrRT+4Dz0GSW/c6pobX6h4VRO1Nl9u1X0CESrSWQOL2ddxYkKnf/2Hsrb
         EE0AucjwFue8X1NIX4/ynGpeP+Tq9Kk4WigrUye1SODQmwbTRBR+DJ5CsyEFk8sQAR/J
         BHjbOSWZJquRowffXfTj/fXe3oo0ckcTLIVtetrtCWjXQeip4MBGDc6VDjnAYoLkA+Tc
         ScAz4cDuaV0l82ZIO+SYjngkBgbDKAzD7DMg3nvxNQOvIK3xMDiGyUAuH7H1Bp/3WxBQ
         GhLaQmLC8ulriZ2coVUznIo7N6kC/fpZUhkI8/qESSOaUeLXSj5+fTVFQiuAm5ingbjM
         vazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785769; x=1742390569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw7dKcGFzGJkW3IBMitbQFnsQ7sx/nKwPOz+ojjzDEQ=;
        b=jcf96nGrz42lQ+j2JW0x8WND/qo07XEC0BISqtoWJC+ZfWtVxlvOqPaq3nzuYYs7HL
         vuAgFjBT2uQovsoIH1bpso2zWG/vOX601Z7BR1bwoYlmeA1OMtWc6++i7sA+1oHFGZiG
         t23B11OfnNWxszTbR39pgLiEClpdoMosc9VTGDFeUF4fAemy9+nf8Q5Vpdw5Rz573vS9
         Hg3Q/0Omu7JXrc2q0tmgl20PO3fOvGDy+ML7jTAMoJPG9LznP1TeRYaHoI9AuH/T5Or5
         pIDT+gnWWqJQWM+y/0uM5UUbEi/QoidiAETy/9FZZDTYiDgg3rOZxRlyflvLB1TWoHxZ
         g7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwCNwPxKotkcCQ90d0zZMis/fxL+7+3uVU9mVHlLy502UyPnawP0nLa+saDPCMaB7QPXDbvsh6AkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDl2TOATi+i4dTtNW+Wpeytl7nmvYGLLH0qOP76619zatFLoX
	UvArqjWKQjQGLEBf1OBqviDZkTmFx2rYHLvxurLS2tqYmaVrLBVs2NkXCtj9lAWCk9dYXiucRxz
	bITNOj85ez1bR7iOMd5WpCJj0d7M=
X-Gm-Gg: ASbGnctVsLJRYKWptO+fS3BAlVOw1rA7FrrKSHYs55/Rel36SBouxairm3E39Vj0o4W
	F3TqHs4o/7W7YPaD4xKaJ6caKPSYj+L+o3LXclLYvLYjYytnN3N5erELXlRugv1h5XBWl1PYwWA
	rfBvC+hmulkfPzwMXlC/0irz8zsw9dTse3IS6MVWfUgrWxtuc88aDjNii1mmWR
X-Google-Smtp-Source: AGHT+IFrMXC7SYXhEKQnPDtKZlDUW3qJ9xGndfREWIG34/wAxoEbLhBHIqlL0eiAFR181HNq0CtIIwO3NtqH0WWPA3k=
X-Received: by 2002:a2e:94cb:0:b0:30b:f775:bae5 with SMTP id
 38308e7fff4ca-30bf775bd9cmr55082101fa.6.1741785769045; Wed, 12 Mar 2025
 06:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyH4E-qaK0TEtUMn3QpB0rYsDjm_erqRwVko7bAgYdmQBg@mail.gmail.com>
 <174172935674.33508.779551385082016505@noble.neil.brown.name>
In-Reply-To: <174172935674.33508.779551385082016505@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 12 Mar 2025 09:22:36 -0400
X-Gm-Features: AQ5f1JqRqDWOBWaowuipKFmcyD1L5vLiwUoUJkjqgK-gtS7Mx7KZ1Q5z_24w0EE
Message-ID: <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@umich.=
edu> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wro=
te:
> > > >
> > > >
> > > > NFSD_MAY_LOCK means a few different things.
> > > > - it means that GSS is not required.
> > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not requir=
ed
> > > > - it means that OWNER_OVERRIDE is allowed.
> > > >
> > > > None of these are specific to locking, they are specific to the NLM
> > > > protocol.
> > > > So:
> > > >  - rename to NFSD_MAY_NLM
> > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen=
()
> > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
> > > >    into fh_verify where other special-case tests on the MAY flags
> > > >    happen.  nfsd_permission() can be called from other places than
> > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > >
> > > This patch breaks NLM when used in combination with TLS.
> >
> > I was too quick to link this to TLS. It's presence of security policy
> > so sec=3Dkrb* causes the same problems.
> >
> > >  If exports
> > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
> > > won't give any locks and client will get "no locks available" error.
> > >
> > > >
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >
> > > > No change from previous patch - the corruption in the email has bee=
n
> > > > avoided (I hope).
> > > >
> > > >
> > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > >  fs/nfsd/trace.h |  2 +-
> > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > >  fs/nfsd/vfs.h   |  2 +-
> > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > --- a/fs/nfsd/lockd.c
> > > > +++ b/fs/nfsd/lockd.c
> > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh=
 *f, struct file **filp,
> > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > >         fh.fh_export =3D NULL;
> > > >
> > > > +       /*
> > > > +        * Allow BYPASS_GSS as some client implementations use AUTH=
_SYS
> > > > +        * for NLM even when GSS is used for NFS.
> > > > +        * Allow OWNER_OVERRIDE as permission might have been chang=
ed
> > > > +        * after the file was opened.
> > > > +        * Pass MAY_NLM so that authentication can be completely by=
passed
> > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH=
_NULL
> > > > +        * for NLM requests.
> > > > +        */
> > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_M=
AY_READ;
> > > > -       access |=3D NFSD_MAY_LOCK;
> > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_M=
AY_BYPASS_GSS;
> > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> > > >         fh_put(&fh);
> > > > -       /* We return nlm error codes as nlm doesn't know
> > > > +       /* We return nlm error codes as nlm doesn't know
> > > >          * about nfsd, but nfsd does know about nlm..
> > > >          */
> > > >         switch (nfserr) {
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index 40533f7c7297..6a831cb242df 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > >         if (error)
> > > >                 goto out;
> > > >
> > > > -       /*
> > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > -        * which clients virtually always use auth_sys for,
> > > > -        * even while using RPCSEC_GSS for NFS.
> > > > -        */
> > > > -       if (access & NFSD_MAY_LOCK)
> > > > -               goto skip_pseudoflavor_check;
> > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAU=
THNLM))
> >
> > I think this should either be an OR or the fact that "nlm but only
> > with insecurelock export option and not other" is the only way to
> > bypass checking is wrong. I think it's just a check for NLM that
> > stays.
>
> I don't think that NLM gets a complete bypass unless no_auth_nlm is set.
> For the case you are describing, I think NFSD_MAY_BYPASS_GSS is supposed
> to make it work.
>
> I assume the NLM request is arriving with AUTH_SYS authentication?

It does.

Just to give you a practical example. exports have
(rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. Then
does an flock() on the file. What's more I have just now hit Kasan's
out-of-bounds warning on that. I'll have to see if that exists on 6.14
(as I'm debugging the matter on the commit of the patch itself and
thus on 6.12-rc now).

I will layout more reasoning but what allowed NLM to work was this
-       /*
-        * pseudoflavor restrictions are not enforced on NLM,
-        * which clients virtually always use auth_sys for,
-        * even while using RPCSEC_GSS for NFS.
-        */
-       if (access & NFSD_MAY_LOCK)
-               goto skip_pseudoflavor_check;

but I don't know why the replacement doesn't work.

> So check_nfsd_access() is being called with may_bypass_gss and this:
>
>         if (may_bypass_gss && (
>              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
>              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
>                 for (f =3D exp->ex_flavors; f < end; f++) {
>                         if (f->pseudoflavor >=3D RPC_AUTH_DES)
>                                 return 0;
>                 }
>         }
>
> in check_nfsd_access() should succeed.
> Can you add some tracing and see what is happening in here?
> Maybe the "goto denied" earlier in the function is being reached.  I
> don't fully understand the TLS code yet - maybe it needs some test on
> may_bypass_gss.
>
> Thanks,
> NeilBrown
>
>
> >
> > > > +               /* NLM is allowed to fully bypass authentication */
> > > > +               goto out;
> > > > +
> > > >         if (access & NFSD_MAY_BYPASS_GSS)
> > > >                 may_bypass_gss =3D true;
> > > >         /*
> > > > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> > > >         if (error)
> > > >                 goto out;
> > > >
> > > > -skip_pseudoflavor_check:
> > > >         /* Finally, check access permissions. */
> > > >         error =3D nfsd_permission(cred, exp, dentry, access);
> > > >  out:
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index b8470d4cbe99..3448e444d410 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> > > >                 { NFSD_MAY_READ,                "READ" },          =
     \
> > > >                 { NFSD_MAY_SATTR,               "SATTR" },         =
     \
> > > >                 { NFSD_MAY_TRUNC,               "TRUNC" },         =
     \
> > > > -               { NFSD_MAY_LOCK,                "LOCK" },          =
     \
> > > > +               { NFSD_MAY_NLM,                 "NLM" },           =
     \
> > > >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" },=
     \
> > > >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },  =
     \
> > > >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_ROOT=
" }, \
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index 51f5a0b181f9..2610638f4301 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct=
 svc_export *exp,
> > > >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> > > >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> > > >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > > > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > > > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> > > >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" :=
 "",
> > > >                 inode->i_mode,
> > > >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > > > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struc=
t svc_export *exp,
> > > >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > >                 return nfserr_perm;
> > > >
> > > > -       if (acc & NFSD_MAY_LOCK) {
> > > > -               /* If we cannot rely on authentication in NLM reque=
sts,
> > > > -                * just allow locks, otherwise require read permiss=
ion, or
> > > > -                * ownership
> > > > -                */
> > > > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > > > -                       return 0;
> > > > -               else
> > > > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVER=
RIDE;
> > > > -       }
> > > >         /*
> > > >          * The file owner always gets access permission for accesse=
s that
> > > >          * would normally be checked at open time. This is to make
> > > > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > > > index 854fb95dfdca..f9b09b842856 100644
> > > > --- a/fs/nfsd/vfs.h
> > > > +++ b/fs/nfsd/vfs.h
> > > > @@ -20,7 +20,7 @@
> > > >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_READ */
> > > >  #define NFSD_MAY_SATTR                 0x008
> > > >  #define NFSD_MAY_TRUNC                 0x010
> > > > -#define NFSD_MAY_LOCK                  0x020
> > > > +#define NFSD_MAY_NLM                   0x020 /* request is from lo=
ckd */
> > > >  #define NFSD_MAY_MASK                  0x03f
> > > >
> > > >  /* extra hints to permission and open routines: */
> > > >
> > > > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > > > --
> > > > 2.46.0
> > > >
> > > >
> >

