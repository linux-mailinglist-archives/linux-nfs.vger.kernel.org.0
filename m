Return-Path: <linux-nfs+bounces-13681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A5B28588
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 20:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0371D042CF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B01E51EB;
	Fri, 15 Aug 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e62ENeVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC8317717
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281279; cv=none; b=n30ZE4SMmXvUz2YxTUd0lr1urwpR5Gu3JPCFpTQ2ySzeGYL/X2ZsxAs18yAY6+Bw/5b2CJjXVumocfXoArf4EurnMbNFJB2ht8GVtPPAyxzwzUcwff20bxLYKjHimEMaAPYfuwSSzAmQMwBMrbrs1J2viKIEw5fXF/5vFVcLAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281279; c=relaxed/simple;
	bh=ZN1jzVyjghbEQt/NQXOSgI5Wlgv2uvBZ1dPvRmRf2CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Np6UICk7hYGeslK6T/Yv6Y4hjBYenV7oK1rjG3BDGdDn1j+Nbx0csYMwubTaaDXInjIpIXb3ZFs4JQmO1YyYcbAYlP4z/t9D1yMgbAP7FKRv9QKzVSs/eimapmRrlhQPewt6e+U/oJG2Q1oeoyAGJEkIS1jPbw8Jy3yoB0iVmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e62ENeVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755281276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SFW18LTLoe+/CiLZYVMYpI6hxkLfwDo8eZq9MNOd5M=;
	b=e62ENeVDMyN7oDzWYohbMvU9phQMRqodLauMuemEEYkrvDhZeMSykkhWFjDYlLvIeySSga
	bEx7IkGgLAS8Ks4PkR/2UgBpynYkaK/QZox9bP125w4yO+aKfAysdaufOWBAlQZS4iVcDN
	1uWIropCVYb76uVdWWu8YQg18tH+HVU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-oU0SutbuPZeTiwJfJh1aHQ-1; Fri, 15 Aug 2025 14:07:55 -0400
X-MC-Unique: oU0SutbuPZeTiwJfJh1aHQ-1
X-Mimecast-MFC-AGG-ID: oU0SutbuPZeTiwJfJh1aHQ_1755281274
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c4c2cfso86000651cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 11:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281274; x=1755886074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SFW18LTLoe+/CiLZYVMYpI6hxkLfwDo8eZq9MNOd5M=;
        b=NjPjJwnwMCmh+L1h4mHpFQEvy8jugSeE2FtYGYCOTL0BVJ/Vh8NDNCgcm3M/Tje2Ft
         z5r0918xx7n5YjzWOTOVPMyRO2+ip+13IRkNs3bZeiVdox6RQsSlgouAZfQwtqVmgSDl
         g0IaFxyNyObAwXO7WV6cDNJF0FLpa9s4T4LwSZMgFPBoHUsWEjhyStITfe6eZ6J1ZxK6
         0dCDJ11NidEtNSrWdo/6xa6uJGDJjOj9T3gNHehbfL0p+cWBvridyZWgrLBTSBpCon+r
         trT2RICvbPXEzesRC8oNUgyqv/PE6b8IrSOKAral5eiK4Hp4k1oBY/L7AixHQ65PaTmo
         QQ3w==
X-Gm-Message-State: AOJu0Yw6KMMgtJjtXY1DXkG19XG8/oE6FC6994q/ByLwBV78ezdhDt0+
	j+ndGuEOM7tgX0v2VAB7nclSR4tXkB9w/2oQcQM7w4E3L6KyqnfF17yGYXL0bMYnb4k+Qollk6+
	wqTKqfiFlll0k6uc6WTDXAPca+ghOIysLUWrvHr6THilJX6t/GGVQGrDXy9o9Fw==
X-Gm-Gg: ASbGncuM6dFCk8sK9tkVN5DNecL5A6NpRGj4S2487Hz6kMj53BGnAgIu2iYKdppFKex
	Xtxt5nyKBcnrjlVl6ay5l3W0JzuEBkzffH99dw7r94IV71TqSektf/SlVjNkshQrxfBbdZYGY8x
	zlA790MlJGBTTeDdiroM9pX8lrDzSJr1FCRbWNRUuQPcryYTRIJujxeB/vJ27V1d1i60X9Gqg7l
	aIfLDb4NmjjXse4DRCr0FkwryNDmbdg/KOBVVdH6EG/gZsbip0akoWBCBKixeEifI4TTIb5RzNc
	i/8DNJWahcrS5udUn5AzZ7yY1+CNJ1j4pZLkdRc9
X-Received: by 2002:a05:622a:1e18:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b11e1d90acmr46799431cf.19.1755281274179;
        Fri, 15 Aug 2025 11:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIFL8g7XQhsMPGTyoNv6Li38ROXnd8WvcQK4CNRnxnJmk7FseGl37XyM7Hw3AFNb+Bp13NLw==
X-Received: by 2002:a05:622a:1e18:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b11e1d90acmr46798801cf.19.1755281273659;
        Fri, 15 Aug 2025 11:07:53 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba906706esm11645436d6.17.2025.08.15.11.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 11:07:53 -0700 (PDT)
Message-ID: <42121eeb-6e7e-4138-9520-8ee81679ddac@redhat.com>
Date: Fri, 15 Aug 2025 14:07:52 -0400
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
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <9d84391f-d724-4693-90d9-c56d54ece17e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey!

On 8/15/25 1:26 PM, Chuck Lever wrote:
> On 8/15/25 12:23 PM, Steve Dickson wrote:
>> Hello,
>>
>> On the more recent gcc version (15.1.1) the
>> -Wold-style-definition flag is set by default.
>>
>> This causes
>>      warning: old-style function definition [-Wold-style-definition]
>>
>> warnings when functions are defined like
>>
>> int add(a, b)
>> int a;
>> int b;
>> {}
>>
>> instead of like this
>>
>> int add(int a, int b)
>> {}
>>
>> Now I did fix these warnings in the latest rpcbind
>> release... But libtirpc is a different story.
>>
>> I would have to change almost every single function
>> in the library to remove these warnings or add I
>> could add -Wno-old-style-definition to the CFLAGS.
>>
>> Now I'm more that willing to do the work... Heck
>> I'm halfway through... But does it make sense to
>> change the foot print of every function for a
>> warning that may not make any sense?
> 
> I recommend breaking up the work into several smaller
> patches, and posting them here for review before you
> commit.
Not quite sure how to do that... at this point it
is one huge commit... growing as we speak. Even if
I do it by file... it will still be a ton of patches.
But I agree... trying to make it easier to review
would be a good thing.

> 
> Maybe you could also pass the result through a C linter
> or clang-tidy. But don't go too crazy. You get the idea.
No worries... I will not go crazy! ;-) But if I do that
God only knows what would be found! :-)
This is old code... but point taken.

> 
> Out of curiosity, what is the test plan once your
> conversion is code-complete?
The upcoming bakeathon?? In general I lean on the
Fedora guys to do the regression testing...

But at the end of the day, I didn't realize
there would be this much change... so I have
not thought that through. Idea welcome!

steved.


