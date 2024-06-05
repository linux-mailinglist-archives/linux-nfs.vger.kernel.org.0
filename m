Return-Path: <linux-nfs+bounces-3559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D068FC6C9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E19E1C22AE5
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0B1946C0;
	Wed,  5 Jun 2024 08:42:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291931946C3
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576950; cv=none; b=LUDuDDGGYXLJR/xGByfa9bi+F1BnOHmbhLfVNJ01BbSxWJ3DlqT4jwmNvCCtkWtN3H4TrMCrc9qvNpnVf1STZsdYhUcz8xpPtNIt4ZKXCUI589zUDDjYzL+ruPOmlsUaUwcCGsUPhVA81EicEr20+Nat8U+utOfPtAaYJp8FDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576950; c=relaxed/simple;
	bh=P4M4MqXPdfStaxRovxntDkhfu0FZYLwXIYeKWyYbmto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqIFZROkGEGNIDHxaZrvtjFBp4zt4zu3TYZ9JLTN+TIY7BMC2MzNScxE6lb6NAxns8L4cm9VHA2bgAaVQr/WCklWnYoZwwSvyq+30eGDDYCRkv+PMofLAp6m/bH1ASt6BgjXYLT12uYVXUxKjd5ryTzKnNuFaoauvjCaxeNlNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421498a3ccfso2124435e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 01:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576947; x=1718181747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gF2K7qRQ3IrsmR4TpwYBfaLg0wle65nX8emoO5du54Y=;
        b=WzuVoQuADwIii3MB2umlp6FlBE4WzsXQyh0HeWtXb78DFGtrnF/862F2VQo6zLqy5+
         jVG/AqZYoiK6joiTC/g6F8gxspqNxMjDKQ9NtgK5JEGJhTZIaqpAL60s4EK51nbm8ogR
         DX0qBkg9Pxvm0g3x+mpgpyNkfKpe1FYJFt2bCde6lRoZ11Nps/8p/Al3cZh/EWn67R9L
         u88eIf0KcSoI3VzEqt5qr2/mBK25bPnbnKcHx3HSNRWr2DiknBTop2cvDNVgL6C6/izS
         nkOfcymX//y6B67ze//r5+xpKjun1ZdlzBkoHZONQFWk7ObhouEKOYlrvWKNA7lG5CVV
         q9xQ==
X-Gm-Message-State: AOJu0YyKOSwBMo0Dz+eOkQlZCNJPIWAG452N41TlJCTp6Aw+LKs4ndjT
	6QrnMTl/EVOvPE9g4AjpG/PBbS7qFtMSr0MiMmPh+KO3w+MzPosVdOSey0S/
X-Google-Smtp-Source: AGHT+IHTjY6WWPUAXjjECEkUza25N+0RaN4SMghv/ggiJHzb59GiDp04f6+DccZnxmzhQadg78yYPQ==
X-Received: by 2002:a05:600c:35ca:b0:420:29dd:84e2 with SMTP id 5b1f17b1804b1-4215633fe1bmr13929465e9.2.1717576947245;
        Wed, 05 Jun 2024 01:42:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158102a69sm12428625e9.15.2024.06.05.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:42:26 -0700 (PDT)
Message-ID: <21f6b999-ce54-4756-b687-84c1c746ca49@grimberg.me>
Date: Wed, 5 Jun 2024 11:42:25 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] xprtrdma: Fix rpcrdma_reqs_reset()
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20240604194522.10390-6-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604194522.10390-6-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/06/2024 22:45, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Avoid FastReg operations getting MW_BIND_ERR after a reconnect.
>
> rpcrdma_reqs_reset() is called on transport tear-down to get each
> rpcrdma_req back into a clean state.
>
> MRs on req->rl_registered are waiting for a FastReg, are already
> registered, or are waiting for invalidation. If the transport is
> being torn down when reqs_reset() is called, the matching LocalInv
> might never be posted. That leaves these MR registered /and/ on
> req->rl_free_mrs, where they can be re-used for the next
> connection.
>
> Since xprtrdma does not keep specific track of the MR state, it's
> not possible to know what state these MRs are in, so the only safe
> thing to do is release them immediately.
>
> Fixes: 5de55ce951a1 ("xprtrdma: Release in-flight MRs on disconnect")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/frwr_ops.c |  3 ++-
>   net/sunrpc/xprtrdma/verbs.c    | 16 +++++++++++++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index ffbf99894970..47f33bb7bff8 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -92,7 +92,8 @@ static void frwr_mr_put(struct rpcrdma_mr *mr)
>   	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
>   }
>   
> -/* frwr_reset - Place MRs back on the free list
> +/**
> + * frwr_reset - Place MRs back on @req's free list
>    * @req: request to reset
>    *
>    * Used after a failed marshal. For FRWR, this means the MRs
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 432557a553e7..a0b071089e15 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -897,6 +897,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
>   
>   static void rpcrdma_req_reset(struct rpcrdma_req *req)
>   {
> +	struct rpcrdma_mr *mr;
> +
>   	/* Credits are valid for only one connection */
>   	req->rl_slot.rq_cong = 0;
>   
> @@ -906,7 +908,19 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
>   	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
>   	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
>   
> -	frwr_reset(req);
> +	/* The verbs consumer can't know the state of an MR on the
> +	 * req->rl_registered list unless a successful completion
> +	 * has occurred, so they cannot be re-used.
> +	 */

Theoretically it would be possible to know by inspecting the FLUSH error 
completions
and see which of those was a registration wr (meaning the registration 
was not ever
executed).

But I guess its simpler to just assume that it isn't reusable.

> +	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
> +		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
> +
> +		spin_lock(&buf->rb_lock);
> +		list_del(&mr->mr_all);
> +		spin_unlock(&buf->rb_lock);
> +
> +		frwr_mr_release(mr);
> +	}
>   }
>   
>   /* ASSUMPTION: the rb_allreqs list is stable for the duration,


