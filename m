Return-Path: <linux-nfs+bounces-10574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF2A5E7AF
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457EC189966C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C71F0E3E;
	Wed, 12 Mar 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jAxlCpmg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2941F03E4
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819923; cv=none; b=C4LuArc0uGEe7wnREZ1shJ6ue4u8OnU9zT1fRydJzQhSkuzr0ybSAueWEptdWCzFspO8vxMuRN46gDMHQ/MGetkJ9N00L5v+E2Yp8ASTkUrhLQOE803tlfh2rmZWVQ2S6Mgw/pM/m6dU0JVEmO5fFJKxWiYbpJHUSni3ALR5aLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819923; c=relaxed/simple;
	bh=UJJQiV394j4IxRUnbMSCHYMmYTsqVBFOXfcpgzcfgZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX2rwkKDOclGBFSrHUMtT7fC+Dr/rfWshhy5ZIVHQJwJUauxQq9VccDLTJgaqbNNq3Cy29g9Y/MW/kIeYDEBvoP8rEYSn+8xo2X13AXP2vybO9Pp+tLxHq2rGZtGjUD3bksjQNJEL9MzxYDlNQria0f4ZRfHsCBgpa9F3tx6M5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jAxlCpmg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549946c5346so357692e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741819919; x=1742424719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWXf4pH/slOKYGX1qQ1Rt9aYWsF1E9nyWmIXq+l6cyM=;
        b=jAxlCpmg6Nw8D6Zoqp4bY+aTHOijKUshSXORwBupXNSlkK++K8iltfmS+2Tk2yhfvP
         jAnvtLFJhjD9mEawwu3T7uvHkgog3mbwZCiq5QhPLSNb7U/lFAgL4ZAdQ9NxSuloWfF7
         7V5tCEbeU3XFwCQkolsqyRa4XskgQmcXK89WSqJzhcdpYfLj6oKlF3vSiOQkpfLWW7sg
         TpxajNu9IuNN4m7/pYTrCFBmmMeSGV8W0aL7DuZUQVznSyjbrW7fbsMdAH4fE6NEOxzJ
         k8SDfl/2RWQZ+o7TzPY5kuoli9Mk83vvKeHplR52Imi+4ISZCJ5xwRLEOhmoJw5WQazk
         zCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741819919; x=1742424719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWXf4pH/slOKYGX1qQ1Rt9aYWsF1E9nyWmIXq+l6cyM=;
        b=YSLjV6eDjdrYg9sERJJEnPxtBs1AtBzd/DRwl48wdkW9VU5BUcVwpoRGazYqjC53z5
         838f+ss3HbuYfXxLJYmxROSu9FdRKGTuc2AFWNuoN4XYxROpCxZRnGoJ5Y5eXxBS4C3A
         vIDlllvjqGrFkjYV4TKkPsjH2lEfqBL/ksQeMM031ZV227cnenCcSQ2cXAA3Sj2pnLHc
         KO4EMwk26bTFJdqeRoKwxMaC4A59iPFLNxxvdlpdLqzqZ1sClr2Qf4iYgxgtnY6fFq1K
         /nSVdN0SjUsMqQr1CgtSWRB7NgFOBLAu7thLvR/awg3yaNg3I/PIGzawss+Ds5fvldK6
         EpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw26YFdNkAmHy0qvumCFOffPaqzlVlrKfAHWfIbI8+4f/AmI2NE+mzNnau8BVlV00rkuM6bUN3Ogw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2tq/Pj8RkM/8koaBoj6G6a9iM6Ep3olwASLIlyzSx/MpjkyG
	FGH/jRMKXuuHdUHIzb+4lnIBQ1fL1KHRF1kfLf9hKzuAvn2iAdOq8zUtm96keyIwPgsBRvQ4+hW
	7/bx8SfD9sxEcezF1NwbehxCff8s=
X-Gm-Gg: ASbGncuzduLOrfXshrAc1mV0ERyWdEXAXiUlxMDPipUb9ZI0y6ngPzxD4UaUyDA/m0E
	3o3uQig7RUR8g8VyethP8UR78YeQ/ZUE8/ayPI+e9UtrDv1Ca1j7p2Cp0imeeD0QJw+WO5Lymwj
	Yg3kVMadowojF7LJUZaFdsggqFtZ9h7su/SxRAt/rae+8qnVBkcTD9WItEDxIlcOLWxuz5Lyg=
X-Google-Smtp-Source: AGHT+IFl9zie0r4erdIj6OUZXJab06X48GXb+4kjUDziCvSL7EiRudznNv9cTDHI1Q1Hp2RAhLEGWWHNceKizF6KjgQ=
X-Received: by 2002:a05:6512:114f:b0:545:1193:1256 with SMTP id
 2adb3069b0e04-54990e29badmr6892838e87.1.1741819919312; Wed, 12 Mar 2025
 15:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyH4E-qaK0TEtUMn3QpB0rYsDjm_erqRwVko7bAgYdmQBg@mail.gmail.com>
 <174172935674.33508.779551385082016505@noble.neil.brown.name> <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
In-Reply-To: <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 12 Mar 2025 18:51:47 -0400
X-Gm-Features: AQ5f1JoWL7pP05fcgpi8uA9IUgD-zAEQighUpaLzy5vapM50SCXspEOJ9uvM82w
Message-ID: <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@umic=
h.edu> wrote:
> > > >
> > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> w=
rote:
> > > > >
> > > > >
> > > > > NFSD_MAY_LOCK means a few different things.
> > > > > - it means that GSS is not required.
> > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not requ=
ired
> > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > >
> > > > > None of these are specific to locking, they are specific to the N=
LM
> > > > > protocol.
> > > > > So:
> > > > >  - rename to NFSD_MAY_NLM
> > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fop=
en()
> > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
> > > > >    into fh_verify where other special-case tests on the MAY flags
> > > > >    happen.  nfsd_permission() can be called from other places tha=
n
> > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > >
> > > > This patch breaks NLM when used in combination with TLS.
> > >
> > > I was too quick to link this to TLS. It's presence of security policy
> > > so sec=3Dkrb* causes the same problems.
> > >
> > > >  If exports
> > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
> > > > won't give any locks and client will get "no locks available" error=
.
> > > >
> > > > >
> > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > ---
> > > > >
> > > > > No change from previous patch - the corruption in the email has b=
een
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
> > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_=
fh *f, struct file **filp,
> > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > >         fh.fh_export =3D NULL;
> > > > >
> > > > > +       /*
> > > > > +        * Allow BYPASS_GSS as some client implementations use AU=
TH_SYS
> > > > > +        * for NLM even when GSS is used for NFS.
> > > > > +        * Allow OWNER_OVERRIDE as permission might have been cha=
nged
> > > > > +        * after the file was opened.
> > > > > +        * Pass MAY_NLM so that authentication can be completely =
bypassed
> > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AU=
TH_NULL
> > > > > +        * for NLM requests.
> > > > > +        */
> > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD=
_MAY_READ;
> > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD=
_MAY_BYPASS_GSS;
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
> > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NO=
AUTHNLM))
> > >
> > > I think this should either be an OR or the fact that "nlm but only
> > > with insecurelock export option and not other" is the only way to
> > > bypass checking is wrong. I think it's just a check for NLM that
> > > stays.
> >
> > I don't think that NLM gets a complete bypass unless no_auth_nlm is set=
.
> > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is suppose=
d
> > to make it work.
> >
> > I assume the NLM request is arriving with AUTH_SYS authentication?
>
> It does.
>
> Just to give you a practical example. exports have
> (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. Then
> does an flock() on the file. What's more I have just now hit Kasan's
> out-of-bounds warning on that. I'll have to see if that exists on 6.14
> (as I'm debugging the matter on the commit of the patch itself and
> thus on 6.12-rc now).
>
> I will layout more reasoning but what allowed NLM to work was this
> -       /*
> -        * pseudoflavor restrictions are not enforced on NLM,
> -        * which clients virtually always use auth_sys for,
> -        * even while using RPCSEC_GSS for NFS.
> -        */
> -       if (access & NFSD_MAY_LOCK)
> -               goto skip_pseudoflavor_check;
>
> but I don't know why the replacement doesn't work.

As I mentioned the patch removed the skip_pseudoflavor check (that for
NLM) would have bypassed calling check_nfsd_access(). Instead, the
problem is that even though may_bypass_gss is set to true it call into
nfsd4_spo_must_allow(rqstp) which now wrongly assumes there is
compound state (struct nfsd4_compound_state *cstate =3D &resp->cstate;)
... (but this is NLM). So it proceed to deference it if
(!cstate->minorversion) causing the KASAN to do the out-of-bound error
that I mentioned. It most of the time now cause a crash. But on the
off non-deterministic times when it completes it fails.

I really don't think calling into check_nfsd_access() is appropriate for NL=
M.

>
> > So check_nfsd_access() is being called with may_bypass_gss and this:
> >
> >         if (may_bypass_gss && (
> >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> >                 for (f =3D exp->ex_flavors; f < end; f++) {
> >                         if (f->pseudoflavor >=3D RPC_AUTH_DES)
> >                                 return 0;
> >                 }
> >         }
> >
> > in check_nfsd_access() should succeed.
> > Can you add some tracing and see what is happening in here?
> > Maybe the "goto denied" earlier in the function is being reached.  I
> > don't fully understand the TLS code yet - maybe it needs some test on
> > may_bypass_gss.
> >
> > Thanks,
> > NeilBrown
> >
> >
> > >
> > > > > +               /* NLM is allowed to fully bypass authentication =
*/
> > > > > +               goto out;
> > > > > +
> > > > >         if (access & NFSD_MAY_BYPASS_GSS)
> > > > >                 may_bypass_gss =3D true;
> > > > >         /*
> > > > > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > >         if (error)
> > > > >                 goto out;
> > > > >
> > > > > -skip_pseudoflavor_check:
> > > > >         /* Finally, check access permissions. */
> > > > >         error =3D nfsd_permission(cred, exp, dentry, access);
> > > > >  out:
> > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > index b8470d4cbe99..3448e444d410 100644
> > > > > --- a/fs/nfsd/trace.h
> > > > > +++ b/fs/nfsd/trace.h
> > > > > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> > > > >                 { NFSD_MAY_READ,                "READ" },        =
       \
> > > > >                 { NFSD_MAY_SATTR,               "SATTR" },       =
       \
> > > > >                 { NFSD_MAY_TRUNC,               "TRUNC" },       =
       \
> > > > > -               { NFSD_MAY_LOCK,                "LOCK" },        =
       \
> > > > > +               { NFSD_MAY_NLM,                 "NLM" },         =
       \
> > > > >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" =
},     \
> > > > >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },=
       \
> > > > >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_RO=
OT" }, \
> > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > index 51f5a0b181f9..2610638f4301 100644
> > > > > --- a/fs/nfsd/vfs.c
> > > > > +++ b/fs/nfsd/vfs.c
> > > > > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, stru=
ct svc_export *exp,
> > > > >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> > > > >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> > > > >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > > > > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > > > > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> > > > >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride"=
 : "",
> > > > >                 inode->i_mode,
> > > > >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > > > > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, str=
uct svc_export *exp,
> > > > >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > >                 return nfserr_perm;
> > > > >
> > > > > -       if (acc & NFSD_MAY_LOCK) {
> > > > > -               /* If we cannot rely on authentication in NLM req=
uests,
> > > > > -                * just allow locks, otherwise require read permi=
ssion, or
> > > > > -                * ownership
> > > > > -                */
> > > > > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > > > > -                       return 0;
> > > > > -               else
> > > > > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OV=
ERRIDE;
> > > > > -       }
> > > > >         /*
> > > > >          * The file owner always gets access permission for acces=
ses that
> > > > >          * would normally be checked at open time. This is to mak=
e
> > > > > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > > > > index 854fb95dfdca..f9b09b842856 100644
> > > > > --- a/fs/nfsd/vfs.h
> > > > > +++ b/fs/nfsd/vfs.h
> > > > > @@ -20,7 +20,7 @@
> > > > >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_READ =
*/
> > > > >  #define NFSD_MAY_SATTR                 0x008
> > > > >  #define NFSD_MAY_TRUNC                 0x010
> > > > > -#define NFSD_MAY_LOCK                  0x020
> > > > > +#define NFSD_MAY_NLM                   0x020 /* request is from =
lockd */
> > > > >  #define NFSD_MAY_MASK                  0x03f
> > > > >
> > > > >  /* extra hints to permission and open routines: */
> > > > >
> > > > > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > > > > --
> > > > > 2.46.0
> > > > >
> > > > >
> > >

