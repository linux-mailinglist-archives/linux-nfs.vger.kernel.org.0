Return-Path: <linux-nfs+bounces-11574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5AAAE297
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4259C0172
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B83288C28;
	Wed,  7 May 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWE9g4sL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC41E49F
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626950; cv=none; b=TDmuRVWFloZH+4yvFl25mS7sJWIOm4P/vLME6VWe08L7X7XluRC8gT388z0aOUIKbcoj/Gxx0Q0gxz4xsWTbsGRpThLRo9rEo17P3r1bNFv3Rmkk0YNmF+cAd/WWXa6SPii+7jjmx8ykaDk3hd9sbsfVCVwN6wc1GZO9Edp73e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626950; c=relaxed/simple;
	bh=qo+uQHEAXccBOCDsrqPMWE9Ota57XfpdsF7yd4kmAD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0bbPa8+YJxKRKAktwhrgbQhqSRc0xPyymN1fDYBr41CyOO866hZHUjLZ+2hyTLjmAFnrJHCr2Gx+kGKnve0OjhD7wNXtVAnCFBqzhvc1bS9B0Kx4UfEV/0pzwgKnp2eRWO61Qf3Nd/nYrSeD46Y/NuFZHGcY2M43wPPeNe2iPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWE9g4sL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746626948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hod9ClR/0iqFVHkXoCmmcGPfp0kUeV34uftDySekgG4=;
	b=QWE9g4sLBQ/os54Wl32aRUQSmT8dI4YtrOWy4ETr2jIAkhJfSG6Kystc9J9YZ5o4/iF+P4
	EpnXx9U/RjlKm60VToe9FESNodI6YH2q3SHZ/ozHGOP3BoV5lCr98y1XphafyNdFm++sZG
	nqspoX3GV+ZV567ouL5WRwmijjMRwzg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-fIdHME6WPvyhXALrK41XpA-1; Wed, 07 May 2025 10:09:07 -0400
X-MC-Unique: fIdHME6WPvyhXALrK41XpA-1
X-Mimecast-MFC-AGG-ID: fIdHME6WPvyhXALrK41XpA_1746626946
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f4367446so77977936d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626946; x=1747231746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hod9ClR/0iqFVHkXoCmmcGPfp0kUeV34uftDySekgG4=;
        b=Yu6ubQsYJNf6wEFO8OkDbSD+zgNZusyZg5+YgRhsIRBwWhRF8Bh8fkrBR5sYoK5yZg
         Uw5jTN64zXRGq6QriivT9vJbXQMWz4g5DSOkG7bH9OVino4kPwZwNZ3NNrOrKlTZMYeJ
         8oT6FOS+8IJ8Z3MP5zYl3HX/ZJQISJ8aAjAYXvesZwFKveMunJQG+yXvkB+i5tkGLup1
         iR9EErSAV461nCI2Xgirs6vT6bOgJMq16oTDhX0sE7LZfht3pVJiuiYNfgN2JDFgFecq
         v4xHzqq4cFIXTe2okk+U34FOGXxQTUoR2hWySOINGPvzP3t8GCofkGRv6o8FhNL1tSln
         GrTg==
X-Forwarded-Encrypted: i=1; AJvYcCXKwkd3jRewwRzNQbmrBwLqq4GkaZeYoF7xtXY7TJbZvXMPPafAU2swKmBb2F0cw1bLbX42eFDd2ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXglImsvwoNnNjBICLpVzwriwbmUfz1gCt8rIfDZZrOPqd54dY
	U+KhEohSnNTFeeWdA/GdG03NKyVN0ha2MmCxK4SQd/aAVAz64JkP7uM6YaRN3+1fnuSZG1I7kP8
	8yqlKEBdjpp0u2HNIGZKMHwpYgNvFet+M3xjhtMTeNSLxe9/KO8UXnaUnmg==
X-Gm-Gg: ASbGncu2lpzhxeJLcPR+w8zGaVrfaNnwQ3GmMc8YXcUBLDcbKCA9lgbmrgcabksT3Rd
	/rpPD+MYLPL9V0qNyuypTVv0xnuXJEV6mlDdZnReDE5skt8CpCdyk2+zcwDOeXN9TiGbaNsQs2o
	BTjCocODt+2Fn8HWOzLKo3HGEsnG+TK9w1yFTBcyitBnfFJSVw3cNdat5unSXKzga4VTqtK9Ora
	pPzhcYU3+nvkKx0+mcBTpRGlD8jHNLDu2ptLiX3pPq/0oRG4txk3Aq+xpe4QYZWZlZbjvE3bnva
	F9xM+9LjQA==
X-Received: by 2002:a05:6214:19ed:b0:6e6:5bd5:f3c3 with SMTP id 6a1803df08f44-6f542b00b7cmr47234986d6.44.1746626944561;
        Wed, 07 May 2025 07:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtTee3HiTQZvPnaesuAGAw1QyR+9ewiZ04ynMCZ7q9uS3CSuZgDwnAplQo3L8chViW245Tlg==
X-Received: by 2002:a05:6214:19ed:b0:6e6:5bd5:f3c3 with SMTP id 6a1803df08f44-6f542b00b7cmr47232346d6.44.1746626941777;
        Wed, 07 May 2025 07:09:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f542781393sm14123066d6.88.2025.05.07.07.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:09:01 -0700 (PDT)
Message-ID: <3d18e4ce-1c79-43f2-8f39-a118126b8f61@redhat.com>
Date: Wed, 7 May 2025 10:08:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: fix lockd config during autostart
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <20250501181928.125198-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250501181928.125198-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/1/25 2:19 PM, Scott Mayhew wrote:
> Be sure to actually send the lockd config values over the netlink
> interface.
> 
> While we're at it, get rid of the unused "ret" variable.
> 
> Fixes: f61c2ff8 ("nfsdctl: add necessary bits to configure lockd")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-4-rc1)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 733756a9..ae435932 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -1417,7 +1417,6 @@ static int lockd_configure(struct nl_sock *sock, int grace)
>   {
>   	char *tcp_svc, *udp_svc;
>   	int tcpport = 0, udpport = 0;
> -	int ret;
>   
>   	tcp_svc = conf_get_str("lockd", "port");
>   	if (tcp_svc) {
> @@ -1432,6 +1431,8 @@ static int lockd_configure(struct nl_sock *sock, int grace)
>   		if (udpport < 0)
>   			return 1;
>   	}
> +
> +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, udpport);
>   }
>   
>   static int


