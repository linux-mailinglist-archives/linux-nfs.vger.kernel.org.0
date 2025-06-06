Return-Path: <linux-nfs+bounces-12146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B2ACFC69
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 08:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6483517547B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF0433AC;
	Fri,  6 Jun 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB2Xq32D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542336D
	for <linux-nfs@vger.kernel.org>; Fri,  6 Jun 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190295; cv=none; b=sT/iWc5Oz/8SEfoK/dnajzY2Vm5UsD2bXAVac7Nbaw+JQor9F+xHsM+0VKz5CXySfJI1HfE9E6M8fU4d/4HDBy5TircZpqdduoFVtEYYyzza/4YzLuxHMZZCPg9/gWYrn7x2/cIO56rYFgh7m43TQz5pws4gA0TS5bDZMGk4i8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190295; c=relaxed/simple;
	bh=OaQucuElph5L/GEE/dIoaOVgGNwJ0acG+TCkiFekg3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pKhuq+qm9GHtcRnOBAz4Vwb/cJLSBT2UL5j82Yv5M5DweHr6npSljuXntf1vi2Am/lXNe0qnCuM0qr+3VjLmx8Ob1dzZ7W/0bpgM6kaYReiSvf3Wu7KHMEOqI6TWmQLwohk3IkytYGWEmByZS4PNqGbF8DAmWJ+Xn0cFW9mXONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB2Xq32D; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e993f49aso1538035a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749190293; x=1749795093; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNPH0m/THXjXoi3etRiOn9m9g57bBytN4g10RQH+1vA=;
        b=EB2Xq32DBE4zEClbCue7YJEBeagWBINR10N3N9ChPnN7QZQQMIFYd6eDqlGxwXnDnT
         Q8JmV63npfkquXV8Jdu81ZK1tsPmf2M8bysaMAmQEQl6OFsm+jU+X7t8HhPgtFx66KmF
         TT2j9+3OmM2dLBZJ5zYxyueDpjYPEMex3+q1uFEBgeqijG+dpyTEuUUnT64TANHSwkps
         /zZRuSMgrDAmkewzCobOaPeVtj7a3huqC/247o28xblo7ufBJJDFI5RB7W1JtIB8+ffw
         ifSDZ8C0XwZ6HjGG07sdm7jKx6uuFrlzbRWelsQcuCg1CTQz2YPiXVsQYSzxDhe7jWg3
         58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749190293; x=1749795093;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNPH0m/THXjXoi3etRiOn9m9g57bBytN4g10RQH+1vA=;
        b=NjdG+cCWAWyGTJQBBn15LDqw4dEXutWJUNl5LBdJGjqm3yTV9UW9snqUP1ySHA2Yr5
         onCsOtgsZK1S9T7ozbz3OMnN5dsoL5kX10wmGG9QZfLXit7ADkJh/Z8PAeIWEmIfIBgb
         nYw2nJPkML2p1PSFB3GtoRCBWAe6p+5EMMcX+Iyg1rrZ+hoWbVSCevuLtngrY401clkY
         R27mnUBSy+Td1SuWH3rjO49PBubkDRiLMrdj7zaMBHk+P+MJ8k6USzxX6c0OBTtUFi08
         ERQ/zYdSOqjYdDqf4rNFP4KCgj2dAl+f/MjDeNenfPo09OebZ9l75KqvGsGnSupRLUtk
         Fhaw==
X-Forwarded-Encrypted: i=1; AJvYcCUEHUw9zamOGZQuqF0JCVUkzvgGztXTNhIyY6vIzb6lF8apdqu1LaTcC7e4j4VKwAphNZgSqJi9/Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoj2Ck4KkiXLT3VrrQqQ3uT0Jhs+X9N+32+X96yOgTzSE4S+y6
	ZpHc5GW3lBI6AhbATZe5Mxo140OdmRZWsgJIsgB/ZYbdYoKPy+c4HE346pbXpRdh/Egb9pp2d82
	aQDgr9C408r14S1L3dw/H7B9xg9BN4XS7eA==
X-Gm-Gg: ASbGnct/fmPhhtF6nzUFvFo0Juun5KkxPEmpJ7pYpWWbHlQGVxLropYOnYVdwRp5Rbt
	mhF2e7YZ/uCn0bXiLNCUW0eXD6weTGXpmi3t7koacvTuN2TtFfRxOGvajQfFhooKyu1XAkxgeIZ
	oG5y17VVy5onPAKxrRSzu/ROhqb0xdsuxO1UZv3PYCGbs=
X-Google-Smtp-Source: AGHT+IHMCv49qveQ4vc6UWIvAOaJ0QZRoaFTdib6LnF8OFCnox5ZXetSfIX1yBjqsaxGr1jisRVOsiqDG4SXZH7TzKo=
X-Received: by 2002:a17:90b:1801:b0:312:e445:fdd9 with SMTP id
 98e67ed59e1d1-31346b20a9amr3659969a91.10.1749190293282; Thu, 05 Jun 2025
 23:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4csWq+Zu2hfdz0GcLk9pc0-JeP0EKZs=yOScJSx+v9ow@mail.gmail.com>
 <CAPJSo4XP132ParCDO6uNFZHyq+c_e1j0o2qxO9tQe4hqbWQw7w@mail.gmail.com>
 <CAM5tNy4EVhgmj1XHocMqbeKqJSWcUio7kppy+EKfp5ECnQ2R7g@mail.gmail.com>
 <CAM5tNy5ke7H+pMfsvQC-+kuRUokd0vsbPw_WOY-N6v=0t-pS5Q@mail.gmail.com>
 <CALXu0UdjF5s3Af72uo0A6503fZfGQ0kfxUs9yGoBh+v0oPz7pA@mail.gmail.com> <CAM5tNy5+X9f=xfr8T2Z+2OcOg6P7VGbSHbH0AeE1h5Xffugh6g@mail.gmail.com>
In-Reply-To: <CAM5tNy5+X9f=xfr8T2Z+2OcOg6P7VGbSHbH0AeE1h5Xffugh6g@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 6 Jun 2025 08:11:00 +0200
X-Gm-Features: AX0GCFvo5zNsZ07l3ixU-IGBDvD8vujrDjNKjI47sAmmYi-ck0N9S6n16bOUL0o
Message-ID: <CALXu0UdeQhppELxzG7NrW7D4wJ6SM-QQm=PROkV8Z6v+c6+E_Q@mail.gmail.com>
Subject: NFSv4/TLS support for newgrp(1) Re: [Ms-nfs41-client-devel]
 Implementing NFS over TLS
To: Rick Macklem <rick.macklem@gmail.com>, ms-nfs41-client-devel@lists.sourceforge.net, 
	libtirpc-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Jun 2025 at 22:21, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Wed, Jun 4, 2025 at 10:36=E2=80=AFAM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Mon, 2 Jun 2025 at 02:45, Rick Macklem <rick.macklem@gmail.com> wrot=
e:
> > >
> > > On Sun, Jun 1, 2025 at 3:53=E2=80=AFPM Rick Macklem <rick.macklem@gma=
il.com> wrote:
> > > >
> > > > On Wed, May 21, 2025 at 12:20=E2=80=AFAM Lionel Cons <lionelcons197=
2@gmail.com> wrote:
> > > > >
> > > > > On Wed, 21 May 2025 at 01:53, Rick Macklem <rick.macklem@gmail.co=
m> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > If the Google AI is correct, MS does not provide a full
> > > > > > TLS implementation in the kernel and their kTLS only
> > > > > > handles record level encryption/decryption, similar to
> > > > > > FreeBSD.
> > > > >
> > > > > Could you first look into adding TLS support to steved-libtirpc i=
n a
> > > > > generic fashion via openssl, please?
> > > > Ok, I finally got around to doing this. The tarball is attached and=
 it can
> > > > also be found at...
> > > > https://people.freebsd.org/~rmacklem/tirpc-tls.tar
> >
> > How are uid and - more important gid - information passed to the NFS/RP=
C server?
> Normally, no differently than it is now. Either krb5 or auth_sys.
> RPC-over-TLS encrypts
> the RPC header, but does not change it.
>
> There is a "special case" where a <user@domain> string is set in the othe=
rName
> component of subjectAltName. For that specific case, the NFS server gener=
ates
> credentials based on that user (uid+gid list for POSIX servers) and uses =
those,
> ignoring whatever is in the RPC header (presumably auth_sys with any old =
uid
> and gid list).
> --> This is entirely an option for an NFS server and really has
> nothing to do with
>      NFS-over-TLS except that it is embedded in the client's X.509
> cert. by whoever
>      created it. It is meant for laptops and similar that are only
> used by one user.

I see a problem here, because <user@domain> is not sufficient. Users
can have multiple primary groups, e.g. in case of /bin/newgrp, Windows
winsg and so on.

TLS must have a way to specify a primary group for POSIX newgrp(1) support.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

