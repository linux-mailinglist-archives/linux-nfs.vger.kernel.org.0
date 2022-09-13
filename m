Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C515B794F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiIMSWU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIMSV5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4F7436D
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663090632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrsQoqfEyKkIxPXVDqrvNX1K9HhbJQ0I80aFs5ReBHE=;
        b=G8PoAuEC8mdnPcKESTCApx+h8GNuu5oA+s5DrYwiaEcPG/lvMhx+DC2BipltC1W8CuuuKV
        8B+aK9p08KZJlpm5dtm1io2JCUiiE4iLiC2flj2GakNF286vOOcjtSUDVUbIHDzyeY72M4
        ofkMS0vFRgMu1QWVmWb+W/+JtqVGqtg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-1yQB2q29NcSsC163z-Z7Tg-1; Tue, 13 Sep 2022 13:37:11 -0400
X-MC-Unique: 1yQB2q29NcSsC163z-Z7Tg-1
Received: by mail-qk1-f198.google.com with SMTP id bs8-20020a05620a470800b006ce16870cb7so7164514qkb.10
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wrsQoqfEyKkIxPXVDqrvNX1K9HhbJQ0I80aFs5ReBHE=;
        b=DVDjinOmvippqLBhCkQ05/KzmXwvY18sqncZiLB64iFPV0GAocu569i34wQZjBtSTJ
         Vc/OHY18ornEquxKlZRydKTlxzdho5wryOtsmWumsDt65a3rZqqj9OsrTjuiLidoOVwC
         jrDXpidKLMQMr7mk0hMv3bpDeZZI2a0gDPoecEhs6BDpJ9LGZTLd4kW9+i6bt6lTt2kY
         RirIVgDzDM/YS95Qf8tIc2wWXg4UXdJHWPAZLqBft0QVBC7VmU3sh+QEvq9KE8VMO067
         aLf3d6XBLZ/jE/7/hNDsLY0aboBQ1zWoDZajoLaVrlXCNbhEFehQ6dPeo33lLZVwwkcW
         nEQQ==
X-Gm-Message-State: ACgBeo38l4+rAcSN8i+ma9e6cXoL21twRV+FFmlhmHCgbnbOOh00S45b
        iJGMw337z+wgenLbWrGXqvJdx4N8uVFoR/DRur7WP7fknBnHAb+uKQ8GqQfN5O4hQf/bbKgweIE
        B6laR3ITK+DDmIuw2tJON
X-Received: by 2002:ac8:5f0b:0:b0:35b:fd08:2414 with SMTP id x11-20020ac85f0b000000b0035bfd082414mr3775880qta.333.1663090630528;
        Tue, 13 Sep 2022 10:37:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78wgAlSmu/N5BBdJga17qnJHBc7r6644nLAJSYfUQkJbxP9qCINiPXvcs+ygDDC+wRmwnX2A==
X-Received: by 2002:ac8:5f0b:0:b0:35b:fd08:2414 with SMTP id x11-20020ac85f0b000000b0035bfd082414mr3775870qta.333.1663090630289;
        Tue, 13 Sep 2022 10:37:10 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a444b00b006b9c9b7db8bsm10841392qkp.82.2022.09.13.10.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:37:09 -0700 (PDT)
Message-ID: <0429dc4f-e9a6-34fd-1572-0eab2708d3f5@redhat.com>
Date:   Tue, 13 Sep 2022 13:37:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] mountd: Check for return of stat function
Content-Language: en-US
To:     Khem Raj <raj.khem@gmail.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
References: <20220816024403.2694169-1-raj.khem@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220816024403.2694169-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/15/22 10:44 PM, Khem Raj wrote:
> simplify the check, stat() return 0 on success -1 on failure
> 
> Fixes clang reported errors e.g.
> 
> | v4clients.c:29:6: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
> |         if (!stat("/proc/fs/nfsd/clients", &sb) == 0 ||
> |             ^                                   ~~
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
Committed... (tag: nfs-utils-2-6-3-rc1)

steved
> Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
> Cc: Steve Dickson <steved@redhat.com>
> ---
> v2: rebased
> 
>   support/export/v4clients.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index 5f15b61..3230251 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -26,7 +26,7 @@ void v4clients_init(void)
>   {
>   	struct stat sb;
>   
> -	if (!stat("/proc/fs/nfsd/clients", &sb) == 0 ||
> +	if (stat("/proc/fs/nfsd/clients", &sb) != 0 ||
>   	    !S_ISDIR(sb.st_mode))
>   		return;
>   	if (clients_fd >= 0)

