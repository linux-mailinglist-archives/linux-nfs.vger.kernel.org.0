Return-Path: <linux-nfs+bounces-8164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC99D4347
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75E4283DA7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56C185920;
	Wed, 20 Nov 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhyj7Qiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F513C695
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135979; cv=none; b=s+BL3jlZ7kOL6DQKF2TFTLoaB3RHRERyedzowYfyiQnVsK4EI6XpeKo2WlHaJ5H4Ph0oHNfZqHkvUubRMOwqdP59zhntgSbt5bkK64kRXTT+te3SPMqBNbHDc7mqGQWhdMcP4DDnkTFqpK9vEPyLN0ySIfnokAGJ5btIXtVx7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135979; c=relaxed/simple;
	bh=wIGPB82w7AHQ9l6CgKBj1kfQ0D9bem8I2zr+ha7jdNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7loESJ8qXrBoNgH2dSe63rSKoIOZZFORuExcmymA+SSpgPSgVcrR5i/yHx4fAu26cIfeIrLq48uPj1nG9MXtgTOZt2uLx0KAq91T2yZSZtVHievHtCpr0B7CIYAfxOyYUOWQfEaNjLj43doFzRrLq9GYRL0PhsKgsVXf2973Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhyj7Qiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732135976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IhNrrRz1Y0rIG2VcuOVcCOVkM8oPj+5uLuuvKvf5N0=;
	b=fhyj7Qiys+GyoT9eC1CrB8NDbqKH0Q2DryfocVyXXEd9bFSW8icaziO84KZBtBwVdHTyo0
	8lBgWz5bu5Oix23B5zzJGQQ+o3Ol+D1sPXYWFz5NzYeuh//8e9FBLMldaZ2Afbqklw6UC9
	607cwDPvSWbczbsrGuiFc+grs5pGDuU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-0BkXwualMCSYB-9Am86yQA-1; Wed, 20 Nov 2024 15:52:55 -0500
X-MC-Unique: 0BkXwualMCSYB-9Am86yQA-1
X-Mimecast-MFC-AGG-ID: 0BkXwualMCSYB-9Am86yQA
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso117249239f.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732135973; x=1732740773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IhNrrRz1Y0rIG2VcuOVcCOVkM8oPj+5uLuuvKvf5N0=;
        b=eQ9C4F0NkfRQPdDTb+LttIjwK4V4UuuddHnNy9whvW/aPeusyEyiOdMOVJxscNco6H
         cLPJsHsGDV2dQLAUvvryJP1QnF7wayYewuz03QuRfxisxsnXp8zLZROnsijAhveuQ/yL
         dWO+dqTKCndoVCC3EGozPRWv2lJdhxHFsAte2QL0ecxHtdNoq3q8yGbZxqL4cx1iOt4X
         lgj40FM/Z64snDYfpFv/Mb51Hn2Dm9g6GlhMZFaQw6I63PTi0RATATuiRTU1dnm7VZfo
         mBY0qiUuRZPyjUCzQymoFxjQFQxf1B1XUbln3KGaqHwwY93L/xXB47XRq0JzWIj+hicV
         7RGA==
X-Gm-Message-State: AOJu0YyS/FeM543TkX6UHJnpbSCmYsJeA0dvitPJi5tqwQGlmXwrRC11
	WuakI/mW1AHZfgRs7xKIawyA57dplbWvn2HZlffqgme1BDVhffcOmLBrkVr25x5liKSg/ZBJLgR
	0wG63LSwJjQqZI03udgc3y8L8Nkppt+eWQS0g5caRGt3qyD60yNrOh/sdJEz2kF4C5g==
X-Received: by 2002:a05:6602:2b14:b0:83a:a8d8:4fca with SMTP id ca18e2360f4ac-83ec1a04a54mr108954639f.4.1732135973593;
        Wed, 20 Nov 2024 12:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOdHQFWuvomjsn2gVcTZpBziNJfjddkHaFXj4V66ZY5XG6VZ0YIWb8RY9y5BY4LQcOOeLHcg==
X-Received: by 2002:a05:6602:2b14:b0:83a:a8d8:4fca with SMTP id ca18e2360f4ac-83ec1a04a54mr108952839f.4.1732135973310;
        Wed, 20 Nov 2024 12:52:53 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e6dfc825esm303004239f.11.2024.11.20.12.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:52:52 -0800 (PST)
Message-ID: <3586ddab-9a09-49c1-b6f8-04906d593b97@redhat.com>
Date: Wed, 20 Nov 2024 15:52:51 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 1/2] nfsdctl: fix up the help text in
 version_usage()
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20241118201902.1115861-1-smayhew@redhat.com>
 <20241118201902.1115861-2-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241118201902.1115861-2-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/24 3:19 PM, Scott Mayhew wrote:
> The help text in version_usage() has examples with a 'v' character in
> the version string, but the format string in the sscanf() call in
> version_func() doesn't contain a 'v' character.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc2)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index f7c27632..ef917ff0 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -764,9 +764,9 @@ static void version_usage(void)
>   	printf("    Display currently enabled and disabled versions:\n");
>   	printf("        version\n");
>   	printf("    Disable NFSv4.0:\n");
> -	printf("        version -v4.0\n");
> +	printf("        version -4.0\n");
>   	printf("    Enable v4.1, v4.2, disable v2, v3 and v4.0:\n");
> -	printf("        version -2 -3 -v4.0 +4.1 +v4.2\n");
> +	printf("        version -2 -3 -4.0 +4.1 +4.2\n");
>   }
>   
>   static int version_func(struct nl_sock *sock, int argc, char ** argv)


