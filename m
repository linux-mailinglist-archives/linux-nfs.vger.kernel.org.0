Return-Path: <linux-nfs+bounces-1052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DEA82B95C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 03:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90105B234E5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A44A14;
	Fri, 12 Jan 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arc8ujXl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC804A13
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso3932538a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705025614; x=1705630414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5LAS9MKzJv7Abc3VE8e+t2pg7zB4zEuieSCdi0sJ1g=;
        b=arc8ujXlrrliBv8r/OrEHW8BAFbCDNr6ALFhud0G4ec7gOdkbmq1b5X1aBnxjbRXVI
         mKh5CkY9whlJxDTpf/eFHPCQlt8MRq6sLwRDnFwnAB5+HN1V/PZPQ5tKl4OCObNeLKgR
         QSyvgKXny3QffbXd+wcZm4Hwat40V8kwjw8bLzChjAX0qmBWU2XRMvZaIXU9gHFSYOYR
         ZXOPmWkAD0c6L4RzKD6zLILqFQWt88h/6yoZ4t0uWQ4Os3KOUe5BQJbkMI/jMfJ2o1xW
         i0wBtMUsFHNqUvSRAixJjy890QbRr9fbnWnuVUu38ipYzC+TxuSQjdTB1a4eBV/hW9AX
         6Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705025614; x=1705630414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5LAS9MKzJv7Abc3VE8e+t2pg7zB4zEuieSCdi0sJ1g=;
        b=QslzrNRSGQ5dAmuUg3ThwBLJW4l6ji16npcSQUeM5Ft2xWrvJx/GQPY2OJFvGSoftK
         P6fjD0NfjSKo4ahyybhs27Q7zsxmm3kS6Av0XaDwJTStLT27zu1t23xiiheEXi3bP2NX
         OU4gK/8Xcfd/2GA+IILzk3bdG8BtBfWu6+Y6XVTVHbPLBS1x//R1fJTbrKIMyBgX0nl7
         Pp+V5VZSJcozu6qfRM7MZxlpJMOL3RwgQd10oYt53L2DOUalKeWRlkYLDTJklRnIzz3e
         lKNfUNKMzXz+ccJF3xaIG5HM8sRY2fY77mbcBzn/5LQ3v80gL6yOalUd6cmYpDaJRpb6
         WKEg==
X-Gm-Message-State: AOJu0Yw2vvw4Ld/mACyoTaNtre1TVHBdsNmkEvKKvehCfbyIdJm7ArbC
	tt+VS+tB5PX3+FTPdn1RTsLyMtgSKDhgEiGu3g==
X-Google-Smtp-Source: AGHT+IGdlulXTe2l8VixR9bzvZFyaIsxUJUbTuUbzZjgCAq9u9c6xyGsiIoaia8tKQTSUf45vorHdB2Ohok0tlKuqn4=
X-Received: by 2002:a05:6a21:196:b0:199:9d92:f307 with SMTP id
 le22-20020a056a21019600b001999d92f307mr358324pzb.94.1705025614154; Thu, 11
 Jan 2024 18:13:34 -0800 (PST)
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
 <CAAvCNcCC7xB1oWoSxaL269T62TuOYx64A+49fRoJTFJZ6xD+EA@mail.gmail.com> <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org>
In-Reply-To: <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 11 Jan 2024 18:13:17 -0800
Message-ID: <CAM5tNy6yW_zVCu-i_bG=Tp5wE7OTqcjdjCgCJUEhax-P6aWARA@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Jeff Layton <jlayton@kernel.org>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > > > Are there any known issues with NFSv4.1 mandatory locking nfs=
d code in
> > > > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian B=
ullseye
> > > > > > > RT kernel) ? Is there any kernel or NFS test suite module whi=
ch covers
> > > > > > > NFSv4.1 client mandatory locking ?
> > > > > >
> > > > > > Linux doesn't support mandatory locking at all since 2021 [1]. =
The Linux
> > > > > > NFS client and server therefore do not support v4.1 mandatory l=
ocking.
> > > > >
> > > > > Forgot the footnote!
> > > > >
> > > > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/202=
10820114046.69282-1-jlayton@kernel.org/
> > > >
> > > > OK, this is pretty bad in terms of interoperability.... ;-(
> > > >
> > > > What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed,
> > > > ms-nfs41-client, ...) do in this case ?
> > > > It basically means that locking for these clients will fail if the
> > > > server does not support it... ;-(
> > > >
> > >
> > > I think they have two choices:
> > >
> > > Learn to deal with advisory locking, or contribute some sort of (sane=
)
> > > mandatory locking implementation to the Linux kernel.
> >
> > None of this will happen.
> > 1. Advisory locking cannot be mapped to Windows mandatory locking. End
> > of story. They are incompatible. That is why the NFSv4 protocol had
> > mandatory locking built in into the first place. That was the grand
> > design and the grand dream. That is gone.
Are you sure?
What about the following (in the same compound RPC as the Read/Write
operation):
- if the byte range being read/written is not yet locked by the client/task
    Lock byte range using a lock_woner4 that represents the task doing
    this Read/Write
- do read/write
- if Lock'd above, LockU the byte range

As I understand it, the only difference between advisory vs mandatory
byte range locking is that, for mandatory locking, the Read/Write will
get a reply of NFS4ERR_LOCKED when a conflicting lock exists.
--> For the above algorithm, the Lock operation will get a NFS4ERR_LOCKED
      if a conflicting lock exists.
     Isn't that at least roughly equivalent?

There has always been problems w.r.t. mandatory locking in NFSv4.
1 - No way for the NFSv4 client to know if the server is implementing
     mandatory locking. If you look back far enough, you'll find that RFC30=
10
     had a flag in the Open reply that indicated "mandatory locking". It wa=
s
     dropped for RFC3530 and nothing else was added to replace it.
2 - I could never see how write back data caching could be implemented in t=
he
     client when the server is enforcing mandatory locking.
     --> The write back fails with NFS4ERR_LOCKED. What does the client
           do then?
     I've concluded a client must either do write-through data caching or b=
yte
     range lock all byte ranges of all files being write back data
cached. Neither seem
     reasonable to me.

For a long time, I did have code in the FreeBSD NFSv4 server that
could implement
mandatory locking for NFSv4 clients only. (It is really only a check
for a conflicting
lock that is done by Read/Write.) I eventually got rid of it because
no client wanted it.

rick


>
> Yep, pretty much. Samba does set VFS-layer advisory locks that (mostly)
> correspond to the locks that SMB clients set, but it's really just a
> best-effort sort of thing. It has to emulate the windows semantics
> internally.
>
> > 2. No one is going to implement a giant set of code just so that SAMBA
> > and NFSv4 can work. SAMBA has a builtin emulation so mandatory locking
> > works between Windows clients, ignoring the Linux side and Linux
> > advisory locking completely.
> >
>
> Also, pretty much. With a general purpose OS like Linux, we try to avoid
> this sort of emulation. We do have that for the share/deny locking that
> happens during OPEN, but there was really no choice there since we
> couldn't reasonably implement that in the VFS, and it was a required
> part of the NFSv4 protocol.
>
> Mandatory locking is optional so we can just opt-out.
>
> > The only option is option three: NFSv4 for Windows will become a 3rd
> > class glorified FTP replacement with no functional locking. Just for
> > copying files around. End of story.
> >
>
> More or less. FWIW, here's the LWN article from when we decided to start
> getting rid of mandatory locking in Linux:
>
>     https://lwn.net/Articles/667210/
>
> No one used it. It was racy and there weren't great ways to fix that
> that didn't slow down I/O.
> --
> Jeff Layton <jlayton@kernel.org>
>

