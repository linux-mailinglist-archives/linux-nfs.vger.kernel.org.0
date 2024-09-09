Return-Path: <linux-nfs+bounces-6335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D86971551
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B76283E91
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038161B2ED8;
	Mon,  9 Sep 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLGwouhy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C01B5309
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877718; cv=none; b=RCo5bDS73EqT4qcrOAHrBo07LPj9mF36fnH+Ilty5lef6JP+f5hqXWauzBOJgHnivr4a35eqrh7imYjWUN52VHqeBzAWOPthy4kqtUhXmu0MUZZ/NYbtxKTdN8PFI1YFfLw2+cW9puGFmMGZG4Cz9CensRpI6hK/wuvEE10fP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877718; c=relaxed/simple;
	bh=nc52E6d/62fnrheUEb914pIdp7dhzBTVx/SnLCnTRic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GattXGtSf22U4I0GdHqYlbbRbPeV1MvP440eIOhRGxdjgX2mfldTIZ9SfMf61NeoSbForVa3XoZQBtMkqrWZcU4pn4p0d+u6vfwuVICIPxtUrEeGJXgIg/9y+8n76FlWt2gLN+Jy0cqzHgZSS5PCASrcFmePNGfIsoNKieKY4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLGwouhy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725877715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+Kb6vXmYy0XoChq2v5I1X9XJKRuTAq/LYmh1VxR2As=;
	b=RLGwouhynzYOnsOy1FHjc7M4SZgXW5wC4ol2xRA6fCHavikxnEB5+hKbqyHxEiwecNZDef
	oWrgXCzRJ43ZcFWeIPdZCKWgsggT2nfKY6546va9P+aKdhoQT2bvZVJ0+0WzX53BeCAKGf
	W9RT1r7I9i9eTfkDNQ4is0KIRIlfruQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-o2DxlG7IMQijO1nNSPya2Q-1; Mon, 09 Sep 2024 06:28:34 -0400
X-MC-Unique: o2DxlG7IMQijO1nNSPya2Q-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-49bcd872a85so1894739137.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 03:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877714; x=1726482514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Kb6vXmYy0XoChq2v5I1X9XJKRuTAq/LYmh1VxR2As=;
        b=WCcxLURsudXp2psUoVE+TUdpz5H7hWRsuBy8AgcMezobRn6r21X+VqB3USVTP70h6g
         3+1AwWWToOdLoY5fISkKRJvEI/Fj0l+dRu96oxKS4qB1/wUXmeKCvD7i6aGgUm4kh5M3
         /Dlotzot/nd4kDtFWU6ZVQs+Fy30bmrQA6LwLr1B+WWmV90m0aLXj9NVDYbkzUDd1Yfx
         wZLI450KmJ6LtevTCCm6KBQvcDkHZDCFVB2VqJi940Lf1zvtY/8VTssZhLTlDnewds1y
         Rfght8NnZc/kx7XvVzQ1P/w1DH7sw6S3A+/jqPJ/7QNUKq2P8pXjIUkxToxPZnYQvEBG
         GdzA==
X-Forwarded-Encrypted: i=1; AJvYcCXVbnK656K4ENtKU1YPG0IOUz2JYn4WqgDjgfJVeSE/4FhKJk/5r7Q7X6eiGF3/iB8EMpueFceGx6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPo9sdHBnMuaEP6vs1xv2lhPk3siQZJJwvbfV0rZo4SRMeYqsY
	eYMz+46i0FK/9iRVhuWG+z6LdGtmqUl1+D1FbhjzoBlDdX5gCDA3R8jfEOaYzwvYZ0fVEDkb0O9
	u8iVVa+DNlKxeJCpxuFnh4ac0C3abxFIWsmHaBtoweAMAwA7hoMWLd8JPIQ==
X-Received: by 2002:a67:ec4d:0:b0:49b:fe4d:20e4 with SMTP id ada2fe7eead31-49bfe4d2327mr3361992137.28.1725877713966;
        Mon, 09 Sep 2024 03:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFodfmNB4DOlVPT3Sq0iNwylTzftTLTsDQNtv4tzZxj8wpfXDkJUdbIyM0d+7NvHM2yqBtrmg==
X-Received: by 2002:a67:ec4d:0:b0:49b:fe4d:20e4 with SMTP id ada2fe7eead31-49bfe4d2327mr3361981137.28.1725877713595;
        Mon, 09 Sep 2024 03:28:33 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.152.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d787sm19441396d6.97.2024.09.09.03.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 03:28:32 -0700 (PDT)
Message-ID: <8ba8176e-d37f-44b3-a4cc-1d0f04181770@redhat.com>
Date: Mon, 9 Sep 2024 06:28:31 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rpcbind 1/1] rpcb_prot.x: Update _PATH_RPCBINDSOCK
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net
References: <20240901120609.197824-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240901120609.197824-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/1/24 8:06 AM, Petr Vorel wrote:
> 2f9ce0c updated rpcb_prot.h, but rpcb_prot.x must be updated as well.
> 
> Fixes: 2f9ce0c ("Move rpcbind.sock to /run")
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
Committed... (tag: libtirpc-1-3-6-rc2)

steved.
> ---
> Actually, tirpc/rpc/rpcb_prot.h should be generated by rpcgen, but I
> just updated the header.
> 
>   tirpc/rpc/rpcb_prot.x | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tirpc/rpc/rpcb_prot.x b/tirpc/rpc/rpcb_prot.x
> index 472c11f..e0e6031 100644
> --- a/tirpc/rpc/rpcb_prot.x
> +++ b/tirpc/rpc/rpcb_prot.x
> @@ -410,8 +410,8 @@ program RPCBPROG {
>   %#define	RPCBVERS_3		RPCBVERS
>   %#define	RPCBVERS_4		RPCBVERS4
>   %
> -%#define	_PATH_RPCBINDSOCK	"/var/run/rpcbind.sock"
> -%#define	_PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
> +%#define	_PATH_RPCBINDSOCK	"/run/rpcbind.sock"
> +%#define	_PATH_RPCBINDSOCK_ABSTRACT "\0" _PATH_RPCBINDSOCK
>   %
>   %#else		/* ndef _KERNEL */
>   %#ifdef __cplusplus
> -- 2.45.2
> 


