Return-Path: <linux-nfs+bounces-17395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B5CED966
	for <lists+linux-nfs@lfdr.de>; Fri, 02 Jan 2026 02:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E27C3006A80
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 01:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4213B5AE;
	Fri,  2 Jan 2026 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfnE+7jl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C2482EB
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767316375; cv=none; b=krCXqHulpSL9Qvc8ZUDNcT+qQoIYtdy6dJEqN1Ttj2rR3p8sywD/991CEUMywlGka7Hskqltbyh90n9PKdyopcmoj8gWWI5/cZNJGIOvTzoMSIYIyeD4lg4cbGzC2ReC5dJorQB4IK7Y1eJV6gzjnf/w+Ge6Ej/OuK32UvT0bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767316375; c=relaxed/simple;
	bh=QI0+9Mh9Vc4jZT/76ilegL0uRbqec9Y1VwSdraqUXLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhonN7Rq7omW5Mmx3VjTJc7cbAeQNRICLK0YMM+jzCPSGX92dZUvunSKGG4hKNEUuSEfGyQcLuwsme5TWw2qW0UFmB/BnxFKSi3+aKqGste9ym9Lf69exzf5j+70hIJnv6uI8I+8uy9Xq3mLEQhfUuym3NTlvQl7rUX4yMKebDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfnE+7jl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so16016283a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jan 2026 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767316372; x=1767921172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI0+9Mh9Vc4jZT/76ilegL0uRbqec9Y1VwSdraqUXLY=;
        b=QfnE+7jl+o5Rewv7XQiLSCmYmF4QivVwegUWNvq96b52y3j/622k+9rCFaaeV4Qhb6
         nkgkCil1ftyFQOhRrH6xdGFQa5JpJ8U/alRgd8E/TQTrc2bZ9CWIUdI9LNt8P9123XQz
         Guzm2YylfMgp+L6Gck4pyFe+sOHv9BDHHdJ3hT+Ihdmst53dvixwawBDGj07LC0FmVnk
         uG/s/M2aWKic2xQoRYfPXo+KajpJLEY3/N6Zanx4YuAyyy7xHhPVlyrkTbsUfrtBvOD1
         YR35LM4giYKrahH3KoSEthie/LHN36+Emot2FaixYBeRo2xhr6iu+jJbhlxXWNTBOhg+
         8lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767316372; x=1767921172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QI0+9Mh9Vc4jZT/76ilegL0uRbqec9Y1VwSdraqUXLY=;
        b=ZMz3+jR85VnrIGAuL+45HRlN5Bs1SB/iSBJ1GB5+/1I94Okv04ZEF56CaHbuIJnre7
         +H8iGxbyRrRYNc5QrNRTzTyyXwobFQi7CqEFp4vHSMUgoZ0Njeylg+sLEm7vRhDueigu
         HAcS8F7ejw0/L9mZtccMnfGITwz7g0tl+UGMaoFYjYARAUvbdh02dDBVZySavxUmg/4P
         2u23zudhcCzOeIsgpnEE8HKuhroPbs/9dW0VD9iLBo9C7MV7iQ1RE8+X/RlNKyiMXUTM
         Qj2Q7AHGfi3+BKf+s1cSpqUK0c4JeLXLbUmbvziZNiM3oR96Ym8DMgB3u2mU2+c1xzHZ
         cHCw==
X-Gm-Message-State: AOJu0YxGFoy/CwboDIJFnGywJ+XIKS8b7WzEm/IFhZHzGSDNwd64rmhb
	EypC9SafbHvUAVkhYFg/cDmIRNOOwJiB1AM99hT4mHwh7joHG0ucxfDSwHSmUoxkc4lGGIlPP5q
	jH2xHsVM8dRxOaMM5vxqWb9UV5tpgJhME1rw=
X-Gm-Gg: AY/fxX7k3LWDo+uKLPRc80AiQVG9a+ORBPAVhTh/W34D3ibheKuDy8odV+X9mf4AFvb
	tHTZ77XGE6BXi9ewRgWv6AsJBVyuJvYT/LFPuZGv00YnTIYsWifIix/Lhu6HtOGnCWzV2gbZvA3
	ytl5OEH/TWVaSH7S7daGbSdcb+kDw1B9sfXoBfnXTs9fySOoA7L4RjSWtULFX0E7T5y9tjMED5m
	J+H6CCQeJc8ZrjzXHPOrxu7jOo22QKJHDFDEKv5dfa2Pwl4esVaZdoEQosIGPWkU0xDjKfx7hCY
	8P7lFk65/3gQltRMSI4c3hCpTE0=
X-Google-Smtp-Source: AGHT+IHRMnciFCxWry0lPCOf7KlfW6Sa5+16r7XmXRHI8/oABEfMLplEMUg2JVfP8pM3gSmwwRNuapGa6ViUrOa8Hyk=
X-Received: by 2002:a05:6402:2345:b0:640:9eb3:3673 with SMTP id
 4fb4d7f45d1cf-64b8e93baa1mr40443161a12.4.1767316371620; Thu, 01 Jan 2026
 17:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
 <4291447f826bb3206cc7f9d083998066f7b5471d.camel@gmail.com> <CAM5tNy5eq8C3iu6-=LHvTC1-4BdEQ+f28Tr41Oj7mJj5FXBDpw@mail.gmail.com>
In-Reply-To: <CAM5tNy5eq8C3iu6-=LHvTC1-4BdEQ+f28Tr41Oj7mJj5FXBDpw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 1 Jan 2026 17:12:39 -0800
X-Gm-Features: AQt7F2oxk3sYIIwYw1wlyzo8Vq9BqlK5LrFQIq1DFokKtBvLnmXiDmxssS5z9aw
Message-ID: <CAM5tNy4BATEpUKZTux-Nu4_vHSsbMhOz-RTrE1mfZ14Pvh6acQ@mail.gmail.com>
Subject: Re: RFC: No NFS_CAP_xxx bits left, what do I do?
To: Trond Myklebust <trondmy@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 2:36=E2=80=AFPM Rick Macklem <rick.macklem@gmail.com=
> wrote:
>
> On Thu, Jan 1, 2026 at 10:06=E2=80=AFAM Trond Myklebust <trondmy@gmail.co=
m> wrote:
> >
> > On Thu, 2026-01-01 at 08:48 -0800, Rick Macklem wrote:
> > > Hi,
> > >
> > > I'm trying to clean up the client side of the NFSv4.2
> > > patches that implement the POSIX draft ACL extension.
> > >
> > > I need to set a "server->caps" bit to indicate that the
> > > NFS server supports POSIX draft ACLs.
> > > (There is currently NFS_CAP_ACLS, but it is set when
> > > the server supports NFSv4 ACLs.)
> > >
> > > The problem is that it looks like all the bits are used,
> > > when I look at nfs_fs_sb.h.
> > >
> > > What do you suggest I do?
> > >
> > > Thanks for any comments, rick
> >
> > See the function nfs4_server_supports_acls().
> >
> > NFS_CAP_ACLS is really just used by the NFSv3 acl code at this point.
> >
> > For features that are implemented through new NFSv4 attribute types, it
> > is better to check server->attr_bitmask[] directly rather than add new
> > bits to server->caps. For one thing, that means we don't have to keep
> > several different sources of truth in synch.
> Thanks Trond. I just made nfs4_server_supports_acls() global so it
> can be called from nfs_get_tree_common() to optionally set SB_POSIXACL.
Actually, the above didn't quite work, because it resulted in the nfs modul=
e
depending on the nfsv4 one (and vice versa).

I'll just put the tests against the bits in super.c.

rick

>
> Have a happy 2026, rick
>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com

