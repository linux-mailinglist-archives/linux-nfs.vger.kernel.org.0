Return-Path: <linux-nfs+bounces-15574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB424C01B7E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBAE05636D0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A1328B58;
	Thu, 23 Oct 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Vff9Wc+O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D51328B45
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228959; cv=none; b=l2g9mTnhn1k0C3tbUoI77308hCEQuZmgSbor0ey8gLzr7ptheWbTSq7T4C1k/PkZx1wWOXoDlNtLJIuSMbpoI782aMLbhlHDVOgYxtClyraLaAdmsASi18QUOs7tGhY9cjm6IESMdIJjDs/fuzfdCMzmSCAC9/dnlpTXYGTcZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228959; c=relaxed/simple;
	bh=La81eW4v0yruMqAG7pyWKPXE9t1yZcIi/tuE29sb5AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfDitNazuj8vS29SuKPvpH7xl4x7TZOjEfAPs4TNECJMXF1RIeCYwKDKPa01XULpFDoBNj8Kml1A9PBxYe6PqMF9rW+xzoI1n0ws6oodBxPc3t05d5VHZfDzl+tHH3JiArNbmi+YuSczDkapFlUQKS6crT6uzn2iaeSwYNsWiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Vff9Wc+O; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-375eff817a3so10353401fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761228954; x=1761833754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnmzaZy4L/iYlPObH/mLNJiUdG2gST8lT8jLSfDBEeA=;
        b=Vff9Wc+O22gzyaGqiVCvoWrsOk5a66kSUAIhTFUlqWhUULBNE4lNdMY+chtHKXbVHi
         7J0YHO9nqqySmHNU2jMBUtBdzhuDSkGt6zoCZk7G3c+B/hkWZYsLRucdYSMpFF6H441F
         6iavBq0MLKr+nEKBEKkJXOzRfF2pmrO28bCF2QfqW/t4m8gHds+VO1dHdk74zfMktbNc
         MQiN3jFMYLJAuj5KWK8C01JZCt5j3Do9oILssUp+KgZ64o4jjWFLT2aqjKL54WdjQY9l
         2Pr1XpZLHdsM7G/nAzylNyyte416w6NvLmlAAI7CwpcuJPD9P+TKNJoO6LYvvSM59KMZ
         510w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228954; x=1761833754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnmzaZy4L/iYlPObH/mLNJiUdG2gST8lT8jLSfDBEeA=;
        b=HJxRXxw7Y/MvMgnRQQpMUOYySTcapbJ1ny3M3Em8/VUCXJ/GJwB7N/9wg2XrAC01ex
         bcij8c5dpPyo3U1PZpW4Rt46EjukbQVwRyLWRJndYTLlexBmoy7dhMfpT0hflSI28jZ6
         h3fC5r19+btV9HUNYm4BmZgfqykEX3cV6yh55Hl3FR1wvWcQZ2n+zPx/9VQJQqSAI2CD
         OuNxrKdR80dq2wSNVMxNDq4B39GByTI+GWfBqzOzw2NUfePl0ToJo6Amc37cLmR6Qpo1
         PbnppKojH0ZQmAd79HWKcnnOJDZTRefw9803pVeH4B38xDHvemNB2gBYG6BjIssMIRQr
         sLmw==
X-Forwarded-Encrypted: i=1; AJvYcCU5sjqy/0rf7URVKxT/Xl33USbj+q5Ip2dt4IM1Dajrgw4tTCENerXIumI1td4l/ypG/4dsK77QLmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVlYdu+J1ZdlJCBUHb3zZdKz51AH3gvEgpb+MDz01A9UntIP/
	kqAYlOkTV46NvPn7qnPoWRcGOjlry5N3l8jPR9wjyL5nByfdHFnG38jpW3Wmz83rxkpWNHY1NQC
	RkiTG2x7QwszBsyB5WYZoTDniHr7DHBU=
X-Gm-Gg: ASbGncvLTuJJGIYVFrXQpFsINh3yxtsJ7Q5pA9V4V8bvQSSsa1Vqc++veXvyHnRvKSx
	X5BRvzG3IXYP1SNt0e3eoWwrc3bveVTR4PQeI0Ak2wmd7sW8GpZXazCxDIWY6GHDb9KXQKiHra3
	E+chvI69T0Vztm2ot2BD08PhlKpZmER4JV7ZdzIYZ0HxiKpCpjnI4rG8UvicOMus42dbEXup2zQ
	WaXGUneleuwxaoCIkDprJhIWuir2ffWGhlv0aXevFxtKU1xqMMVjQATlp2k
X-Google-Smtp-Source: AGHT+IFIEg9F3wCW2DjE72mm8ubEmFJpMVM/CxWOCwjxKYaiEKwJ/npB9DMzTCtDvWviGrdQzHR9avtVt8eUYtm8heA=
X-Received: by 2002:a05:651c:199e:b0:36c:ebb0:821c with SMTP id
 38308e7fff4ca-37797831bfbmr71129001fa.7.1761228954181; Thu, 23 Oct 2025
 07:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
In-Reply-To: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 23 Oct 2025 10:15:42 -0400
X-Gm-Features: AWmQ_bl9LY18HUud66HWLCTuVHA73J6fbzjK7A4y_hLW0wHInsec9HTsdyfuLkQ
Message-ID: <CAN-5tyFFx+_WnLbHq0bLH0uQ7XkK=wh2urooqvauTW-hxxz7cw@mail.gmail.com>
Subject: Re: [PATCH] lockd: don't allow locking on reexported NFSv2/3
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:13=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Since commit 9254c8ae9b81 ("nfsd: disallow file locking and delegations
> for NFSv4 reexport"), file locking when reexporting an NFS mount via
> NFSv4 is expressly prohibited by nfsd. Do the same in lockd:
>
> Add a new  nlmsvc_file_cannot_lock() helper that will test whether file
> locking is allowed for a given file, and return nlm_lck_denied_nolocks
> if it isn't.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

> ---
> Regardless of how we fix the bug that Olga found recently, I think we
> need to do this as well. We don't allow locking when reexporting via v4,
> and I don't think we want to allow it when reexporting via v2/3 either.
> ---
>  fs/lockd/svclock.c          | 12 ++++++++++++
>  fs/lockd/svcshare.c         |  6 ++++++
>  include/linux/lockd/lockd.h |  9 ++++++++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c1315df4b350bbd753305b5c08550d50f67b92aa..cd42e480a7000f1b3ec7fca5e=
cc7fb8dc4755a09 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -495,6 +495,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>                                 (long long)lock->fl.fl_end,
>                                 wait);
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         if (!locks_can_async_lock(nlmsvc_file_file(file)->f_op)) {
>                 async_block =3D wait;
>                 wait =3D 0;
> @@ -621,6 +624,9 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
>                                 (long long)lock->fl.fl_start,
>                                 (long long)lock->fl.fl_end);
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         if (locks_in_grace(SVC_NET(rqstp))) {
>                 ret =3D nlm_lck_denied_grace_period;
>                 goto out;
> @@ -678,6 +684,9 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file,=
 struct nlm_lock *lock)
>                                 (long long)lock->fl.fl_start,
>                                 (long long)lock->fl.fl_end);
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         /* First, cancel any lock that might be there */
>         nlmsvc_cancel_blocked(net, file, lock);
>
> @@ -715,6 +724,9 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
>                                 (long long)lock->fl.fl_start,
>                                 (long long)lock->fl.fl_end);
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         if (locks_in_grace(net))
>                 return nlm_lck_denied_grace_period;
>
> diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
> index ade4931b2da247abd23bd16923f1d2388dc6ce00..88c81ce1148d92bd29ec580ac=
399ac944ba5ecf8 100644
> --- a/fs/lockd/svcshare.c
> +++ b/fs/lockd/svcshare.c
> @@ -32,6 +32,9 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_fil=
e *file,
>         struct xdr_netobj       *oh =3D &argp->lock.oh;
>         u8                      *ohdata;
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         for (share =3D file->f_shares; share; share =3D share->s_next) {
>                 if (share->s_host =3D=3D host && nlm_cmp_owner(share, oh)=
)
>                         goto update;
> @@ -72,6 +75,9 @@ nlmsvc_unshare_file(struct nlm_host *host, struct nlm_f=
ile *file,
>         struct nlm_share        *share, **shpp;
>         struct xdr_netobj       *oh =3D &argp->lock.oh;
>
> +       if (nlmsvc_file_cannot_lock(file))
> +               return nlm_lck_denied_nolocks;
> +
>         for (shpp =3D &file->f_shares; (share =3D *shpp) !=3D NULL;
>                                         shpp =3D &share->s_next) {
>                 if (share->s_host =3D=3D host && nlm_cmp_owner(share, oh)=
) {
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index c8f0f9458f2cc035fd9161f8f2486ba76084abf1..330e38776bb20d09c20697fc3=
8a96c161ad0313a 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -12,6 +12,7 @@
>
>  /* XXX: a lot of this should really be under fs/lockd. */
>
> +#include <linux/exportfs.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
>  #include <net/ipv6.h>
> @@ -307,7 +308,7 @@ void                  nlmsvc_invalidate_all(void);
>  int           nlmsvc_unlock_all_by_sb(struct super_block *sb);
>  int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
>
> -static inline struct file *nlmsvc_file_file(struct nlm_file *file)
> +static inline struct file *nlmsvc_file_file(const struct nlm_file *file)
>  {
>         return file->f_file[O_RDONLY] ?
>                file->f_file[O_RDONLY] : file->f_file[O_WRONLY];
> @@ -318,6 +319,12 @@ static inline struct inode *nlmsvc_file_inode(struct=
 nlm_file *file)
>         return file_inode(nlmsvc_file_file(file));
>  }
>
> +static inline bool
> +nlmsvc_file_cannot_lock(const struct nlm_file *file)
> +{
> +       return exportfs_cannot_lock(nlmsvc_file_file(file)->f_path.dentry=
->d_sb->s_export_op);
> +}
> +
>  static inline int __nlm_privileged_request4(const struct sockaddr *sap)
>  {
>         const struct sockaddr_in *sin =3D (struct sockaddr_in *)sap;
>
> ---
> base-commit: 316f960d9ffb8439e0876dc2eab812e55f3ccb2a
> change-id: 20251023-lockd-owner-a529e45d8622
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>
>

