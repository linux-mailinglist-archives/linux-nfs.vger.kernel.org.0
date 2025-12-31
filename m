Return-Path: <linux-nfs+bounces-17387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6015CEB257
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 04:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52ACE3003F52
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172F23ED75;
	Wed, 31 Dec 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF1kQxev"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBB248F68
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149881; cv=none; b=PuTrjRbCFS+nA2jTVYlAF4f60T0kB5dqbWEdNXm4zye309Mg0TlPGmcFNwMs+oNCPsuQHVrV7t6LuSGNGscPf1Ih+3vx7ITHa+Sci1TmXv6lKGpl8Yocus5h4qynfzeW849kPco8i7MJ7O/h89zY2Z7bNhTJ5oscIqvtK5nOeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149881; c=relaxed/simple;
	bh=pxI8J7zrO05PeMVIn+eng3kyw/qZofUToS1ed3P7usw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GquB0wSrtu/b2YLQovXkqkY2/c+uNjDDXZEyrlHh68eLktfnPyMFCWXjILF+xqNH85/eJ0rsf09EJlOjXIfhji2xxLc7VNSM4G4X2AGttUnephiXaHoJrMp/yz+eG5Mx27wp4adDcUIPNnEISUargpbVhfI9TjlIzBuhob9A/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF1kQxev; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so14470259a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767149878; x=1767754678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teYbuoIpl0H5sNCEndMSg3lDx6nGn/3g+KdnQoN9KP0=;
        b=gF1kQxevOXiUg51FJii1CU89iV4qcgql7TwogGIKjPcXyL/BQ/SNpUnHDTq9hho5+E
         u1OwXarp4jUKvyECjG0wWdYYWeBD5deLtIdnXuTWRxZ98DB9gZ2ebPk/ibdDxkVB8sOO
         /VhHtOIifO0mIxUPJAXthhIWacq5rSIhva1DyhTWhokoBf2sBgwpbJ3ynUA8MMmzzRwC
         9Bl8dqHTlta+Vdbe7lGHOou70zORZyLwBycQv9QL5r9dw72zSIUT4zQjSisgpcz4pxbo
         UIlXFuPV6WWQ/b9Tu5VRcoqbYIFcSEL4uoQyX1AI5+w3q/bwPaY7MG3U/Yd9HKj2deYD
         6LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149878; x=1767754678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teYbuoIpl0H5sNCEndMSg3lDx6nGn/3g+KdnQoN9KP0=;
        b=vihQvympC5yT8JdO9BIFmT5qSpR9arN7BWyyfUb/qWMWspgnTqcVGcq/DpkjyRpTJ7
         JeRK8/ureoVIWQYYwsW3NIdprFjHQh3BpfvcoyFKqE6Y3Iz0C8eVYUV3eQJ2o+MkphR+
         LDUTvRwlcLa2kAb6Y0ea+9QdvP952GZe1IGziEyWN8vk2qTlcUB/4eBKPV23R+u94aAn
         POSNCdm2dYodAp/Ivdmrc1ENXn0lEN4Sl/CYMr9xDwUhgaT/XuMPYFL+YzzlvksNZ20c
         wjeyM4x/tKDBtNBGuDY6zTTSlSqv0M1+XHty/kOgVXY1dnIaYqHi+qV8Az3o3xjEz1Y1
         D2pg==
X-Gm-Message-State: AOJu0YxFtf2MUAjl6sDVEAmH4LdWYmE5Ye67465B+Xd7C6aw8dBZjZze
	9oIN3V+rUspuq5Q9ao7CFdzsPITQK0aUBTqWZWfdF/oCF9w5vqsXX7xcQypRT2IDQzNfSZ9Nso9
	M83q2MAQjeNKpjxOG7XnGqN5mFkDr1g==
X-Gm-Gg: AY/fxX4km1xxRz5iCjZUSfiG8GxJ8K7GWK7Vjo6X2m1DJ3yKevuBp8GwANPbOFPIJZQ
	oAeokcN46iyr4ft3nOkKIvUNDkHSmV99JLAEhy1Q/t36/XNqBZ6hcbrWUjMAciiciayIBh12t29
	iomA6Hdz5AdtG69LhlAKOTBO18pL+CGO0rejSBAYin+BnEHbJ1i9E6X7Pn/i6qYNNbrwZLtUpQe
	avR5jExZ/oEfyhCj/k3kMCk7o9sMRWyIe2u9yZqAgzaKdDAr5wyggcAU+P6TqaT9S3mVfI+feIH
	GibIMP1yjTildeZX1X0Hj3APXA==
X-Google-Smtp-Source: AGHT+IF5wSBngun9/xWzw1CRYGqUM5BEhT7+O9rqK4WhbeODxlBmO/tVTfYa4csTJbn1wX1rPMTozp8fKnfbhBXavP4=
X-Received: by 2002:a05:6402:1e96:b0:64c:7903:afe5 with SMTP id
 4fb4d7f45d1cf-64c7903b3b6mr30307687a12.26.1767149877787; Tue, 30 Dec 2025
 18:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231022119.1714-1-rick.macklem@gmail.com> <5045ae28-4f2d-4d57-b6c3-523e8bbd99cd@app.fastmail.com>
In-Reply-To: <5045ae28-4f2d-4d57-b6c3-523e8bbd99cd@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 30 Dec 2025 18:57:46 -0800
X-Gm-Features: AQt7F2oCDzNoXFa5BW4RNZwk78aj9QU9lO-fxlww5c7lppdHBnSDLvyNM6s-DFE
Message-ID: <CAM5tNy4DTNV18Fyfj8bVGcrY0ZY3zPtWHXVf5q1zZ0d+hfuAKw@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] Add NFSv4.2 POSIX ACL support
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Rick Macklem <rmacklem@uoguelph.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:48=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Dec 30, 2025, at 9:21 PM, rick.macklem@gmail.com wrote:
> > From: Rick Macklem <rmacklem@uoguelph.ca>
> >
> > The Internet draft "POSIX Draft ACL support for
> > Network File System Version 4, Minor Version2"
> > https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/
> > describes an extension to NFSv4.2 so that POSIX
> > draft ACLs can get acquired and set directly,
> > without using the loosey NFSv4->POSIX draft mapping
> > algorith.  It extends the protocol with four new
> > attributes.
> >
> > This patch series implements the server side of
> > this extension for the knfsd.  It is analogous
> > to the NFSACL protocol used as a sideband protocol
> > for NFSv3 and allows the ACLs to be acquired/set
> > be getfacl(1)/setfacl(1).
> >
> > The current implementation does not support the
> > "per file" scope, where individual file objects
> > store/use either an NFSv4 ACL or POSIX draft ACL
> > and assumes POSIX draft ACLs are supported for an
> > entire file system, if support for POSIX draft ACLs
> > is indicated.
> >
> > Rick Macklem (17):
> >   Add definitions for the POSIX draft ACL attributes
> >   Add a new function to acquire the POSIX draft ACLs
> >   Add a function to set POSIX ACLs
> >   Add support for encoding/decoding POSIX draft ACLs
> >   Add a check for both POSIX and NFSv4 ACLs being set
> >   Add na_dpaclerr and na_paclerr for file creation
> >   Add support for POSIX draft ACLs for file creation
> >   Add the arguments for decoding of POSIX ACLs
> >   Fix a couple of bugs in POSIX ACL decoding
> >   Improve correctness for the ACL_TRUEFORM attribute
> >   Make sort_pacl_range() global
> >   Call sort_pacl_range() for decoded POSIX draft ACLs
> >   Fix handling of POSIX ACLs with zero ACEs
> >   Fix handling of zero length ACLs for file creation
> >   Do not allow (N)VERIFY to check POSIX ACL attributes
> >   Set the POSIX ACL attributes supported
> >   Change a bunch of function prefixes to nfsd42_
> >
> >  fs/nfsd/acl.h        |   3 +
> >  fs/nfsd/nfs4acl.c    |  35 ++++-
> >  fs/nfsd/nfs4proc.c   | 126 +++++++++++++++--
> >  fs/nfsd/nfs4xdr.c    | 312 ++++++++++++++++++++++++++++++++++++++++++-
> >  fs/nfsd/nfsd.h       |   8 +-
> >  fs/nfsd/vfs.c        |  34 ++++-
> >  fs/nfsd/vfs.h        |   2 +
> >  fs/nfsd/xdr4.h       |   6 +
> >  include/linux/nfs4.h |  37 +++++
> >  9 files changed, 536 insertions(+), 27 deletions(-)
> >
> > --
> > 2.49.0
>
> Thanks for posting, Rick!  What branch/tree/commit did you base this seri=
es on?
Oh, and the piece that is missing is the tracing stuff. I need to figure
how that's done and was hoping to leave that for a separate patch series?

rick

>
>
> --
> Chuck Lever

