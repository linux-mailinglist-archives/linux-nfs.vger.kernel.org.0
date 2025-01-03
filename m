Return-Path: <linux-nfs+bounces-8901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26884A00FE6
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D121881283
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929E145B3F;
	Fri,  3 Jan 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJhw9bvf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE9145B03
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940036; cv=none; b=pKKLcUPtGIS+U6HS1do87Zh7ZrnZKwESu2i1PkFvcz9SYgjTXPGzRe1EW6Ch/jdN6Z69UbE+9brMedWYoMLVz7cyviVUUQL+D1rhWVEucZXNKcg6/eyij8FuJEGcwlGDMcr5zZ0PY3PPYPdMv3iOWMjglE4noxJQdpP6Qs65Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940036; c=relaxed/simple;
	bh=4g17KLXhOFl4TbK7uNRNgLJsRQoYHqgS4AmN8OG/y4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhFF4dkDMXEEZAcc5sMSM8hrqAIfB/X2UZKW1NsO4PdyN7rHLyYjMcp8u6dtxSruYC80cwwAUKrBcTfJdBTzUNzv6HUYFNYYMfu/1Am3EyrGAl2UR3dCOV1zoZV+5qFcDOcsHCQYpbjjd4Aa+zstzLeEoRnfaCmP4wxcrSdgkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJhw9bvf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735940034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YROMMbFHqlasUD5BirDhDSzkDtm5QFBoWkzw6c9ceso=;
	b=XJhw9bvfCH5S+PO12bAEz0Hypge03nHdw9+I/esiigc7LFL0c4UpQAmPWp4P73nkXQT2Kt
	FTegbEITtLEBTRp795+YiiBfHDd7ER79BB0moln2W56rvrcN7MiI1hfwkxcviCmMzWjOK7
	tAfXVAKsqlSeqyO62kcONaoxkb+6BXY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-xylSPMnuMoqOUljHwbFVjg-1; Fri, 03 Jan 2025 16:33:52 -0500
X-MC-Unique: xylSPMnuMoqOUljHwbFVjg-1
X-Mimecast-MFC-AGG-ID: xylSPMnuMoqOUljHwbFVjg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467982f8816so274950241cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735940032; x=1736544832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YROMMbFHqlasUD5BirDhDSzkDtm5QFBoWkzw6c9ceso=;
        b=sOAQcUJNXp+1Zvl+V4aaAC81IIzxyuYiIa+T3wohiYNxdUNcrP9hNMrlJ6JFJgg3Et
         3V2ZD7SwCOe5oyysxJ8M8/VLnz7Znxt1/BD/al190ccGjHJsXGG/2axXLhkzgZXvHDXc
         Z5po19cvSJ/R3DcnbJW/ZQwC54DT8bDpgzTgNcZ2u5wRGfxlhKY5cQVnAbbEYmcHXck1
         9eCyCBoCZRYJD+rlF2RL/cdKC/E16hwQVthCrtzkMnfCas8/P9GwswmbLhJVlTiVqtlz
         Jk6SJ734c+2EZNsJNUmBA4PWMOp98o0onz+UmRZGfe1XIrnfn++d0EnIzPPcNwm0lMCH
         u0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8S+n9MSzwK23ODqCAz0iF1pVlEi5y1pG6/l3GtWlW9EzrcwzK1hOPZhu9oegPoN9EQLy8t5nbwzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqJOI6wAiDoxu5KmhxNU/Hu7MkCJiy2/oL1uw/F8PJxWOIAZo
	/EZWzCg+4OWFyCoXB48i49emdq3DoDZKA+zKJvxSMKZxVJme7xak9k5NvuPdch6XHvlZRRLl0Om
	YUZU6dJI8LruLP4kLUJPatF8ezJ2XzibqYJEqlS7lhVOZh8aNYHh7vJjkx3vUPx5ovA==
X-Gm-Gg: ASbGncsA2CWnSkCsqkfpUh+ZZzyuUeLrcstrKzr5811nmvsgbtV4pfMYOGyP5mRjS86
	Pq30DOCOHwfrII5ijO1aIRMvHbVpNY5+Zlu+1IT960Idf5Hu1OzlNtgcgpeDPS4bGfWkcFqBlPr
	H0Ci36xVaKcZ5UslO4B4/uWaBAdrZo7jgk/d0vqHX4hK8omG+g7+icMvjsrJgQvP3YfeI+CSjsL
	IDb1INJErOP9ty1eOKPMW64KGocD5pnrOxybUpoKcueeEKBNJBch+OL
X-Received: by 2002:ac8:7d92:0:b0:466:9ab3:c2d0 with SMTP id d75a77b69052e-46a4a9a6c2fmr885106071cf.44.1735940031739;
        Fri, 03 Jan 2025 13:33:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4H11aDZh9RmCiwK+H0hGT375i12OiLeMyoDppfYKLykZeLgC/NmsISJ2+45K9yQhv6IBixQ==
X-Received: by 2002:ac8:7d92:0:b0:466:9ab3:c2d0 with SMTP id d75a77b69052e-46a4a9a6c2fmr885105851cf.44.1735940031442;
        Fri, 03 Jan 2025 13:33:51 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a9bf7sm149094961cf.48.2025.01.03.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:33:50 -0800 (PST)
Message-ID: <2afb1b05-17e4-4948-b466-ee64c6c7d446@redhat.com>
Date: Fri, 3 Jan 2025 16:33:50 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix typecast warning with clang
To: Khem Raj <raj.khem@gmail.com>, linux-nfs@vger.kernel.org
Cc: Benjamin Coddington <bcodding@redhat.com>
References: <20241219191212.530007-1-raj.khem@gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241219191212.530007-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/24 2:12 PM, Khem Raj wrote:
> Fixes
> file.c:200:8: error: assigning to 'char *' from 'const char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc1)

steved.
> ---
> v2: Make base as const char pointer insread of trying type punning
> 
>   support/nsm/file.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index de122b0f..68f99bf0 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -184,7 +184,8 @@ static char *
>   nsm_make_temp_pathname(const char *pathname)
>   {
>   	size_t size;
> -	char *path, *base;
> +	char *path;
> +	const char *base;
>   	int len;
>   
>   	size = strlen(pathname) + sizeof(".new") + 1;
> 


