Return-Path: <linux-nfs+bounces-2181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63E870BA0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1941B1C21D54
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6E6FA9;
	Mon,  4 Mar 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcqkPMGo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6917C8
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584357; cv=none; b=PvAcIG1QYRPboKNhjS3GIxnwlAn2AjodJQXU8ok4LpXkrLeDIfT//VQsyB/aWvfM2BvBjTSioI+X59LYL7fHqtK4KbV4JstDq3TN45oSrfRMSN/gVeqOHHF3Eq7nJ7szfyL4qcaPqcaxlxRePuMi+ew5dqdnxU5BdhFIn1wE0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584357; c=relaxed/simple;
	bh=7/RVFHrgeH8QoZylt5uvm8d2DMl/Aigg8JqC3T2Wr2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsScyhsJRfY43FrsK1Tj8P6zddm8+O8n/0zYKZhO+aeyYADFoFQoP07AKdpYSTX0iE8hBId1XTOG3hy2XQdNWzqgaC9gn5oeiApj/MuSAGNNLcIS8rLdUHXvIa/0VuaU/DV72ZFsaS790idQQ1293RFr6xCcifQQdkLJej8gdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcqkPMGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709584354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud9xZMOhud0dd82mElbcjjAj5OUkZsAT1V4pqMmTjOM=;
	b=CcqkPMGozrUbxKlqdUGmw3u+kFtnmhaAwaS4Xrt2OIHICYX45MVBVSyKNQrSzdDIL5sTj5
	+vmTLIm4UVlHR/BgmFdSwJxVRTE3+Glfm02pIRD9/281Nk4w+15flAiPvne3xjySmMiDmN
	l1VNz2Kd6/npmWHihUIB5UAp9erpe8E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-KZOdOXZdOdSCl4GczgfeSQ-1; Mon, 04 Mar 2024 15:32:33 -0500
X-MC-Unique: KZOdOXZdOdSCl4GczgfeSQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f4f5c2so214235985a.0
        for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 12:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584352; x=1710189152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud9xZMOhud0dd82mElbcjjAj5OUkZsAT1V4pqMmTjOM=;
        b=HPElp2lTh57FKm9ITdznNBx/cEljmX18y31xVQp5b8Z6EbOHoC/QmO8+Xx+6SxcdlB
         /InDoflfuexlRG9P3bjakxN51j3nRJcChtrzQY5l+o8iUqspQ/vdisZfYXB4u7cPxuUa
         CY+J3Kf3RA97s8wAlM6Il7TNtyCgWZb4sENHUVxgHZg5bgUMWqCcSTVk/i+FKqncjzGC
         WTA2ApHqrZshAjVCi+TtDYoeR0859VnUrqxe72F3ZzAEdE4UyvzmDbODMDYiybzclTHA
         GC9jnkSgmBMALm/9Pfm5WnawtXx+KbohFEP3SiTeiTkhyq0BqFNRK75tSuEXiq/K7fj+
         DG5A==
X-Forwarded-Encrypted: i=1; AJvYcCVw9sWxjozk7wY3yMHF0dxHv50r+uiimRgB6xhN7EuedPvmqqHcEN1z53WYIJWYwgsCqeciYq34QFSPtBlqdvvDKh37TMTZgHig
X-Gm-Message-State: AOJu0Yy0uqCMZkBvR9mgJgglTuxhMVSAnmBAy0EFyBSw27hmyDie+voH
	0VMCCnBbVt2bNC0U6fOa7NOpKRr6WUQ/jDpjVcHFhb7Q4K8x6mHs68RJPKy/o47YiHo8W+IjUdU
	lpsDBXhHLvGSYZ+4HpZM+3h/yIUjcNDm+dy7yvjj97pRknJ9x05MYjGqwURfhKy1CuQ==
X-Received: by 2002:a05:620a:28c4:b0:788:31b2:35d5 with SMTP id l4-20020a05620a28c400b0078831b235d5mr86743qkp.5.1709584351932;
        Mon, 04 Mar 2024 12:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeSa3DmixMuq5SpjBro37lFXVZBbygOKuU1zWkINuDfzhZxVdnEbD6FmbZS4THaEfHYfq0ag==
X-Received: by 2002:a05:620a:28c4:b0:788:31b2:35d5 with SMTP id l4-20020a05620a28c400b0078831b235d5mr86730qkp.5.1709584351653;
        Mon, 04 Mar 2024 12:32:31 -0800 (PST)
Received: from [172.31.1.12] ([70.109.163.43])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a158100b00787b93d8df1sm80167qkk.99.2024.03.04.12.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:32:31 -0800 (PST)
Message-ID: <c8e97bb6-7f0a-40a1-a52e-b5e6ad9d33cb@redhat.com>
Date: Mon, 4 Mar 2024 15:32:30 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 rpcbind] Supprt abstract addresses and disable
 broadcast
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
References: <20240225235628.12473-1-neilb@suse.de>
 <b4b4d325-f15f-4fb3-a52c-c3f39d56018a@redhat.com>
 <20240304182931.GA3408054@pevik>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240304182931.GA3408054@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 1:29 PM, Petr Vorel wrote:
> Hi Neil, Steve,
> 
>> Hey Neil,
> 
>> My apologies on addressing this...
>> Too much PTO :-)
> 
>> On 2/25/24 6:53 PM, NeilBrown wrote:
>>> The first two patches here I wrote some years ago but never posted - sorry.
>>> The third and fourth allow rpcbind to work with an abstract AF_UNIX
>>> address as preferentially used by recent kernels.
> 
>>> NeilBrown
> 
> 
>>>    [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
>>>    [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
>> You realize that the broadcast code is configured out by default
>> ./configure  --help | grep rmt
>>    --enable-rmtcalls       Enables Remote Calls [default=no]
> 
>> So do we want to introduce a flag and man page section
>> for something that is off by default?
> 
> I would say man page does not harm.
> 
> If I'm not mistaken, it's disabled in openSUSE and Debian/Ubuntu, maybe
> disabling flag is really not needed.
As well as RHEL but not Fedora.

steved.

> 
> Kind regards,
> Petr
> 
>> steved.
>>>    [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
>>>    [PATCH 4/4] rpcinfo: try connecting using abstract address.
> 
> 


