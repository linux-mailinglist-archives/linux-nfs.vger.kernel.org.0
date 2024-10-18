Return-Path: <linux-nfs+bounces-7265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD99A39E5
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B111F2729C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83951EF95C;
	Fri, 18 Oct 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an/6QKia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC212192B94;
	Fri, 18 Oct 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243420; cv=none; b=FoL2Dwl29cV9hc7QHMuvrSoe+I4QQ2c9jpNnTiIsNXZ4j1ZakwZj8p8qj093h+DlNjPFE03FTxkwjk28Oj/hskXwxOAGhkIRiVWtQLQRsE329bSeVscAkypofdmhL43WDeZLeuKCRfUbZhiSKPsnL87uZiOqW3+uw1T0A8PtmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243420; c=relaxed/simple;
	bh=XBgsysFiWxjIcrTa7+BvZ7SjeoAfI7waehEEknFZsAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqWP90oM/RIrRbq7WGu7Hi/uCHJVHxgdSKHa9ezzi3E9Dv+jvACMO/ENuWlgMDBH2uU8YKGazwmzocZ2A0udd/NbPqZ2wcJ7WPY3B3DI249f07g+EeTygbo2LbQGiVIb7f/rVuJ4uOuxpNlUjYH53paBxaKQMwWZdDq/nTHwAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an/6QKia; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431481433bdso19075465e9.3;
        Fri, 18 Oct 2024 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729243417; x=1729848217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8i9TOmXHFPJppsA6DPvnN0VQVdHM4wmI36dIvbrDxh4=;
        b=an/6QKiaQAhnFVaMwzIWgOtzoWGPrDgycDmIcqz0BiV8J96CgTeP8gEy4qNQokl8S9
         6sM6kwBiP2J/tzXoo+fJp2BuR3yYlTReY+y0R9rnONyPhZ/xtizqB+LhmaiT4JF/8vpu
         MjPNDC8YcYYnQXgdNdIKk8in0B7ocnGduP8ws9C4C1SLdZsyahRDXgIN4MNBvLsYH6nu
         BPA67Jll67H2EEGAWnNUoarMHRjhK4kL+4mSyTKCaoLsF780cDuIseZBDPw1/nCwvUGY
         mPFirYMMWm0YHfZljWgl+evsyen/VnxUiadAjMreOCsv8IL3qUqAdoJFNtbunmKJc287
         H+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729243417; x=1729848217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8i9TOmXHFPJppsA6DPvnN0VQVdHM4wmI36dIvbrDxh4=;
        b=VB2OYSb8S+4HYdDWaOSQCEivtWOdW0qSj+DHx7MFFTb2+pOdsC6I9x8zBu8c7sBIPd
         AauwXXEMTqXzqtAWlGxZHq7EhkM7B5lO+SjgH9KkGYbG1/bTR6kqC41P0rxpgtf5bSQM
         9uBVoSDUPcSvKmDufWGMNRZgDGTpDoCcRnLkEjr8rNURctA8m8zbcNgWvGbDNXPjMzqw
         aJTww4HqrAm6ms254EyItWu7CE3Y5noDtAXvSyM0ZOm6QifzhiCpZaF4cgB0LT0wyBwN
         nXRQdSdsX6GDvZZUesp7frUQ0SDO+OCPpOzckES5zb2EswRfyJPDN4hsUarPQkLNHHYB
         i2lg==
X-Forwarded-Encrypted: i=1; AJvYcCV9TsS9BRIjqlyoxZJ37SjBmentVOOY0AjdGdsN5OP2CzoeJv4bkRX26Oftx5X1TPNt/0HF+t5GlivZtA==@vger.kernel.org, AJvYcCVoe0X6uA1oRqMHKzyiiNt+INPEPDnsQXHKH1abzEN+UV5HWtR7bkImYh9Q2hapcILU2cqtx/NQJKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCC7dAFFb9NnaNUmoNxHa2Kw+ftizmUw32fnjzwgduOe6dZmG
	DybzF+5gmrHXBKViTDxwTmVFOpaMWN/nELO/stvMMtsvc18HSdjE1/SdEQ==
X-Google-Smtp-Source: AGHT+IFJ7Gxdf1ZnrmO+mn3m+8skLU7E4OudUEkboMhHMiL2aInOKyopnFbHYMnvvXRLhrInqFdd4w==
X-Received: by 2002:a05:600c:45c3:b0:42c:de34:34c1 with SMTP id 5b1f17b1804b1-4316161f356mr13232615e9.2.1729243416695;
        Fri, 18 Oct 2024 02:23:36 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dfacfbsm18743125e9.21.2024.10.18.02.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 02:23:36 -0700 (PDT)
Message-ID: <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
Date: Fri, 18 Oct 2024 17:23:29 +0800
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
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-rdma@vger.kernel.org
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
 <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
Content-Language: en-US
From: Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chuck,

On 2024/10/17 9:24 PM, Chuck Lever wrote:
> On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
>> Hi Chuck,
>>
>> On 2024/10/16 9:57 PM, Chuck Lever wrote:
>>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
>>>
>>> An RDMA consumer is not in control of the "source port" in an RDMA
>>> connection, thus the port number is meaningless. This is why the
>>> Linux NFS client does not already support setting the source port on
>>> RDMA mounts, and why NFSD sets the source port value to zero on
>>> incoming connections; the DRC then always sees a zero port value in
>>> its lookup key tuple.
>>>
>>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
>>>
>>> 259         /* The remote port is arbitrary and not under the control of the
>>> 260          * client ULP. Set it to a fixed value so that the DRC continues
>>> 261          * to be effective after a reconnect.
>>> 262          */
>>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>
>>>
>>> As a general comment, your patch descriptions need to explain /why/
>>> each change is being made. For example, the initial patches in this
>>> series, although they properly split the changes into clean easily
>>> digestible hunks, are somewhat baffling until the reader gets to
>>> this one. This patch jumps right to announcing a solution.
>>
>> Thanks for your comment.
>>
>>>
>>> There's no cover letter tying these changes together with a problem
>>> statement. What problematic behavior did you see that motivated this
>>> approach?
>>
>> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
>> support resueport now, so we try to add it as tcp/udp.
> 
> Thank you for clarifying!
> 
> It's common for a DRC to key on the source port. Unfortunately,
> IIRC, the Linux RDMA Connection Manager does not provide an API for
> an RDMA consumer (such as the Linux NFS client) to set an arbitrary
> source port value on the active side. rdma_bind_addr() works on the
> listen side only.

rdma_bind_addr() also works on client before rdma_resolve_addr.
From man rdma_bind_addr,
"
   NOTES
       Typically,  this routine is called before calling rdma_listen to bind to
       a specific port number, but it may also be called on the active side of
       a connection before calling rdma_resolve_addr to bind to a specific address.
"
And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().

Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
rdma_get_dst_port() at userspace.
So if needed, it's easy to support them in linux kernel.

Rpcrdma and nvme use the src_addr/dst_addr directly as 
(struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
(struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
Call helpers may be better then directly access.

I think, there is a key question for rpcrdma.
Is the port in rpcrdma connect the same meaning as tcp/udp port?
If it is, we need support the reuseport.

Thanks,
Kinglong Mee

> 
> But perhaps my recollection is stale.
> 
> 
>> Maybe someone needs the src port at rpcrdma connect, I made those patches. 
>>
>> For the knfsd and nfs client, I don't meet any problem.
>>
>> Thanks,
>> Kinglong Mee
>>>
>>>
>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>> ---
>>>>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>>>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>>>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>>>  3 files changed, 141 insertions(+)
>>>>
>>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>>>> index 9a8ce5df83ca..fee3b562932b 100644
>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>>>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
>>>>  int xprt_rdma_pad_optimize;
>>>>  static struct xprt_class xprt_rdma;
>>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>>>  
>>>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>>  
>>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>>>  		.mode		= 0644,
>>>>  		.proc_handler	= proc_dointvec,
>>>>  	},
>>>> +	{
>>>> +		.procname	= "rdma_min_resvport",
>>>> +		.data		= &xprt_rdma_min_resvport,
>>>> +		.maxlen		= sizeof(unsigned int),
>>>> +		.mode		= 0644,
>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>>>> +		.extra2		= &xprt_rdma_max_resvport_limit
>>>> +	},
>>>> +	{
>>>> +		.procname	= "rdma_max_resvport",
>>>> +		.data		= &xprt_rdma_max_resvport,
>>>> +		.maxlen		= sizeof(unsigned int),
>>>> +		.mode		= 0644,
>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>>>> +		.extra2		= &xprt_rdma_max_resvport_limit
>>>> +	},
>>>>  };
>>>>  
>>>>  #endif
>>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>>>  	xprt_rdma_format_addresses(xprt, sap);
>>>>  
>>>>  	new_xprt = rpcx_to_rdmax(xprt);
>>>> +
>>>> +	if (args->srcaddr)
>>>> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>>>> +	else {
>>>> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>>>> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
>>>> +		if (rc != 0) {
>>>> +			xprt_rdma_free_addresses(xprt);
>>>> +			xprt_free(xprt);
>>>> +			module_put(THIS_MODULE);
>>>> +			return ERR_PTR(rc);
>>>> +		}
>>>> +	}
>>>> +
>>>>  	rc = rpcrdma_buffer_create(new_xprt);
>>>>  	if (rc) {
>>>>  		xprt_rdma_free_addresses(xprt);
>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>>> index 63262ef0c2e3..0ce5123d799b 100644
>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>>>  	xprt_force_disconnect(ep->re_xprt);
>>>>  }
>>>>  
>>>> +static int rpcrdma_get_random_port(void)
>>>> +{
>>>> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>>>> +	unsigned short range;
>>>> +	unsigned short rand;
>>>> +
>>>> +	if (max < min)
>>>> +		return -EADDRINUSE;
>>>> +	range = max - min + 1;
>>>> +	rand = get_random_u32_below(range);
>>>> +	return rand + min;
>>>> +}
>>>> +
>>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>> +{
>>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>>>> +
>>>> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>>>> +		switch (sap->sa_family) {
>>>> +		case AF_INET6:
>>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>>>> +			break;
>>>> +		case AF_INET:
>>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>>>> +{
>>>> +	int port = r_xprt->rx_srcport;
>>>> +
>>>> +	if (port == 0 && r_xprt->rx_xprt.resvport)
>>>> +		port = rpcrdma_get_random_port();
>>>> +	return port;
>>>> +}
>>>> +
>>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>>>> +{
>>>> +	if (r_xprt->rx_srcport != 0)
>>>> +		r_xprt->rx_srcport = 0;
>>>> +	if (!r_xprt->rx_xprt.resvport)
>>>> +		return 0;
>>>> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>>>> +		return xprt_rdma_max_resvport;
>>>> +	return --port;
>>>> +}
>>>> +
>>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>> +{
>>>> +	struct sockaddr_storage myaddr;
>>>> +	int err, nloop = 0;
>>>> +	int port = rpcrdma_get_srcport(r_xprt);
>>>> +	unsigned short last;
>>>> +
>>>> +	/*
>>>> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
>>>> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>>>> +	 * port selection happen implicitly when the socket is used
>>>> +	 * (for example at connect time).
>>>> +	 *
>>>> +	 * This ensures that we can continue to establish TCP
>>>> +	 * connections even when all local ephemeral ports are already
>>>> +	 * a part of some TCP connection.  This makes no difference
>>>> +	 * for UDP sockets, but also doesn't harm them.
>>>> +	 *
>>>> +	 * If we're asking for any reserved port (i.e. port == 0 &&
>>>> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>>>> +	 * ensure that port is non-zero and we will bind as needed.
>>>> +	 */
>>>> +	if (port <= 0)
>>>> +		return port;
>>>> +
>>>> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>>>> +	do {
>>>> +		rpc_set_port((struct sockaddr *)&myaddr, port);
>>>> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>>>> +		if (err == 0) {
>>>> +			if (r_xprt->rx_xprt.reuseport)
>>>> +				r_xprt->rx_srcport = port;
>>>> +			break;
>>>> +		}
>>>> +		last = port;
>>>> +		port = rpcrdma_next_srcport(r_xprt, port);
>>>> +		if (port > last)
>>>> +			nloop++;
>>>> +	} while (err == -EADDRINUSE && nloop != 2);
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>  					    struct rpcrdma_ep *ep)
>>>>  {
>>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>  	if (IS_ERR(id))
>>>>  		return id;
>>>>  
>>>> +	rc = rpcrdma_bind(r_xprt, id);
>>>> +	if (rc) {
>>>> +		rc = -ENOTCONN;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>>  	ep->re_async_rc = -ETIMEDOUT;
>>>>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>>>  			       RDMA_RESOLVE_TIMEOUT);
>>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>  	if (rc)
>>>>  		goto out;
>>>>  
>>>> +	rpcrdma_set_srcport(r_xprt, id);
>>>> +
>>>>  	return id;
>>>>  
>>>>  out:
>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>> index 8147d2b41494..9c7bcb541267 100644
>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>>>  	struct delayed_work	rx_connect_worker;
>>>>  	struct rpc_timeout	rx_timeout;
>>>>  	struct rpcrdma_stats	rx_stats;
>>>> +
>>>> +	struct sockaddr_storage	rx_srcaddr;
>>>> +	unsigned short		rx_srcport;
>>>>  };
>>>>  
>>>>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>>>   */
>>>>  extern unsigned int xprt_rdma_max_inline_read;
>>>>  extern unsigned int xprt_rdma_max_inline_write;
>>>> +extern unsigned int xprt_rdma_min_resvport;
>>>> +extern unsigned int xprt_rdma_max_resvport;
>>>>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>>>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>>>  void xprt_rdma_close(struct rpc_xprt *xprt);
>>>> -- 
>>>> 2.47.0
>>>>
>>>
>>
> 


