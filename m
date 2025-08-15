Return-Path: <linux-nfs+bounces-13685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEFB285DE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E4B60945E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF6244664;
	Fri, 15 Aug 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8K1PPkd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9822FAFD
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282771; cv=none; b=L8Y50AkFS/zYwiNeE4SqXLCVdxxMa96dvjoPM9Ub/bWUg+1cmMAVfJCZVs+Sq4P4O58NgbwDGET9/RwZtbxZ7amjNzEZl5rfZbgGGIpyLcmeFzDU0qUANcfWWoK3bOEFz/erW5GUFJW6t5utAfN045mHOfUhyU2E1R6nq3jrR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282771; c=relaxed/simple;
	bh=r9c3rQ5z9MWHvvPdWBRGs6A3839nl+e4ZYt9QLADMUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHVvS+wRd3eGVAwdMYaKkKSuW3sNcD5ZMA6EF4DAnV05eRm0KZLVvc46Co3rhXuh7+rG+pfHn1+7Ra7Y3SReN9U2CDfqiVjtIo4PuIO/hecTRmFE1k1RJctlZ17Cg95Afjb+Y08gHf/3P76ShSyZnT21tZYcAH2ebtYHSC35JwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8K1PPkd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755282768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7E2ze0OJ7SDZCFayIVgSwqY4PHLaA2wt5SNOV0/IzY=;
	b=T8K1PPkdTFADQlFLGZZdMB9E4/t1Y3PNsCiSVuePNd3HrrfOxYSHavjgVeHrhuHlct32Zy
	Er0f5n6mL365SHKVI1FlPnLqoz+wGvO+GY3Ajfd3FcyYii7IWsLikxPmCng4oBseKbwgSZ
	qwYSB24xC2W8jkD1MlshI30l3+ZS+NE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-pqFYTwilPwGmO96EQ0fIEQ-1; Fri, 15 Aug 2025 14:32:46 -0400
X-MC-Unique: pqFYTwilPwGmO96EQ0fIEQ-1
X-Mimecast-MFC-AGG-ID: pqFYTwilPwGmO96EQ0fIEQ_1755282766
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d604dcc4dso30965447b3.2
        for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 11:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282766; x=1755887566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7E2ze0OJ7SDZCFayIVgSwqY4PHLaA2wt5SNOV0/IzY=;
        b=dGgmQgFVfVxo31w5GgWwxk0vzOQLdbdXht81g7OTG6UJBD5spX5NBn2VIQoLqcrunl
         H9QXlWXbVgjmWQrfD9v4f6z/yef+HKoQi23vAl7Fl7GwhQ/8mirKq472qpUOqEJhnQKx
         htpwtAUOOEGzXq1n5no4oDL94rOAcZQjtH0LC6CeS4idDFZ96QW5NSn0lvESfMI32GC6
         YM1IgZviOfIe/ssaDraV6RQag3mk/rUC8iy6qNrskIgab53/wVX+53Hw6Q0eLREUyPM9
         se11hNQp2hlNBblYAz1KI2DPTs+jOxH3tz6O5KcYltAvw8UjBU9Qb6ZJkM6fnuaTR+KZ
         Z5/w==
X-Gm-Message-State: AOJu0YzJMMpy3IYNhYLHAYT/Cq7UiUZw1bsW2dECH+gNKUbasZureEU/
	OEWrMhjj0koC7Fkt5lP4u3dPOTKxlB1Rm+qpyni5/BuDaquEaxbAYUShVu6GVXTIbP24H9uJBri
	6HUs9uuFzq+Owf9KwzjmYDwXY+hPNslbdkHxv7t+0JOOcI56GEEyXamk0lkqHMw==
X-Gm-Gg: ASbGncuqqtPw75Bj5F/bNvGY+zfKfuRVFLwfUr8Pj7hXFJ1i8M72OunXa1iTefJwu0Y
	YUbvbYDSnJ5f8H29+Y0RStVkHW1hXYWu657oqOOjRU1Tc4O5Ig7+1Ln+4LbIiRLl6Rbh946yKix
	RlETJxn/K6DJNaKeA24YMNW2byzm5pO12ebuLL4z47Bl34RxPCQn8M70UWvY7k2y376/fyauFhG
	HFPnjC5FTdl9nX2shbGMu0gwAbOg/b8/MAt7qYo9dU0XZDX1cJS+oS4egXvuCfQl+Oeqyl4JGuB
	de9Zx0NYkpUsM5mWhHeKPPllALM4eu/erK95b/CS
X-Received: by 2002:a05:690c:d0f:b0:71b:b928:74ed with SMTP id 00721157ae682-71e6ddeae9dmr42115217b3.20.1755282766305;
        Fri, 15 Aug 2025 11:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYtMK5nxegjUP6+sITqsrzvx62pHkOZjmZSX0c7a3EwA1t/InLWwH1zuGr2PCT4uBlBz7rQ==
X-Received: by 2002:a05:690c:d0f:b0:71b:b928:74ed with SMTP id 00721157ae682-71e6ddeae9dmr42114877b3.20.1755282765910;
        Fri, 15 Aug 2025 11:32:45 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e058dbasm5482657b3.47.2025.08.15.11.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 11:32:45 -0700 (PDT)
Message-ID: <28d4e637-7469-4dcf-8bff-c5c69bf65dd4@redhat.com>
Date: Fri, 15 Aug 2025 14:32:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -Wold-style-definition warnings
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 libtirpc <libtirpc-devel@lists.sourceforge.net>
References: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
 <9d84391f-d724-4693-90d9-c56d54ece17e@oracle.com>
 <42121eeb-6e7e-4138-9520-8ee81679ddac@redhat.com>
 <ad23a6d9-72a4-4363-bee5-e52164e3ed17@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ad23a6d9-72a4-4363-bee5-e52164e3ed17@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/25 2:18 PM, Chuck Lever wrote:
> On 8/15/25 2:07 PM, Steve Dickson wrote:
>> Hey!
>>
>> On 8/15/25 1:26 PM, Chuck Lever wrote:
>>> On 8/15/25 12:23 PM, Steve Dickson wrote:
>>>> Hello,
>>>>
>>>> On the more recent gcc version (15.1.1) the
>>>> -Wold-style-definition flag is set by default.
>>>>
>>>> This causes
>>>>       warning: old-style function definition [-Wold-style-definition]
>>>>
>>>> warnings when functions are defined like
>>>>
>>>> int add(a, b)
>>>> int a;
>>>> int b;
>>>> {}
>>>>
>>>> instead of like this
>>>>
>>>> int add(int a, int b)
>>>> {}
>>>>
>>>> Now I did fix these warnings in the latest rpcbind
>>>> release... But libtirpc is a different story.
>>>>
>>>> I would have to change almost every single function
>>>> in the library to remove these warnings or add I
>>>> could add -Wno-old-style-definition to the CFLAGS.
>>>>
>>>> Now I'm more that willing to do the work... Heck
>>>> I'm halfway through... But does it make sense to
>>>> change the foot print of every function for a
>>>> warning that may not make any sense?
>>>
>>> I recommend breaking up the work into several smaller
>>> patches, and posting them here for review before you
>>> commit.
>> Not quite sure how to do that... at this point it
>> is one huge commit... growing as we speak. Even if
>> I do it by file... it will still be a ton of patches.
>> But I agree... trying to make it easier to review
>> would be a good thing.
> 
> Yes, making it easier to review is exactly the idea.
> 
> Possibilities (that you are free to disregard):
> 
>   - Write a cocchinele script or two?
> 
>   - Ask an AI for advice on how to strategize the changes
> 
>   - Change internal (non-public) functions first
> 
>   - Stage the changes across several library releases
This might be a good idea... But I'm thinking of grouping
the commits by functionality... commit src/clnt_* files
then src/pmap_* file etc... I'm thinking there would be ten
or so patches... I'll see what it looks like.

> 
> 
>>> Maybe you could also pass the result through a C linter
>>> or clang-tidy. But don't go too crazy. You get the idea.
>> No worries... I will not go crazy! ;-) But if I do that
>> God only knows what would be found! :-)
>> This is old code... but point taken.
> 
> Yeah, ignore the complaints about actual code. Just look at function
> definitions and declarations, etc.
True.

> 
> 
>>> Out of curiosity, what is the test plan once your
>>> conversion is code-complete?
>> The upcoming bakeathon?? In general I lean on the
>> Fedora guys to do the regression testing...
> 
> Are there critical applications or packages that build against
> libtirpc? I guess... rpcbind, nfs-utils, any NIS packages left? Do you
> need to build libtirpc with alternate C libraries? On alternate hardware
> platforms?
> 
> It's hard for me to imagine functional breakage if the code is still
> compiling.
I agree... My carpal tunnel syndrome might acted up
do to all the repetitive typing ;-) This should be
straightforward... just a lot of change.

steved.


