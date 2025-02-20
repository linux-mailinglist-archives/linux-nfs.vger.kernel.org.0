Return-Path: <linux-nfs+bounces-10218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0385A3E2F2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0913AB8CF
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A021324F;
	Thu, 20 Feb 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gzl4uYnY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F0213248
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073259; cv=none; b=UhbHgDiKq53qBtxo8tc0fiurzy+VRW2rJLnTqfvdxBqzcXdZVC+yga5mQw5XmjsKXPPde/8e2z4GIoiinanOZAOYAJveVLgl/RiYV7zbodnyNJRUXdOvPVBflXe4qoJP7+m1uGfNOO8wV4uhRQZE675T0hL3Xz2BKx00/buoCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073259; c=relaxed/simple;
	bh=8rPnFaNq1SfJ7jVpZvL0HRIukQfDe+00TekDIZglHqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTqYQQS+dBO1889erAHuKnVvNq0emX1vijNPLLaeWFLMj/FsC04xWHHVAaGnJnTptERqbUV8Fy/GYsr9MqOK4r2g4pNyvJEJDLuzHybyEgVB8Zay8B6xT6thVNtKYum4ByxRecfFBepRWNsloEHrK1Pe5REKHikvsDrZ23iv8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gzl4uYnY; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so983652276.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740073257; x=1740678057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu7DO/yBBwA/XGaFJzr9sCM18a7jAEeqhWVP0InQkzI=;
        b=Gzl4uYnY65hl2BR5i6mgM3CNtkSXWslno2D8Dnpl+u8ocKicHeVFJwa7ZZtC4wMFH8
         gmtg2x/k9zMLSV0SDP11z8Vq/O5eDfxb2JcdNr9OeFUJHY6SaRyIDQYslyFujIQlSUpW
         B0co0t6aeKkBZrI/KxZEhi830groy6lXNgCMQLi09gqASilQ6Db+Hef2YEh4Ik14nLM5
         k0laCRFdlOpu3swydEUVYl9oYAwsXHdVzFhb9IZpu1kgLFjEiYHzh2eMgNY3VvAZMYJ6
         7Tx+rCj+FnzkJV6XIwzPtKoudM8Ji38ghEA5u96gxg0kUn+rOzYbdyvAwbZP8gMK4nDC
         U6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073257; x=1740678057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu7DO/yBBwA/XGaFJzr9sCM18a7jAEeqhWVP0InQkzI=;
        b=KuMKeTsd+Lb58k0Zll2xsZiz7cMdLSL3BAG1CXZdm/Y4LEgvFhkY5GgEmT8suuMoZG
         IsHsMsOhPHsmuYxObJyj8Dklml8bRB9wjIf90qNGu5m+h2BNugXOpPhQbq+tKjUpwEYH
         WVoUgkoo90pFJD93CCnyzm0IWaqaje3xZRHbBlS79mvdkXoOq6I8hppBpCUZXmQfJd6R
         TTBQzMWor7PCwhwMEHGEUIk0ECxZhwXJE4zONCszt0ff5hljjnDK9mJD7YxclqXhjJ/w
         ttXWhsMEmJ1JHbRpxOd5a0s2/ZLsp5WAyfYR20G21xKO4ulZfwUOy4Vk+gxjqALXPpzd
         /ujw==
X-Forwarded-Encrypted: i=1; AJvYcCUhpBAYyC8IPMPOuFphGs1SyC9iDxmS/VC1SS0Yb4WIcrlTaSq6kWmxQvrMLSEsXLdsR3tFvlwX4co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAo3iCKcBYAEdAxRV/G1PzjDJgHupLlrrX3qAHHw8hyTK7F6u
	WtTQ7ozkEI+7s8xCcHi0Qp0CYyGRL1a088z+9NtuGp2lkK+x9u1YnF5lOm/ea++jkxbhL6N7mVh
	oR/ouxmLuCkN8m+Qpk3JtjvR7ozXV3ezrINxX
X-Gm-Gg: ASbGncvSlm+qzHSqqQQRyqyZHas9YChk512U2kGgLgWavZGML6JNH6l+3ZdVgWGziMl
	2QVHpwDqUyMkI39JVN6n3FPIzyeZx8BoossRod+nlwOgpiljNDV88Rk+rjHWRxOgCpRbyt0J4
X-Google-Smtp-Source: AGHT+IGOC3n697KQWN6744ppAX2UiJaNpyU2qsRLzjIySb2kBI0edUGzQLUx4OZtKin2ejcQnHHBTTRTr9VNGFYZed0=
X-Received: by 2002:a05:690c:6283:b0:6f9:a75f:f220 with SMTP id
 00721157ae682-6fb58361e38mr219054337b3.25.1740073256563; Thu, 20 Feb 2025
 09:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 12:40:45 -0500
X-Gm-Features: AWEUYZkFZy4bmFlQEibuzns5VOKgC88N9W9hwaf8Sszpl0Su5qJth6e0K_A3KCU
Message-ID: <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Replace the (secctx,seclen) pointer pair with a single lsm_context
> > pointer to allow return of the LSM identifier along with the context
> > and context length. This allows security_release_secctx() to know how
> > to release the context. Callers have been modified to use or save the
> > returned data from the new structure.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: ceph-devel@vger.kernel.org
> > Cc: linux-nfs@vger.kernel.org
> > ---
> >  fs/ceph/super.h               |  3 +--
> >  fs/ceph/xattr.c               | 16 ++++++----------
> >  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
> >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> >  include/linux/lsm_hook_defs.h |  2 +-
> >  include/linux/security.h      | 26 +++-----------------------
> >  security/security.c           |  9 ++++-----
> >  security/selinux/hooks.c      |  9 +++++----
> >  8 files changed, 50 insertions(+), 70 deletions(-)
> >
>
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 76776d716744..0b116ef3a752 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> >  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> >         struct iattr *sattr, struct nfs4_label *label)
> >  {
> > +       struct lsm_context shim;
> >         int err;
> >
> >         if (label =3D=3D NULL)
> > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struc=
t dentry *dentry,
> >         label->label =3D NULL;
> >
> >         err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> > -                               &dentry->d_name, NULL,
> > -                               (void **)&label->label, &label->len);
> > -       if (err =3D=3D 0)
> > -               return label;
> > +                               &dentry->d_name, NULL, &shim);
> > +       if (err)
> > +               return NULL;
> >
> > -       return NULL;
> > +       label->label =3D shim.context;
> > +       label->len =3D shim.len;
> > +       return label;
> >  }
> >  static inline void
> >  nfs4_label_release_security(struct nfs4_label *label)
> >  {
> > -       struct lsm_context scaff; /* scaffolding */
> > +       struct lsm_context shim;
> >
> >         if (label) {
> > -               lsmcontext_init(&scaff, label->label, label->len, 0);
> > -               security_release_secctx(&scaff);
> > +               shim.context =3D label->label;
> > +               shim.len =3D label->len;
> > +               shim.id =3D LSM_ID_UNDEF;
>
> Is there a patch that follows this one to fix this? Otherwise, setting
> this to UNDEF causes SELinux to NOT free the context, which produces a
> memory leak for every NFS inode security context. Reported by kmemleak
> when running the selinux-testsuite NFS tests.

I don't recall seeing anything related to this, but patches are
definitely welcome.

--=20
paul-moore.com

