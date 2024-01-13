Return-Path: <linux-nfs+bounces-1071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EE82C925
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F406D1C22B74
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9661A184D;
	Sat, 13 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKB9+7VF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6386FC2
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso5110996a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 18:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705113625; x=1705718425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNrBO26dLFKEb4E2Icae36wVQATJz4EgPpiz/a6Op00=;
        b=HKB9+7VFjjbEaCIXdVhgm/O1mwKlj8no2yO+Fi0YGIDNoDQNO/T6lUn7k9WrheGmUd
         3rdtCYcEFNeNjoi487BeAl6gdndrmVI/Hk05m4mWknZIeM40o7as0vqJSSlUyB7G0oAT
         oth0VtlWwQMe3/awnpHvGWJxKZZ+cJKs5A2TGkW+OhAzRlm7GTODVzDCn6LrHe85xUqU
         xEDLbAlOYWTNUiu3nYtm698DSLJ1H4Sy+o9E/e/L1Q1yoHxEiI8NmZZaMvyln/IvZaR5
         SdpCTI7i6h/uC39RIVM+Ky58zzQg6sHL0mC062rlpR0TbFOKc3h/8ZXXrPoVPF5dpV+g
         mNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705113625; x=1705718425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNrBO26dLFKEb4E2Icae36wVQATJz4EgPpiz/a6Op00=;
        b=iZmCQe2VjrpLQwvgzfLiqSrO9q8U8qimrkhlyw8altYAPNa8O5JqreBq7W26WTD2NL
         7U183zZv/XFa94E1YOasun4CHLTLEOFiajZzlechemUCw5guBB9BqRNGbsQE0C7mT6ej
         8rMQxw0BzVG6dBlRjxgaec4msQ0w4mfCq5TtUhQXkpYlb3aHcyW9SB5rHcnI6Omvw0Tu
         F/9vlmfg8ae04XzWfgSCNetXf+m8q37yAP3qZvXWRQPdRJLs7ehXYD6qqx+1tU2e695b
         J8swqBMkpJPPtpjT/bTNcfYxGm8FaO9DEOR2476Qwo6X/rAVpKR4bl4AGHV5H4v3/uyF
         J8VA==
X-Gm-Message-State: AOJu0Yzaxsv/dKpXnqVVCIUehnSqm2AcPVs6v2OjEjL6dqLQg39Uc+ka
	XUFjbIyX1yZO/T7USKscixWRQmR8JhmH+BNAGQ==
X-Google-Smtp-Source: AGHT+IH3/kpWrJfCQU6yNStPXEBGIYHUiBPRRYjz8ZHPlJzy54FHN3Gghhdcc9o4/bL2h65Zn9AC414Qzcmfi4kuDqM=
X-Received: by 2002:a05:6a21:6da0:b0:199:d648:7d87 with SMTP id
 wl32-20020a056a216da000b00199d6487d87mr2188198pzb.81.1705113625548; Fri, 12
 Jan 2024 18:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
 <CAAvCNcBSW7ZH4LpSLLo+Bmh2kQ=w5sFrLJ-PKDDSBKwkS5fd5g@mail.gmail.com> <BFA98D60-DBA4-4CB1-AC9C-D546B369855F@oracle.com>
In-Reply-To: <BFA98D60-DBA4-4CB1-AC9C-D546B369855F@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 12 Jan 2024 18:40:08 -0800
Message-ID: <CAM5tNy614H9T4QwWBd1DGJKhMHO-U0yrMrwzgvx33MaWqFdSPA@mail.gmail.com>
Subject: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:53=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jan 12, 2024, at 8:47=E2=80=AFPM, Dan Shelton <dan.f.shelton@gmail.c=
om> wrote:
> >
> > On Sat, 13 Jan 2024 at 02:32, Jeff Layton <jlayton@kernel.org> wrote:
> >>
> >> On Sat, 2024-01-13 at 01:19 +0100, Dan Shelton wrote:
> >>> Hello!
> >>>
> >>> We've been experiencing significant nfsd performance problems with a
> >>> customer who has a deeply nested filesystem hierarchy, lots of
> >>> subdirs, some of them 60-80 dirs deep (!!), which leads to an
> >>> exponentially slowdown with nfsd accesses.
> >>>
> >>> Some of the issues have been addressed by implementing a better
> >>> directory walker via multiple dir fds and openat() (instead of just
> >>> cwd+open()), but the nfsd side still was a pretty dramatic issue,
> >>> until we bumped #define NFSD_MAX_OPS_PER_COMPOUND in
> >>> linux-6.7/fs/nfsd/nfsd.h from 50 to 96. After that the nfsd side
> >>> behaved MUCH more performant.
> >>>
> >>
> >> I guess your clients are trying to do a long pathwalk in a single
> >> COMPOUND?
> >
> > Likely.
>
> That's known bad client behavior, btw. It won't scale
> in the number of path components.
>
>
> >> Is this the windows client?
> >
> > No, clients are Solaris 11, Linux and freeBSD
>
> Solaris 11 is known to send COMPOUNDs that are too large
> during mount, but the rest of the time these three client
> implementations are not known to send large COMPOUNDs.
Actually the FreeBSD client is the same as Solaris, in that it does the
entire mount path in one compound. If you were to attempt a mount
with more than 48 components, it would exceed 50 ops in the compound.
I don't think it can exceed 50 ops any other way.

rick

>
>
> >> At first glance, I don't see any real downside to increasing that valu=
e.
> >> Maybe we can bump it to 100 or so? What would probably be best is to
> >> propose a patch so we can discuss the change formally.
> >
> > OK. How does this work?
>
> Let's back up a minute.
>
> I'd like to see raw packet captures with the current
> MAX_OPS setting and the new larger one. Something is not
> adding up.
>
>
> --
> Chuck Lever
>
>

