Return-Path: <linux-nfs+bounces-9217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88738A11E4B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 10:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1503A07E6
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398D24816D;
	Wed, 15 Jan 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc3di4jt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA43248175
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934068; cv=none; b=g+Od08/M1CZKdvqbWMzkpGRCurrSPf/rKPV89ndU/etz+3JSWNqB+vNUddGTcINyTcTjI5iKI8QPLFeGwoZDrJIJwCVDdXtzNwrsuSASzeno1IJSCkHsuOz68wZmslTVUhTXNLwksEh4YFkR4NV4H3erCqRKPkXPNbr28fvD27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934068; c=relaxed/simple;
	bh=jINEzzYUW4NjlUjB2oY7c7+ASe+bxxtCs43O8GXqIbs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X7E8rtPJbpAr+AGbkQIj7chl+PHKAabsR+/UvxT45g90G2tYt4byaBVXAwAmJ7Hn3IvAN33J4s7swzikVI3rPcOWOCvnsMkQ6pr8EbjqTgy/BmJSR0iP260uulWv5vljCMC6Qodsuhd9pbyxrRso4WEdaYzYve92fHT5qKWEE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc3di4jt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736934065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu38b48OEG5zBB85sN/OuBsNY6ZV3Esp5ASUSXhY4yY=;
	b=Oc3di4jt+TIMh7mghqKeZaEcZRUbes72hxQ/FEnkbyihdJWrjrVv2B7AyPFtrFEX61iG4e
	sIOZAuA64OhejhwqgTH/57a+vv5ygPZzy2ArfnB4kWcRuz6pRVs+c+YxXshl/UgKI1iKHz
	PLf6nBzjknxVdG03e8dT3FN9HbVu/aA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-NyBAT1f0OdGgyo6ysE6Dkw-1; Wed, 15 Jan 2025 04:41:03 -0500
X-MC-Unique: NyBAT1f0OdGgyo6ysE6Dkw-1
X-Mimecast-MFC-AGG-ID: NyBAT1f0OdGgyo6ysE6Dkw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21640607349so141956485ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 01:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934061; x=1737538861;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu38b48OEG5zBB85sN/OuBsNY6ZV3Esp5ASUSXhY4yY=;
        b=C6fGbEiUMMwW0A+U2YcbIvYvIjf2i8ZWQ5RiPuO2Uuhlba1X3k0vms3kfHX45+Fyvr
         JSSfIpaMcHGhOL6TUYKOKgM9LGhWM53gvapdG+2HZJqCXR2kzWECETCP5V4s+fdUc+zu
         VqTp18t8IyRcdP8nkdCUBdqZpAp5x3bF64ZLe1yboBjRoCZq6XFqykFXjfAvWUHgcA/L
         cdWnHtmdDy9hZFekFipIwkGtqq5wnf78h2lMNHJf1tdfmA8R1biRgCaeP56Cb/WUoIEm
         jmBQo8694bGJ9jxbA5s0RMevnL5ts4ZHqRwWthoQ3f2P7OvYFBQPCNOXubmYF7PjurY0
         6s7A==
X-Gm-Message-State: AOJu0Yyg491KYgXLPHJbznHk4/Bf+4p4BzrEMxQH0VgbmSpKsf3nicqv
	eMTxf9+aSbfOfuj1g5hLDRGrMuM20FxRIWH3fMEufNwOe78fNZ/EEaxRPDKLRx88lfDuF3HEDMU
	KcYA67jPKCkoo3mj+wM8u8O7YjfnVLNAOGCMan7ViSqZgaj4JsQIAZiLYm5h63xAXtxz0sciFp/
	+O9OtaO9FptsTefCbZxTINuaLP8AefoGQv3iFq7ok=
X-Gm-Gg: ASbGnctHsr04K4CRLuANk/E+v//fsRZV2OI3W+idzR3QNgDLvvuJz9NPx5LkN1wOX+f
	f3aRdmponqXZ0bblr1DwuITW7mYM78hcGRhG1LRpubqL5u8yPkOPQ/d9mSa8ACw7F//cta+zHYS
	pbrflFxR1MtxtxQSPIm/n3r969S4kUVaHgSAMvEy+J6ABmdqaBoLhXlvnBgk//7Jksby5gEGbyT
	s0SHGeTLx2Jd9hcmfzAVE9sPoidOV6ECeilA6WQcZ0fMXJbCUPn7wiP
X-Received: by 2002:a17:902:e852:b0:216:6be9:fd57 with SMTP id d9443c01a7336-21a83f57028mr467205945ad.21.1736934061422;
        Wed, 15 Jan 2025 01:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwOCOrJHOUx1goOh+Ar63iahhHxKzqcoJnx/E+dWrBvUadnX2zX+Wen5ypnlb0eKXsJcgRmg==
X-Received: by 2002:a17:902:e852:b0:216:6be9:fd57 with SMTP id d9443c01a7336-21a83f57028mr467205635ad.21.1736934060960;
        Wed, 15 Jan 2025 01:41:00 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253ec0sm79942885ad.236.2025.01.15.01.40.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 01:41:00 -0800 (PST)
Message-ID: <d0886f7c-2078-4a0c-8b35-31c72ca05dd8@redhat.com>
Date: Wed, 15 Jan 2025 04:40:58 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdcltrack related manpage and configure file cleanup
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250111095509.61461-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250111095509.61461-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/25 4:55 AM, Steve Dickson wrote:
> Fixes: https://issues.redhat.com/browse/RHEL-73500
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.

> ---
>   nfs.conf             |  4 ----
>   systemd/nfs.conf.man | 14 --------------
>   2 files changed, 18 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 087d7372..3cca68c3 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -60,10 +60,6 @@
>   # debug=0
>   # storagedir=/var/lib/nfs/nfsdcld
>   #
> -[nfsdcltrack]
> -# debug=0
> -# storagedir=/var/lib/nfs/nfsdcltrack
> -#
>   [nfsd]
>   # debug=0
>   # threads=16
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index d03fc887..e6a84a97 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -158,19 +158,6 @@ is equivalent to providing the
>   .B \-\-log\-auth
>   option.
>   
> -.TP
> -.B nfsdcltrack
> -Recognized values:
> -.BR storagedir .
> -
> -The
> -.B nfsdcltrack
> -program is run directly by the Linux kernel and there is no
> -opportunity to provide command line arguments, so the configuration
> -file is the only way to configure this program.  See
> -.BR nfsdcltrack (8)
> -for details.
> -
>   .TP
>   .B nfsd
>   Recognized values:
> @@ -329,7 +316,6 @@ for deatils.
>   Various configuration files read in order.  Later settings override
>   earlier settings.
>   .SH SEE ALSO
> -.BR nfsdcltrack (8),
>   .BR rpc.nfsd (8),
>   .BR rpc.mountd (8),
>   .BR nfsmount.conf (5).


