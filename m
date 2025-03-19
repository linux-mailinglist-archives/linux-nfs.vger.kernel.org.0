Return-Path: <linux-nfs+bounces-10701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEAA699BC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBFC1891134
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AA1E5710;
	Wed, 19 Mar 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2/aN/K1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCCA920
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413794; cv=none; b=gGPRiGnP+HhlpIQF27eroEJb3T5HwG7M4GFBAAligixbdTza1npjjC2xI8rLHQGlG6Mbdv9aKO3GqFVxSRqsBAqqi9tCoFuIU4XFU6mgYGnMmFpLCIATd9x8Lew0ZuJSVOAXyJa46YrBUdbRjfQyDkza7DHqU4Gz1pZuwHhx7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413794; c=relaxed/simple;
	bh=/HyDRKPFlvGKoEmKnRa6D8yfzorBMybVVEULwo/0XLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJvVWYptkEyi76YRbfA6Ak+QMd1APgwKmxgyMrMUUemK9/R3Mdz6bDrFcH0cwb5YXb8Es5A+pCxQO9Mc5juuCVwqS4a7qoIH7Cqshw1d7tAEvlFLOjfN64hPpTm5FjUq9Px075VhJCrLtegpbYW9+1z873HUy3OxH/OkEqzpehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2/aN/K1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742413791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvsYaZvdz0y4tUSN7d8xYGBzQ7gicT4e59dnB2dcgyI=;
	b=Q2/aN/K1qaocBY1lRlv1lFPM/aIIzgBnFYHotTJovZ5Tq1Fq0PE9vzZxNLMPv9YRmMQGfi
	iJoUn31U2eV/m/oygX2yxrKo+oIdD9cWB9hTlM6iDyGX12yeCrfmzVm9m3Os3oTJ9o1Jxh
	oHyEhXeYfD+tB/t6UQ1IBq+sAllDbCM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-dTC9kp--PjS_jfNyTYVWEg-1; Wed, 19 Mar 2025 15:49:47 -0400
X-MC-Unique: dTC9kp--PjS_jfNyTYVWEg-1
X-Mimecast-MFC-AGG-ID: dTC9kp--PjS_jfNyTYVWEg_1742413787
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so380105ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 12:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413787; x=1743018587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvsYaZvdz0y4tUSN7d8xYGBzQ7gicT4e59dnB2dcgyI=;
        b=cVNLoZqMS7I/kDaQf3b3swxi+Ws3MDZYtsnONlMUeSk//sTTyVoWky/isCL+11yClH
         04sH15AW/K7wHhtAL0LPrP6Dhm9jjeq22DSQ1kdGPk10i9ZAOYpuSJks4DyRp12HMddM
         oSBX1MvEFHPdy/bMkzEx5KAzEMyiVb9jzZPY3/iLnWsbCmwus4F8i/h/Uwn0oTTP6Yas
         X3Nmfc2Tsb//yeaqmCgmxPncVkk/htOoXeSxAPBDKfRrNOSuzwmnJ+0uQ/vxm97WwQx2
         gKVSdalRq8o7ENY4Xl0BkPmVWpjcoTi9cGsPBD4liA8AXBDU5GaM5CWWJfUCH626sBN7
         2IUA==
X-Forwarded-Encrypted: i=1; AJvYcCWjNfCPYundT7AdQfM9r5p8OzJ4eCNmMph/oyXfBwhubd9I/eJX2qIL3vZtscKPgFpOp9cecM8h3ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlcSY6h+2ynv5cUcFyI2X2F/dm2CIvhVXkov0J0PUkHn8yJHC
	3yQodaqEM5aPqIdqJF56ex0sUYflH/oV5M2WS8GH/NE8CM/+A9K+9+J0g+WFShOF9KsHqk8gDkV
	OseQN9NZXEAJ8a1MaeeO2Z0xP7oD45qWG2M5e8nU63mEgWq9sSHyXximPtw==
X-Gm-Gg: ASbGncuOPzXQ/iWtXQcr2YO7ySvEhFxXAIGwS682HsUIQyAjkfi+DjvcUmjsMbva1ID
	IhurUmRTWyS44pI5IpYTSLEV6Syk/hsMh5BeCu+fzwAF7RBZlGzGwhKO8UtHOzBPrladueBqgXW
	Ok+JPLCuYEX+v4EO+HPY+3eiCZPRgCDeZbtB8rDX9mmcUGUQYdzDOI3oyOlFgi+1p/SO1fDJXaf
	LQ8kNcGIOlp2dy2uqu4p1svQn1zHKI/MWOAQfO//KG3nIwE/Gb3JWaWpLizhupHu7MqoZ3oilNi
	75UZC7a9qM8WoMJ9
X-Received: by 2002:a05:6e02:3787:b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d58e73bed0mr9227825ab.0.1742413786909;
        Wed, 19 Mar 2025 12:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHWYEh8simdCymYDrf4CAgIX/SPzgFc2351eLJKks0vZmnKKdl0C7EsT6ld/05AUPAY5C8Iw==
X-Received: by 2002:a05:6e02:3787:b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d58e73bed0mr9227675ab.0.1742413786556;
        Wed, 19 Mar 2025 12:49:46 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.248.172])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fb326sm3387786173.75.2025.03.19.12.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:49:46 -0700 (PDT)
Message-ID: <8e73b3d9-d5f6-4dd2-9f5f-7741e6895509@redhat.com>
Date: Wed, 19 Mar 2025 15:49:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: ensure autostart honors the default
 nfs.conf versX.Y settings
To: Scott Mayhew <smayhew@redhat.com>
Cc: yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <20250318201714.1164817-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250318201714.1164817-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/25 4:17 PM, Scott Mayhew wrote:
> Yongcheng noted that after disabling a versX.Y option in /etc/nfs.conf,
> and starting nfsd, subsequently commenting out that option and
> restarting nfsd would not result in it being re-enabled.
> 
> Reported-by: Yongcheng Yang <yoyang@redhat.com>
> Fixes: 03b2e2a1 ("nfsdctl: tweak the nfs.conf version handling")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc7)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 05fecc71..5ea848c9 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -1318,6 +1318,18 @@ static int configure_versions(void)
>   	bool found_one = false;
>   	char tag[20];
>   
> +	/*
> +	 * First apply the default versX.Y settings from nfs.conf.
> +	 */
> +	update_nfsd_version(3, 0, true);
> +	update_nfsd_version(4, 0, true);
> +	update_nfsd_version(4, 1, true);
> +	update_nfsd_version(4, 2, true);
> +
> +	/*
> +	 * Then apply any versX.Y settings that are explicitly set in
> +	 * nfs.conf.
> +	 */
>   	for (i = 2; i <= 4; ++i) {
>   		sprintf(tag, "vers%d", i);
>   		if (!conf_get_bool("nfsd", tag, true)) {


