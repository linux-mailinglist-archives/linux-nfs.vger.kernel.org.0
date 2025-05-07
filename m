Return-Path: <linux-nfs+bounces-11577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBDAAE2C3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8AC5283D8
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3F28C037;
	Wed,  7 May 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfQOI1eC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97E28A1EB
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627307; cv=none; b=l/HndZExec8qggHvvQo5RoERvSgvkowLMW9bfNKqfDFtXJ0hgx5PNhU4pn+ycUmxPAYP6J8wRMFRN/kxmXrkFwoir/I6Tofsd3RqHsAXTTl3ExttHvmsuH0f7XiyWNeGEdzX6X3gWz48TQNGJXivYe9TmWFLzbfWwPrbyBv96/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627307; c=relaxed/simple;
	bh=UK7ZCOx4OADDVpWjQHMJgc9LDEjXvN0B53sAzWKeXh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN5vdm/rnwjiwEveOdtGHs3zWtAInTZf16Ta4xece6t2pVhNxr1PG+RNVoBRFV566d0F2pZs6U0TfE+F2lLRhppfFYQaowWo25nVHm/iHbWrF9v5AtzbpBw+t70q9Q4x+4tRYFY7daJKCImda7+Bk09FmSyktDcoiy8Hd9Xhd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfQOI1eC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746627304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9GIHHBe2DWdqL71MfzxlYkwZuC08u0cVJcdF9XzPec=;
	b=dfQOI1eCMHiFc9lsc0BPy0KnSPfcS6+GdynXpzxyrcyXszbPQArzhxfEdFmzsNrL9KC17j
	BlOedzuUGqn2KO63xv8G31w2QcqYTFlLnGU7cXBNSiOqPTPHb2a+nT5RZz2ieNDsgraYkj
	6HBVPBM58F3Ih/t9TZncifhN63D2JJs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-HbSoOWt7PJi2yulVcMXkIw-1; Wed, 07 May 2025 10:15:03 -0400
X-MC-Unique: HbSoOWt7PJi2yulVcMXkIw-1
X-Mimecast-MFC-AGG-ID: HbSoOWt7PJi2yulVcMXkIw_1746627303
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feffbe08so164623356d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627302; x=1747232102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9GIHHBe2DWdqL71MfzxlYkwZuC08u0cVJcdF9XzPec=;
        b=HnPbqnIDJe6Iz4D/4a0lftDBa4zOFW4upl8aWm2hHU3wQDp5i9ckxNKfhuuZ2GxD0J
         nc5fD0j0F3001H84Zun7T/7AfTUhJyH5zVhGrXIxjgJs/XQnT5x6UoNLkHJNgSHuV9ce
         gdIm35mDfX0fg/BUSv5mwIlHZsW0/5OahAnR2myeBb2e7MgJAJIl6y4Y1dFVBI1FOtvv
         RTh/Y2aXc2LOdiT7oGvlUNVX8ERz0Ity0xOUAn8JDciB+4eIbmKte40bcXeUIfKMa5rO
         7dnY2mW/j7durJmtbHuRKoeKcP0oSBJnnfDowUw3qYB3XMs8HQK+rZydmxwEORsPB3jV
         nnuA==
X-Forwarded-Encrypted: i=1; AJvYcCVepToVXiXV1b6bOXfSTQMkTDv9oMDOIjGOIzpjAT1uAJ6fA6Q7lDb4s4YVX0tVucf2OOYvc0Siq/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuzciIPspZyEb2wJPVy8qkr/F3P4WRcBMeL5Nv+QiuS1VFaMo
	HupDJnbcfTpAt4GzvcFkzhfbYpCHmlL1xZ1+XBDTPewLT4Qc+qsNrmXsHOKh+56wDIn8UtY3BA6
	2GcmpgoG8HztRKjR15XgZnOhRmK787/oUvd3rGe5d1GpmRPGHShjhrVdkDqSDGfiqhQ==
X-Gm-Gg: ASbGncvKtLgVMl+NSx1VNPwDXQvlPwyPC1jTgmlMhEirRhsosFP2Gx31S/wnIYOE1up
	nwY6n/zE+k0KoBVHWMb9VPjvzGrRJVQv1t3BF3eqCctWyZJLd1sSSuVx994TZZ6gVnr6s1N3SJk
	ekp3F3V7E8Ti1+4Q119jLA/C1Sqsn3ZTZzqucWjbYKV5hXhW5WAaz1YcHCuRjYRbYOaHoRgMs/N
	8VNzcLAMsTPk7+PmMp0p9t5gaZ9J1wCYwhSPE/ISwbRMWuktfK9A5wWJltUt6PNf3NsBdjjgQ+p
	WkH0JHb1Ww==
X-Received: by 2002:a05:6214:226a:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6f542ae3cdemr51014806d6.34.1746627302233;
        Wed, 07 May 2025 07:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZStABUmunh6hLoRwVFeWvLWe2tHkoOVLSunL9OrO0uZl4b7WeeZP2mmmy6KQoxUM2GzZHdg==
X-Received: by 2002:a05:6214:226a:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6f542ae3cdemr51014326d6.34.1746627301761;
        Wed, 07 May 2025 07:15:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f542780cc6sm14178986d6.83.2025.05.07.07.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:15:01 -0700 (PDT)
Message-ID: <b12bd840-8aa2-40a6-8880-d017ddd54fbe@redhat.com>
Date: Wed, 7 May 2025 10:14:59 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gssd:fix the possible buffer overflow in
 get_full_hostname
To: 597607025@qq.com, linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn
References: <tencent_86CDAF841D6F5657A618E706DD1CAAD95E05@qq.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <tencent_86CDAF841D6F5657A618E706DD1CAAD95E05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/25 10:17 AM, 597607025@qq.com wrote:
> From: zhangyaqi <zhangyaqi@kylinos.cn>
> 
> Signed-off-by: zhangyaqi <zhangyaqi@kylinos.cn>
Committed... (tag: nfs-utils-2-8-4-rc1)

steved.
> ---
>   utils/gssd/krb5_util.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 560e8be1..09625fb9 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -619,6 +619,7 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
>   		goto out;
>   	}
>   	strncpy(outhost, addrs->ai_canonname, outhostlen);
> +	outhost[outhostlen - 1] = '\0';
>   	nfs_freeaddrinfo(addrs);
>   	for (c = outhost; *c != '\0'; c++)
>   	    *c = tolower(*c);


