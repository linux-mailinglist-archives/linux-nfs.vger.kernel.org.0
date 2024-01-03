Return-Path: <linux-nfs+bounces-909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261AC82394A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F622877B7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4C1F926;
	Wed,  3 Jan 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN9ESy5J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF921F932
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704325145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhX+sFpw7NtL035Q+70Z1mcyDrlKANyUjNATssayT+g=;
	b=dN9ESy5JdkogkXQkT0t0MUCka5iic1sNeOu8/uBGGtwej5EA5c96zOKnmUsc6YiTsxoaXO
	1DBWGgpeaSCFkXa1tG0Pui+0hf1wey4Y9F/+vRFWBKvIVWF8/6kgDn7cq7XWL363Zai0cy
	pw0lsIwFJhOZU2TgznrwdOeKEjKKxcY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-DeIs4YaVMi2IMr3DxnSXGg-1; Wed, 03 Jan 2024 18:39:03 -0500
X-MC-Unique: DeIs4YaVMi2IMr3DxnSXGg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6801dd788faso23750166d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 15:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704325143; x=1704929943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhX+sFpw7NtL035Q+70Z1mcyDrlKANyUjNATssayT+g=;
        b=BWbzqKf5a1MW6MGh4xswfu5hBSdYAAVwkHReSW6zs+pgHbZPFs3gSb71vaiNOKiaHJ
         chz5QBDRsqs3ebF8UZRF5CwQosumMEZ3RPzKlcZ/tl7N09sYqvBKraS/4sQL+mB1zYoy
         08V0g3sifPp3avmpr8ckgrfIsgzentphUP+Cp0svDx9wCYdEqcl61/o9pzusmrtP8b1n
         1fWbI7tWDmr36mMNwzZjXSXYPS5GhfJPjKnuTOUVvccaZV3+9k14WekFkCGT07j8mnFb
         5nwFeijupAVl7lxlvAXe9QHOSqaH+oeZONxAi8YNGGPeGhMS1o50n/dvGB+H0Rj2FIoo
         RVvQ==
X-Gm-Message-State: AOJu0YwQBqa3fCKGBghcp9CgdI9eO4kzQk8sgiBRS458G/Mlwz0YWcNO
	BBnnwX5q6ZNLtGv/kENe2cGeTXtOiEzdf7vA8Rpfb6SnxItAMVJK1qQ3fT/+WKN6eFoTKDM+7u2
	cFOl6j2ojgi9t+VbCsMKDCz2PWL6o
X-Received: by 2002:a05:6214:500d:b0:680:b6ec:ea3b with SMTP id jo13-20020a056214500d00b00680b6ecea3bmr9468004qvb.5.1704325143075;
        Wed, 03 Jan 2024 15:39:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWNrex+2Ob7VenCoWfyWUR7Mbd4bM1CD/uM2bUet/SHzoSFmW3Zb6a7EDEzrTt8jP7vIOzbQ==
X-Received: by 2002:a05:6214:500d:b0:680:b6ec:ea3b with SMTP id jo13-20020a056214500d00b00680b6ecea3bmr9467997qvb.5.1704325142847;
        Wed, 03 Jan 2024 15:39:02 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id o2-20020a0cecc2000000b0067aab230ed9sm11283824qvq.21.2024.01.03.15.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 15:39:02 -0800 (PST)
Message-ID: <c5fe6393-86fc-4918-9d02-9257296b2f89@redhat.com>
Date: Wed, 3 Jan 2024 18:39:02 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gssapi: fix rpc_gss_seccreate passed in cred
Content-Language: en-US
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: linux-nfs@vger.kernel.org, chuck.lever@oracle.com
References: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
 <20231206213127.55310-2-olga.kornievskaia@gmail.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231206213127.55310-2-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 4:31 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Fix rpc_gss_seccreate() usage of the passed in gss credential.
> 
> Fixes: 5f1fe4dde861 ("Pass time_req and input_channel_bindings through to init_sec_context")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Committed... (tag: libtirpc-1-3-5-rc1)

steved.

> ---
>   src/auth_gss.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index e317664..9d18f96 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -842,9 +842,9 @@ rpc_gss_seccreate(CLIENT *clnt, char *principal, char *mechanism,
>   	gd->sec = sec;
>   
>   	if (req) {
> -		sec.req_flags = req->req_flags;
> +		gd->sec.req_flags = req->req_flags;
>   		gd->time_req = req->time_req;
> -		sec.cred = req->my_cred;
> +		gd->sec.cred = req->my_cred;
>   		gd->icb = req->input_channel_bindings;
>   	}
>   


