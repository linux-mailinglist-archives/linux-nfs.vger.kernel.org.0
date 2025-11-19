Return-Path: <linux-nfs+bounces-16571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34551C70A38
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0FB8343977
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E843112D2;
	Wed, 19 Nov 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IleJNGpW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVcsWFA7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548526C3BF
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576591; cv=none; b=kDR81ANI1ok802tGGVu/5d9FEy4KFhqxsqa137dchKzSeddfceXN40JuFwGR7rprTJ6fy47GG2ipZdjK3ofv8eT/1agZ97pUM12Dtv5mw/EKfpDfOR4f1jZngav9mLEGoOBLGR8RUO8tm12tffr+C9rVDU7DRFvJeQtA8KWXP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576591; c=relaxed/simple;
	bh=kIE/2jpVArIfWTz+yU9k0O6c+hOXWKg0ujMakQqF3dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S2rUCGY90qzVe/x+DJY/bO20u++vJI9zudBGnE18UQXpPnpmiFOiF28L8nNzOV/rSg0wu8r6/UnuhSuBuiOL5AznOOdO+f1woAr5Gnqhs9CrFG9Dgyr2dG5suzklsGR6ef+XPUHJmEE/iv0NFHDycrQR5HJIbpx5QbjH7G9CFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IleJNGpW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVcsWFA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763576583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw0qt9nIqi048zd9eDMfUVaCdS7lucHj6QtAWfhbmzI=;
	b=IleJNGpWOIuEbhzTGdk+vKExj32NHYgKzWaD7N1k6UQ+QVe4LOCZwIA73tk4H8Lk0uPIpE
	eLAlkRKC8PIqeCxXA7x+vQLrFYG6psg+VAOEZtLU+KbwVxErldSdHZ04z56ckXUsbYSVyf
	8V3CGVkodbqtkmEt93/0rWk0Z8hMjjE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-LF9RvQIKOGS5betF9GgtkA-1; Wed, 19 Nov 2025 13:23:02 -0500
X-MC-Unique: LF9RvQIKOGS5betF9GgtkA-1
X-Mimecast-MFC-AGG-ID: LF9RvQIKOGS5betF9GgtkA_1763576581
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882529130acso834786d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763576580; x=1764181380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw0qt9nIqi048zd9eDMfUVaCdS7lucHj6QtAWfhbmzI=;
        b=JVcsWFA7PGhIbQc6FOrgZFtQ4zoLQPxDd/5K1VrJi/VxgHOhhpj3ZC6EV9U8WEFx1J
         OZx7jZSeRwKBvPW1hwHOXahbWE43p+9Z6+SpWsIEWtbSLR9j7T1QoTrtfZXj+IG+kX8T
         a0gm06MGjkXEC5hlZrqqDbJadR6WeRALwjYk7gzCVNaPDwqLXnVYEAy3gsQYR1wJx+ZK
         1X/pvAe1hxNjNbrF8UeQysHYp8hKzo6sRcnMW9fTm2G8DJDbCV3cvbdBLxpL5wNEBn/H
         V7q+5yLkmeDWZAfSjV+4mIQfDvV3Vee2HXli7MgUNmDj2PBwtiZNa4dAsUnUJHGaWwCF
         c8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576580; x=1764181380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qw0qt9nIqi048zd9eDMfUVaCdS7lucHj6QtAWfhbmzI=;
        b=JbM4Y9bPsRESNJIYE6gGD4c+dtpZWTtzEj0hLU6BhThYfS5H6FHh00v65d9mX0iDef
         1pYwS+Wxl6nvinjMxtjPi6vOxWJSVgJztJ4i11+L73sdcfKlG5vsJtW1Mg9u8RdsCLSC
         mQ5UgpGzCEzZLSI2DCLSeUMafIcedgsFg0ZL4wZjl/0v0HcBq9JqvYzcvcwdsViJC9sl
         oHe8c2bTUBga2aEkeIRUDokjGuoZhDzbBa/R1H7OnW2NI8fqX9ByKVrOCf/CYnn5dp0N
         mKnp/P589Rz5Y2XskArjDuda0QhK1qRYhl6mzWF0JMeW3rQxOmwjb57UY7PW2lk9hAT/
         zCtw==
X-Forwarded-Encrypted: i=1; AJvYcCXOkQ05MQosnLd3OPnckapioMcuvtzAXSHhG2/X7AUgc94RBnmy+ARuSIUbwfSBPR04Gc7pD01PChQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1ZhYeNR/nEctsCcO9/ASygW3b/NOo3g173K+lDEFXdXOQUT7
	MIz8H56GjA3nS6dbjVzflvEJEamfrNm/R/YAbfXai/yaHTYNpMQ5jqNeNB1YAdADkld7yFt6zfK
	S9H3k9i2uwVQdm9amu+n6/3zHgaiB/t8HTyQfD7mBkbzIIAIstjKfWLQ86WnKWgxX8tQSRw==
X-Gm-Gg: ASbGnctPoZT4BJEdYMD9MERmB5aJHfFMOhH2/3RAkK5eiSqdnwudlGOQLQgqMAVr6P5
	g+FgsyH5T8j60N4S4ZlIKccVh9MYxMOw3r2Fapf1faW/84u4mRxyRC8AnvfUpAKBMFrkMjkc/qJ
	78TlRE2+OyQgfsD7syIs6rydb4/eDWIPnj153xkO6Tr3mKMdSONptN62tv8mOCVSZeuDd8v/ZA8
	TnamB2hMeYbJUoiH6/qyZjlGSxr8f91FFUHTpbjhxcZDUxP6IGACFecnKTKg3/Wf5D/SBkcyQvc
	uv0Ky4rmG6PZgIYtuvLY26Y7nG8u0xJMk/4u0W/1KyQpBV5y/tU7kLWYD1jg6MMf2eE1XAIttAC
	nUA6dDtp7bg==
X-Received: by 2002:a05:6214:20ea:b0:87c:2938:c358 with SMTP id 6a1803df08f44-8846e2475demr2153726d6.67.1763576580439;
        Wed, 19 Nov 2025 10:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1JpSgC2TvKigq7DGKtr1+rgoHZ1rbkEUjUVspfEE3JxrGjxSaDXoH9FhroWQYKaGMgEGhhw==
X-Received: by 2002:a05:6214:20ea:b0:87c:2938:c358 with SMTP id 6a1803df08f44-8846e2475demr2153406d6.67.1763576579992;
        Wed, 19 Nov 2025 10:22:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e446463sm472616d6.11.2025.11.19.10.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:22:59 -0800 (PST)
Message-ID: <836688db-32b5-4dcb-a071-8b4949434cb5@redhat.com>
Date: Wed, 19 Nov 2025 13:22:58 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locktest: use correct build flags
To: Ross Burton <ross.burton@arm.com>, linux-nfs@vger.kernel.org
References: <20251117143241.1501312-1-ross.burton@arm.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20251117143241.1501312-1-ross.burton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/25 9:32 AM, Ross Burton wrote:
> This makefile uses CFLAGS_FOR_BUILD etc but since 2020[1] hasn't used
> CC_FOR_BUILD as CC.
> 
> This means in cross-compile environments this uninstalled binary is
> built for the host machine using build machine flags, which can result
> in incorrect paths being passed.
> 
> As this binary hasn't been built with CC_FOR_BUILD for five years, we
> can assume that this isn't actually used and just remove the _FOR_BUILD
> flags entirely.
> 
> Original patch by Khem Raj <raj.khem@gmail.com>.
> 
> [1] nfs-utils 1fee8caa ("locktest: Makefile.am: remove host compiler costraint")
> Signed-off-by: Ross Burton <ross.burton@arm.com>
Committed... (tag: nfs-utils-2-8-5-rc1)

steved.> ---
>   tools/locktest/Makefile.am | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
> index e8914655..2fd36971 100644
> --- a/tools/locktest/Makefile.am
> +++ b/tools/locktest/Makefile.am
> @@ -2,8 +2,5 @@
>   
>   noinst_PROGRAMS = testlk
>   testlk_SOURCES = testlk.c
> -testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
> -testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
> -testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>   
>   MAINTAINERCLEANFILES = Makefile.in


