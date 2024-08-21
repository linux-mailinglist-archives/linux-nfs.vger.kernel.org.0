Return-Path: <linux-nfs+bounces-5549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AB95A54C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4C283385
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805715C159;
	Wed, 21 Aug 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6p3I6+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9BA31
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268700; cv=none; b=uSMFPkaMQ+Gk0kIC5t6hVojFsfexTB+FBlCTEP8s1p2m5h9NT3KuctJEzOyBm3b3IR5G61xpEjQHniOK1a92ekwU0EbcCcQM/M5nnuODJgSdJLEjXD0ecYDGDgFMlQ+PTubtA4Awr/MCXmmKABMYkSQZvdskEHQO+6VPnmnYDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268700; c=relaxed/simple;
	bh=hioNEE2o9WZr6EmsaHIvayFrO8wUziG291jzuQZnrLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTUcqFZ6IZzjjeNKC3PZzET8dhPcfhGXcKgz8SJCkKwUbA0YYx3FeaaQkqH0L5KL3iGfGNJcP5Ef3c5IgnqzB4MfCC7GsOwaWlzevMgq1ID80Kr9iSLsMRIUmuntaFrwIfZPdKxKJqelvozsFMNeYEWGStFAc8luzwHY/5yVmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6p3I6+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0479C32786
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724268699;
	bh=hioNEE2o9WZr6EmsaHIvayFrO8wUziG291jzuQZnrLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q6p3I6+E3miQDuOpMNbs6p45t4uzzazQT3b0kjOTIZq/ybasJKNOD/TpKiUJEyoMl
	 q5KHmZWjqYCVenSXVgeuTw9ezR0dgvw2vNpl93Cd70CNWevnVChTctQrF0+nFN9srJ
	 DXlW2ISKBGDr8ZQsGGG+L3ZAUq7XsPXSTEdBG4zwjh+CWRw9jqJ5xu+HM4C4K6M7Lr
	 DaS+nUCJL/04VS7/9aqPfu3vvxTN6KRDHq4+LH1dBFHqiLihbxNIdBGQhP9owRoru1
	 UEqLZPxorxX9X+bgZ223t96pzn7TNVRK9C9jJ+ekjDx+3YjgNpIJ5tgl3QeU7VfcPE
	 3s4y6VJ2ZsniQ==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4519383592aso497301cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 12:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuci0h9QmsiknpNaONsAdSM0qvajbuPxfVofo/szdNRVilnzI6k6omy4gd/QTyVlP6opkDf4QtlYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjonm6swCfV2xdwo6hjn1ox2bNOvgQ0btgc6aAR/3XTgI9vht1
	RigTcieYnPnhbpzORg//n3JdVVzY+faHHSZV8Nqf5X/58iB2jTcCruemag2PPZCmadKkEyKk+L7
	QFnZembzVetUVD6dUA/XQSdgFeJU=
X-Google-Smtp-Source: AGHT+IHSsftowzOOclVvMNISvqWXw2hPXb+9MdUqSkN5fenJ9/1sWNQ7beyIgGrTLX47flgyP28OySaHm/zzJ+PUVXU=
X-Received: by 2002:a05:622a:580a:b0:451:d859:2025 with SMTP id
 d75a77b69052e-454f26a6e8bmr43481241cf.59.1724268699076; Wed, 21 Aug 2024
 12:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812154759.29870-1-cel@kernel.org>
In-Reply-To: <20240812154759.29870-1-cel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 21 Aug 2024 15:31:22 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmyYciHb0O4Bya+RkwZiZ6FjAKxN_fAPV7bB7cui9dFLg@mail.gmail.com>
Message-ID: <CAFX2JfmyYciHb0O4Bya+RkwZiZ6FjAKxN_fAPV7bB7cui9dFLg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for NFS/RDMA device removal
To: cel@kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Mon, Aug 12, 2024 at 11:48=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Fix a handful of nits for the NFS/RDMA device removal code that
> went into v6.11-rc.

Are you intending these for 6.11-rc or 6.12?

Anna

>
> Chuck Lever (3):
>   rpcrdma: Device kref is over-incremented on error from xa_alloc
>   rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
>   rpcrdma: Trace connection registration and unregistration
>
>  include/trace/events/rpcrdma.h  | 36 +++++++++++++++++++++++++++++++++
>  net/sunrpc/xprtrdma/ib_client.c |  6 ++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> --
> 2.45.1
>

