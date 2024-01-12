Return-Path: <linux-nfs+bounces-1063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8182C5FD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 20:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759981C20E2C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33315AC9;
	Fri, 12 Jan 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z73VExy/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CD12E79
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28cc07d8876so4243789a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088756; x=1705693556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQZRo4h3S5T/ykKR93mSQAS0+ahhX1sXppoNbH5OQds=;
        b=Z73VExy/WCYe76Wzg4JyNBR8KGixBUvpl812vDOREYwYHCBLR6j8TEw7IAEUwVU5AB
         F9Is2Jk0W+pne1WwNMhsv43Kvei3ky0FYm5B9ocQ5T2yvmPAS5C2vsNgMPAO8cW/ju+s
         SWZpnPJKz1kPfnX28FejEscqtPazb3WY1PefDZSjQ5T2SFra5X+RBOyaZhaGENn51oRL
         WHvor73xilKxe5MW9Slg/LcRcpBxAc2y9uBjoId/a+oiyDe6VMQaExghYW5rCmjp0lnh
         ocIEiBxh0L21fLp3rVVD/UMZlccyvMswqTDvOZZqwRcHXYrohXtg/HPigZwb5kZA1SaJ
         uI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088756; x=1705693556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQZRo4h3S5T/ykKR93mSQAS0+ahhX1sXppoNbH5OQds=;
        b=gilWpex5DIhZ4m0qU6OdPD3sWycK7FII7fJA3GRnHAou4nmwf/Zi67OqLfUd7/Gi/x
         1L2Ssc6zzH1xiV3c08OA+at/2PDvF+9Ajf35I5DTxi08MP9LVLdQTltYzAkSn+prX4S1
         VDaO1xFxFfQfCMqHAWngT4pfkgEsDYh2rSrF+W6Mt6oTKByY7LvCK7nExLBcO8dNcbFW
         zFvMHU7+2actmRj6S4cZIzPh07/pbEJ5JB+qzReqFlGFrzeNtQGRHheiReXZl9cL+3cb
         jNVNaYutPjaSiLflc3HA8QubHEjeLe23HXmO+F69NIdRF9sZh37z+f6Goo0TKTdDefFF
         IMCw==
X-Gm-Message-State: AOJu0YxN/UttZPVDTlQknWX4yUl0N0o93LHliMOmSG4z9HZT0HIzNbIW
	FSdBGCjvDOLitF5sS7ONQCoG6sYwtCfQVtq/jQ==
X-Google-Smtp-Source: AGHT+IHMUIIzQNRpQUFvnEVMfdMKO9SoXr5zuzK0gVeBetUD/gLxu+abrvvf4xE0D6jLuCeI09MiKMIGqG+R1+X/VMg=
X-Received: by 2002:a17:90a:b385:b0:28e:60f:a01d with SMTP id
 e5-20020a17090ab38500b0028e060fa01dmr1333003pjr.84.1705088755600; Fri, 12 Jan
 2024 11:45:55 -0800 (PST)
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
 <CAM5tNy6yW_zVCu-i_bG=Tp5wE7OTqcjdjCgCJUEhax-P6aWARA@mail.gmail.com> <CAAvCNcDrpAUQp8h1xEy4XtaN=GL4hvgTedhSi-bPTbD+7YfoiA@mail.gmail.com>
In-Reply-To: <CAAvCNcDrpAUQp8h1xEy4XtaN=GL4hvgTedhSi-bPTbD+7YfoiA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 12 Jan 2024 11:45:38 -0800
Message-ID: <CAM5tNy5iLRhKVRxeuKgUZvgor18LUDSpFc2ya=wrLRZfssr_0g@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:25=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>
> On Fri, 12 Jan 2024 at 03:13, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > CAUTION: This email originated from outside of the University of Guel=
ph. Do not click links or open attachments unless you recognize the sender =
and know the content is safe. If in doubt, forward suspicious emails to ITh=
elp@uoguelph.ca.
> > >
> > >
> > > On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > > > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > > >
> > > > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@ke=
rnel.org> wrote:
> > > > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > > > > > > Are there any known issues with NFSv4.1 mandatory locking=
 nfsd code in
> > > > > > > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debi=
an Bullseye
> > > > > > > > > RT kernel) ? Is there any kernel or NFS test suite module=
 which covers
> > > > > > > > > NFSv4.1 client mandatory locking ?
> > > > > > > >
> > > > > > > > Linux doesn't support mandatory locking at all since 2021 [=
1]. The Linux
> > > > > > > > NFS client and server therefore do not support v4.1 mandato=
ry locking.
> > > > > > >
> > > > > > > Forgot the footnote!
> > > > > > >
> > > > > > > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch=
/20210820114046.69282-1-jlayton@kernel.org/
> > > > > >
> > > > > > OK, this is pretty bad in terms of interoperability.... ;-(
> > > > > >
> > > > > > What should a Windows NFSv4 client (Hummingbird, OpenText, Exce=
ed,
> > > > > > ms-nfs41-client, ...) do in this case ?
> > > > > > It basically means that locking for these clients will fail if =
the
> > > > > > server does not support it... ;-(
> > > > > >
> > > > >
> > > > > I think they have two choices:
> > > > >
> > > > > Learn to deal with advisory locking, or contribute some sort of (=
sane)
> > > > > mandatory locking implementation to the Linux kernel.
> > > >
> > > > None of this will happen.
> > > > 1. Advisory locking cannot be mapped to Windows mandatory locking. =
End
> > > > of story. They are incompatible. That is why the NFSv4 protocol had
> > > > mandatory locking built in into the first place. That was the grand
> > > > design and the grand dream. That is gone.
> > Are you sure?
> > What about the following (in the same compound RPC as the Read/Write
> > operation):
> > - if the byte range being read/written is not yet locked by the client/=
task
> >     Lock byte range using a lock_woner4 that represents the task doing
> >     this Read/Write
> > - do read/write
> > - if Lock'd above, LockU the byte range
> >
> > As I understand it, the only difference between advisory vs mandatory
> > byte range locking is that, for mandatory locking, the Read/Write will
> > get a reply of NFS4ERR_LOCKED when a conflicting lock exists.
> > --> For the above algorithm, the Lock operation will get a NFS4ERR_LOCK=
ED
> >       if a conflicting lock exists.
> >      Isn't that at least roughly equivalent?
> >
> > There has always been problems w.r.t. mandatory locking in NFSv4.
> > 1 - No way for the NFSv4 client to know if the server is implementing
> >      mandatory locking. If you look back far enough, you'll find that R=
FC3010
> >      had a flag in the Open reply that indicated "mandatory locking". I=
t was
> >      dropped for RFC3530 and nothing else was added to replace it.
> > 2 - I could never see how write back data caching could be implemented =
in the
> >      client when the server is enforcing mandatory locking.
> >      --> The write back fails with NFS4ERR_LOCKED. What does the client
> >            do then?
> >      I've concluded a client must either do write-through data caching =
or byte
> >      range lock all byte ranges of all files being write back data
> > cached. Neither seem
> >      reasonable to me.
> >
> > For a long time, I did have code in the FreeBSD NFSv4 server that
> > could implement
> > mandatory locking for NFSv4 clients only. (It is really only a check
> > for a conflicting
> > lock that is done by Read/Write.) I eventually got rid of it because
> > no client wanted it.
>
> Rick, welcome to https://github.com/kofemann/ms-nfs41-client or
> https://www.opentext.co.uk/products-and-solutions/products/specialty-tech=
nologies/connectivity/nfs-client-nfs-solo
> I think both clients want that.
Well, 20 years ago I beta tested the Hummingbird client (I'm surprised it i=
s
still a product, since I haven't seen those guys at a bakeathon in a long t=
ime).
ack then, it was basically a port of their NFSv3 client and I do not recall=
 that
it needed mandatory locking (or other features you have asked about, such
as named attributes and system/hidden attributes), but it has been 20years.
I wonder if they ever upgraded it to NFSv4.1?

As for the CITI code, it was meant to be a prototype and until recently see=
med
to be dormant since work stopped on it at least 10years ago.

The short version is "Since Microsoft never adopted NFSv4 as an alternative
to Cifs/SMB, there is no significant demand for these features.

If you wanted a server that does mandatory locking, Solaris might?
(There used to be some weird combination of mode bits that meant
"mandatory locking" in Solaris. set_gid set and group_exec cleared,
or something like that.  The problem is that a chmod could change this
at any time. I think that is why the Open flag that indicated mandatory
locking in RFC3010 got dropped for RFC3530.)

I proposed a "mandatory locking" attribute along with a few other
new attributes for NFSv4.2 in an IETF  personal draft, but there did not
seem to be any interest, so I ditched it.

As far as I know, the only way for a client to know if mandatory
locking is being done by the server is something like:
- Open a file
- Apply a write lock using a different lock_owner4
- Attempt to read the file.
--> If the read replies NFS4ERR_LOCKED, then the server is
      applying mandatory locking.
Of course, there is no guarantee the same semantics will apply
to other files nor that the semantics will not change for that file.

I used to email nfsv4@ietf.org 20 years ago about this, but I
gave up after a while, since no one seemed interested.
(Again, the "if Microsoft doesn't care, the vendors don't care"
principal.)

rick
ps: A Solaris server might also do named attributes?

>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd

