Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE81489BC7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiAJPF6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbiAJPFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641827154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQgM+cU0wUYydtJ1f/sBrB9AQ1WGxdEqco1mpg+KpEo=;
        b=LVrWGcGFOvTEbpBnYHxiGojv6lmvFWPRv9nLT8x4QQ7pIK875TtIa7ZZ6RDbVk92p9E7Rk
        AheDEtS6dgvx6wPED4KegQN16v5oQQNZYBkr/5axhJiJKi9TpWOTWBNTUORDYWowlqA/td
        ennNJ0RmeOfCTBCGqduAmXYkLKnXs20=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-YYaOG7t7Mza46YRMQakaCw-1; Mon, 10 Jan 2022 10:05:53 -0500
X-MC-Unique: YYaOG7t7Mza46YRMQakaCw-1
Received: by mail-qk1-f197.google.com with SMTP id g66-20020a379d45000000b0047792ef05a1so6464092qke.11
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 07:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQgM+cU0wUYydtJ1f/sBrB9AQ1WGxdEqco1mpg+KpEo=;
        b=V9A4uq7/yqZ3h65LAFSNEwfBpY4y+1NNLQmsGE/r9CT5OB9euXq5IPSDz8GQHzkMzJ
         dUn5yeTXekmCy/tMOJqxAtPgLpT0zV3hZsJnw+J64BYIbHDvprZOgLMl3kaR3ThT0eaM
         lkMNYRJvYRPdbpmFT5G6UpOHVLzC+nuosD3TXl+QRTpYriZnup96VTyX31Ue9/892xuX
         C+7NfuprJj9SaDrrFM8YUTv/uhjpSIwyMAqVpYjx9cByOkLchcVioaM2Gan61RKS6hyh
         sv1ij/mzXGa0teoaRCnj3DGnFH4XDJ11Ml7HSjdbs9f3upZpGhrXWs0cufFuj+ZKIdkE
         tRog==
X-Gm-Message-State: AOAM531rLyhvmluNHPx3Y74YgbyUZEoLQcfGthUz1OCGEbjTFJ8UUnZi
        z83MJZ+RauKu1HDUll9XYbjucEsaTKevgyVZd6mJUKqcRpCwzG8jZtOiC298RWzdVxdt2SaXOaB
        lTH9hUxgp9z34yd9OvqxN
X-Received: by 2002:a05:622a:1a0d:: with SMTP id f13mr83963qtb.468.1641827152451;
        Mon, 10 Jan 2022 07:05:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8q0l9+6ZnlkVJpNK/Dy9u3+nVzTOrmZPd29tszLD75D3DjoQjq8AdM32RyxOwUPIBKn22Pw==
X-Received: by 2002:a05:622a:1a0d:: with SMTP id f13mr83942qtb.468.1641827152208;
        Mon, 10 Jan 2022 07:05:52 -0800 (PST)
Received: from [172.31.1.6] ([70.105.247.147])
        by smtp.gmail.com with ESMTPSA id l10sm4824383qtk.18.2022.01.10.07.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:05:52 -0800 (PST)
Message-ID: <71767c2a-7eaf-12cd-fa56-f7a37397e145@redhat.com>
Date:   Mon, 10 Jan 2022 10:05:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] tools/rpcgen: fix build on macos arm64 (stat64 issue)
Content-Language: en-US
To:     "Sergey V. Lobanov" <sergey@lobanov.in>, linux-nfs@vger.kernel.org
References: <20211214165544.40403-1-sergey@lobanov.in>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211214165544.40403-1-sergey@lobanov.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/14/21 11:55, Sergey V. Lobanov wrote:
> __DARWIN_ONLY_64_BIT_INO_T is true on macos arm64 so struct stat64
> and stat64() are not available. This patch defines stat64 as stat if
> __DARWIN_ONLY_64_BIT_INO_T is true
> 
> Signed-off-by: Sergey V. Lobanov <sergey@lobanov.in>
Committed... (tag: nfs-utils-2-5-5-rc5)

steved.
> ---
>   tools/rpcgen/rpc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/rpcgen/rpc_main.c b/tools/rpcgen/rpc_main.c
> index e97940b9..277adc6b 100644
> --- a/tools/rpcgen/rpc_main.c
> +++ b/tools/rpcgen/rpc_main.c
> @@ -62,6 +62,12 @@
>   #define EXTEND	1		/* alias for TRUE */
>   #define DONT_EXTEND	0	/* alias for FALSE */
>   
> +#ifdef __APPLE__
> +# if __DARWIN_ONLY_64_BIT_INO_T
> +#  define stat64 stat
> +# endif
> +#endif
> +
>   struct commandline
>     {
>       int cflag;			/* xdr C routines */
> 

