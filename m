Return-Path: <linux-nfs+bounces-7869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC09C43CF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4651F2237C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE841A76A5;
	Mon, 11 Nov 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW50aO/D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D701AA1D3
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346396; cv=none; b=laSgnzQ5Em593SspLa/woyJl2Fb9w8FWlt/N9cXoR6UAc1cJ8cg9NvzdMSUiRPBGF3TqGgH3TzAkYSYGslHteABYeaIln2FpE/X/rYbGLCPAxaXUqd51hl9yFJ6Ttt4Z3RLFZ6QLqjomwPtGYellYI6flsGAUdTeF8cW4mT39yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346396; c=relaxed/simple;
	bh=mkEW3HoIRrkzzWJQi7aVwYK4TRj6t9R59KpYv7qdiVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hKpoLVFqM/so8wbDvnOg+apS8PRPVScque/DCwTW2ONdp+5zs4Krva+MreAE+Y2+3TOfX6clHCtHBRxNLvipXX4vXNlUDhCDEZoLQ0le/URa//O24nMWxqsYimFwjZnPgDu7BkHUjh6N3ys3ZZFCXhtb2Q/WGzIgK2/LtTogQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW50aO/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731346393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y7qrzp07t5c4s/kK+MQiqwXdrjC/rYPyr79kYj/CNg=;
	b=JW50aO/DxhgrMCJ41PJMdJVqr83LxulyK8phU6I9mrDiwZpeDh4KCbBFrA0m8XgZPe0gC7
	gVC7y0R9ckukUF4YnTDRb1F5v4YYmHLM/jmWpGq+BaHLK7lzD1H1kVkoDfc8HEXAGr8JRS
	YfoYnBWI+tlI30/w7/YJwBMWLPT4yDo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-7lX5tc-NN0m0zAh8MEiRiw-1; Mon, 11 Nov 2024 12:33:12 -0500
X-MC-Unique: 7lX5tc-NN0m0zAh8MEiRiw-1
X-Mimecast-MFC-AGG-ID: 7lX5tc-NN0m0zAh8MEiRiw
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b7974696so58363085ab.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 09:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346391; x=1731951191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y7qrzp07t5c4s/kK+MQiqwXdrjC/rYPyr79kYj/CNg=;
        b=JOf9zVERwt59eLkz6WIMr/yuQ8N3ABR+wNyooXzMXyH4DTXgpRAfljFv+OP2LBrXE0
         vEXkuWoKQXA/iZUJtLRNTTpCVDixy1ZPoiovT48NROS7zZixOuUy3MtYw8cpeona0ENv
         k8dH4q5yq/y3z9TYHqh0Y7upfxTTqxsI2fD4lKFtcLMAQ2BLT/Kuml4E8yhoPLew7meW
         +05UXKBVZsiaYZ/SOIotaC3JkEvXh/LycBKXzmopEYsWJXMzm/mL8r3rnQuoA9KQ8yfT
         f8lTjR3e75diP+ggVlk6x9MDgxakVq3DEJKGtzxLvnZcd/DpNuheyNQAbNiRoKq5buAx
         LVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIZwrGAHOFOpw3OrsvNEL5I86FH5gJeSUfTlFeDl9k0xBjPjw29RD/zzbKoD8VMQZCnh7Rn3k3WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFQY2bkaHlvrdkLyKiHeED+DhLXutshyvhFgAYS2hepkPBWHa
	d9YcONiagpF9DVTMM60huVgJ1/tR2e75dKLN8b+CnJpc8toGcPDshcImvWZ7V0g5VA5FTIL8vQ9
	ySUt2FyX872hPc+3FpUoc0L+Ar+99gTwCzZn4dVrLg8X5e5G1X2LF7zJsQT2aK/NgPQ==
X-Received: by 2002:a92:c244:0:b0:3a6:ab32:7417 with SMTP id e9e14a558f8ab-3a6f1994673mr115793095ab.1.1731346390837;
        Mon, 11 Nov 2024 09:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5wZ5ekRrLYTdHtxrAg7IvqDs+q+qPfvwFzhvwH4x9zc/uHr6Gqh4tjttkYFIAB+6vY5F+8g==
X-Received: by 2002:a92:c244:0:b0:3a6:ab32:7417 with SMTP id e9e14a558f8ab-3a6f1994673mr115792865ab.1.1731346390423;
        Mon, 11 Nov 2024 09:33:10 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f989b2c7sm15257895ab.79.2024.11.11.09.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:33:09 -0800 (PST)
Message-ID: <b7981e49-206e-4eea-ad06-f230c86f897a@redhat.com>
Date: Mon, 11 Nov 2024 11:33:07 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [nfs/nfs-utils/libtirpc] getnetconfig.c: free linep to
 avoid memory leakage
To: Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20230201105725.3500063-1-yieli@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20230201105725.3500063-1-yieli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/1/23 4:57 AM, Zhi Li wrote:
> Signed-off-by: Zhi Li<yieli@redhat.com>
Committed... (tag: libtirpc-1-3-7-rc1)

steved.

> ---
>   src/getnetconfig.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/src/getnetconfig.c b/src/getnetconfig.c
> index 9acd8c7..afbf8b5 100644
> --- a/src/getnetconfig.c
> +++ b/src/getnetconfig.c
> @@ -507,9 +507,7 @@ getnetconfigent(netid)
>   	    break;
>   	}
>       } while (stringp != NULL);
> -    if (ncp == NULL) {
> -	free(linep);
> -    }
> +    free(linep);
>       fclose(file);
>       return(ncp);
>   }
> -- 2.39.0
> 


