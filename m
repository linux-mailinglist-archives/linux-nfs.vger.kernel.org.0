Return-Path: <linux-nfs+bounces-8209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6A9D6B48
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDAFB21D6E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9216DEB3;
	Sat, 23 Nov 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYc+D9Rn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35E34545
	for <linux-nfs@vger.kernel.org>; Sat, 23 Nov 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391616; cv=none; b=eBPy+pgNIgYiu5K1Vm8vLYx8ORn+SpB4AeEEV2zz28OvhdSxztosrEyRANW2pOwX9hh/2pEhJev2QaoTtdKdH2wu+Sc4KoOmptOZXpXzr8WDZ75VF9NEynI5SyTM9oz1f+rGoeiQesJamVhnw0V9ruLjPNDnXb9RVmkQG0zjiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391616; c=relaxed/simple;
	bh=AtBtUcaWrAFFfMBybDLCI9URxUlIqFTX1nPrKvq7UaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGtmhzcBtWpqMaV6DnhqWQhjMMpvUszqZt2eq09OpyusiYgYCA/oMmeaCgukVA9I/16cJHN+in/D5F8398t4om80ROGpnLCmoYhnWda5HgQGyecGQUDSZHDKl+RCK9lG5+3/6B96LGOhyji4fL3Xc42N/h4+pAm1+ZNQABHplB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYc+D9Rn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732391613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3nTrOgyK/jMcmO7eCNjZf6pnyPtWmLex07ZZ5YL3nM=;
	b=WYc+D9RniBAtsm9d23ezimua0P2Uus20/zXloxGlpJQ86XhgW7iensM2d24GcvkWRYhIvV
	QgYa0wg2F1WBGztq2c5zYghXbdOU/Ehq78kVQV9WCfkNKauRgmcWCP3TyHmV2esQkE0XOb
	t+4xLKHzvhNqek+LGTAfPI1EOkqhuAg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-gMiBISzoMGqyoHvLtlJ9hA-1; Sat, 23 Nov 2024 14:53:31 -0500
X-MC-Unique: gMiBISzoMGqyoHvLtlJ9hA-1
X-Mimecast-MFC-AGG-ID: gMiBISzoMGqyoHvLtlJ9hA
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d425b9dedeso40564326d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 23 Nov 2024 11:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391610; x=1732996410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3nTrOgyK/jMcmO7eCNjZf6pnyPtWmLex07ZZ5YL3nM=;
        b=atv6BV3xHlcewsX9gdsZ/kU6Ti3iuJxI1i8sr46vfw09kWCNMtOP6vHzSPrKy7CTs0
         UwxW4UfxaNO374jHbzRtLqb57koZoRqi5psf6LNkp7PYQnUeAjPIwMlsPzKlGbY03NKr
         lYHLj7e0w9kaj3DzCtVRwQSAmOybCWjNTPXdr+Sr6xJ1JeBUSuczpHHANZjcUcQaidaR
         0T7mImlrIFwIQ4OX593a5bTngMjso8WLWJd5xZAdyq90wZ4zuFKHxifJR/LiIviTIRU4
         BZMlZw7Dwx/wKH2dinj9cvp4q/7CU+oats9nb3iQMA4JvJH/mu8CaNFmx6Ihtsw3bQPg
         kcTA==
X-Gm-Message-State: AOJu0YwYTn9KAryiwc3n/vbpTy29VFIPKFrQAxSFIqj1FC0fWnekTply
	GsKEQj0X1on5E8dYiftLvpMlmHyJtpk5CIIzu4lKjrU32WX5ZLCumgCw6ksj2ce5lknrWVs0J3R
	Go61Ng7ygarEUs/FWChJATjbhIEvxanhS6/BpzicBUuiIPmffLRbWs564lURN9ADdWQ==
X-Gm-Gg: ASbGncv7jx2KnoONCCzpn0Y0nenNMyDOJplKbVMzNyfGg1ixkUzs5IrrfUqP2YFc8mw
	T/bW7hgD8My7WK8wltqEDWiac0rE49vpBs4tgmGA8L1uUVu9SQLGailzhJ6EPTBbttLvozEGN+a
	+sR12FDgwIngspEKK6l4tsnIBoEyCpaU2rNhrlGlaztjT0JE+KWBLjb8Yig/w1V1nI4NZQAsxg/
	QNbcAF3CoQzwJQURM9L/JZYh+oKwAAcNt59lTEKp0ltG7gkbA==
X-Received: by 2002:a05:6214:c6b:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d45112fc0dmr114023956d6.30.1732391609859;
        Sat, 23 Nov 2024 11:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9qOsLkjCNIyVKm6SBBJX8YkAP/quZLE6zIWvB8EPn5k963cj5FhhYolXLvcFmHyaUVGRJSA==
X-Received: by 2002:a05:6214:c6b:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d45112fc0dmr114023806d6.30.1732391609623;
        Sat, 23 Nov 2024 11:53:29 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a85d9fsm24821346d6.18.2024.11.23.11.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 11:53:28 -0800 (PST)
Message-ID: <3ecdde1f-b92a-4675-b0f9-3ed120827461@redhat.com>
Date: Sat, 23 Nov 2024 14:53:26 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsd: dump default number of threads to 16
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20241118202011.1115968-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241118202011.1115968-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/24 3:20 PM, Scott Mayhew wrote:
> nfsdctl defaults to 16 threads.  Since the nfs-server.service file first
> tries nfsdctl and then falls back to rpc.nfsd, it would probably be wise
> to make the default in rpc.nfsd and nfs.conf 16, for the sake of
> consistency and to avoid surprises.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc3)

steved.
> ---
>   nfs.conf          | 2 +-
>   utils/nfsd/nfsd.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 23b5f7d4..087d7372 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -66,7 +66,7 @@
>   #
>   [nfsd]
>   # debug=0
> -# threads=8
> +# threads=16
>   # host=
>   # port=0
>   # grace-time=90
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index 249df00b..f787583e 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -32,7 +32,7 @@
>   #include "xcommon.h"
>   
>   #ifndef NFSD_NPROC
> -#define NFSD_NPROC 8
> +#define NFSD_NPROC 16
>   #endif
>   
>   static void	usage(const char *);


