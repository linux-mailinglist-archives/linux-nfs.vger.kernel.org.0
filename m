Return-Path: <linux-nfs+bounces-10553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0092A5CAF9
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733073B8134
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75150260378;
	Tue, 11 Mar 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SdgOYKhX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4B25F7A9
	for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710957; cv=none; b=AvWHdO4bkEniuSrkhGBdMjMA/4dkjMJ4bYxXvECbEEmRl724ohny1MLpn08VVgg70t1aTMrUAVmOpne3p9AqYe9BRO8PhJAMYRb5z49INXntrTrZzm6DJ/mQRBDbcw3fKAwGYQGzISbLU1czspoSO47mCTop87Rd7z8RKbBcoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710957; c=relaxed/simple;
	bh=lP6m0cZZxtNzmjQWBlP3K90nDAAwxsaacQVezwmOpYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8tJdLQL44q5K91qCyUb3ASj9SvHgBPsC8iE0euLr6RkYxHF/O+nMDbCrxT4F9gnwAqGthM9mmENaWJLfVxjHUl7vclA3ja++tnlyfZ6ygWMYONtksb+4aai3R62AZmr92fkIAyZBrRGi0jTbzroumbq6QzmC0eOtv04NCg5YYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=SdgOYKhX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfca745c7so38749871fa.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741710954; x=1742315754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmrlqYXTyBPcP02wpgSdQOryaGme0pbpnMA8DPl0fDg=;
        b=SdgOYKhXfJIK1qcUU07W0GiaBDUpdT9wOnP67nUkNxLYUVCXG7QkaBgcGSjDj4xke7
         RVlo3x69PK53cZxwuAp8A65qO1u4HSM3EElfV4ntf7xE8h9nAFZW9F1ury1BBxjLhaLR
         3iS6R1zloBMWmXJMb95FInmbUPMbRG/DHf88QximZMQdwW+kAUh0S+jTjsL7WVumY202
         /aaajuhioFQCuNZXdhY/dhGswJJJxU5M5HcOAxT0JrTmEJJ3GcP7bLRMsaDn2oy3UR0Z
         +yYfRbeTRfliuQt1OTiQR7/TH70GbpMvSn+MXufLQnwV5HJ0LysE2QrNARGDrWd85BoU
         tp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710954; x=1742315754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmrlqYXTyBPcP02wpgSdQOryaGme0pbpnMA8DPl0fDg=;
        b=WEzfEX6lWBrt+ejxMEg0BuTZvhLhZAyoVe10UIf/qKVN8YkMfiXrQqdldYbqOWDE2F
         JSB09wjiZuStJIbE/kcGD1ljrCEkvuBgaJGcfKLYlIGucE7aBpTSD1K6GSTCX5VyokXi
         MwJ/Mkw7YcX5exAgokHkKz+ttSiQ60gvstbzZ5nnXkFGWYCvvbLl+AScA9nPlzoZZuMC
         E1NWbw8lA/27Y061xVwwmf4SgauSle/HexkANsRjJ/z0qXW+RW7qh1OQPS8fuf6WgSmH
         k1htSeUST3p8VPICAiXlFqMSI3FcY7iWCpu8wYZ/8Xd9wh7sMgAfYOJXPllPvr2JsJyI
         dppw==
X-Forwarded-Encrypted: i=1; AJvYcCWaji/TDMD5eUNhhWX0VL6qtC/F8OmlmHg6tDoC6s5zoKSDkKf8xVimj3Zd34OCJnS3kgdP9YwlKgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3XKUifXCv7SI9zAkS03+PrzVA8M8q+lL3yQKD7p3uUu4G7j3
	kElMNun8vyuSj4FVnZZ83bdHc82Oi0wp9psNEAaOlYrGAETYPhVOYaCCxhEmyKRbxhA+4Z+CJmj
	KTB0lmCJK68wZqE8wrebOPcfIY3Q=
X-Gm-Gg: ASbGncvObQBoc0qpnyBQz1YHrh5FV7jgooQ8uTC6cQxxyLn8xHCYwbZXcF8gsOpdF0G
	kiFjNOHP4lEMR0Fs365oRa4tCv+utKfLn1ONFKwalLJzk/zkvzWFiE45kuU0PFtx7xR3+JmBPOa
	2X9Z2RkHuVzGcV5zOLN/yYFMWqezOYVsYS2FcGil2TJ46e5pvJ/aErzQHxqbc3
X-Google-Smtp-Source: AGHT+IF46cU6USQ3ba6HDmbfkC5awOb+RHf322RZRC7h/d4JFTUySbtmjobPcHTonX27Pwd/GqJyxf8RIE0jFdtVmiY=
X-Received: by 2002:a2e:bc23:0:b0:30c:1002:faac with SMTP id
 38308e7fff4ca-30c1002ff65mr38796591fa.10.1741710953363; Tue, 11 Mar 2025
 09:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172920135149.81717.3501259644641160631@noble.neil.brown.name> <CAN-5tyHb5ZVtqPyVqjbG8gjdgPvrMQsnXmgTeN_4wphTaMkHkw@mail.gmail.com>
In-Reply-To: <CAN-5tyHb5ZVtqPyVqjbG8gjdgPvrMQsnXmgTeN_4wphTaMkHkw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 11 Mar 2025 12:35:41 -0400
X-Gm-Features: AQ5f1JrvjfORv9prgHP-Mb1TrzNLbS-E7H-uy7CZSwm9bQ5DySOUbGc9YKxIcYQ
Message-ID: <CAN-5tyFZmWJ5-1gLyHDt5=o6GuiGKCJsyjMNon-WD4FR2RNZYQ@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> >
> > NFSD_MAY_LOCK means a few different things.
> > - it means that GSS is not required.
> > - it means that with NFSEXP_NOAUTHNLM, authentication is not required
> > - it means that OWNER_OVERRIDE is allowed.
> >
> > None of these are specific to locking, they are specific to the NLM
> > protocol.
> > So:
> >  - rename to NFSD_MAY_NLM
> >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
> >    so that NFSD_MAY_NLM doesn't need to imply these.
> >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
> >    into fh_verify where other special-case tests on the MAY flags
> >    happen.  nfsd_permission() can be called from other places than
> >    fh_verify(), but none of these will have NFSD_MAY_NLM.
>
> This patch breaks NLM when used in combination with TLS. If exports
> have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
> won't give any locks and client will get "no locks available" error.
>
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >
> > No change from previous patch - the corruption in the email has been
> > avoided (I hope).
> >
> >
> >  fs/nfsd/lockd.c | 13 +++++++++++--
> >  fs/nfsd/nfsfh.c | 12 ++++--------
> >  fs/nfsd/trace.h |  2 +-
> >  fs/nfsd/vfs.c   | 12 +-----------
> >  fs/nfsd/vfs.h   |  2 +-
> >  5 files changed, 18 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index 46a7f9b813e5..edc9f75dc75c 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f,=
 struct file **filp,
> >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> >         fh.fh_export =3D NULL;
> >
> > +       /*
> > +        * Allow BYPASS_GSS as some client implementations use AUTH_SYS
> > +        * for NLM even when GSS is used for NFS.
> > +        * Allow OWNER_OVERRIDE as permission might have been changed
> > +        * after the file was opened.
> > +        * Pass MAY_NLM so that authentication can be completely bypass=
ed
> > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NUL=
L
> > +        * for NLM requests.
> > +        */
> >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_R=
EAD;
> > -       access |=3D NFSD_MAY_LOCK;
> > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_B=
YPASS_GSS;
> >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> >         fh_put(&fh);
> > -       /* We return nlm error codes as nlm doesn't know
> > +       /* We return nlm error codes as nlm doesn't know
> >          * about nfsd, but nfsd does know about nlm..
> >          */
> >         switch (nfserr) {
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 40533f7c7297..6a831cb242df 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> >         if (error)
> >                 goto out;
> >
> > -       /*
> > -        * pseudoflavor restrictions are not enforced on NLM,
> > -        * which clients virtually always use auth_sys for,
> > -        * even while using RPCSEC_GSS for NFS.
> > -        */
> > -       if (access & NFSD_MAY_LOCK)
> > -               goto skip_pseudoflavor_check;
> > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNL=
M))
> > +               /* NLM is allowed to fully bypass authentication */
> > +               goto out;
> > +

I think it's not appropriate to add (exp->ex_flags & NFSEXP_NOAUTHNLM) here=
.

> >         if (access & NFSD_MAY_BYPASS_GSS)
> >                 may_bypass_gss =3D true;
> >         /*
> > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> >         if (error)
> >                 goto out;
> >
> > -skip_pseudoflavor_check:
> >         /* Finally, check access permissions. */
> >         error =3D nfsd_permission(cred, exp, dentry, access);
> >  out:
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index b8470d4cbe99..3448e444d410 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >                 { NFSD_MAY_READ,                "READ" },              =
 \
> >                 { NFSD_MAY_SATTR,               "SATTR" },             =
 \
> >                 { NFSD_MAY_TRUNC,               "TRUNC" },             =
 \
> > -               { NFSD_MAY_LOCK,                "LOCK" },              =
 \
> > +               { NFSD_MAY_NLM,                 "NLM" },               =
 \
> >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" },    =
 \
> >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },      =
 \
> >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_ROOT" },=
 \
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 51f5a0b181f9..2610638f4301 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc=
_export *exp,
> >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
> >                 inode->i_mode,
> >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct sv=
c_export *exp,
> >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> >                 return nfserr_perm;
> >
> > -       if (acc & NFSD_MAY_LOCK) {
> > -               /* If we cannot rely on authentication in NLM requests,
> > -                * just allow locks, otherwise require read permission,=
 or
> > -                * ownership
> > -                */
> > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > -                       return 0;
> > -               else
> > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE=
;
> > -       }
> >         /*
> >          * The file owner always gets access permission for accesses th=
at
> >          * would normally be checked at open time. This is to make
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 854fb95dfdca..f9b09b842856 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -20,7 +20,7 @@
> >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_READ */
> >  #define NFSD_MAY_SATTR                 0x008
> >  #define NFSD_MAY_TRUNC                 0x010
> > -#define NFSD_MAY_LOCK                  0x020
> > +#define NFSD_MAY_NLM                   0x020 /* request is from lockd =
*/
> >  #define NFSD_MAY_MASK                  0x03f
> >
> >  /* extra hints to permission and open routines: */
> >
> > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > --
> > 2.46.0
> >
> >

