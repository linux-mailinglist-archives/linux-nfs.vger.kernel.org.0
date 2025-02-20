Return-Path: <linux-nfs+bounces-10209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D92A3E11C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BE4177CD8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69720DD4C;
	Thu, 20 Feb 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRzEymQz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E820C00D;
	Thu, 20 Feb 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069808; cv=none; b=EfiHvV36kl2GodIMT3S3BChxRScBlH0PTCIEiBJpf6JGcmNsm6AvnOxhpU5O0ue1t/pBWCNY3rJQmA6sxNaGlGy6WXjN3+yI4eUuqYcKXNDJ3ZlF3oqWd0by9C6QT5f7rUWg3zQLMcOO51I1h2tQfRvwuXc1kkahATdv6ph7Y14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069808; c=relaxed/simple;
	bh=vVECa4utTX4xbUhcnJWoWLUVHp/KMDoJ9zPavXCFBLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekUH/UimQ5T4+8c8T71IF9Y14fZfUw93GV+j31yINhdsT1yyds59ttasQd7plh7eqtnT0GrF4NuN5GI+rvIZ4+oo5jqraIQLytmHknr5RJfuPse+XA8+2Sp3fMEDaGltc7ahaNv5i5X4v69lIhlV1PP3h8iY5k4icpmE2Ygf4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRzEymQz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so4005513a91.1;
        Thu, 20 Feb 2025 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740069806; x=1740674606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGKStiuvmu6PZ8iLcfPINnLEtELIaRoHYvov97O+LS8=;
        b=IRzEymQzOj9QOg7SyFdfAictqfazKy2RYm2Tv58CbPI8i1RS4TFQQD/Omw9qfU3gPa
         ePuZdhTVv3SjyKJS6lxm4wRAY+Mo6u5FtZ6awXGIZ9Gj+h86Fdn6lIpee21MACG3gaeG
         77jnyncXD3YNCy6piVffOPYVltJ+j9Vv7rZzDIDo7FSnP2zMJkwl2ILvtybcBwusZ49B
         188wj8UdlnXKmQIQABmn7VRF1mIiPAPr/gakgcqtxtN4i0JppJ7mOMZDp7NcZY0JHrXF
         SzqVdjO6BpekgAXljpuUbrJH3r6y98490+7QJ7dqLQu81OfODHYsn0QI3jwpIdvw6qyc
         uxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069806; x=1740674606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGKStiuvmu6PZ8iLcfPINnLEtELIaRoHYvov97O+LS8=;
        b=GdeUqfxt+ENqZH6v/NbNC49xvMowj+nRwOE3EwZUvsx/YJ3Olb9TBtBguGkMdER4JR
         QCGUEpqH06V3c/Pu4Pv1cyuzMlbL+4QWcMA+6sLHkv5ifK28qt8YcQSfaBerSjzV+JMA
         wGVimMbZWB32obGchImKWOqVw/o6hLPAKWPN2BNu10JGnVdnoWrAuAepBpPyMhQSRaqU
         YPyQe6xtBLi1vvpbFIWXmSBJ94RPtPh+G+DtMQzuM1W4jK4/W7U+KEtuBhonqipMC3n1
         WOX6fMVzz5nb9Lyu2Ymbe8Nk3lV3uMJ4U9lkB0XGza22wb+zRY6/NKBoD+er/+OsojCS
         nWbA==
X-Forwarded-Encrypted: i=1; AJvYcCVAoq8ohybFccddFxRNqwdFzBZH5yQduaLH/hSIy9bvBCwbXjYuiByJ2NR2X3OAhQTGGz9vYQbJhPKNpVQAVTmcHqrNBntd@vger.kernel.org, AJvYcCVUnfWeWNvjLwSg0rpQ+LNqLqaeQET/WGHzZluvLNRT3zy58HVcrrDakopXlHM8WCKcyxRt/AXwBXG0@vger.kernel.org, AJvYcCVWPW3Kp75ZlCYM4vUc8tNBu0kq/mVA/VdIMo4XzLUTdOtdcHs3cF+ro/LTcdtDWc6hoiIBe9dLTTpz@vger.kernel.org, AJvYcCWxbZqBmWxHeZV1CgNzsfUbiZHqG6uSfcreonewHxdUWoLRQBo+mpmZYI3B5+10q16VmeE08EPJrI1XcB+5@vger.kernel.org, AJvYcCX6bfJmksfn/IubZ47/ZxUCCWxL9WreeXl2oanaLxG4KQBG3Rr4cknZXkuc88RWg0v3VKtMcDYWmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8GIbYUMJsIBBIKFXyhTPErtihLU4mjmnjEMaaqscL0ym/hbG
	Ya6VKAWMBlz1xaCEutoH2lHQJxxVVUXXs8njWxwv5Ey7qcYnBC09vmR3Sv0Asvr3CliuNEoB5qw
	9gmwcAykLUtlzJpJs4HyxXa7GwaE=
X-Gm-Gg: ASbGnctRQmWH2lAwzmYgrYZYOqY/ab1PgpM0aU1HpFfXt5ZVqM1oF2aWTq2GZXvXnWk
	h5YCEQ9lgHCsnxdKnam6ufKHo3vnm72U0Nstqm4ThyMa+T3tKGMfWrnVZJRZhuVNJ+yxImvWb
X-Google-Smtp-Source: AGHT+IGbA2Q+XEnVZAQ4NEP7BEgN3IdARfcH5GHq6FTupNzUVVzv1CrxmhQmgth2w7JIYa+zxno9NRI2IlvxRC+uy/8=
X-Received: by 2002:a17:90b:2d46:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-2fccc1287e9mr7457400a91.8.1740069806451; Thu, 20 Feb 2025
 08:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com> <20241023212158.18718-5-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-5-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 11:43:15 -0500
X-Gm-Features: AWEUYZk5wAy-pDKUyIeTJwZ9O0NtnaTtHtgvwhFaZG6kHfsbWwV584YyTGAvgfs
Message-ID: <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Replace the (secctx,seclen) pointer pair with a single lsm_context
> pointer to allow return of the LSM identifier along with the context
> and context length. This allows security_release_secctx() to know how
> to release the context. Callers have been modified to use or save the
> returned data from the new structure.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/ceph/super.h               |  3 +--
>  fs/ceph/xattr.c               | 16 ++++++----------
>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      | 26 +++-----------------------
>  security/security.c           |  9 ++++-----
>  security/selinux/hooks.c      |  9 +++++----
>  8 files changed, 50 insertions(+), 70 deletions(-)
>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76776d716744..0b116ef3a752 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>         struct iattr *sattr, struct nfs4_label *label)
>  {
> +       struct lsm_context shim;
>         int err;
>
>         if (label =3D=3D NULL)
> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct =
dentry *dentry,
>         label->label =3D NULL;
>
>         err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> -                               &dentry->d_name, NULL,
> -                               (void **)&label->label, &label->len);
> -       if (err =3D=3D 0)
> -               return label;
> +                               &dentry->d_name, NULL, &shim);
> +       if (err)
> +               return NULL;
>
> -       return NULL;
> +       label->label =3D shim.context;
> +       label->len =3D shim.len;
> +       return label;
>  }
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -       struct lsm_context scaff; /* scaffolding */
> +       struct lsm_context shim;
>
>         if (label) {
> -               lsmcontext_init(&scaff, label->label, label->len, 0);
> -               security_release_secctx(&scaff);
> +               shim.context =3D label->label;
> +               shim.len =3D label->len;
> +               shim.id =3D LSM_ID_UNDEF;

Is there a patch that follows this one to fix this? Otherwise, setting
this to UNDEF causes SELinux to NOT free the context, which produces a
memory leak for every NFS inode security context. Reported by kmemleak
when running the selinux-testsuite NFS tests.

> +               security_release_secctx(&shim);
>         }
>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_l=
abel *label)

