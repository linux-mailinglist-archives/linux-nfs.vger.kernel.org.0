Return-Path: <linux-nfs+bounces-3517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7C8D6F64
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jun 2024 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E251F22402
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jun 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB222625;
	Sat,  1 Jun 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo/oRG33"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C42208A4;
	Sat,  1 Jun 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717238924; cv=none; b=e9rvNz+/qAuhOM+B0O9/DMtZayi3apIXQmKEcSV10uQuaGZsNPuIGWekcBJYhs9rbwNIICwxV0BNklyXcEOwdIOarCfO1q/DXPjtHPkpNsOmuSJPljoLZ16MCuZJM59t6UpLwIKfDjEh+TDmNVzYgOvCwaJXhf/C5kXq4RBMWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717238924; c=relaxed/simple;
	bh=t7Yxc/sMMXjQyys67Hy3ZCEYasLuO5tPNCSbnM7JMp4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K2BrqcT7quRfNjrjgLpfuZlFZXzxJUZtaruroPajewqptnFTXL2H/KZtHaXSb/+uzE+8JoY2gjaYApQZbywP3aJE61Iqz9cmXY+ewvtxM6XzTDkk+yGHS6S4Y3wG9Lq4KfCLd0ppCNqcKx2/T7/ekUKt3GM6VCjcfaQe81TIipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo/oRG33; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so3191234a12.2;
        Sat, 01 Jun 2024 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717238921; x=1717843721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trttD0uWfUYffFlBENVoJn8IhNqw4mAtThQYet7wC/A=;
        b=mo/oRG33yAqmJTYivLNVPFLrx0ZCc+8trJR4EObEvIfyJJc40mqIp07mr3IzTm2Yyc
         FOR8/ZPCfAD5Kbkx7go+mlx+JAIEb1o2pJbW1RkSiUVRiJiK/f1IkMYlEudbQ/329THg
         qG/qf352aZYyDOym+y15JI4xFfXQc3Tuccx/JomN85PmJ4CAE5ZVoHmocwFJdGOy9buG
         tGKzjR6Fdgo66nmgJ6S2Z/PB7FAsR65j8MbMPkqk9tWiEuiZXaPeXysNvrl9oPl2g6p/
         Ox+8ZRVpj5Iu2LL1zxVmxgQgnzdHMUplZpkZT6q8bK+HGqAJ0K5ekwqwUvvV7TNEulJ+
         E+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717238921; x=1717843721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trttD0uWfUYffFlBENVoJn8IhNqw4mAtThQYet7wC/A=;
        b=Klt3xwUi4NlCckIbwPLUVzh4nFjsune3JOcHFvPQavmcxJ+xn6d/zjipqn8mJt19hC
         bfIqq70G2PTcWza61FQE2ESaBGUixsx9aEFSOoYcTM09T8LYKIZs8AdCkYfMLZM/rqOJ
         G0rB28XAh9pBUrx0oB+7Zan8bNacJSmwCsBcnnqH0dOGApVAd17hsKWu9O/h6GmHeHf+
         VZQT3t3QVXMwQSdxIElqAIUs3qUGjP5kCTjSF6cXfbv62DV4UwXnte/movacq/xIlSSA
         4NgMXX2itfVYOZfk10JJOHGtimY6YSqPnCcJKOIcfxFLgFI0+SZ2J5anDbZmvvO62Q8t
         IqAg==
X-Forwarded-Encrypted: i=1; AJvYcCX3yt562WAP8gbtTgB55aio8JsOrlrozuOAGXOt07yP6NbAdIXTdPXyDjPpZdDN2M/Uk+19ObCmA0UKMe1tQz5h6yvbyaXUBdLVIgdBzwsncX2tkQNebMPRndOgTyhh2zLKgeA2QA==
X-Gm-Message-State: AOJu0Yw2bLXOVwB+zQIhuycEWeOrcbCuqj8mdKSg1mz8SAfinxuCx9Sn
	2EVYc+bExCKL0q/OtA6aMwDyG4r2quGgCluX9HYNyi+9rWtDhZ8i
X-Google-Smtp-Source: AGHT+IG66buVC88Xhu49p/nRbGcNmKQC7DSO7MPLDmVX1/IRePGfBk5v4W5HQJMeOt2AVMP6jGLtWQ==
X-Received: by 2002:a50:d518:0:b0:57a:4b31:5d71 with SMTP id 4fb4d7f45d1cf-57a4b3160f6mr715471a12.26.1717238921263;
        Sat, 01 Jun 2024 03:48:41 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm2091633a12.18.2024.06.01.03.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 03:48:41 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <2bc28d01-0345-4d30-870a-3c5506936401@linux.dev>
Date: Sat, 1 Jun 2024 12:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] svcrdma: Handle ADDR_CHANGE CM event properly
To: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20240531131550.64044-4-cel@kernel.org>
 <20240531131550.64044-6-cel@kernel.org>
Content-Language: en-US
In-Reply-To: <20240531131550.64044-6-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 15:15, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Sagi tells me that when a bonded device reports an address change,
> the consumer must destroy its listener IDs and create new ones.
> 
> See commit a032e4f6d60d ("nvmet-rdma: fix bonding failover possible
> NULL deref").
> 
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index fa50b7494a0a..a003b62fb7d5 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -284,17 +284,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>    *
>    * Return values:
>    *     %0: Do not destroy @cma_id
> - *     %1: Destroy @cma_id (never returned here)
> + *     %1: Destroy @cma_id
>    *
>    * NB: There is never a DEVICE_REMOVAL event for INADDR_ANY listeners.
>    */
>   static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
>   				   struct rdma_cm_event *event)
>   {
> +	struct svcxprt_rdma *cma_xprt = cma_id->context;
> +	struct svc_xprt *cma_rdma = &cma_xprt->sc_xprt;
> +	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
> +	struct rdma_cm_id *listen_id;

I am not sure whether I need to suggest "Reverse Christmas Tree" or not.
This is a trivial problem. ^_^
You can ignore it. And it is not mandatory.

But if we follow this rule, the source code will become more readable.

Zhu Yanjun

> +
>   	switch (event->event) {
>   	case RDMA_CM_EVENT_CONNECT_REQUEST:
>   		handle_connect_req(cma_id, &event->param.conn);
>   		break;
> +	case RDMA_CM_EVENT_ADDR_CHANGE:
> +		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
> +						      sap, cma_xprt);
> +		if (IS_ERR(listen_id)) {
> +			pr_err("Listener dead, address change failed for device %s\n",
> +				cma_id->device->name);
> +		} else
> +			cma_xprt->sc_cm_id = listen_id;
> +		return 1;
>   	default:
>   		break;
>   	}


