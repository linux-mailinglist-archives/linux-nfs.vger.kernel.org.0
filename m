Return-Path: <linux-nfs+bounces-2670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CB89A017
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D0287629
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D88BEF;
	Fri,  5 Apr 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="rVB5a0mZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826816D9D5
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328487; cv=none; b=Bq4hEdjegZusIRy1H41OwoPZN9TZWpanJfd2UfCJUUIYS1a8SLa5ReU1hKV7+JwVCy+MaCrnW+CfQTRluwzNyfeJ3lCiXbFzdUsSTWx2MDCj2jRn4mJnP5ks2FT/3eWTLlk5CQLllE1wFnkIzhUjKtjw31Q8acNoEpbqJhFvseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328487; c=relaxed/simple;
	bh=aKE/4B7GJFb9gB5kbbM7t6MF7RgJ65t8f7T8siVxts0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/wiEaeKc6tFrYqZETkG/5evXv/P/slv/+RyvtZTMi1dsl+/xoEgiBUemzPYHpB/GpNMpWL4ccW3+BJ/903dQ4aFkejRr+Naz4i1pZHqd5c0GldgUAJkFPbA+cHOzYMthij6IuAmvE0NbS/XB80coZnCDXLhhCXzGJBcVCWBUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=rVB5a0mZ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-368c13003eeso10066045ab.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Apr 2024 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1712328484; x=1712933284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aKE/4B7GJFb9gB5kbbM7t6MF7RgJ65t8f7T8siVxts0=;
        b=rVB5a0mZWFv+978t6LugIWyVDxKHYawXyWo6VGEOZe/GkXuE4g2VxfXlQKUSlwSHKo
         MSGZbPXCDg3PeQWf4fKG689RPrn86W0DSbD455YwKZQA92ZiTlvxCAo9fiTaP/VHtVCW
         eua6bBHmhNkFAY5wvYJpM8DH7qvQeOCBS+obVb5+Zw+CMNvcuix5TnEmH1GpK5vHgHZi
         pLkx52V97yblKP2CcGxhBvWfe6wT3IU5MoKDLS3mvLNTTGgXBYwUX0d7nDiysvGp0ncI
         tZlHqahCXOP7NzJAlxy6K0W7a5a6m9Ql4Ko7qZ9BdUfRcJ1r43GSnPS6F6UyU0czmCXK
         chQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328484; x=1712933284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKE/4B7GJFb9gB5kbbM7t6MF7RgJ65t8f7T8siVxts0=;
        b=El7Pfgzhcb18+vppcP6CpFHNyioirN6nQrS11M1NOTeJFnOY3VH/C693J0ZYeA7xfC
         7aftJkKDGyg26OTyPQVOk6Oxcpw2dyS6fm5ooIf+oN9NBWP6t3oDODDOllxaPb4MZINN
         UlG9RMRRUta0MLaodBjg+AjRPxx7QPXp6vp4uNL1Zy8NazJKMdnQX2roNLIcfM8WM8iY
         kj3I3ksThs3Q/EXDYOsTXUoWJW3r4uN6gr9dKdh1PXdXMxUgRfWxyS/JmsK29QDWAANN
         YCvCrLXepYNxc2fV4YooVGPMvCaT8wikC3v2u1bLuAPRJTaPNCPRbz2nsNz0IRwPQdi5
         5lbw==
X-Gm-Message-State: AOJu0YwIAiQ440+a1FbbwsoahlclPXtsq16iwxXpaEtZECtnAjt/TKFM
	duOZXf077JOadFEs9tnyteaXlBn07A0KY6cPix1HU4WpLrxUoiJVxw9jDgP1LVD8RP7TLrgwyqS
	ECahOX3lCDjt5ayNgbokfNJEYnC+iQAnRUErSJb1+GwaKORWEkCI=
X-Google-Smtp-Source: AGHT+IHIySzktMEVGliOgGgnAO2kRWGKXOeUXHAr1kqX3Xr+syAgbUoEtYfJm/QnxrqzuOL3WUhqy0tlezGNhKNLmiM=
X-Received: by 2002:a05:6e02:1a06:b0:368:a502:14e0 with SMTP id
 s6-20020a056e021a0600b00368a50214e0mr1470137ild.31.1712328484107; Fri, 05 Apr
 2024 07:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
 <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
 <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com> <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
In-Reply-To: <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 5 Apr 2024 15:47:27 +0100
Message-ID: <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com>
Subject: Re: directory caching & negative file lookups?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Apologies for dragging up an old thread, but I've had to tackle
wayward negative lookup storms again and I have obviously half
forgotten what I learned in this thread last time (even after
re-reading it!).

Can I just ask if I understand correctly and that there was an
intention a long time ago to be able to serve negative dentries from a
"complete" READDIRPLUS result?

https://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0108.html

So if we did a readdirplus on a directory then immediately fired
random non existent lookups at the directory, it could be served from
the readdirplus result? i.e. not in readdir result, then return ENOENT
without needing to ask server?

But that is not the case today because you can't track the
"completeness" of a READDIRPLUS result for a directory over time (in
page cache)? Or is it all due to needing to deal with case insensitive
filesystems (which I would think effects positive lookups too)?

I did try to decipher the v6.6 fs/nfs/dir.c READDIR bits but I quickly
got lost...

Cheers,

Daire

On Thu, 1 Sept 2022 at 16:49, Daire Byrne <daire@dneg.com> wrote:
>
> Yea, got it now. That all makes sense. Thanks!
>
> Apologies for the noise. Now I just have to go and fix a bunch of our
> user's code so I can forget about negative lookups again...
>
> Daire
>
> On Thu, 1 Sept 2022 at 16:43, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2022-09-01 at 16:27 +0100, Daire Byrne wrote:
> > > On Thu, 1 Sept 2022 at 14:55, Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > > man 5 nfs
> > > >
> > > > Look for the section on the 'lookupcache=mode' mount option.
> > >
> > > So I get that the client caches negative lookups once we've made them
> > > (the default lookupcache=all), but what I'm wondering is if we have
> > > already cached the entire directory contents before the (negative)
> > > lookup, can we not reply that it doesn't exist using that information
> > > without having to go across the wire the at all (even the first
> > > time)?
> > >
> > > Or is there no concept of "cached directory contents"? I thought that
> > > maybe readdir/readdirplus knew about the "full contents" of a
> > > directory?
> > >
> > > My thinking was that if we did a readdir/readirplus first, we could
> > > then do lookups for any random non-existent filename without having
> > > to
> > > send anything across the wire. Like I said, a newbie question with
> > > limited understanding of the actual internals :)
> > >
> > > Daire
> >
> > There is no concept of a 'fully cached directory'. The VFS and the
> > memory management code are free to kick out any unused cached entries
> > from the dcache at any time and for any reason. So the absence of an
> > entry is not the same as a negative entry.
> >
> > Furthermore, certain features like case insensitive filesystems on
> > servers makes it hard for the NFS client to know whether or not a
> > specific name will or won't match an entry returned by readdir. In
> > those circumstances, even if you think you have cached the entire
> > directory, you are not guaranteed to know whether the lookup will fail
> > or succeed.
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >

