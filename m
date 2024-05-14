Return-Path: <linux-nfs+bounces-3253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AE8C5CBD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 23:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05841F21FD2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261AF17F36E;
	Tue, 14 May 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GPmCUoNC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBC1E491
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721717; cv=none; b=Af209gLNr9/7KymnDGwnlS3gOoKNB+lwK0Sazrz2j8ugLYafNPeMk6FV5WwDdfQs9vJqnc7cBIvICbs2mrQLvz1e1zHBsHHAaetblJrz5sP1Ccz7hQsK/4wHkpGZ+gU9bZX7cF10xU4LwgRMAdY7tjGEOsYm3PA5GNIHvwvZWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721717; c=relaxed/simple;
	bh=om2afHVLXbEBAwXNSr8doBYtFWiob61AQIeolBNom1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIqTcF/2R3sxvPQFDFtf7i2lOPHn0vQGOwsF1jJee/pM/s3GPHB4g6niZjcVElf+uJUH92FPousukico4WjU8bbIE2+8vWgasY6BGLXprxYsZnyjcFfMqaRSmUnytWS5n7SCHK65/7S018koao8rSBvGyQT6garQMS1LxpH3swE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GPmCUoNC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51fe647633dso591438e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1715721713; x=1716326513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om2afHVLXbEBAwXNSr8doBYtFWiob61AQIeolBNom1Q=;
        b=GPmCUoNC+7pg8mfX/YTnZ9oBVlJbvn5XdmXrbSax9XlPBZoKiPSSzVk/4XrHb/LMP3
         wrK3qIuVcGF7KdyJroJRXeEEoG5HGoWFxaJ4fZkz7yZeA+k+PeOadi0xxHnbHZ4F3qhd
         ksWQBK5AiXllqqOLGRQGvFvM6/hybGSaNrXGk31qldV9byGsZGpGqCcKg2TC+iNBIEds
         ipUm6ZvqM0fPWzpmwJJYBqjqjOMXYQndGuqV11kbSVSeg3jr/ZL7gKzY/t2ItImC3sqC
         3xhQ8fbd0+x5zBiJ62ZG4L9mc0KZ8ZzXBMwJhV8507MtfIWP/dnaTaZixXBlVMCpfDaZ
         RhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721713; x=1716326513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om2afHVLXbEBAwXNSr8doBYtFWiob61AQIeolBNom1Q=;
        b=eAYuBm1VRRXcH2AI+Zvv27o1G+EDtSY+zK5uejfbRKUUc7ajj4dMct6XnGvJ8sPimX
         l7+VdgdkfTndB2DsUBJOE0F3xUfmnOjBNHDIC5t0T2x046yr2sTg3iDUQdawAW3K7a2D
         QmQhtQVxsSaACrkto8EGLCSPznELTJJ3gkdo/PnYTluE80EdMk2B2MHEu8MbTOMs/ON8
         /9RGYkom1NXP0GMCGDQtbhHdLklbUFxavwSOkPGHKCwEVFln1irIzlA3l3xbmOChYPjY
         U4W2cU+UJTd+1T/IbKwwIm9wL+eluJByvWErbGv/RZxjTqOabNsX3EAFQHjPn99U/VOg
         pVPg==
X-Gm-Message-State: AOJu0YyBUpV/Aiqk5UKtMzt4mIhiOeqDiJd0CKRMmMBvFCBeLkTvJ620
	e2C4/tTPb9Gs+qLIQ4qawG1vioxmBxora/1QXY+IpzbSIQg55iUz+9zaSfNtACTtGl4iYUaTe8U
	x1c6F0eomv3NJnczINfc6VFJnw5iuOw==
X-Google-Smtp-Source: AGHT+IHAIzo90JyANAz55cDSZjH6PPvj00ty+q05Qou+rvKVM0lOFY3ZEDSqBNU/Q0sNjdzLn2Fe1jMjPt4vrPn0tEA=
X-Received: by 2002:a2e:b5d6:0:b0:2e1:fd4a:cc3d with SMTP id
 38308e7fff4ca-2e51fd4dd13mr88006291fa.2.1715721712675; Tue, 14 May 2024
 14:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
 <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
In-Reply-To: <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 May 2024 17:21:40 -0400
Message-ID: <CAN-5tyGxDtO7BuXvU=MQKad3W9+Zsf_9BMB5Hojnyy6bQ6fj0w@mail.gmail.com>
Subject: Re: sm notify (nlm) question
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:09=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On May 14, 2024, at 2:56=E2=80=AFPM, Olga Kornievskaia <aglo@umich.edu>=
 wrote:
> >
> > Hi folks,
> >
> > Given that not everything for NFSv3 has a specification, I post a
> > question here (as it concerns linux v3 (client) implementation) but I
> > ask a generic question with respect to NOTIFY sent by an NFS server.
>
> There is a standard:
>
> https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm

Thank you Chuck. This too does not give any limits as to the
uniqueness of the state value.

> > A NOTIFY message that is sent by an NFS server upon reboot has a monito=
r
> > name and a state. This "state" is an integer and is modified on each
> > server reboot. My question is: what about state value uniqueness? Is
> > there somewhere some notion that this value has to be unique (as in
> > say a random value).
> >
> > Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
> > representing the same DNS name) and acquires a lock per mount. Now say
> > each of those servers reboot. Once up they each send a NOTIFY call and
> > each use a timestamp as basis for their "state" value -- which very
> > likely is to produce the same value for 2 servers rebooted at the same
> > time (or for the linux server that looks like a counter). On the
> > client side, once the client processes the 1st NOTIFY call, it updates
> > the "state" for the monitor name (ie a client monitors based on a DNS
> > name which is the same for ip1 and ip2) and then in the current code,
> > because the 2nd NOTIFY has the same "state" value this NOTIFY call
> > would be ignored. The linux client would never reclaim the 2nd lock
> > (but the application obviously would never know it's missing a lock)
> > --- data corruption.
> >
> > Who is to blame: is the server not allowed to send "non-unique" state
> > value? Or is the client at fault here for some reason?
>
> The state value is supposed to be specific to the monitored
> host. If the client is indeed ignoring the second reboot
> notification, that's incorrect behavior, IMO.

State is supposed to help against replays I think. This client is in
its right to update the state value upon processing a reboot
notification.
The fact that another sm_notiffy comes with the same state (and from
the same DNS name monitor name) seems logical that can be a re-try and
thus grounds for ignoring it.


>
>
> --
> Chuck Lever
>
>

