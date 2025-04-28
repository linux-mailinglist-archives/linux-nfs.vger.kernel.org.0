Return-Path: <linux-nfs+bounces-11303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C165A9E7FE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD63189AF4A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C519F120;
	Mon, 28 Apr 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HBDpWJnz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D111CAF
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820626; cv=none; b=sZqICtKl/27lsB/TwTAdU4xiBu81bzZKJUl95NgMEy6U9gBVTMa3fi/XyvXR8vU/6Sd2/bq0Nqb1Ket3w7CddIlgZRFnLfR3XYj0siSYEsjU8/xy/Esr3/kuvgiVK4EEi7Xh2I5IsH4dVA+zKXpQMEnmvxrhiHo5A7ZUJ2wlQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820626; c=relaxed/simple;
	bh=zRq3rv+wVr/Yfb96CGYUhuAf6Baacx7aNhuBm3I3Esw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1hm9cZaFj+pnUDcfbqdT3Luw+IPdFLFLTZ9O6jZyvifbbeesw+5xvrSTLUlO7WSouz7sTN6Av5ez16HF2LjG3ipkmjM+p2I+fN4yUC8Vem+0ZUXAaO9dp7M4OmmZE5pg0XyqycwA7EepoAs9sVGqrueBcmUQRDc/LSLmX5g0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HBDpWJnz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d21d80b-db20-4f00-bff0-147716693baf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745820619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCLCWvK9hdEXP9vwBpzf+o2i8WrHmJy0vm18h0TrVxY=;
	b=HBDpWJnzUtV7KaME04pnMTPpRnArISvJZtnnx99IFGUV4n6WjmX/BOrGWo4ph7P6DK8ZIM
	bWKuK1Ohpp/sf10ZVgZ+r9+0lB4jtrjsN5S0NjyqcMgePd+rpU7ZIzAK8BTkvvHnjh6VVp
	4T0ioagxnm7FAljXrfi7bKayaNoFiqk=
Date: Mon, 28 Apr 2025 08:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] svcrdma: Unregister the device if svc_rdma_accept() fails
To: cel@kernel.org, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250427163959.5126-1-cel@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250427163959.5126-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/27 18:39, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> To handle device removal, svc_rdma_accept() registers an interest in
                                                            ^^^^^^^^ 
interface?

Except that, looks good to me.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> the underlying device when accepting a connection. However
> svc_rdma_free() is not invoked if svc_rdma_accept() fails. There
> needs to be a matching "unregister" in that case; otherwise the
> device cannot be removed.
> 
> Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index aca8bdf65d72..5940a56023d1 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -575,6 +575,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>   	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
>   		ib_destroy_qp(newxprt->sc_qp);
>   	rdma_destroy_id(newxprt->sc_cm_id);
> +	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
>   	/* This call to put will destroy the transport */
>   	svc_xprt_put(&newxprt->sc_xprt);
>   	return NULL;


