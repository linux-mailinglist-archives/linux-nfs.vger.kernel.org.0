Return-Path: <linux-nfs+bounces-10234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D2A3E5DF
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 21:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FF54205F5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE912641CD;
	Thu, 20 Feb 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPLwX4Hg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F21E9B2C;
	Thu, 20 Feb 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083610; cv=none; b=jOP9UGAId0Tp6ItkBmxUuwSejvx8HltueBfpZFvr/02c3el3X2Jyq5rGjdGp0LSTVxHNXHhTNUUzy9HkePdquKGJvV1yOExqrEidAJKEa1g6LBHi/xa2KZ6qdSfG7TW+fnoXWRSa5oQ6gvlDY7Za0r4cumJSa6M5hz9id5vswEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083610; c=relaxed/simple;
	bh=JUU5G6sdSznWTP4poak7ba6rGEpBqcIOj8w8auBF1Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyLpEzYmTSykf7Fh5tEEsE7Las0zYH628UDF0zQTgJFYb9/zwsfOYmjP3XVHmLBZcxuy5bhUnTl+Ii+CyYb9PfXMD6IBdcJ7jpqac0BFGOkD6acm3MIAJV+oIwOvN0UcVWl4C5dFF4ucsxFkjqXre8Ca6/UUeiUjeIQa6xbEkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPLwX4Hg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso2130623a91.1;
        Thu, 20 Feb 2025 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083608; x=1740688408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V86iYXn2WMaj2Yi1DCVOtha2FQ5bzEejGFlHAU1IdxY=;
        b=TPLwX4HgSAZrS30S2v1mVSFHK7/p4UxPjOfVESNAEx2GOcgiJIF9DeYx73imIFxH6M
         n/fe5xdEXq35mnMCUCILK4A4X0femWasojrlPsiOkJz9iz0CGwT7nzTKb8J7UrtgUJRX
         OIs2gFfmpIYr6OLEnLjg5vvnt39VD+SiW7cfhKo8tQ01/ld7JzUv5DsTHGhkQHPPEEAx
         +wOb3mS7qHz3Oj9Y/bHv3D69MSWtPrs1J1BugHTRBEQiUr2mfvYzJwAVfX5EbuWOwJK8
         SEkBpuoRqav7OLGHPYyLQYPf5QG3pbwEKlYoyUvxB9R37LNJH6xqX7r0c1i+mpF+g5wO
         DAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083608; x=1740688408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V86iYXn2WMaj2Yi1DCVOtha2FQ5bzEejGFlHAU1IdxY=;
        b=cEALoHo3K1zltj+EbcroLNIojf0KLni23hTLR28CpP+XwQ3A2vRgCsW+s7Qn1YHDXN
         jRrKgMvjpuYYqblVXIoGAlzwGGHLplq6zQ0bYc9C+KUZHeaNseW+9IVhLWP2tDD9IkCm
         Y3mb1uUGQiqWBcwrbDsofcQAE2l2YgXHiVlPgahykMjcewTwVM1xjx278Q6n1JmA8IZN
         KU1YpHeifk0p7vDGlFfLFWAWsw+fL6zCAbzoWV0TlFbwN+c6SG+0QIqK78K7uGhsvm0A
         PuH0s8kXkEDzELdnQam00eXJpZzOLmQabwMrNhMfjt7spN4eTFhoMHsbWg4gxIX/P0In
         c9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUOmLBA23YIyg5/zFtbTDv1WPbH59s6UZ0RBFDfa9WVQqdbiYk8KR9aL4/yFQryoBb0JjEDu4w2cw54wRbcEbQCgvVri99Y@vger.kernel.org, AJvYcCUiDNy9awWwLb1VEEFjkQerjKPqS4p/r30azuadWJ0vvRPBBnNEMPuW4AF0g28YaIVRFQYnM7dHoOj0YQiO@vger.kernel.org, AJvYcCV4DMB6whdMtAXhtXAtV5farVcBs+i+3zGM0WghG0+e61fPjwzsNI9fa/dL5kya/wrWise5soZJVaSI@vger.kernel.org, AJvYcCWIQdM7Ss55dGyiODDVguqDUL5NSN7VIIap0aUgjo7SmH7VJs+f3XM9/9JhfvNtdv5En1MTSG1jz2MS@vger.kernel.org, AJvYcCXZMUnYscfP+M0qmagroAc2xaomHGVD3MWuv1841SOlC4+Un0n4htzJ98yuLhkw9WGl7xt36FXT9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXHqle5AnA1pB5L3knTKRCA2GuYnngMk/okXK2e34HnGew6rG
	DKo7bA3/KnkHAjrFZI4j4CM7iR6kFd5Y/37ZtL36+Fq/ADrV4IdNCY3WxohRzN1tmaDI3zLzah6
	IrAZE2TiQc7fKYwfWaVaiSe6tQkk=
X-Gm-Gg: ASbGncuzSpHNlFL+ogQPtOBL3jG5TmhPCI0SeP+9JYOnFYfu8pwvcyN6shNejrf/pM2
	uxQnCvaVKlA5m3qbBtjKTuTlDM3NutiYO8E/nR0oDxnx0IZ+AC7EXGqMW36nFP63IxwZsGLMz
X-Google-Smtp-Source: AGHT+IHpvR31/HVJCtZcS7XYkfofHLWSJnENH8pYWOcwKjrI9FIN+Q/xmu1WS+s35ZD9NZUut48EJZmZ2qH9ldVUtNo=
X-Received: by 2002:a05:6a00:190b:b0:730:75b1:720a with SMTP id
 d2e1a72fcca58-73426d98ed2mr370154b3a.23.1740083607804; Thu, 20 Feb 2025
 12:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
 <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com> <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
 <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com>
In-Reply-To: <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 15:33:16 -0500
X-Gm-Features: AWEUYZm9cUSet6LM6iUid8EOSELH01fSnkwZSX8Q5dQbtUJj8tST52mZd_2Um6o
Message-ID: <CAEjxPJ7aXgOCP4+1Lbfe2b5fjB9Mu1n2h2juDY1RjPgP10PUxQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:31=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 2/20/2025 11:37 AM, Stephen Smalley wrote:
> > On Thu, Feb 20, 2025 at 2:33=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 2/20/2025 10:16 AM, Stephen Smalley wrote:
> >>> On Thu, Feb 20, 2025 at 1:02=E2=80=AFPM Stephen Smalley
> >>> <stephen.smalley.work@gmail.com> wrote:
> >>>> On Thu, Feb 20, 2025 at 12:54=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> >>>>> On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> >>>>>> On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> >>>>>> <stephen.smalley.work@gmail.com> wrote:
> >>>>>>> On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@sc=
haufler-ca.com> wrote:
> >>>>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_conte=
xt
> >>>>>>>> pointer to allow return of the LSM identifier along with the con=
text
> >>>>>>>> and context length. This allows security_release_secctx() to kno=
w how
> >>>>>>>> to release the context. Callers have been modified to use or sav=
e the
> >>>>>>>> returned data from the new structure.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>>>>> Cc: ceph-devel@vger.kernel.org
> >>>>>>>> Cc: linux-nfs@vger.kernel.org
> >>>>>>>> ---
> >>>>>>>>  fs/ceph/super.h               |  3 +--
> >>>>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
> >>>>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++----------=
-------
> >>>>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> >>>>>>>>  include/linux/lsm_hook_defs.h |  2 +-
> >>>>>>>>  include/linux/security.h      | 26 +++-----------------------
> >>>>>>>>  security/security.c           |  9 ++++-----
> >>>>>>>>  security/selinux/hooks.c      |  9 +++++----
> >>>>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>>>>>> index 76776d716744..0b116ef3a752 100644
> >>>>>>>> --- a/fs/nfs/nfs4proc.c
> >>>>>>>> +++ b/fs/nfs/nfs4proc.c
> >>>>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> >>>>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dent=
ry,
> >>>>>>>>         struct iattr *sattr, struct nfs4_label *label)
> >>>>>>>>  {
> >>>>>>>> +       struct lsm_context shim;
> >>>>>>>>         int err;
> >>>>>>>>
> >>>>>>>>         if (label =3D=3D NULL)
> >>>>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir=
, struct dentry *dentry,
> >>>>>>>>         label->label =3D NULL;
> >>>>>>>>
> >>>>>>>>         err =3D security_dentry_init_security(dentry, sattr->ia_=
mode,
> >>>>>>>> -                               &dentry->d_name, NULL,
> >>>>>>>> -                               (void **)&label->label, &label->=
len);
> >>>>>>>> -       if (err =3D=3D 0)
> >>>>>>>> -               return label;
> >>>>>>>> +                               &dentry->d_name, NULL, &shim);
> >>>>>>>> +       if (err)
> >>>>>>>> +               return NULL;
> >>>>>>>>
> >>>>>>>> -       return NULL;
> >>>>>>>> +       label->label =3D shim.context;
> >>>>>>>> +       label->len =3D shim.len;
> >>>>>>>> +       return label;
> >>>>>>>>  }
> >>>>>>>>  static inline void
> >>>>>>>>  nfs4_label_release_security(struct nfs4_label *label)
> >>>>>>>>  {
> >>>>>>>> -       struct lsm_context scaff; /* scaffolding */
> >>>>>>>> +       struct lsm_context shim;
> >>>>>>>>
> >>>>>>>>         if (label) {
> >>>>>>>> -               lsmcontext_init(&scaff, label->label, label->len=
, 0);
> >>>>>>>> -               security_release_secctx(&scaff);
> >>>>>>>> +               shim.context =3D label->label;
> >>>>>>>> +               shim.len =3D label->len;
> >>>>>>>> +               shim.id =3D LSM_ID_UNDEF;
> >>>>>>> Is there a patch that follows this one to fix this? Otherwise, se=
tting
> >>>>>>> this to UNDEF causes SELinux to NOT free the context, which produ=
ces a
> >>>>>>> memory leak for every NFS inode security context. Reported by kme=
mleak
> >>>>>>> when running the selinux-testsuite NFS tests.
> >>>>>> I don't recall seeing anything related to this, but patches are
> >>>>>> definitely welcome.
> >>>>> Looking at this quickly, this is an interesting problem as I don't
> >>>>> believe we have enough context in nfs4_label_release_security() to
> >>>>> correctly set the shim.id value.  If there is a positive, it is tha=
t
> >>>>> lsm_context is really still just a string wrapped up with some
> >>>>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going t=
o
> >>>>> be okay-ish, at least for the foreseeable future.
> >>>>>
> >>>>> I can think of two ways to fix this, but I'd love to hear other ide=
as too.
> >>>>>
> >>>>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx=
()
> >>>>> and skip any individual LSM processing.
> >>>>>
> >>>>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
> >>>>> process the ANY case as well as their own.
> >>>>>
> >>>>> I'm not finding either option very exciting, but option #2 looks
> >>>>> particularly ugly, so I think I'd prefer to see someone draft a pat=
ch
> >>>>> for option #1 assuming nothing better is presented.
> >>>> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
> >>>> the shim.id obtained in nfs4_label_init_security(), and use it in
> >>>> nfs4_label_release_security(). Not sure why that wasn't done in the
> >>>> first place.
> >>> Something like this (not tested yet). If this looks sane, will submit
> >>> separately.
> >>>
> >>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_securi=
ty")
> >>> did not preserve the lsm id for subsequent release calls, which resul=
ts
> >>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> >>> providing it on the subsequent release call.
> >>>
> >>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_securi=
ty")
> >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> I'm not a fan of adding secids into other subsystems, especially in ca=
ses
> >> where they've tried to avoid them in the past.
> >>
> >> The better solution, which I'm tracking down the patch for now, is for
> >> the individual LSMs to always do their release, and for security_relea=
se_secctx()
> >> to check the lsm_id and call the appropriate LSM specific hook. Until =
there
> >> are multiple LSMs with contexts, LSM_ID_UNDEF is as good as a match.
> >>
> >> Please don't use this patch.
> > It doesn't add a secid; it just saves the LSM id obtained from
> > lsm_context populated by the security_dentry_init_security() hook call
> > and passes it back in the lsm_context to the security_release_secctx()
> > call.
>
> Right. Sorry. If you're going to do that, the nfs_label struct should
> just include a lsm_context instead. But that hit opposition when proposed
> initially.
>
> The practical solution has to acknowledge that at this stage there can on=
ly
> be one LSM providing contexts, and each LSM can release the context if th=
e
> LSM is matches the LSM or is LSM_ID_UNDEF. That will change before SELinu=
x,
> AppArmor and Smack can co-exist, but that's not yet available. For now th=
e
> check
>
>         if (cp->id =3D=3D LSM_ID_SELINUX)
>
> can either be removed or changed to
>
>         if (cp->id =3D=3D LSM_ID_SELINUX || cp->id =3D=3D LSM_ID_UNDEF)
>
> In a system that respects LSM_FLAG_LEGACY_MAJOR the id isn't relevant
> with the context using LSMs all being thus identified.

Shrug. My patch seemed cleaner, but I don't really care as long as it
is fixed, preferably before 6.14 goes final.

