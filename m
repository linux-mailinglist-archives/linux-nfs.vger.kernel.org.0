Return-Path: <linux-nfs+bounces-7307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A559A4CD6
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9571C20E40
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FF1CC17A;
	Sat, 19 Oct 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYwYsk3I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BA56B81;
	Sat, 19 Oct 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333317; cv=none; b=LxX5O8A0sRNfF+I6BMVnhu+2aTRhwJK0ETqLZf1YOV7h5M+6zCXIt1+f+nQu+h3wWo7+Mu3Uu1pt6odLI2FrfcpbO4OHSOQPZAQoAtz33sWscZlapPd/J1+V8OBxiNTMkh/Oj9dc4xBvAmvtg0wRNMhud/NboYvsIexyAz3EZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333317; c=relaxed/simple;
	bh=LHq/m7jOm2+inGUgdzrkMo7a4FllS7Y/mldZauK5yCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWt3ggyvt0cCQmDEhv4mb52Ka1U2hw0rmWneb7Y+WLP5r8WazJqtqbArygWLlBgnbBJPMqZjV2Vm1sOMIcCQ4YJUgFUHKSpSRRgr3HO0GVdA8ImkEDCZbFzSJqwdfO18bK79RQ7liHXscPbRMI6QT31WC6GNo7t8LJUSqREOtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYwYsk3I; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d533b5412so2059889f8f.2;
        Sat, 19 Oct 2024 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729333313; x=1729938113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBEq+6G0SmQqTUSVvAZ+JWtoayTVAGMPSl1l0++W358=;
        b=PYwYsk3IuGDSjxttTE5telB1adnXy3Qv9gUWzqjXa4V2/wbrLAaBh2FvlTngHZhuh7
         UKorCZSIf4PuRzGGESIWO28qeyZXEcPSGjAghbw5h/GACYhepWsgvlWeCb7KVmidW02S
         unXbrKgh0isy/RhxKFuzb3o839BXB4lMdMs2sIT1DpJqGH1LcxLYuKI9ucn2xlKcQ+WJ
         tVD7O/rvNccylI/eycyCRQqgR5MX4DNNIaXBMSSGikv0RPBESCTlz5ThoA+DHPYLl29n
         uh6lToxhABS4EtZ8mLrsF2NJe26FxnjQUHuVI6wt27w/EuIWvjIWm80VvbKbQ1dPA4+g
         VMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729333313; x=1729938113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBEq+6G0SmQqTUSVvAZ+JWtoayTVAGMPSl1l0++W358=;
        b=Qbt4Xif5MoDwUyDSrBQpa2aRPHq8Td/Pdl3SZW1pPznw2bK9zzDa2A4A4HQtDB/DOj
         NMgrdTcMagrzt0XNL5Tb52YoO1gn4GmgHyzUClBl1lMBriXxW+zPyrBB2QPBO7LdNi/T
         BQmRp+vtCCMxvP0NGqcejddepx1mI8dsWb3vNlh5nRv+ysDcg0SFpMY621xQrv/lGl3P
         aea/DjjhAiguV8LygLlB02GbaDJBrFVdes0tHKgpJpW+RMvXiilmsHXuV2/gnIRB7oTu
         jaMWr/JbhB4I5Y1hh4jzlJbIWqM1uS94j0GBr2lZwkBHhpLslRvzOuyxVzaz/x0jO77n
         rEJw==
X-Forwarded-Encrypted: i=1; AJvYcCVbmfhxWsLIfWKvccY8Y8VIxjqE88PU+vkmgY9eOkmx/86O11rJZzQTc3kcIQVHyHtOw7QdmboJjeA=@vger.kernel.org, AJvYcCXoPqHAL7dAFJwI2hRrh/o+GlLFDx3zK2GeaOolYl26mzO9umkVgG1vFj/z1IeCLg/BST2t4AlgX4LuVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9a0EjSipSsPEXHoV8l0iQnQzPvODyNZhxObpiulPVFACKbRf5
	/PeQcs9o32xEzBEbuiPkWBcHaqLOQAJOLguA81K56BMZkuwxrMZaUjTiQw==
X-Google-Smtp-Source: AGHT+IHOmYFIKxjHeUsIRG3ypvRj8owNnsscGeiTFD6k8l0AtUBEDX3WcMTRjpFjP+Or5i8sQ4vJVA==
X-Received: by 2002:a05:6000:100d:b0:37d:4f1b:359 with SMTP id ffacd0b85a97d-37eb48a0f28mr3581052f8f.53.1729333312208;
        Sat, 19 Oct 2024 03:21:52 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed341sm4147468f8f.72.2024.10.19.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 03:21:51 -0700 (PDT)
Message-ID: <290d18f3-befe-44b4-b79b-983983f1418f@gmail.com>
Date: Sat, 19 Oct 2024 18:21:44 +0800
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
 <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
 <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
Content-Language: en-US
From: Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chuck,

On 2024/10/18 10:23 PM, Chuck Lever wrote:
> On Fri, Oct 18, 2024 at 05:23:29PM +0800, Kinglong Mee wrote:
>> Hi Chuck,
>>
>> On 2024/10/17 9:24 PM, Chuck Lever wrote:
>>> On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
>>>> Hi Chuck,
>>>>
>>>> On 2024/10/16 9:57 PM, Chuck Lever wrote:
>>>>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>>>>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>>>>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
>>>>>
>>>>> An RDMA consumer is not in control of the "source port" in an RDMA
>>>>> connection, thus the port number is meaningless. This is why the
>>>>> Linux NFS client does not already support setting the source port on
>>>>> RDMA mounts, and why NFSD sets the source port value to zero on
>>>>> incoming connections; the DRC then always sees a zero port value in
>>>>> its lookup key tuple.
>>>>>
>>>>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
>>>>>
>>>>> 259         /* The remote port is arbitrary and not under the control of the
>>>>> 260          * client ULP. Set it to a fixed value so that the DRC continues
>>>>> 261          * to be effective after a reconnect.
>>>>> 262          */
>>>>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>>>
>>>>>
>>>>> As a general comment, your patch descriptions need to explain /why/
>>>>> each change is being made. For example, the initial patches in this
>>>>> series, although they properly split the changes into clean easily
>>>>> digestible hunks, are somewhat baffling until the reader gets to
>>>>> this one. This patch jumps right to announcing a solution.
>>>>
>>>> Thanks for your comment.
>>>>
>>>>>
>>>>> There's no cover letter tying these changes together with a problem
>>>>> statement. What problematic behavior did you see that motivated this
>>>>> approach?
>>>>
>>>> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
>>>> support resueport now, so we try to add it as tcp/udp.
>>>
>>> Thank you for clarifying!
>>>
>>> It's common for a DRC to key on the source port. Unfortunately,
>>> IIRC, the Linux RDMA Connection Manager does not provide an API for
>>> an RDMA consumer (such as the Linux NFS client) to set an arbitrary
>>> source port value on the active side. rdma_bind_addr() works on the
>>> listen side only.
>>
>> rdma_bind_addr() also works on client before rdma_resolve_addr.
>> From man rdma_bind_addr,
>> "
>>    NOTES
>>        Typically,  this routine is called before calling rdma_listen to bind to
>>        a specific port number, but it may also be called on the active side of
>>        a connection before calling rdma_resolve_addr to bind to a specific address.
>> "
>> And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().
>>
>> Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
>> rdma_get_dst_port() at userspace.
>> So if needed, it's easy to support them in linux kernel.
>>
>> Rpcrdma and nvme use the src_addr/dst_addr directly as 
>> (struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
>> (struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
>> Call helpers may be better then directly access.
>>
>> I think, there is a key question for rpcrdma.
>> Is the port in rpcrdma connect the same meaning as tcp/udp port?
> 
> My recollection is they aren't the same. I can check into the
> semantic equivalency a little more.
> 
> However, on RDMA connections, NFSD ignores the source port value for
> the purposes of evaluating the "secure" export option. Solaris, the
> other reference implementation of RPC/RDMA, does not even bother
> with this check on any transport.
> 
> Reusing the source port is very fraught (ie, it has been the source
> of many TCP bugs) and privileged ports offer little real security.
> I'd rather not add this behavior for RDMA if we can get away with
> it. It's an antique.
> 
>> If it is, we need support the reuseport.
> 
> I'm not following you. If an NFS server ignores the source port
> value for the DRC and the secure port setting, why does the client
> need to reuse the port value when reconnecting?

Yes, that's unnecessary.

> 
> Or, are you saying that you are not able to alter the behavior of
> your private NFS server implementation to ignore the client's source
> port?

No, if the rdma port at client side is indeed meaningless,
I will modify our private NFS server.

I just wanna known the meaning of port in rdma connection.
When mounting nfs export with rpcrdma, it connects an ip with port 20049 implicitly,
if the port in client side is meaningless, why is the server side meaningful?

As I known, rdma_cm designs those APIs based on sockets,
initially, I think the rdma port is the same as tcp/udp port.

Thanks,
Kinglong Mee

>>
>>>
>>> But perhaps my recollection is stale.
>>>
>>>
>>>> Maybe someone needs the src port at rpcrdma connect, I made those patches. 
>>>>
>>>> For the knfsd and nfs client, I don't meet any problem.
>>>>
>>>> Thanks,
>>>> Kinglong Mee
>>>>>
>>>>>
>>>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>>>> ---
>>>>>>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>>>>>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>>>>>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>>>>>  3 files changed, 141 insertions(+)
>>>>>>
>>>>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>>>>>> index 9a8ce5df83ca..fee3b562932b 100644
>>>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>>>>>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
>>>>>>  int xprt_rdma_pad_optimize;
>>>>>>  static struct xprt_class xprt_rdma;
>>>>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>>>>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>>>>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>>>>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>>>>>  
>>>>>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>>>>  
>>>>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>>>>>  		.mode		= 0644,
>>>>>>  		.proc_handler	= proc_dointvec,
>>>>>>  	},
>>>>>> +	{
>>>>>> +		.procname	= "rdma_min_resvport",
>>>>>> +		.data		= &xprt_rdma_min_resvport,
>>>>>> +		.maxlen		= sizeof(unsigned int),
>>>>>> +		.mode		= 0644,
>>>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>>>>>> +		.extra2		= &xprt_rdma_max_resvport_limit
>>>>>> +	},
>>>>>> +	{
>>>>>> +		.procname	= "rdma_max_resvport",
>>>>>> +		.data		= &xprt_rdma_max_resvport,
>>>>>> +		.maxlen		= sizeof(unsigned int),
>>>>>> +		.mode		= 0644,
>>>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
>>>>>> +		.extra2		= &xprt_rdma_max_resvport_limit
>>>>>> +	},
>>>>>>  };
>>>>>>  
>>>>>>  #endif
>>>>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>>>>>  	xprt_rdma_format_addresses(xprt, sap);
>>>>>>  
>>>>>>  	new_xprt = rpcx_to_rdmax(xprt);
>>>>>> +
>>>>>> +	if (args->srcaddr)
>>>>>> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>>>>>> +	else {
>>>>>> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>>>>>> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
>>>>>> +		if (rc != 0) {
>>>>>> +			xprt_rdma_free_addresses(xprt);
>>>>>> +			xprt_free(xprt);
>>>>>> +			module_put(THIS_MODULE);
>>>>>> +			return ERR_PTR(rc);
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>>  	rc = rpcrdma_buffer_create(new_xprt);
>>>>>>  	if (rc) {
>>>>>>  		xprt_rdma_free_addresses(xprt);
>>>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>>>>> index 63262ef0c2e3..0ce5123d799b 100644
>>>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>>>>>  	xprt_force_disconnect(ep->re_xprt);
>>>>>>  }
>>>>>>  
>>>>>> +static int rpcrdma_get_random_port(void)
>>>>>> +{
>>>>>> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>>>>>> +	unsigned short range;
>>>>>> +	unsigned short rand;
>>>>>> +
>>>>>> +	if (max < min)
>>>>>> +		return -EADDRINUSE;
>>>>>> +	range = max - min + 1;
>>>>>> +	rand = get_random_u32_below(range);
>>>>>> +	return rand + min;
>>>>>> +}
>>>>>> +
>>>>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>> +{
>>>>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>>>>>> +
>>>>>> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>>>>>> +		switch (sap->sa_family) {
>>>>>> +		case AF_INET6:
>>>>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>>>>>> +			break;
>>>>>> +		case AF_INET:
>>>>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>>>>>> +			break;
>>>>>> +		}
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>>>>>> +{
>>>>>> +	int port = r_xprt->rx_srcport;
>>>>>> +
>>>>>> +	if (port == 0 && r_xprt->rx_xprt.resvport)
>>>>>> +		port = rpcrdma_get_random_port();
>>>>>> +	return port;
>>>>>> +}
>>>>>> +
>>>>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>>>>>> +{
>>>>>> +	if (r_xprt->rx_srcport != 0)
>>>>>> +		r_xprt->rx_srcport = 0;
>>>>>> +	if (!r_xprt->rx_xprt.resvport)
>>>>>> +		return 0;
>>>>>> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>>>>>> +		return xprt_rdma_max_resvport;
>>>>>> +	return --port;
>>>>>> +}
>>>>>> +
>>>>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>> +{
>>>>>> +	struct sockaddr_storage myaddr;
>>>>>> +	int err, nloop = 0;
>>>>>> +	int port = rpcrdma_get_srcport(r_xprt);
>>>>>> +	unsigned short last;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
>>>>>> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>>>>>> +	 * port selection happen implicitly when the socket is used
>>>>>> +	 * (for example at connect time).
>>>>>> +	 *
>>>>>> +	 * This ensures that we can continue to establish TCP
>>>>>> +	 * connections even when all local ephemeral ports are already
>>>>>> +	 * a part of some TCP connection.  This makes no difference
>>>>>> +	 * for UDP sockets, but also doesn't harm them.
>>>>>> +	 *
>>>>>> +	 * If we're asking for any reserved port (i.e. port == 0 &&
>>>>>> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>>>>>> +	 * ensure that port is non-zero and we will bind as needed.
>>>>>> +	 */
>>>>>> +	if (port <= 0)
>>>>>> +		return port;
>>>>>> +
>>>>>> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>>>>>> +	do {
>>>>>> +		rpc_set_port((struct sockaddr *)&myaddr, port);
>>>>>> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>>>>>> +		if (err == 0) {
>>>>>> +			if (r_xprt->rx_xprt.reuseport)
>>>>>> +				r_xprt->rx_srcport = port;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +		last = port;
>>>>>> +		port = rpcrdma_next_srcport(r_xprt, port);
>>>>>> +		if (port > last)
>>>>>> +			nloop++;
>>>>>> +	} while (err == -EADDRINUSE && nloop != 2);
>>>>>> +
>>>>>> +	return err;
>>>>>> +}
>>>>>> +
>>>>>>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>  					    struct rpcrdma_ep *ep)
>>>>>>  {
>>>>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>  	if (IS_ERR(id))
>>>>>>  		return id;
>>>>>>  
>>>>>> +	rc = rpcrdma_bind(r_xprt, id);
>>>>>> +	if (rc) {
>>>>>> +		rc = -ENOTCONN;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>>  	ep->re_async_rc = -ETIMEDOUT;
>>>>>>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>>>>>  			       RDMA_RESOLVE_TIMEOUT);
>>>>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>  	if (rc)
>>>>>>  		goto out;
>>>>>>  
>>>>>> +	rpcrdma_set_srcport(r_xprt, id);
>>>>>> +
>>>>>>  	return id;
>>>>>>  
>>>>>>  out:
>>>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>> index 8147d2b41494..9c7bcb541267 100644
>>>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>>>>>  	struct delayed_work	rx_connect_worker;
>>>>>>  	struct rpc_timeout	rx_timeout;
>>>>>>  	struct rpcrdma_stats	rx_stats;
>>>>>> +
>>>>>> +	struct sockaddr_storage	rx_srcaddr;
>>>>>> +	unsigned short		rx_srcport;
>>>>>>  };
>>>>>>  
>>>>>>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>>>>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>>>>>   */
>>>>>>  extern unsigned int xprt_rdma_max_inline_read;
>>>>>>  extern unsigned int xprt_rdma_max_inline_write;
>>>>>> +extern unsigned int xprt_rdma_min_resvport;
>>>>>> +extern unsigned int xprt_rdma_max_resvport;
>>>>>>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>>>>>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>>>>>  void xprt_rdma_close(struct rpc_xprt *xprt);
>>>>>> -- 
>>>>>> 2.47.0
>>>>>>
>>>>>
>>>>
>>>
>>
> 


