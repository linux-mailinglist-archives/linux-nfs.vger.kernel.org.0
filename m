Return-Path: <linux-nfs+bounces-2386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121887F745
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 07:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43B41C20F65
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B74594E;
	Tue, 19 Mar 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRUj/oRf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BC5B1E3
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829623; cv=none; b=RGS/Cwda4iSZLMGXhYbVjxUtZ/iRPoB8JuDxBEdMvUd30+2XAajpzjUHebUc9kNjZXozfBArOrRhilnvsanEkAUDDhrv/aznHgS1+XEyK3Nb4aJuf2FALG9EBmoZuKfL0tpnDfbNRzFi1EByMiZrDEoxTpOxjJrZauLgb8fZPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829623; c=relaxed/simple;
	bh=WSaf+h/t2R+7t74nTu6Zi9aKf3ti8jGhnNq/LRYRUIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mO7e5ejp2XTqib+0lgxEFfOs6QvN440ebyUJWA4wbuhe8EeOvzIrsLGNSTEYaJ6Z1ZNBwyzKn0ea+edENnIXkNzvAz3MeffdlcThe6tuLzMshR9em7CzjnWJFZjodJbZPltCmawiIIdNEMf2MqGivJF7bKnUPsyrA/2XNbrR2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRUj/oRf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so858652a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710829619; x=1711434419; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSaf+h/t2R+7t74nTu6Zi9aKf3ti8jGhnNq/LRYRUIg=;
        b=ZRUj/oRfw+wXVn4qxAuArH9Gl6g1VX/DKU6ipix8m+TE6zbs3wv4lXVNb3B0YseQ8O
         sXXsDLJxYdl5B/DkAsyXW+zr078gRsiriTaA/UyMEaEwnag4HUQ81GgmKPNhy4Aa0oPM
         JMiyJ/gXm4kLd1MhZMr1m12SfBiGv+6mM12iOaPVpkWDPxfsI+V8Xq5SfAmnyELVNmkq
         sbHtN2oajUOhThvbm5bgvjzYW+FbMnEI2vwIw8rLCI5qbuKvRt961hShAR+Y9/BRWwWT
         BgF7IU5RUkQ3qY5oQm+kcNEg/6xu8+N9kn07oe0BzGoq3n4RhRETiUVdSLOTH1fvk1xz
         s7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829619; x=1711434419;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSaf+h/t2R+7t74nTu6Zi9aKf3ti8jGhnNq/LRYRUIg=;
        b=DHQCor5fvOarBan1/eLBqJrLNsS1IJtMQhBTcJJnAX6hH+VEn7l96WndEWXvRxLNRp
         YARSNuv7Md//qrSkWLTMIDLNXVc8pp/tBMsJlXhUrjQDMf+BjzVBJMAYORk+nIkdpxJG
         kBd8UM2baOCNtw9BsqVczrhyj5g2dz9fASGnE9EoWPLIzHnXSgqCCjy020agbpp0T+aR
         7JV6Wwd59hz4Qb7p2w8ZVlwC2aSL2zw5qG9GzkWKSuSxpe41x/Ydav2xmY0yONfsppRZ
         n+SBKFsy76bNI6piFY4u9f54IwzLH3JBroNoaUKPHG4YR0ynJch4MAJ8lQYiwpzl28aE
         D2qA==
X-Gm-Message-State: AOJu0YwdoRrAbQeBX+PjWwnyGN2hLm+bpgnu7n+SBei0t7lPnr/ACQ4t
	ooX2xf3/5YtebP0A6WsOzhnaCwUruiFW3ivbk175WN1xZ5k3JAlVbXolUk2voX71c0ayZkV9+ce
	yL3qhxQjJZJ+EUHtWOZA0ItXEjo4rVQDWrG8=
X-Google-Smtp-Source: AGHT+IFVFKRSBmEM676b7mReuXs7pkVXvHX4pbPrxLz9IUJSmvZ3akA7rceT1CtTp+eYIas3g5SO5BIvBadFPUnkdrA=
X-Received: by 2002:a05:6402:e9d:b0:565:7b61:4c82 with SMTP id
 h29-20020a0564020e9d00b005657b614c82mr9591405eda.5.1710829618677; Mon, 18 Mar
 2024 23:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com> <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
 <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com>
 <470318C6-3252-445F-94F3-DDB7727F84C7@oracle.com> <CAKAoaQ=6nGHD0uA+9EaQQPWBk8dvq0XVUPPgPAhbh=XPk+ecSg@mail.gmail.com>
 <76D8D54D-AE71-4D4C-AD61-2D2232FB1ECB@oracle.com>
In-Reply-To: <76D8D54D-AE71-4D4C-AD61-2D2232FB1ECB@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 19 Mar 2024 07:25:00 +0100
Message-ID: <CALXu0UeFBmX0y3dJH-nbdm7eQeOCMFNp7GDzthstLW0iFd6cUw@mail.gmail.com>
Subject: Re: |ca_maxoperations| - tuneable ? / was: Re: RFE: Linux nfsd's
 |ca_maxoperations| should be at *least* |64| ... / was: Re: kernel.org list
 issues... / was: Fwd: Turn NFSD_MAX_* into tuneables ? / was: Re: Increasing
 NFSD_MAX_OPS_PER_COMPOUND to 96
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Mar 2024 at 17:35, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Mar 16, 2024, at 7:55=E2=80=AFAM, Roland Mainz <roland.mainz@nrubsig=
.org> wrote:
> >
> > On Thu, Jan 18, 2024 at 3:52=E2=80=AFPM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>> On Jan 18, 2024, at 4:44=E2=80=AFAM, Martin Wege <martin.l.wege@gmail=
.com> wrote:
> >>> On Thu, Jan 18, 2024 at 2:57=E2=80=AFAM Roland Mainz <roland.mainz@nr=
ubsig.org> wrote:
> >>>> On Sat, Jan 13, 2024 at 5:10=E2=80=AFPM Chuck Lever III <chuck.lever=
@oracle.com> wrote:
> >>>>>> On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.=
org> wrote:
> >>>>>> On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> >>>>>>> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelto=
n@gmail.com> wrote:
> > [snip]
> >>>> That assumes that no process does random access into deep subdirs. I=
n
> >>>> that case the performance is absolutely terrible, unless you devote
> >>>> lots of memory to a giant cache (which is not feasible due to cache
> >>>> expiration limits, unless someone (please!) finally implements
> >>>> directory delegations).
> >>
> >> Do you mean not feasible for your client? Lookup caches
> >> have been part of operating systems for decades. Solaris,
> >> FreeBSD, and Linux all have one. Does the Windows kernel
> >> have one that mfs-nfs41-client can use?
> >
> > The ms-nfs41-client has its own cache.
> > Technically Windows has another, but that is in the kernel and
> > difficult to connect to the NFS client daemon without performance
> > issues.
> >
> > [snip]
> >> Sending a full path in a single COMPOUND is one way to
> >> handle path resolution, but it has so many limitations
> >> that it's really not the mechanism of choice.
>
> Yes, COMPOUND was added to NFSv4 as a possible
> way to manage network latency, but in hindsight
> I think the NFS community now recognizes that
> there are more effective strategies to deal with
> network latency than creating more and more
> complicated COMPOUND operations. Client-side
> caching, for instance, is a much better choice.

I have a severe hiccup now after reading THAT comment. Every
generation of IT engineers makes the same damn mistakes, and it takes
them ~10 years to realise their mistakes.

So here is the comment - before my first coffee - from someone with a
grey beard, who is old enough to deal with Mintel, the first UNIX and
the first RFS, NFS, AFS, DFS:
Mistake 1: Caching will solve it all. DFS (the follow up to AFS) tried
that to an absurd extent, and failed badly, too complex, too buggy and
too cpu and memory intensive. Granted the bugs were fixed over time,
but by then the reputation was ruined.
Mistake 2: Caching is always possible. Mounting /var/mail with
actimeo=3D0 is the classical example, HPC another popular one.
Mistake 3: The cache memory is unlimited. We had that one with
Solaris's builtin name cache, and then ZFS. Memory is limited, and
just making the caches 2x, 8x, 32x times bigger doesn't give you any
benefits, because cache expiration/timeout. Of course you can try to
keep the cache "hot", or try delegations, or move data ownership to
another server closer to the client. See DFS above. Did not work.
Google also "law of diminishing returns"
Mistake 4: The network has unlimited bandwidth, so we can keep the
local cache updated/hot, or abuse it otherwise. Unlike our dreams in
the 1990 that we will have 100GB/s Infiniband networks in our laptops
by 2020, the real word laptop in 2024 maxes out at 1000baseT, and most
rural offices still have 100baseT
Mistake 5: The main memory is unlimited. That ignores the fact that
SUN promised us that NFSv4 will not require more memory than NFSv3.
NFSv4 still has to serve the embedded/IoT use case, either for data,
or for diskless boot from NFS(v4). Those machines cannot waste 512MB
on your dream cache with their 8MB main memory, which is also not
going to work because of "Mistake 3". The law of diminishing returns
sends you your greetings.

So complex COMPOUND operations are not that bad, but they are also not
the perfect solution for everything. Likewise, giant client-side
caches are not the perfect solution for everything, neither are they
feasible in all scenarios. Oh delete the "all" and replace with
"most".

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

