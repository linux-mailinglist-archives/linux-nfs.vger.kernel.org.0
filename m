Return-Path: <linux-nfs+bounces-10283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8AA4016F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202053A9CE7
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B8253326;
	Fri, 21 Feb 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQSxg1V1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176E1EE028;
	Fri, 21 Feb 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171355; cv=none; b=bx5sIxWZav5/piICDF4CoNKxm56g3eddQUXGJ/UqRWd7uUKQrAWRL0XhNZH9MU2cQIf+gmnfj4PORkKw1YRvq2IKu4BTAl3CTz6EyYC0ut8NQDyrDjlDBSRoCK6+eTjHrQwLmEafDI2DTaHFP+6Tnvy5GpU6rE6c0SJwOWe1E3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171355; c=relaxed/simple;
	bh=37WpLW3oAzfgtH8aj+4lVOFw/YVOpIINjRGUzhY4sHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPEWITOcI+P4X+ZWdq4LmzSUvu71MoqOlWEh+cKighqw6zxQweQzsSxCqvMLa006t8YcWVAiZrqzTDMjKkoF05xO9tC99DKvbzxSspabLfZzNOShJwqzkvLp964p9H3mvU8K7EBsC9bkTl+T8ckR2XaZbHnCN2R8IBWq2Loumic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQSxg1V1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso5188353a91.0;
        Fri, 21 Feb 2025 12:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171353; x=1740776153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90i7bzYrYHAptL72LiQEPDIHG0tWzBixtnIqNxFuxWE=;
        b=dQSxg1V18cKv+18DQG6p5dWCk/zVzFUHJk9LkXHDRI/fFDt7Ij0GnXnN4oIX4Q8y8j
         KXfZ13v2rCPn/u9MZmYPhKEU7OjvUifL936tnAY9omxT3novv01dX1xo7RmQtrGB9spx
         q+42BoE/PNFrAGabDwJgyUC59aschjYGiy+KrV1s1gBMzUtdBpkiphZtHolwa/1UaUr3
         xo9I6ZRpT5RUpamAQ6edBfwNKd5KXHa59hdyisOWRmNri2CIm2rPokQCvmBwnkIfNu93
         aNxptnV/dPMcGgXfq2nZGM2ce9nX0rHoThNvkd/P+13C3YaHW5XyHTpsxMlv4hkRv+az
         dKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171353; x=1740776153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90i7bzYrYHAptL72LiQEPDIHG0tWzBixtnIqNxFuxWE=;
        b=gQHVI9NuM+G9jdQWzc1M2v6GSQV7UMFR1RPwZdN1ITanN205oyT0X75XB0nPYd0uHa
         rjoUlf4zDrAsDORX754v8Jk+2QXjGk8oF0OrDuqkVvMsKjyNPT6HEZrshCU1r7UAIZaD
         fXVifLVONpLGxiwnBGx+Pp8bzyvknLXnF4B4Ko7fCGHzzdMxvQzsftBOPOxOsyQMcs0U
         3h9ii5aND4C3hHXLd/zQkjJ3jN6/0eEIjWM/dak9KxTzm5pTdgGPejLJlUeLhbyoXzIX
         AlHwkIwwbech3QDa7865j3Kqic5LQvLx3suwXTCSPt4jLf8KERTMFquXgMs+yYVFKuIe
         4iXg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ENalwmiAHMPGXnEGIU2PPN2r+cTvHE7l5T7FVl9IJKGMaX37haImve+MQTlNdcDHRXlTkyc3wWA=@vger.kernel.org, AJvYcCWsudrb/COLIrAxa/Y+7N5RQvNcVhokmf8Fwm2evs6VVMdppCkVXi1yojQCSJ1d5aA3yKqhTkUdDkAT/CBHxB1SeqAwkjqC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/tORraixr5hV5m7hQL2Gc8meKukQPY5qcL3Ig+H0DEQ8GhF3
	T7xzCdIMoRaoDH42oI4X1lKlp1xpmVJzRGvLsUNH61y5rmAJU4fjqGibd8IjCIrGuXUghkdQZX3
	Yu3SNlq79+A2E6+cJhjfB6XjNQIA=
X-Gm-Gg: ASbGncu7Ip5m574ru9HyQDiQva5/tTPN0KgEzEINKgzT8y2+3Nw9x9GhbbpF54uHmdq
	aKrRYXG/H9hEboQLLIkj6llOsebOugH2eBy0PWkQLxL0wlByt1tLh/yHbQp+1/SOy4VI8kT0otM
	eZonHltx4=
X-Google-Smtp-Source: AGHT+IGNIlRlpRHWNL8F9GOOYjAkfMxbXL8fbNAki6RBGtVYOc0rxXte51IyL/u0p7/yEV/282i8d2TqXRYOIVxho7k=
X-Received: by 2002:a17:90b:1b05:b0:2ea:9ccb:d1f4 with SMTP id
 98e67ed59e1d1-2fce85982bemr8375627a91.0.1740171353331; Fri, 21 Feb 2025
 12:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8.ref@schaufler-ca.com>
 <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com> <CAEjxPJ6SnFnp773P-OP9VDjgs-D7XOC9Ygfk_MexKs9UdX73dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6SnFnp773P-OP9VDjgs-D7XOC9Ygfk_MexKs9UdX73dw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 15:55:42 -0500
X-Gm-Features: AWEUYZmPGLqQfR_wMrabUL3s9rkuy1s1nurw4SnvBxnZQxesL2yyDsPvqB0ZVx4
Message-ID: <CAEjxPJ50YbWXB1DV65U-vFW-5mVkjwFjXQcEbULW3m3ZE3AM6g@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix NFS4 memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Feb 21, 2025 at 10:59=E2=80=AFAM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >
> > The NFS4 security label code does not support multiple labels, and
> > is intentionally unaware of which LSM is providing them. It is also
> > the case that currently only one LSM that use security contexts is
> > permitted to be active, as enforced by LSM_FLAG_EXCLUSIVE. Any LSM
> > that receives a release_secctx that is not explicitly designated as
> > for another LSM can safely carry out the release process. The NFS4
> > code identifies the lsm_context as LSM_ID_UNDEF, so allowing the
> > called LSM to perform the release is safe. Additional sophistication
> > will be required when context using LSMs are allowed to be used
> > together.
>
> Shrug. This seems less safe to me but I will give it a try with
> SELinux labeled NFS tests.

My kernel with this patch seems to be crashing during the NFS tests
but not 100% sure yet if it is your patch's fault or something else.

>
> >
> > Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  security/apparmor/secid.c | 2 +-
> >  security/selinux/hooks.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> > index 28caf66b9033..db484c214cda 100644
> > --- a/security/apparmor/secid.c
> > +++ b/security/apparmor/secid.c
> > @@ -108,7 +108,7 @@ int apparmor_secctx_to_secid(const char *secdata, u=
32 seclen, u32 *secid)
> >
> >  void apparmor_release_secctx(struct lsm_context *cp)
> >  {
> > -       if (cp->id =3D=3D LSM_ID_APPARMOR) {
> > +       if (cp->id =3D=3D LSM_ID_APPARMOR || cp->id =3D=3D LSM_ID_UNDEF=
) {
> >                 kfree(cp->context);
> >                 cp->context =3D NULL;
> >                 cp->id =3D LSM_ID_UNDEF;
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..b89d3438b3df 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6673,7 +6673,7 @@ static int selinux_secctx_to_secid(const char *se=
cdata, u32 seclen, u32 *secid)
> >
> >  static void selinux_release_secctx(struct lsm_context *cp)
> >  {
> > -       if (cp->id =3D=3D LSM_ID_SELINUX) {
> > +       if (cp->id =3D=3D LSM_ID_SELINUX || cp->id =3D=3D LSM_ID_UNDEF)=
 {
> >                 kfree(cp->context);
> >                 cp->context =3D NULL;
> >                 cp->id =3D LSM_ID_UNDEF;
> >

