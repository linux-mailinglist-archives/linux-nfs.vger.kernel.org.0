Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595655BEDC1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiITT2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiITT2c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 15:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58A76441
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyTWxAEWi23XoogbbfOyzTXrCIiTkCfob7u1C7WVfkk=;
        b=SwFYOEA3OD0nctskmWNnldpQcBa4fN+6ajbpkN+eTMuy/MR4qqlwdWctDmUmFUfkACbM2w
        A32xcz78Nuo7LhSiax3g+ORAunukHJas000K7mqmH9XgK+K5Y5bIFk4D7JNoPcvFRvF9gJ
        mb0a70zTnA1aSRYW6GPusCftNbMZzAg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-ZGm22TQuMSC-i2tr9pW5VQ-1; Tue, 20 Sep 2022 15:28:21 -0400
X-MC-Unique: ZGm22TQuMSC-i2tr9pW5VQ-1
Received: by mail-qt1-f200.google.com with SMTP id g21-20020ac87d15000000b0035bb6f08778so2574248qtb.2
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nyTWxAEWi23XoogbbfOyzTXrCIiTkCfob7u1C7WVfkk=;
        b=csIIzrxiZALymQTje3hV3qPrN92rEfV4E/pTZfg7WGyTDAj5Z5JLXedIyGWLDdsdLF
         BS6zX3x0dZjj5tuiLwf4e5eKtcKMmBOBpg/AyK7oA3lqge15Vnu2URb+Rhq5hVlFD1+L
         +V7s+4BdN12QRr+8B12evNt6RKkmWbJeTF2mrZoHdHQhjbCOVu5cplBJY6uETiuQDFph
         6nVgFNopPDdacHLnXZstRuLp7IdswPgg2kHRLpHIHEN1U7rxeGF5KBWXJQ3cIgCaI51S
         NUz8nPFXUrHtgte8dElJuqK1XN7p6wCqHEEMx78//vLfEazuGz7OKol3sp0WnkE4vxNQ
         OraA==
X-Gm-Message-State: ACrzQf2ZvdfbfAQVx6/fuhIua1M0LoMBf2K2ExJh42xwMZ8/mA6oLFUS
        5FJQms4vGQ9N5ABUGBW1vctrQbKM8cCSYUoDzS7B/qYTSsIE0o+Zn1qTdRT0eDx3gBymy0DMydR
        Co4Jl1gSKfHzblQp6ZbSx
X-Received: by 2002:a05:620a:4723:b0:6ce:9a32:52a9 with SMTP id bs35-20020a05620a472300b006ce9a3252a9mr17993626qkb.673.1663702101508;
        Tue, 20 Sep 2022 12:28:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6n0JaJvxQissjPUgDjV5mQSCEjf+ayhOaSveTU9l/mttMsgY56UxigEq3yhv3JL3AdIm2fxw==
X-Received: by 2002:a05:620a:4723:b0:6ce:9a32:52a9 with SMTP id bs35-20020a05620a472300b006ce9a3252a9mr17993609qkb.673.1663702101267;
        Tue, 20 Sep 2022 12:28:21 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.93.20])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a454b00b006ce2c3c48ebsm378771qkp.77.2022.09.20.12.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 12:28:20 -0700 (PDT)
Message-ID: <0d972685-d120-0b2c-c072-b8e9941e0baf@redhat.com>
Date:   Tue, 20 Sep 2022 15:28:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] libtirpc: add missing extern
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, linux-nfs@vger.kernel.org
References: <20220919235954.14011-1-rosenp@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220919235954.14011-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/19/22 7:59 PM, Rosen Penev wrote:
> Fixes compilation warning.
What was the warning? Plus AUTH_DES is no longer supported.

steved.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   src/svc_auth.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/svc_auth.c b/src/svc_auth.c
> index ce8bbd8..789d6af 100644
> --- a/src/svc_auth.c
> +++ b/src/svc_auth.c
> @@ -66,6 +66,9 @@ static struct authsvc *Auths = NULL;
>   
>   extern SVCAUTH svc_auth_none;
>   
> +#ifdef AUTHDES_SUPPORT
> +extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
> +#endif
>   /*
>    * The call rpc message, msg has been obtained from the wire.  The msg contains
>    * the raw form of credentials and verifiers.  authenticate returns AUTH_OK

