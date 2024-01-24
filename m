Return-Path: <linux-nfs+bounces-1307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C298883AB56
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B61C21074
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7677F14;
	Wed, 24 Jan 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMcMXb5a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6163103
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105128; cv=none; b=AZ5jt71PYiDbTtRVjGZrG6UZLyB+2Gb8KXnd5fdxqUeHDvEwaDwD4C7V/wkSrfskpawkPw2EzIpEmwWHDMQKLE6KmtaD3azAkh230NjBUfH2Otu3MQIElmLBr4Nj9ofsynzUtP+OkptuRptDgab0wugIraAqJ31bkgDv/RQQz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105128; c=relaxed/simple;
	bh=rKT/SovjmMKybGM+TsighIhEsthz6eW5SOAgfqxWmW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H13utaRH1KPaXhfxoNMHzjCHh0uZCDnDF9T1Oz0y1o6OBIjHvwgaR0ViWRvT37cNxNgS80C0n4erDe9+URiiE5QoiYK4f91eXHeOHQwoZKPxjxoMX5SYz27Oar3wvwaRYMxK0x6QcHM/Pd+exacdZta8KTxlZpCwsgRoqYIEicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMcMXb5a; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso6483853a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105125; x=1706709925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKT/SovjmMKybGM+TsighIhEsthz6eW5SOAgfqxWmW8=;
        b=lMcMXb5aNgNUtmj8JKvWT3PynkrdW0EuBTywtSukiuzhOHbkFoxGXbTJPUtyybg36Q
         QxQkSyckSHyEjyVsYMghMv4de3sk50EGmTikcGYLKyn1Y1DwsxcTvplkn6ebBFY54aaF
         iObbF+DU4y0tN09jX/UvMxJxOrXwhtn85CQyECkFc4GExxHjecJa40VZBSMG8VBl3rGu
         OAgjkCLDTNN7JkfWJzMbFXZG2+B0PGIAQ2XCa3OSWS+A7DeUDPv3sOJI3ONU9WZEeZEF
         C3b0X1oIMg6SET3mOy7YubeTlugkDMdbfRDBknrYBjiWIHtB4zRDA/4x3LraZzmQFGMc
         w/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105125; x=1706709925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKT/SovjmMKybGM+TsighIhEsthz6eW5SOAgfqxWmW8=;
        b=NJWjYF/vWVe7N72UUT3w84LBmwxHswCNtNYHqRWy4KoUzxQcA0Q47KU6SKUnwygp2S
         LBNl8ReHXux/H39I5vBpNTfmCy1sxGZfe4R/yuoqKhH5xU1CxuQzKcOl30Aox6PqxLGb
         B6Vk5QEzWmpd92E/9q9Q4q40ey4ZxtVQCpsJcQeIm2abrAiiodjaVN2rNQJ+pdAwE9ju
         cNi6dLsmiqKrJFIuDPSjXgrWUhreDVm1VDa9BjgHTnFEJ+XkhMQ9Bl8/tZ/4lTZMMckM
         mm8CIUmsNWrpioXQ5EQT1lqZ5HpCLln15MQ+fYQhjVFcq6OBfLZFAVNK0IdQ9/4rACMj
         xGeQ==
X-Gm-Message-State: AOJu0YyCvqa1aBx7UlUIAXygKgTO1fo7vkamEut439GUerWK3bDRHSmY
	Ye9sH7RRLGXILAZjFCm8fV5rPcdLKIn76VvxgjqrsRJI5dQqGzVNHe/NDKthV2tSOBtY8+VCsJO
	lDXM3+JfiBUXoAgq4kXYY2ReYdR8=
X-Google-Smtp-Source: AGHT+IHiS6Y1aNjvrdXQ2o2Y/Zml8pOm9KPLusAP0wFIn484RmL2qBhO9OghbJQngeEf0+GSJE1zp7oom3EwF+rCc14=
X-Received: by 2002:a05:6402:4310:b0:55c:bffb:1308 with SMTP id
 m16-20020a056402431000b0055cbffb1308mr721192edc.15.1706105124683; Wed, 24 Jan
 2024 06:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com> <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com> <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <d864c378-3b4d-41f2-bb21-d3403db55cbc@redhat.com> <CALXu0UcUUmVSih6LfCTHWKZA_Czfv5f=MM_cQE_HsGXtuq2y1Q@mail.gmail.com>
In-Reply-To: <CALXu0UcUUmVSih6LfCTHWKZA_Czfv5f=MM_cQE_HsGXtuq2y1Q@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 24 Jan 2024 15:04:44 +0100
Message-ID: <CALXu0UfQzHA7MZ76ETRbMksSqBsP8zc+cf9EBLi80BgqNh1o6g@mail.gmail.com>
Subject: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Martin Wege <martin.l.wege@gmail.com>, 
	Chuck Lever III <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Sun, 19 Nov 2023 at 18:17, Cedric Blancher <cedric.blancher@gmail.com> w=
rote:
>
> On Mon, 13 Nov 2023 at 16:48, Steve Dickson <steved@redhat.com> wrote:
> >
> > Hello Ced,
> >
> > On 11/12/23 8:01 PM, Cedric Blancher wrote:
> > > On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> > >>
> > >>
> > >>
> > >>> On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> =
wrote:
> > >>>
> > >>> On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.leve=
r@oracle.com> wrote:
> > >>>>
> > >>>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmai=
l.com> wrote:
> > >>>>>
> > >>>>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle=
.com> wrote:
> > >>>>>>
> > >>>>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gm=
ail.com> wrote:
> > >>>>>>>
> > >>>>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@g=
mail.com> wrote:
> > >>>>>>>>
> > >>>>>>>> Good morning!
> > >>>>>>>>
> > >>>>>>>> Does anyone have examples of how to use the refer=3D option in=
 /etc/exports?
> > >>>>>>>
> > >>>>>>> Short answer:
> > >>>>>>> To redirect an NFS mount from local machine /ref/baguette to
> > >>>>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
> > >>>>>>> /etc/exports:
> > >>>>>>>
> > >>>>>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> > >>>>>>>
> > >>>>>>> This is basically an exports(5) manpage bug, which does not pro=
vide
> > >>>>>>> ANY examples.
> > >>>>>>
> > >>>>>> That's because setting up a referral this way is deprecated.
> > >>>>>
> > >>>>> Why did you do that?
> > >>>>
> > >>>> The nfsref command on Linux matches the same command on Solaris.
> > >>>>
> > >>>> nfsref was added years ago to manage junctions, as part of FedFS.
> > >>>> The "refer=3D" export option can't do that...
> > >>>
> > >>> Where in the kernel is the code for the refer=3D option? I'd like t=
o get
> > >>> some of my students to contribute support for custom NFS ports.
> > >>
> > >> IIRC supporting ports is one thing we can't do right now because
> > >> the mountd downcall interface is text-based, and its parser can
> > >> barely handle "refer=3D", let alone specifying a port.
> > >
> > > I had a chat this weekend with Roland Mainz (who works on the NFSv4
> > > driver for Windows these days):
> > > ...
> > > That is the old mistake to think that "hostname" and "port" are
> > > separate entities. We had this kind of debate at SUN/MPK17 several
> > > times. Host and TCP port are the "location of the server", and they
> > > are inseparable.
> > > ...
> > > The RFCs even help out with that one, for example RFC1738 (URL RFC)
> > > defines a "hostport" in Page 18.
> > > And that's what I actually did for ms-nfs41-client: NIH&Institute
> > > Pasteur needed custom TCP server ports, and I implemented this by
> > > changing the communication of nfs41_driver.sys (kernel) to userland
> > > NFSv4 client daemon (nfsd_debug.exe) from "hostname" to "hostport",
> > > and added the port number in the UNC, so Windows always uses (and
> > > remembers!) the port number together with the hostname.
> > > Or easier: I changed "hostname" to "hostport" to embed the port numbe=
r
> > > in the up-/downcalls for mount requests - and that is what the Linux
> > > people can use too.
> > > ...
> > >
> > >> Our plan is to replace the mountd downcall with a netlink protocol
> > >> that Lorenzo is working on, and then it would be very straightforwar=
d
> > >> to add a port to each target location. But getting to a mature
> > >> netlink implementation will take a while.
> > >
> > > Yeah, instead of waiting for NetLink you could implement Roland's
> > > suggestion, and change "hostname" to "hostport" in your test-based
> > > mount protocol, and technically everywhere else, like /proc/mounts an=
d
> > > the /sbin/mount output.
> > > So instead of:
> > > mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> > > you could use
> > > mount -t nfs 10.10.0.10@4444:/backups /var/backups
> > >
> > > The same applies to refer=3D - just change from "hostname" to
> > > "hostport", and the text-based mountd downcall can stay the same (e.g=
.
> > > so "foobarhost" changes to "foobarhost@444" in the mountd download.)
> > My suggestion is you and Roland attend the next Bakeathon, this
> > spring, which will have remote access for testing and
> > talk about this on one of @2pm talks.
>
> Where is the bakeathon hosted? San Francisco?
>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur



--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

