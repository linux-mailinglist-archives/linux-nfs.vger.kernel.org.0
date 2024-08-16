Return-Path: <linux-nfs+bounces-5414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865A954B63
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976D9B23E32
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286819D8BA;
	Fri, 16 Aug 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Key158rz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE819644B
	for <linux-nfs@vger.kernel.org>; Fri, 16 Aug 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816183; cv=none; b=Xts3gituaXgB+Pg7Fm2obZVfnhoCPe6yd+Xa86CEBWNN60J1zGKhMifYe30E59OR4XYwnQixzc8dzoDivLZX+H6vvsA1ZOH/xs8YVuLoevDdQkGa/yCWXMjPJn+TWgkeqrq3yXU4x2t+KCpl6Wj1uwC5LDnVkhq2IRMeswsmCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816183; c=relaxed/simple;
	bh=bk6ihrsPAJF7eTiBdcJ1bswP2epDJW779Ta31CKSh4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDSsfhV7QhqLNaic6QQC99SdqM1yKZmzlqeTL3c3CixE9zH5/JxlD7MiDyOSHviIYJaBHW07ujywO3I6cQvGgXJfJJVLyHcDbVmWJC7B68Vx50eGFd07dFEa0QFuEruXRSylNTfrmQiBzVpD+IBkAFSztsajaKRujRiJqhR4HsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Key158rz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723816180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNVsfDSCQ35Otb+d4cQrc4kpMU3VCRIAftynBpvO9/U=;
	b=Key158rz4BmuoRoQxmMD2qscBqEXCA3dJRpGD9D4SQ0W9b/3b3XAqX0HyYNTyKxF4JYk06
	6EV2tAxnQ8TB9kxrCsY41pgZ9CBenDxweteQGcJP0tey2ISbGoZ4wOr1QtO1o6X5HKvVXy
	gRWWHZpsbKydkHBMjfE4RSDsH59pE30=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-EimSA9SyNleGhztPM4uUKQ-1; Fri, 16 Aug 2024 09:49:39 -0400
X-MC-Unique: EimSA9SyNleGhztPM4uUKQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3db3874fe0fso298764b6e.3
        for <linux-nfs@vger.kernel.org>; Fri, 16 Aug 2024 06:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816178; x=1724420978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNVsfDSCQ35Otb+d4cQrc4kpMU3VCRIAftynBpvO9/U=;
        b=SmXSc0FV5h/hhC71holPBpdiVd3C0A6TrqfpSXoAouLhDIeRB9yP4KKFEGLH67YjfK
         1CX7pDrvFU4kZJ1iZOX0V5Po0Oj0seGpfcaUo4GNdwzDfE8y2xcAzOEyM5AsIqinx8o8
         4ty6b7JOPnUVuo7bocAGZG9NeftEN2KJOilTYkI0lWPyRXSZDIK+sx8yXccedVKiYHbc
         OTAgYNJY/6lbm22RJtDQEcNGBD/NHSt5GYGXYD1DhwhEyia6oRpklW6OpfWwiqiZliUL
         3+3HmNOvt8LpmxjdwxGDaZ8VVUOu6KxwN5nKEay4bGC1ME1RQzYmfpB2R9RH2+3tVK50
         fm4g==
X-Gm-Message-State: AOJu0YyBePPiI4vXkgw63PINdtrSBxKSv60LwpOF13Tlwoyo5hI5aLn5
	eB3nm4PlNL18+dzYH/ks5Y+F75EKVVxrFVvn4NIP1Na80cfDMuH5Uik7YgeSrnfzq7XEZSLwb/V
	hACn3jwnO06X74ogrMmVLdgvem2mbjSoaVzuiyL02NpsvhNhHUrd+233zMA==
X-Received: by 2002:a05:6830:4423:b0:708:b80a:de0b with SMTP id 46e09a7af769-70cac904251mr1666682a34.4.1723816178234;
        Fri, 16 Aug 2024 06:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6u9owD1wO/1HiVNVVEzrZkmV0AKLOLEZJIfQT+D9h+zCL53YD528sFHS2OhoMbubhg+JAUQ==
X-Received: by 2002:a05:6830:4423:b0:708:b80a:de0b with SMTP id 46e09a7af769-70cac904251mr1666666a34.4.1723816177829;
        Fri, 16 Aug 2024 06:49:37 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0851a7sm16485041cf.96.2024.08.16.06.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:49:37 -0700 (PDT)
Message-ID: <85a4e925-64f9-4160-bce8-54318ac27aef@redhat.com>
Date: Fri, 16 Aug 2024 09:49:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rpcdebug: fix memory allocation size
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>
References: <20240814210109.15427-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240814210109.15427-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/24 5:01 PM, Olga Kornievskaia wrote:
> Memory isn't allocated enough to hold the null terminator.
> 
> Valgring complains about invalid memory access:
> 
> [aglo@localhost rpcdebug]$ valgrind ./rpcdebug
> ==222602== Memcheck, a memory error detector
> ==222602== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
> ==222602== Using Valgrind-3.23.0 and LibVEX; rerun with -h for copyright info
> ==222602== Command: ./rpcdebug
> ==222602==
> ==222602== Invalid write of size 1
> ==222602==    at 0x4871218: strcpy (vg_replace_strmem.c:564)
> ==222602==    by 0x400CA3: main (rpcdebug.c:62)
> ==222602==  Address 0x4a89048 is 0 bytes after a block of size 8 alloc'd
> ==222602==    at 0x4868388: malloc (vg_replace_malloc.c:446)
> ==222602==    by 0x400C77: main (rpcdebug.c:57)
> ==222602==
> ==222602== Invalid read of size 1
> ==222602==    at 0x48710E4: __GI_strlen (vg_replace_strmem.c:506)
> ==222602==    by 0x492FA7F: __vfprintf_internal (vfprintf-internal.c:1647)
> ==222602==    by 0x49302F3: buffered_vfprintf (vfprintf-internal.c:2296)
> ==222602==    by 0x492F21F: __vfprintf_internal (vfprintf-internal.c:1377)
> ==222602==    by 0x491BC93: fprintf (fprintf.c:32)
> ==222602==    by 0x40103F: main (rpcdebug.c:100)
> ==222602==  Address 0x4a89048 is 0 bytes after a block of size 8 alloc'd
> ==222602==    at 0x4868388: malloc (vg_replace_malloc.c:446)
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed...

steved.

> ---
>   tools/rpcdebug/rpcdebug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/rpcdebug/rpcdebug.c b/tools/rpcdebug/rpcdebug.c
> index ec05179e..1f935223 100644
> --- a/tools/rpcdebug/rpcdebug.c
> +++ b/tools/rpcdebug/rpcdebug.c
> @@ -54,7 +54,7 @@ main(int argc, char **argv)
>   	char *		module = NULL;
>   	int		c;
>   
> -	cdename = malloc(strlen(basename(argv[0])));
> +	cdename = malloc(strlen(basename(argv[0])) + 1);
>   	if (cdename == NULL) {
>   	  fprintf(stderr, "failed in malloc\n");
>   	  exit(1);


