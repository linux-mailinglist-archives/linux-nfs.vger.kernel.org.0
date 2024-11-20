Return-Path: <linux-nfs+bounces-8162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0999D4344
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71791F21C3C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3EE13BAF1;
	Wed, 20 Nov 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJ7t30M2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F4487A7
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135865; cv=none; b=F/r3wwR6Z1mdbUw8zLAdb+oAu/rtp6FfYF3axXhaO5yFNNzlr9vK+yzkfL4C/HfeDd4eImkd503pb4grHhJew7OhqB/32D25ZdLAmSr9UcWy029N8025W7kMWM3ecubaF+o2AEvTpTbks+ibPYsc8OjmM4/ewmxszE8z4RgEBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135865; c=relaxed/simple;
	bh=1DD1Yz9GMLlNiwMUVDLj8EjJic4ITvgCCnuCgyDMCTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbgnoO64QWYSws8esJvrRwio5jZZAx35OebeVgA2tx4AWngdO5TfJWloRVly984zanchTvfKDy6mFlmBTECE88wTe/7YRurv3yQC0gKIIedpFx7TtDQG7L8lvzIIjQv3Cs86YjprHX4YROIOBzOBqHomybooFGcefzIAtnu0ADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJ7t30M2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732135862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEtxkbxa+BGi2A8l4iq5w+WYAp1Bdc2LQa7tEAPo+q4=;
	b=iJ7t30M2vqdaO0UY4i0tVSWfuJSlPUKwHtnRK6slRuYhJ/Bz0slBPJTH36IprQi3npj+pW
	adCBCQkOpbn2VEWPc471yH+RjpqW1sAB1BRS19j4UCblmNP2Q8yKyPVROgG7pr3i0u3u8l
	T54X6WOKWxQnRN0g/3tedpjwP220r20=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538--B41C0_qNf6EDu3aukgt7A-1; Wed, 20 Nov 2024 15:51:00 -0500
X-MC-Unique: -B41C0_qNf6EDu3aukgt7A-1
X-Mimecast-MFC-AGG-ID: -B41C0_qNf6EDu3aukgt7A
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e5fef7b126so188575b6e.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732135859; x=1732740659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEtxkbxa+BGi2A8l4iq5w+WYAp1Bdc2LQa7tEAPo+q4=;
        b=qzBVN3dtEu8OV2m4Eb9PH8BvTc31LVhll7oZy3SAq9u9tHc1ZQKn0CyXb9LZDxzJ6J
         /2XQLHlyDz6uS3OYRXFxtDrUXM8/o/0LmuaB1Fz0CngipZ2RDs+mE8ZQ9FXffF0xbboy
         g26rKOtQYVHMwWt85TivTMknDNN618QhNJxRXyYBMV9ZSu3ylfKuJYhLfFc/vTS6jT0K
         wkPBTcf0YtNb2fBzHXTB7xdkH05esbLq0lNx+dj4pFgbn8+mHadKKEgk4gp0nHWWKbJH
         dfA40UARqNfsCM+UCUpr5qvWRZlY884k6byml2WQCerweFZ0iRMWFRNBhCVzW2oYpPEP
         y9KQ==
X-Gm-Message-State: AOJu0YwdycXyRb/+1xyzYY0qD+vCnEpfGATqzxrNUWC4FiV5S4qzsbQX
	bCVPiARJBI75zEezMRytw3PXje+oeN8ssur1TFuqQfH1/SEEnCZcXdVl0W3w92IzmNVrRhbIyDl
	0dmiwI3GlkOvcDpOfRh/KaZRVOP94UYQx3F87wA85brS7luBPSc0CW53qtyj04k1X4Q==
X-Gm-Gg: ASbGnctJA8gG8pPUc8i2/wFTVTY8q6fCNoSKwmYaxe2gmJpLh/AQAufAa8rTIznK34m
	UysgQ01Q+okK3lQkuiA/vwCbMWIWP5OeSdp4zCpu29o0ChWnjJU8jthn2YFN2Zh+kgA+fC+PL98
	gy1M8+mJhTUV1ZP4wQTJ5ERXoFGhaPHnIiXz6QpVa5199D72o/KUjiE07UFfYPPlYljIhCxlSYO
	F10eIjw6fYb6A14kj4vgKHIUnk7vvDBDiAtvro8i/iHXvM0Cg==
X-Received: by 2002:a05:6808:2519:b0:3e5:e4b2:8f10 with SMTP id 5614622812f47-3e7eb6eca0amr4182654b6e.18.1732135859533;
        Wed, 20 Nov 2024 12:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ZQ9Ljrf384NMQ1HB4J2i9Dl8Zql6HbMAxcs8+UMGAc1pdYWMtWY9yCXAYLQUJs7dsNDp1A==
X-Received: by 2002:a05:6808:2519:b0:3e5:e4b2:8f10 with SMTP id 5614622812f47-3e7eb6eca0amr4182639b6e.18.1732135859166;
        Wed, 20 Nov 2024 12:50:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6e7f2csm3446952173.15.2024.11.20.12.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:50:58 -0800 (PST)
Message-ID: <ff57df3e-70e7-4487-a9e1-1324775ec9b7@redhat.com>
Date: Wed, 20 Nov 2024 15:50:57 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: fixup statd testing simulator host arg
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <e8a429e2957d3771031d6d944981eaa16ea9feab.1731514372.git.bcodding@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <e8a429e2957d3771031d6d944981eaa16ea9feab.1731514372.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/13/24 11:13 AM, Benjamin Coddington wrote:
> The getopt setup for the host arg was not expecing a value, update it as
> expected
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc2)

steved.
> ---
>   tests/nsm_client/nsm_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nsm_client/nsm_client.c b/tests/nsm_client/nsm_client.c
> index 8dc059179806..b757209c3769 100644
> --- a/tests/nsm_client/nsm_client.c
> +++ b/tests/nsm_client/nsm_client.c
> @@ -72,7 +72,7 @@ static struct timeval retrans_interval =
>   static struct option longopts[] =
>   {
>   	{ "help", 0, 0, 'h' },
> -	{ "host", 0, 0, 'H' },
> +	{ "host", 1, 0, 'H' },
>   	{ "name", 1, 0, 'n' },
>   	{ "program", 1, 0, 'P' },
>   	{ "version", 1, 0, 'v' },
> @@ -136,7 +136,7 @@ main(int argc, char **argv)
>   	my_name[0] = '\0';
>   	host[0] = '\0';
>   
> -	while ((arg = getopt_long(argc, argv, "hHn:P:v:", longopts,
> +	while ((arg = getopt_long(argc, argv, "hH:n:P:v:", longopts,
>   				  NULL)) != EOF) {
>   		switch (arg) {
>   		case 'H':
> 
> base-commit: 38b46cb1f28737069d7887b5ccf7001ba4a4ff59
> prerequisite-patch-id: 8e580f79b2ce8a4c0771e250fcc7c67f943b309b


