Return-Path: <linux-nfs+bounces-3234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0368C258C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545BBB23D99
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203012C461;
	Fri, 10 May 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5M6RhTo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB612BF21
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347134; cv=none; b=ZByvRZ6e1ZRE2vrIpiKa4FH1dVJlLQ06GfY3RslGEp8NDAPaF8Qj9DOWaWrTpUBgtsvyx5SiTlr9jbUn/+ENQa4rHU5nH2/1ZYjk9Sq/hXJNYFcw3OeXty98Ps20FB6+YSnXMA4qiaqZbS4rk+JwOhy7iyv5/Aw505G3vQrnjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347134; c=relaxed/simple;
	bh=ts5uCJziYe7b/uV8ZRAW4LdvW3N0jdGR5KHk7uhkwLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7wfCfoGMebnHvdqTc6YQ6tAM6uYTfnKhdkjBdcSXXPb2ZFMHtgqEJs+/kZMspTcN8x2+1GNjUfm0Q9BMaw2RyL/W2BxgONJqM9QpjzRBAYsZpNEvhbYKWiv1md5d+zVrpjCuE69OCaccOOJyRHnMTwC2SoKlgj3Lse9dWLcoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5M6RhTo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715347131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m29G2q68q9ZiGugXdxUBikmSBGRhnENZ3CfoC37g/Q=;
	b=N5M6RhToCaFidLocRU6kRwhpyAjT5IpBxVxuGCE2+o73bj+Bx2oYrctry7QEgek4NuU8cw
	WaRRGwzOqpvWUglQLFoTbN+430YWX9jo+CZohXtOL3+ytyCQMYhjFG5XJgh5nQ8W+5jG2i
	B1NY4A+GNroVlFze+d8jSU7Oi5F4DFA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-2zA5SmRuMVq4KAyPZE_sKg-1; Fri, 10 May 2024 09:18:45 -0400
X-MC-Unique: 2zA5SmRuMVq4KAyPZE_sKg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ab48a13643so588915a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 06:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715347124; x=1715951924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2m29G2q68q9ZiGugXdxUBikmSBGRhnENZ3CfoC37g/Q=;
        b=lB30wQEmfbZX+LRgeyfdaW3tvZnvDxHhZ7cAE60f2kB+4190HHx3cMVdP031ODxz1w
         z3XyuxMTulUQ+SRvaP5wMYLC0eKMig0YSrT19wzjAWhitKS/jqtYjcxzMreIGsFO0V+m
         T53IVZ7kaiVyJr5Cb0hWJ/r0+jPlrcdZ0hEpkUZtQpW3JUOwFfHsI8a3ESf5VDhUUPwG
         5FcIja71OUA5CtcPhbRRD2WsiygoRVN+YOAHQvpwEbsdAlcwwSoPZM+cUjs/te770own
         pSD4TsQOQO9RzJS5oVxUJ54CMPQmTIkwk76DemcZTvzlxzZOVKsjHMX6FrbhTx7vVqab
         ELag==
X-Gm-Message-State: AOJu0YwkR8Pe5O/jP50QDfAozUYsvn6M+3OSOK0ed5r3aK0ubjDu4wk+
	Td4LycG4q5I4TLCHFzhUCKX/0MFQxRq2d2u+RucLiIXEA2I9vON+sJbtGiY0/vhGqnnZXnozSBC
	ZtcFhjI1OjHAXnYbpeIChWQqja2Pt8hOfXoUKg0367lB4MKXGuiOW5vP01g==
X-Received: by 2002:a17:902:f68b:b0:1e7:b7da:842 with SMTP id d9443c01a7336-1ef43d2a424mr29423775ad.2.1715347124479;
        Fri, 10 May 2024 06:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEih6mEuI43Ibjgo/8xT8lX3qsWqtZyrS3RX6zUYicVxbLkQlUWuDNsfuvGKBk8gdStmG2a7w==
X-Received: by 2002:a17:902:f68b:b0:1e7:b7da:842 with SMTP id d9443c01a7336-1ef43d2a424mr29423475ad.2.1715347124066;
        Fri, 10 May 2024 06:18:44 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad5fa2sm31708205ad.66.2024.05.10.06.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:18:43 -0700 (PDT)
Message-ID: <915b48f5-4c78-4ba8-bc99-58b9abf48027@redhat.com>
Date: Fri, 10 May 2024 09:18:41 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] junction: export-cache: cast to a type with a known size
 to ensure sprintf works
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Vladimir Petko <vladimir.petko@canonical.com>
References: <20240502135320.3445429-1-carnil@debian.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240502135320.3445429-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/2/24 9:53 AM, Salvatore Bonaccorso wrote:
> As reported in Debian, with the 64bit time_t transition for the armel
> and armhf architecture, it was found that nfs-utils fails to compile
> with:
> 
> 	libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../support/include -I/usr/include/tirpc -I/usr/include/libxml2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -pipe -Wall -Wextra -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Werror=format=2 -Werror=undef -Werror=missing-include-dirs -Werror=strict-aliasing=2 -Werror=init-self -Werror=implicit-function-declaration -Werror=return-type -Werror=switch -Werror=overflow -Werror=parentheses -Werror=aggregate-return -Werror=unused-result -fno-strict-aliasing -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -c xml.c  -fPIC -DPIC -o .libs/xml.o
> 	export-cache.c: In function ‘junction_flush_exports_cache’:
> 	export-cache.c:110:51: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
> 	  110 |         snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
> 	      |                                                 ~~^     ~~~
> 	      |                                                   |     |
> 	      |                                                   |     time_t {aka long long int}
> 	      |                                                   long int
> 	      |                                                 %lld
> 
> time_t is not guaranteed to be 64-bit, so it must be coerced into the expected
> type for printf. Cast it to long long.
> 
> Reported-by: Vladimir Petko <vladimir.petko@canonical.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218540
> Link: https://bugs.debian.org/1067829
> Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2055349
> Fixes: 494d22396d3d ("Add LDAP-free version of libjunction to nfs-utils")
> Suggested-by: Vladimir Petko <vladimir.petko@canonical.com>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed...

steved.
> ---
>   support/junction/export-cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/junction/export-cache.c b/support/junction/export-cache.c
> index 4e578c9b37b1..00187c019d60 100644
> --- a/support/junction/export-cache.c
> +++ b/support/junction/export-cache.c
> @@ -107,7 +107,7 @@ junction_flush_exports_cache(void)
>   		xlog(D_GENERAL, "%s: time(3) failed", __func__);
>   		return FEDFS_ERR_SVRFAULT;
>   	}
> -	snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
> +	snprintf(flushtime, sizeof(flushtime), "%lld\n", (long long)now);
>   
>   	for (i = 0; junction_proc_files[i] != NULL; i++) {
>   		retval = junction_write_time(junction_proc_files[i], flushtime);


