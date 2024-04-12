Return-Path: <linux-nfs+bounces-2778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0F8A2DB9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D351F23C4B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808FD54FAC;
	Fri, 12 Apr 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="N9vZQjHY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB032E3E9
	for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922225; cv=none; b=NSdrbeQq1nVLTc2VJHDq9nWWULOLLJjqgfyxuDNwET/IAx1WrE58sBUOCjfyE1dPHr+3g9Ympf1tUzxW1lV0S8sBz7karLpBjeef2MS3lxt9OTf98C9SoDC71c5HEHyyoVqEPQE8Qcs9ijjQ2A1xC1sfEO5F5Ua7ptrm3AVHhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922225; c=relaxed/simple;
	bh=ijWklAAayKtVtnnKeJniYXpxK7ndCcTQOD3nmwTwn3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOJ5S5HO39XKJA2mCsSFi6nSMwvlNOsfywl15gvVvtMMAzLXwfyuwuXtjbw4JHt3nFUH2Ks4cn1xdoQp74PWdw7bk0VGTUPZ5iz5enfqy2A9FcqWGU7+KjyGYU97/GebchJK8lVBaN+BbYLkZblKLWUe51JHg3WchHM0AZIj2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=N9vZQjHY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so877075276.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1712922222; x=1713527022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWklAAayKtVtnnKeJniYXpxK7ndCcTQOD3nmwTwn3c=;
        b=N9vZQjHY1aeEdARbb80IIeTf0JA3HvgW8/5gW+jgZNTUmnK+kIVlxSOVbdV2Nrj/WY
         9sD7x7KzJzh53OYDONzMWG60Y8rq7JptI43MJ4DRnM1qkuIbUCqmUG1fgxnsJjjSqUXL
         0pmIoRGtGL/ktdhbib5ACa8tHPA7PNl1asZUMolGyGT2kD5Leq1Do8nkJoFQl/FmeiBt
         IbrimX0e9b37k2j2wkYDd3YEVEQoZx0GokQDentgeN3oFtuuON2HYEyWRat1NA/g9uop
         MpljKBs5bWwUIX/VXJ4BKMAS3O6n3QSRNRx4CymlitvKaeQ1Tzz5+87CpMEFHHU/kt7H
         8IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922222; x=1713527022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijWklAAayKtVtnnKeJniYXpxK7ndCcTQOD3nmwTwn3c=;
        b=IG08jONwm+RfwTDvNBO/NupUfxnXPnEG35okv35WGoWFlIt2ZtQpCR7gMncjOaC6qx
         lzksjMcN0fNPe7vu5laYrJxzJ19VXEbbePTtq3QmNNkf/3i8n4wNxQaozJ/oM+wdc9Ik
         RdS9zyEsIEjdR4zCYRGqHANg0KzeJ1DIXAdFo+fY6XjdPAy3Ud4sB8HV63UUJkTlnRj0
         qZldcU3r37Pd/QJO93ULcU4edgHkgYEUWCJ4IMDC5ELMmoAwh48gZF5KSX8PFRtuQMbF
         Bax9s3vjXW6SaxS6z3GJyEZfFmi8XyGAQza7r8soTMiBXhq2ARhSdjVrYEEW6K4YisdM
         /mHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcvU178wQXiMQFIdTmMdLGdi16PVDYnzKg1et1Gi7wfDT6X4vGZWyOID/YZUxaOuA5mRFizahqbeJyaKuZWeop7vdZ7UVirMZ5
X-Gm-Message-State: AOJu0YwtxKfEXIILLzTBcW0SyA3m83Gg+sBDCFbOZy/K/85eJn6FkrGj
	ng1o+hzbG86fbYNM7QyWp2HXUfOXZwiIQ2A/ZiTofQkZKDAmLCQhS1D5gECdcjHw4E5G+tjm7jb
	IO1S0tSEPEa8H9kjEXz/g3r2rTyI9NjIeaDkmq153zjm0wO3YLeE=
X-Google-Smtp-Source: AGHT+IFLKb2fMon+WxuRZ7JyPeZ/xO/cjWCqkGjMLUzhPAcL8CsNdGXI8VKfKEqWCTnerd27J9UbPxI8OFpmg1cf4yg=
X-Received: by 2002:a25:ad08:0:b0:dcb:e432:cb06 with SMTP id
 y8-20020a25ad08000000b00dcbe432cb06mr2684367ybi.29.1712922221999; Fri, 12 Apr
 2024 04:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
 <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
 <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
 <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
 <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com>
 <17e2bf4c718a7cfdc34131978ad03656d0622de5.camel@hammerspace.com>
 <CAPt2mGM-kc1UShzuuUZeeh4sJDbT==sVh+uv-HK7K9EoZoHvnA@mail.gmail.com> <7e593bfb376eabb1968244d6014e223945e71990.camel@kernel.org>
In-Reply-To: <7e593bfb376eabb1968244d6014e223945e71990.camel@kernel.org>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 12 Apr 2024 12:43:05 +0100
Message-ID: <CAPt2mGOK-rURRe1i7HJsEHkJDFKRrZexw4jS=FyAPyyuJq9Uwg@mail.gmail.com>
Subject: Re: directory caching & negative file lookups?
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 11:21, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2024-04-12 at 10:11 +0100, Daire Byrne wrote:
> > Thanks for the clarity Trond - I promise not to forget this time and
> > ask the same question again in 2 years!
> >
> > It just keeps coming up here at DNEG due to accessing software over
> > NFS and crazy PYTHONPATH usage by some of our developers. In some
> > cases, there are 57,000 negative lookups but only 5000 positive
> > lookups (and opens)!
> >
> > Getting devs to optimise their code is my cross to bear I guess.
> >
> > But this is also a well known and common problem for large batch farms
> > and there are some novel workarounds out there:
> >
> > https://guix.gnu.org/en/blog/2021/taming-the-stat-storm-with-a-loader-cache
> > https://computing.llnl.gov/projects/spindle
> > https://cernvm.cern.ch/fs/
> >
> > Coupled with our propensity for high latency (~100ms) NFS via
> > re-export servers (for "cloud rendering"), these inefficient path
> > lookups quickly become a killer - the application takes longer to
> > lookup non-existent files and open files, than it does to execute to
> > completion. We use aggressive caching (actimeo=3600,nocto,vers=3) and
> > "preload" metadata ops (ls -l, open) on a regular basis to try and
> > keep things in (re-export) client cache which certainly helps. It's
> > hard to keep known (expensive) metadata worksets in memory.
> >
> > I've also been looking at using an overlay and hand crafting whiteout
> > files in the upper layers to essentially block known negative lookups
> > from hitting the lower NFS share - again, only useful and correct for
> > read-only software shares.
> >
> > I wonder if Jeff Layton's directory delegations will help for
> > (read-only) metadata heavy lookups over the WAN?
> >
>
> Probably not. In order to optimize away lookups of negative dentries
> that aren't in cache, you need to know all of the positive dentries in
> the directory. As Trond pointed out earlier in the discussion, NFS
> doesn't have a concept of directory "completeness", so we can't
> reasonably do this.
>
> FWIW, CephFS does have such a concept and can satisfy readdir requests
> and negative lookups out of the cache when it has complete directory
> info.

Out of interest, do directory delegations help with positive lookups
or repeat opens? They may be less numerous in our badly behaved
workloads, but they are still nice to optimise for latency.

Can you disable "cto" for example if you have a directory delegation
and repeatedly open the same file for reading without a network hop?

I also noticed that "nocto" can completely stop any subsequent network
hops for opens (with a long actimeo) for NFSv3, but on NFSv4 it only
cuts a single GETATTR before still doing an OPEN DH over the network
each time.

I'm probably wandering off into "disconnected clients" and AFS style
territory now...

Daire


> > On Fri, 5 Apr 2024 at 16:03, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >
> > > On Fri, 2024-04-05 at 15:47 +0100, Daire Byrne wrote:
> > > > Apologies for dragging up an old thread, but I've had to tackle
> > > > wayward negative lookup storms again and I have obviously half
> > > > forgotten what I learned in this thread last time (even after
> > > > re-reading it!).
> > > >
> > > > Can I just ask if I understand correctly and that there was an
> > > > intention a long time ago to be able to serve negative dentries from
> > > > a
> > > > "complete" READDIRPLUS result?
> > > >
> > > > https://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0108.html
> > > >
> > > > So if we did a readdirplus on a directory then immediately fired
> > > > random non existent lookups at the directory, it could be served from
> > > > the readdirplus result? i.e. not in readdir result, then return
> > > > ENOENT
> > > > without needing to ask server?
> > > >
> > > > But that is not the case today because you can't track the
> > > > "completeness" of a READDIRPLUS result for a directory over time (in
> > > > page cache)? Or is it all due to needing to deal with case
> > > > insensitive
> > > > filesystems (which I would think effects positive lookups too)?
> > > >
> > > > I did try to decipher the v6.6 fs/nfs/dir.c READDIR bits but I
> > > > quickly
> > > > got lost...
> > > >
> > > > Cheers,
> > > >
> > > > Daire
> > >
> > > If the question is whether the client trusts that a READDIR call to the
> > > server returns all the names that can be successfully looked up, then
> > > the answer is "no".
> > > It's not even a question of case sensitivity. There are plenty of
> > > servers out there that will allow you to look up names that won't ever
> > > appear in the results of a READDIR (or READDIRPLUS) call. Having a
> > > hidden ".snapshot" directory is, for instance, a popular way to present
> > > snapshots.
> > >
> > > So no, we're not ever going to implement any negative dentry cache
> > > scheme that relies on READDIR/READDIRPLUS.
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> >
>
> --
> Jeff Layton <jlayton@kernel.org>

