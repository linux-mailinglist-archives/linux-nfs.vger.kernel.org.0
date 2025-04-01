Return-Path: <linux-nfs+bounces-10983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B302A78506
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 00:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CC188DFA1
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A761EE03C;
	Tue,  1 Apr 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="nVaq9hFm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3E1C863F
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548248; cv=none; b=FWhBMhDJQ8J+W/NHImunpsbFpN6dPqLiEqqE6DZwWG9O7sA/31g+tkjlDY5tc3/I4ytTWUV/dsU413xEov3g/9fvYDDKfms4kWwQwqtwtrc5egI64o9k5ODfLgziEJ6cA0x5hr8AQGK7B5Z2u9/c0Vb5EgXU1urPTAsTKhF0PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548248; c=relaxed/simple;
	bh=E5JIG4cDisnmxRq2wXENGqLDEx2MwwFQHzxJsEifGCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZEqlMdDrbgBGAIMrZyfrLQ7WzymHrSbiD+zKVPYMU8SQnjwhA04FSxJieKYK7HfXiPVRLXoyErEIAD0BrenclLXJCGqb+d5PDHBwZGRyHveWmq8PQAORTblVFYq4qLVfcl47xWIr4azc6X7Rf3+Pa7rp8nFDUWgEjAmGZs9awU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=nVaq9hFm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so59558521fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 01 Apr 2025 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1743548244; x=1744153044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNqNy09TyKWjJSzaNVkyPaBCkfKpfsvIFJUNhAjGteE=;
        b=nVaq9hFmumy0na3jQTrqfgk56CoZ1yv1bzxKYsO7b9tl0ecoBW55dNxi0hSgz1IUrx
         3hQF84SjvQ6FmySUnhQNT4t1MClDIA6AtZ8p0U3FvqIndpjDmt5MVT2VXrJyfYd5a1K3
         ww9mp4NdJ6neDhUWQGQTBRT1Z7f6FdZ8WZ4GaeuPVGu+blJI+te14DohVaQFpjnVAPLB
         +ZK7vM8UAlogfUSn7s87P3whwCFERa19WP3DBezmcixd8jHHaEYo5mPpwonK4e8tVnO/
         McwHnEl74lEKsEGnzqHY1+j052iihEXOm4E/Bcfmwl1vy9U60WsYAV/9KiRP8gkJS6gE
         Lq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743548244; x=1744153044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNqNy09TyKWjJSzaNVkyPaBCkfKpfsvIFJUNhAjGteE=;
        b=nuobkkVirdVEXtSSUuYPupy404pZaxKzHa9xCO5cSEl5SZa6lMakNAgxpYP+qur6Uz
         n4ttGoejWRKEz29bFmZo8+hOnPVCoYETRifnZbNelZwX5RnvhxF85DCZtsdmyAS5e6By
         CG80NxIZS0p+AzuBkUjVSQRkaD6Ue5Z0I59+j/6U84eRtdAw4Z26FP+qaXEJ10OledoG
         smsjoSgW9OAONiHBXirry2/vmMT5+aggu9CMSerj7DFfg2/tu+2Qj7RaIUP2m2N2m/nm
         zUZwL2GqhTBndSs2allHYyQiFpL+gT/F2ZZI0z5XOkg4Jcr04q6VieK1o48Mdsi3o1Oc
         MnSw==
X-Forwarded-Encrypted: i=1; AJvYcCV1vn8hB9tJlFRPab3krBoxByCSnOyArX8Pbj5YSs5y4ytwAzbIoHQp5SpW3M65cEKfp9kU0sayKFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLPOxR/SI9Epso3m/PRhi5WC9gChdGpteMGRJcgyyNB6n0anK
	aksr2I1s/I0sY91M7Xm+CkUcqVue354HB9w4XjG2VRlR+oGPADe58TrKf8oQSOmeL4f74f+H7vy
	SUYd0Zmbesrq8xlY0ieKIaEv4IK4=
X-Gm-Gg: ASbGncuI6WKV4jFIUWgGaxwckYa3TvcpXQPcpplImZ2MLXxx+OK4BffZpK9b3kUvHxG
	t3YKQ/JjexUOesPMBkT6LpijI36ivbBHexOxMIGurGFFYCYTjvI+aL7YiAr20Ztb972SpCnK6FT
	okyjPnMtMQZ/Ucwt5WgfnPWqAcUZUt1O7+ugmws/ACp0rpC9vFeIB3wm8DKg8=
X-Google-Smtp-Source: AGHT+IFH+fdWou5IQlnP/4r0+JoovMTbA9i/0YPCtyg3MztbHN6+q1q1nHtmEsl3hnRy9yvA4W2xbT3pg2XQtr4EObA=
X-Received: by 2002:a05:651c:30c7:b0:30a:4428:dea9 with SMTP id
 38308e7fff4ca-30de03138bfmr59265161fa.30.1743548244011; Tue, 01 Apr 2025
 15:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACSpFtDd0u3rdePuFYLZVVS0j_arvmox_z9AQTCzQva+iv8rWQ@mail.gmail.com>
 <174354624811.9342.14750814170089065011@noble.neil.brown.name>
In-Reply-To: <174354624811.9342.14750814170089065011@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 1 Apr 2025 18:57:11 -0400
X-Gm-Features: AQ5f1JpA1pIwlnt28XQ8pBLiGdpq9e5WTGiB4WSwLwccnjBvdXzprYDM9WnxNto
Message-ID: <CAN-5tyG+RGh9aO1R8XYwymP20X0xERvaARhgnQQ0--8o6wk3_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
To: NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 6:24=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 01 Apr 2025, Olga Kornievskaia wrote:
> > On Mon, Mar 31, 2025 at 10:49=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> > >
> > > On 3/30/25 8:10 PM, NeilBrown wrote:
> > > > On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
> > > >>
> > > >> This code would also make the behaviour consistent with prior to
> > > >> 4cc9b9f2bf4d. But now I question whether or not the new behaviour =
is
> > > >> what is desired going forward or not?
> > > >>
> > > >> Here's another thing to consider: the same command done over nfsv4
> > > >> returns an error. I guess nobody ever complained that flock over v=
3
> > > >> was successful but failed over v4?
> > > >
> > > > That is useful.  Given that:
> > > >  - exclusive flock without write access over v4 never worked
> > > >  - As Tom notes, new man pages document that exclusive flock withou=
t write access
> > > >    isn't expected to work over NFS
> > > >  - it is hard to think of a genuine use case for exclusive flock wi=
thout
> > > >    write access
> > > >
> > > > I'm inclined to leave this code as it is and declare your failing t=
est
> > > > to no longer be invalid.
> > >
> > > For the record, which test exactly is failing? Is there a BugLink?
> >
> > Test is just an flock()?
> >
>
> But what motivated you to perform that specific test:
>   exclusive flock over NFSv3 on a file you didn't have write permission t=
o
> ??
>
> Is it part of a test suite? Or is it done by some application? or ....

A long story. It started with xfstest failing for sec=3Dtls policy (ie
thus the other 2 patches in the series). But I saw that it's just an
flock that was failing so I stopped doing xfstest and just using an
flock. But as I started digging into the bisected patch I was trying
to understand the code and thus started using other export policies.

> NeilBrown

