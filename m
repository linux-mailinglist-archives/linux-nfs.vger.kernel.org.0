Return-Path: <linux-nfs+bounces-13705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43270B295F6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 02:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B530717F018
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016D54758;
	Mon, 18 Aug 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fksJ9HUE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C71E25FA
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478260; cv=none; b=oGlNsVcgFQozJsP1YY+0sRAe5AwkpGsX9uNHYQ8TN8G9UK9HdWkB0rW7jNOx7OTiAjrPZ81SrqQo2iAhsOA8WXyiZE7irbtWC4TBCXoFYQwuVmVBN+8m0EQVlN2NN8p/HCJwI86JZfvQNBIqld47n2f5sLzlxY4BdfLCCzBwjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478260; c=relaxed/simple;
	bh=PF1OT+fPY2wSFa31k4ilOmk1Jmk4wDaiTKIFgqEQ148=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THum5z5BzKBdddnDuoFmnYg3TZZzbdNXQUeX+1G1oHTnBt+TLZOHQxHpQl/Dp0bPuggC0Guc/EC6mKUmJwZ4ImiY/YP8dZB6RQi8CgDeeHkuhhXz8Qj63ZfZ6tDQT7ifUE3pl9puRIhJXSOlpjuhC8ekMMKiyD8OHFAuhy+pUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fksJ9HUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755478256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6skRmLO0QxhlQAZqTh/vGEZoU682gHAIupnw44XtRgI=;
	b=fksJ9HUEyse5nuF0dbH5JiTpbtl8lPwadCpuG6IM0mlF7maCc64GIINgbo1K+3bg+PjWJ9
	K9Gf9YrctFDZ5KgBAANDIO0hQPvZ4RiowMlrV2EpPkE3cP0QKwysFTJtu2Q/uP5SNqo8gp
	AAqERnKqTjm/AczSkih2c7fZH+G7Rb0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-3jue6DvtOcKbocxhGckXaw-1; Sun, 17 Aug 2025 20:50:54 -0400
X-MC-Unique: 3jue6DvtOcKbocxhGckXaw-1
X-Mimecast-MFC-AGG-ID: 3jue6DvtOcKbocxhGckXaw_1755478254
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458194d82so34768725ad.2
        for <linux-nfs@vger.kernel.org>; Sun, 17 Aug 2025 17:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478254; x=1756083054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6skRmLO0QxhlQAZqTh/vGEZoU682gHAIupnw44XtRgI=;
        b=XQDcLrHzzIuL2f+jA1wrNavqU1NByy89ruELzd99Z0Okb9Kjpkcpx2wTiTnHx7fztW
         QBeonCZ4Wnf2OkIdQYL339ISVFqEUdqTVJ//9kaM2s5dIkHEGwAnNhcF1meYHpqS6pro
         MT5e71iu7CWAtGA4rmDkbw6aVb9DrkPIXQ9llYWgvoNWL+JXGfQ0TKe1YcsH9rs1y6NT
         mdLUrVk5rb1phgrKxuJtdSFwTzEXB9+l80EuuLTWpau2IhOEwty/JD6Es0eYzPo43YEi
         8uXf5uEFS6yNRPTLrhuwh5v6JkinLMevs7LNFy0eP2RUmTUgWZSghZ1XMg4QK5+ZpC2U
         QwdA==
X-Gm-Message-State: AOJu0YzDc6GtnnHfpfYGyk3vsqvOVV0Z46hRXQgof6zT6p0lb8Wgy9nR
	CTIuLm2eW3wuOGCHLBeb7mEY0xyQgA3eXTVMUrvJcrVgmnBNju6u2ZiMGVZSEkBcm/HHXj8nENb
	Fk3nMJAAHh9QpVJF43n7eVCLBpUdsKIpUKnO2R2jr/HZiU/UEStjSODRPhIeXbA==
X-Gm-Gg: ASbGnctuLFcpAYURja8ZoVjEYXhllH3N5Kwn3VGPl20soA7XEpy/rY8CMx07leTK7VI
	9rUIV5ZAPY1on+yClfxyjMsThTF/9ZfMmObe5jynzaUQMXzG1DtdQyNibJF55gynHe4ypwgS5CI
	WPMJTrXF7xH8ZrxujiiCcobfkrg4ZrD6kc5MBANzz5rWvbyDlwJLg4UthFuBZ3tNbMI7U8ly/FB
	j2htNmBVh4GRjpZ+5yTsH/8R6JvZwx0ms0EhS7ysZo05c9xjKZIK3HCHzscCx3frN1TkZ+i19qF
	miCRWWdPbeTz50nMzbpakiP4Lmajqox1kPpm0VCTpya7HZnwqSzXMHhc5xMw1P7jad1buGVM5MB
	kmxvaUHgdZ0QouHxd
X-Received: by 2002:a17:903:38cc:b0:235:f143:9b07 with SMTP id d9443c01a7336-2446d5afbacmr140750595ad.5.1755478253632;
        Sun, 17 Aug 2025 17:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGKvoveUjy5ylntz1JSLMgmZbb42DVWDQ/8f4mKHokeOJzIDFIHw0OGLzEeE1veJLXM/BcqA==
X-Received: by 2002:a17:903:38cc:b0:235:f143:9b07 with SMTP id d9443c01a7336-2446d5afbacmr140750465ad.5.1755478253256;
        Sun, 17 Aug 2025 17:50:53 -0700 (PDT)
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc5161sm9633534a91.12.2025.08.17.17.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 17:50:52 -0700 (PDT)
Message-ID: <303bf381-dce5-495e-a3f0-0fb9f215ad82@redhat.com>
Date: Mon, 18 Aug 2025 08:50:48 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Libtirpc-devel] -Wold-style-definition warnings
To: Chuck Lever <chuck.lever@oracle.com>, Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 libtirpc <libtirpc-devel@lists.sourceforge.net>
References: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
 <9d84391f-d724-4693-90d9-c56d54ece17e@oracle.com>
 <42121eeb-6e7e-4138-9520-8ee81679ddac@redhat.com>
 <ad23a6d9-72a4-4363-bee5-e52164e3ed17@oracle.com>
Content-Language: en-AU
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <ad23a6d9-72a4-4363-bee5-e52164e3ed17@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/8/25 02:18, Chuck Lever via Libtirpc-devel wrote:
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
>>> I recommend breaking up the work into several smaller
>>> patches, and posting them here for review before you
>>> commit.
>> Not quite sure how to do that... at this point it
>> is one huge commit... growing as we speak. Even if
>> I do it by file... it will still be a ton of patches.
>> But I agree... trying to make it easier to review
>> would be a good thing.
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
>
>
>>> Maybe you could also pass the result through a C linter
>>> or clang-tidy. But don't go too crazy. You get the idea.
>> No worries... I will not go crazy! ;-) But if I do that
>> God only knows what would be found! :-)
>> This is old code... but point taken.
> Yeah, ignore the complaints about actual code. Just look at function
> definitions and declarations, etc.
>
>
>>> Out of curiosity, what is the test plan once your
>>> conversion is code-complete?
>> The upcoming bakeathon?? In general I lean on the
>> Fedora guys to do the regression testing...
> Are there critical applications or packages that build against
> libtirpc? I guess... rpcbind, nfs-utils, any NIS packages left? Do you
> need to build libtirpc with alternate C libraries? On alternate hardware
> platforms?

autofs depends on libtirpc and I'm pretty sure there are independent

developed products that rely on TI-RPC but the the change is more

syntax than anything so I'm not sure the risk is actually high.


>
> It's hard for me to imagine functional breakage if the code is still
> compiling.

Indeed so, yes.


Ian


