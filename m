Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380084951EC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376817AbiATQAl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 11:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243632AbiATQAk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 11:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642694439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPlMjOFPuoQTdvBhyDzgXZAnIO+rgfpDpnc3UimkWsY=;
        b=aUQG+deoL/tWn8GZmXzqclDfKQGGLZsDGRmqFVwTTJFsdOAJ8hE2Ig/068bpO4qNntktUH
        dFd+nnGemNrVQClGLQei4b6E7zm06Km0W+1HSlnKoQt0d7T0Ek6X1eDye97dg7oo7KJwFn
        p2bYimnGItqQyDdEQhhLmPndIZlmH+c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-K2-jIylgNiqmfnAwiqlx-Q-1; Thu, 20 Jan 2022 11:00:38 -0500
X-MC-Unique: K2-jIylgNiqmfnAwiqlx-Q-1
Received: by mail-qt1-f198.google.com with SMTP id u23-20020ac87517000000b002cdd58d2951so1087275qtq.15
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jan 2022 08:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kPlMjOFPuoQTdvBhyDzgXZAnIO+rgfpDpnc3UimkWsY=;
        b=SPBS5KnSyEw33C0l74E1jsYpG0HUeBWxiLJpsk2t6nvLj1RHpY8u9yegH7cQcARNsX
         l60jmoP1I7RPXTK2A7OpCdUFAd75ywqDgeYQmYt2R6384DKGTJ5uDemzu8Z99NyXtvBb
         1eGAtG01ZiDpRsq1vJ+/K5P067FZFx/uOb/h4PBQC51PDjSLsPjCKwcWiQ5+xax0cRWt
         KMwmyPMTDaqzuGL9KyKxqm6RcqpAP49otHve+hW2S4FP+GzBTUhfx1UZwG4gE5EKL3Ql
         otr+KaFJNLD5Jds9B6uP8lETxx4QjsP7EN67FBXT1YaF+CWTpzRSuLu4vPsc/B+W8tEH
         aJ1w==
X-Gm-Message-State: AOAM530yW80CgJrQeLj1GKUeSGg8/BkeQ2Cn/rkI2twEy1QQkLUdujM2
        D3Yw2j34j5l5KZPlSiZfVvIYg7ZXCmA8UUK0q+Hu+bAViRjrD/KwlEnVGgsEQx56FfckCLz1Cd2
        T74ruHVU9Twnje35of75p
X-Received: by 2002:a05:620a:2847:: with SMTP id h7mr23899366qkp.295.1642694437502;
        Thu, 20 Jan 2022 08:00:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy83KahURgddv6150WmZOkIPcLhUNQvzCLpbps7Fj7NzO64Qd0X4mvgh05ImmGi5/6qzsGA0w==
X-Received: by 2002:a05:620a:2847:: with SMTP id h7mr23899328qkp.295.1642694437138;
        Thu, 20 Jan 2022 08:00:37 -0800 (PST)
Received: from [172.31.1.6] ([70.109.152.127])
        by smtp.gmail.com with ESMTPSA id m8sm1720849qkp.88.2022.01.20.08.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:00:36 -0800 (PST)
Message-ID: <3710b69f-a77a-04e4-5989-b2cc3dd77929@redhat.com>
Date:   Thu, 20 Jan 2022 11:00:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] libtirpc: Fix use-after-free accessing the error number
Content-Language: en-US
To:     Frank Sorenson <sorenson@redhat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20220113193605.3361579-1-sorenson@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220113193605.3361579-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/13/22 14:36, Frank Sorenson wrote:
> Free the cbuf after obtaining the error number.
> 
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Committed  (tag: libtirpc-1-3-3-rc2)

steved.
> ---
>   src/clnt_dg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/clnt_dg.c b/src/clnt_dg.c
> index e1255de..b3d82e7 100644
> --- a/src/clnt_dg.c
> +++ b/src/clnt_dg.c
> @@ -456,9 +456,9 @@ get_reply:
>   		 cmsg = CMSG_NXTHDR (&msg, cmsg))
>   	      if (cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_RECVERR)
>   		{
> -		  mem_free(cbuf, (outlen + 256));
>   		  e = (struct sock_extended_err *) CMSG_DATA(cmsg);
>   		  cu->cu_error.re_errno = e->ee_errno;
> +		  mem_free(cbuf, (outlen + 256));
>   		  release_fd_lock(cu->cu_fd_lock, mask);
>   		  return (cu->cu_error.re_status = RPC_CANTRECV);
>   		}

