Return-Path: <linux-nfs+bounces-7865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E47519C437D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C11F22395
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD61A3BD8;
	Mon, 11 Nov 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isXG2K+K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9E25777
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345885; cv=none; b=rzQdZyPAwSzIBk6wdeYbRv5TV0miaUStJBdl5ihOQb76iSslxt6w4vuUWoVvh8gdBhQHpcemsbkCQLfzCkMJ/g70HfM4pAzxPuDV25BwH0uPdYvY6Zpurh69daoiNzjO1CtZQLm4muzcIeBDhnEZRxkKUZVax78XTxsTr+py/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345885; c=relaxed/simple;
	bh=5uJUepbanUD9indfEK8EjnJdr7dJ/eVVsZ8Rzg+eqvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J8JP4YwRy7EHJivZhLFafZrTBx04/msTyakpRAKE5RUzEdu89Xv5f3zT2rL1SVwVSAZD6vWtvBHvexSHXiKEzn4WPukTH9dl0Ou3WVlLY5h2qd2e3kdX82YoXKKGlEn07GPGEmwGS0S/snCGjjAT7kjiUk46+XjVDKDiJzekMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isXG2K+K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731345882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M48p7GvR95/5p9PCbTmToRr8NhFxwEd/IRf9NwhKxPo=;
	b=isXG2K+KJjVxEloaKn+ZGZhX2qAJXD3UxqHvtHM0bcT/5uvoKnw4peQD+CRPUVmNjgt6gm
	mvmvawAZTc/EeCogMe7XNXdjnvpUxntpHFzNvv7ev/ZjuFR8McYHabd9+TMRx54BvBJbuy
	1GFFEa+dfuh7J0OxbrAeU88Q7Ni6QAc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ncpXL2gbMgadVnChPGSFjg-1; Mon, 11 Nov 2024 12:24:41 -0500
X-MC-Unique: ncpXL2gbMgadVnChPGSFjg-1
X-Mimecast-MFC-AGG-ID: ncpXL2gbMgadVnChPGSFjg
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso576008939f.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 09:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345881; x=1731950681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M48p7GvR95/5p9PCbTmToRr8NhFxwEd/IRf9NwhKxPo=;
        b=hmLYMwkzs4/FnAKaxWTR3KPINi9rR6LtAiqxtOl1OwvhI6cDQVFzntUfVZ9U5wiR29
         C5jQApxcbBsEZZLemGcO1HIg9cZ5B5TkQ01d5impeAO2JRf9OlqlcpF7M4DMqpNzINC9
         HeAS/mhlMm1HYeiTqxxGh1kGlKkIUpN5y+k6ZCW1w1C1DYqw2gvT24fPJaUxgPTKYVUb
         2stuNg09ux/pSL1lbSePXzZ0Pzy8rYrK/zQZI7OTW+LT17YsA0/0i+OqVlRC8khDexSQ
         mHrw8OJ+wNo2x3x3VJataAD1qwThhHvoTmaiKbk6MZ7kRIk09Ob6ifNPGbHhxLhFeeit
         RmjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfusEzH3fGMD8kNxdefVMvXDUDtjDLF5IS58NVqvMtXq10iIwni0JMMjpT8ZzL07VJuYIhqgNZwN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKJHeLuOBQduUuq0Ax2KgdDnV2XAd5qnypivTzS3454IlSpon
	SQ4PiaPG+byCIMtgoZdvVd1fW0+4YzMh4Vaup5IIMoRizkIXY06RbuUcm2AZS59APCjf8YiCqS7
	BbrmVd3VoQA1ihSnjv3p9gqde63FtwpS2jlDpARpjbRhXKXF4p7q6k484yw==
X-Received: by 2002:a05:6602:6014:b0:82a:7181:200f with SMTP id ca18e2360f4ac-83e032e3fd9mr1324031439f.9.1731345880725;
        Mon, 11 Nov 2024 09:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTZawuw0z14cnoTrAN8LXfFVVd+6KBnzsbIICJCAq9Y9sBUj7w/9hJzbuE75oI5PqcGesPRA==
X-Received: by 2002:a05:6602:6014:b0:82a:7181:200f with SMTP id ca18e2360f4ac-83e032e3fd9mr1324028839f.9.1731345880333;
        Mon, 11 Nov 2024 09:24:40 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f0a7esm1458826173.129.2024.11.11.09.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:24:39 -0800 (PST)
Message-ID: <3130fa49-cfdb-4f96-8779-7b10a4e61a8c@redhat.com>
Date: Mon, 11 Nov 2024 11:24:38 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] reexport.h: Include unistd.h to compile with
 musl
To: liezhi.yang@windriver.com, linux-nfs@vger.kernel.org
References: <20231214101206.70608-1-liezhi.yang@windriver.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231214101206.70608-1-liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 4:12 AM, liezhi.yang@windriver.com wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> Fixed error when compile with musl
> reexport.c: In function 'reexpdb_init':
> reexport.c:62:17: error: implicit declaration of function 'sleep' [-Werror=implicit-function-declaration]
>     62 |                 sleep(1);
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Committed... (tag: nfs-utils-2-8-2-rc1)

steved.

> ---
>   support/reexport/reexport.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
> index 85fd59c1..02f86844 100644
> --- a/support/reexport/reexport.h
> +++ b/support/reexport/reexport.h
> @@ -1,6 +1,8 @@
>   #ifndef REEXPORT_H
>   #define REEXPORT_H
>   
> +#include <unistd.h>
> +
>   #include "nfslib.h"
>   
>   enum {


