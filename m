Return-Path: <linux-nfs+bounces-7216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA919A18C9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30B41C20F02
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D43B182;
	Thu, 17 Oct 2024 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga/q4T7x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313A1805E
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133551; cv=none; b=ltzNfkS71bOdHLDQUIgaf14M0mJ2L25YYZ6m4retK43PjdQOe6iRIAtQaRi1dBpb3X29QAQa27IyAtkOTOxL8JB9tIPwugWIqEtwTDBJXaStYfaUAPzS9Amc+FFwyBbXk0ZP0/RD6sMg91b4QGO5iPzZ2pT2AXJdzKpVs7yQzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133551; c=relaxed/simple;
	bh=3iGNl/b9v2mT5eflis6F8v7eTtiL209930hQnUUVYqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYf7QlwueUVEXC1wQj0MFg6GphVSVNAyADk5moUwc80QtafizAcMO2Uq1xavHXo0XB02DgD5IA8kQwIn+0g7Lnr/NP3sTnpfV2lOkhBW3wWtSpiiQO/8jVSPfiHWDHydg0MZ4sgOLYwqFznwSIfFkLJ4vXBaVhsMwu3Tw4kEy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga/q4T7x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so326895f8f.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729133547; x=1729738347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wyNt9LRzEVUv/Dgtfloo06G+ck9BYBRhLFMWtA1QEI=;
        b=Ga/q4T7xcUKbJ8/5RE+eUGY6BGN1QENnIiwJsImeDwG4ZHuytcarmCUDoFD/Yvwdqq
         Bs+HWlt4XRCmrwiSR8wTZteIgShqzFp0Heaz9HvB0igq0BXNToDp/6htN2mWzqdJ+k8h
         AMBAzrXJR1XWZP6q7mGnjY80GLAuGPGGRfXRNwNf3UNJnRa8gSPtw72VjO1n/HNgA91Q
         iBoSuftNkNpPOHC3bMU0pPvesxG0TYF7Z1RCsy21OwibY7ADOTSJMQ/eTCHD/Qqi5rjL
         sLt8ASKH9a/wulckpDFGjgy67tj6ar1OyblEYXSyT4FHBJ138+0BsVwFwhnF1A7ct/kG
         RqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133547; x=1729738347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wyNt9LRzEVUv/Dgtfloo06G+ck9BYBRhLFMWtA1QEI=;
        b=ToApJABELws2l/j5gW+Engdx3bRttj5PjfTCBpI2MDtIQQpEZxuFWgQW1zuV5fvYEQ
         sT+sY0/KBhmCPbW11CSdSyeATuuyN2rypkBhBZ4+Fn4AfxEtcQGhwFHr67ap2zTA+EM+
         AisrgEa/vnJ52NWmCBbaNwvgCd0Qh78He0vr48rFg5t3vcZK0CmW3jY1BhADhyPOLlFq
         HfoccFqnnH0aIvn7+yS8PXSEp85lx3a7ElZxEfB/pqyXLrAG8HV1daAkwrhcFORxvNJD
         Z9wuYP6ZO/bclPFZRw74qlFybqZQfUdN2MAfIFcjXyUjhx6PLmwHtbmDPyVLUg22Ew4N
         4/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUewktY0VUBMs6J3gLEsmmNRgnWxviowX0DqBgwdPBDrkcA5RsDiI/RgWnthY37QpZFl8RiXByfcHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQWy/L4w+22bZGPOR4n7sL0TlrIR/oiag5wYLPUsoaoD28UDp
	0HruZeFqXOm9ZHJKqomtqfzQa3jd1G0iMZQwTfS8rY9qRk7/8Y+GXoP32Q==
X-Google-Smtp-Source: AGHT+IGqWChsSP9w5ZPn5psGTfLaee9eV+uhuGgznQiCdW/PR8xi4Fv919VbFzSvuvJKdSQjK1Vk/Q==
X-Received: by 2002:a5d:4dca:0:b0:37d:4e9d:34d1 with SMTP id ffacd0b85a97d-37d5529ea2dmr13458163f8f.37.1729133547173;
        Wed, 16 Oct 2024 19:52:27 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c7dsm5821362f8f.42.2024.10.16.19.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 19:52:26 -0700 (PDT)
Message-ID: <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
Date: Thu, 17 Oct 2024 10:52:19 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
Content-Language: en-US
From: Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <Zw/GUeIymfw+2upD@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chuck,

On 2024/10/16 9:57 PM, Chuck Lever wrote:
> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
> 
> An RDMA consumer is not in control of the "source port" in an RDMA
> connection, thus the port number is meaningless. This is why the
> Linux NFS client does not already support setting the source port on
> RDMA mounts, and why NFSD sets the source port value to zero on
> incoming connections; the DRC then always sees a zero port value in
> its lookup key tuple.
> 
> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
> 
> 259         /* The remote port is arbitrary and not under the control of the
> 260          * client ULP. Set it to a fixed value so that the DRC continues
> 261          * to be effective after a reconnect.
> 262          */
> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> 
> 
> As a general comment, your patch descriptions need to explain /why/
> each change is being made. For example, the initial patches in this
> series, although they properly split the changes into clean easily
> digestible hunks, are somewhat baffling until the reader gets to
> this one. This patch jumps right to announcing a solution.

Thanks for your comment.

> 
> There's no cover letter tying these changes together with a problem
> statement. What problematic behavior did you see that motivated this
> approach?

We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
support resueport now, so we try to add it as tcp/udp.
Maybe someone needs the src port at rpcrdma connect, I made those patches. 

For the knfsd and nfs client, I don't meet any problem.

Thanks,
Kinglong Mee
> 
> 
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>  3 files changed, 141 insertions(+)
>>
>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>> index 9a8ce5df83ca..fee3b562932b 100644
>> --- a/net/sunrpc/xprtrdma/transport.c
>> +++ b/net/sunrpc/xprtrdma/transport.c
>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
>>  int xprt_rdma_pad_optimize;
>>  static struct xprt_class xprt_rdma;
>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>  
>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>  
>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>  		.mode		= 0644,
>>  		.proc_handler	= proc_dointvec,
>>  	},
>> +	{
>> +		.procname	= "rdma_min_resvport",
>> +		.data		= &xprt_rdma_min_resvport,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>> +		.extra2		= &xprt_rdma_max_resvport_limit
>> +	},
>> +	{
>> +		.procname	= "rdma_max_resvport",
>> +		.data		= &xprt_rdma_max_resvport,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>> +		.extra2		= &xprt_rdma_max_resvport_limit
>> +	},
>>  };
>>  
>>  #endif
>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>  	xprt_rdma_format_addresses(xprt, sap);
>>  
>>  	new_xprt = rpcx_to_rdmax(xprt);
>> +
>> +	if (args->srcaddr)
>> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>> +	else {
>> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
>> +		if (rc != 0) {
>> +			xprt_rdma_free_addresses(xprt);
>> +			xprt_free(xprt);
>> +			module_put(THIS_MODULE);
>> +			return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>>  	rc = rpcrdma_buffer_create(new_xprt);
>>  	if (rc) {
>>  		xprt_rdma_free_addresses(xprt);
>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>> index 63262ef0c2e3..0ce5123d799b 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>  	xprt_force_disconnect(ep->re_xprt);
>>  }
>>  
>> +static int rpcrdma_get_random_port(void)
>> +{
>> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>> +	unsigned short range;
>> +	unsigned short rand;
>> +
>> +	if (max < min)
>> +		return -EADDRINUSE;
>> +	range = max - min + 1;
>> +	rand = get_random_u32_below(range);
>> +	return rand + min;
>> +}
>> +
>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>> +{
>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>> +
>> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>> +		switch (sap->sa_family) {
>> +		case AF_INET6:
>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>> +			break;
>> +		case AF_INET:
>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>> +{
>> +	int port = r_xprt->rx_srcport;
>> +
>> +	if (port == 0 && r_xprt->rx_xprt.resvport)
>> +		port = rpcrdma_get_random_port();
>> +	return port;
>> +}
>> +
>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>> +{
>> +	if (r_xprt->rx_srcport != 0)
>> +		r_xprt->rx_srcport = 0;
>> +	if (!r_xprt->rx_xprt.resvport)
>> +		return 0;
>> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>> +		return xprt_rdma_max_resvport;
>> +	return --port;
>> +}
>> +
>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>> +{
>> +	struct sockaddr_storage myaddr;
>> +	int err, nloop = 0;
>> +	int port = rpcrdma_get_srcport(r_xprt);
>> +	unsigned short last;
>> +
>> +	/*
>> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
>> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>> +	 * port selection happen implicitly when the socket is used
>> +	 * (for example at connect time).
>> +	 *
>> +	 * This ensures that we can continue to establish TCP
>> +	 * connections even when all local ephemeral ports are already
>> +	 * a part of some TCP connection.  This makes no difference
>> +	 * for UDP sockets, but also doesn't harm them.
>> +	 *
>> +	 * If we're asking for any reserved port (i.e. port == 0 &&
>> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>> +	 * ensure that port is non-zero and we will bind as needed.
>> +	 */
>> +	if (port <= 0)
>> +		return port;
>> +
>> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>> +	do {
>> +		rpc_set_port((struct sockaddr *)&myaddr, port);
>> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>> +		if (err == 0) {
>> +			if (r_xprt->rx_xprt.reuseport)
>> +				r_xprt->rx_srcport = port;
>> +			break;
>> +		}
>> +		last = port;
>> +		port = rpcrdma_next_srcport(r_xprt, port);
>> +		if (port > last)
>> +			nloop++;
>> +	} while (err == -EADDRINUSE && nloop != 2);
>> +
>> +	return err;
>> +}
>> +
>>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>  					    struct rpcrdma_ep *ep)
>>  {
>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>  	if (IS_ERR(id))
>>  		return id;
>>  
>> +	rc = rpcrdma_bind(r_xprt, id);
>> +	if (rc) {
>> +		rc = -ENOTCONN;
>> +		goto out;
>> +	}
>> +
>>  	ep->re_async_rc = -ETIMEDOUT;
>>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>  			       RDMA_RESOLVE_TIMEOUT);
>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>  	if (rc)
>>  		goto out;
>>  
>> +	rpcrdma_set_srcport(r_xprt, id);
>> +
>>  	return id;
>>  
>>  out:
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>> index 8147d2b41494..9c7bcb541267 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>  	struct delayed_work	rx_connect_worker;
>>  	struct rpc_timeout	rx_timeout;
>>  	struct rpcrdma_stats	rx_stats;
>> +
>> +	struct sockaddr_storage	rx_srcaddr;
>> +	unsigned short		rx_srcport;
>>  };
>>  
>>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>   */
>>  extern unsigned int xprt_rdma_max_inline_read;
>>  extern unsigned int xprt_rdma_max_inline_write;
>> +extern unsigned int xprt_rdma_min_resvport;
>> +extern unsigned int xprt_rdma_max_resvport;
>>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>  void xprt_rdma_close(struct rpc_xprt *xprt);
>> -- 
>> 2.47.0
>>
> 


