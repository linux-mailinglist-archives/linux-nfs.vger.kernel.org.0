Return-Path: <linux-nfs+bounces-1055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5382BB0D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 06:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930E41C212CF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F61DA31;
	Fri, 12 Jan 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezv1fEpu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478A4F4F7
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso6842837e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705038766; x=1705643566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz5GaoSv7NgrFNg5nLXLWBDihb/gxOIaeZMsf5z6sy8=;
        b=Ezv1fEpueYEnEMnkHSUkgICaadAnjsb1wb1bksMjzpsUP2XGqbhL+NWjQrd7SuqZfQ
         4xoThbQ0TAFrI/x5sl3vji4THY2NKmzKEtq1u0Yiqm5dJGKe24sYN3psqyTY860iv+kd
         Juo0vTuvTt3FSjUzlNxFwLhbj9a+QMdf9kAxa1tQzC13pqYmJGC87l3YTY2PozmUt7Uw
         15nhSDEjSgkR0seR3V+hTcQyk6oH4HVoumEb6CweZ26HdYYuf1I+hymTfkx4oGyPw1/2
         GwEV3kU+67QFSdhMYTDMlepDTZlD8UI2gJxr7jWNXzERlyq5zkgBuDQMaoOfPQ8VFD5P
         lapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038766; x=1705643566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz5GaoSv7NgrFNg5nLXLWBDihb/gxOIaeZMsf5z6sy8=;
        b=OOfZVCHX0caZne4z2HL8O7JAKaLWPLEb4AjvKLuUkZxXDZHnPcre3rVVozQe8vrLqT
         1czd5ed/ZYIRlWy4ByhGMctYzlUiP1VPrEmEl5ctG7MEZ8a17iBQ3AJ9/QZ5lG+5qN6E
         exc7G+FFtOtwsEdo2mI728RrRM/mOcO7BtUeqfsgas8f8HzA0ikagQmXdUMTQc65ICl/
         UxNwduqb+m9nzWFzm/jxBoqufJ07Ueez7N17zZKRlw0iG9RK8CASqW6DovATTCev/Ff7
         bVSzD46284sY1p/WCwQ/GHeulxr7qIvBl2DGNDd8Ria3DZ7RH2CQzNg81/tD7FchmEL6
         yJtw==
X-Gm-Message-State: AOJu0YwBM6hA3oW9+btEw9MK084wxDNEHNB+U2o+gmRfvH8VXox0ux/1
	dot499J1wVsmsxWdOYACWQ8j15awDg8cAMIvUfBfoMca
X-Google-Smtp-Source: AGHT+IEt/Xxus9Qr/Mikuu4P3n+pNvp84mb0DX8GSxrEWnXbIjywm8X5IXmy3wdOa16f2I/90Jut9pih3aFjJDQZzgc=
X-Received: by 2002:a19:2d54:0:b0:50e:abd1:bfba with SMTP id
 t20-20020a192d54000000b0050eabd1bfbamr215794lft.15.1705038766028; Thu, 11 Jan
 2024 21:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org>
 <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org> <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
In-Reply-To: <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 12 Jan 2024 06:52:00 +0100
Message-ID: <CALXu0UeCARBNQU6gVaW60J=WwdeZrQow1rPwu6jDovSBEkBh4g@mail.gmail.com>
Subject: RIP NFSv4 interoperability?! Re: NFSv4.1 mandatory locks working in
 Linux nfsd ?
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 at 22:28, Roland Mainz <roland.mainz@nrubsig.org> wrote=
:
>
> On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > Are there any known issues with NFSv4.1 mandatory locking nfsd code=
 in
> > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian Bullsey=
e
> > > > RT kernel) ? Is there any kernel or NFS test suite module which cov=
ers
> > > > NFSv4.1 client mandatory locking ?
> > >
> > > Linux doesn't support mandatory locking at all since 2021 [1]. The Li=
nux
> > > NFS client and server therefore do not support v4.1 mandatory locking=
.
> >
> > Forgot the footnote!
> >
> > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/202108201=
14046.69282-1-jlayton@kernel.org/
>
> OK, this is pretty bad in terms of interoperability.... ;-(
>
> What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed,
> ms-nfs41-client, ...) do in this case ?
> It basically means that locking for these clients will fail if the
> server does not support it... ;-(

The NFSv4 server has to provide an emulation, as mandatory locking is
part of the NFSv4 protocol [1].

Although I am more, and more, and even more horrified that the once
beautiful NFSv4 design goal of a protocol for all platforms, as in
Windows, Unix, Linux, RTOS, ..., is rapidly degrading into a devolved
Linux-centric network fs, something 9p already covers, while
SMBFS/CIFS have completely taken over the market for cross-platform
network filesystems.

RIP NFSv4 ?!

[1]: <sarcasm>Of course the next NFS RFC will declare NFSv4 mandatory
locking as "obsolete", as interoperability is already covered by
SMB/CIFS and 9p</sarcasm>

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

