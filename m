Return-Path: <linux-nfs+bounces-3386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E88CF47B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 16:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1042812F0
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45659171C8;
	Sun, 26 May 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m77P/9g8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73A171B0
	for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716732777; cv=none; b=iT90HG2IvJNBKFIb9RuFkFgYReVnFpjjxmHXTMMiDVssqYdlvBjthoCbSsMmEvMtWOAJqaeW6N6i9hDWfXEhoOFJ7SEGUnTGFq8qpFQbZJa6cqlFczsgVTVyYePY7PGxEgCqjUT2gDA3OAb83alziHQthitqTyQ5+uD3CWPPZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716732777; c=relaxed/simple;
	bh=xnmgBAgGztGOmDd3FMFWXj/tx0xsv6p462+2LeR/il4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8JJYPrRGr+u5HTd1FqVq2h2/05gtjGyBQO5uFLh8Nagzotr2PcUg2i7O1vTBFeaHK1qVbQxwel8Wj9756GMqQMVHwz1ojsgoraiHzgw56K+cQx/2FH75Po3ZM3/VsOgRofqdPRWP/aLsB+jk188lOvoHpz7fIKZGj1CAq0OajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m77P/9g8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so2477926a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716732774; x=1717337574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnmgBAgGztGOmDd3FMFWXj/tx0xsv6p462+2LeR/il4=;
        b=m77P/9g8nr58XuouEMhyt/Cs6FOq5oDw2jjJcddehUVil+WX9PU9a78wPQEk0tyMAg
         BLmYmch82c1iQdgmK4ELDj2/y8NcBHamLZhQ3jmJuUwgV4jS6VfCaZzA9pFrI0ctkQK4
         yOONAnmdaLk9rGKtLN75VtvOm65u5o1jNlNTk6knw/Q9FUKuy8BVB/1VcIhyNdV+/bbN
         F529RrmxLdQCP+n4T7IQB30ZpI+8yjMTwjDD7UZxTfn42NgMJdW2kU1erMiK0Eext+D6
         mmoyifItOK49/9vSQcdSKvPaX4ugVlcpUkP3nDWvu9lSurUTTtm0qCjM1NauOkDtAvYT
         6C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716732774; x=1717337574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnmgBAgGztGOmDd3FMFWXj/tx0xsv6p462+2LeR/il4=;
        b=OIR8rj9AN1SlXJuGchhD6ZNd0LwIXW1z6TwIrXc4EPxNtsGdIbnDKDB1sgG39gV33E
         yYEbtTnAqyWf6H0kDuUKSGe5THIr4AivQdoRVk+YivgXKDyvWQHJTRdCOl6UTnWPKora
         Ves8lHnrVkhYjJvIVhgmrx28l6/vxJV5hz/2GhVO8RuWvxbjyyIQs9j0zYk5KvIFX0+0
         l8r8d60iMcXieb+9T5nWya3912C3NtK3ThlSDYV+NMDmgJizvfVsSDGfZkb69gZA1sxQ
         +XYOtkW576ww/VJeqwdZaRYn+UHEiyumvSXsCxysuFKZbX9AWAo/VJuhDU4m57Bb6uKw
         5NxA==
X-Gm-Message-State: AOJu0YzTgF8D7DOtOlH9316nx4Sp2fNE5yokjfLdYwhPWYUL3yCMn6qF
	5V7NpRr26dx7HX6TYUsu6Xi1P2c6lFPB5DQKh0SBb6fwTee5i+6HoggCkRBVvMpC8lxZydDwubh
	UbYVeDO660vtTpVeNBWa2URBWmM4SYg==
X-Google-Smtp-Source: AGHT+IHiCZkeOXknCyaGgBx39Btp4UJxTwQ2zxoJn/P6t5H1BUwdJLa6OWoVQKHLpifCQ/7kZ+RzNW6HPxHSeFxBEWg=
X-Received: by 2002:a17:907:b90:b0:a59:a3ef:21eb with SMTP id
 a640c23a62f3a-a62651123bfmr376317266b.73.1716732773573; Sun, 26 May 2024
 07:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com> <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
 <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
In-Reply-To: <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sun, 26 May 2024 16:12:42 +0200
Message-ID: <CANH4o6MHtYVFaciH=Xh-Ph3x_AXuiYNVmhU2akzYwbQ_MmFPcA@mail.gmail.com>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 1:28=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-05-24 at 19:11 +0200, Dan Shelton wrote:
> > On Wed, 15 May 2024 at 23:46, Steve Dickson <steved@redhat.com> wrote:
> > >
> > > Hey!
> > >
> > > On 5/14/24 5:57 PM, Dan Shelton wrote:
> > > > Hello!
> > > >
> > > > Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, whi=
ch
> > > > provide platform-independent paths where resources can be mounted
> > > > from, i.e. nfs://myhost//dir1/dir2
> > > >
> > > > Could Linux /sbin/mount.nfs4 support this too, please?
> > > Why? What does it bring to the table that the Linux client
> > > does already do via v4... with the except, of course, public
> > > filehandles, which is something I'm pretty sure the Linux
> > > client will not support.
> >
> > This is NOT for Linux only. Every OS has its own system to describe
> > shares, and not all are compatible. URLs are portable.
> >
> > >
> > > So again why? WebNFS died with Sun... Plus RFC2224 talks
> > > about v2 and v3... How does it fit in a V4 world.
> >
> > This is NOT about WebNFS or SUN, this is to make the job of admins easi=
er.
> >
>
> I think Steve is just trying to get at the use-case for this. Who is
> using nfs:// URLs in their environment, and why? IOW, how will adding
> this make things better?
>
> Then there are the more practical questions:
>
> - will this require kernel support? If I mount using a nfs:// URL,
> should I expect to see that in /proc/self/mounts, instead of a
> host:/export ?
>
> - do you need support for public filehandles? Those were largely
> ignored by most NFS implementors, including Linux. That opens an
> entirely separate can of worms.
>
> I'm happy to consider patches that add support for this (including
> documentation), but I'd need to understand why this is a material
> improvement over the traditional ":/" syntax.
>

No, traditional syntax is :\, traditional syntax is UNC form,
traditional syntax is GUI with hostname and path fields. No,
traditional syntax are options -H hostname, -P path.

Seems there is no tradition, just every software on Linux, PC/Windows,
MAC has its own syntax. Therefore I would agree that a platform
independent standard would be good

Thanks,
Martin

