Return-Path: <linux-nfs+bounces-8146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195B9D3439
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415832833E7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DDB158D6A;
	Wed, 20 Nov 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eihpNa1+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3A15A843
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088401; cv=none; b=qsmAJwha1MWiQsLm8dxIIyWGi9oUvTa9K+ME6FtEtAmidDvhMt3TNUM76FqCgZ/KkTaGjAU6m/DaGrl0OvBRBNK0z5l4N0rTMveV0BKnlW+YMYI+DA0JPminpn7FtYiyvOlwKaC8jtCNaW5hneMOcCEzZBNWkXgYxZkP676FVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088401; c=relaxed/simple;
	bh=97awQ5vjrWiANGXRVLq6yhOyA4gqx34HnoJcmzMSmUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aAkoorSws8wrq+1NF2LoZ61HynUaZ2sHpp2GemhtD4CBhrpsBCBTYNyzFegRbD+rAKsPnPwmp0Zyz8h15vHy82pJIiY2izEcqS3Glz+pENlUpJ+CE8EyHIsLuOWYRR6/5g93QKxDE5vWixkU5G8ipXWoKvM3P5Etv7Ph5oW92s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eihpNa1+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so15902391fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732088397; x=1732693197; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97awQ5vjrWiANGXRVLq6yhOyA4gqx34HnoJcmzMSmUA=;
        b=eihpNa1+aN61oARC613mcCgkAF3+DQN6gNMnt4elT1JSwi47cbwS4QLqGw5QEwppHh
         /EfDjEyJpmsHhznzpIFd1vBmJ+u9IiHnrQP7yOCOVjMzcj3DItMVHoNh3g6xW0zsdPcR
         41vSozmsRI62Z8RrbN0LGQsSv79/cRz6Iu0m23MbMsoQfm11/hibX0uhFJgokFrmMBoy
         QmAjp774LAwA4uj9EB7WSzJCc2BtBFkQ70OxVBqgvoGB5ERKTZSMcyimQH+retezzsgM
         6W3GfDAJOavOZNdv9JuCW4SWH0hA4zBRjjIElPyeP3LOmhS7Z93fyuEiLwnaYSp4j6GY
         ScRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732088397; x=1732693197;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97awQ5vjrWiANGXRVLq6yhOyA4gqx34HnoJcmzMSmUA=;
        b=nQaB/2/r5kquBnw+URPomxqgViEY+CaDu1rvfiVcIR8Hx4lGyWHJk0P0seD8/EDUBe
         YLpge9fnIQnUJGTaHWgXumC+zaJwHHv8QXoGXa/gJhb6cpNBrrY4TcNmzCOtzEnm/5cc
         MSmcKhz33XTcldfvzK9kdbKhTI9v0tQrv1SK4e/YJAPSz++GsDAHXRfdNoCeZhekx5U8
         9sKzwlJYRVG4qjYsvfP1vZoMgZCp7VIGk861uI5Ljc/Vyj+rlu6ZQVVuMkOIbssmUWLR
         x4/98bePYVVnxQyK3RLHwhqg+sZqFgmN3nIHL0io7KamAaKrzD4upuz28aBrlpdyeIQp
         V7tQ==
X-Gm-Message-State: AOJu0Yy9pvfFn+198cEUe6oWCzLw3TZowNTrdeMK1K45MPEd8tQYpZFq
	6HrmWU0mN9WEpvbXzdCiH+xamiB2uU9KXhY5OvQeHuTvMwjkelXHpApqmXOc8KBQJ9/ZG43/7tt
	P0KdWHnQ2z6LEd9NigVjl1T3Vw2hCIDu4
X-Gm-Gg: ASbGncueItSX4hdxZMXTdSKjdc1oYn3RaZHTkl/XU6qlRUrOP93z4ukuUmYbyV6skPI
	rEBdN0UfKp3CKbh8hBAKYNRIaDY6eZSk=
X-Google-Smtp-Source: AGHT+IFBCGaqLB/R6yB+LyA2xNist72wiX8MGJMnWGjAu+TFiBStJs1VXngOE0TnAUmF0Nkg0mtJzXokk8G+H7IefU8=
X-Received: by 2002:a05:651c:907:b0:2fb:4603:da13 with SMTP id
 38308e7fff4ca-2ff8dcf5538mr7444151fa.39.1732088396522; Tue, 19 Nov 2024
 23:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org>
 <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com> <4210AE90-97EE-4B32-AC67-1DB80082D4CC@oracle.com>
In-Reply-To: <4210AE90-97EE-4B32-AC67-1DB80082D4CC@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 20 Nov 2024 08:39:00 +0100
Message-ID: <CALXu0Ud49Sze09H-Xp-UG24Zwfeo44gd=Txo3kbgDpCgcyApWQ@mail.gmail.com>
Subject: Re: OPEN_XOR_DELEGATION performance problems
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Tiramisu Mokka <kofemann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Nov 2024 at 17:31, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Nov 19, 2024, at 10:09=E2=80=AFAM, Trond Myklebust <trondmy@hammersp=
ace.com> wrote:
> >
> > On Tue, 2024-11-19 at 06:45 -0500, Jeff Layton wrote:
> >> We attempted to implement the "delstid" draft for v6.13, but have had
> >> to drop the patches for it. After merge, we got a couple of reports
> >> of
> >> a performance issue due to the OPEN_XOR_DELEGATION patch:
> >>
> >>
> >> https://lore.kernel.org/linux-nfs/202409161645.d44bced5-oliver.sang@in=
tel.com/
> >>
> >> Once we enable OPEN_XOR_DELEGATION support, the fsmark "App Overhead"
> >> statistic spikes significantly. The kernel patch for this is very
> >> simple, and doesn't seem likely to cause a performance issue on its
> >> own. My theory is that this test is one that causes the client to
> >> return the delegation, and since it doesn't have an open stateid, it
> >> has to reestablish one during the test run, and that causes the app
> >> overhead stat to spike.
> >>
> >> Trond, Tom, Mike -- I know that the HS Anvil has support for
> >> OPEN_XOR_DELEGATION. If you run the fsmark test against it with that
> >> support both enabled and disabled (either on the client or server
> >> side), do you see a similar spike in "App Overhead"?
> >>
> >> If so, then I suspect we need to consider limiting the use of that
> >> flag
> >> in some cases. I have no idea what heuristic we'd use to decide this
> >> though.
> >
> > As already stated when we discussed this at Bakeathon: the server is
> > still in charge of heuristics w.r.t. whether or not there may be
> > contention for the file. The OPEN_XOR_DELEGATION flag changes nothing
> > in that respect.
>
> fsmark is a single-client test. There should be no contention
> for any files during this test.
>
>
> > Yes, I'm sure you can find tests which cause recalls of delegations,
> > and those will be marginally slower when the client has to re-establish
> > an open stateid.
>
> The fsmark result regressed 92%.
>
>
> > However the issue with those tests is that they are
> > deliberately setting up a situation where the server ideally shouldn't
> > be handing out a delegation at all.
> >
> > Furthermore, this is no different than a situation where the client
> > used a delegation to cache the open (i.e. avoid sending an OPEN call)
> > after the application closed the file and then later re-opened it.
> > So the point is that this is not a situation that is unique to
> > OPEN_XOR_DELEGATION. It is just a consequence of the client's ability
> > to cache open state.
>
> The regression was bisected to Jeff's XOR patch on two
> separate occasions. This does indeed appear to be a
> situation that is unique to OPEN_XOR_DELEGATION.
>
> It's possible that our theory of the failure is wrong.
> As developers of the only other server implementation of
> OPEN_XOR_DELEGATION, can Hammerspace help us troubleshoot
> this issue?
>

Doesn't Tigran's dcache.org nfs4j server also support OPEN_XOR_DELEGATION?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

