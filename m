Return-Path: <linux-nfs+bounces-7413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F69ADA48
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 05:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CE81C20C80
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28315746E;
	Thu, 24 Oct 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwiNnEbp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A6158A00;
	Thu, 24 Oct 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739450; cv=none; b=OvMSG8eQYwVYvvbfvh26HneVdnNN8agy2I3qZawVV8l/q1irXqeE1LEi4PW6KC0MIqclK0s/9wlvUNaDiEGSUK+RqxE7M3Pf7QxggqzBA14b0DGOsp1iDIZq9z/uHAcwlt6nx9EQSVP+hNBwq48pPEBVNjAzcCZA4OKXzb/HQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739450; c=relaxed/simple;
	bh=yxvuZduyG8Kt8yfGR6KSgVZgCOC25cth+81IyQ1wrs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3gGNWku8PDy2KaOShNJnXqv6+muxVIh9mpWWZlvcO+0kF1j+lfVcZQtiaol32v4mQgePE3MzdV4+jnbkf3ObJSpvVUnE/tasS49Z2wXpjrFzj5Ul3r7KPExG8g2JXL+B5iXNzSpUOfRbnPzT4f9ZLdPja1r+MdRJ5/lVOl/1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwiNnEbp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315baec69eso4178795e9.2;
        Wed, 23 Oct 2024 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729739445; x=1730344245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKdqmNrcstHWC6KC2d2g+kQUdFMworuaXv1moXT8JCY=;
        b=OwiNnEbpMugdDcGmJTqlm2fLE6B2PtUL+HBnFOlg7x5GmtCq1/0rV2Jzvb1hulQgDy
         SFjESBvNYyrRFlC9AAP+txVqrM4/AFKyIU4Ib/KfqfXaUjb6Rl3ywZ4aoiy4OV5dslNo
         kyBKqve2C+T4VgUIghgD6OVxqRVoFmc3YQBi0A7Zo3k6W/O54PB8V8Y2D00oIMkjW2OQ
         7PwPldm0fdXWbD36ku8169O00ENeA8Mj7tFDIGw2m1tLWqcmUBWmpb6Hi11uyWo1C6I7
         R+AxiccgQYx/cZFLFLVJp9ESNPmPXglI9yau7A8Mv27jhf/R0cZhUm7LU3Tnat54kwbQ
         bh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729739445; x=1730344245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKdqmNrcstHWC6KC2d2g+kQUdFMworuaXv1moXT8JCY=;
        b=tlWj8hEYJCeaHJ/h8Zm6sJaZAJrg1K1i+jJUZtIKQY3W/Nwww2TnhERh4hQPOw1e+U
         CWmKFqFyJkSg059L8BNUe4drkqIF5yGGhxyXSBcFyca7qFNCY+WKOH7mRGTz8sl68+h3
         lRWhthz94y8VitITQfeK1LVZ5v14fpo/U78OOy579wUI/N2P1yGBWIZrimlpPrvgOH/W
         F1s5Q56IaWLbEbMCh2170nuaOgfnt7IFkCRSItlVjqkuIRRp07uAegD4MbXTO7a/huhb
         Ktzj8lVhwodX5qcigTuOBXmvzJuGlae4DijkSl1GTAwtlBSibE39n4jFM8Pxg1lkLljU
         GVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm9jm3Fdr2aHEtFRcindOLsHR0nxeaqS3J3AbgdOXfSwkYhpoX5TdrIHqC0tK4DGKbqkSosUBPgmIZjg==@vger.kernel.org, AJvYcCVnqxME6lCmLp59nQ7cOmj++835y5U/6eKt5yXJyoUB3Ya5cpigxMk1gzThq/UvKhgUGogMs9Sk3/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPoBWsxnRzvTRXoITY1KlInD6b0NlNHiFbmy5Dh2Uxx+HZWQP
	BU1jsKFib1pTJITrNDY0d5z690EbeQ1Ba54RZUJ7Z77Y1CyFZrpf
X-Google-Smtp-Source: AGHT+IGtdn4VkNJl8EtnzLcE5GDAIXXXGG5WG36E1Z0Ng9LwtnrfhwrorIlCMb/m3qAkITky0sHSTQ==
X-Received: by 2002:a05:600c:3b93:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-4318a9182e1mr6985225e9.9.1729739444616;
        Wed, 23 Oct 2024 20:10:44 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bfcfd0sm32712925e9.26.2024.10.23.20.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 20:10:44 -0700 (PDT)
Message-ID: <6c9b31e6-efb8-4b84-9af8-1dc6ed768d1f@gmail.com>
Date: Thu, 24 Oct 2024 11:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
To: Tom Talpey <tom@talpey.com>, Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
 <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
 <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
 <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
 <290d18f3-befe-44b4-b79b-983983f1418f@gmail.com>
 <3225E57B-40A4-4CF6-BDF1-3A90BC313D22@oracle.com>
 <6eb46c99-d410-4090-8832-394e7aa69adc@talpey.com>
Content-Language: en-US
From: Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <6eb46c99-d410-4090-8832-394e7aa69adc@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/10/24 12:02 AM, Tom Talpey wrote:
> On 10/19/2024 2:51 PM, Chuck Lever III wrote:
>>> On Oct 19, 2024, at 6:21 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>> Hi Chuck,
>>> On 2024/10/18 10:23 PM, Chuck Lever wrote:
>>>> On Fri, Oct 18, 2024 at 05:23:29PM +0800, Kinglong Mee wrote:
>>>>> Hi Chuck,
>>>>> On 2024/10/17 9:24 PM, Chuck Lever wrote:
>>>>>> On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
>>>>>>> Hi Chuck,
>>>>>>> On 2024/10/16 9:57 PM, Chuck Lever wrote:
>>>>>>>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>>>>>>>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>>>>>>>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
>>>>>>>>
>>>>>>>> An RDMA consumer is not in control of the "source port" in an RDMA
>>>>>>>> connection, thus the port number is meaningless. This is why the
>>>>>>>> Linux NFS client does not already support setting the source port on
>>>>>>>> RDMA mounts, and why NFSD sets the source port value to zero on
>>>>>>>> incoming connections; the DRC then always sees a zero port value in
>>>>>>>> its lookup key tuple.
>>>>>>>>
>>>>>>>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
>>>>>>>>
>>>>>>>> 259         /* The remote port is arbitrary and not under the control of the
>>>>>>>> 260          * client ULP. Set it to a fixed value so that the DRC continues
>>>>>>>> 261          * to be effective after a reconnect.
>>>>>>>> 262          */
>>>>>>>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>>>>>>
>>>>>>>>
>>>>>>>> As a general comment, your patch descriptions need to explain /why/
>>>>>>>> each change is being made. For example, the initial patches in this
>>>>>>>> series, although they properly split the changes into clean easily
>>>>>>>> digestible hunks, are somewhat baffling until the reader gets to
>>>>>>>> this one. This patch jumps right to announcing a solution.
>>>>>>>
>>>>>>> Thanks for your comment.
>>>>>>>
>>>>>>>>
>>>>>>>> There's no cover letter tying these changes together with a problem
>>>>>>>> statement. What problematic behavior did you see that motivated this
>>>>>>>> approach?
>>>>>>>
>>>>>>> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
>>>>>>> support resueport now, so we try to add it as tcp/udp.
>>>>>>
>>>>>> Thank you for clarifying!
>>>>>>
>>>>>> It's common for a DRC to key on the source port. Unfortunately,
>>>>>> IIRC, the Linux RDMA Connection Manager does not provide an API for
>>>>>> an RDMA consumer (such as the Linux NFS client) to set an arbitrary
>>>>>> source port value on the active side. rdma_bind_addr() works on the
>>>>>> listen side only.
>>>>>
>>>>> rdma_bind_addr() also works on client before rdma_resolve_addr.
>>>>>  From man rdma_bind_addr,
>>>>> "
>>>>>    NOTES
>>>>>        Typically,  this routine is called before calling rdma_listen to bind to
>>>>>        a specific port number, but it may also be called on the active side of
>>>>>        a connection before calling rdma_resolve_addr to bind to a specific address.
>>>>> "
>>>>> And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().
>>>>>
>>>>> Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
>>>>> rdma_get_dst_port() at userspace.
>>>>> So if needed, it's easy to support them in linux kernel.
>>>>>
>>>>> Rpcrdma and nvme use the src_addr/dst_addr directly as
>>>>> (struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
>>>>> (struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
>>>>> Call helpers may be better then directly access.
>>>>>
>>>>> I think, there is a key question for rpcrdma.
>>>>> Is the port in rpcrdma connect the same meaning as tcp/udp port?
>>>>
>>>> My recollection is they aren't the same. I can check into the
>>>> semantic equivalency a little more.
>>>>
>>>> However, on RDMA connections, NFSD ignores the source port value for
>>>> the purposes of evaluating the "secure" export option. Solaris, the
>>>> other reference implementation of RPC/RDMA, does not even bother
>>>> with this check on any transport.
>>>>
>>>> Reusing the source port is very fraught (ie, it has been the source
>>>> of many TCP bugs) and privileged ports offer little real security.
>>>> I'd rather not add this behavior for RDMA if we can get away with
>>>> it. It's an antique.
>>>>
>>>>> If it is, we need support the reuseport.
>>>>
>>>> I'm not following you. If an NFS server ignores the source port
>>>> value for the DRC and the secure port setting, why does the client
>>>> need to reuse the port value when reconnecting?
>>>
>>> Yes, that's unnecessary.
>>>
>>>>
>>>> Or, are you saying that you are not able to alter the behavior of
>>>> your private NFS server implementation to ignore the client's source
>>>> port?
>>>
>>> No, if the rdma port at client side is indeed meaningless,
>>> I will modify our private NFS server.
>>>
>>> I just wanna known the meaning of port in rdma connection.
>>> When mounting nfs export with rpcrdma, it connects an ip with port 20049 implicitly,
>>> if the port in client side is meaningless, why is the server side meaningful?
>>>
>>> As I known, rdma_cm designs those APIs based on sockets,
>>> initially, I think the rdma port is the same as tcp/udp port.
>>
>> IIRC the 20049 port is needed for NFS/RDMA on iWARP. On
>> IB and RoCE, it's actually unnecessary.
> 
> Right, the _destination_ port 20049 is IANA-registered because iWARP
> uses TCP and the server is already listening for NFS/TCP on port 2049.
> The NFSv4.1 spec allows dynamic negotiation over a single port, but
> to my knowledge no client or server implements that. And of course,
> NFSv3 and v4.0 are naive so they require an rdma-specific port.
> 
> IB and RoCE use the "port" number to create a service ID and have no
> conflict, so while it's technically unnecessary they have to listen
> on something, and the server defaults to 20049 anyway for consistency.
> 
> OTOH the _source_ port is a relic of the NFS/UDP days, where the
> UDP socket was kept over the life of the mountpoint and its source
> port never changed. The NFS DRC took advantage of this, in, like, 1989.
> 
> For TCP, SO_REUSEPORT was used to retain the semantic, but it's not
> guaranteed to work (the port could be claimed by another socket, and
> even if not, the network might still deliver old packets and cause
> it to fail). Because the DRC is attempting to provide correctness,
> it's IMO very unwise for a new server implementation to require
> the source port to match.
> 
> So, even if rdmacm now supports it, I don't think it's advisable to
> implement port reuse for NFS/RDMA.

Nfscache uses following data for duplicate request match,
        struct {
                /* Keep often-read xid, csum in the same cache line: */
                __be32                  k_xid;
                __wsum                  k_csum;
                u32                     k_proc;
                u32                     k_prot;
                u32                     k_vers;
                unsigned int            k_len;
                struct sockaddr_in6     k_addr;
        } c_key; 

Nfs-ganesha uses address(conatins port), xid, and a 256bytes checksum
(libntirpc's rdma set it to zero now) for duplicate request match.

At nfs client, a xprt connect generate xid value for a rpc requst based on
its own random number(xprt->xid = get_random_u32(); and xprt->xid++;).

Like that, a NFS mount with single xprt connet can run correctly,
two requests from the single xprt never contains a conflict xid;
but for with more xprts (nconnect > 1), two requests from different xprt may
contain the same xid from the same address(different port).

If port reuse is not guaranteed to work, we remove the use of the port from
the server's DRC（like svcrdma set it to 0, or a new implementation）.

Like nfs-ganesha or some private DRC, they implements a drc pool for
each client base on address, and match other keys(xid,checksum).
Different xprts(same address, different port) shares a drc pool,
unlucky, they check xid and a zero checksum.

If we agree with the meaningless of nfs client's port,
and remove it from server's drc, xid generation should be modified
to per client, not per xprt.

Thanks,
Kinglong Mee

> 
> Tom.
> 
>> I'll continue to sniff around and see if there's more to
>> find out.
>>
>>
>>> Thanks,
>>> Kinglong Mee
>>>
>>>>>
>>>>>>
>>>>>> But perhaps my recollection is stale.
>>>>>>
>>>>>>
>>>>>>> Maybe someone needs the src port at rpcrdma connect, I made those patches.
>>>>>>>
>>>>>>> For the knfsd and nfs client, I don't meet any problem.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Kinglong Mee
>>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>>>>>>> ---
>>>>>>>>> net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>>>>>>>> net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>>>>>>>> net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>>>>>>>> 3 files changed, 141 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>>>>>>>>> index 9a8ce5df83ca..fee3b562932b 100644
>>>>>>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>>>>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>>>>>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>>>>>>>> unsigned int xprt_rdma_memreg_strategy = RPCRDMA_FRWR;
>>>>>>>>> int xprt_rdma_pad_optimize;
>>>>>>>>> static struct xprt_class xprt_rdma;
>>>>>>>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>>>>>>>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>>>>>>>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>>>>>>>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>>>>>>>>
>>>>>>>>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>>>>>>>
>>>>>>>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>>>>>>>> .mode = 0644,
>>>>>>>>> .proc_handler = proc_dointvec,
>>>>>>>>> },
>>>>>>>>> + {
>>>>>>>>> + .procname = "rdma_min_resvport",
>>>>>>>>> + .data = &xprt_rdma_min_resvport,
>>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>>> + .mode = 0644,
>>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>>> + },
>>>>>>>>> + {
>>>>>>>>> + .procname = "rdma_max_resvport",
>>>>>>>>> + .data = &xprt_rdma_max_resvport,
>>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>>> + .mode = 0644,
>>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>>> + },
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> #endif
>>>>>>>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>>>>>>>> xprt_rdma_format_addresses(xprt, sap);
>>>>>>>>>
>>>>>>>>> new_xprt = rpcx_to_rdmax(xprt);
>>>>>>>>> +
>>>>>>>>> + if (args->srcaddr)
>>>>>>>>> + memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>>>>>>>>> + else {
>>>>>>>>> + rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>>>>>>>>> + (struct sockaddr *)&new_xprt->rx_srcaddr);
>>>>>>>>> + if (rc != 0) {
>>>>>>>>> + xprt_rdma_free_addresses(xprt);
>>>>>>>>> + xprt_free(xprt);
>>>>>>>>> + module_put(THIS_MODULE);
>>>>>>>>> + return ERR_PTR(rc);
>>>>>>>>> + }
>>>>>>>>> + }
>>>>>>>>> +
>>>>>>>>> rc = rpcrdma_buffer_create(new_xprt);
>>>>>>>>> if (rc) {
>>>>>>>>> xprt_rdma_free_addresses(xprt);
>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>> index 63262ef0c2e3..0ce5123d799b 100644
>>>>>>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>>>>>>>> xprt_force_disconnect(ep->re_xprt);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> +static int rpcrdma_get_random_port(void)
>>>>>>>>> +{
>>>>>>>>> + unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>>>>>>>>> + unsigned short range;
>>>>>>>>> + unsigned short rand;
>>>>>>>>> +
>>>>>>>>> + if (max < min)
>>>>>>>>> + return -EADDRINUSE;
>>>>>>>>> + range = max - min + 1;
>>>>>>>>> + rand = get_random_u32_below(range);
>>>>>>>>> + return rand + min;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>>> +{
>>>>>>>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>>>>>>>>> +
>>>>>>>>> + if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>>>>>>>>> + switch (sap->sa_family) {
>>>>>>>>> + case AF_INET6:
>>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>>>>>>>>> + break;
>>>>>>>>> + case AF_INET:
>>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>>>>>>>>> + break;
>>>>>>>>> + }
>>>>>>>>> + }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>>>>>>>>> +{
>>>>>>>>> + int port = r_xprt->rx_srcport;
>>>>>>>>> +
>>>>>>>>> + if (port == 0 && r_xprt->rx_xprt.resvport)
>>>>>>>>> + port = rpcrdma_get_random_port();
>>>>>>>>> + return port;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>>>>>>>>> +{
>>>>>>>>> + if (r_xprt->rx_srcport != 0)
>>>>>>>>> + r_xprt->rx_srcport = 0;
>>>>>>>>> + if (!r_xprt->rx_xprt.resvport)
>>>>>>>>> + return 0;
>>>>>>>>> + if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>>>>>>>>> + return xprt_rdma_max_resvport;
>>>>>>>>> + return --port;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>>> +{
>>>>>>>>> + struct sockaddr_storage myaddr;
>>>>>>>>> + int err, nloop = 0;
>>>>>>>>> + int port = rpcrdma_get_srcport(r_xprt);
>>>>>>>>> + unsigned short last;
>>>>>>>>> +
>>>>>>>>> + /*
>>>>>>>>> +  * If we are asking for any ephemeral port (i.e. port == 0 &&
>>>>>>>>> +  * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>>>>>>>>> +  * port selection happen implicitly when the socket is used
>>>>>>>>> +  * (for example at connect time).
>>>>>>>>> +  *
>>>>>>>>> +  * This ensures that we can continue to establish TCP
>>>>>>>>> +  * connections even when all local ephemeral ports are already
>>>>>>>>> +  * a part of some TCP connection.  This makes no difference
>>>>>>>>> +  * for UDP sockets, but also doesn't harm them.
>>>>>>>>> +  *
>>>>>>>>> +  * If we're asking for any reserved port (i.e. port == 0 &&
>>>>>>>>> +  * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>>>>>>>>> +  * ensure that port is non-zero and we will bind as needed.
>>>>>>>>> +  */
>>>>>>>>> + if (port <= 0)
>>>>>>>>> + return port;
>>>>>>>>> +
>>>>>>>>> + memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>>>>>>>>> + do {
>>>>>>>>> + rpc_set_port((struct sockaddr *)&myaddr, port);
>>>>>>>>> + err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>>>>>>>>> + if (err == 0) {
>>>>>>>>> + if (r_xprt->rx_xprt.reuseport)
>>>>>>>>> + r_xprt->rx_srcport = port;
>>>>>>>>> + break;
>>>>>>>>> + }
>>>>>>>>> + last = port;
>>>>>>>>> + port = rpcrdma_next_srcport(r_xprt, port);
>>>>>>>>> + if (port > last)
>>>>>>>>> + nloop++;
>>>>>>>>> + } while (err == -EADDRINUSE && nloop != 2);
>>>>>>>>> +
>>>>>>>>> + return err;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>>      struct rpcrdma_ep *ep)
>>>>>>>>> {
>>>>>>>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>> if (IS_ERR(id))
>>>>>>>>> return id;
>>>>>>>>>
>>>>>>>>> + rc = rpcrdma_bind(r_xprt, id);
>>>>>>>>> + if (rc) {
>>>>>>>>> + rc = -ENOTCONN;
>>>>>>>>> + goto out;
>>>>>>>>> + }
>>>>>>>>> +
>>>>>>>>> ep->re_async_rc = -ETIMEDOUT;
>>>>>>>>> rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>>>>>>>>         RDMA_RESOLVE_TIMEOUT);
>>>>>>>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>> if (rc)
>>>>>>>>> goto out;
>>>>>>>>>
>>>>>>>>> + rpcrdma_set_srcport(r_xprt, id);
>>>>>>>>> +
>>>>>>>>> return id;
>>>>>>>>>
>>>>>>>>> out:
>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>> index 8147d2b41494..9c7bcb541267 100644
>>>>>>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>>>>>>>> struct delayed_work rx_connect_worker;
>>>>>>>>> struct rpc_timeout rx_timeout;
>>>>>>>>> struct rpcrdma_stats rx_stats;
>>>>>>>>> +
>>>>>>>>> + struct sockaddr_storage rx_srcaddr;
>>>>>>>>> + unsigned short rx_srcport;
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>>>>>>>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>>>>>>>>   */
>>>>>>>>> extern unsigned int xprt_rdma_max_inline_read;
>>>>>>>>> extern unsigned int xprt_rdma_max_inline_write;
>>>>>>>>> +extern unsigned int xprt_rdma_min_resvport;
>>>>>>>>> +extern unsigned int xprt_rdma_max_resvport;
>>>>>>>>> void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>>>>>>>> void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>>>>>>>> void xprt_rdma_close(struct rpc_xprt *xprt);
>>>>>>>>> -- 
>>>>>>>>> 2.47.0
>>
>>
>> -- 
>> Chuck Lever
>>
>>
> 


