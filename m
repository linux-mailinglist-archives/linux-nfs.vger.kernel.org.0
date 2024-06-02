Return-Path: <linux-nfs+bounces-3519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85318D7431
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618DAB210FD
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E117578;
	Sun,  2 Jun 2024 07:51:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4B171D8;
	Sun,  2 Jun 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717314664; cv=none; b=dFmkZd5b2B23JZVpHWYkt8YCYaqAuKRYQ7dnVIiAej3fxGP8h3xse6uTwZroq7ZtOk3L//gw7k/1zhG22VKt5iHv95yTezecDtnEx43p+R4p3VhSMVCf1PBli4tdh7ETjWCC4aZwfkNOPcyHQnYn/pK6WRlrw9B3YEO17R1Clg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717314664; c=relaxed/simple;
	bh=AZu49nY28ov+iASFfyhKpt3j8P0WVVadjo2Zqlcq6K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxiA+6nlWkO0YbltiZ3xW08jyKxRKpXSIFoxwGuN8mRka12GhWrjU8C+vOa99z/V3bEbwqXh58vuLj5hQEK87vl3kQEHJhhAr7LAZKSGO+VKqVEp7tvKBK6u/9nWEQC6BVhd0xl4kyJyHfajJsgDWUX6GYMIPD+n5xtLniOQu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ea84b9181dso1823951fa.2;
        Sun, 02 Jun 2024 00:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717314660; x=1717919460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/SOWSlctJCblL/nwyH7JDdZwoHFKl1tHUB0yIAR9Gk=;
        b=gzsH0tP52f/3TPfcA60e3LMbXSQuN2KBlQhA5l7YtWxkIpyveXfhnmrwyaGIwgUNbm
         mtyJvU12ccrYinu1yIXF9He7f4IuxuMkrsVdwOUk2qZKk3IOGCUFLWSkk1fTqbrXLBCW
         cLKivTd00U/nTpCuK10+xVSLPiU9Nw1eyrrodzJUuwu32IbeEtW8de6UEaIu1BajyBV5
         0ztVzlm3sA+z3hDYUuVNdvFDDPD+SCdmGG+zmFZNfA5FxIz6e/fw5cPe3F10L7zMp9o3
         n4/iWvfMq/BgWV09XWuzcDcrbouv9gEB2dpV26AD44u7kEWq14bIsDto0WADPFZAg46k
         Sd3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQjxbIxByMxTvi5K2CDtaUzn5e5HJo4bme3Sup6gwEaaak1BxXdZhTgPiwXLoePMZndfzYoWSfbfI24E6Ywnw6dk7KwoPo3JjItD+AxOOgwU8d/yrYtxcS3TRLKd8AGO/INx7Kjw==
X-Gm-Message-State: AOJu0YzPcgSnklllwAIP47mh0UBNvdZ+c62MG91PA0c1LHbunRoSvC/P
	UJbVMx27FLNGcrDou2o+W/hwyCDzljK0hc5m2rtQDvJQogQrGHHQ
X-Google-Smtp-Source: AGHT+IGPxe5Gl5vpA6oWGjpp1Qh7OQr9fo/Ruce71SPYlMdz6kcR6/M1TKE7tTxa/Y/nJD/7tbS/wg==
X-Received: by 2002:a2e:be0f:0:b0:2ea:806a:d701 with SMTP id 38308e7fff4ca-2ea95242b93mr38516401fa.3.1717314660255;
        Sun, 02 Jun 2024 00:51:00 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42123458f78sm119521935e9.1.2024.06.02.00.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 00:50:59 -0700 (PDT)
Message-ID: <5250bfd2-1268-4ab5-8429-92227a4a049b@grimberg.me>
Date: Sun, 2 Jun 2024 10:50:58 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix ADDR_CHANGE event handling for NFSD
To: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20240531131550.64044-4-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240531131550.64044-4-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/05/2024 16:15, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Sagi recently pointed out that the CM ADDR_CHANGE event handler in
> svcrdma has a bug similar to one he fixed in the NVMe target. This
> series attempts to address that issue.
>
> Chuck Lever (2):
>    svcrdma: Refactor the creation of listener CMA ID
>    svcrdma: Handle ADDR_CHANGE CM event properly
>
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 83 ++++++++++++++++--------
>   1 file changed, 55 insertions(+), 28 deletions(-)
>

Looks good, For the series:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


