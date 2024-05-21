Return-Path: <linux-nfs+bounces-3305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200E8CAED1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E156283546
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58A54277;
	Tue, 21 May 2024 13:05:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C6757F7;
	Tue, 21 May 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296710; cv=none; b=SkgggFUaJPxxuTNblDdro+LvucehdIRJBznKOFzy7uu08h7VesyrYziTQ8GJE23EFQ38e7mFF5HuhT6J3nxh1s0m3VBlnQmSoghX8YgokIBrfRcMQWnVK6PyCVmnIDboTqA/wUs5tyOQTZ4V38orlW+V/PyFg57kaauxW+ZWmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296710; c=relaxed/simple;
	bh=zNxomSvXx/+ib9LtsQN1Jmd2/UscT6DGZpkXXbgDttY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAqe7wOkbyfW/e2SwjHOOKh9+/F9E8uCFO+kCPFozWNRudHP6A56cTFiOAGktsIklg3mQ5MRVF5MvkrPH17ByVhxAGWMOaLt4uXwFTp5nFSx4HADIEakYcDhR1+TuQ7CB8x5KpqJKjAllvma0l/PrYpokq8rba5oVCIz0mT4AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354cd8d5f89so129560f8f.0;
        Tue, 21 May 2024 06:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296707; x=1716901507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SoVULRuyToXbSm7nUXxsggMhpk0D4GBRowOzHO6JjQ=;
        b=UnU+e7Gb4y1AiWKO2bFAxMWONiTuVdM+YsNsCtfsqeD5typ1/4tiHUNB/7osfY6EFh
         8bbfhKrGeUgi7XXs22mDH+pgZaPOOiL282EbPN8Zz30903HCnLQb6xAwsztEfYM5TD22
         gsWc28hhxQFkoPfbdnpxqJgizE18ack6AfXzcXV8e3UDnXiEplbU7zWUl0UV2Qmi914b
         2Wnff7XrSQEkqXaEb/ns4rSmtEPqUKn8ARHZbXziFwRvTLPRvgY65KYIcDVWzqmWtljY
         SUjl0nhjihNR37hzsPXEeD4dsi4TTd4YeHfVo8egnKp74335WJT8PM/qp8jNmetq4uya
         dxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHflqHHni/i4DbgiMcMqkRQ6WRxNv9VYnWyInvR1fOdAkPOi/izQCqqhmLUkoYSTaXwoVRpmtVoQTGfzWbN6eFgEm9bx0A/pDglJ2FeMo59EufJHrDuuBtWCwpZZj0SlwLMaQ3fA==
X-Gm-Message-State: AOJu0YxqPhem9HlhDqkHRs7lNcXB0Pyko/7S80vBrZKQtuaQZK4e2xLx
	zCbppOUiLORke8zTGI9XBSMZmmZSJq3vyY3vk92SprcGV6gDmRmMh75UFg==
X-Google-Smtp-Source: AGHT+IEdobWPhLgggCFjo3QOLm3uPSRaC65WhbBG1MKIJZJsYt6hIsRi8dkvEAaICJcmiW9nQa/nNg==
X-Received: by 2002:a05:6000:186d:b0:354:d14a:cb60 with SMTP id ffacd0b85a97d-354d14acc23mr1081883f8f.7.1716296707124;
        Tue, 21 May 2024 06:05:07 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm31951726f8f.81.2024.05.21.06.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 06:05:06 -0700 (PDT)
Message-ID: <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
Date: Tue, 21 May 2024 16:05:05 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521124306.GE20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 15:43, Jason Gunthorpe wrote:
> On Tue, May 21, 2024 at 12:04:02PM +0300, Sagi Grimberg wrote:
>>
>> On 20/05/2024 21:05, Chuck Lever III wrote:
>>> Hi-
>>>
>>> I've tested this with two kinds of systems:
>>>
>>> 1. A system with no physical RDMA devices and no start-up
>>>      scripts to load these modules
>>>
>>> 2. A system with physical RDMA devices and with the start-up
>>>      scripts that load xprtrdma/svcrdma
>>>
>>> In both cases, after doing an "rmmod rpcrdma", I can mount
>>> a "proto=rdma" mount or start the NFS server, and the module
>>> gets reloaded automatically.
>>>
>>> I therefore believe it is safe to delete the code in the
>>> rdma-core start-up scripts that manually load RPC-related
>>> RDMA support. Either the sunrpc.ko module does this, or NFS
>>> user space handles it. There's no need for the rdma-core
>>> scripting.
>> I didn't know that rdma-core does this... it really shouldn't, the
>> mount should (and does) handle it.
> This is new, it didn't used to do this
>
>> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
>> loaded by their userspace counterparts as well (or at least they
>> should).
> And AFIAK, these don't have a way to autoload at all. autoload
> requires the kernel to call request_module..

nvme/nvmet/isert are requested by the kernel. iser is loaded by iscsiadm.
IIRC srp had a userspace daemon loading it.

