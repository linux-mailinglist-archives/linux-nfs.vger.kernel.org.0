Return-Path: <linux-nfs+bounces-6573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0097D8EF
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EEEB21E63
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3261C6BE;
	Fri, 20 Sep 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES1yxaXX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2901EF1D
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852632; cv=none; b=l9wUA5uhPr8vVS33QqPD+VunzycTkNGmohiCzlnaUVHjthqD1mg2DWoQWP8bYV6rAEiiQvJk/y0kAla5pAnhq4td1lXlYtjayEdDYop7pJeRovO1UpLJWXl7BuHVNe/RGOL4aWT+8H1u4aPPgqAfr6LIuyLb0TTBq7Fky0xhOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852632; c=relaxed/simple;
	bh=d7YIWdTax/hW51QsQ2k4e+tX5Zn6AJcwRTPrme7JuDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+I00YiHeKltkvHj4zLMLZi9KwmwzwSdXf2Jio18Fu/HHxY8uvnyH+Z7RonFU9bC/L+PkL12kM/jKktmBY2Vc4yuhDPm/FpnpBem5OgWFZvuoW9grPHnH880nFTIw//CGQYWymjrI1yuWDmtdh1lea9EtNJloSbAFFNQ3JRBOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES1yxaXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726852629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXOHWiOt7911ioqr8yIjjKEVmIrqorV0HU72lBE7nYQ=;
	b=ES1yxaXX+hM8ckM9gGZe0DKD9OnJL6BUnhyUzko6R89SLjNuZqiRHxFRE9eAIH0ZAUdUuC
	viRd9clNKwrNmtM9eFAJXSjfRV/56d8OjpqLiRY9Xhj9LI6PEKmonJGhu1ferKdP4tznEv
	BRBsvzXE3dd8MqasTNRvx3gCO9wixFQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-b_CbI9UDMhmBWTor2brUSw-1; Fri, 20 Sep 2024 13:17:08 -0400
X-MC-Unique: b_CbI9UDMhmBWTor2brUSw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e27a592c37so209400b6e.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 10:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852626; x=1727457426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXOHWiOt7911ioqr8yIjjKEVmIrqorV0HU72lBE7nYQ=;
        b=sBQS4zWIKXe3bIOMsdtq/y3yG/Bam7azwq8xtwIPci15Qm+YCS2UxdFN7qwOrHZNIG
         rkjXZ4yc88we7PX+JQtd7HBu/wurinEcn1jegsPf9euG1uN1ohVQOzK7Jz9tg/IY7xtf
         hduQgiuiEVEGdjC1tMhtYR54HhbWDKO0Aya6XlzebKbKjg4uposRllFJv8G/wjQu86+n
         ZHoVo9AAefJ+Q7BTmxS57cbimwnO8fBD6wbxW4Lme8pOGVwUV3jyJg4OQ2vcxdAY2yYx
         Iet6aA7+tgiMbycEipP8C9zNzgbgoUscwNIo7Ny4Lb7FMIi5KWo4xnktmy03Ez/0GvdK
         nMUA==
X-Forwarded-Encrypted: i=1; AJvYcCV0s40d4lu9GH3+59UgvKcu7DYo0yNyVo4Nc7N5PNGqj3+/Xa4zg3CCSkj+OcMa413gzqOQkazw8TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1dTE98TdtXaWA7l36+Gwfl9uLaYo0ZIgqJIDLfTbToTvwdEa
	q5+g6NDrlKlk4T+ffOx7G07aDK4OXVW+eUuAc8DQavywCSP1DtlX0IemOZbFGiMnlSvrCwL8Pv5
	C0B03dlKZdX0zIIsOV24zXaO6bvHSB/skANC49SnzSb31GOx732fds8xY9p7tPsTZCGiX
X-Received: by 2002:a05:6808:1882:b0:3e0:736a:a429 with SMTP id 5614622812f47-3e271b92191mr2288591b6e.2.1726852626597;
        Fri, 20 Sep 2024 10:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0+qEyHnnoHJNGj3uWQ/SgU6VBph2Y7IDQO1fNfVVWz3MZkgqyE+OeWQbtySU4U5a1RTcnQ==
X-Received: by 2002:a05:6808:1882:b0:3e0:736a:a429 with SMTP id 5614622812f47-3e271b92191mr2288576b6e.2.1726852626280;
        Fri, 20 Sep 2024 10:17:06 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.244])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8493978dea3sm1821003241.1.2024.09.20.10.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 10:17:05 -0700 (PDT)
Message-ID: <7839fb66-4a7b-480a-93c6-89cccde47771@redhat.com>
Date: Fri, 20 Sep 2024 13:17:03 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 1/2] support/include/junction.h: Define macros
 for musl
To: liezhi.yang@windriver.com, linux-nfs@vger.kernel.org
References: <20240908121217.967390-1-liezhi.yang@windriver.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240908121217.967390-1-liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/24 8:12 AM, liezhi.yang@windriver.com wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> Fixed 1:
> In file included from cache.c:1217:
> ../../support/include/junction.h:128:21: error: expected ';' before 'char'
>    128 | __attribute_malloc__
>        |                     ^
>        |                     ;
>    129 | char            **nfs_dup_string_array(char **array);
> 
> Fixed 2:
> junction.c: In function 'junction_set_sticky_bit':
> junction.c:164:39: error: 'ALLPERMS' undeclared (first use in this function)
>    164 |         stb.st_mode &= (unsigned int)~ALLPERMS;
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Both committed... (tag: nfs-utils-2-7-2-rc1)

steved.
> ---
>   support/include/junction.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/support/include/junction.h b/support/include/junction.h
> index 7257d80b..d127dd55 100644
> --- a/support/include/junction.h
> +++ b/support/include/junction.h
> @@ -26,6 +26,16 @@
>   #ifndef _NFS_JUNCTION_H_
>   #define _NFS_JUNCTION_H_
>   
> +/* For musl, refered to glibc's sys/cdefs.h */
> +#ifndef __attribute_malloc__
> +#define __attribute_malloc__ __attribute__((__malloc__))
> +#endif
> +
> +/* For musl, refered to glibc's sys/stat.h */
> +#ifndef ALLPERMS
> +#define ALLPERMS (S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO)/* 07777 */
> +#endif
> +
>   #include <stdint.h>
>   
>   /*


