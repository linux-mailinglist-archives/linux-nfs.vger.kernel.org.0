Return-Path: <linux-nfs+bounces-2301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C991887CDDA
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F11F21CBF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C12E634;
	Fri, 15 Mar 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7fz+N3m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE902E636
	for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508340; cv=none; b=nGM7vMRSA8zNzGqXk0t9TAy001PU1Vlz+XQb0s8GPsmQMH5wMEm5qDA+Wj6Ha+RHNpAjfmcwbfzYwKbWW3KJJAQYQ/L2IC4mjCFL8MSQbxiep6KhJolhlXHkqKOTl0tZxV7nO60LQwUxWZP3oD1ps/y6XIGkZT+/2CDWckGo+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508340; c=relaxed/simple;
	bh=eZPvS+fmz8pHlG5R4BRlZTAT8mPSqpJs2Zxyn7UbYsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0DDF81wb+EXjlf10QNziQ/mltYnrDohmES9XhNGa7ZPD1RGRsXx/NhkPg28dw1dcatG11iTJDeOAozLTkmI5N3zPUUjdT7zPArLPx1kurZo5CBTvj3EZhBgx70Go+VqBLUmQlbaih9z2Vjwx9+8jBGt8o0KyPDYVY8kgezHTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7fz+N3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710508337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ege7nl2EvaAETGqByINROZRPU6XrS4/SqJP//n8wn8=;
	b=b7fz+N3mbHA8Ppm+laEWWJJmn3KfZBGruDXBW469Bmct9Swh2NdDYPNGboWjJLmrQ+oTzw
	mSYsrsg0q1cIUpjJx37Ad5pQTjc/Q8MGBJC5kjewVheL5ShsYXId7cHiUfC88w0DGN8j7V
	zZ9knV5jhcwOJMxbHiQy5hAxFPDtEOo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-8qsmOo-8ODarJTf2oMNZwg-1; Fri, 15 Mar 2024 09:12:15 -0400
X-MC-Unique: 8qsmOo-8ODarJTf2oMNZwg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690b5ad0e61so5536736d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 06:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508334; x=1711113134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ege7nl2EvaAETGqByINROZRPU6XrS4/SqJP//n8wn8=;
        b=LZymdnlQPrI6jY7b38c2I8WnVMDozX89/0c77x9MrfMKBOuSFG4z7yJ+zpvP9jZX11
         myfvjgQrNNdIsXaQvj2Qg4YFn2i/lhatXo1Oul30ObeysODcNy3uTW+2ZtxZmLLPwZb6
         cQ1DLKNF85bulCHMfAATxkJAQNMkldAblOWoIVwNaCiteqhMl+EYjqeDGC1i75iknSZX
         xSoED86Groo+8vu9gI4hysPhRXxhAzZYV5W1UUz+gW8LpfbTfEOhuDR+wsYPBPb9JaCK
         JxOSw3lijoVpc2/Qa2m+YnmJEZFkkfuljJ/XP8kpKX0TFzDitkK/lUriCh83OcdF9p/F
         KaAA==
X-Gm-Message-State: AOJu0YxrndtCp+dbiRPaz6AAmB2Z1LDVr3ZkmuxatbTx3e75kq0dc3jE
	aeSuVQiSKHiD8w8s+it0eqJgBRmR5J6cXpZTwIO3qnTfBBBqI/q1vCVczcZ2V/1T9+fVjIQxhhd
	pO4gQpk63VioSvWjguc0wBlYOEP3b1dXwQ0K1phlWNX2mPnUpFTpO5//PRw==
X-Received: by 2002:a05:6214:4893:b0:690:b5a9:84f1 with SMTP id pc19-20020a056214489300b00690b5a984f1mr2179944qvb.1.1710508334500;
        Fri, 15 Mar 2024 06:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBBO+Wp4MK4sxW2uwG1YEWDfkkjdEkS2nxRlMkGnZFdPfepeDPPsqdd/+Pj4z/z4GRga6jsA==
X-Received: by 2002:a05:6214:4893:b0:690:b5a9:84f1 with SMTP id pc19-20020a056214489300b00690b5a984f1mr2179928qvb.1.1710508334246;
        Fri, 15 Mar 2024 06:12:14 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id gy10-20020a056214242a00b0068f6e1c3582sm1939942qvb.146.2024.03.15.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:12:13 -0700 (PDT)
Message-ID: <a77b6ad7-7a8c-4657-9abc-a59db2ef199a@redhat.com>
Date: Fri, 15 Mar 2024 09:12:13 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exports(5): update version information of "refer=" option
Content-Language: en-US
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: linux-nfs@vger.kernel.org
References: <20240228100957.659-1-chenhx.fnst@fujitsu.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240228100957.659-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 5:09 AM, Chen Hanxiao wrote:
> "refer=" is a NFSv4-specific option (as per RFC 7530 section 8.4.3).
> Other client version will ignore this option.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Committed (tag: nfs-utils-2-7-1-rc5)

steved.

> ---
>   utils/exportfs/exports.man | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 58537a22..c14769e5 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -445,6 +445,9 @@ the given list an alternative location for the filesystem.
>   filesystem is not required; so, for example,
>   .IR "mount --bind" " /path /path"
>   is sufficient.)
> +
> +This option affects only NFSv4 clients. Other clients will ignore
> +all "refer=" parts.
>   .TP
>   .IR replicas= path@host[+host][:path@host[+host]]
>   If the client asks for alternative locations for the export point, it


