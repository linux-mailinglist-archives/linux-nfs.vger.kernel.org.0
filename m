Return-Path: <linux-nfs+bounces-461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E4280A18F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2B1F213A2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADB125B6;
	Fri,  8 Dec 2023 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4j9z1+e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFA1723
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702032831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LR35QZGRFkULz+F2wJsQvKhm56MBRmsdbE9EOS2j0RI=;
	b=T4j9z1+ecWbSmNXkGxWFKTWnh9KsQK4RJWAynLU0J9n8AyXeu8D3m6eRczRbvjjhueVBrN
	M8z8/RMW+OFoiPWphPD/RIHkRG7rJQ5f0tT0Wx+Cvr7HHLiVJu6kBFXaSNIN519hgBm7MC
	kLDX0824xjXG/BtGnalDBByVvMzb3k8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Thf1QlfqNU6OnwtyF8bzXA-1; Fri, 08 Dec 2023 05:53:49 -0500
X-MC-Unique: Thf1QlfqNU6OnwtyF8bzXA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4648274100aso401678137.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Dec 2023 02:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032829; x=1702637629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR35QZGRFkULz+F2wJsQvKhm56MBRmsdbE9EOS2j0RI=;
        b=WCwGxuLgn/KVVA181sKlfbdYy/22VGfddG7QxzW2ppNOWrzX2fU0z3Z1DJiISy03Ej
         ah+1b9S/R8X74KXQnkw1ylakQOpgCXlCB7snpN2Z6nAyA2IYVvzLX+NQzedSVVnqLAHp
         geD4jT4dTD2VQp1PKJ7o1khiWhGRfLYDukwC2vsBBYKr0ZJv9ESRNS04rOfVJDH2ViRn
         PdBHtp9+0736/1xBk/2/LvPnmzm8YsN/Njg/6/q9GiNoKIU/AQiwRQEaTAEgWeMxj8VU
         FpTl7U0jKoGmwMWRRfhnlywhRQu/twHhBYy3hMhdMfgJrisCdEVK2l97i7XIJleZ7dux
         br8Q==
X-Gm-Message-State: AOJu0YxmfFpxwFfWAW08NiqHVhU//tw2/P1K2Hu4X20cas1IocjKyHTs
	Db8tZoJQzGb1JLVeFgKxEE6fe8sPubKoxBhWEKwCehsogbrgMHdscLvNg2N4OldiRcC2S8QF7J2
	tmXKWJCTgilvwpMa0PigB
X-Received: by 2002:a67:f7d4:0:b0:464:7d73:526d with SMTP id a20-20020a67f7d4000000b004647d73526dmr7794583vsp.2.1702032829442;
        Fri, 08 Dec 2023 02:53:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpNHX+/p+SgJ8Iwp2qx0khkQ0diE1c+T5wCy9B2DRXiUlBaumVWHPUegj6qxobMUO7HBWtbw==
X-Received: by 2002:a67:f7d4:0:b0:464:7d73:526d with SMTP id a20-20020a67f7d4000000b004647d73526dmr7794577vsp.2.1702032829135;
        Fri, 08 Dec 2023 02:53:49 -0800 (PST)
Received: from [172.31.1.12] ([70.109.128.46])
        by smtp.gmail.com with ESMTPSA id ec6-20020ad44e66000000b0067a24f5b432sm694519qvb.62.2023.12.08.02.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 02:53:48 -0800 (PST)
Message-ID: <bc48cb89-e1e2-44c9-8a99-61de8ab0fa57@redhat.com>
Date: Fri, 8 Dec 2023 05:53:48 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autoconf: don't build nfsdcltrack by default
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
 <2c9be16b-012e-4438-a396-fd1050284310@redhat.com>
 <5e8863edb88f2bf5a2913736fbd71228fc986a5a.camel@kernel.org>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <5e8863edb88f2bf5a2913736fbd71228fc986a5a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey

On 12/7/23 3:14 PM, Jeff Layton wrote:
> On Thu, 2023-12-07 at 14:42 -0500, Steve Dickson wrote:
>> Hey Jeff!
>>
>> On 11/27/23 10:18 AM, Jeff Layton wrote:
>>> Now that we've started the process to remove legacy v4 client tracking
>>> methods, let's stop building nfsdcltrack by default.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    configure.ac | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 93a1202807ea..62c833cc2409 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -248,9 +248,9 @@ AC_ARG_ENABLE(nfsrahead,
>>>    	fi
>>>    
>>>    AC_ARG_ENABLE(nfsdcltrack,
>>> -	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
>>> +	[AS_HELP_STRING([--enable-nfsdcltrack],[enable NFSv4 clientid tracking programs @<:@default=no@:>@])],
>>>    	enable_nfsdcltrack=$enableval,
>>> -	enable_nfsdcltrack="yes")
>>> +	enable_nfsdcltrack="no")
>>>    
>>>    AC_ARG_ENABLE(nfsv4server,
>>>    	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],
>>>
>>> ---
>>> base-commit: cc5cccbb9f24a2324f50a5cb4c29d83fdf6b1f90
>>> change-id: 20231127-master-5ef1c15da9c4
>>>
>>> Best regards,
>> Quick Question... Should we remove the code or just
>> turn off the building as this patch does?
>>
>> steved.
>>
> 
> Eventually, I think we'll want to remove nfsdcltrack entirely, but I
> think we shouldn't do that right away, without announcing it first and
> giving distros some warning.
> 
> Since we're on the subject, how long should we wait before fully
> deprecating it? A year? 2 or 3 releases? What makes sense?
Well, I was planning on make a new release (nfs-utils-2-7-1) when
I took the patch... So I guess turning the build off for
now makes sense... just to see what happens.

> 
> Maybe we should have configure spew a warning about its impending
> removal when someone enables it too?
Hmm... If it is not needed... why go through the effort?
I've always been a fan of... a clean cut! :-)

steved.


