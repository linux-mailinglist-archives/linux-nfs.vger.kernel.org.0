Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC66FFAE3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbjEKTzi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKTzh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 15:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C2B76A0
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683834901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mlxa3/tDpGw4Y9cRwx4l46ozdkqM3UTf0I9GGUJiAtU=;
        b=ZARbjsdZpcTdEunVZoNHvXzBn3NEgxpU6d9zb1OYHKpmDRpCD5zmO85iC93lQWARTHhVTN
        Izt4173goZnF+0bnsjLQxB85BRKcTueqv86pTePxwqBydhL/WcwYky401B4WcLRPJC5M1O
        QBdBYu0eWmF7k0TPTgIfrbovEWCnzFc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-zS4p4JTgNsefJfITHkrEGw-1; Thu, 11 May 2023 15:40:20 -0400
X-MC-Unique: zS4p4JTgNsefJfITHkrEGw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74e23e33f80so91382185a.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834019; x=1686426019;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlxa3/tDpGw4Y9cRwx4l46ozdkqM3UTf0I9GGUJiAtU=;
        b=ldVgdHS5nMnGUlAkXWomEDM6p0+n0oiLy8zhfpnVAhEWhoL+NPmOjqzcWGjsEeSXS1
         CS3Bq2RJMEa25ctKJZJ+0pJQqB6u2pNHVOFb2gNUtU4UpWrEr8o7mGsXhtE/WASukLfJ
         37A+K/cTqeBWkIjk/+0qZY6HEpNsT8pUoxaxft+Q0DDvG3vOUWI4n3JIKTsBBxchpsXT
         pUtuRMOxmnALAF+AP5uNf96+NCe7J3WVzFl6QCWyAYUKmSQOv8Ypqybw4qKRCHg4imap
         G5qAuBaadZvoljYuiEqg8dAJPTlxIbDQMz+yFWF09fZDPB+WWaGVQo/nDcPw3A2CRpeQ
         sBSg==
X-Gm-Message-State: AC+VfDyfV3bx+O+8sRDYrMZIV8633PJkzKhLtaNg3rN/rkA1+TGlT4LF
        y0rkeDy+uzsTVp23Y02RVu1gk7VCWX9hZr26DuJOTAMeJVVqCVXFhdEKCJdYPIa3PtALKkjbsT9
        hvZgP6iHbqnFxdPCZgzOGoFDGv+Jn
X-Received: by 2002:a05:6214:226a:b0:61b:73b2:85ca with SMTP id gs10-20020a056214226a00b0061b73b285camr32652084qvb.5.1683834019405;
        Thu, 11 May 2023 12:40:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56yqj+pyjchZ8GRoC8T6gnPvsd9TY9So25YOxNUY4LkBNXdCeUh2M6uZnBDVnJ3xbHdrCYAQ==
X-Received: by 2002:a05:6214:226a:b0:61b:73b2:85ca with SMTP id gs10-20020a056214226a00b0061b73b285camr32652061qvb.5.1683834019142;
        Thu, 11 May 2023 12:40:19 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z3-20020ae9c103000000b0074e4c3719e9sm4825244qki.69.2023.05.11.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 12:40:18 -0700 (PDT)
Message-ID: <3d6b6f1e-5299-e59b-3078-b46acc79c475@redhat.com>
Date:   Thu, 11 May 2023 15:40:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH nfs-utils] nfs.conf.man: Fix typo cache-use-upaddr to
 cache-use-ipaddr and add manage-gids to exportd section.
Content-Language: en-US
To:     Lukas Herbolt <lukas@herbolt.com>, linux-nfs@vger.kernel.org
References: <20230511143449.2266773-1-lukas@herbolt.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230511143449.2266773-1-lukas@herbolt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/11/23 10:34 AM, Lukas Herbolt wrote:
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
Committed... (tag: nfs-utils-2-6-4-rc1)

steved
> ---
>   systemd/nfs.conf.man | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index bfd3380f..866939aa 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -137,8 +137,9 @@ but on the server, this will resolve to the path
>   .TP
>   .B exportd
>   Recognized values:
> +.BR manage-gids ,
>   .BR threads ,
> -.BR cache-use-upaddr ,
> +.BR cache-use-ipaddr ,
>   .BR ttl ,
>   .BR state-directory-path
>   
> @@ -204,7 +205,7 @@ Recognized values:
>   .BR port ,
>   .BR threads ,
>   .BR reverse-lookup ,
> -.BR cache-use-upaddr ,
> +.BR cache-use-ipaddr ,
>   .BR ttl ,
>   .BR state-directory-path ,
>   .BR ha-callout .

