Return-Path: <linux-nfs+bounces-8161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D749D4343
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF7C283185
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AA13BAF1;
	Wed, 20 Nov 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRaKdvdg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD72487A7
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135828; cv=none; b=g5RQEHZFy0BCX/YmpiK9Da+ZX/9yI+BnKisIfcGCOTVZh9LPa+ZFL20RzI4Xtcj/tCXeIloUhUGQg15oSe4izz9yK1ApVDPUXMWIJ0CP+7EKzLac7xPAl3CQ/GCV/NcZjVKfPzamg8vCUDWKUobo6RZ2HAkLnRmhlrSj4zopQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135828; c=relaxed/simple;
	bh=1DD1Yz9GMLlNiwMUVDLj8EjJic4ITvgCCnuCgyDMCTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP9k1lBIP96lVXQhS+tAWX1kkxvrdFycVgwS5qxh1CKgUZpTm4OR9VvnN/S5v9evmBoJPov7ZxM0Nn0n7DTYJMa5htt3NYnLCeexGXWiUsBL7Tiv2fJp3M1WbNeM8dD1dS4p4oj1gT9BBVp//aTVXKo/5yBmOD1chu2Ml4bPI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRaKdvdg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732135825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEtxkbxa+BGi2A8l4iq5w+WYAp1Bdc2LQa7tEAPo+q4=;
	b=FRaKdvdgWdkB3nxMvWTTFmgrNJc/zde0AfLAs0fKBG6h4SVjxI/xlcGfrJiPnV+RLcYnND
	6v11iwRRrQGYLPHaZ2ok3oYXgcrsuAdpSBMk6iLiIdOHsiXJRzijK3r7Y0oxk70NXpuy+d
	W54VIKLsE0+eR01En2aEJ+BRFzNJiks=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-HKPpba0aNTa4i-Ekplw1pg-1; Wed, 20 Nov 2024 15:50:24 -0500
X-MC-Unique: HKPpba0aNTa4i-Ekplw1pg-1
X-Mimecast-MFC-AGG-ID: HKPpba0aNTa4i-Ekplw1pg
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7776959fdso1321245ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732135822; x=1732740622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEtxkbxa+BGi2A8l4iq5w+WYAp1Bdc2LQa7tEAPo+q4=;
        b=X/txDvZdaUZFffXV4OdOMLBP+tQLCdeQIZqmw4ro2SA6+pCzDhpFwtGyV7l99HRhZc
         YcVgNrpjA0uHK9NWQVAGTjscd26jWYnLoVYPQEDoywurxVcthAfbvFB/adpAS2AcU8Nw
         1EhWvYbSKpJ0U245LTEnFu/pOL1vftjfM687OuMMUF2MFYg9riSa39Gbe3oIGmbXutkx
         b/6n33n1UeKK8/4S5K7UTaix4U3fYKXWKe12E6GZwLbjSCBi5+wUXIu2T6DUHWke8tQw
         /bVJi6e1XceSKBI4N0n2/mN/EjnvaUxEjqsBIHUOJgfNOYw2GqffjWD8pxzd1la8pO+w
         bXQA==
X-Gm-Message-State: AOJu0Yz0qcjEMF2Q/Wo5hLmh9zEOUrSvKh4CZ4rEa7EJXFMfyYINh/bF
	RK865FVuTUguW43cr1V5UuHPHOiIu8W1TVQ+/pK9/+ISAiezKf1yG3vVRUwZ0BvgIYzfYVhig+V
	JAb6K4rogYRin4uG6RBd8hpZWjNO7U8F5+bXv0oZcnEdMWvnn7HMIcYO7YbqSexmCDA==
X-Received: by 2002:a05:6e02:32c9:b0:3a7:87f2:b00e with SMTP id e9e14a558f8ab-3a787f2b0b1mr52041535ab.19.1732135822340;
        Wed, 20 Nov 2024 12:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGjMjxT+uvlSH53KkIh+YRMlpN2bGKAJ1hhhWlj7VjFR1qwg1vaZkXjHgLKxB9qSsE1PAEPA==
X-Received: by 2002:a05:6e02:32c9:b0:3a7:87f2:b00e with SMTP id e9e14a558f8ab-3a787f2b0b1mr52041385ab.19.1732135822033;
        Wed, 20 Nov 2024 12:50:22 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a78eadf929sm1914175ab.10.2024.11.20.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:50:20 -0800 (PST)
Message-ID: <59677bfd-1163-494b-b325-3d0cc3223dba@redhat.com>
Date: Wed, 20 Nov 2024 15:50:18 -0500
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


