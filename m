Return-Path: <linux-nfs+bounces-3100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82608B7A74
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147CA1C226AE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC6770F0;
	Tue, 30 Apr 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbb8J3lK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A85770E3;
	Tue, 30 Apr 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488324; cv=none; b=CiTjw0X90U4bJ8ycbGWaQgc6aS92LszqdnHDiGLhFmKsPy+CojUYIn+58XxB7LCp9VAwdbiIFmvCVidsJkLR++sNaOqgWJA5e+xiQIWV/fTvLhTxQOoVTAdR52zJqx7L0mAt2lEEfzby2FhoqA9smtnSaspDdQLBxor85gWDpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488324; c=relaxed/simple;
	bh=SQ0pawimoOjWaEZRpOTD7te2lZ82DdtQBQ6Ux3/kxZU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UcbDy6uo7YUjUCxw7Vb+2N+UNYkK08nkopK+mxLSFW5dOrYrNZat8YIFnx2LGH7oOajiafPQ4MAD5fUVUNuSMWatcm5TGNOBd/Q02CZFKz3paIqqkZT1QeTnQGCsIDApJO2SzQ1EeeafxxoZC+wy3zpwDXjRGilz/Df2knTVlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbb8J3lK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34d96054375so363229f8f.2;
        Tue, 30 Apr 2024 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488321; x=1715093121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcW3ThwTpracNVT6BIj2sViiE5bP9U7pNEb0EqDX8R0=;
        b=Bbb8J3lKetFDQ0nqopj2W1AGE88ZMJ0iTa30uqdsHvJFroJ4+iOi5bD7deHpUGhXhp
         HxCjmzhvx/ScXkplt2OOtwbYbzdsagEab5Ld9h/1Vymy9QqM0ZwqIKx/H4+D61TYpw9E
         eyUybukIzfDuyIdojFb1qzEsqGc3gHoMx1aAWGbOf8ydcWKawfZdVRpXqAeR0CknCfmw
         6rqqKj/AhD8QmJzPjCUkmUxtla3aOHvrRMKp0I0g3zjJY0TOCZ2bH3aNylXPdKT7Owic
         7FfxYSeG2rLY9ONqjAra4mWUgMpCWuoAtvgfWvkZgJSByjDFYgyVA0S0AdOYAUato/Jl
         LE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488321; x=1715093121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcW3ThwTpracNVT6BIj2sViiE5bP9U7pNEb0EqDX8R0=;
        b=FErJNhVmf/hazeqbub3xrQecUwjoYtYlcuMnElbBQGkPZcHtWngmdG/tjgmtsR+0YB
         jxzOl2JRR1vv7iusiRybuk48Y1gXRx84bSqJwJ99+o6TnSlPWdPO1vncoaRPsFfwmmBG
         X/DBPU+dIGiAuBUwcmdKP9NOIg2SD+y4mycxeh+HuCLa+zbGpcRHro1F9658Q0ab0Ts1
         SyTF65ss3jOJXh2HQHHazO3ojvTRWDDrjo2qp+jrG9LIRyxpkuQvLMe0mdZ6Wp39pI4W
         VMBb7x7D1w2tnC0vSbiNG3qrH5P+MXd80mRtWPERkz1slWxah4WJfda+OeZYRqYc1gws
         zngg==
X-Forwarded-Encrypted: i=1; AJvYcCVmLFJfjuExIiNPqyjiu7FDe5RKQbotLibDXqqNfp/Hqkn0K9KC25jcO6FFHdIRzscZhr7EnLb9sZRRQI8kOaOKt+VAUhtTxVakPvX407Zr+6KNbtSpey1hRjpl8qz06PUqbXym5Q==
X-Gm-Message-State: AOJu0YyS/0MYZOx4qnQZROL1+wV0ZONSwcm2t8XN+P/BlvWJNODkli01
	0ffYnOCLR2vaJraflhI7lwGCiLBRf+zCJjUc5oHoNC5kchVXKhb7
X-Google-Smtp-Source: AGHT+IHkF+ba7Btb7L7FjML/+fBDXlXBctSNMdU/i+CV00wPVcggo7cJ6jjeUyyiiNG9DMmS8VmEoA==
X-Received: by 2002:a05:6000:c83:b0:34c:5448:b81a with SMTP id dp3-20020a0560000c8300b0034c5448b81amr9285033wrb.48.1714488321039;
        Tue, 30 Apr 2024 07:45:21 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0034c59c41f45sm11326435wru.7.2024.04.30.07.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 07:45:20 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
Date: Tue, 30 Apr 2024 16:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
In-Reply-To: <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.04.24 16:13, Chuck Lever III wrote:
> 
> 
>> On Apr 30, 2024, at 9:58 AM, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>>
>> On 30.04.24 15:42, Chuck Lever III wrote:
>>>
>>>> On Apr 30, 2024, at 3:26 AM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>>>
>>>> On 29.04.24 17:25, cel@kernel.org wrote:
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>> Avoid getting work queue splats in the system journal by moving
>>>>> client-side RPC/RDMA transport tear-down into a background process.
>>>>> I've done some testing of this series, now looking for review
>>>>> comments.
>>>> How to make tests with nfs && rdma? Can you provide some steps or tools?
>>> We are building NFS tests into kdevops:
>>>
>>>     https://github.com/linux-kdevops/kdevops.git
>>>
>>> and there is a config option to use soft iWARP instead of TCP.
>>
>> Thanks a lot. It is interesting. Have you made tests with RXE instead of iWARP?
>>
>> If yes, does nfs work well with RXE? I am just curious with nfs && RXE.
>>
>> Normally nfs works with TCP. Now nfs will use RDMA instead of TCP.
>>
>> The popular RDMA implementation is RoCEv2 which is based on UDP protocol.
>>
>> So I am curious if NFS can work well with RXE (RoCEv2 emulation driver) or not.
>>
>> If the user wants to use nfs in his production hosts, it is possible that nfs will work with RoCEv2 (UDP).
> 
> Yes, NFS/RDMA works with rxe and even with rxe mixed with
> hardware RoCE. Someone else will have to step in and say
> whether it works "well" since I don't use rxe, only CX-5
> and newer on 100GbE.
> 
> Generally we use siw because our testing environment varies
> between all systems on a single local network or hypervisor,
> all the way up to NFS/RDMA on VPN and WAN. The rxe driver
> doesn't support operation over tunnels, currently.

Thanks a lot. "The rxe driver doesn't support operation over tunnels, 
currently." Do you mean that rxe can not work well with tun/tap device?

> 
> It is possible to add rxe as a second option in kdevops,
> but siw has worked for our purposes so far, and the NFS
> test matrix is already enormous.

Thanks. If rxe can be as a second option in kdevops, I will make tests 
with kdevops to check rxe work well or not in the future kernel version.

Best Regards,
Zhu Yanjun

> 
> 
>> Best Regards,
>>
>> Zhu Yanjun
>>
>>> kdevops includes workflows for fstests, Mora's nfstest, the
>>> git regression suite, and ltp, all of which we use regularly
>>> to test the Linux NFS client and server implementations.
>>>
>>>
>>>> I am interested in nfs && rdma.
>>>>
>>>> Thanks,
>>>> Zhu Yanjun
>>>>
>>>>> Chuck Lever (4):
>>>>>    xprtrdma: Remove temp allocation of rpcrdma_rep objects
>>>>>    xprtrdma: Clean up synopsis of frwr_mr_unmap()
>>>>>    xprtrdma: Delay releasing connection hardware resources
>>>>>    xprtrdma: Move MRs to struct rpcrdma_ep
>>>>>   net/sunrpc/xprtrdma/frwr_ops.c  |  13 ++-
>>>>>   net/sunrpc/xprtrdma/rpc_rdma.c  |   3 +-
>>>>>   net/sunrpc/xprtrdma/transport.c |  20 +++-
>>>>>   net/sunrpc/xprtrdma/verbs.c     | 173 ++++++++++++++++----------------
>>>>>   net/sunrpc/xprtrdma/xprt_rdma.h |  21 ++--
>>>>>   5 files changed, 125 insertions(+), 105 deletions(-)
>>>>> base-commit: e67572cd2204894179d89bd7b984072f19313b03
>>> --
>>> Chuck Lever
>>>
>>>
>> -- 
>> Best Regards,
>> Yanjun.Zhu
> 
> 
> --
> Chuck Lever
> 
> 


