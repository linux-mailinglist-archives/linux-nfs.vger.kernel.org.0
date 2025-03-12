Return-Path: <linux-nfs+bounces-10575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2AA5E7B5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C591899BDC
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CE1EFFA7;
	Wed, 12 Mar 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="FiKWAFFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018681D5CC6
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820096; cv=none; b=R1pfRZRLLgWOFT2klH+9NoOnUZSdxReYzhBFtzgF5EB0L3jA71owZG4wz7OeS+z+9FNd2Lb3408a/JdJDmQd81yAZ4lI+qF4JDzpldHA6BNGQ/ZupP+pFrQC46RJOKV6wlbZ20MM1vdafA+CjQgbwEJ54tOk6TomOLAdeOfKeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820096; c=relaxed/simple;
	bh=DaFmI4Nw9cj93s2RprFaJtGG35ATf9KrPdA/QRs/ErY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRNKTlY+tj5O3PgZCMrdy/0320sSjaB/dgi+HwTRBtqLefockAWEHx27FkM7munBZJEjQBIjkSY38PyGVmUcLld5JTB3bSG/55rkJM15HLyXHx3S0FM+DpV0kF7Zwj7N7bZ8PQav3uPVtz1yvVgjgd4nCZ69txq2zl/VsOSxj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=FiKWAFFj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so377229e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 15:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741820093; x=1742424893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKxtjL7BGqYccA4dJkw81jDDIMMKajhFuz+X3eJGsAo=;
        b=FiKWAFFjS/6kb7NsyFTCNapuINN/eYYiuRc1MvWJTMXgUtyx5kFBQNE2sfMg70rkL2
         OYTKNvwAZ2/ID0dEOhGpLyy0t4T5HwfoZmoOmIPpWMFBbHmxrLBVBH94Rbn6v2/LOxih
         7cNKwUZER+XllIV9yFmabaJnNuvW45H0OtHwdVFZrVo6czQsuZapKoxR0wHfGfMlhHX9
         XEvpGuIeWsC9ai0BltjAh2Y8ST4pdBN8HFa6kmEksuIdP9kEu5msZnZJmuvNzSxpX5Kj
         LkCRneIboW8tM1ftB4Lsn9k/Y0Nu4wlYI2riXxvJkgdQI3xPYesV2COUFRPdqVxwtdaq
         1ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820093; x=1742424893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKxtjL7BGqYccA4dJkw81jDDIMMKajhFuz+X3eJGsAo=;
        b=FPWGwR49GOD8ZvF1AJRA7SCsfUUcu69Al9ysmbsCeCY6Qt6gDHLjU6cKldLtMQsQb1
         khSfAoH6vaQXMECQK59hjIF/++fuMkADmKMBUtyIPMDl+sEtwEppLCJjWMepPdXQskCR
         Us4yhgeFYgQ3A3G9bxvSCIZEvm4nnQEnYFAQ6ygJYMGjZsTZtZoPKREjrXI+q5KR9aLU
         qvYVgDj9ftJ37LxYRKwbpM0igZWiiHGOlJMXFXCqb93KaZrPpMIkZFPggLSrOwv22+Fr
         qXKFrpLTabTIT+9k5mAuT4D94mkoQnRC8nHG8jLWxvDCGycONvHq2o/HAkFCv8Kv5jDL
         1v5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtVYrXJdDfDaKrEowsEd+NbbG3Oj7lE3DsyuK5r17q1XGSLpLhwn8qgb2YdRpeAA6Ml+6pYl4eRvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnnt6i8XqllEnAFuYXUeLONfODvV4dg9JJnB7to97SxmOinM6
	8AT7REbOpwLYwLodfAFqVrtfqogtS7NXRX9cBuGlZmcVU9UTP1lruYXmfpsMtkcQ3LGIXE1KZ1U
	uWXJAAtJH/WLmErSgv3/6RMiY2uQ=
X-Gm-Gg: ASbGnctMXZcAPJ86UVgxZxnwdnhUs58uRvqxrS/LPnVm3xTyo0GiRSRZjpwnsRAkAKL
	fnwpfMBH6evEWNAe+zdAHTzpcMNVXiRhdx91lyY2Q5L7pwdE25sDXGZmKzwmul+vo1SA9PPiUy3
	iFFF4oRNQ3mJ77jbOdDh9+dzfgcpZ6jUHLCl2vsjiIotItWuMbVSmyrc49fPIh
X-Google-Smtp-Source: AGHT+IHNuMp+GnNL7FwCK3KHP7vwnfospw0i3qOsq/z6yzU+nuHIiOAeNOx6BONWw38qsvw50T+afA6L/SVLVrLxGkg=
X-Received: by 2002:a19:6408:0:b0:549:b0f3:439d with SMTP id
 2adb3069b0e04-549b0f34586mr1899902e87.12.1741820092974; Wed, 12 Mar 2025
 15:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com>
 <174181841557.33508.11810351442398748810@noble.neil.brown.name>
In-Reply-To: <174181841557.33508.11810351442398748810@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 12 Mar 2025 18:54:41 -0400
X-Gm-Features: AQ5f1JpiDCn4jIxG3_13kRlRlcvt2hVSen0Ppd2ae2PeirkZ0ca-IN9TYB546Wo
Message-ID: <CAN-5tyGak9WbYZtU6X_2cVLaMGfxTBsiTr3hZVmRyK3NqixJhg@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:27=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> > On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@um=
ich.edu> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de>=
 wrote:
> > > > > >
> > > > > >
> > > > > > NFSD_MAY_LOCK means a few different things.
> > > > > > - it means that GSS is not required.
> > > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not re=
quired
> > > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > > >
> > > > > > None of these are specific to locking, they are specific to the=
 NLM
> > > > > > protocol.
> > > > > > So:
> > > > > >  - rename to NFSD_MAY_NLM
> > > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_f=
open()
> > > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() a=
nd
> > > > > >    into fh_verify where other special-case tests on the MAY fla=
gs
> > > > > >    happen.  nfsd_permission() can be called from other places t=
han
> > > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > > >
> > > > > This patch breaks NLM when used in combination with TLS.
> > > >
> > > > I was too quick to link this to TLS. It's presence of security poli=
cy
> > > > so sec=3Dkrb* causes the same problems.
> > > >
> > > > >  If exports
> > > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the serv=
er
> > > > > won't give any locks and client will get "no locks available" err=
or.
> > > > >
> > > > > >
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >
> > > > > > No change from previous patch - the corruption in the email has=
 been
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
> > > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nf=
s_fh *f, struct file **filp,
> > > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > > >         fh.fh_export =3D NULL;
> > > > > >
> > > > > > +       /*
> > > > > > +        * Allow BYPASS_GSS as some client implementations use =
AUTH_SYS
> > > > > > +        * for NLM even when GSS is used for NFS.
> > > > > > +        * Allow OWNER_OVERRIDE as permission might have been c=
hanged
> > > > > > +        * after the file was opened.
> > > > > > +        * Pass MAY_NLM so that authentication can be completel=
y bypassed
> > > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use =
AUTH_NULL
> > > > > > +        * for NLM requests.
> > > > > > +        */
> > > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NF=
SD_MAY_READ;
> > > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NF=
SD_MAY_BYPASS_GSS;
> > > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp)=
;
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
> > > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_=
NOAUTHNLM))
> > > >
> > > > I think this should either be an OR or the fact that "nlm but only
> > > > with insecurelock export option and not other" is the only way to
> > > > bypass checking is wrong. I think it's just a check for NLM that
> > > > stays.
> > >
> > > I don't think that NLM gets a complete bypass unless no_auth_nlm is s=
et.
> > > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is suppo=
sed
> > > to make it work.
> > >
> > > I assume the NLM request is arriving with AUTH_SYS authentication?
> >
> > It does.
> >
> > Just to give you a practical example. exports have
> > (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. The=
n
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
>
> Can you see if this fixes it?
> Maybe we need to bypass tls as well as gss
>
> Thanks,
> NeilBrown
>
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp,
>                     test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
>                         goto ok;
>         }
> -       goto denied;
> +       if (!may_bypass_gss)
> +               goto denied;
>

I don't think this would help in any way as NLM does pass may_bypass_gss...

>  ok:
>         /* legacy gss-only clients are always OK: */

