Return-Path: <linux-nfs+bounces-11856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63317ABFFB1
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 00:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55653A84C9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 22:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340D239E94;
	Wed, 21 May 2025 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHXSci1o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F971754B
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867102; cv=none; b=S4DNJLIQJIkl0vn6QAGcBzkvfkhC4aSYXSWPsi0ndumeEggwInFBTCsrjZ/yXAMV43al3aAuAPhx3aIJSl3GVWGJ0GG8fe+ug4Tq3vzBgvPjrnVZpDTm6DnEf55ueQ+wEtanBg4b8BBSMXoZjmJLIlLciv7qo489sI6gCktDiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867102; c=relaxed/simple;
	bh=lkmYfYalRQ7SIVlGkEeQtTQEjLulLpWdiiBfVjWlZ08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzfUEnauGSKj5et0ruE8UfRQYTgfGaNSEey+sL8HbcSZcFP8T4Wr6k6BA3v8ZsZ+eWG+JGlehTQcNdpjHGJ/JsOSYKkUUjic9gez+VKHnQYaCuKiQVkXQ0wbc1AzkLQOJnx+hVbextHHxoXvw3OuWT5UbJU9GMQRGsBXL2SL8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHXSci1o; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601d66f8cafso6239587a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747867099; x=1748471899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkmYfYalRQ7SIVlGkEeQtTQEjLulLpWdiiBfVjWlZ08=;
        b=jHXSci1o+ucNs6+EUIRn7OX9Y2tK0SZq+Engrpx6YE/L4Wc6J0YVDonSS59hzZYfy5
         2kVBQxThUukUQc63FejPnPqbZqteR9A3i1o99HaMlly1vy61CxHNhn1c/bkzfAP0mTnJ
         ro0hbx3iQtrQiAgediObtuKKmdeFARrPGzphC5LlAjpsw/F7btdYgw3GOWeNm+dfwBSo
         R1REY2eRbRjjQthPDfHtMCd920Z7mThwHYVPKi2ykCPDbyr5P8i8bGXeupBf030iTQDa
         ioJUBiHSkCdKCEpat7RR9sU6ndav0KBVzYsm5Co/eaHfM54Uv7bFliIRXqp5pvHB2ovh
         7Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747867099; x=1748471899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkmYfYalRQ7SIVlGkEeQtTQEjLulLpWdiiBfVjWlZ08=;
        b=CLtyfonCFeoUSMu7lhVMin7szbSD31hmGT087anp8GibAK0pS9hk6O6I2iux1FVpAy
         rTLBHkrCqBlLYtiVlvUNP5J2GJKt3V/7qttimkc3UzIU1xWNjQ1gC58ylGf5pfxL1KHP
         1N6NYRKx0QYxuzDPo9EU5sZ4qNdcvaoBdkvyy2RUoMz1pLbF+qTzel9PeQxGWn3tyN9a
         VyJDAquRHC37rUG4zTiwitk7wtCJoaI0tqGewrdaPpvYIMkbRNbPQGkiOJKIX5FhjVCt
         hk8eBJPTiW4FB8/hPv6EET0ybIKmvbV3bUSlqiqpTXjrWvCyJwxCup723tqOCT8viDup
         s/zw==
X-Gm-Message-State: AOJu0YywVAhUnLbHVn5PIAnlP6WGzn9SFvi2XAOY2pZh71txx4aO9NvL
	E/NwqD8jNCKiTKWLPFApgrPetE1cFsSMDXrxdfZKbAj24jn4J8eG9xN+CKwezFEoYp92xVdJojA
	MSaxPJvDQEFY52XtGuT7U7aJYSAE5EwEz2zTrhw==
X-Gm-Gg: ASbGncuCpQy6LVBQpAisOBfN1ZFC7JJ4HG2t2CZiC4fphQOD6//HVtI5PyC3hQigIj/
	d1VFf1Za6BZ5t9Gji32jEs15e3TfZOTgNkRp3fEd+g+T++5RGNrczxvHe+KUt/LDVLNF7Q+kCN/
	kH5+PcXWJGE+tCamyHIG8O3yEldLVZx3C1ecgusk7oYjnrZMLC713bIW7Q0EfMSm0=
X-Google-Smtp-Source: AGHT+IGkSSZEuMewGtPAQUOI5W+yj0JrfEI5MuvwDwlOj4iMgNyc3rExr+LfpPXm92IwJ7LX5fo+YaEA9Ncv4ZokwEE=
X-Received: by 2002:a05:6402:27d1:b0:602:2a0f:eae with SMTP id
 4fb4d7f45d1cf-6022a0f0edcmr4901044a12.14.1747867098403; Wed, 21 May 2025
 15:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com>
 <CAPJSo4VU8UP1bzT=FssnBU2EAtLmVoKg4icxLA6bXmNUNtVF_A@mail.gmail.com>
 <CAM5tNy61mcXY8LoP-Ve2L7Qpb8pmtb=+MyfC5Q=otq7_Bc19CA@mail.gmail.com> <CAPJSo4UFPbwaO3=rwSOvG72EFrye8W3i3s+ztFJ8_DBY62zjjA@mail.gmail.com>
In-Reply-To: <CAPJSo4UFPbwaO3=rwSOvG72EFrye8W3i3s+ztFJ8_DBY62zjjA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 21 May 2025 15:38:04 -0700
X-Gm-Features: AX0GCFueEkV1H0HL9qANH-0KMno0JfLgV2apnzf8mRlYB9uSQacIqPMF4_MF-N8
Message-ID: <CAM5tNy5_=YuyHfUNeVjYNEC=hoV7TxJS4St+=Q9WdzpuK3H1=g@mail.gmail.com>
Subject: Re: NFS/TLS situation on Windows - Re: Why TLS and Kerberos are not
 useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the
 default for all exports
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, libtirpc-devel@lists.sourceforge.net, 
	ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:07=E2=80=AFAM Lionel Cons <lionelcons1972@gmail.=
com> wrote:
>
> On Tue, 20 May 2025 at 03:38, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Mon, May 19, 2025 at 6:03=E2=80=AFAM Lionel Cons <lionelcons1972@gma=
il.com> wrote:
> > >
> > > CAUTION: This email originated from outside of the University of Guel=
ph. Do not click links or open attachments unless you recognize the sender =
and know the content is safe. If in doubt, forward suspicious emails to ITh=
elp@uoguelph.ca.
> > >
> > >
> > > On Thu, 15 May 2025 at 04:09, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > > >
> > > > On Wed, May 14, 2025 at 2:51=E2=80=AFPM Martin Wege <martin.l.wege@=
gmail.com> wrote:
> > > > What other clients are there out there? (Hummingbird's, now called
> > > > OpenText's NFSv4.0 client. I was surprised to see it was still poss=
ible
> > > > to buy it. And it probably can be put in the same category as the M=
acOS one.)
> > >
> > > Situation on Windows:
> > > 1. OpenText NFSv4 client: We've talked to Opentext about TLS support,
> > > and they do not know whether a market for NFS over TLS outside what
> > > they call the "Linux bubble" will ever martialise. There is also risk=
,
> > > both engineering and drastic performance degradation if the Windows
> > > native TLS is used (this is a kernel driver, so only the Windows
> > > native TLS can be used).
> > > So this is not going to happen unless someone pays, and the
> > > performance will not be great.
> > >
> > > 2. ms-nfs41-client NFSv4.2 client: I've talked to Roland Mainz, who i=
s
> > > working with Tigran Mkrtchyan on ms-nfs41-client (Windows NFSv4.2
> > > client). Their RPC is based on libtirpc, and if steved-libtirpc gets
> > > TLS support, then this can be easily ported. But Roland (didn't ask
> > > Tigran yet) doesn't have time to implement TLS support in libtirpc.
> > >
> > > 3. Windows Server 20xx NFSv4.1 server: Other department went through =
a
> > > cycle of meetings with Microsoft in 2024/2025, so far Microsoft wants
> > > "market demand" (which doesn't seem to materialise), and cautions tha=
t
> > > the performance might be below 50% of a similar SMB configuration,
> > > because TLS is not considered to be a good match for network
> > > filesystems.
> > >
> > > Summary:
> > > Forget about NFS/TLS on Windows.
> > Well, for #1 and #3 I'm not surprised and would agree.
> > I would like to find a way forward for #2.
> > I will take a look at the libtirpc sources and try and cobble to-gether
> > a prototype using the OpenSSL libraries.
>
> That would be awesome
>
> >
> > I am not sure how helpful that will be for Roland, but it might be a
> > starting point. (It depends upon what Microsoft provides in the kernel
> > w.r.t. TLS and whether the driver uses a libtirpc library built from so=
urces.
>
> If it works with steved-libtirpc on Linux, then it should work with
> the libtirpc from ms-nfs41-client too.
Hmm. Maybe I will put the function calls that would do upcalls in and
then write a simple set of them that do the OpenSSL calls. I need to
find out more about how the driver does RPCs.

I'll try to look at the sources on github.

>
> Question is whether the openssl license is compatible to LGPL used by
> ms-nfs41-client
I don't see why LGPL'd code cannot link to non-GPL'd open source, but
I'm no lawyer. (When this is done, it will only be attractive to those that
want RPC-over-TLS, since the TLS libraries will need to be linked into
the app. using the libtirpc, I think? (I don't understand library versionin=
g,
so I don't know if there is a way to avoid this when apps. don't want
RPC-over-TLS?)

The question is what TLS libraries are normally used for Windows?

rick

>
> >
> > I do plan on posting to the mailing list for #2, since I did a short
> > test drive of the driver.
>
> Thank you
>
>
>
> Lionel

