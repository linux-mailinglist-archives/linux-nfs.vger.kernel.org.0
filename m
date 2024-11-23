Return-Path: <linux-nfs+bounces-8208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E619D6B47
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 20:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94700161B87
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A016DEB3;
	Sat, 23 Nov 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fcn3x+aE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290C34545
	for <linux-nfs@vger.kernel.org>; Sat, 23 Nov 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391586; cv=none; b=jY9ClwtF5pxt0FvGt3irWDCvopfGyEZfkcRh/Ps0+j1O7svfwxfWpw7zckAzALJjOGSZLq3uJxMlAG9oF3RRIYN9+1pNFJsa9k8TnduMO0nRJ0LzZL5LvpCngsQxtLT8gMfs9C5ZkoKFNeOO74oh3iMa11akJoIiM7ss9Xixl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391586; c=relaxed/simple;
	bh=WbTxGjJND3cWuKP5n8RURuLmA9vHTmakoxrcdiwBN38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfDqmWtz6triFhPAZy8E/elhhmt+dUt8Tgu+1vYP8pZkM1gR5sMqkIZPLlTIh9U76Np/PsragPIKITJ3mD51fmAQZaLPf6/+yJwFa8ZL/d4lJ3teRxmGWmTv0hKeAcnTi7VP2vsWRJvjrr57RVkeDSUy+xNrdpl7KThuecYp/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fcn3x+aE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732391582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6Q8GTaMdvLk6Te1Ux6VJl+OWWVKIP0SpsWPG2zTh68=;
	b=Fcn3x+aEbX7zgKVlTYCIFd3eyxrDEvXTd+yuCnXA5iWPkLlyXiIeCW4QiNXxcKsiKm2NTQ
	9w+HjTBEPbvjwufGQB5PRga00YzpCJlm50epu/maCvUEy6e7eMinZU++WwlZZYo4gA9lUH
	L7CkQy5QA0/6/98uxsiUDAoWRu5Seds=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-0kdW_U7sOwG8i__jT9GE8A-1; Sat, 23 Nov 2024 14:53:00 -0500
X-MC-Unique: 0kdW_U7sOwG8i__jT9GE8A-1
X-Mimecast-MFC-AGG-ID: 0kdW_U7sOwG8i__jT9GE8A
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d40dcb7c98so43997516d6.1
        for <linux-nfs@vger.kernel.org>; Sat, 23 Nov 2024 11:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391579; x=1732996379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6Q8GTaMdvLk6Te1Ux6VJl+OWWVKIP0SpsWPG2zTh68=;
        b=tAfUH79TI0gk4MFTE4BipjtTTcODI8VmWqX/n07Yez49EZaU03UFmq/VSiKIKb/+3l
         xP2znRs9lgJnS5bfzvWbX+ntBTesCCVzaBbTks8Z1SaZzbv0oSp/V9d0PG/dzfKP9GmB
         ij/VuvPH1p08z+RbhiHnMpy4uZ2arZ6pKc6RFU+mRiTXtvYBbVnHBVCllh2628JxcGrC
         cgH8cMrFhRCc+CvISkcLk5x2cUCxs61eRUtAshKAmDiJthN9v8OdKAKZ86Z6MVJJE9hm
         PLPARw3wKpBRQWUbYxis4NIex6SAdUhB37VgPwXQ8gOieeGyqsu4X1ZNzMGYIm6PdT9s
         TPcw==
X-Gm-Message-State: AOJu0YwIIBnwDm64Fznb9shd0awWjg8ryw54ULgYFeZDhsOVoRB2j1Ng
	6wVQMFTvbSdFbSLET5P4fCwh1bCl07omdsk4asz5HZDnB0DtMuQy+MMrdEvPw6sx8W6EI/L8BNB
	2k4xxmro/dBk+s7oAsL6tPF9TyiTO9/qGyYljalLgYoaUTeSQMYb/PyRNELCP2LJ2Vw==
X-Gm-Gg: ASbGncvMFl5KaAWGQ86T3Qzn0nfal0LJ7m50ZzB1GSyxtoe+FDtD8WmJG4t0rp5ChiZ
	lfMe+V0Ql9vezFupGYyxCNOd2jFcsM7SUQG4GaEyEmYgj+3sPdN69Jc9zUQCbqCcS6tehiD1u9i
	ezp8in98mXZsHn7M4/m23oWVaK7UkS4jk13V2S1Mp9mreB2yvcZbnXKyxkKt52DRKd/oN2avPbM
	esxihUhPFRmYrhr4n/iqZvIkd1mm4dnCbTEHzRVnJeaHFNL2A==
X-Received: by 2002:a05:6214:2583:b0:6d3:f6bd:ca04 with SMTP id 6a1803df08f44-6d4514b3437mr115253326d6.40.1732391579687;
        Sat, 23 Nov 2024 11:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT/SMKgl9yYYKNhBYyHjMOCMBow5rQ21RUXXA9Ft90Fk/FzY8KI4xumMswG56duGjN+lPl2A==
X-Received: by 2002:a05:6214:2583:b0:6d3:f6bd:ca04 with SMTP id 6a1803df08f44-6d4514b3437mr115253186d6.40.1732391579379;
        Sat, 23 Nov 2024 11:52:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513fa4e95sm203794085a.33.2024.11.23.11.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 11:52:58 -0800 (PST)
Message-ID: <603c6c03-1e98-48e2-b149-73720661f11d@redhat.com>
Date: Sat, 23 Nov 2024 14:52:56 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autoconf: don't build nfsdcltrack by default
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/23 10:18 AM, Jeff Layton wrote:
> Now that we've started the process to remove legacy v4 client tracking
> methods, let's stop building nfsdcltrack by default.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   configure.ac | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Committed... (tag: nfs-utils-2-8-2-rc3)

steved.
> 
> diff --git a/configure.ac b/configure.ac
> index 93a1202807ea..62c833cc2409 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -248,9 +248,9 @@ AC_ARG_ENABLE(nfsrahead,
>   	fi
>   
>   AC_ARG_ENABLE(nfsdcltrack,
> -	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--enable-nfsdcltrack],[enable NFSv4 clientid tracking programs @<:@default=no@:>@])],
>   	enable_nfsdcltrack=$enableval,
> -	enable_nfsdcltrack="yes")
> +	enable_nfsdcltrack="no")
>   
>   AC_ARG_ENABLE(nfsv4server,
>   	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],
> 
> ---
> base-commit: cc5cccbb9f24a2324f50a5cb4c29d83fdf6b1f90
> change-id: 20231127-master-5ef1c15da9c4
> 
> Best regards,


