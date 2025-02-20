Return-Path: <linux-nfs+bounces-10223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D3A3E3A8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DE03BE82F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA52213E91;
	Thu, 20 Feb 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLlBPD+D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94620212D83;
	Thu, 20 Feb 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075430; cv=none; b=f60syAFJHZ6TABxOFMiBDLOICYf/jcj3UDUoVQayKctfEPnSkNmWjKxedn30tBmLkaGpFz0ys0+6pe8bBOSXZxK3h+CwqOxLXOqdliEE16icZtihev8BF3k8jG9dVd+vloaVbd/CGXTjp48TIF2/EIL6JUgayZ02m4qYyRqej4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075430; c=relaxed/simple;
	bh=sZCL2zwFfS4aq5nJt0eRPJ+sxJ/IPYsLUz90jub2+ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAVkQTzapID9eZAilLpYCI38xfXEHP+rc+j3lq4vrWKZc+JdmSWV0HGxkJzmokidfJbOf3/WX8Tr8AWBIaPWL4C0j7IMyp6dS22v7BwfC/12JJlq4cRB06T7F98nuK80zQrv4Xo8eWLXTzaw8LUz/X0E5s9kbdQYMcZHE055tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLlBPD+D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so2580221a91.2;
        Thu, 20 Feb 2025 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740075428; x=1740680228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfKM7knmqUYwX1VVpA/8zOe2wX6fSaSheqqMSE2TwXg=;
        b=gLlBPD+D1XKDsykJEfgzIIm5pNlGD2JP/7g2WHt6dI6dfHPtGk98Ld31HhzNcaCscc
         gIb5Tbgz2tuh+meAfPbLvgV/oRxPEEnPZgp+KKQ2rl+azCuPwglcT7bQy0oIX2BSd+7i
         Rj0PbT/dDFeOFXrgzwYovaoV+dLRJ5/0iZUIWdkbfUpRtJzYPjqoxay/6M82Dj115q/W
         OPSFNFhu1Jqqzs45ZcMBLmp8RzG+ZRgW97EecP7StKlLBG7FlvUgEFyTWtioiMzP6HO2
         TkX/kbRMArz7R+agHhBm4UTO9IKugYDxyBnVqjFsi+3vl8qbrkR1MuwoVoAYQSn/NC+q
         0Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075428; x=1740680228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfKM7knmqUYwX1VVpA/8zOe2wX6fSaSheqqMSE2TwXg=;
        b=E3P2VmP6Y/2+Kak0z71MyqwwsJz4eSI7n++2pRY6dNxO8OKRZU0YzTxHdbuKZ836Zv
         5+tT9Ui2/uPiOTxv1TeOmVkTkK+W72fIlou8XN1707rjWBHyyvmIOdzNaq4ohLeJp33q
         6S18b9X6BFg+XI29oMAst2pJBQKWKA+ud2jlek1FQ88tR1uWmrHfYNX49Zsytoe2cxKp
         O4xEpzqN8w92aWouRn+tam+BlPrZmskmk8wbQ971c28rnH4tEd1tcZ0NUP7zC2ylLY38
         9k4f8KjARo8Zxsgz3jBIviqx1GU521Tj9LJ33BFc1dWfGUFQyAJqZAtIYzGpyhviQ6HW
         H63g==
X-Forwarded-Encrypted: i=1; AJvYcCUotte0ZbIb404cjNY1YgpjNDBKiLtyWNxOaR1kSB/NqOUsJqUSmoeJfTPpoPwc+/Wz8OnzTRhdmmaBjoSwWiWgO9NS2+l9@vger.kernel.org, AJvYcCWHLNLFHDaIJyhqHdU4sm4kDBowT62erAkGwaEf+TZ9tiponJHMnvBLXdHZmlvTGHawgw2SRhS/J1rn@vger.kernel.org, AJvYcCWaRBIpmSMQ53MdCWcqUfsaPC7VMpi383p4yp4nVbGa9LHbrEcvbrzWXt5uivWUnyofiRHO5AKMuyAd@vger.kernel.org, AJvYcCWfCSEVvNIxk8XaKYVbm0idtQvEHS+1Ul+yVzUUd0Evggndrvu7F1VQzZXeCIITq0t8ZTYXa8IdRy9zZEfY@vger.kernel.org, AJvYcCXSTQHN2Tk765Ddnd7rw8TSuRN8ZPbpD6O524AHR7jmxL1tz6Uvi+/eWDOmX8IG/XDT+U0GtLFnPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhVf47evqsM68Flnt17TKqY23ipusgkrCc6yiKWd3eHUNDdD6
	m1LVgftFEFrRyefIlp1tgAQfq5MRcPlc9LMvnKQsvgzQKP6NQYTVba6ZM6gWFPBQ5LMfSWoroqT
	iNGT6zyHK4kR3JUyMkufo7B0Nzgg=
X-Gm-Gg: ASbGnctqXIaT/xXxQizMan1I0NKDuWKP0Ofx/3jOgl2s7tTcNs4ZF3hsNWuZ7Dc+C7d
	zvvdx5oYrZqrcfxhiHDxF8WcaOtmlaKaKjY6klWQy5K2ykPCOW7enSp66anyb/tyAuQ9AGTWI
X-Google-Smtp-Source: AGHT+IGj9VB2ugiuMyRTetTsloYZOD9SaPCz/FGasu17xbz3oWMT6BlhGTojeMWDJAXzbJ042WqxmktzLW10JRvejNQ=
X-Received: by 2002:a17:90b:3c0e:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fce78a3843mr281697a91.12.1740075427751; Thu, 20 Feb 2025
 10:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com> <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 13:16:56 -0500
X-Gm-Features: AWEUYZl165kFk3KdZeVeMNhXtyQfevbuVPAQdDZnGvEKBh7fxgHjXXmN4CQQy2Q
Message-ID: <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 12:54=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@scha=
ufler-ca.com> wrote:
> > > > >
> > > > > Replace the (secctx,seclen) pointer pair with a single lsm_contex=
t
> > > > > pointer to allow return of the LSM identifier along with the cont=
ext
> > > > > and context length. This allows security_release_secctx() to know=
 how
> > > > > to release the context. Callers have been modified to use or save=
 the
> > > > > returned data from the new structure.
> > > > >
> > > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Cc: ceph-devel@vger.kernel.org
> > > > > Cc: linux-nfs@vger.kernel.org
> > > > > ---
> > > > >  fs/ceph/super.h               |  3 +--
> > > > >  fs/ceph/xattr.c               | 16 ++++++----------
> > > > >  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------=
------
> > > > >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> > > > >  include/linux/lsm_hook_defs.h |  2 +-
> > > > >  include/linux/security.h      | 26 +++-----------------------
> > > > >  security/security.c           |  9 ++++-----
> > > > >  security/selinux/hooks.c      |  9 +++++----
> > > > >  8 files changed, 50 insertions(+), 70 deletions(-)
> > > > >
> > > >
> > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > index 76776d716744..0b116ef3a752 100644
> > > > > --- a/fs/nfs/nfs4proc.c
> > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> > > > >  nfs4_label_init_security(struct inode *dir, struct dentry *dentr=
y,
> > > > >         struct iattr *sattr, struct nfs4_label *label)
> > > > >  {
> > > > > +       struct lsm_context shim;
> > > > >         int err;
> > > > >
> > > > >         if (label =3D=3D NULL)
> > > > > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir,=
 struct dentry *dentry,
> > > > >         label->label =3D NULL;
> > > > >
> > > > >         err =3D security_dentry_init_security(dentry, sattr->ia_m=
ode,
> > > > > -                               &dentry->d_name, NULL,
> > > > > -                               (void **)&label->label, &label->l=
en);
> > > > > -       if (err =3D=3D 0)
> > > > > -               return label;
> > > > > +                               &dentry->d_name, NULL, &shim);
> > > > > +       if (err)
> > > > > +               return NULL;
> > > > >
> > > > > -       return NULL;
> > > > > +       label->label =3D shim.context;
> > > > > +       label->len =3D shim.len;
> > > > > +       return label;
> > > > >  }
> > > > >  static inline void
> > > > >  nfs4_label_release_security(struct nfs4_label *label)
> > > > >  {
> > > > > -       struct lsm_context scaff; /* scaffolding */
> > > > > +       struct lsm_context shim;
> > > > >
> > > > >         if (label) {
> > > > > -               lsmcontext_init(&scaff, label->label, label->len,=
 0);
> > > > > -               security_release_secctx(&scaff);
> > > > > +               shim.context =3D label->label;
> > > > > +               shim.len =3D label->len;
> > > > > +               shim.id =3D LSM_ID_UNDEF;
> > > >
> > > > Is there a patch that follows this one to fix this? Otherwise, sett=
ing
> > > > this to UNDEF causes SELinux to NOT free the context, which produce=
s a
> > > > memory leak for every NFS inode security context. Reported by kmeml=
eak
> > > > when running the selinux-testsuite NFS tests.
> > >
> > > I don't recall seeing anything related to this, but patches are
> > > definitely welcome.
> >
> > Looking at this quickly, this is an interesting problem as I don't
> > believe we have enough context in nfs4_label_release_security() to
> > correctly set the shim.id value.  If there is a positive, it is that
> > lsm_context is really still just a string wrapped up with some
> > metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
> > be okay-ish, at least for the foreseeable future.
> >
> > I can think of two ways to fix this, but I'd love to hear other ideas t=
oo.
> >
> > 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
> > and skip any individual LSM processing.
> >
> > 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
> > process the ANY case as well as their own.
> >
> > I'm not finding either option very exciting, but option #2 looks
> > particularly ugly, so I think I'd prefer to see someone draft a patch
> > for option #1 assuming nothing better is presented.
>
> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
> the shim.id obtained in nfs4_label_init_security(), and use it in
> nfs4_label_release_security(). Not sure why that wasn't done in the
> first place.

Something like this (not tested yet). If this looks sane, will submit
separately.

commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
did not preserve the lsm id for subsequent release calls, which results
in a memory leak. Fix it by saving the lsm id in the nfs4_label and
providing it on the subsequent release call.

Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/nfs/nfs4proc.c    | 7 ++++---
 include/linux/nfs4.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..c0caaec7bd20 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct
dentry *dentry,
  if (err)
  return NULL;

+ label->lsmid =3D shim.id;
  label->label =3D shim.context;
  label->len =3D shim.len;
  return label;
@@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
  if (label) {
  shim.context =3D label->label;
  shim.len =3D label->len;
- shim.id =3D LSM_ID_UNDEF;
+ shim.id =3D label->lsmid;
  security_release_secctx(&shim);
  }
 }
@@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode
*inode, void *buf,
  size_t buflen)
 {
  struct nfs_server *server =3D NFS_SERVER(inode);
- struct nfs4_label label =3D {0, 0, buflen, buf};
+ struct nfs4_label label =3D {0, 0, 0, buflen, buf};

  u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
  struct nfs_fattr fattr =3D {
@@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *i=
node,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t bufle=
n)
 {
- struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
+ struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
  struct nfs_fattr *fattr;
  int status;

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 71fbebfa43c7..9ac83ca88326 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -47,6 +47,7 @@ struct nfs4_acl {
 struct nfs4_label {
  uint32_t lfs;
  uint32_t pi;
+ u32 lsmid;
  u32 len;
  char *label;
 };
--=20
2.48.1

