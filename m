Return-Path: <linux-nfs+bounces-17447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6137CF2384
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 08:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DCF2301A732
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA07296BA4;
	Mon,  5 Jan 2026 07:24:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FFD274FE9
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597855; cv=none; b=Pa3zPrj9hpqM8I1HkXTarGjOdY/si6cgNX5ImNVAfo1exavANCoTuPnRHAWlaJoHeV6vN74pQR7ZCZQyAqkga/BGN+TKZ7lPoGCuV6PTweyJ8vDhWsycNL7H9VACzCH0Ph2bsZFh3YWwuq0GbDAN1WSFAxOONSYtU11JbsQJSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597855; c=relaxed/simple;
	bh=Xm/IlbzbWPxBGHhB2QdSkIrzbLzNvpbpfFPkn6N/DRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UnLmLEkGKG8JduRKv3fAIHV6doep63COSWy+WpHnoRZv4YMWcihkhRPZXq8xTqTLHQjM1YW54MoR8VECRz0ecUyRE1yeztrhXyPecb1rC8fFq6QTTOlt0XRKPtV4vWu5L2xld5bd7n6lTmYDedAbxDulH/sDfCnE8CubEVIvbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso8440435e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 04 Jan 2026 23:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597852; x=1768202652;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pj/CwMnr63WuBiw+FNTr9nYUIOuneOM4Jn5Fn6kjIU=;
        b=kM9BVS81Lcz07tXgcM7xgsPBSsigPc/LhgDu023XRl2+Of6CQEQ6wbW20qWpKw1USB
         yPnclHtJ7ZB1asWAR1b8YRhqhO1aaxaa5g3EY4EFe5hCMhGBfpIyUMakN4ZwfwvKwhev
         L3CtcR+94LH2/1/OLX1zNeVhTtDKzo1+10sQ4O0/SKxp+rfoJul9IYzex91G917ugzlI
         E73ZVUEIOCpJSYGznlOzs73praiuJn9onYBKIiGsZzRkCtBU6aDjRTk/6WgKnvS/qcEt
         aDFcsTn4wUBNHp0F49/qRhZPBY8BE6K93YvBxT7vsZmz0ci6Rld7mNgcibQfYPyx1rv4
         cJww==
X-Gm-Message-State: AOJu0Yx15cOT4Hi1FDJT1iyylFaiNR02WwH6TcQGwHB3qIrGbg02TjYq
	37vlqP6Kf3yVjXsC6iCTrLLP+SwC1HuS/bkHAYNsFt85jI9EdmnynCL+
X-Gm-Gg: AY/fxX4jCqxsnT/0AmPOOicLJwN0yHm82h+Nqsf232TAdW56xvt/XUG14lAutr1nN0q
	Bllmwl1wlFp8kWuFHNZMrKPwU8snYhg2s8o/whLRZmLb0ziwutqPLo1xQ3iaTSmMU2ZqGRkgvrR
	7CBr9UHypn/X7upqXHcR6jqD+EWF+B/w/adQwDYHBie37NUjvLtAXCm39YZk6ByF0YDN+A5KWUl
	P+aoChFZ3X2ljdWNK2qmr6WQRmnAgVvAjO+2UzmB/I2JIh7e8B9QhD8dld48xWAa2vuCRKpxSwq
	i4B8vAADsdntNgGuhVBRdN5oMZtxlcC7mCIYwlh71Mr34p6xkx4Lf9Lpejynd9Ff6tGsT37TBDH
	4oCH2Ru/BTEekNi/kqAP2Ni6go86A20bH0DWTuxaYHPia3F0ZbDmdjk8Qg4M7RUm5fWIdODfcGH
	z4Af8LeU9N7QHyt2IhoBaThxwMWvpSFor/zv/DGc+Yefs=
X-Google-Smtp-Source: AGHT+IGBPvwVoUaMD9UO7fxQP9uem8zkBXimV1J02SS+DqS17wSjpd5bSd6ORu1C4DJ/rXXiGX9xhA==
X-Received: by 2002:a05:600c:3106:b0:47a:829a:ebb with SMTP id 5b1f17b1804b1-47d1957b115mr575282195e9.19.1767597852037;
        Sun, 04 Jan 2026 23:24:12 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13e2c8sm140558465e9.2.2026.01.04.23.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:24:11 -0800 (PST)
Message-ID: <f508a557-0548-4fb7-8606-7f4bec35e875@grimberg.me>
Date: Mon, 5 Jan 2026 09:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/nfs: Fix readdir slow-start regression
From: Sagi Grimberg <sagi@grimberg.me>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Reply-To: sagi@grimberg.me
References: <20251227104629.234133-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20251227104629.234133-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/12/2025 12:46, Sagi Grimberg wrote:
> Commit 580f236737d1 ("NFS: Adjust the amount of readahead
> performed by NFS readdir") reduces the amount of readahead names
> caching done by the client.
>
> The downside of this approach is READDIR now may suffer from
> a slow-start issue, where initially it will fetch names that fit
> in a single page, then in 2, 4, 8 until the maximum supported
> transfer size (usually 1M).
>
> This patch tries to take a balanced approach between mitigating
> the slow-start issue still maintaining some efficiency gains.
>
> Fixes: 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - minor phrase
> - added a Fixes tag
>
>   fs/nfs/dir.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Anna, Trond, any feedback on this patch?

