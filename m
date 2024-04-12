Return-Path: <linux-nfs+bounces-2773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25C8A2AA6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1142D1F22BC5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820241C7F;
	Fri, 12 Apr 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="mRH8/BfF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E93D3BC
	for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913099; cv=none; b=kWk6EtA9/CofiagnVkwDK2962DxNttlewVoikfB1nSZ2iwRfIQJTOrIS3qoI/VuTH/WBCsimp5wwh4XAdpBEy/TMK24Okl5wHSJA4s37YFekTNI6sNpc4qzIJ3H3o9lIA4r7zzRY+HDc6HbXdu1FqF7dWtjLlCMca3kUG+DPTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913099; c=relaxed/simple;
	bh=qwujUKLLl1vnNWOQ5lnxygTuy7zYpdHCWu+jdDaD9Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umH03hQuS+tytULirrHBJy/99WwO+4/GqVnNAz6VaXryAkTtqoPRckb/YBO0Hx1t24Q3IG9jR2PyIJb+fzFpfwc8DtGywMcJsN0FkJOi6cadBQn4+I9Yw4Rnrgc/y1D+fMvS5s+Sx8G7Gjq1UQa7K6VIO+zyarZH1ntOOeXncpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=mRH8/BfF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso720200276.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1712913096; x=1713517896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qwujUKLLl1vnNWOQ5lnxygTuy7zYpdHCWu+jdDaD9Nk=;
        b=mRH8/BfFtgt4+o7fr7S8JI/60yzu7lWARL8YLjm4j/llOA1zvgq1ZFpuXUe8fyw7Fz
         EcOfJUeOVLUVNRue3VZDC0hka4emW9YkMD3xZSAXi4AH2S2DTm4OlZlWKG8mJ3/HKQcj
         7VELNv6sVwmF54d18/1C5/9c1b7SHaBWC8F+wUmmSTNUb9VWXVRBXy2gt8Rd8ZuL1UZ5
         +Q5UvLu3g/nTCyoiwx5Yc1kMY5uPyJSErAAN8E5xxmP4NUgCivjj9ySXFG/jJigWDhml
         5twe/TbYJIir1jxwFMSVP4P5d46onw2c06ZRjB8Oyfv9XqGjxd0aTOeZ2iWlVmvlkA3c
         c9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913096; x=1713517896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwujUKLLl1vnNWOQ5lnxygTuy7zYpdHCWu+jdDaD9Nk=;
        b=OM4XKb+qxig31vPYvks5MWJTB8ZZ0mXMR6tktCItlvE15YGqwTpuG2H9Wk+jtXJLWB
         Ft8dpLfvaPKaKbHMiq4sn8kNLytAZxeE08uJy/9WcktcID6VMJjCjNbUoN4otaX66LMI
         KXrASrgyPf87Bjk/KLNpv1UDn4CIQV27VtsjuyVCTWybayT1eIRsYgiZcfqI7t3sXNtq
         JVz7rNE9cFK4iCeE0BH+CBEcoS65/j3FjEV06nIGIF6F6LzrqGnHn+V5F5qu2e1+D5t2
         xrUYVGaopH2OncY/NSTyEmlCSxH2qnT5SGUCLQWXHMv08O5FwIhpEsD80TNMFMOJ++b9
         jt1w==
X-Gm-Message-State: AOJu0YzsgET9piptXW7Kvb2rHrqTazhjjldwW+LvXww64sQ8RHpbJoAo
	htGVC71hGuHw7sEWPnFyFX+VZL83ZH9zHRH0AM7rx/UzimYDBUP+AsCG6ZEIAAkk4PLpWR4TouX
	qlmuehWnHeqr9n4YSyx7o0OueczUxKKfeNLT+cKPAiYaHa120MTc=
X-Google-Smtp-Source: AGHT+IErCPWrI9qYJwXR2+dGoTOtDsPFbp1AsYLUaZcEZCVGKksGF2pfCNSarQrN5aIR/GMc0x4EZAnJrOoOVEVMI+E=
X-Received: by 2002:a25:901:0:b0:dc7:46ef:8b9e with SMTP id
 1-20020a250901000000b00dc746ef8b9emr2122358ybj.29.1712913096134; Fri, 12 Apr
 2024 02:11:36 -0700 (PDT)
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
 <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com> <17e2bf4c718a7cfdc34131978ad03656d0622de5.camel@hammerspace.com>
In-Reply-To: <17e2bf4c718a7cfdc34131978ad03656d0622de5.camel@hammerspace.com>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 12 Apr 2024 10:11:00 +0100
Message-ID: <CAPt2mGM-kc1UShzuuUZeeh4sJDbT==sVh+uv-HK7K9EoZoHvnA@mail.gmail.com>
Subject: Re: directory caching & negative file lookups?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for the clarity Trond - I promise not to forget this time and
ask the same question again in 2 years!

It just keeps coming up here at DNEG due to accessing software over
NFS and crazy PYTHONPATH usage by some of our developers. In some
cases, there are 57,000 negative lookups but only 5000 positive
lookups (and opens)!

Getting devs to optimise their code is my cross to bear I guess.

But this is also a well known and common problem for large batch farms
and there are some novel workarounds out there:

https://guix.gnu.org/en/blog/2021/taming-the-stat-storm-with-a-loader-cache
https://computing.llnl.gov/projects/spindle
https://cernvm.cern.ch/fs/

Coupled with our propensity for high latency (~100ms) NFS via
re-export servers (for "cloud rendering"), these inefficient path
lookups quickly become a killer - the application takes longer to
lookup non-existent files and open files, than it does to execute to
completion. We use aggressive caching (actimeo=3600,nocto,vers=3) and
"preload" metadata ops (ls -l, open) on a regular basis to try and
keep things in (re-export) client cache which certainly helps. It's
hard to keep known (expensive) metadata worksets in memory.

I've also been looking at using an overlay and hand crafting whiteout
files in the upper layers to essentially block known negative lookups
from hitting the lower NFS share - again, only useful and correct for
read-only software shares.

I wonder if Jeff Layton's directory delegations will help for
(read-only) metadata heavy lookups over the WAN?

Daire


On Fri, 5 Apr 2024 at 16:03, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2024-04-05 at 15:47 +0100, Daire Byrne wrote:
> > Apologies for dragging up an old thread, but I've had to tackle
> > wayward negative lookup storms again and I have obviously half
> > forgotten what I learned in this thread last time (even after
> > re-reading it!).
> >
> > Can I just ask if I understand correctly and that there was an
> > intention a long time ago to be able to serve negative dentries from
> > a
> > "complete" READDIRPLUS result?
> >
> > https://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0108.html
> >
> > So if we did a readdirplus on a directory then immediately fired
> > random non existent lookups at the directory, it could be served from
> > the readdirplus result? i.e. not in readdir result, then return
> > ENOENT
> > without needing to ask server?
> >
> > But that is not the case today because you can't track the
> > "completeness" of a READDIRPLUS result for a directory over time (in
> > page cache)? Or is it all due to needing to deal with case
> > insensitive
> > filesystems (which I would think effects positive lookups too)?
> >
> > I did try to decipher the v6.6 fs/nfs/dir.c READDIR bits but I
> > quickly
> > got lost...
> >
> > Cheers,
> >
> > Daire
>
> If the question is whether the client trusts that a READDIR call to the
> server returns all the names that can be successfully looked up, then
> the answer is "no".
> It's not even a question of case sensitivity. There are plenty of
> servers out there that will allow you to look up names that won't ever
> appear in the results of a READDIR (or READDIRPLUS) call. Having a
> hidden ".snapshot" directory is, for instance, a popular way to present
> snapshots.
>
> So no, we're not ever going to implement any negative dentry cache
> scheme that relies on READDIR/READDIRPLUS.
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

