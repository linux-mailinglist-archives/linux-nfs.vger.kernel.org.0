Return-Path: <linux-nfs+bounces-5551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709795A54F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CC31C21AFD
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292215C159;
	Wed, 21 Aug 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDBbwqQ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE12A31
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268858; cv=none; b=seaIt+pDbKNSaYOZZCluZwyBTQQ5jlOp+P1EkuREnH10kTVxk9qtxZ5J4Vml+6mSvOGnTHKc6SpB6GAsZPlp2bybdEbIeZ1ObSfyIsVLCKwlxrzy1LPDzhaklO0b8baGL7Wlf0x0hqxQlG2xGVjKFpVarEJSehid3koottaBiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268858; c=relaxed/simple;
	bh=G//LQTYOP7TCoJP+6801AZFa7CX0tYF2+5oc1hOwtms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN9vMnTVJiV1FMP2HzNvkaPZAec1IFdxgiBPtYGlKSlumC+HDn2A3336tVvqc0xPNf3JL9tqlOVihHIPAtl8oBbGgq0naJ/K+gVGHJhpftHvDgdy/k2q9g0ZzvXOyfRVkd3HXR5Pkf8YxD3PmElz70SDeaG5peIVVRpjNw2afto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDBbwqQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F884C4AF0E
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724268858;
	bh=G//LQTYOP7TCoJP+6801AZFa7CX0tYF2+5oc1hOwtms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDBbwqQ0jjgqhjSeQQfZD/2/FkjgDz+IpwtgX2hCdvlTbsDHeW0oP+I0QAfHqaEEk
	 cvWbBst5igMLqTw+oPwf+qen4e8g+Gg3NaRFymWPSjthjKH/j+xO0Gol3lNnz3PFAU
	 A40luk2nYv9BBgCwyqq/AYvjDBcjFSzEd0d2cEDX7Q6NM8kbkNt+QkxiKl4IDT5ao7
	 oobv28Omx9puQxe2giple2S1PwHBzXvsDfLIQmZpKubU4PxHLeLZDIrySM6TehFcl4
	 cBHAkByeh+oEQ4FgcvtaP+icPqjH5X/jQO2D1kUTx1AgCWQQ4ep9MMa4Hw6bAde0Jk
	 rNk2e2nYio2mQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db16b2c1d2so17082b6e.2
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 12:34:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5U3O1vSIducIf4khZzxPUpsO5GZ1dgsGlOpx+L/daIftwHnDiXUTKf4JgrvEdEr289A5OAfEWzTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLmF7vMj1CR+TpHbjkQlokwsvkbQP8JzNQawjg4Vdu1ge1YK5
	PzK6E6LuUXvXVZPdFlQAdI/m+2bGEpU1HBOIkcxJPCoYm93zuJekhK/DyZ5VvacHn8slBU3ZCJm
	fb5q44aGr+ZTKo/n5JXS5YeKuLic=
X-Google-Smtp-Source: AGHT+IH+KMjRSKMwTmBbsZqe6O3cIl1rFOQxUuF+YHgRyXSrAyoWOMvz6NXYzJgjcRtfv7kXqRr1/bUhL22XbmN9WSE=
X-Received: by 2002:a05:6808:13c1:b0:3d9:3a3e:48b9 with SMTP id
 5614622812f47-3de1959e7b3mr3686955b6e.45.1724268857825; Wed, 21 Aug 2024
 12:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812154759.29870-1-cel@kernel.org> <CAFX2JfmyYciHb0O4Bya+RkwZiZ6FjAKxN_fAPV7bB7cui9dFLg@mail.gmail.com>
 <92BEC3CC-7A5A-42E2-9BDF-ACCB1BF62750@oracle.com>
In-Reply-To: <92BEC3CC-7A5A-42E2-9BDF-ACCB1BF62750@oracle.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 21 Aug 2024 15:34:01 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfkq8AFHA=o+=_NRU80iCSVBstJioaVXkprw+RUSpR=OUg@mail.gmail.com>
Message-ID: <CAFX2Jfkq8AFHA=o+=_NRU80iCSVBstJioaVXkprw+RUSpR=OUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for NFS/RDMA device removal
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 3:33=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Aug 21, 2024, at 3:31=E2=80=AFPM, Anna Schumaker <anna@kernel.org> w=
rote:
> >
> > Hi Chuck,
> >
> > On Mon, Aug 12, 2024 at 11:48=E2=80=AFAM <cel@kernel.org> wrote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Fix a handful of nits for the NFS/RDMA device removal code that
> >> went into v6.11-rc.
> >
> > Are you intending these for 6.11-rc or 6.12?
>
> IIRC the patches they fix went into 6.11-rc1, so I'd like to
> see these go into a 6.11-rc release.

Sounds good, thanks!

Anna

>
>
> > Anna
> >
> >>
> >> Chuck Lever (3):
> >>  rpcrdma: Device kref is over-incremented on error from xa_alloc
> >>  rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
> >>  rpcrdma: Trace connection registration and unregistration
> >>
> >> include/trace/events/rpcrdma.h  | 36 +++++++++++++++++++++++++++++++++
> >> net/sunrpc/xprtrdma/ib_client.c |  6 ++++--
> >> 2 files changed, 40 insertions(+), 2 deletions(-)
> >>
> >> --
> >> 2.45.1
> >>
>
> --
> Chuck Lever
>
>

