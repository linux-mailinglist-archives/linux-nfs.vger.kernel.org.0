Return-Path: <linux-nfs+bounces-1065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AD82C835
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D3A1F22950
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA2195;
	Sat, 13 Jan 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlPE5B8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403C364
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso6059960e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 16:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705104570; x=1705709370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3geMRT4lnWRt6j00DLGFwhbGaONKIiYxTrQBD9NUuo=;
        b=DlPE5B8fW7rVVJP5NAFOOj2yEgAN9Sj6WyNajsnizrqcgX21vmVOlPkxSAmByo5W8d
         Azy65ULEn3XTddwf5RCTBT4H4vPwVCzAahUN82QAVqJZakcq5eUXc2hc8P60n43+Ew1Z
         O+IocvXV/8rps1WMfB9ic2kDw/6M+E43iI29mqcNMmwahH6P9vXSO33Lk+i9WH4rkPhO
         didSBye/IxvIunh9KqqZI4aEDoiXERZbF9oNzz/PcCDRprQ7vjRWQscZgxy3qmjjraaI
         u0EBtuhoYxTqgU7FKOrATod1o/wpY+XZaMab1j4Qx0ZhkY6YO/x9PuDaXGTEESRn99cU
         p4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705104570; x=1705709370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3geMRT4lnWRt6j00DLGFwhbGaONKIiYxTrQBD9NUuo=;
        b=puEpRvit2X9K/WY2AoBVkmFH0ttgaNwdrI1rnMNzjCuPiPtx3oAODnP5RVVoCtI0eN
         Ex9E+Cuh4Qea1uEF87rf/hElh/VTcMzRPoxKKUXmz8mBNFupNHcP15sq4eFAixP2/jrW
         7Gx32s113mgw4hPYCd++trEvhIOgOV7AI/GOcCYsCvB3biSnl4KvhRFFyApTChIzn6+2
         5YYWCAMjEA2EOBVsAFt7/6IYy8ixmT6+qG8LzE1qX6cLYs95EFKvp3mgNa0FoefsHJFE
         nsTyisjuzhjnV0bx/lHIYroRRIRd1UrDeu1LoYAXRajgKYP2N1mqpCO8IKftD58C3Uan
         /EpQ==
X-Gm-Message-State: AOJu0Yxy1ID42YgwuXeQ0jBenHFN+hxbTJ5QYYxlhhTWa4GIAdZ4hNa5
	NmtI/2H5CfDt097iteA34gD6lB3i6nJmcBkFlMdprA64iluHBg==
X-Google-Smtp-Source: AGHT+IHYjf7ifpOXZdrixVW6ZD/Z/G9JgGSxs4AUxq1NDba+/nywiJ4KMzjokgVoARFibTdrri8e0uLPpOuB/r8m2GY=
X-Received: by 2002:ac2:414f:0:b0:50e:9354:67d0 with SMTP id
 c15-20020ac2414f000000b0050e935467d0mr965846lfi.14.1705104569825; Fri, 12 Jan
 2024 16:09:29 -0800 (PST)
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
 <CAAvCNcDrpAUQp8h1xEy4XtaN=GL4hvgTedhSi-bPTbD+7YfoiA@mail.gmail.com> <CAM5tNy5iLRhKVRxeuKgUZvgor18LUDSpFc2ya=wrLRZfssr_0g@mail.gmail.com>
In-Reply-To: <CAM5tNy5iLRhKVRxeuKgUZvgor18LUDSpFc2ya=wrLRZfssr_0g@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 13 Jan 2024 01:09:03 +0100
Message-ID: <CAAvCNcD72YcNrot701hJDpdSfrbXDCU0iQ=eNipCBicOtoxYWg@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2024 at 20:45, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Thu, Jan 11, 2024 at 6:25=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.=
com> wrote:
> >
> > On Fri, 12 Jan 2024 at 03:13, Rick Macklem <rick.macklem@gmail.com> wro=
te:
> > >
> > > On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >
> > > > CAUTION: This email originated from outside of the University of Gu=
elph. Do not click links or open attachments unless you recognize the sende=
r and know the content is safe. If in doubt, forward suspicious emails to I=
Thelp@uoguelph.ca.
> > > >
> > > >
> > > > On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > > > > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > > >
> > > > > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@=
kernel.org> wrote:
> > > > > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > > > > > > Are there any known issues with NFSv4.1 mandatory locki=
ng nfsd code in
> > > > > > > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the De=
bian Bullseye
> > > > > > > > > > RT kernel) ? Is there any kernel or NFS test suite modu=
le which covers
> > > > > > > > > > NFSv4.1 client mandatory locking ?
> > > > > > > > >
> > > > > > > > > Linux doesn't support mandatory locking at all since 2021=
 [1]. The Linux
> > > > > > > > > NFS client and server therefore do not support v4.1 manda=
tory locking.
> > > > > > > >
> > > > > > > > Forgot the footnote!
> > > > > > > >
> > > > > > > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/pat=
ch/20210820114046.69282-1-jlayton@kernel.org/
> > > > > > >
> > > > > > > OK, this is pretty bad in terms of interoperability.... ;-(
> > > > > > >
> > > > > > > What should a Windows NFSv4 client (Hummingbird, OpenText, Ex=
ceed,
> > > > > > > ms-nfs41-client, ...) do in this case ?
> > > > > > > It basically means that locking for these clients will fail i=
f the
> > > > > > > server does not support it... ;-(
> > > > > > >
> > > > > >
> > > > > > I think they have two choices:
> > > > > >
> > > > > > Learn to deal with advisory locking, or contribute some sort of=
 (sane)
> > > > > > mandatory locking implementation to the Linux kernel.
> > > > >
> > > > > None of this will happen.
> > > > > 1. Advisory locking cannot be mapped to Windows mandatory locking=
. End
> > > > > of story. They are incompatible. That is why the NFSv4 protocol h=
ad
> > > > > mandatory locking built in into the first place. That was the gra=
nd
> > > > > design and the grand dream. That is gone.
> > > Are you sure?
> > > What about the following (in the same compound RPC as the Read/Write
> > > operation):
> > > - if the byte range being read/written is not yet locked by the clien=
t/task
> > >     Lock byte range using a lock_woner4 that represents the task doin=
g
> > >     this Read/Write
> > > - do read/write
> > > - if Lock'd above, LockU the byte range
> > >
> > > As I understand it, the only difference between advisory vs mandatory
> > > byte range locking is that, for mandatory locking, the Read/Write wil=
l
> > > get a reply of NFS4ERR_LOCKED when a conflicting lock exists.
> > > --> For the above algorithm, the Lock operation will get a NFS4ERR_LO=
CKED
> > >       if a conflicting lock exists.
> > >      Isn't that at least roughly equivalent?
> > >
> > > There has always been problems w.r.t. mandatory locking in NFSv4.
> > > 1 - No way for the NFSv4 client to know if the server is implementing
> > >      mandatory locking. If you look back far enough, you'll find that=
 RFC3010
> > >      had a flag in the Open reply that indicated "mandatory locking".=
 It was
> > >      dropped for RFC3530 and nothing else was added to replace it.
> > > 2 - I could never see how write back data caching could be implemente=
d in the
> > >      client when the server is enforcing mandatory locking.
> > >      --> The write back fails with NFS4ERR_LOCKED. What does the clie=
nt
> > >            do then?
> > >      I've concluded a client must either do write-through data cachin=
g or byte
> > >      range lock all byte ranges of all files being write back data
> > > cached. Neither seem
> > >      reasonable to me.
> > >
> > > For a long time, I did have code in the FreeBSD NFSv4 server that
> > > could implement
> > > mandatory locking for NFSv4 clients only. (It is really only a check
> > > for a conflicting
> > > lock that is done by Read/Write.) I eventually got rid of it because
> > > no client wanted it.
> >
> > Rick, welcome to https://github.com/kofemann/ms-nfs41-client or
> > https://www.opentext.co.uk/products-and-solutions/products/specialty-te=
chnologies/connectivity/nfs-client-nfs-solo
> > I think both clients want that.
> Well, 20 years ago I beta tested the Hummingbird client (I'm surprised it=
 is
> still a product, since I haven't seen those guys at a bakeathon in a long=
 time).
> ack then, it was basically a port of their NFSv3 client and I do not reca=
ll that
> it needed mandatory locking (or other features you have asked about, such
> as named attributes and system/hidden attributes), but it has been 20year=
s.
> I wonder if they ever upgraded it to NFSv4.1?
>
> As for the CITI code, it was meant to be a prototype and until recently s=
eemed
> to be dormant since work stopped on it at least 10years ago.

New binaries with new features and bug fixes every month does not look
"dormant" to me:
https://sourceforge.net/p/ms-nfs41-client/mailman/message/58718627/

>
> The short version is "Since Microsoft never adopted NFSv4 as an alternati=
ve
> to Cifs/SMB, there is no significant demand for these features.

Microsoft is selling a NFSv4 SERVER, actually with support and bug
fixes. Hell knows why they abandoned the CITI project

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

