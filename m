Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D455631089
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 20:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiKSTvn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 14:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiKSTvm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 14:51:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA44E6A
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668887437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6vqm4g4zo3/mFe6zqZUnPGTiJ0Cyey+C7bRNWf8i0M=;
        b=UoAZF1CFXTZ7teUx4Lm3SH+zXOe1p2mPVMOSfJk8GqeD0PgxvqcwyHR7Ukca7KmmNoSUh6
        x8vaAV5dchKyvENHuqGH8XVwT5QIA3bIcgEtltSTXePxUB2r6cwMn/IpWjDg619Ymdmc7S
        /j2dGcFalA4Qdfml3V4CsP1zw3+SUvk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-923bZqYiN7-sTYWKJMJkZA-1; Sat, 19 Nov 2022 14:50:35 -0500
X-MC-Unique: 923bZqYiN7-sTYWKJMJkZA-1
Received: by mail-qt1-f199.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso8354314qtx.15
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6vqm4g4zo3/mFe6zqZUnPGTiJ0Cyey+C7bRNWf8i0M=;
        b=BYtKrZQKgOuQLM2gwjzDYI4EryAQEP/nieVKt2VVXBf9tWqWPDOlLdORDVzAVQoh6j
         EGZeKuUHQDhbHMIlPwtRRJ6CDvIIHyQ0JjU5ZxxEQPVkaRRzUfVbTavxrSn2WNCTbuk/
         UJsBX7tkc5R40BKXhcO8qmk8BRk/LHqdEPPfLbGEb27736Cz+gzuRUv/VdqO8f4PH8qh
         nWQafc1vMR0efg6U/DjBGOS8ZNerK2rDNEC6RXN5RtNJvSVS/dz+I3+w+hs8hd8IyZpF
         E+1L+1pNUZQZ7Yn12vcv5+/Zbu9QObxeCrx8MW3ihwLH3maZLEiOiK2jAVEdMQ1pZ6uQ
         +kvQ==
X-Gm-Message-State: ANoB5plRMBXk5P7fD7qQpw7KSwwCmIcyFNmzl9/fWA2ZWn8cSMw7uR/l
        bTBZVQtLbjFrBF8fiCqQqqlh0XkBG0pewXM21aLDVYjQJClna8ciqxjg/0W5DWFPBnhI4v/QG+G
        Z8TpFI70AK17Fg+Fns61w
X-Received: by 2002:ae9:d8c4:0:b0:6fa:2aef:51ff with SMTP id u187-20020ae9d8c4000000b006fa2aef51ffmr10766312qkf.270.1668887434607;
        Sat, 19 Nov 2022 11:50:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf450rck0x/D3mvM8RBVVox7k/kBkaMbkjPwuyrFH+sFHAhb4+ppphWgZdeKtuw3Cd5wrwrH+g==
X-Received: by 2002:ae9:d8c4:0:b0:6fa:2aef:51ff with SMTP id u187-20020ae9d8c4000000b006fa2aef51ffmr10766306qkf.270.1668887434358;
        Sat, 19 Nov 2022 11:50:34 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a410c00b006eef13ef4c8sm5238065qko.94.2022.11.19.11.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 11:50:33 -0800 (PST)
Message-ID: <085631c5-eb73-8f40-83fd-bfaacd8fad14@redhat.com>
Date:   Sat, 19 Nov 2022 14:50:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] README: fix mount command
Content-Language: en-US
To:     yegorslists@googlemail.com, linux-nfs@vger.kernel.org
References: <20221115095320.10261-1-yegorslists@googlemail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221115095320.10261-1-yegorslists@googlemail.com>
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



On 11/15/22 4:53 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Without device specification, mount tries to mount an entry
> from the /etc/fstab file. Hence, specify target "nfsd" to
> make this command executable from the command line.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Committed...

steved.
> ---
>   README | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 7034c009..1c19ecd0 100644
> --- a/README
> +++ b/README
> @@ -70,7 +70,7 @@ scripts can be written to work correctly.
>   3.1.  SERVER STARTUP
>   
>   
> -   A/  mount -t nfsd /proc/fs/nfsd
> +   A/  mount -t nfsd nfsd /proc/fs/nfsd
>         This filesystem needs to be mount before most daemons,
>         particularly exportfs, mountd, svcgssd, idmapd.
>         It could be mounted once, or the script that starts each daemon

