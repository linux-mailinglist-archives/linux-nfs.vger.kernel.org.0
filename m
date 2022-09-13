Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4069F5B7954
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiIMSWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIMSWY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66127B2BC
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663090708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKJ9YJZOTu9smE9fjjtIegi6o4X9RyJ2sb8jrIUvPHA=;
        b=P21IAsIyDUuVoNmYuirnCCAsQw1oe8nrglf35u2KiWjrnrVsellUk6EaIgwhA12s8J+AGi
        GOY/BgXL9osjAtm0phRNGH4vYkwJNY4zmYzFoT/0NTUonMSjzQ7gMWqpmw/8Zco+UOZQzh
        Tpmh4LIe/6ucU/RAE7bDmAnelbPtD04=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659--pOCTiyfPsWSi2boAJXooA-1; Tue, 13 Sep 2022 13:38:26 -0400
X-MC-Unique: -pOCTiyfPsWSi2boAJXooA-1
Received: by mail-qk1-f199.google.com with SMTP id az11-20020a05620a170b00b006bc374c71e8so10786266qkb.17
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mKJ9YJZOTu9smE9fjjtIegi6o4X9RyJ2sb8jrIUvPHA=;
        b=dJea8P6qV7CdLIBJo5FTbA0HYdyp7vs1Feh36sO4X6R/oyqekdNHSqE1d1c55x39+d
         PEIQs2/wSERp1oxNAp+40Zo6nX7EcXLCpomaCy0pNgXb2VJ7BPJPnyjoj6i2Pk3LZ7m7
         XwdPqeAOqUu4pX171+eIdH+moaVivD+R5Gmfcgmp4fXZ/Mvglw6surT6P5ByFVQCnUwk
         guNbZzzCGGbS1UqEAv4QKL3acUtwWEf5sXsSsF5V5/x0IuDW9ZjDfPoHMEUhhStaANKj
         pBPhj22BfcJ46nLi+gq0H/RuvEmkuW9PI9AZleB+WJY76mkQ8Jld29YbCfTv91H5INHk
         IvfQ==
X-Gm-Message-State: ACgBeo0PvqKIWCPLT586zMX+Zi2anZlyB3rO+FK5BUNi9qen3D0i/6ce
        pNR0PqFGkbPNyS4pvjS9onbE9djJDQsFxiy7IHjZD0GUttt5oyl99a/Jg54HLCZAgYw84+gjawu
        Dv31cPn85wddDt2sGJQQY
X-Received: by 2002:ac8:5a45:0:b0:35b:a3de:d3a7 with SMTP id o5-20020ac85a45000000b0035ba3ded3a7mr17687199qta.137.1663090706358;
        Tue, 13 Sep 2022 10:38:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4up3iC/KnsfElPMa0AVAglPabb8xcYE4BFE0y42GYbkkXIPbuxllC3C6kb202KCwU11PA7yQ==
X-Received: by 2002:ac8:5a45:0:b0:35b:a3de:d3a7 with SMTP id o5-20020ac85a45000000b0035ba3ded3a7mr17687179qta.137.1663090706105;
        Tue, 13 Sep 2022 10:38:26 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r21-20020ae9d615000000b006bb9125363fsm10105071qkk.121.2022.09.13.10.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:38:25 -0700 (PDT)
Message-ID: <b1ae2a88-3302-dff9-e111-f1a35082b4ca@redhat.com>
Date:   Tue, 13 Sep 2022 13:38:25 -0400
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
> Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Committed... (tag: nfs-utils-2-6-3-rc1)

steved
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

