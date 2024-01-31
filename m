Return-Path: <linux-nfs+bounces-1636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF528844905
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 21:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EF528C144
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 20:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC011BC49;
	Wed, 31 Jan 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoqcgdSP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6424A18
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733526; cv=none; b=YA9uyrQSpyz8kP95VG4UhiUKMEBtne2MbPinM8xuq9/F7YLYzgXXjHkmHi6l+PjUIK2novzZpkAu/40dkwWWmz/XMdGyIHNje5xhmMraO8mXxl6p99Z2A30rC3Fr4n9Gve3ZISsE1jCWucCo5fZVFH4QlRjDYnFmALgxaX73NAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733526; c=relaxed/simple;
	bh=tg27zAtyXt7rLrfIcrUi9Whhdczi0Nui8BLGcgeRvbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9eMmfYGA1g2GmziflhVGc+ya7Apa78GAz8+grDcWv+/57w1fwvLyD0wuDPXBmy9OKabZH/mq5cvy7FnT77fBpEaqJGwJ7mZzlBJb+rVLacw1qtOAzuP7CcIJUHyswJ4OrI8mWjjr2PXGf1NbXnPipAc5w/wqIXfD2jLjLp2F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoqcgdSP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51124e08565so271009e87.3
        for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706733522; x=1707338322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4skPJA2vJ56LGwhJco2Cysnat/idw91vbpowRvolhjg=;
        b=UoqcgdSPsTorX9Xv3sBd7Gw5jZWytP9Yj5s5x1FK7UdNpisuaNpXDwXJROktMDZ4PH
         svXMBhfbadBKq+DWKZZ4w5RQdDEspGSxMJp6ZJZqGOd9H+jh2fWp3z5w3QhQIBzotOfm
         3k1SQ2wXqsja9V413V+KBtqeSAxN90zcwPJNEX26NoJ9l0NTDPmKNdPJZsqVr12LDpWH
         WflgADxuMWCmuOkOS3b7Ffaocg8WLS48xTpZSOi6k0dWSgvm7+vGlPNV4Xsm/tGseLQM
         CU7YBpzP8DwnY4tvom219ApdOdPCyyzoW0V/ECGFkDRL2cGbaql3SgVa0Dee0s0PG9Z8
         +pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733522; x=1707338322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4skPJA2vJ56LGwhJco2Cysnat/idw91vbpowRvolhjg=;
        b=meHFQoz91R9Itag0V94sB+5p0t0UwmVzGXXv6VI2c0bMcg+G0W4sI13sOt35REJLHF
         sWKCP4phcK/ta2VIeBgrVern62YFuEW6tOohHWl0YlINLnfOKDhosRztH3AL/NxT4zLt
         9Kn5OYYJ2d+giDFttJy4SSS1c693oXng+8Pd3TluBQ936aUX6FhFZESwfu0mlMLIc+xp
         4FoUcUES/Zg/SunNnGtDz4iGxTR3DZE2J7CZBGDTppyTiUhEz8bWUPQyG/OmVvKyVNcK
         3gwU9/shLhFxjnq0VZJCjeOCkV/BYg8OR0Eyuq285MaUURXT1MJXbCSCTl3hQxC0FNqu
         om0A==
X-Gm-Message-State: AOJu0YzhuPok60If54HU0oTPjN41nbKoDry7lN1eiTJU6VRzFsT83TxM
	fG35Svw9drELa4D8FlV8o6aC0M2rQ6KGspHXQMIAzyS1HwZcwH6arrsfrJPvdAhcRkYsmgz59bW
	WQbJkQVGSABVNInyaOgbavuZ22O0=
X-Google-Smtp-Source: AGHT+IFbYTVDT+mczKy3WH4NDLBWxYHgJvdDgDLHPsah3qXFzgFVE1rFTwVr9QmEEDpXDmd7I2QsDlQlEWZ1GyD1rG0=
X-Received: by 2002:ac2:4578:0:b0:511:e82:1c52 with SMTP id
 k24-20020ac24578000000b005110e821c52mr418563lfm.65.1706733522316; Wed, 31 Jan
 2024 12:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org> <CALXu0Uc3t6NgvG_FJRvnTYoXKVi2whOWfysApt5Gj4RhAPn0oQ@mail.gmail.com>
In-Reply-To: <CALXu0Uc3t6NgvG_FJRvnTYoXKVi2whOWfysApt5Gj4RhAPn0oQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 31 Jan 2024 21:38:15 +0100
Message-ID: <CAAvCNcBqo55j8W5Pqe0+-AmaqbLoiQtNDKU4C9T0Y7T6aAsC1g@mail.gmail.com>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"

?

On Fri, 26 Jan 2024 at 08:23, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> On Thu, 25 Jan 2024 at 21:44, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
> > > Hello!
> > >
> > > Is it possible for a NFSv4 client to implement TLS support via
> > > /usr/bin/openssl s_client?
> > >
> > > /usr/bin/openssl s_client would do the connection, and a normal
> > > libtirpc client would connect to the other side of s_client.
> > >
> > > Does that work?
> > >
> > > Dan
> >
> > Doubtful. RPC over TLS requires some cleartext setup before TLS is
> > negotiated. At one time Ben Coddington had a proxy based on nginx that
> > could handle the TLS negotiation, but I think that might have been based
> > on an earlier draft of the spec. It would probably need some work to be
> > brought up to the state of the RFC.
>
> What about libtirpc-based apps? Is anyone going to add TLS support to libtirpc?
>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur



-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

