Return-Path: <linux-nfs+bounces-1308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7483AB58
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 15:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BD51F21E6D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE47A707;
	Wed, 24 Jan 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV0sPz0E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D277F3A
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105166; cv=none; b=Eb/hji7KMXcI5fx4eTsSSTZJCjy5ylCyuO+TkdSfDZKJBsAP2+vF5S4VOZGvF3U7dk4b4hC7PF++3pix7ndAFzOHSCA+gO6LLPRCoQJ4bQ2KgxCnteWafd5qOM8brpRzZb5zmnmrhSYW1raMwiq/W+PYpPQYBczxNLdXFcOalnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105166; c=relaxed/simple;
	bh=JhJajn1dlRnhQIzzLtUNOavOaD/8QtUQ8+ibIesZnws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZR+jpXfWGHW73LCQ0rdxAbchO6FApLuFV+mFWim7uJVylkAtFTWwNKHO8w62Q/wYwwVEJiVd0a6nq7jyBIkoVumF+flLu+WV85HBqMYsw+tePF4kjbw95T5OAsEPozu9DbSuqNTr8jle0KeAHYdN8+vOZITrj8ok6jU8eXO3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV0sPz0E; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so9958260a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 06:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105162; x=1706709962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhJajn1dlRnhQIzzLtUNOavOaD/8QtUQ8+ibIesZnws=;
        b=BV0sPz0ERpTD77RV9F8u1+p9jXRjcT/qj28bIoWIfdJcd25OIqOuTmKKnDDulUOkMh
         pxXwwPebQZ7pmA84IquRyeXQrrKNr+5bKF6tLFnx+Jngbg9xxoQ/ToQzr30sYLjw1/F/
         S040i6c2LjEtjAOd0w6RfkGHumwilS1cwMQBwSzqjII4emRsS/Y1L9EPDi/5jTzp1+FN
         Rm1v2BSj5c4OwppLM4w7TGcC+KNbQJwvSQat1ghgJs45jVMl3PwCsvig6CuCz+HwOD/q
         E8Bzdz5mcsZQqa4AE4YnAqzrHJXWaxWCRheYpqjE5q+T3ms82h9HoSzeJfUaq1jfH5+v
         JmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105162; x=1706709962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhJajn1dlRnhQIzzLtUNOavOaD/8QtUQ8+ibIesZnws=;
        b=ieGjDf2ZqeuoYVE0eyBAmwtYVs1Xjp4SzfKFHaUkky6n1WqOzHtdWVbUKSFMwSIpAv
         LqD+chDoM3yMNBfuIPHjkjxNcu+c3sIYy+sFXoKYoooinZTBJAbGQQuO7CRkC2kFIieV
         /JAPHkEvbI8NWm0HYtBgkMZIFvMf+jDzahLqEv5Rvl/9Kd5hWtkxkxUeNiBUlNFG9UTL
         BnSmJO163gHNGWI67qK8wmbO6dd96ZBB+5yOzofZ/ReknNxgm5MzjaWrrp9cWIxwonfW
         zFdIOP1p0s7TBSGU5NUoi2W7XkQDAoTSgLUQxmnns0Mn/JzFTtMiPNN8wqAqi0mOxTbx
         A2/A==
X-Gm-Message-State: AOJu0Yx6yGh/xFSbf8UtLhMbGz4G4ihABQCg9FK1YhNOSGIO5IdBebcO
	o+bemH/komiXx1utjO7mauFy9KOYZKPkpEhYhO/gpV+cqOulZvDTDW7m29Lbob/+VKhUkwbm5Lb
	WsBTeBhmrrGm/ljLwbI+NuK5HE29CdVCF
X-Google-Smtp-Source: AGHT+IERe4gorQFDJ7x6nq5gum9w2jgKgWlPMKKMFJ2fXRNk0f12S2O1DOVdt2xqDyyR1cvmwN/o0lUQGKg/fXYz6pI=
X-Received: by 2002:a05:6402:350e:b0:55c:a84b:ca58 with SMTP id
 b14-20020a056402350e00b0055ca84bca58mr1827955edd.18.1706105162260; Wed, 24
 Jan 2024 06:06:02 -0800 (PST)
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
In-Reply-To: <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 24 Jan 2024 15:05:26 +0100
Message-ID: <CALXu0UcoxTNM7DnevRmPR7iKynp9RCLQvoe4uS=NVkpRiHAUTQ@mail.gmail.com>
Subject: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Martin Wege <martin.l.wege@gmail.com>, Chuck Lever III <chuck.lever@oracle.com>, 
	Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Nov 2023 at 02:01, Cedric Blancher <cedric.blancher@gmail.com> w=
rote:
>
> On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
> >
> >
> >
> > > On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> wr=
ote:
> > >
> > > On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever@=
oracle.com> wrote:
> > >>
> > >>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.=
com> wrote:
> > >>>
> > >>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> > >>>>
> > >>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmai=
l.com> wrote:
> > >>>>>
> > >>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gma=
il.com> wrote:
> > >>>>>>
> > >>>>>> Good morning!
> > >>>>>>
> > >>>>>> Does anyone have examples of how to use the refer=3D option in /=
etc/exports?
> > >>>>>
> > >>>>> Short answer:
> > >>>>> To redirect an NFS mount from local machine /ref/baguette to
> > >>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
> > >>>>> /etc/exports:
> > >>>>>
> > >>>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> > >>>>>
> > >>>>> This is basically an exports(5) manpage bug, which does not provi=
de
> > >>>>> ANY examples.
> > >>>>
> > >>>> That's because setting up a referral this way is deprecated.
> > >>>
> > >>> Why did you do that?
> > >>
> > >> The nfsref command on Linux matches the same command on Solaris.
> > >>
> > >> nfsref was added years ago to manage junctions, as part of FedFS.
> > >> The "refer=3D" export option can't do that...
> > >
> > > Where in the kernel is the code for the refer=3D option? I'd like to =
get
> > > some of my students to contribute support for custom NFS ports.
> >
> > IIRC supporting ports is one thing we can't do right now because
> > the mountd downcall interface is text-based, and its parser can
> > barely handle "refer=3D", let alone specifying a port.
>
> I had a chat this weekend with Roland Mainz (who works on the NFSv4
> driver for Windows these days):
> ...
> That is the old mistake to think that "hostname" and "port" are
> separate entities. We had this kind of debate at SUN/MPK17 several
> times. Host and TCP port are the "location of the server", and they
> are inseparable.
> ...
> The RFCs even help out with that one, for example RFC1738 (URL RFC)
> defines a "hostport" in Page 18.
> And that's what I actually did for ms-nfs41-client: NIH&Institute
> Pasteur needed custom TCP server ports, and I implemented this by
> changing the communication of nfs41_driver.sys (kernel) to userland
> NFSv4 client daemon (nfsd_debug.exe) from "hostname" to "hostport",
> and added the port number in the UNC, so Windows always uses (and
> remembers!) the port number together with the hostname.
> Or easier: I changed "hostname" to "hostport" to embed the port number
> in the up-/downcalls for mount requests - and that is what the Linux
> people can use too.
> ...
>
> > Our plan is to replace the mountd downcall with a netlink protocol
> > that Lorenzo is working on, and then it would be very straightforward
> > to add a port to each target location. But getting to a mature
> > netlink implementation will take a while.
>
> Yeah, instead of waiting for NetLink you could implement Roland's
> suggestion, and change "hostname" to "hostport" in your test-based
> mount protocol, and technically everywhere else, like /proc/mounts and
> the /sbin/mount output.
> So instead of:
> mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> you could use
> mount -t nfs 10.10.0.10@4444:/backups /var/backups
>
> The same applies to refer=3D - just change from "hostname" to
> "hostport", and the text-based mountd downcall can stay the same (e.g.
> so "foobarhost" changes to "foobarhost@444" in the mountd download.)

This issue is still open, and BURNING!

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

