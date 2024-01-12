Return-Path: <linux-nfs+bounces-1053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82082B97C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 03:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B46CB245AA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91210FE;
	Fri, 12 Jan 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlnW0f3d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108721118
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7b273352so6334458e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 18:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705026335; x=1705631135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE1GMnIGmgD4rkvwiIXimCg9nrr/enMMIfmV2Qp080I=;
        b=DlnW0f3diuKdjvTR6mJq5irY7jT+qXp83pJqEoivNpj3y/bD2Wh9iHWTEZ+ylymln2
         INeKP5T5rZeQpOWQt+ls0a5N3AJTM65lark02qCK98Bmyj+kwdTzOQs6ONhMACqc8vYy
         CrFJaROQ5ucU2nYrAmcFQ7/JiZg2R+6vliOcXxGWKBfNw0z8xH77rc9h/85CmBv9tzvW
         VF5uDBEkNl6L/UDIMiwuD9SM8mJHZphKhFQxQiCPisdifWvKDWZd3FsBIcX9j7OVSjVM
         FgMIbf5U3E65/Oi0j+md4CrWcCcxGEjXCLgJVDKxxkA43awSUCPuXavjQXa4JLNixem5
         wtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705026335; x=1705631135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE1GMnIGmgD4rkvwiIXimCg9nrr/enMMIfmV2Qp080I=;
        b=OK4nQYqz6eHC3n9R3txyngBTYzG/KwQplOGYMArBXai85ayw90XgRMKNC+jyWs8TOo
         3UjBckiaBFvX9CJUApiEltEv3Go2EKIUak3LGwWxgxpfQyf+qKD5VsS3vjBYa9FmSQA9
         spK1DdF6FvMaa26KDy+5VvbxOrperqmK3Oi8pMXXU6dG+CUuI2uRg4v3d/rj2gZdXoRd
         kUh1uNjh9pE/4tYCbAgLSxfKI7FCySFa3bPuHVItIyP98GccMW+olErMNj77mj1hCM3v
         LEOp82a5lrB0h+W9hHARK5FAIsDWMVMASsuXFDFzvBHFyykPyhP/vmxuEVSspSY/o7ST
         3G0Q==
X-Gm-Message-State: AOJu0YzVIlxtu8ZBajzPKztlDBEcDLfidPS2FW+76glcMB/sJQ+K0L04
	B2jss9rz+vVNA0vGe2oafaTPGcixFy59t9V1Iq87+tiIzVsM3A==
X-Google-Smtp-Source: AGHT+IEnT6MJR7QqsGYqVMo5pG4v7hL/3yruEl5Qxepf+z34Rb3HO8XcrNe1IRC6c5B7zfKAWFbKCMt1969XcXNa3bA=
X-Received: by 2002:ac2:598e:0:b0:50e:1f22:3110 with SMTP id
 w14-20020ac2598e000000b0050e1f223110mr233761lfn.65.1705026334809; Thu, 11 Jan
 2024 18:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org>
 <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org>
 <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
 <5057fdb94f4d61661f9d13ccadb775a3a5bcdc92.camel@kernel.org>
 <CAAvCNcCC7xB1oWoSxaL269T62TuOYx64A+49fRoJTFJZ6xD+EA@mail.gmail.com>
 <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org> <CAM5tNy6yW_zVCu-i_bG=Tp5wE7OTqcjdjCgCJUEhax-P6aWARA@mail.gmail.com>
In-Reply-To: <CAM5tNy6yW_zVCu-i_bG=Tp5wE7OTqcjdjCgCJUEhax-P6aWARA@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 12 Jan 2024 03:25:08 +0100
Message-ID: <CAAvCNcDrpAUQp8h1xEy4XtaN=GL4hvgTedhSi-bPTbD+7YfoiA@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2024 at 03:13, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If in doubt, forward suspicious emails to IThel=
p@uoguelph.ca.
> >
> >
> > On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > > > > Are there any known issues with NFSv4.1 mandatory locking n=
fsd code in
> > > > > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian=
 Bullseye
> > > > > > > > RT kernel) ? Is there any kernel or NFS test suite module w=
hich covers
> > > > > > > > NFSv4.1 client mandatory locking ?
> > > > > > >
> > > > > > > Linux doesn't support mandatory locking at all since 2021 [1]=
. The Linux
> > > > > > > NFS client and server therefore do not support v4.1 mandatory=
 locking.
> > > > > >
> > > > > > Forgot the footnote!
> > > > > >
> > > > > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/2=
0210820114046.69282-1-jlayton@kernel.org/
> > > > >
> > > > > OK, this is pretty bad in terms of interoperability.... ;-(
> > > > >
> > > > > What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed=
,
> > > > > ms-nfs41-client, ...) do in this case ?
> > > > > It basically means that locking for these clients will fail if th=
e
> > > > > server does not support it... ;-(
> > > > >
> > > >
> > > > I think they have two choices:
> > > >
> > > > Learn to deal with advisory locking, or contribute some sort of (sa=
ne)
> > > > mandatory locking implementation to the Linux kernel.
> > >
> > > None of this will happen.
> > > 1. Advisory locking cannot be mapped to Windows mandatory locking. En=
d
> > > of story. They are incompatible. That is why the NFSv4 protocol had
> > > mandatory locking built in into the first place. That was the grand
> > > design and the grand dream. That is gone.
> Are you sure?
> What about the following (in the same compound RPC as the Read/Write
> operation):
> - if the byte range being read/written is not yet locked by the client/ta=
sk
>     Lock byte range using a lock_woner4 that represents the task doing
>     this Read/Write
> - do read/write
> - if Lock'd above, LockU the byte range
>
> As I understand it, the only difference between advisory vs mandatory
> byte range locking is that, for mandatory locking, the Read/Write will
> get a reply of NFS4ERR_LOCKED when a conflicting lock exists.
> --> For the above algorithm, the Lock operation will get a NFS4ERR_LOCKED
>       if a conflicting lock exists.
>      Isn't that at least roughly equivalent?
>
> There has always been problems w.r.t. mandatory locking in NFSv4.
> 1 - No way for the NFSv4 client to know if the server is implementing
>      mandatory locking. If you look back far enough, you'll find that RFC=
3010
>      had a flag in the Open reply that indicated "mandatory locking". It =
was
>      dropped for RFC3530 and nothing else was added to replace it.
> 2 - I could never see how write back data caching could be implemented in=
 the
>      client when the server is enforcing mandatory locking.
>      --> The write back fails with NFS4ERR_LOCKED. What does the client
>            do then?
>      I've concluded a client must either do write-through data caching or=
 byte
>      range lock all byte ranges of all files being write back data
> cached. Neither seem
>      reasonable to me.
>
> For a long time, I did have code in the FreeBSD NFSv4 server that
> could implement
> mandatory locking for NFSv4 clients only. (It is really only a check
> for a conflicting
> lock that is done by Read/Write.) I eventually got rid of it because
> no client wanted it.

Rick, welcome to https://github.com/kofemann/ms-nfs41-client or
https://www.opentext.co.uk/products-and-solutions/products/specialty-techno=
logies/connectivity/nfs-client-nfs-solo
I think both clients want that.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

