Return-Path: <linux-nfs+bounces-3254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54298C5D05
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 23:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E7E1F2218B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA18181BA9;
	Tue, 14 May 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YkPnyPJI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760DE180A77
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723410; cv=none; b=Bg46lemrxSQhDtNTL4++pY71Le1X4GJGaY66oaE49NrQWMDag05f+h9eFaa1mPT3Hjls8aA9gNpVrYUDATW+rZS5zLbyzZT3sZN5Lac5o5ANB7e753Xfg3FEJpxWHd0uPBped9VGCCqbOj49ygayiKO5PGthjj6jTZQY9XXZdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723410; c=relaxed/simple;
	bh=zh87VwEwup4bdSL8lzYFN/HA0wVw4v2hPUsEJkEziro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixTJ1gcKDFfwCSUw81v9lfGErBUBahU3EHrZX88MPwm0a7eO3jUbJ5Rh1udRKef7VbYXbs1Sgrv5eQTpXPFzwNJV61fj9M7aboeoyO0ee94EDn1RfZ/G+JX0iOT2MmqUJTELQor+hPv927jEri3IRsOfpK7Z3bbk6Fm4btUzv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YkPnyPJI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5232f0ca07cso304724e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1715723405; x=1716328205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh87VwEwup4bdSL8lzYFN/HA0wVw4v2hPUsEJkEziro=;
        b=YkPnyPJI1sW0a4WSHGHR77bNiqCTlxj+SNDEve4GAn0NTw4T1pMLMCG2nPXfnPICE/
         yiuKI8mUxSkTB/YgUIbXveig2N9CLhBtyj4QX8JTBJYkrBS+dEVD2c9rVJnFEdg+pg7V
         HfvJ3mvgBTndj3BA/6A4UfmiI1zIEj7v6FmjaKDub0vDq9DZz1TWn93NEHje4VtfDWsl
         r0K2as7D5nrHA4FvcBnoYKVtRPnp9LwECNJl4bb++3uTyUbcBUOUTMFZu93q+jgfq04a
         td/reRQghKbbLEkBqUtw2Cu0/QsCEsSzHl2z0wUxVZFQcEdRWMkGScXKWSURgQuvUs/O
         hKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715723405; x=1716328205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh87VwEwup4bdSL8lzYFN/HA0wVw4v2hPUsEJkEziro=;
        b=HMLD6SY9yFg07F3jumCUVvH240WnVWmF/16auX56q4H1mSavVAkvy5q7y88u5zQA1t
         spPYBZh3xFc/O3BBABF9zeRzICdqZAIxBaj/fYlAPX9HVKG5ERfmpx9P0Nm7DC5E+dA2
         lPylG37I4enNMRN1pUVioQzDEayU/9PVvmvovwqMc1ip7EjPc5mw+RxlwvpFhVQ4KzV7
         mxxaRdkQ6rqVsanZUvxnY5aNvVgdtCFNDxtxLl7fS1bPZQyyblDxh+EKZuCmg6JbmORA
         pmuRKM4lhkAlQzel6PFvOwPbAuso6zvQJhS196SbIu489ZgVGTBO+SsaBD7jG4A7nr6f
         Ur9g==
X-Forwarded-Encrypted: i=1; AJvYcCXrDBFEomTXRsoyFv1LCm3q9GdELiiVzKirz1UpSUR91QHJPhEwqTuHc8dbacl7qHHsDsLYuXWftNtpd4WxMnT6uy17ypEIGRD7
X-Gm-Message-State: AOJu0YxQKxvKbcYikEoW4T8IZC6Q3EW9HLemwPr1E2eJdHfHDl9guM0a
	Gpmhqlcb5iw5kRqvsrYJfiMuwQ9e2fnvdA9PYKCESncRBtZz2umI04+RN6lFOT5fCXSBwtzzPuw
	XIM9goXafh1cds9A+GnDGKEubj+4=
X-Google-Smtp-Source: AGHT+IH3llqG5FNtuR/8ZvEHzshilx5nCVV54ByaHRmsqPst33djfQEZi9BKSOeRLIZj73mMVZj7pqEZTsODFU0X0wI=
X-Received: by 2002:a2e:9f4e:0:b0:2e5:6859:1902 with SMTP id
 38308e7fff4ca-2e56859194bmr77461941fa.0.1715723405416; Tue, 14 May 2024
 14:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
 <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com> <0b1101daa646$d26a6300$773f2900$@mindspring.com>
In-Reply-To: <0b1101daa646$d26a6300$773f2900$@mindspring.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 May 2024 17:49:53 -0400
Message-ID: <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com>
Subject: Re: sm notify (nlm) question
To: Frank Filz <ffilzlnx@mindspring.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:36=E2=80=AFPM Frank Filz <ffilzlnx@mindspring.com=
> wrote:
>
> > > On May 14, 2024, at 2:56=E2=80=AFPM, Olga Kornievskaia <aglo@umich.ed=
u> wrote:
> > >
> > > Hi folks,
> > >
> > > Given that not everything for NFSv3 has a specification, I post a
> > > question here (as it concerns linux v3 (client) implementation) but I
> > > ask a generic question with respect to NOTIFY sent by an NFS server.
> >
> > There is a standard:
> >
> > https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
> >
> >
> > > A NOTIFY message that is sent by an NFS server upon reboot has a
> > > monitor name and a state. This "state" is an integer and is modified
> > > on each server reboot. My question is: what about state value
> > > uniqueness? Is there somewhere some notion that this value has to be
> > > unique (as in say a random value).
> > >
> > > Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
> > > representing the same DNS name) and acquires a lock per mount. Now sa=
y
> > > each of those servers reboot. Once up they each send a NOTIFY call an=
d
> > > each use a timestamp as basis for their "state" value -- which very
> > > likely is to produce the same value for 2 servers rebooted at the sam=
e
> > > time (or for the linux server that looks like a counter). On the
> > > client side, once the client processes the 1st NOTIFY call, it update=
s
> > > the "state" for the monitor name (ie a client monitors based on a DNS
> > > name which is the same for ip1 and ip2) and then in the current code,
> > > because the 2nd NOTIFY has the same "state" value this NOTIFY call
> > > would be ignored. The linux client would never reclaim the 2nd lock
> > > (but the application obviously would never know it's missing a lock)
> > > --- data corruption.
> > >
> > > Who is to blame: is the server not allowed to send "non-unique" state
> > > value? Or is the client at fault here for some reason?
> >
> > The state value is supposed to be specific to the monitored host. If th=
e client is
> > indeed ignoring the second reboot notification, that's incorrect behavi=
or, IMO.
>
> If you are using multiple server IP addresses with the same DNS name, you=
 may want to set:
>
> sysctl fs.nfs.nsm_use_hostnames=3D0
>
> The NLM will register with statd using the IP address as name instead of =
host name. Then your two IP addresses will each have a separate monitor ent=
ry and state value monitored.

In my setup I already have this set to 0. But I'll look around the
code to see what it is supposed to do.

>
> Frank
>

