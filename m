Return-Path: <linux-nfs+bounces-3233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF38C2582
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B933283DC0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A18128366;
	Fri, 10 May 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOjE3V0w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24166481C0
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347099; cv=none; b=BLepCioB4ZqV9lOPp19lZ4AAhYr8JudecLjqagaP6In3peR7biFMCyQY9b7mCoNWaYN5Hw4wNOsGZD/xqR8xWU1qbcrPJCKEQihdnqvGfNsT+lXPXR3bFal5WdP0Tu4OcxEOF8rgHT08DcuQQI6RiZazRxdQDCfr7+ag74C7oDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347099; c=relaxed/simple;
	bh=IHn9OrUp6uo+vxeElczlHdFjA4OzCiyjkASWV+VvJmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5U488TbH3U5yB4E6RH/P5AZ+KiHCIXL1uZgLb0GSxNXpH2sat+BY+oWfDJ2D5zQgJ7HsWsY90DtEL/DnJCzzvF2831IEmd1Uqn0bfzbdBXyRe6aEVilfDJyUZ99GLBQjvcqBxiw4IfK305lfhmRTWUB6Z+lwn4uGlmBrtdq+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOjE3V0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715347097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V55+B+ekqMo0nZJst1vFH7FauIuhxvjGfrHVBhR8AKA=;
	b=MOjE3V0wQvzjSH3xTJnHgthlosujE5iGYUcyN6o2PNF+m7AIMM80EoIGNRQhodQi/sGYs1
	tXjpu++eBrxe/3+3vnUdaoVTcaz7Rcr/0c+dEOTyKavin5y4XS5sZWVJBQMSY1Qb5Qs9Z/
	cPZYK8dfoKWoThUSmgdAs0v0JJFLic0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319--iEY3WQLMVaAxkXRj798OA-1; Fri, 10 May 2024 09:18:07 -0400
X-MC-Unique: -iEY3WQLMVaAxkXRj798OA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b52fdaf766so714206a91.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 06:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715347085; x=1715951885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V55+B+ekqMo0nZJst1vFH7FauIuhxvjGfrHVBhR8AKA=;
        b=iod4vN5E7nweavOIS4x9a0OYILabBywvejSKmh5NtqJc95EVuNr4BstfHHxSrXNYaL
         4a7m+LvkhaPIh28ZSrKZ7Ne9HnxTgbs8mlkemtklDfJ/jmm8mVZ2Fwd2BFgM1RMy2K86
         XAlLHwT6xkMMuzuc7tRmAWy38hf0VN/KPS4NO2IRwRnXGwHy2gxvqQgDlPzK2RKUSuuJ
         w8HUCy+rbBOUJm0f1S4FwAEVOpAX0WDtQDnuoWmvwLrg5qRaMsNRUQOm4eOUNJGQWYbn
         Cz+0azfnTTRbp9i52OgaMvW8L15ukmwkRdpWlAVMSWbIAEBcDJKL+Rvst4FZDQkODEmu
         +juQ==
X-Gm-Message-State: AOJu0Yyocl2+8bcfMX/uj2pg+2fBMiSKcnXreutu5jgkJLPY+H/Rb6U6
	B7hRuXjsgKeh0aNOC92Ip8Iopk1VncdppTROHOU5XrkwpQnfiegJe7UbEoeofszq92QkEdJc0r2
	KeEauUVLGrlCJubF/4P2b1N5SBxKoD6S3nGYVaImFWwGoD5vQqRjj6OfBSbs8u4Oc7Q==
X-Received: by 2002:a17:90a:4497:b0:2af:d64:4887 with SMTP id 98e67ed59e1d1-2b6cd1eef1dmr2361108a91.4.1715347084800;
        Fri, 10 May 2024 06:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpGz470B2/bYfC6J35zsBXKBo/jQ/Hr2BkJKuetZNlVs1J5kKfLQoUqu5MOjEl9np7iDGkpQ==
X-Received: by 2002:a17:90a:4497:b0:2af:d64:4887 with SMTP id 98e67ed59e1d1-2b6cd1eef1dmr2361081a91.4.1715347084301;
        Fri, 10 May 2024 06:18:04 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6aadsm5033691a91.50.2024.05.10.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:18:03 -0700 (PDT)
Message-ID: <39ac3688-e99c-4b80-a94c-c80f9e2dc31b@redhat.com>
Date: Fri, 10 May 2024 09:18:01 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
To: trondmy@gmail.com
Cc: linux-nfs@vger.kernel.org
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/24 1:02 PM, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
> we currently limit the number of backlogged connections to 64. Since
> that value was chosen in 2006, the scale at which data centres operate
> has changed significantly. Given a modern server with many thousands of
> clients, a limit of 64 connections can create bottlenecks, particularly
> at at boot time.
> Let's use the POSIX-sanctioned maximum value of SOMAXCONN.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Committed... Sorry it took so long... The patch was not
on my radar... Feel free to ping when things linger this long.

steved.

> ---
> v2: Use SOMAXCONN instead of a value of -1.
> 
>   utils/nfsd/nfssvc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> index 46452d972407..9650cecee986 100644
> --- a/utils/nfsd/nfssvc.c
> +++ b/utils/nfsd/nfssvc.c
> @@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const char *node, const char *port)
>   			rc = errno;
>   			goto error;
>   		}
> -		if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, 64)) {
> +		if (addr->ai_protocol == IPPROTO_TCP &&
> +		    listen(sockfd, SOMAXCONN)) {
>   			xlog(L_ERROR, "unable to create listening socket: "
>   				"errno %d (%m)", errno);
>   			rc = errno;


