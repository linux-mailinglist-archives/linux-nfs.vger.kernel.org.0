Return-Path: <linux-nfs+bounces-10554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4557A5CDDB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F78F3ADA6D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89028263C6B;
	Tue, 11 Mar 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ZLi5biPr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF26225760
	for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717555; cv=none; b=HQIs39eRnCApmp38cIuVvnSRWxr/z7C+OGNbcbdQr7VAc61nuTGrjGVB5nhY15upgwQnG39s7nEQ5o85mOvs1oHxb96PlS1YRhJ/Ui1M+1srhpp7b3wLsspp66v66zOD8d17C+I3+Sn9Sa2mlccEn2PhBvC9gJXk8WbT+m2H70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717555; c=relaxed/simple;
	bh=pWa/Y9H37PEkmzYjS/teONr/mDWaaMz86eJiSzCYmok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMdrLl92dtD3ASow+J9SHAOXzqoi8DCooqnT9kFiB9oU0LzyZDsYVF44ftJ5uUAktGbEc2uxFYLLIUOHAcHNFwvDcixTrEbcrGpTgqJ20qVWX66Kb2AbFLKpoJ6Nn3qhy1DU14EbRt7JQ6sWdcjgJbJh4p474nu5anaTPc64qKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ZLi5biPr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso1043721fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741717551; x=1742322351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRTPVNt7euXowYRaci8qWQOJGEm3SA0tg1/ytQ7I+GI=;
        b=ZLi5biPr/zAGnXd81sk/eDAt1fROOcOC/2b8qUB0QNEnOnRoTQ6jdua5j03w1Y4PNt
         oAWVXAUNjDeMWN7WyIxOmoih/U92JaI24hFkSZF5VYS02kOzbULPKbTZUZPgdG+jq0so
         c3h0EUa2ajvL+56/TsJ6N8xZ2ch0f7imxjSAJnHGtLrfXTCCwiFiYihiKDptE4qhsPoo
         AcCi4rnsB5R0Keo3hvxvDVyH0Ilin6W91lagisaY6zn+la7nbF9EDYNMaJKn9QdsXQNy
         wi/tAtrp2AqapmjMJrWux/P1hbL1e+VZDDehuv1m9KcFi8gsIBVi0gMuXZ2kku3GSIDL
         adwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717551; x=1742322351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRTPVNt7euXowYRaci8qWQOJGEm3SA0tg1/ytQ7I+GI=;
        b=vK+iEG1wtpmX28mD1D9bSA9TVvQWTm0IG97YK+CyD+DZ7hy/Dj1gHcc/ghllsYecuz
         n2UKYwcjf4Ge1zyN1zwnvWEg2peDX2iBcW6dGdaXKU0XTOQqsoDI/aFq1t05sSzKI+MF
         2VkeEjoUrl2pSNt6DDYDy30H+ddZZbPpgEZ3ZXEobgLTpX0nTvwtXAJH7dpDbxgZLNIB
         3U2YZlvOyd7oby7AG8bROeXF5XpVExHl2+VDzDvjc/QG8XreN6hs03AeKZENDS29eQBU
         K/Q5wfZSwzBfwSJM1VEEwfzAcdTkoUY0kgclGa4ScVmSF0mgWxGDhXz2nTQ9aHJa/4tQ
         FLpg==
X-Forwarded-Encrypted: i=1; AJvYcCURS0EOZYamMXZ0QQ1kqxXVJvKL72FaSlrJU3XDI/yyaW0JSS4M+FGBH7OCFD/cd1IQWy0QtVdDzPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkVYLnKoE2XqqkHgbfjfuUX8DHuufRS9tVrcoBqzx10YgmhO5
	z13hDHNtBXY9t9emOL8Z59DPS9rHrb5bj3l1cjvcLFi5vIjp2JD0CM54oO6In8cnLfCvPCauAAN
	2HTgpb+PBo+XufXf3KXctohPXtSM=
X-Gm-Gg: ASbGncvLbLecv7QU5mhYUF53jS7wPSJb7sOqraLMc7X5UyJd2D7PuOeHasN8HIy7OiU
	S8zJ0tcFfbOATj2AIgiakyC60LIvv8DKoS1KnCX3w5r+FQ45bJeNPreZiLFRMQ4Owt1xCY1GvLU
	xMq5VjnNch1WARPqt3QCJFKTx2rLxwbcNMsM3eTkvcpiaka7xcfP1z/c3YpRoj
X-Google-Smtp-Source: AGHT+IEAm3dxlahro9uDLXox9db9icxr92rvp/8eZagJKy1tVOOeViGHNatOUxTl97ELNShmqTmTvBMuFQ/7vFtY9R0=
X-Received: by 2002:a2e:9e45:0:b0:30b:9793:c1f6 with SMTP id
 38308e7fff4ca-30c20f75165mr14652851fa.17.1741717551113; Tue, 11 Mar 2025
 11:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172920135149.81717.3501259644641160631@noble.neil.brown.name> <CAN-5tyHb5ZVtqPyVqjbG8gjdgPvrMQsnXmgTeN_4wphTaMkHkw@mail.gmail.com>
In-Reply-To: <CAN-5tyHb5ZVtqPyVqjbG8gjdgPvrMQsnXmgTeN_4wphTaMkHkw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 11 Mar 2025 14:25:39 -0400
X-Gm-Features: AQ5f1JpWFFytPpXSSzIcd827HlD-EUIkb8lmMGO1b_p-FtXuqvNO7rqD-LDcfY0
Message-ID: <CAN-5tyH4E-qaK0TEtUMn3QpB0rYsDjm_erqRwVko7bAgYdmQBg@mail.gmail.com>
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
> This patch breaks NLM when used in combination with TLS.

I was too quick to link this to TLS. It's presence of security policy
so sec=3Dkrb* causes the same problems.

>  If exports
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

I think this should either be an OR or the fact that "nlm but only
with insecurelock export option and not other" is the only way to
bypass checking is wrong. I think it's just a check for NLM that
stays.

> > +               /* NLM is allowed to fully bypass authentication */
> > +               goto out;
> > +
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

