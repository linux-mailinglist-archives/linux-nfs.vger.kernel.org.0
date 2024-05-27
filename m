Return-Path: <linux-nfs+bounces-3397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06FA8CF8A7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2FB1C20D68
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB24C13C;
	Mon, 27 May 2024 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHy+RGSg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C6C129
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787010; cv=none; b=dXojYOJTAERSdYHWFnYcPiejdUzNYkgd2Ot1uG2uBF5WJ21bsUl+YXaXbDBJO4jIbQ/O6eFpwwhsmbpVFHJN0xgR5XhxQ0bAacrI6CldPpDfUu3reHqrd63s5SCANNtPhtrfUC35MgvHJEHHu9FvLf3QHGIPvGsZmeC6ktq4Sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787010; c=relaxed/simple;
	bh=8xjr+6gD39/RyHRK4PnWLLjvDiEm9gbM6BhUoUc00CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VSZElTnmFwTn0I1vkBmMqATS2G3ckQfvqroEGnGKV7MiN0kFx0eHVNkLbSBp75l6v4FMHjT8VOfhAm+ZYVkB0THm+M96eRdUyX+9GUhGRTTTib3x4Mr0LK8N/xl8yhV1lBFHG2Dv9volD/CluW7hbkn3AQ1B5xeSZZYCLKgpoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHy+RGSg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529b22aabc1so257184e87.2
        for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716787007; x=1717391807; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xjr+6gD39/RyHRK4PnWLLjvDiEm9gbM6BhUoUc00CE=;
        b=bHy+RGSg4INxISa949pOZz9FOoWaC/g9rG4NP64DcL8mByI0QU77/32N/VASUzsySm
         fvfMLiC+fGUyNdAbF+ykKS2I0MgQo+lRuCdsPfRi0WTT00FoT8rcD7SVE6pcary9F4qm
         4Jf5z/bfz0DN+xppLTHTbHE1X9Ca99Ixo6BBivkv0x5t8mai87DBv17+a0/5CiuGoWLZ
         YO/UKPxqaYxhJnvwVj0ipFfEKIeu+hAKft+tegSJZrXYbaRGZvTQc+m9t1k81pEQ4xpJ
         aDinAbxdh4848H9N9h3O9Whj+5hX3vo9oez51RKKASOpnzVDJ+HSdhfaac4SL/SdbAYb
         8ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716787007; x=1717391807;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xjr+6gD39/RyHRK4PnWLLjvDiEm9gbM6BhUoUc00CE=;
        b=aK2blJRTTjx0e0pU2S0bh/eud9ltqFimsTEiQog1CtDfMx3JY242Zh/NshI1ur2VzG
         PkUeLK2al6k/XCbfGYhZVTMpHQy/mKllA0MJgNl8qIHQNb1HSdAMUa17G3LDONWzb3x8
         u1NG1Q+/TNoUo3Ai3IM3HXV4mOUPO6Od71K0VVwj8YjhEoX92ZGX1zZp1NWa4axMYO8l
         c/t152tEkCUBLqN126RbxA21rArJb2krwb7dH+C3ZkhccWqIwI3D/UGtaMPtcwjSzcmV
         UlR+MXbsRWj3abc3JwqefKumO2DugZxfWztVn301EMJ2Jqy20a7d2uUImJ1Hc/LcfOiw
         e1nQ==
X-Gm-Message-State: AOJu0YwvMVYP0eJ6msWJNa77h6e+KtzxsOcsRMhcT5obLrAhI+yHOfQ2
	uSsgvtl6OhLdNvYQGFGyP01fhpaenof2Q3wRFvRAgZZGhz1bwCblY63aPQZ6NVUdVQ/wXUpYQa6
	wUnXyhh2aHZr+BhbjdmtIIGlR/kp/XA==
X-Google-Smtp-Source: AGHT+IFz3GIx1b1uobeo3/vb594o8lI8ubMbuATb5RVTtT2TtQiuo7E1iuuLjizJt0lPXFk6pe+qqCS8vaOE7f7QbTU=
X-Received: by 2002:a05:6512:3e0c:b0:523:93e8:1ced with SMTP id
 2adb3069b0e04-529661f2ea4mr7535154e87.53.1716787006482; Sun, 26 May 2024
 22:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com> <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
 <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org> <CANH4o6MHtYVFaciH=Xh-Ph3x_AXuiYNVmhU2akzYwbQ_MmFPcA@mail.gmail.com>
In-Reply-To: <CANH4o6MHtYVFaciH=Xh-Ph3x_AXuiYNVmhU2akzYwbQ_MmFPcA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 27 May 2024 07:16:00 +0200
Message-ID: <CALXu0UfDKQsbL2aTZwaBv3uVT3BAys3cWxMObZRt_xi_M9VM9Q@mail.gmail.com>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 26 May 2024 at 16:13, Martin Wege <martin.l.wege@gmail.com> wrote:
>
> On Sun, May 26, 2024 at 1:28=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Fri, 2024-05-24 at 19:11 +0200, Dan Shelton wrote:
> > > On Wed, 15 May 2024 at 23:46, Steve Dickson <steved@redhat.com> wrote=
:
> > > >
> > > > Hey!
> > > >
> > > > On 5/14/24 5:57 PM, Dan Shelton wrote:
> > > > > Hello!
> > > > >
> > > > > Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, w=
hich
> > > > > provide platform-independent paths where resources can be mounted
> > > > > from, i.e. nfs://myhost//dir1/dir2
> > > > >
> > > > > Could Linux /sbin/mount.nfs4 support this too, please?
> > > > Why? What does it bring to the table that the Linux client
> > > > does already do via v4... with the except, of course, public
> > > > filehandles, which is something I'm pretty sure the Linux
> > > > client will not support.
> > >
> > > This is NOT for Linux only. Every OS has its own system to describe
> > > shares, and not all are compatible. URLs are portable.
> > >
> > > >
> > > > So again why? WebNFS died with Sun... Plus RFC2224 talks
> > > > about v2 and v3... How does it fit in a V4 world.
> > >
> > > This is NOT about WebNFS or SUN, this is to make the job of admins ea=
sier.
> > >
> >
> > I think Steve is just trying to get at the use-case for this. Who is
> > using nfs:// URLs in their environment, and why? IOW, how will adding
> > this make things better?
> >
> > Then there are the more practical questions:
> >
> > - will this require kernel support? If I mount using a nfs:// URL,
> > should I expect to see that in /proc/self/mounts, instead of a
> > host:/export ?
> >
> > - do you need support for public filehandles? Those were largely
> > ignored by most NFS implementors, including Linux. That opens an
> > entirely separate can of worms.
> >
> > I'm happy to consider patches that add support for this (including
> > documentation), but I'd need to understand why this is a material
> > improvement over the traditional ":/" syntax.
> >
>
> No, traditional syntax is :\, traditional syntax is UNC form,
> traditional syntax is GUI with hostname and path fields. No,
> traditional syntax are options -H hostname, -P path.

There is another use case for URLs: Unicode characters in hostname and
path. Not really applicable in the US, but the french frog eaters and
CJKV (Chinese, Japanese, Korean, Vietnamese) would find that useful.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

