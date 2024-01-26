Return-Path: <linux-nfs+bounces-1453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466C83D47D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731B41C2440F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D5F10A19;
	Fri, 26 Jan 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfDBuEWB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F07D29B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253803; cv=none; b=gpd7uS+/SkPZnc34pkM5/3tIGJhBNlhWK+/nT19+lGQzPZSKUG6DYHSDBq83uxfJ/I3do1MTzC+D79DUcd6O8wLUEZYJlx/X5uruA67Y+f0e/uVr+JLLKBgajLhWuKbA68rbYeyrVCj2SIVD7g0YzclVqaYAD3q8R8II93Sxku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253803; c=relaxed/simple;
	bh=N/eFqOZCaa4Z7nKlUG4H7qIYSL+ZspQhb1Djh8GhIXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ6eC4h5MdphUjCkP8yTPepxckACXhSU1t9E64dRoEFJOyTioZogZOYcHQa6Gl3zPyLP4uP9mTDAp5/h4e0U4zp4ZHQ8as6Mzr5Lo3NnmnWiBpzh0XpHJZOe6mo2EkTiPQDp2lnJ7k1B+Py9Geuso/C/mAJZAbyrh7ZoREN3vEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfDBuEWB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55d314c1cb7so156643a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706253800; x=1706858600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+vQy8sjcnFuJ8qhftZfWkpq4aMUKfN5Bi7z8UTJ/IA=;
        b=GfDBuEWByPgLwygZ9lvkn7BnKvDDAn7418qpPrPJDW9xfoB0vgNutl9cjGYoVPFoS8
         9To7S4JWcqbU2AXPG4nVX9r+VQKRcui5TImhoPhm26YP11C26D0oxc987XqMkNL6Ju6I
         UIJ6pDCFVNijEixFjarkZxwg1uJGO6jla+NqgE9DRd5LKI/ZOgUYkUdWsqVdVNedWofs
         fOpscwuENifrsamnGD3Vz6vcoNBqPsYYsE9SXmluAO5IZYjlk/NvjWaREzyrk+vmWIwI
         4SeD/6MyqmAzQJl+qO6K8joKpOKiaDhlZYr1ew4Sh5hlpXihLiS0QQCntB+gghx5TElq
         CbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706253800; x=1706858600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+vQy8sjcnFuJ8qhftZfWkpq4aMUKfN5Bi7z8UTJ/IA=;
        b=MwJBoWqFMTfFcjmejwTSVKwjz/A/kj+YyXjvQu3EuoHJ+Niv4GGZRh0RSVL6fSi5iC
         K+mNMEHVx5U9Fq6BYjGKvLv9QMwG9U8faUqwIRMtaE98xOEh59UNNV+ztBF9+M7SCM9p
         uDAzB3xxpdIURBHt1LfqIqJUiKdEQXUzZLTLp6sfVqcNBmJSAJfQTmoDtAKr9snmH7s8
         g/2zdb77c2/YXO7wMwui09/RyNIfvdjzFWNQJdnr8vfvePLjL5ihYVyrnyoyFQT/2OQ4
         KF9gykyFD8vCoTvkLs73Dba0+OrLLMaSZR3/3aOGOO8uMdy0d1dmkVilbqZ+qXPXBsgR
         iatw==
X-Gm-Message-State: AOJu0YxnD/Vx9aAH6hbdY1LFoafm4ks7jL44FxV9OL7qlKZFsqjEyWIr
	ks1qcQHjQ7FLVRa499v+/SqFph0QyUNulNmLLRzWq5FbVnAprb+AbCJZj5ftjaWCeSs9xdCCqoS
	nLKL5Vt42X4IMekkhIw/1rYkIgxo=
X-Google-Smtp-Source: AGHT+IFfChEAzzI6iBWPCDLhJ5N5bRfOhomP22/U4KEq8zbOlpKHupHXP080hahP/boEqYctZDf36cA5/Tmf50BnXGg=
X-Received: by 2002:a05:6402:f89:b0:559:b411:fa87 with SMTP id
 eh9-20020a0564020f8900b00559b411fa87mr549694edb.20.1706253799637; Thu, 25 Jan
 2024 23:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
In-Reply-To: <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 26 Jan 2024 08:22:00 +0100
Message-ID: <CALXu0Uc3t6NgvG_FJRvnTYoXKVi2whOWfysApt5Gj4RhAPn0oQ@mail.gmail.com>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
To: Jeff Layton <jlayton@kernel.org>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Benjamin Coddington <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 21:44, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
> > Hello!
> >
> > Is it possible for a NFSv4 client to implement TLS support via
> > /usr/bin/openssl s_client?
> >
> > /usr/bin/openssl s_client would do the connection, and a normal
> > libtirpc client would connect to the other side of s_client.
> >
> > Does that work?
> >
> > Dan
>
> Doubtful. RPC over TLS requires some cleartext setup before TLS is
> negotiated. At one time Ben Coddington had a proxy based on nginx that
> could handle the TLS negotiation, but I think that might have been based
> on an earlier draft of the spec. It would probably need some work to be
> brought up to the state of the RFC.

What about libtirpc-based apps? Is anyone going to add TLS support to libtirpc?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

