Return-Path: <linux-nfs+bounces-1050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E603782B8B8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 01:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9095E286289
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 00:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F44A21;
	Fri, 12 Jan 2024 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixQGlxlq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011084A1C
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6782392e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705020275; x=1705625075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MetRMED4wMmHOC4sJxLk64xo7zIuH58/nznxaHUBYJQ=;
        b=ixQGlxlq3dB8qfa3JeQ+fyfLVTQ8p28ZAeAXsdhXN9sEX9jp5x+08OAKTCboYOb/ht
         gArmOGiCM0x/zG+NitjL1PbxcWDqVdXknvOpTOXZfiJpuSvhHDNnmdvFlYtCD+mYJxCD
         bS3zokBti/dAjISDd6ax6bjV5x9lzjhx539zFiP8yV5sgQzayIRHSpJx9W5wcXBIZxGY
         7qJYDE5yrAn3+9JqT8f5jzQRX+5AqW6veOd/N0/wZBmKYIjdbkA2DtPlmUD4oMW8RStC
         LTCDPo6aw892TzPL4jTpa3PpdVe9cJwObN4mnV0Qpo3MrY3E7xns2N7vxbhh5qXdqhuB
         Y0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705020275; x=1705625075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MetRMED4wMmHOC4sJxLk64xo7zIuH58/nznxaHUBYJQ=;
        b=BTIy+TVLqDJ424uTSbBI/n2GJyGxFEeFrWb11GOTJ323RhZMc80h1BQSXf9MkLcTNY
         F36IRvKufdpr1v3W+coZLO3BUYGTCVgDqtfNzFDbVWAzdu8r9OvvGIdd+kyhkon8EsQw
         VDx/9JPbcoG8ar263KxSUgM6NjX912NqBz1pYf2sVeb70Uhpam98U3lm1Lhi+i0iXyiq
         cXtuFYIXfxMRSlpl8OFdqum0LpPaQ/j9dcnoxsQmAcIJ8Bs3BLgVopl9OQasnd8Q9MW+
         nitohhxi3wyh5bs44/94/L2KGIrjPkmO2u9K+FasShg8rZm36/LocZ17hWgIRVMyB9eL
         iiVg==
X-Gm-Message-State: AOJu0YwX8Ao3hRyLLI4hoVPSoXFWIiYKBwSwww1WVV4haTazi28vKIn7
	cabwOd9+XmLfhgk2X9X2z+1BbdDNxRDErcQGcHiKwpPYx7w=
X-Google-Smtp-Source: AGHT+IEdJYtzVeWE2c5c1DTTzJG++Ttyg9MNyqnGt/MhViAPUHnd+otGT6bHFIJ92rX74gD0DetoCl/pVNbxUt383yk=
X-Received: by 2002:ac2:43db:0:b0:50e:3b8f:3c40 with SMTP id
 u27-20020ac243db000000b0050e3b8f3c40mr209458lfl.43.1705020274909; Thu, 11 Jan
 2024 16:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org>
 <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org>
 <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com> <5057fdb94f4d61661f9d13ccadb775a3a5bcdc92.camel@kernel.org>
In-Reply-To: <5057fdb94f4d61661f9d13ccadb775a3a5bcdc92.camel@kernel.org>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 12 Jan 2024 01:44:08 +0100
Message-ID: <CAAvCNcCC7xB1oWoSxaL269T62TuOYx64A+49fRoJTFJZ6xD+EA@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Jeff Layton <jlayton@kernel.org>
Cc: Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > Are there any known issues with NFSv4.1 mandatory locking nfsd co=
de in
> > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian Bulls=
eye
> > > > > RT kernel) ? Is there any kernel or NFS test suite module which c=
overs
> > > > > NFSv4.1 client mandatory locking ?
> > > >
> > > > Linux doesn't support mandatory locking at all since 2021 [1]. The =
Linux
> > > > NFS client and server therefore do not support v4.1 mandatory locki=
ng.
> > >
> > > Forgot the footnote!
> > >
> > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/2021082=
0114046.69282-1-jlayton@kernel.org/
> >
> > OK, this is pretty bad in terms of interoperability.... ;-(
> >
> > What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed,
> > ms-nfs41-client, ...) do in this case ?
> > It basically means that locking for these clients will fail if the
> > server does not support it... ;-(
> >
>
> I think they have two choices:
>
> Learn to deal with advisory locking, or contribute some sort of (sane)
> mandatory locking implementation to the Linux kernel.

None of this will happen.
1. Advisory locking cannot be mapped to Windows mandatory locking. End
of story. They are incompatible. That is why the NFSv4 protocol had
mandatory locking built in into the first place. That was the grand
design and the grand dream. That is gone.
2. No one is going to implement a giant set of code just so that SAMBA
and NFSv4 can work. SAMBA has a builtin emulation so mandatory locking
works between Windows clients, ignoring the Linux side and Linux
advisory locking completely.

The only option is option three: NFSv4 for Windows will become a 3rd
class glorified FTP replacement with no functional locking. Just for
copying files around. End of story.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

