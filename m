Return-Path: <linux-nfs+bounces-1047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CB82B6A3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 22:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D312810A2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389375812E;
	Thu, 11 Jan 2024 21:28:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD85812A
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee328027bso102612139f.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 13:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008498; x=1705613298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i9AwnNpiL2QJUJkBWftoBjOLoXQw74K+x0EgQPt/LQ=;
        b=IOk1PVCp1NhTiBcLH0Gd+/ulXciUjlWnlHR3FZwKilDyopdjSwhjk5u5o7gBkLADUL
         poXpEKnRwhsbbtVcLwfSygcIW2by4GQSh2vyRagACJzVWnEEmFyil/j5FMNP/4VA4wUy
         GlOWlf5CAoUc0kx4rKgR6PO6EXO+O5plXYozH38MlyvCfZrCHWGKx2BBgULUWSYwSNGP
         L9NYqCE3nUp5k3XKspqPb4x+u61P4TMR2eipPEl9M+KnzrG70B0xMZMoQVqIcxL68y+V
         ALjXNxlj7N5pQkgz1xeJ/5JNUiKjkamp4XsePSXaKyobq6BHAtbCpMc2Zm4pxG8Ac2s2
         IaCQ==
X-Gm-Message-State: AOJu0Yy4yhkf3v3ZjiOELHu0ESEPSrQH6i7Ze9nH/g4xVz1vX3i8nN+N
	GcHiUlsTu4woCoUOtnJUKV4n2o0HagUV+sBXXcrVkoJEvR8=
X-Google-Smtp-Source: AGHT+IEfy9r55A2x5jKVePyQLDFLKXMpn3JaO9xVJkjsFttWtXBLEXlfhZKwA7H3y0I4GbXCeHhSN3r0qmbwwVFi65w=
X-Received: by 2002:a6b:e214:0:b0:7be:c0fc:e18e with SMTP id
 z20-20020a6be214000000b007bec0fce18emr384375ioc.22.1705008498574; Thu, 11 Jan
 2024 13:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org> <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org>
In-Reply-To: <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 11 Jan 2024 22:27:42 +0100
Message-ID: <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > Are there any known issues with NFSv4.1 mandatory locking nfsd code i=
n
> > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian Bullseye
> > > RT kernel) ? Is there any kernel or NFS test suite module which cover=
s
> > > NFSv4.1 client mandatory locking ?
> >
> > Linux doesn't support mandatory locking at all since 2021 [1]. The Linu=
x
> > NFS client and server therefore do not support v4.1 mandatory locking.
>
> Forgot the footnote!
>
> [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/20210820114=
046.69282-1-jlayton@kernel.org/

OK, this is pretty bad in terms of interoperability.... ;-(

What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed,
ms-nfs41-client, ...) do in this case ?
It basically means that locking for these clients will fail if the
server does not support it... ;-(

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

