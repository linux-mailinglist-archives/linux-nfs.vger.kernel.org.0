Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC44631085
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 20:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKSTtu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 14:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKSTtt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 14:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFEC1AF0E
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668887329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8P6jnKn80vQ/KvuSh4Ioo0jxpiSrAoQs8ogz4gu82Uk=;
        b=epsetczxR/doG2dXCDIDC2iMtnE2gziQM/TIgCZCm22y0tsGlWTOcw0g4/t60R7IsOyn/i
        7ksnrOI2MNs0Kewf2q/AmQb12J9iUfU/iFguBwn+VxD7azQxDIgN0Hh+2+OPqzouVlN5a7
        aKAouojv9xlhY4a6w7BKH7Du+sWd73A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-523-HUG15X7VNxms_20oxh6FiA-1; Sat, 19 Nov 2022 14:48:38 -0500
X-MC-Unique: HUG15X7VNxms_20oxh6FiA-1
Received: by mail-qv1-f70.google.com with SMTP id h13-20020a0ceecd000000b004c6964dc952so4728359qvs.13
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P6jnKn80vQ/KvuSh4Ioo0jxpiSrAoQs8ogz4gu82Uk=;
        b=o3uYsqSPwcKS9rYzDcAf7RshYKQWERmC2qEvbuhP7NDdN9A12bHnD1UckIgaQYY+Ew
         VY7BTfICFgWvce9bnyuCKQCnvh7sph1bl2UlfCka9iitKDMK//tDu7672v+cJh/bK03C
         0h5o+MGPnV1vm+5jd8rTRY+45p8k7t6RoZSviG0Db8LRkif29WwLsqX5OlfBlZDLv/JN
         43htezOv9NmnO4Kf7Y6YeEje9efEhiygCPTdnx6l8MsXdX2r62TTlDU9C992JRu8M1bW
         ZnDndeE8ryKhoMCkNR07lEU3CeD1ridvvfHP8xIXWKWgcadz4hTxV6ksLKCcpQYXXdK7
         iLdA==
X-Gm-Message-State: ANoB5pkyJSa9wi4ICb6FITOtcds2odwfQaCtrzwQMGHSSEYd4MqCd79y
        dOaMioVyG/02myEJfCsCxIfM/seiiACRYCMnJArTVp2JnP1mxsCXMGpZdSSsFKnt88N/LEm5ha5
        J6k8NmUUrbBBngovVR4y1
X-Received: by 2002:a05:620a:749:b0:6f9:ffec:2dea with SMTP id i9-20020a05620a074900b006f9ffec2deamr10563072qki.136.1668887316684;
        Sat, 19 Nov 2022 11:48:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf48tqf4NzONwmjMgu+dtPOG+QXxwPxiJPofw4DX8T7OpKFiCb6kYg+2Ydxht1ruleXCZJsCXQ==
X-Received: by 2002:a05:620a:749:b0:6f9:ffec:2dea with SMTP id i9-20020a05620a074900b006f9ffec2deamr10563061qki.136.1668887316440;
        Sat, 19 Nov 2022 11:48:36 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b006cfc01b4461sm5072473qkb.118.2022.11.19.11.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 11:48:26 -0800 (PST)
Message-ID: <d1d05678-42ab-f8f6-a01a-53634d144f88@redhat.com>
Date:   Sat, 19 Nov 2022 14:48:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] .gitignore: ignore ctags generated file
Content-Language: en-US
To:     yegorslists@googlemail.com, linux-nfs@vger.kernel.org
References: <20221115095532.10850-1-yegorslists@googlemail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221115095532.10850-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/15/22 4:55 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Committed...

steved.
> ---
> Changes v1 -> v2:
> 	- add SoB line
> 
>   .gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index df791a83..682153d5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -86,3 +86,5 @@ systemd/rpc-gssd.service
>   cscope.*
>   # generic editor backup et al
>   *~
> +# file generated by ctags
> +tags

