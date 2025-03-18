Return-Path: <linux-nfs+bounces-10670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C7A680FB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45C78817C9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDE2147EB;
	Tue, 18 Mar 2025 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdJpewqv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19499214216
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342377; cv=none; b=fHbR07S87G/VXeYcMJdUJXCC9/JMciX+ljh6UlW41VgiXChLJoRsoiOLkjnOW9cnBmpIlZMIfxZcZ9AsHvZMnVytUuPHJcalDNw2rtxAbdiMQo0nIViyjimfhEKCLbhI4mF+W0k7PtY1TXFeeteG4Ijj2qOLhiBE+oiCVfSudBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342377; c=relaxed/simple;
	bh=AmhcopXfUxGs18/GrgWDANF80plzJoPQhH5ul3V3Ol4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRD7FLf0CnjdA2reZOVH4DzdlmlG2NN2hjJvUSDBug/ZKdRSXFCTvXr3aeeHoDL1T8qdISN+aHDGRYsda5yAz29Y1t44GfrNyjQO65brDcn2icOiHMdj0JnEwdwo4IW8xOfUlnc0r/f0eTzD6pGc4ikrRW/ziZnff1RIOxxU9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdJpewqv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so11857806a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342374; x=1742947174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmhcopXfUxGs18/GrgWDANF80plzJoPQhH5ul3V3Ol4=;
        b=DdJpewqvxXCQDvfg97sAkUmxMTHaQYEctDB7ZdcFvViy8rCBxYebYF74NroByEWpDM
         zXOtiJz2w8WJA3keYCDTv30GvQN5UuIfsABGVpVSKGqcwfLdHeJDbY6ZSIq1eZJ4hfDi
         zV9U6Pl5270g4L0JDL99FfohHgU7GfMNrwhzX562d4sytxXOOqGh6xc0kIir7UdRsldL
         iuTzvG+3ElAtQbF8WkiB9+igdM1BOAmPHxkHoktnFuDmwynEGcul34gT7bzhYWgpsNj8
         Xh27TxCcqtUe2t7SMwzFOSc+d8oHYRG/BVo2xlsgtBOLgaTKWn4PHFpBAuD0YKrzp3mo
         lAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342374; x=1742947174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmhcopXfUxGs18/GrgWDANF80plzJoPQhH5ul3V3Ol4=;
        b=NIh39cP1HjFnNAjFpYMwC17KRZOvQbSldKv7diImb8GFY4SEaeAuSBpysVaDY9vLjr
         r4oVuRh3hl64X1XyZj4P+ELWurVz00MZyIrLDzZOu9AyBUOb/Ud1VuWJKKjvvaw1osmt
         OPn+EHs5JlV2G7IJpI1WJnygltO1yF7E0RJiCG3C1Ijo3f8DEl6ZhODFc5t2wpYZ9bD3
         OGkGJaI6b3VyjkUDzSBSNPMiYQwbzW9ruZmPbGGE/CHk0k4U7AJD0B3As8jNQOIpc2tm
         mTCoSa5HaMSWFWoIPexe/l/a2VFLu+fts4KfmrOPE3hAFAg31aVH6TYoElhO2hsoZL08
         MEEA==
X-Gm-Message-State: AOJu0YxEdMoeBRkJl5q+e5UyF9QjE/hqh9f41cTvHAtSDeGAvDj65UMs
	2NQFFZV8BSB4jnKwsGwL+98NP24umQ9CniPz3yWYelVYLKMCn42jgCdIitVJmfckAQr4ohD3fkt
	coyUC7qtbF8MDaRuCYqO8yFDZ+A==
X-Gm-Gg: ASbGnctbetTkcs0D/Q+jAxUfbGh5cxCUtKRhj2rsRa1eYE52YPjwAOGI+P09Xt/m939
	0OktIuxPW4qROSU2Vf4BRq/tTYKJVYftNMjg1M6jOYC0tu4Y21ME7C+e9niYcvsOtx1mTkdh0Dn
	46Rg4TM0DkHZpGA8H8EmNsgk/J3FQvFZfFNZPfpafjzKD4Zo0i/VDLbyLaEsI=
X-Google-Smtp-Source: AGHT+IEqAj8TsMGVaPA/OJKYgSWyc+36N7sMgiN9qmJaBXcyBH9f4ziU99E40n+PNNT3nzFuzigg/O/ab9l6B2LAr3Y=
X-Received: by 2002:a05:6402:13c9:b0:5e7:84eb:6e13 with SMTP id
 4fb4d7f45d1cf-5eb80d199d7mr607446a12.14.1742342374047; Tue, 18 Mar 2025
 16:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
 <CAM5tNy7AGHk+-H2BQpzB0r8LtSy37XdWvpjcNxPmOuG+v5zBtA@mail.gmail.com> <e285a3e013e0ca593f21b5aed24f545e6e64312a.camel@hammerspace.com>
In-Reply-To: <e285a3e013e0ca593f21b5aed24f545e6e64312a.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 16:59:20 -0700
X-Gm-Features: AQ5f1Jpg8zIheOMaRHGbjkcuaJ0aTdrGJmnoo2Ipu4UNC1p0cUKPbYEFC1qmCAk
Message-ID: <CAM5tNy5p1FQB0JDAeFpXZJvqs3m4LcHA5d2kVXFVWiz5TMZDdQ@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:54=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-03-18 at 16:01 -0700, Rick Macklem wrote:
> > On Tue, Mar 18, 2025 at 2:17=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> > > >
> > > > The problem I see is that WRITE_SAME isn't defined in a way where
> > > > the
> > > > NFSv4 server can only implement zero'ng and fail the rest.
> > > > As such. I am thinking that a new operation for NFSv4.2 that does
> > > > writing
> > > > of zeros might be preferable to trying to (mis)use WROTE_SAME.
> > >
> > > Why wouldn't you just implement DEALLOCATE?
> > Not my area of expertise, but I believe some like to know that
> > zeros have overwritten the data instead of the data just being
> > unallocated
> > (blocks still sitting around with the data in it).
>
> How do you guarantee that? There could be file or filesystem level
> snapshots, there is the drive's own FTL...
snapshits are definitely a big security risk. As I just posted, I do\
not know what guarantees the NVME Wr_zero command provides?

>
> There are good reasons why there are companies that specialise in
> physical destruction of storage media.
When at Guelph, we used the 5lb hammer method. Good enough for
a university environment. (For some reason, I always enjoyed smashing
hardware to bits.;;-)

rick

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

