Return-Path: <linux-nfs+bounces-10551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0689A5C75D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920B83AC3D6
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB11DF749;
	Tue, 11 Mar 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="aqPFg69y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBF15820C
	for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706920; cv=none; b=ZwEZ9gQc8XxLGEAZOmrvZQIYmbmzQVsIE005XVKfeJQxL7QgFOxniXzW9caj79dpx9yNmmv5rPU6azNJzNZsS7Uk3Au8IFu4r230e4Fhub2KoLlZNaF0FSnGejV623qOl3ct9kUXVCfCLCjiaMhgXpWGqN9FijrRk2b0PkAoXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706920; c=relaxed/simple;
	bh=dXF4elIW/9KFmhvChfu9o60RwzCZWtOODs/fNQJcAiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtJYEB8S+2jHvfyJjo1pDdOov6tQiDdAFQBZLejSrYd8LYjrKFvGjuHzJQuwqjWQMsmymCArPlQbPuN/W3wROkA0kzpCqhiHMD0CyF7IakCVLtMQf76QbXcnW2rnQciGvppzYq9V53cTjLB+01E7iRZAswoasPJ7Wnvh1XIRmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=aqPFg69y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso44758261fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741706916; x=1742311716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QfrqJdUHjNKT+aP9ElWlnONJIr641jG9fLZLCNT+iY=;
        b=aqPFg69yOeZVjG1tKEQFf9tkpqBIT58rxdbzoFG1qX8dGGtvwqrVO9T1KVuOWI7/Os
         9WsxumVnkZbybWJYmabTaUx7JWl6XYw/SKwCxyh0SDaFY6Pw0EaS58EU94RILn+4MT1B
         jFM6f6ecymkgnGNy18OlfTuATTEhfVhzSa/5NDLOUefaslXRgLJW/y1xJgI1XdS9yXgC
         AfXej3tfvcWIRbm2V9zx5VuwL0R8a2NJoa6uYJzjh92FBywDQ+LTQVIlZ5glaYKSMI5D
         Q8dywXZqQv35E0ZPMmz8lRn0nGdD5b/aAHP8gpbiWN72z2LhNmRHgCKPpx+6Qe3uTM6W
         MCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706916; x=1742311716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QfrqJdUHjNKT+aP9ElWlnONJIr641jG9fLZLCNT+iY=;
        b=rB+KZEfeCL7M9zuhowR02j1lmBu953rDAYa27Hy0z1y3wMcyBF2pMOol/PdQQhyxXg
         +qv5IzLxHBS0UF4SKpOi92dH7j39IeTmp+FJHVyLWrIUUjyvKoQK23Hm3y5+7gHeYjO8
         r9Xaef96SlSXEXftE5h0T17vtloOtayMnru+n/fTwGJ+sCUqGUcQ0LxeHIfTJBCV+tOC
         gYl/kSdbngejCeaRVyOY49j5aKTGL5ttwpBwtAsPNj8AnDY3IKnK6PH7L1zyarRrU7I0
         YPLsQ6UI/BoKje2FFaRcRM4trvAohmru9golJ7XzWrKjHZRFB7drgq14Gpi8y8UbmQAI
         BRHg==
X-Forwarded-Encrypted: i=1; AJvYcCVm5keZyj8yymnUuL3OPf9c6C6LXRkG2KdT/1JcD84U7ZWJ1drL5uyBO5kNZHx7aZlRssWYER0+QVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQia/A14z5vD52+nIWiZJECUbP7H10Tf7ndeF6BKfd1Vt2DEY
	wzeGVrkKsn9q+q/k9yrkRlYIpyIPh5fbx5f7wufS8EsQfQ5E92W35jcwOe7sWTckIRuMcw8jQE8
	CwCOr7U2P5zvKTLJPhJK1VFCTUVQ=
X-Gm-Gg: ASbGncv+e/ONDOvoJvWOrfXWiazVsUAJWYDFV7jP6Kn2sJ7SAGE5TuVuzDbNcAL+R5X
	CoHKaJDUdutn/PR1Z6YTh28HXqS9gRR58aInCKm9tJE6ZNX7SSfKis0h+R76welrk2KCeZ7k35V
	lCp0kisckKjkDPGI2ClDLHo0muQThpCug7j2cL+D03xwtJeKP47pogRa7uDwuL
X-Google-Smtp-Source: AGHT+IFcCVB6RkQOhK8pVrUOGtjqkx2qntnu7CtefupWBKPwAbOTBEsN9+ZQO1bdc8JyNXr9rFTDSIMTmzDE13Al3oc=
X-Received: by 2002:a2e:bea3:0:b0:30b:fc3a:5c49 with SMTP id
 38308e7fff4ca-30c20ebea1bmr20213201fa.9.1741706915705; Tue, 11 Mar 2025
 08:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172920135149.81717.3501259644641160631@noble.neil.brown.name>
In-Reply-To: <172920135149.81717.3501259644641160631@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 11 Mar 2025 11:28:22 -0400
X-Gm-Features: AQ5f1JoHP1vnpbVturAD3a7T_56saYHzzFtjoJv9Ghk6wXzLfkvGt_OIldPIcN4
Message-ID: <CAN-5tyHb5ZVtqPyVqjbG8gjdgPvrMQsnXmgTeN_4wphTaMkHkw@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
>
> NFSD_MAY_LOCK means a few different things.
> - it means that GSS is not required.
> - it means that with NFSEXP_NOAUTHNLM, authentication is not required
> - it means that OWNER_OVERRIDE is allowed.
>
> None of these are specific to locking, they are specific to the NLM
> protocol.
> So:
>  - rename to NFSD_MAY_NLM
>  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
>    so that NFSD_MAY_NLM doesn't need to imply these.
>  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
>    into fh_verify where other special-case tests on the MAY flags
>    happen.  nfsd_permission() can be called from other places than
>    fh_verify(), but none of these will have NFSD_MAY_NLM.

This patch breaks NLM when used in combination with TLS. If exports
have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the server
won't give any locks and client will get "no locks available" error.

>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
> No change from previous patch - the corruption in the email has been
> avoided (I hope).
>
>
>  fs/nfsd/lockd.c | 13 +++++++++++--
>  fs/nfsd/nfsfh.c | 12 ++++--------
>  fs/nfsd/trace.h |  2 +-
>  fs/nfsd/vfs.c   | 12 +-----------
>  fs/nfsd/vfs.h   |  2 +-
>  5 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 46a7f9b813e5..edc9f75dc75c 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, s=
truct file **filp,
>         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
>         fh.fh_export =3D NULL;
>
> +       /*
> +        * Allow BYPASS_GSS as some client implementations use AUTH_SYS
> +        * for NLM even when GSS is used for NFS.
> +        * Allow OWNER_OVERRIDE as permission might have been changed
> +        * after the file was opened.
> +        * Pass MAY_NLM so that authentication can be completely bypassed
> +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
> +        * for NLM requests.
> +        */
>         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_REA=
D;
> -       access |=3D NFSD_MAY_LOCK;
> +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYP=
ASS_GSS;
>         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
>         fh_put(&fh);
> -       /* We return nlm error codes as nlm doesn't know
> +       /* We return nlm error codes as nlm doesn't know
>          * about nfsd, but nfsd does know about nlm..
>          */
>         switch (nfserr) {
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 40533f7c7297..6a831cb242df 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
>         if (error)
>                 goto out;
>
> -       /*
> -        * pseudoflavor restrictions are not enforced on NLM,
> -        * which clients virtually always use auth_sys for,
> -        * even while using RPCSEC_GSS for NFS.
> -        */
> -       if (access & NFSD_MAY_LOCK)
> -               goto skip_pseudoflavor_check;
> +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM)=
)
> +               /* NLM is allowed to fully bypass authentication */
> +               goto out;
> +
>         if (access & NFSD_MAY_BYPASS_GSS)
>                 may_bypass_gss =3D true;
>         /*
> @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
>         if (error)
>                 goto out;
>
> -skip_pseudoflavor_check:
>         /* Finally, check access permissions. */
>         error =3D nfsd_permission(cred, exp, dentry, access);
>  out:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index b8470d4cbe99..3448e444d410 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>                 { NFSD_MAY_READ,                "READ" },               \
>                 { NFSD_MAY_SATTR,               "SATTR" },              \
>                 { NFSD_MAY_TRUNC,               "TRUNC" },              \
> -               { NFSD_MAY_LOCK,                "LOCK" },               \
> +               { NFSD_MAY_NLM,                 "NLM" },                \
>                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" },     \
>                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },       \
>                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_ROOT" }, \
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 51f5a0b181f9..2610638f4301 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_e=
xport *exp,
>                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
>                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
>                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
>                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
>                 inode->i_mode,
>                 IS_IMMUTABLE(inode)?    " immut" : "",
> @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_=
export *exp,
>         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>                 return nfserr_perm;
>
> -       if (acc & NFSD_MAY_LOCK) {
> -               /* If we cannot rely on authentication in NLM requests,
> -                * just allow locks, otherwise require read permission, o=
r
> -                * ownership
> -                */
> -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> -                       return 0;
> -               else
> -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> -       }
>         /*
>          * The file owner always gets access permission for accesses that
>          * would normally be checked at open time. This is to make
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 854fb95dfdca..f9b09b842856 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -20,7 +20,7 @@
>  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_READ */
>  #define NFSD_MAY_SATTR                 0x008
>  #define NFSD_MAY_TRUNC                 0x010
> -#define NFSD_MAY_LOCK                  0x020
> +#define NFSD_MAY_NLM                   0x020 /* request is from lockd */
>  #define NFSD_MAY_MASK                  0x03f
>
>  /* extra hints to permission and open routines: */
>
> base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> --
> 2.46.0
>
>

