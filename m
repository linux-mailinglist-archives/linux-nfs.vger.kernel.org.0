Return-Path: <linux-nfs+bounces-1620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7B84420C
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632B228F4E5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A269D00;
	Wed, 31 Jan 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="WsRPaPl7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A35A7A1
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712075; cv=none; b=PmBKXZp0NEB8ieqmrS4QksvXfrc42ez2xAeik56DEgGk6z/FI+we0v62nuldXiEuzzjMn6wo9uiUQntrXvQFrLCvkK/p/IfpUM7rcCfTZhA8UlC8FAQHm+M9snkTU7LFCeBnEiaZUyuukgZKdV5zYBcUjP1fywdFkLA9C5VldyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712075; c=relaxed/simple;
	bh=naCzy54kmlRz+T4Cq62hg2BrJxHr+hHKopVqJt2T+bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISPMEauoB90QZISEg/JlNzLaYNPyPxcP7P38Ixlo5b1HfK9hkGiQhl2L1YrHWaFyfVJYIFi5MUitFxoFe9WA/pSqHt/wPklcdTMAcMpYppHD2hLANVERddeyiC3WVN6nrMqRArMxsmQcr5SvCdreZFfVaUKGn9Tsw6mWS8hnNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=WsRPaPl7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d063862047so2542411fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 06:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706712070; x=1707316870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naCzy54kmlRz+T4Cq62hg2BrJxHr+hHKopVqJt2T+bQ=;
        b=WsRPaPl7sAGLy9VMsk6e6GYxKcbAgcbQSZ9tpgY1XYaCn5ild+jxfQeAavU8YBOI4a
         sZFyMD+whsKZia5Ol6QCdABpqfvv3Kt7Sg4VOIpqzAnLkA4aVJgKspLK0iskNMUr+S5z
         iR8XoiCvXnDbW5vHKLbRqC4LPPv2kVUA74fHZoe3tgR1iU8i3pTQgChvfF7fXmZYdL9Q
         NvxSjOkHfNwqW9Lg1Nao5AtITV5NMjqIyp0jHwjmdA6HMpLm/hInq4jwDtBbMYegMaSF
         M8arR/GQCr3xgcxrUciW1m25/J/m9MeBHw9XsDiC0DUmc2axP5tZNQ3r9dVhapNf5BhE
         MtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712070; x=1707316870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naCzy54kmlRz+T4Cq62hg2BrJxHr+hHKopVqJt2T+bQ=;
        b=kWbxgnaB+D1TGA07IP+qrWLFu6jmW5gP//82UA5djWch33UExdjb9A2A9842Q0ot13
         deXV4Ky0F0CExNOdZPJbSRcPZ7P0oMGrCoiE1TcxqHoKl/rJdri98ZFY7SXH9DaAzmv/
         dqpAKMAHbmfd+Qf4C3AKorGG0jYcbXj8lNhko6f4/2DhM2LajmCS/lCm9LytjVVMDOfL
         garbVMWlVCpXzqYgh0754TvWCsTkZ2mbbmKoS+kDUZ311ZX7oUz9PPtBKHfWNV6Uh80w
         XhYAUp0OaW46KUxQ5cTit/052nqv1hOMy7zRHvCjijar6rw0wyug8ZvWR68cP55sx30k
         Be3w==
X-Gm-Message-State: AOJu0Yzlx1cLd4YmLSQWGT2TAL/9cVrbSdzUZjlF3RxT6HrsKm1lqjoG
	acf0Ms4uMWBRMS7JeTFFWKAXAeRyMC89XGHDwDY6OfejzDQLAIdw1+6XINM0a/I7Ls6jk9CRn+0
	38BnkkaFFhWe8ykGOTOJj6Ln5WfmNAwPrF/g=
X-Google-Smtp-Source: AGHT+IGQ3Ht7Xje2e7DFjf2Gs5YbsYZkitvpyE5Cc6S9m3+gcmeYSvKOKWyNpYl2+X6Osreug3WZpWZI3n90Rd2/9ps=
X-Received: by 2002:a2e:1301:0:b0:2cf:1325:342 with SMTP id
 1-20020a2e1301000000b002cf13250342mr1247619ljt.4.1706712070347; Wed, 31 Jan
 2024 06:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
In-Reply-To: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 31 Jan 2024 09:40:56 -0500
Message-ID: <CAN-5tyHsrw-hAWxK5kt3+eLv6BtdVrjNKkt3oZeCY4TUAMjc+Q@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can use python nfstest testing suite (git clone
git://linux-nfs.org/projects/mora/nfstest) and run as a user but that
user needs to be in sudoers so that the test can do a mount. Nfstest
tests for protocol correctness (both client and server).

On Fri, Nov 10, 2023 at 12:59=E2=80=AFPM Martin Wege <martin.l.wege@gmail.c=
om> wrote:
>
> Hello,
>
> Is there a filesystem test suite for NFSv4, which can be used by a
> non-root user for testing?
>
> Thanks,
> Martin

