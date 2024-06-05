Return-Path: <linux-nfs+bounces-3561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B109E8FC6D3
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83D51C20CCE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457E1946C5;
	Wed,  5 Jun 2024 08:44:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF871946BE
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577079; cv=none; b=Q/xPsZz2MS/Yk5ftpoTEq77MJ0Yru5HvwDd71QrrFRGiGeN1qbOXzNdv+PLSOejWFV/+cF+gKLteI6NqoKmCRdyt7LJTZJqNBmW6MD8BcnnTTkXNuj6us1hA+dd3IwWmToY3fZNnOgrbHyAffhImPMtuFWgUaRY2iKwzDX+AtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577079; c=relaxed/simple;
	bh=wSXShM8/0VZgbtIZEyTzzy+RxAFB1ryL+kawE5MJJi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyIIt3z+tJAgGXaHyQOj9fvbbG5fas/upoylws2nWv3cPINSG5bQIKWI2Lsnsjk+TBSl4G0fPeWXTONqE1aaOIne4NWHz36uPWrwTnpSDHiIEoH1rzfCbu+1josgFbVwg1/t4/wkkRLbgWgqxgIrfx/AmG67FhsxmTMPtnj+Eio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42111da672eso7882435e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577076; x=1718181876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVsIp2bd5nPtNj/IiJ02dbiwnJAtcKxSTnzV1zE5TF4=;
        b=N1w7vmCpkU4KMr37Nv6BRgPFskFkyswc3B0w9aG6odM4WQfEhP7R/4DG/B1SEiL6bH
         srpezR66xksDVmyE/kKsjTo2p1GjiI952sldySVnAVOvvhDsnaafTdYT+FgX6NxIrBAX
         wCwKcYBxXZaUzdAh09O2u0mNWE/J5exJGpMrq1po04gqBafqj2Zl48dpjLyC/XlII0IU
         gwqmp6T4LkGMNaY6Yrt8t4/g1+pAtf+IyUmJ/eiY6f4k9SThlhHb0ojfdjVCjQH/ggEq
         Z9m9ggGOKo7F8v6OE/8E0SAj2SAAqSEYquTMVAdtMljsXNAFZ4KWoz0k5Vhn54B5w/xL
         uhCg==
X-Gm-Message-State: AOJu0YwLMyxdBWXkrMqXICeL9uPzos1xy0f1eG3uGpn9r/uTTQkyMa9U
	bxifjqk8owMFrtDZz6DrA3Tp55bGUpV5DBHya8i9/KagwLzwz8U8
X-Google-Smtp-Source: AGHT+IG7wBAeGznJzlc9ZS85pUcJrGko4uqjnSWNOt1xJvExX5rw2/FxVcQ2XH5iSAd3QFCUdY3pag==
X-Received: by 2002:adf:e402:0:b0:354:d14a:cb60 with SMTP id ffacd0b85a97d-35e929c8a81mr1156969f8f.7.1717577075662;
        Wed, 05 Jun 2024 01:44:35 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35eec1745a3sm720554f8f.4.2024.06.05.01.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:44:35 -0700 (PDT)
Message-ID: <f5a17f07-634c-4e61-a4e5-e6ff78301aa7@grimberg.me>
Date: Wed, 5 Jun 2024 11:44:34 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] xprtrdma: Handle device removal outside of the CM
 event handler
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Dan Aloni <dan.aloni@vastdata.com>
References: <20240604194522.10390-6-cel@kernel.org>
 <20240604194522.10390-8-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604194522.10390-8-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC Dan.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


On 04/06/2024 22:45, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Wait for all disconnects to complete to ensure the transport has
> divested all of its hardware resources before the underlying RDMA
> device can be removed.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/trace/events/rpcrdma.h  | 23 +++++++++++++++++++++++
>   net/sunrpc/xprtrdma/verbs.c     | 23 ++++++++++++++---------
>   net/sunrpc/xprtrdma/xprt_rdma.h |  2 ++
>   3 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index ecdaf088219d..ba2d6a0e41cc 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -669,6 +669,29 @@ TRACE_EVENT(xprtrdma_inline_thresh,
>   DEFINE_CONN_EVENT(connect);
>   DEFINE_CONN_EVENT(disconnect);
>   
> +TRACE_EVENT(xprtrdma_device_removal,
> +	TP_PROTO(
> +		const struct rdma_cm_id *id
> +	),
> +
> +	TP_ARGS(id),
> +
> +	TP_STRUCT__entry(
> +		__string(name, id->device->name)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		memcpy(__entry->addr, &id->route.addr.dst_addr,
> +		       sizeof(struct sockaddr_in6));
> +	),
> +
> +	TP_printk("device %s to be removed, disconnecting %pISpc\n",
> +		__get_str(name), __entry->addr
> +	)
> +);
> +
>   DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
>   
>   TRACE_EVENT(xprtrdma_op_connect,
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index a0b071089e15..04558c99e9f4 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -222,7 +222,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
>   static int
>   rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>   {
> -	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
>   	struct rpcrdma_ep *ep = id->context;
>   
>   	might_sleep();
> @@ -241,14 +240,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>   		ep->re_async_rc = -ENETUNREACH;
>   		complete(&ep->re_done);
>   		return 0;
> -	case RDMA_CM_EVENT_DEVICE_REMOVAL:
> -		pr_info("rpcrdma: removing device %s for %pISpc\n",
> -			ep->re_id->device->name, sap);
> -		switch (xchg(&ep->re_connect_status, -ENODEV)) {
> -		case 0: goto wake_connect_worker;
> -		case 1: goto disconnected;
> -		}
> -		return 0;
>   	case RDMA_CM_EVENT_ADDR_CHANGE:
>   		ep->re_connect_status = -ENODEV;
>   		goto disconnected;
> @@ -284,6 +275,14 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>   	return 0;
>   }
>   
> +static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
> +{
> +	struct rpcrdma_ep *ep = container_of(rn, struct rpcrdma_ep, re_rn);
> +
> +	trace_xprtrdma_device_removal(ep->re_id);
> +	xprt_force_disconnect(ep->re_xprt);
> +}
> +
>   static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>   					    struct rpcrdma_ep *ep)
>   {
> @@ -323,6 +322,10 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>   	if (rc)
>   		goto out;
>   
> +	rc = rpcrdma_rn_register(id->device, &ep->re_rn, rpcrdma_ep_removal_done);
> +	if (rc)
> +		goto out;
> +
>   	return id;
>   
>   out:
> @@ -350,6 +353,8 @@ static void rpcrdma_ep_destroy(struct kref *kref)
>   		ib_dealloc_pd(ep->re_pd);
>   	ep->re_pd = NULL;
>   
> +	rpcrdma_rn_unregister(ep->re_id->device, &ep->re_rn);
> +
>   	kfree(ep);
>   	module_put(THIS_MODULE);
>   }
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index da409450dfc0..341725c66ec8 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -56,6 +56,7 @@
>   #include <linux/sunrpc/rpc_rdma_cid.h> 	/* completion IDs */
>   #include <linux/sunrpc/rpc_rdma.h> 	/* RPC/RDMA protocol */
>   #include <linux/sunrpc/xprtrdma.h> 	/* xprt parameters */
> +#include <linux/sunrpc/rdma_rn.h>	/* removal notifications */
>   
>   #define RDMA_RESOLVE_TIMEOUT	(5000)	/* 5 seconds */
>   #define RDMA_CONNECT_RETRY_MAX	(2)	/* retries if no listener backlog */
> @@ -92,6 +93,7 @@ struct rpcrdma_ep {
>   	struct rpcrdma_connect_private
>   				re_cm_private;
>   	struct rdma_conn_param	re_remote_cma;
> +	struct rpcrdma_notification	re_rn;
>   	int			re_receive_count;
>   	unsigned int		re_max_requests; /* depends on device */
>   	unsigned int		re_inline_send;	/* negotiated */


