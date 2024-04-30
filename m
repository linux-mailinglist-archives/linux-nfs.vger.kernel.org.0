Return-Path: <linux-nfs+bounces-3102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F28B7AB5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C703280ED7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE097710D;
	Tue, 30 Apr 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5lJiH4M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CE1527BF
	for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489073; cv=none; b=E5gzz2UkaTiCIbSYXTNESgmz99EjsktdJXMd8oeZXPCPj3/EM+oa7pHNdkqunf1FMd33M1HULMO/C06mCvu7lZVoI2P5np8GC3gOH1bINUSKyvEe/XhHmVB10aOGuNtu6gK/D+nkxh3qUJBZjoiYRXG8vzth/V949anuFsbf/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489073; c=relaxed/simple;
	bh=u0ws1N2byfhODyeRFxwnUKrAppRYKcwuXepE2Oe6Nl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjeODLXTQHZ6bTErldZmAYqHzNd2konSl7ZFr6rnxK5moHuuXiubtvkD9+mzhdQQcfAmg7fw9++jMTlwsL4MkByTWnb1qjFOKOhkJVDqTS8F0etotchu2As3rDKjCSY35nzfJtPa6YNyip0hLLCLGKQZsnoPmsw6aJBt45E3GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5lJiH4M; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <873cfaf7-fc0f-4809-8439-7a67c1c4f5a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714489069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gk8UC4FxGGHbDkmD2PRRpUNqj2ltZn8Jm3FkYBvKxgA=;
	b=Z5lJiH4MMkQrMPMU6Evc+7cvmEIWQ0t8XBi7qJ1XZI2L9zphKNPppfnbMSDcAFr5LW7EiX
	e3fz+Ff12PrpCOD5nqoUf4uRxy/GgW/AYR6Pt3PS/AdDYlFLapSYbXuc5Zvzkpn5IYhhey
	0ZskXb/sbIod36E6FKqr2lhDaptcN1o=
Date: Tue, 30 Apr 2024 16:57:47 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
 <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
 <3B48378E-CE68-47FC-A8D3-7A7AEE383B25@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <3B48378E-CE68-47FC-A8D3-7A7AEE383B25@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 30.04.24 16:52, Chuck Lever III wrote:
>
>> On Apr 30, 2024, at 10:45 AM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>
>> On 30.04.24 16:13, Chuck Lever III wrote:
>>>> On Apr 30, 2024, at 9:58 AM, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>
>>>>
>>>> On 30.04.24 15:42, Chuck Lever III wrote:
>>>>>> On Apr 30, 2024, at 3:26 AM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>>>>>
>>>>>> On 29.04.24 17:25, cel@kernel.org wrote:
>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>> Avoid getting work queue splats in the system journal by moving
>>>>>>> client-side RPC/RDMA transport tear-down into a background process.
>>>>>>> I've done some testing of this series, now looking for review
>>>>>>> comments.
>>>>>> How to make tests with nfs && rdma? Can you provide some steps or tools?
>>>>> We are building NFS tests into kdevops:
>>>>>
>>>>>     https://github.com/linux-kdevops/kdevops.git
>>>>>
>>>>> and there is a config option to use soft iWARP instead of TCP.
>>>> Thanks a lot. It is interesting. Have you made tests with RXE instead of iWARP?
>>>>
>>>> If yes, does nfs work well with RXE? I am just curious with nfs && RXE.
>>>>
>>>> Normally nfs works with TCP. Now nfs will use RDMA instead of TCP.
>>>>
>>>> The popular RDMA implementation is RoCEv2 which is based on UDP protocol.
>>>>
>>>> So I am curious if NFS can work well with RXE (RoCEv2 emulation driver) or not.
>>>>
>>>> If the user wants to use nfs in his production hosts, it is possible that nfs will work with RoCEv2 (UDP).
>>> Yes, NFS/RDMA works with rxe and even with rxe mixed with
>>> hardware RoCE. Someone else will have to step in and say
>>> whether it works "well" since I don't use rxe, only CX-5
>>> and newer on 100GbE.
>>> Generally we use siw because our testing environment varies
>>> between all systems on a single local network or hypervisor,
>>> all the way up to NFS/RDMA on VPN and WAN. The rxe driver
>>> doesn't support operation over tunnels, currently.
>> Thanks a lot. "The rxe driver doesn't support operation over tunnels, currently." Do you mean that rxe can not work well with tun/tap device?
> No, rxe cannot be configured to use tunnel devices, AFAIK.
>
>
>>> It is possible to add rxe as a second option in kdevops,
>>> but siw has worked for our purposes so far, and the NFS
>>> test matrix is already enormous.
>> Thanks. If rxe can be as a second option in kdevops, I will make tests with kdevops to check rxe work well or not in the future kernel version.
> No new tests are necessary. The only thing missing right
> now is the ability to set up rxe devices on all the test
> systems.

Got it. Thanks.

Zhu Yanjun

>
>
>> Best Regards,
>> Zhu Yanjun
>>
>>>> Best Regards,
>>>>
>>>> Zhu Yanjun
>>>>
>>>>> kdevops includes workflows for fstests, Mora's nfstest, the
>>>>> git regression suite, and ltp, all of which we use regularly
>>>>> to test the Linux NFS client and server implementations.
>>>>>
>>>>>
>>>>>> I am interested in nfs && rdma.
>>>>>>
>>>>>> Thanks,
>>>>>> Zhu Yanjun
>>>>>>
>>>>>>> Chuck Lever (4):
>>>>>>>    xprtrdma: Remove temp allocation of rpcrdma_rep objects
>>>>>>>    xprtrdma: Clean up synopsis of frwr_mr_unmap()
>>>>>>>    xprtrdma: Delay releasing connection hardware resources
>>>>>>>    xprtrdma: Move MRs to struct rpcrdma_ep
>>>>>>>   net/sunrpc/xprtrdma/frwr_ops.c  |  13 ++-
>>>>>>>   net/sunrpc/xprtrdma/rpc_rdma.c  |   3 +-
>>>>>>>   net/sunrpc/xprtrdma/transport.c |  20 +++-
>>>>>>>   net/sunrpc/xprtrdma/verbs.c     | 173 ++++++++++++++++----------------
>>>>>>>   net/sunrpc/xprtrdma/xprt_rdma.h |  21 ++--
>>>>>>>   5 files changed, 125 insertions(+), 105 deletions(-)
>>>>>>> base-commit: e67572cd2204894179d89bd7b984072f19313b03
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>> -- 
>>>> Best Regards,
>>>> Yanjun.Zhu
>>> --
>>> Chuck Lever
>
> --
> Chuck Lever
>
>
-- 
Best Regards,
Yanjun.Zhu


