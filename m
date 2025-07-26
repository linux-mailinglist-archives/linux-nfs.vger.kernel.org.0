Return-Path: <linux-nfs+bounces-13261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C6B12D08
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 01:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9863B981B
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E6202C45;
	Sat, 26 Jul 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFzaqq8x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383417DFE7
	for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571588; cv=none; b=AWjO01o22uIzTlyu0mNmwEMY3GU4MlS1Ewa6+YfNtmz+uIsqd6cUn0xDpbkEs3/GVjX1jJOB5yXCLHw6ODgz20CPfE+0lX1J4/FJGYwDX25HuEoMNiv2I4spgyN+1f+PuJbmGBP401n3H8vnWubnLIXUD9dpUtr1LnOTpxM5bHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571588; c=relaxed/simple;
	bh=Si5OxBiFFjyFY0lpYqUuGb1XS1HTmIX+w3EdSya9mF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7pJVWMqnEnqipiXjPhTIZGDrBjSk8Bl8JwOqSSRoamW+ZfXJxx1Fad/+x91CE0U9Wtkq2jSqJschsvIXu/Z4Fdsgc1dmgMiW/IpgE17AMf/D4UxhExM+cMQIFgDDDgzOaFKuxTlnqDKfTRCFSogBVHBpEkGMSJfZADWsX5+Sks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFzaqq8x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753571584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqt+l7oR8ebIsxyszkkKIN0lgi+U1xVdKw4TvL4+Emk=;
	b=PFzaqq8xcflR8Cy+jiyxRGfe06NuzVURepy+wnJ67JP/R3gkWKn1YoiSEBWuAcXsyVcMcC
	ljG5e6i6t17vJedSoobcSrVob/7BF65VALKy/nBDIj2A8ghofF0/z5R3JRcd/dDljY/S44
	DAbBCBgR4PjD3vH+Z78ZKKtslNbxcDc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-a9hRAGaiOLyGIasN-HqhPg-1; Sat, 26 Jul 2025 19:13:02 -0400
X-MC-Unique: a9hRAGaiOLyGIasN-HqhPg-1
X-Mimecast-MFC-AGG-ID: a9hRAGaiOLyGIasN-HqhPg_1753571582
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-702b5e87d98so60654056d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 16:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753571582; x=1754176382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqt+l7oR8ebIsxyszkkKIN0lgi+U1xVdKw4TvL4+Emk=;
        b=cUF5vraDd/HwPlw/JUbQi0s3JfQwoSHXK+XbrxZwYEPawjuzrGNAAGC5lM8DFPqpMD
         W8D3DLeIG0RDr6LM1Z4ZZH6nCIcM6l8nQshA8w3XzYKnavzL11wg4ICrEEcOx8pS18yh
         imG+QdT5AbxwNRp9rlLorG8e6dlG3o+3HLKX9FJnjlKDmVkZpBqEWtnFkcSsP5R7hhLB
         gwNgRJB8PJUQ9qbrvJ8JKuaVWGB0CQRdCg9y9/T4mwUMP8HCHyrgvHVzJjqkzX4/EXkS
         4Ei6Ggs3DTr4lW5gflAGrz7X5lJxTSQE5AX6rumvZBpgyDycxWcgxImw4YUsDfBiJESH
         t7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWOGEclddcTRibRVP5iI/GUlMpj2vZLd+Xh561g3x4ht19dkJP4H5E8KXzVcqDbMYALM+iXWGq48u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEyfx6FdZtht3l1xTrt36tUwp5JbZjEGfOUXWuRbYIpfO27dd
	OWs+b5L/pJy7dONVc1mL+7gkFaWq23IWJsU6MTxKhAoYUjoeLBR4mHPZ+NRd1HwfgS1SGHJu04I
	wRtH0EjmT8bi7wTmOwJv5aZjUlzITzqWny3YUrUY2YNGhCQ1IuQm1jf+4KiNSfQ==
X-Gm-Gg: ASbGncvqV6+ERxeXyXwArx/Utzlr8NMD6itI6I07kK/uBd2SjOS23xhYGAD7JrL7ZO5
	CwA05JNuIk/ozLmwCmh1kfxQLJqO5VibaF21ZF0Mn8aVAYi102IjypI80l83URs9kn4rwjgxaZ0
	03FYi672FP2RCJ6QF0tEt9XXqHzx3b5SFwxMliVxg7K+QKisGPg4xl5KNAs+uGQ8FPyBESH5Hm0
	gO3DphaP9lhxqvW2mENXkPGVX/drgcwDUWbQRHv9UYCg2aKN5xASHNPjeYyABuRhhu++eBLroxx
	9pynpldhYYcpyX7FkYXCYV4PRhFzxYEP9LoCw0ws
X-Received: by 2002:a05:6214:242a:b0:704:b066:f299 with SMTP id 6a1803df08f44-707205418bdmr109338036d6.11.1753571582323;
        Sat, 26 Jul 2025 16:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAVuwyrW3fqJs+SlLb6lKN7Hf4yCmpbdNHUVvWBfbVNxnx961IOOmccyPNr3X9a5/31c5Rfg==
X-Received: by 2002:a05:6214:242a:b0:704:b066:f299 with SMTP id 6a1803df08f44-707205418bdmr109337696d6.11.1753571581890;
        Sat, 26 Jul 2025 16:13:01 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.240.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff148sm14897276d6.21.2025.07.26.16.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:13:00 -0700 (PDT)
Message-ID: <944684e8-1e80-4190-a608-6631236833e9@redhat.com>
Date: Sat, 26 Jul 2025 19:12:59 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rpcbind 1/2] man/rpcbind: Update list of options
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, =?UTF-8?Q?Ricardo_B_=2E_Marli?=
 =?UTF-8?Q?=C3=A8re?= <rbm@suse.com>
References: <20250605060042.1182574-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250605060042.1182574-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/5/25 2:00 AM, Petr Vorel wrote:
> -L was removed in 718ab7e, -w added in 9b1aaa6, -f added in eb36cf1.
> 
> Fixes: 718ab7e ("Removed the documentation about the non-existent '-L' flag")
> Fixes: 9b1aaa6 ("Allow the warms start code to be enabled at compile time...")
> Fixes: eb36cf1 ("rpcbind: add no-fork mode")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: rpcbind-1_2_8-rc3)

steved.

> ---
>   man/rpcbind.8 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man/rpcbind.8 b/man/rpcbind.8
> index cdcdcfd..cd0f817 100644
> --- a/man/rpcbind.8
> +++ b/man/rpcbind.8
> @@ -11,7 +11,7 @@
>   .Nd universal addresses to RPC program number mapper
>   .Sh SYNOPSIS
>   .Nm
> -.Op Fl adhiLls
> +.Op Fl adfhilsw
>   .Sh DESCRIPTION
>   The
>   .Nm


