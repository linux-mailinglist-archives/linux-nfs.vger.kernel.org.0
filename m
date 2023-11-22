Return-Path: <linux-nfs+bounces-33-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52BA7F53AE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BD1B20D78
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 22:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5D1D53A;
	Wed, 22 Nov 2023 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKVRWO7k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B71B9
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:47:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so415572a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693273; x=1701298073; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrBIHfC+5zBb9zzXQFkmIwWER0SS5u3tXBvXWaeWwjU=;
        b=DKVRWO7koXaLKP2wzZrUSIsv7qd6aPuXV7rC6alxDLZRHGPbkAL/O3CSrwSE4mFzlK
         vD74NwaP7HX4bGbSXb3ZlYHcuDB0xTi/3sHVWFz77s7OfcSc9gGGmcs7cSj2tsOXMzVP
         HjXKvfyjDnWjDjVd7qcr6kLkA/REUvSUNlzhVczlVI0WF4DT62HiOK0z/tccCHmkGFyU
         knwfTFw7iRLNRSxfkgzI0heQ63Qx7JGdIBz/pZQGyV+iG++UpxUt/YYBnC6dDknuhjr0
         cnMxZTNKIg9XWKRDFFcoIQdBjfZAfkFtaE23J6csKOGjDTYnGNRUHAQOnfCqHReHaXSH
         6uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693273; x=1701298073;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrBIHfC+5zBb9zzXQFkmIwWER0SS5u3tXBvXWaeWwjU=;
        b=EymrxMUwsWFo7AQOUWu3Lt8KRN9Q5soCpJ1d7Ue4ny+vzuiAbiUTMyXaxIH6gHe1H5
         rlR3hiYKC4e40s47N1dqbUWlMyxmcNKUSXDw6iJiI85VjTObWvgMxlD77pCOxuRJOz6p
         VUyhLtQnM118Bm5koYBfSJkdlsaphxXWEqJnKYTS8AaZhIAfaOfny59wAydis47dzChA
         1Bwn9klw6otfBdWLzeTzUQ3DE4oabimgS4dQooiBaaqa2gWyVb7z8LjRuSN67YaUWSRT
         m79UvSLfCBW4ToekosK0LUxA6PpT4uu8+cuBLUFr33WN47czqeKYZaExu7KGKdv6sSp8
         irGg==
X-Gm-Message-State: AOJu0YwvIXHPVkMOedI+Fmti9+voEGx0kLRasPcQg2nFA7PkfXZuXOYL
	KmZB3PnoidTzYINSec8kMDJ0G7g7ZlG4PkMYSqtxmFwr
X-Google-Smtp-Source: AGHT+IH086isblgiYfxpwihjpq3w2ho+ZUdxuMwwM+3aqGIpA5r+PuJZa6EqvRblhRFC9ZzPJOVF+ZfbdVqkNrClnwc=
X-Received: by 2002:aa7:c2d1:0:b0:540:3286:d2e8 with SMTP id
 m17-20020aa7c2d1000000b005403286d2e8mr2609913edp.18.1700693273430; Wed, 22
 Nov 2023 14:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
 <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com> <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com>
In-Reply-To: <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 22 Nov 2023 23:47:17 +0100
Message-ID: <CALXu0UevOCU0dm-0WUEZZFCV=V8jQxmy2OQYhtptVyVAZeWs3g@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Nov 2023 at 19:02, Anna Schumaker <schumaker.anna@gmail.com> wro=
te:
>
> On Sun, Nov 19, 2023 at 12:59=E2=80=AFPM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmail.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> > > <cedric.blancher@gmail.com> wrote:
> > > >
> > > > Good evening!
> > > >
> > > > How does READ_PLUS differ from READ? Has anyone made a simpler
> > > > presentation (PowerPoint slides) than the RFCs?
> > >
> > > No slides, but at a high level READ_PLUS can compress out long ranges
> > > of zeroes in a read reply by returning a HOLE segment instead of the
> > > actual zeroes. It's perfectly valid for the server to skip the zero
> > > detection and return everything as a data segment, however.
> >
> > So how do you differ between
> > 1. a hole, aka no filesystem blocks allocated
> > 2. a long sequence of valid data with all zero bytes in them
>
> That's up to the server! It could use something like fiemap or lseek
> with SEEK_HOLE or SEEK_DATA. It could also scan the data to see if
> there are any zeroes that could be compressed out.

How can the client figure out whether the data in a READ_PLUS reply
are zeros of data, or zeros from a hole?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

