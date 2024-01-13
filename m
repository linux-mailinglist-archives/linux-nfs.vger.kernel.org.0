Return-Path: <linux-nfs+bounces-1070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD082C924
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 03:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E461C22590
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65663B2;
	Sat, 13 Jan 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/IZtAfM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83A63A0
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdfed46372so5562519a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 18:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705113394; x=1705718194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZLjI/3EhokFVoJVTzuIT+jS6e17bKUhioZoPsyJT24=;
        b=N/IZtAfMT1WOxa+eoQpEliZKdrEA5kyLKaK2pM6GfAsjB9W/TSrzPWdwe6pkqkNj3X
         1KmvDqcnG6sEqcqJwrjKBKwccLt+VOxVCljelX/kT6tzViX4Jgfcl9gZV6snVout4dT2
         pCRN6AdeYCr2RNg6wesEG1WFUfIpVlzjC2FrLCVv3ySCZh0bdXizp3VeMRCCI/idszGe
         lLhfhQuFROn6nLymWF5uWDfZ/kyIiNKjnnseSnxDh0kdkKDrZwub6p6h3wotTn5PCAVy
         sbgcvQwps36gleafzZwpSqRTosgXUIJwIrlzGLN92Pg2Tc0Wo9+cKD1x+blk0gQM8ZLl
         kuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705113394; x=1705718194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZLjI/3EhokFVoJVTzuIT+jS6e17bKUhioZoPsyJT24=;
        b=HN7RG/E5fEZwJPE1e7lq7xDwBXogZNRrc+PIEtC3NAJhpRISPJJ7U6L2EE3EFrjgl0
         3ZUis7dl6KKd+rt0lmUx711e6CMZI7xMlLBfG+IHagm0gS/AeWft8m6SuSGkgMjBAzCv
         RRpx98Bc+O+hQ1wMU/17Y4RyrbSEnGy67zZt9lN/Bo9MC5Z65Tdt4xvOzN5xWGFk9B5u
         z/0yGCmdDiirNB6j7UwjB0PIDNeISNzfz8/W2Rv/Em+D0+lIZXgBmGz6dqcS9pPOJxnU
         GLb8I3pgyuVUjYR/Xa0GXebdR7iusQd6xenWC5PrBOgyQq0QB90f0IJOiRdQpJECjrwx
         d3rw==
X-Gm-Message-State: AOJu0YyPtx8WihYRbTMPl8H40+rmG6JfC0Upj3sTSKXjJ5fr+yVdG1A1
	cFpKzHtFPeBV2SJReO/qp0nLOo7luCU5mPGQ1A==
X-Google-Smtp-Source: AGHT+IGr6oDQQj9xucnEbKPim/UM6VXzR1oSEAgh+lfX3t9XaS9jAT3K8UdygCgx4BDF1oJR+IsCRg9s82TWwZIEEWs=
X-Received: by 2002:a17:902:7ecf:b0:1d4:ebbd:e057 with SMTP id
 p15-20020a1709027ecf00b001d4ebbde057mr2064231plb.127.1705113393912; Fri, 12
 Jan 2024 18:36:33 -0800 (PST)
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
 <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org>
 <CAM5tNy6yW_zVCu-i_bG=Tp5wE7OTqcjdjCgCJUEhax-P6aWARA@mail.gmail.com>
 <CAAvCNcDrpAUQp8h1xEy4XtaN=GL4hvgTedhSi-bPTbD+7YfoiA@mail.gmail.com>
 <CAM5tNy5iLRhKVRxeuKgUZvgor18LUDSpFc2ya=wrLRZfssr_0g@mail.gmail.com> <CAAvCNcD72YcNrot701hJDpdSfrbXDCU0iQ=eNipCBicOtoxYWg@mail.gmail.com>
In-Reply-To: <CAAvCNcD72YcNrot701hJDpdSfrbXDCU0iQ=eNipCBicOtoxYWg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 12 Jan 2024 18:36:16 -0800
Message-ID: <CAM5tNy5bv--6A_fX=qpfLMNp5xzbUGmEfq8iwHPhHTBCuNhtEg@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:09=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>
> On Fri, 12 Jan 2024 at 20:45, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Thu, Jan 11, 2024 at 6:25=E2=80=AFPM Dan Shelton <dan.f.shelton@gmai=
l.com> wrote:
> > >
> > > On Fri, 12 Jan 2024 at 03:13, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > > >
> > > > On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > CAUTION: This email originated from outside of the University of =
Guelph. Do not click links or open attachments unless you recognize the sen=
der and know the content is safe. If in doubt, forward suspicious emails to=
 IThelp@uoguelph.ca.
> > > > >
> > > > >
> > > > > On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > > > > > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> =
wrote:
> > > > > > >
> > > > > > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > > > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayto=
n@kernel.org> wrote:
> > > > > > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > > > > > > > Are there any known issues with NFSv4.1 mandatory loc=
king nfsd code in
> > > > > > > > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the =
Debian Bullseye
> > > > > > > > > > > RT kernel) ? Is there any kernel or NFS test suite mo=
dule which covers
> > > > > > > > > > > NFSv4.1 client mandatory locking ?
> > > > > > > > > >
> > > > > > > > > > Linux doesn't support mandatory locking at all since 20=
21 [1]. The Linux
> > > > > > > > > > NFS client and server therefore do not support v4.1 man=
datory locking.
> > > > > > > > >
> > > > > > > > > Forgot the footnote!
> > > > > > > > >
> > > > > > > > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/p=
atch/20210820114046.69282-1-jlayton@kernel.org/
> > > > > > > >
> > > > > > > > OK, this is pretty bad in terms of interoperability.... ;-(
> > > > > > > >
> > > > > > > > What should a Windows NFSv4 client (Hummingbird, OpenText, =
Exceed,
> > > > > > > > ms-nfs41-client, ...) do in this case ?
> > > > > > > > It basically means that locking for these clients will fail=
 if the
> > > > > > > > server does not support it... ;-(
> > > > > > > >
> > > > > > >
> > > > > > > I think they have two choices:
> > > > > > >
> > > > > > > Learn to deal with advisory locking, or contribute some sort =
of (sane)
> > > > > > > mandatory locking implementation to the Linux kernel.
> > > > > >
> > > > > > None of this will happen.
> > > > > > 1. Advisory locking cannot be mapped to Windows mandatory locki=
ng. End
> > > > > > of story. They are incompatible. That is why the NFSv4 protocol=
 had
> > > > > > mandatory locking built in into the first place. That was the g=
rand
> > > > > > design and the grand dream. That is gone.
> > > > Are you sure?
> > > > What about the following (in the same compound RPC as the Read/Writ=
e
> > > > operation):
> > > > - if the byte range being read/written is not yet locked by the cli=
ent/task
> > > >     Lock byte range using a lock_woner4 that represents the task do=
ing
> > > >     this Read/Write
> > > > - do read/write
> > > > - if Lock'd above, LockU the byte range
> > > >
> > > > As I understand it, the only difference between advisory vs mandato=
ry
> > > > byte range locking is that, for mandatory locking, the Read/Write w=
ill
> > > > get a reply of NFS4ERR_LOCKED when a conflicting lock exists.
> > > > --> For the above algorithm, the Lock operation will get a NFS4ERR_=
LOCKED
> > > >       if a conflicting lock exists.
> > > >      Isn't that at least roughly equivalent?
> > > >
> > > > There has always been problems w.r.t. mandatory locking in NFSv4.
> > > > 1 - No way for the NFSv4 client to know if the server is implementi=
ng
> > > >      mandatory locking. If you look back far enough, you'll find th=
at RFC3010
> > > >      had a flag in the Open reply that indicated "mandatory locking=
". It was
> > > >      dropped for RFC3530 and nothing else was added to replace it.
> > > > 2 - I could never see how write back data caching could be implemen=
ted in the
> > > >      client when the server is enforcing mandatory locking.
> > > >      --> The write back fails with NFS4ERR_LOCKED. What does the cl=
ient
> > > >            do then?
> > > >      I've concluded a client must either do write-through data cach=
ing or byte
> > > >      range lock all byte ranges of all files being write back data
> > > > cached. Neither seem
> > > >      reasonable to me.
> > > >
> > > > For a long time, I did have code in the FreeBSD NFSv4 server that
> > > > could implement
> > > > mandatory locking for NFSv4 clients only. (It is really only a chec=
k
> > > > for a conflicting
> > > > lock that is done by Read/Write.) I eventually got rid of it becaus=
e
> > > > no client wanted it.
> > >
> > > Rick, welcome to https://github.com/kofemann/ms-nfs41-client or
> > > https://www.opentext.co.uk/products-and-solutions/products/specialty-=
technologies/connectivity/nfs-client-nfs-solo
> > > I think both clients want that.
> > Well, 20 years ago I beta tested the Hummingbird client (I'm surprised =
it is
> > still a product, since I haven't seen those guys at a bakeathon in a lo=
ng time).
> > ack then, it was basically a port of their NFSv3 client and I do not re=
call that
> > it needed mandatory locking (or other features you have asked about, su=
ch
> > as named attributes and system/hidden attributes), but it has been 20ye=
ars.
> > I wonder if they ever upgraded it to NFSv4.1?
> >
> > As for the CITI code, it was meant to be a prototype and until recently=
 seemed
> > to be dormant since work stopped on it at least 10years ago.
>
> New binaries with new features and bug fixes every month does not look
> "dormant" to me:
> https://sourceforge.net/p/ms-nfs41-client/mailman/message/58718627/
>
I did say "until recently".
> >
> > The short version is "Since Microsoft never adopted NFSv4 as an alterna=
tive
> > to Cifs/SMB, there is no significant demand for these features.
>
> Microsoft is selling a NFSv4 SERVER, actually with support and bug
> fixes. Hell knows why they abandoned the CITI project
Yea, I was thinking of the desktop client case. (I actually think they have
some sort of NFSv4 client in Windows server as well?)

rick

>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd

