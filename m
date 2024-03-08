Return-Path: <linux-nfs+bounces-2240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E2875EB5
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EDE1F236D3
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCF4EB43;
	Fri,  8 Mar 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIaoYzZq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD42C1A0
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883696; cv=none; b=DV0PJ2y9mUgqOUJFMCmQ3WguQ8TG304RtvGcTdX6RUCoZ4h+0TwlJQV2qTNBuNB0VHvkWc5RO+i7RnEAx6OZRgudOAU9BtIB68ZiaKwKwEXoHyWE4aYydmpJAbulIWGbV7dfaxrUxWmsNd4uj7l6swbuHsajAurnUFf1oXgIkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883696; c=relaxed/simple;
	bh=ReiTsPORY8KNb5l4znBcNuNed3hZlhXs9hhiGMS+dsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tWjCoodfclQNYcjiRIpVeUQ2yi79BKxkJTa0TkR7lCMwfFkJB2DIw+in8ZiEPQ/Vf8KDbya4NsGfK3sbbUgYIhzBXWt0cch37MOqkjH8h5QH+QrMhjVKruWEJdPPJLBNo5v5+UrPjdHAoGuUAxuaVyF9bPmHTFbjzSKcPLaqsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIaoYzZq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso1998114a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 07 Mar 2024 23:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709883692; x=1710488492; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJHC+C6OpORgzMEfxDfo+Evt+CYYBIEXeRxhcS1XM40=;
        b=aIaoYzZqEGFvUZTritZqdpPtIYIbz7MdFSoRI1u87Lg57HISFhn45lg+DeHWXCfKKa
         UOCGfWVhQUWeaLY3X3HWvy3m5mhB14fmjzz0yPKFzxPRzytK8W8bwmNlgaPA3BzNogGt
         xofmQ3wDTQO2bqcb079nYD5n4YPr/izP5u4J37u1IxkvzfoTHKkVWjCOrPH31flngyFy
         GcQWdXjtQWz2ZCAiW0UdbtHDsndIiFslgeSgguGYSQlXaej4Y7bplJYjoJ44RdfgAd91
         BYkpq47rhx1t0z445J+krNBkhLM5irjlaOZjiYc1MULg5quOdU6dErBbNTUQw7KV2GJ8
         BGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883692; x=1710488492;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJHC+C6OpORgzMEfxDfo+Evt+CYYBIEXeRxhcS1XM40=;
        b=Oj8akdyA9DaKjpLE95LYoBWppFunemxSN1ghWO6U02l/Agf4myZOdZlT7EN1yTj5N7
         9e9xlCJvvHC3c2wuQPhDTGbMZLe+SwZ2v/exNIn0gVv/4njP4+Oi4J5c238/sYao9Kme
         panEiUn2o6XJLaVFx2jhjC/xgQtDjLJl1eTuufjFuIm7w5gUzlkRmsapB1T300Yc/ZSa
         5te4wW9n39EtLbXs0e8Gfzv8asV6Lok30BB8XPbZxUGGBCzkLOkM6JsDGcrsoyDZ5KYP
         LQnujZM2Ot2DPuuWUC6xyhPPH9bVay6WQbbj14dSZBcXHR7uPm2TJAXEDuH+fthKFaqM
         tH9Q==
X-Gm-Message-State: AOJu0YxVpo0h2gKH0ZS7YFnWkWcS6hTtsXBKJz0u+6ZEcmTkXBEyLKD1
	NM1Y6tOK3k9pVn75x/AbCAKVoP3Xo+LWVEbozVM96n2niMjxk6udaUvRQQjPORp/8kGAid/GWdp
	pUUJmjRvdlt07WYoNsOiOBi5WSUpdwhzh
X-Google-Smtp-Source: AGHT+IHUpCJWfih/kzvFdlcEyRybtU6aJTp2EoPwvuCmeAYG2R5ppZ3dZSEaxLU1CVBLPA7gedsPwJEBgtmh0d2oHyA=
X-Received: by 2002:a50:85ca:0:b0:567:de59:e93e with SMTP id
 q10-20020a5085ca000000b00567de59e93emr1193594edh.25.1709883692552; Thu, 07
 Mar 2024 23:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307213913.2511954-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20240307213913.2511954-1-trond.myklebust@hammerspace.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 8 Mar 2024 08:40:00 +0100
Message-ID: <CALXu0Ufw4JW3bi4tapC5xuDwLi7NQA+LV0eBTpaKga8xf+bNYw@mail.gmail.com>
Subject: Re: [PATCH] nfsd: allow more than 64 backlogged connections
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 22:57, <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
> we currently limit the number of backlogged connections to 64. Since
> that value was chosen in 2006, the scale at which data centres operate
> has changed significantly. Given a modern server with many thousands of
> clients, a limit of 64 connections can create bottlenecks, particularly
> at at boot time.
> By converting to using an argument of -1, we allow the backlog to be set
> by the default value in /proc/sys/net/core/somaxconn.

Could you please port this to the Linux 6.6 LTS branch too?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

