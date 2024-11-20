Return-Path: <linux-nfs+bounces-8163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448E9D4346
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B481F22384
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9171BD4EB;
	Wed, 20 Nov 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKdWxCaH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531A487A7
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135944; cv=none; b=q0bRzEylSELJW/4VV9zpz7PxbT8iZCmEth1766Zgh+XzlWvwZDXo+W4SMj0uG9ePtnzoDPO5+RhDXlc/qEszbHPSyPHV0Fhgr1nSmel1YZfBm3VzVBhqzLPGSv3/pJb8MRIhSWbuKpUHw/5FWEqeh27Bv4wa6ZXS3p8kZ2r/gQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135944; c=relaxed/simple;
	bh=JcpfvoEAlS7CYA2ieJV8bKKxjf0Tu7dEzlhqeFMEsjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLklW4NRxRlDuR9t9hEieg/06dU3atEfM1HPPjE6xys0hKeCwxV2d0NoDTW8UHN4Jg/T1EaYNde9u9+TamlGHchJFkyTx8vDqPyLJOGo78b/NJ3uenVyOvP6eRKgYvRbqUCv0hNyy2/NMo8URz9tghTAA7HeLkSFF5i2d+6uh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKdWxCaH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732135942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hM95Hzjl7XpW6zUw6Ut8UFECmOIVbyMwTlMhoUfnJeo=;
	b=VKdWxCaHoHPXBihrM1g0LJ2Zkp/A3XsD4AorqUoJzjLZJtzs48jU17cmozmxvGUdx1HqEq
	1SdWuKshBeXkKZSDQOoHJSoD9ro8khV/i7ENo/TO09fLWuGU61lwX5fzMKLT8yef+nBXGg
	uQi1UmieoYHR4f/uiOqEf+oBzrGb3v8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-iBDS9kwTPD6bd8_IkkpOwg-1; Wed, 20 Nov 2024 15:52:20 -0500
X-MC-Unique: iBDS9kwTPD6bd8_IkkpOwg-1
X-Mimecast-MFC-AGG-ID: iBDS9kwTPD6bd8_IkkpOwg
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7642d452dso12848625ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732135939; x=1732740739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM95Hzjl7XpW6zUw6Ut8UFECmOIVbyMwTlMhoUfnJeo=;
        b=ZjXFCBv2Lt+4QBQWo4TNdnWmBc6P4MJDXPP7dEnjt9KyOpcbJ3dD5WWQIe2TX0T2n1
         6p9HwMeymU0a5mxyw72Bv41rOTysMHFiAPqKvKCtdyC+BjuaGLglgwUx3+M6ZSfgOtmN
         CqwFY6bwTy1j9KqRpoFjTpZ6JtYqO/u4mBDicmnqrIM61OUUx7cA9/lm2VEkUnzh4VAI
         XPtdpKeoEtCdvhiV89yrBEhLY9Zm+dY/KBOHLAWjXCO0BM6f7o24vYzhXLJE4fkb9ruj
         LJdzTm1WcqlksYosH4oc4vmTGdlxUvdI7xbwcIPacNRpen5XHswiwDXuelR2XjnVRQbU
         708g==
X-Gm-Message-State: AOJu0YyeK370qCO75X7fIIAU7I5D9ukTu8ZSNHIOm+Zr7h2zY5mFnCVO
	1L+t8SgFmn510yAiVqFM7+AoUs+KRr/ru8t4Jl0ra4/G3c3izzUlYybLO1678iwWrLh8RJI8gTI
	9VuqQbg1AXzglqvyXQAUhWsuKqHIasOWgmGddx9TXxMl0bVHbzvue24GDNzxktbc4Rw==
X-Received: by 2002:a05:6e02:1fe3:b0:3a7:90da:7105 with SMTP id e9e14a558f8ab-3a790da7113mr3692885ab.12.1732135939393;
        Wed, 20 Nov 2024 12:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBR0IDK8p86RCtqwRnDkjBCOjvza+I+ucsMf9xYpY7GR5+Ghq3tFvEgtE6+IAVjAy5em8xfQ==
X-Received: by 2002:a05:6e02:1fe3:b0:3a7:90da:7105 with SMTP id e9e14a558f8ab-3a790da7113mr3692745ab.12.1732135939102;
        Wed, 20 Nov 2024 12:52:19 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a77df148b2sm8738025ab.50.2024.11.20.12.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:52:18 -0800 (PST)
Message-ID: <9d0efef9-f2c4-4017-8367-c636d3d0f7a6@redhat.com>
Date: Wed, 20 Nov 2024 15:52:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libnsm: safer atomic filenames
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org, Philip Rowlands <linux-nfs@dimebar.com>,
 Chuck Lever III <chuck.lever@oracle.com>
References: <95b7c243dae00ef4fd745f2b6d2cd0c979779237.1731514115.git.bcodding@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <95b7c243dae00ef4fd745f2b6d2cd0c979779237.1731514115.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/13/24 11:11 AM, Benjamin Coddington wrote:
> We've gotten a report of reboot notifications being sent to domains that
> end in '.new', which can happen if the NSM temporary pathname code leaves a
> file behind.  Let's fix this up by prepending a single '.' to the temp path
> which will never be resolvable as a DNS record.
> 
> https://lore.kernel.org/linux-nfs/04D30B5A-C53E-4920-ADCB-C77F5577669E@oracle.com/T/#t
> 
> Reported-by: Philip Rowlands <linux-nfs@dimebar.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc2)

steved.
> ---
>   support/nsm/file.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index f5b448015751..e0804136ccbe 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -184,10 +184,10 @@ static char *
>   nsm_make_temp_pathname(const char *pathname)
>   {
>   	size_t size;
> -	char *path;
> +	char *path, *base;
>   	int len;
>   
> -	size = strlen(pathname) + sizeof(".new") + 2;
> +	size = strlen(pathname) + sizeof(".new") + 3;
>   	if (size > PATH_MAX)
>   		return NULL;
>   
> @@ -195,7 +195,11 @@ nsm_make_temp_pathname(const char *pathname)
>   	if (path == NULL)
>   		return NULL;
>   
> -	len = snprintf(path, size, "%s.new", pathname);
> +	base = strrchr(pathname, '/');
> +	strcpy(path, pathname);
> +
> +	len = base - pathname;
> +	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
>   	if (error_check(len, size)) {
>   		free(path);
>   		return NULL;
> 
> base-commit: 38b46cb1f28737069d7887b5ccf7001ba4a4ff59


