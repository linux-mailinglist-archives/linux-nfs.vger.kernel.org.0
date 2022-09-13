Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0B5B7956
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiIMSXS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMSW7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035EF4D
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663090788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu10hD1OCFhuxjnvLtrbqqDX8ceXhWf0cEsoDTTGW6A=;
        b=dx4o8F/vVl8whooQZFizi1NW85xADrfeppGpGHPZD33YIuXSurqCrkXh2kxJQpws5RprGX
        Wzo1Okj69mQj8jTXrc8SR99JyyNaQGlFGqdheFp9L821NFgy9VgOIlGyqGSb4Dc4jYjmFJ
        SgbCFy3sQUg918Kf/T58TgHhh0oEFCQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-Ql35O-pfND2ion6BtF0bUA-1; Tue, 13 Sep 2022 13:39:47 -0400
X-MC-Unique: Ql35O-pfND2ion6BtF0bUA-1
Received: by mail-qt1-f198.google.com with SMTP id fx6-20020a05622a4ac600b0035a70ba1cbcso10532219qtb.21
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Fu10hD1OCFhuxjnvLtrbqqDX8ceXhWf0cEsoDTTGW6A=;
        b=lCq6vOAQceRE+iZsNgDgdGe4iL06pAjjE/i4ri/fa8iB2IjQ91GToowC0SeStQifdT
         FuU2JDRrHNNfBwFhCM5yTo2VNqO8JPFVLA6aogxOK30xNiOPRh4Ill1nIgib/kSW22g6
         5SyTYerDOL9hilwjlbT8jZ6K3SE4ncIz2CSdr/b1t0KOjBT/obLOMVmRH8kaSz1UV1Zp
         hEpd034U1SmpflUjLB0OOCEUFOd37wkcqj9ajU5Wb2fD2Az+OS8eTqIfRghYPUmPMv49
         c9kTME7lNX9yEosXVQaINK28aPmuo0psCXmG8FL1th8U4Ke9wMKwtvPNWs4mqwoNhvd4
         vahg==
X-Gm-Message-State: ACgBeo3PyrG2dpX9yx6BI97M9MvZ8C9wM4yYwFNe7Xz6C9h35z9ohcLM
        fKv+apEiA46+YFV5mfttcTufxAA89Ggc3+8tKwfgV5HxD1Ozu5fCmLWVNsMP0ZWY3Z+0UU5ILOq
        tQ6cM0JMxs5IINlBKT5B4
X-Received: by 2002:ac8:5710:0:b0:343:5fa9:b707 with SMTP id 16-20020ac85710000000b003435fa9b707mr28159861qtw.192.1663090778920;
        Tue, 13 Sep 2022 10:39:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR74ceIOw5oF8KIKm7jfKnQ4yV4dP6oimS+lx8QcLFJOFDvDW6RaO/0AHdEvDY3zLtl09z/YdA==
X-Received: by 2002:ac8:5710:0:b0:343:5fa9:b707 with SMTP id 16-20020ac85710000000b003435fa9b707mr28159849qtw.192.1663090778679;
        Tue, 13 Sep 2022 10:39:38 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b0069fe1dfbeffsm10474690qkl.92.2022.09.13.10.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:39:37 -0700 (PDT)
Message-ID: <f8e252f5-9a87-5f22-1c47-2fccd82091bf@redhat.com>
Date:   Tue, 13 Sep 2022 13:39:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] nfs-blkmapd: Fix the error status when nfs-blkmapd stops
Content-Language: en-US
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-nfs@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong <linfeilong@huawei.com>
References: <ae07856f-ef34-270e-91b2-9364fdcd6563@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <ae07856f-ef34-270e-91b2-9364fdcd6563@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/1/22 9:44 AM, zhanchengbin wrote:
> The systemctl stop nfs-blkmap.service will sends the SIGTERM signal
> to the nfs-blkmap.service first.If the process fails to be stopped,
> it sends the SIGKILL signal again to kill the process.
> However, exit(1) is executed in the SIGTERM processing function of
> nfs-blkmap.service. As a result, systemd receives an error message
> indicating that nfs-blkmap.service failed.
> "Active: failed" is displayed when the systemctl status
> nfs-blkmap.service command is executed.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Committed... (tag: nfs-utils-2-6-3-rc1)

steved.
> ---
>   utils/blkmapd/device-discovery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c 
> b/utils/blkmapd/device-discovery.c
> index 2736ac89..49935c2e 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -462,7 +462,7 @@ static void sig_die(int signal)
>           unlink(PID_FILE);
>       }
>       BL_LOG_ERR("exit on signal(%d)\n", signal);
> -    exit(1);
> +    exit(0);
>   }
>   static void usage(void)
>   {

