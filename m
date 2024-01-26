Return-Path: <linux-nfs+bounces-1449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC383D1DE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 02:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E6D1C22EEE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3638C;
	Fri, 26 Jan 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvjzlKnK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62045387
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231154; cv=none; b=Iz+7eXt9sJ+yaFbDWP/ZGP7hCF7xn22DUs9IJIc/7dQzo7xaYf96nTqR5WyIXdbUOrCl39/NadqaSq1NNrwmyIMxE/s+zHtvxCs7e6dbep+mvshMmKHHDzrHjsDj07ZsR+afLdPWxRwh1+zCBoXnFvtGZEpA07wQitF0mJtYc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231154; c=relaxed/simple;
	bh=9DmY/5ilPtRdFKrXsl0XOQZwbjhlnMMXpdaHCd8JAhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4brM+doPI8vFMIp7+fDvt6USGlOyHBEwFlb3B8hzUD05WaXQVSb5tftOyS/Rp98HZ07/PrsVokAh1HViCwh9t888h6QpP4ME4M7I+PO82XqDiYAZQM1zSc7ph97NTzlJpn/YKKI27Y7E7RgCXXhxx1zE1d8LfJFlX+Fcb7pMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvjzlKnK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3ea86423so11490711fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 17:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706231150; x=1706835950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkTWF/7nlW+bzEvFkOp8qCgU92UUZyrc3SYE9aayy4E=;
        b=dvjzlKnKgaZTZ74LM5D2xsA6FUBV1hhLw9qM4AB+Uq0yvykjXC8IbTrdhW2rsNIuCt
         z/8cflQ5memPUdcHE01bZG+y7gcPxIi/psnt38OTW5xaWfG4+hoxTAnYRZpIgkc4fWSO
         TswYmGR+zv6OY2K12CsCTOgd0K1kRBIz/MUvVv24RcV2ETEhGYbEho4CNJHzx7dJ8T0V
         GZKAcirLcibczPQ2XFxTXpMuGWjuqWKxSxHQFNsdauKUYJIA6OmgnDRsT5cGpbXky2np
         46bVNEyBoSTsfv4B23CjoTZSVZ3kaAZ4So+dWdWxFsYmEpZzWq2z3OkGY0hQ37McO/Ph
         isng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706231150; x=1706835950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkTWF/7nlW+bzEvFkOp8qCgU92UUZyrc3SYE9aayy4E=;
        b=xHeIBzcN4T1F2//Wtys57xE7qJ6tcT9KwKcm8I4LH7TkSH4jXDX5QHDlbd0jL3wkla
         VrGgt278IxUnxTYEEVVPx4U0UOs2x56IanVDNmFCECkJsyGrhKT4QXfWn1G5GtY4fzzg
         w0y4R9bNODmOFZO4Z0L0RUCOP51UjUorwrsXUm4l/x91Yi/IVu0GSxROU6WDWVy4hoCs
         GFKXfE+DvIfyTcoEDufGvw6aqKSR30yb0F+AIzaRD8xEdFfbUlheYOc7cRbEjMyDaHKL
         C9JodksoJ9D5oC5v9mBdD+odZ0Bkq9Yn08P8Dyt1CFeQiiqUoHJiqLmtzDVbiiSIEL85
         0w0g==
X-Gm-Message-State: AOJu0YzIClAoEM2bCCEJQ3QX7a3Rwd4w9nwdoOMpJOUgVl90jkOHBudw
	cVmnbb/8ApI9gOCshHxaZDLpfHy/TUiY22fDPqL/uFxpnNd2ZdzllqeMwNigpMzD6/8f8JVzvEf
	mr7JSBdrnmZxVMhTI5isxyQ7biQk=
X-Google-Smtp-Source: AGHT+IGD2HnMHJZT3qKY/ULBW+2tabRaprpyR8onN7IKP5TZ8VlMS+4JuEnlS+vEr4WV5Z46wcpxjzj47b1eyuMIHvY=
X-Received: by 2002:a2e:a715:0:b0:2ce:19d:2118 with SMTP id
 s21-20020a2ea715000000b002ce019d2118mr230974lje.6.1706231150142; Thu, 25 Jan
 2024 17:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org> <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com>
In-Reply-To: <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 26 Jan 2024 02:05:23 +0100
Message-ID: <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 22:11, Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 25 Jan 2024, at 15:37, Jeff Layton wrote:
>
> > On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
> >> Hello!
> >>
> >> Is it possible for a NFSv4 client to implement TLS support via
> >> /usr/bin/openssl s_client?
> >>
> >> /usr/bin/openssl s_client would do the connection, and a normal
> >> libtirpc client would connect to the other side of s_client.
> >>
> >> Does that work?
> >>
> >> Dan
> >
> > Doubtful. RPC over TLS requires some cleartext setup before TLS is
> > negotiated. At one time Ben Coddington had a proxy based on nginx that
> > could handle the TLS negotiation, but I think that might have been based
> > on an earlier draft of the spec. It would probably need some work to be
> > brought up to the state of the RFC.
>
> Yeah, its' a little bit rotted.  Wasn't super fresh to begin with, but it
> did help bootstrap some implementation.
>
> You could also modify openssl to be aware of the clear text, something like:
> https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0a6c87d5878348c
>
> .. but I think you're definitely in "what are you really trying to do?" territory.

For example legacy NFSv4 client add-on? You cannot expect that
everyone can or will update to the latest and greatest version, so
either you have clients without TLS, which is a security risk, or have
a way to retrofit them.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

