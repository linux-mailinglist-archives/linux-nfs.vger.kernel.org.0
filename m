Return-Path: <linux-nfs+bounces-8903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B7A00FE9
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F76318833C4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4691B21BD;
	Fri,  3 Jan 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoRR6c30"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15C145B03
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940188; cv=none; b=EsA0o9ZKMlZiYM47Ozwv4NVQZzUiCafYnZpkE3jePSgryi5P9mvozGRGv4ldeaAUQm3Sw+jQLGFZnbcMl1JkDCr0geMfJeCd7T05jugB+i02wMpnPB1ycOOCVdOtOksoPty+3e1BeaPapMiR7qd+qq9Y/IFRSVBoxx/Q0k83/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940188; c=relaxed/simple;
	bh=KSslk8+8JMqyNV5Bo6SmHvR0n8xN1P4cMW273I7r/Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDWbUk3kPKReRMVVT8KdQW5xEvIlH/FZFHI96F8Vp/DNQTFIZ/WRwtXGOSnh0JQWoB8o5J9TtHcKUIZV1PNXiJwQRdoyjOLXIJ9QnXOSnN/sjK+0JqtOjpZ+xkaw0DZZ+ZtYa7XTpmNhzF/M4YVviGtx22HfDHAnzJ1Nndte4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoRR6c30; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735940185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25aMNH5DbFHUILtYUZR+GF0eSGvkF8m+nZjnBy/VVDM=;
	b=NoRR6c306uzRPlThKTvRlDD56L/kDrzV2fa6FlHI8C89R5DfdqjpQN1HZraM7DkQ4yaV1p
	YqrlTgWwxua50sMC8p+fXTej+oISNTa/jd4BU4jepg3ZMU2avWgLp8ArR14jqUEGfqOBSb
	8ROW92guHOszqlKytACMCUfu6Ds2m6s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-4ElXRyrSN6G2cKgBnWPPmQ-1; Fri, 03 Jan 2025 16:36:24 -0500
X-MC-Unique: 4ElXRyrSN6G2cKgBnWPPmQ-1
X-Mimecast-MFC-AGG-ID: 4ElXRyrSN6G2cKgBnWPPmQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e1b037d5so1094743985a.0
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735940183; x=1736544983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25aMNH5DbFHUILtYUZR+GF0eSGvkF8m+nZjnBy/VVDM=;
        b=DyoBbe60B6CXdltCRgcXyM/I8FZ5MDKkGlL8B0DbeiBwy2jTvG+WAso4p22OhEOZ7Q
         vIqRq6ElfWzkiiZFxYBjmEFcvc18sRTncqZymnfXh5WIUTL+c1Km6ZtLMhQDGtkN6Qp9
         WqS9SmjxPqGeV/ERK/gxam7V1HpOYs+DlC+YwSb9RM/Iiy5RmbLVKNVj0ix54AfNzDHL
         qyY8/bgmiwDi3R5qN5ZxCJAaCvNv1ToDADiYxQVbEfHja431OIMDI7Ys5fuQq7WK78Fx
         t04snuipY+2Z5ayq2HR5oE6Wjz1wANj60PClshcEP4wzBuqGV7azxUCiIy6gFeiSuYyP
         XSqg==
X-Gm-Message-State: AOJu0Yw+BVNLdT35An8EtepbUEXAY1d0OVqi5EIdLFiOv2OZSlJHMy9p
	l/U7FnOMiZbX7UyddDixFjIbYkgMyGh1Af5A7B7v34SH2uNaAQwyIhiwh2YmekPmtbKYRYUuMYd
	IT1q+GGdDqUC/j4U0PEgPsG4n5Tm5j6lFRpcjWVw8mpidurPMXuf0Puz0uJ45t0Rk7g==
X-Gm-Gg: ASbGncsflbxuIHloy4vxrTzugb93sabepZzQdyqqRB5lpxXE59OHfZSF08/x1UmUjat
	rB0TkvuQGRdymQuK5eHWPb6hrBWxNDR6qW1xWrJXTTYPILmdidPnBgj5cKIn/mgp9IrtI4sd9vZ
	HLTOINPxVl5q9jnlVUFk4D2jHoDFfBwWmiQf4Fvb9S5xI8u9BWVA7kgQRfhXZAAa86MsEiUGk0f
	458iqjEfqMqVtSOQy9i/sjB/bwbPkfExE4eJHTOWmQi49segwBS6l9k
X-Received: by 2002:a05:620a:8801:b0:7b8:5629:5d65 with SMTP id af79cd13be357-7b9ba79d2e9mr8285505585a.24.1735940183253;
        Fri, 03 Jan 2025 13:36:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHotFh95FVMS5rSgqeam9tTnp6T0F+5sAKnM+L56CoIrf/+bOqppNBtr3+7zCDnTVFvK33B/w==
X-Received: by 2002:a05:620a:8801:b0:7b8:5629:5d65 with SMTP id af79cd13be357-7b9ba79d2e9mr8285503485a.24.1735940182963;
        Fri, 03 Jan 2025 13:36:22 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc4b7sm1304254385a.12.2025.01.03.13.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:36:22 -0800 (PST)
Message-ID: <d36bdebd-35c5-4105-b96f-f94f7fc11a47@redhat.com>
Date: Fri, 3 Jan 2025 16:36:21 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] systemd/nfs.systemd.man: Fix small wording
 typos
To: Salvatore Bonaccorso <carnil@debian.org>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20250102224510.1145860-2-carnil@debian.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250102224510.1145860-2-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/2/25 5:45 PM, Salvatore Bonaccorso wrote:
> The wording about what is required when configuration changes are done
> contained small wording typos. Change the sentence to "When
> configuration changes are made, ...".
> 
> Fixes: 1b5881d5b9f3 ("Add nfs.systemd man page")
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed... (tag: nfs-utils-2-8-3-rc1)

steved.
> ---
>   systemd/nfs.systemd.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
> index df89ddd13b76..f49e7776a185 100644
> --- a/systemd/nfs.systemd.man
> +++ b/systemd/nfs.systemd.man
> @@ -91,7 +91,7 @@ Most NFS daemons can be restarted at any time.  They will reload any
>   state that they need, and continue servicing requests.  This is rarely
>   necessary though.
>   .PP
> -When configuration changesare make, it can be hard to know exactly
> +When configuration changes are made, it can be hard to know exactly
>   which services need to be restarted to ensure that the configuration
>   takes effect.  The simplest approach, which is often the best, is to
>   restart everything.  To help with this, the


