Return-Path: <linux-nfs+bounces-2380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522AE87F14F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 21:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E636F1F23D7C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F158206;
	Mon, 18 Mar 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1bfRXXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2158201
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794423; cv=none; b=Uh7B8cYuPJB3mWqVdiiqtzoxruZKahG4E3T/CjFtYo6YYF+sEmXHtW4a+rK57lpvV7ULe1FC2FUT2IzcJLX4g4PbXNavk3hFVSgqzTtNHd7I1wOr1sx8xJWqkDiHLBCBcxmI/CdGN7ZgB+lIgr+98qxnKMnTNNrsy33up8GZ/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794423; c=relaxed/simple;
	bh=e849nEIzLxWNVOTzEdO1EPWouQx+DlW/m+fN4JKtdoA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rMh/vi6XWXqI7rIhy+O48UaTnMtV3/txnmeCy24PtLkNO1QezZiEIJz2gVPpvW4XhPaX0cOtbRVkfC61Ixaw/P9sCCWJFvadGpiAcnwJGmILeHDuENp0iIO+P5Yqx0CZZ/yoaxxSUunPdFWKQ1YAYngSGSaxU/DGrY9QOE69sMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1bfRXXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710794421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqGvjbKK3OKfu3zjjY94ukwFyL7mtZU5N4zcR3l6250=;
	b=E1bfRXXKd10E/zMnWMqdyMXF6yg546eycWfv1MSUj9lyRn0n9xlF3fE0mmPOdZXgFa7QOr
	yjyw7DsePcquLAPwbkR4wr+8jzgpJMkssW67hxJEQAFFcjvLVgdyTZF5CnKyVdZmdWCeax
	ggs6FLbKR6oC0HgZlyxIIn7DtjjYX0M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-nFz31K4gOw-UeR6eehh11A-1; Mon, 18 Mar 2024 16:40:19 -0400
X-MC-Unique: nFz31K4gOw-UeR6eehh11A-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6dde25ac92fso2123930a34.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794417; x=1711399217;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqGvjbKK3OKfu3zjjY94ukwFyL7mtZU5N4zcR3l6250=;
        b=Wdnc4B1v1g/CVHJkAknpSrVi9VNxZNYxGTJEHsRuhg7XBdXD/Wrr9BrZ94hPUbO70D
         Mro0rpwXZU1oVG4DIFNqo9YBf3FPLLQExI5lvzW01Kzh4Z/vExbeQ1jcRWarAZUvo6B7
         HMsc8cDJhDcvwz4hLyBHkp/46SYoVaibV1gvfSwoeq/kuh09gDHZRXVXp5tZ9HJeaNRF
         pBFXL8rDNb2MSq5MMua5nxxUXm8wQNsnH/uTJEIVgH8Ni9rHNwGPetkKlMKSxPkJycGA
         yjEhzKerMeEN1B21WOrww1aMnfa2kC/icrkl2xlsLR8m9mC/Pk+AE0PTT9YXXC7xI8HN
         NUBA==
X-Gm-Message-State: AOJu0YwXUAGkDsdvNXeYGvBB+0XFeK1NleDKS+MigJMzJ8Lx1pfN5WKO
	jfxrNIIVf7dF9ZD9JG7GALmb+7hoUaPIyUPe1UwNwFBj4+JDpsPMufNGbz5iCK0cq0c1zn/BGaD
	0+cOHeiQEr4aXka4lDt/PwOhHwFOeXFF1VcMt+yZBYPQBVPWdztkuKb2Do0agnkNQo/FmHbgVoz
	WAbvDfdnWl1+bcffjpkuBf21JKc8oxGE3c2wVRkoA=
X-Received: by 2002:a9d:6e07:0:b0:6e5:1d6c:a1bd with SMTP id e7-20020a9d6e07000000b006e51d6ca1bdmr10991901otr.2.1710794417688;
        Mon, 18 Mar 2024 13:40:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQZxjdGpISnteL8bYLiCKz2qEjctkLWE203BnJJRJYkwX5DdG2ogIktxtovbdz1f0ohSXUGQ==
X-Received: by 2002:a9d:6e07:0:b0:6e5:1d6c:a1bd with SMTP id e7-20020a9d6e07000000b006e51d6ca1bdmr10991887otr.2.1710794417329;
        Mon, 18 Mar 2024 13:40:17 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id z7-20020ae9c107000000b00789e1c94cf4sm3968019qki.113.2024.03.18.13.40.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:40:16 -0700 (PDT)
Message-ID: <621c64a8-6566-4c7c-be08-618b74e84c63@redhat.com>
Date: Mon, 18 Mar 2024 16:40:16 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpcb_clnt.c: memory leak in destroy_addr
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20240318151101.11043-1-steved@redhat.com>
In-Reply-To: <20240318151101.11043-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/24 11:11 AM, Steve Dickson wrote:
> From: Herb Wartens <wartens2@llnl.gov>
> 
> Piece was dropped from original fix.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2225226
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: libtirpc-1-3-5-rc3)

steved.

> ---
>   src/rpcb_clnt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 68fe69a..d909efc 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -121,6 +121,7 @@ destroy_addr(addr)
>   			free(addr->ac_taddr->buf);
>   			addr->ac_taddr->buf = NULL;
>   		}
> +		free(addr->ac_taddr);
>   		addr->ac_taddr = NULL;
>   	}
>   	free(addr);


