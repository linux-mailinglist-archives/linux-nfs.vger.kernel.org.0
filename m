Return-Path: <linux-nfs+bounces-3311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE6D8CB01D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260A01F25145
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918D7F7CE;
	Tue, 21 May 2024 14:12:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477257F7C7;
	Tue, 21 May 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300749; cv=none; b=rMvLIHEhqereFuBgrKflSxVNKMI0rMvgQ5OO5hPmber1LHJE5BnR4p8KJBAXnVtbbQ5kfrOeFremYWld/5hjSySqq4at/7FfMpbORzK/h1/Sm2U3sUO9T5OZA8q/2sbZAya9pNAlWcJHLjmuaAD9iGVdKEli5d8gJsWHixLcAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300749; c=relaxed/simple;
	bh=3MUEHDFvC2M4kjyMb2EK0LQG01bY9SLhXHG1bAfb0ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YseWuE1nwcQD18LPKiteV7afa1kjtbiHRKve9Wg6DFSGVFMoP25ZMnVnPRgm1Tp4q8w9UYMNgBdE3wDUfbU2uJLzg5lk2nse9pYXvvEEXTwRJKpGgzkxkP/I7VmJ0XLr2gBO5mEPbUPpT+6W0D+UKiPKO1DwwRXFgLsf5qzCjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354c84d4604so552399f8f.0;
        Tue, 21 May 2024 07:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300746; x=1716905546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y795mXpApDGNyhJCat6hX6jdjeLn3YJy2Vd19MCn3pk=;
        b=eS/BOG8YSW2+jg4i81x/Lv5Mh0kVx04EkkSdl1bkEhd08SV4j6H729HfGSQUUtSlqd
         A0Nc36edRX8kEWbZg6HVJcKhZdhfytXJ41eng4zn61Pb1kKRtj6PKsj+yR0OQ5cg4ylG
         VSvaRZntuiES/bw+ttzxaHc2qtonmxaTKMIhjJm1AFfbOizoCmIF86eJL+Bg8GHClGUh
         d8/baDHtJ7egzNUfPH20wlOxadPTNVKdD1hRMF957ePWp1GKre1COkmffc2bCoMXRzlL
         RFxpB9pVBKQ/DlkJ92DcrSAD61X0lQxGKvSy5hUZJQmz/NYhgFqE7/G1NiRggRNVf5qy
         R81A==
X-Forwarded-Encrypted: i=1; AJvYcCXETIqoUSEqNIrqyUhfFNnopnH0zypyq1PjFe6LsTijYeBOA0DvemOvnAIuKlwYYuwfGEAva0w7UYAGdqJW/NYaXKBOK1I/fV5wKQ2lSF/OH/hBwU12y9lrZG58fUbZck+vdj6+Gw==
X-Gm-Message-State: AOJu0YxaDbolMVgYirUjCkIMrwlTOk4pl24jb6ub5UUZmAZxq2vMOCg+
	EgUaycu8NGEqyk79CwviXwSXIBpXIOuLAO2xL575yobpiioYMzTMcmeSug==
X-Google-Smtp-Source: AGHT+IEeO5y7DDaYEciqkQEg+HSbf0HR38ub1unQgW3mGRTbhXjEU8A9hGNhL6fe+wHlGyr5TF2Drw==
X-Received: by 2002:a05:600c:19c8:b0:41f:cfe6:3648 with SMTP id 5b1f17b1804b1-41fea928a67mr243792385e9.1.1716300745426;
        Tue, 21 May 2024 07:12:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25casm462225375e9.20.2024.05.21.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:12:24 -0700 (PDT)
Message-ID: <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
Date: Tue, 21 May 2024 17:12:23 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521133727.GF20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 16:37, Jason Gunthorpe wrote:
> On Tue, May 21, 2024 at 04:05:05PM +0300, Sagi Grimberg wrote:
>>
>> On 21/05/2024 15:43, Jason Gunthorpe wrote:
>>> On Tue, May 21, 2024 at 12:04:02PM +0300, Sagi Grimberg wrote:
>>>> On 20/05/2024 21:05, Chuck Lever III wrote:
>>>>> Hi-
>>>>>
>>>>> I've tested this with two kinds of systems:
>>>>>
>>>>> 1. A system with no physical RDMA devices and no start-up
>>>>>       scripts to load these modules
>>>>>
>>>>> 2. A system with physical RDMA devices and with the start-up
>>>>>       scripts that load xprtrdma/svcrdma
>>>>>
>>>>> In both cases, after doing an "rmmod rpcrdma", I can mount
>>>>> a "proto=rdma" mount or start the NFS server, and the module
>>>>> gets reloaded automatically.
>>>>>
>>>>> I therefore believe it is safe to delete the code in the
>>>>> rdma-core start-up scripts that manually load RPC-related
>>>>> RDMA support. Either the sunrpc.ko module does this, or NFS
>>>>> user space handles it. There's no need for the rdma-core
>>>>> scripting.
>>>> I didn't know that rdma-core does this... it really shouldn't, the
>>>> mount should (and does) handle it.
>>> This is new, it didn't used to do this
>>>
>>>> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
>>>> loaded by their userspace counterparts as well (or at least they
>>>> should).
>>> And AFIAK, these don't have a way to autoload at all. autoload
>>> requires the kernel to call request_module..
>> nvme/nvmet/isert are requested by the kernel.
> How? What is the interface to trigger request_module?

On the host, writing to the nvme-fabrics misc device a comma-separated 
connection string
contains a transport string, which triggers the corresponding module to 
be requested.

On the target-side, configuring a port transport, also triggers in a 
similar way...

>
>> iser is loaded by iscsiadm.
> Yuk :\

Different strokes for different folks...

>
>> IIRC srp had a userspace daemon loading it.
> srp-daemon requires it already loaded AFAIK

OK, so that one is the exception...

