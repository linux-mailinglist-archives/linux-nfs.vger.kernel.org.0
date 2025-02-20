Return-Path: <linux-nfs+bounces-10221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF9A3E33C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4494C19C02C8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A121422F;
	Thu, 20 Feb 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5QTlDAc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FC214200;
	Thu, 20 Feb 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074554; cv=none; b=igSk2Hrj4C0aJIcKNg1AAsXTaN1qwJNS6rv08zwuLUY9MtXd5ewq8ej5gbU5POVAwM4EsY3oEai/ufuMzjN0l3X+er/zHJ+3TcdSjeEtVW5fBuvm21hTq5g3y0kuziE8Jk4SXSDeoxLqS5JZzVjZlBUbsIdLk2B5YEsh/mYymfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074554; c=relaxed/simple;
	bh=sjA+Gwp0yNbESR83vg4NbHTTaupHHbCoCO+SX4bmW3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKG0Ltcke8ZXvnzKLk6BD792AALgRI/w5D+ciHR48EOuMxZWd2eKHnjE5qjEnGOwRuLemviXkBZ0JUF1+B6eJ/gFXr0OjtPdxBaoTeBUMfYVGIQEDdg64SIpXgrq1T6P93w2gjqXpxTXywZ+/01ozmG3dWVHJBmK9geFKG3Chmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5QTlDAc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d601886fso19561175ad.1;
        Thu, 20 Feb 2025 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074552; x=1740679352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTkJP8hwTQNaDUrNxz87FKDq9ZPgxyVT+1vWx2JFdJE=;
        b=l5QTlDAcpPDclPRjmrSh9Ds1e4BoFWpxVNivs3ZJGg/tIv608bafGGXrn0Ck1Wp6mr
         ogvEjiEQCPuxQScT6WH3CGPGpPbdNO7KkVqKSgTmUX0JkpWODYC6Rfg9EFeb0XGNb13M
         HBpaNSB6rPpVD4kkLVoawO5SxFTIyIxf5Pr7WlB8o4nxqr7gJA12ANgaVR+qg7nO+HlB
         OzSkTv78gzKam8ELIW1Ub11dklrCGr+GWXFhKzqS+9lgOP88sfUoI8LUVyOfEPL25Lyh
         xIl9J2cund2AqpN1y4v8zUmzj31P+kIDiaHBfMXxiM3x29HXt/HRxzb1vTF2N9HtfU7b
         dWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074552; x=1740679352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTkJP8hwTQNaDUrNxz87FKDq9ZPgxyVT+1vWx2JFdJE=;
        b=rmewKMigWjJZs/xImIcUHGD7C8YLhGfvpFoMOvrfnXHcnmVDUk7RFaz5PLQQZ8j6GI
         tJjnWk9iEqitGeUigUormGv74RETmx/72+mrz/5j5B6CloJL6bVJSuOrxG8ORGq9WT86
         pNqXw1myzOq+XPrco32MMmhPgYrW4e69pm/jy25KX5IqfyN7XClCDCqD31vtyTqgoNZe
         efW2eDo/lgIO6q7yaLxvhQ4WTlgp7/GiJgAEEYq8sF0PPI6udLqddLI8J8LuOqCQFHDu
         Oe1LUM9sWDW5t6+vAXXfFuKXGHFkEeXYOn5Uf0dRs086PcFsW8d4vWxI4dv2Bpc6jQOR
         m5zA==
X-Forwarded-Encrypted: i=1; AJvYcCU+WPSsLFXXSLUxEYEwQeevcEGOvdSOTOTSzKfmh8cF/lHXVqBhhGdtCu1HUCBlD9U6qM1NH2pWEQ==@vger.kernel.org, AJvYcCUOM3aLNlDnodPL3aL+haBhx8gtjstiDtezqwYMf1Qe1TjeaQS+8CKj9odI7pm0apdhBab6e/svU7f+TIMJ@vger.kernel.org, AJvYcCUUD4IKYG9rSDTzhhdb14AWQM8iy9Ta6pJMsvkNnaoLb1wfMT58TgKGwHBmzW1QpHZ1vdKyvArFm/QZ@vger.kernel.org, AJvYcCV9P3aL0i/B8bWQqf48uVVhuS+UTSZmiak7ZJOpaNoiDZhUly8cvz0rwpRS/BP/Sq9nkBVtVeTRGto3@vger.kernel.org, AJvYcCVLRJEBwZf8g1+1C5zQtBC/XpEPgrk6uxLrL1qjl0CKXU0fmcUSoqCN/A0ptqZfvIxIHK1eIT3Dll7jRbylCOHdvULqM4qt@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2mkAC9Rp07Fsdw2krfshSD/0yqa6UCwXIaZE0NEntT4gvVlT
	WTSzDbo2B0Qy6WHAwBhwbHhmkevW2yB07RZROQhOcvHn1WreDHHJ0CS4CVb/os+9K8wAx34eLU4
	negt2oZkiBZ6QhjR97kNOlvow81k=
X-Gm-Gg: ASbGncvQqPN+bbzJFgujfqjET/O6tIaCP0d/TnVLd2vWuQe1oWX199lccbdShYtiKyy
	btLFpj17vdwBx4ZIJgPSVIkOK8tGfEutaH/Yti9vx3Vrovgx4G1vgAHyItQ6bDcQEMU9tsQ9Q
X-Google-Smtp-Source: AGHT+IEFczkpeDRERavovv+C8uTMueSNRf40B/mWOw+xTNzXO42DxBetSINerIzLryfpwIZ5/3lWOAhgP7wsC32ek7s=
X-Received: by 2002:a17:90b:2b8e:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2fce78da5d0mr160553a91.18.1740074552430; Thu, 20 Feb 2025
 10:02:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com> <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
In-Reply-To: <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 13:02:21 -0500
X-Gm-Features: AWEUYZkuoKig3o_LnSnZuGYTvTveat9tDyNzdhG4qqFWmE8c6kSUS-TYzcquvws
Message-ID: <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> > > >
> > > > Replace the (secctx,seclen) pointer pair with a single lsm_context
> > > > pointer to allow return of the LSM identifier along with the contex=
t
> > > > and context length. This allows security_release_secctx() to know h=
ow
> > > > to release the context. Callers have been modified to use or save t=
he
> > > > returned data from the new structure.
> > > >
> > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Cc: linux-nfs@vger.kernel.org
> > > > ---
> > > >  fs/ceph/super.h               |  3 +--
> > > >  fs/ceph/xattr.c               | 16 ++++++----------
> > > >  fs/fuse/dir.c                 | 35 ++++++++++++++++++-------------=
----
> > > >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> > > >  include/linux/lsm_hook_defs.h |  2 +-
> > > >  include/linux/security.h      | 26 +++-----------------------
> > > >  security/security.c           |  9 ++++-----
> > > >  security/selinux/hooks.c      |  9 +++++----
> > > >  8 files changed, 50 insertions(+), 70 deletions(-)
> > > >
> > >
> > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > index 76776d716744..0b116ef3a752 100644
> > > > --- a/fs/nfs/nfs4proc.c
> > > > +++ b/fs/nfs/nfs4proc.c
> > > > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> > > >  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> > > >         struct iattr *sattr, struct nfs4_label *label)
> > > >  {
> > > > +       struct lsm_context shim;
> > > >         int err;
> > > >
> > > >         if (label =3D=3D NULL)
> > > > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, s=
truct dentry *dentry,
> > > >         label->label =3D NULL;
> > > >
> > > >         err =3D security_dentry_init_security(dentry, sattr->ia_mod=
e,
> > > > -                               &dentry->d_name, NULL,
> > > > -                               (void **)&label->label, &label->len=
);
> > > > -       if (err =3D=3D 0)
> > > > -               return label;
> > > > +                               &dentry->d_name, NULL, &shim);
> > > > +       if (err)
> > > > +               return NULL;
> > > >
> > > > -       return NULL;
> > > > +       label->label =3D shim.context;
> > > > +       label->len =3D shim.len;
> > > > +       return label;
> > > >  }
> > > >  static inline void
> > > >  nfs4_label_release_security(struct nfs4_label *label)
> > > >  {
> > > > -       struct lsm_context scaff; /* scaffolding */
> > > > +       struct lsm_context shim;
> > > >
> > > >         if (label) {
> > > > -               lsmcontext_init(&scaff, label->label, label->len, 0=
);
> > > > -               security_release_secctx(&scaff);
> > > > +               shim.context =3D label->label;
> > > > +               shim.len =3D label->len;
> > > > +               shim.id =3D LSM_ID_UNDEF;
> > >
> > > Is there a patch that follows this one to fix this? Otherwise, settin=
g
> > > this to UNDEF causes SELinux to NOT free the context, which produces =
a
> > > memory leak for every NFS inode security context. Reported by kmemlea=
k
> > > when running the selinux-testsuite NFS tests.
> >
> > I don't recall seeing anything related to this, but patches are
> > definitely welcome.
>
> Looking at this quickly, this is an interesting problem as I don't
> believe we have enough context in nfs4_label_release_security() to
> correctly set the shim.id value.  If there is a positive, it is that
> lsm_context is really still just a string wrapped up with some
> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
> be okay-ish, at least for the foreseeable future.
>
> I can think of two ways to fix this, but I'd love to hear other ideas too=
.
>
> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
> and skip any individual LSM processing.
>
> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
> process the ANY case as well as their own.
>
> I'm not finding either option very exciting, but option #2 looks
> particularly ugly, so I think I'd prefer to see someone draft a patch
> for option #1 assuming nothing better is presented.

We could perhaps add a u32 lsmid to struct nfs4_label, save it from
the shim.id obtained in nfs4_label_init_security(), and use it in
nfs4_label_release_security(). Not sure why that wasn't done in the
first place.

