Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911ED64449D
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLFNdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 08:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFNdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 08:33:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B66310
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670333565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1nR8Tgkgier7VHLIQPZG2fHeuhK+FbmhRVmq/uyuuc=;
        b=U3vWbS2XAhIxTQ1PkbCiSuPiQ48QaNUYg6uJXhc9xaaUIACmTeTXQ9BkElULZj89zNzirt
        cevnmsgabBqSopbu2eesojT6FGK6IjIWoWDgItZTCN/X1phSZ83tA/Lfkw04bKcv+d/JgH
        HF04FF1qnMNoPL1dsofGWtbl3ScI4u8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-Xou79Tj0NvyIcohn-gRt6w-1; Tue, 06 Dec 2022 08:32:44 -0500
X-MC-Unique: Xou79Tj0NvyIcohn-gRt6w-1
Received: by mail-qv1-f69.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so34347783qvb.20
        for <linux-nfs@vger.kernel.org>; Tue, 06 Dec 2022 05:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1nR8Tgkgier7VHLIQPZG2fHeuhK+FbmhRVmq/uyuuc=;
        b=K/LxyqcSqff1pvUZB+hgJItHYDRMUS/z63Ye/pqaeEm/O0Ww+65JltaQ2gcZWG3uVd
         eblNoFdZ7D7EeUnGyRWAE+5nDv1VfmEJAjJV9mHosCS3sE8EbCgWjNRsKW3g8rRXiA0/
         BLrkp8lDFAkznhkvfGWnwbVhYQrPVVeW/jR/4LEdrAMF3/QMeoRlqQ79A0Lef4QvUPrA
         zJIApenx4l5WSbfuo90hKx7h8RENQa4aK+aXLkPQ6JYr4OJEqTnJdxS/BlpE3shT50k+
         sNDunrN3YJumqMU2XxVJU6EIXcVKa07Ojggdwk8tBXr/So+/UDquK8Ag7GaFuuEcLSfU
         bY8g==
X-Gm-Message-State: ANoB5pnyfGTuRMaY1/YeeORpqSha0lUDtOXu4uWjLIuRVy8/vNMgTHKI
        yjyYXVDwLqAQPVhBzIw9/z6AzEcthxcVJ6VuG0tyOKK0TOYP80l/p5QKk8bgRBVzD6Pdt8UClPN
        O0WSLKXbjgarh97kp8oFb
X-Received: by 2002:a05:6214:330a:b0:4c6:c265:9fef with SMTP id mo10-20020a056214330a00b004c6c2659fefmr374618qvb.35.1670333564088;
        Tue, 06 Dec 2022 05:32:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7owx74T6/MkGjAbxjtxF989h1VDf9I/zFf0QoFgSdYyCdLzqQokQDkVicd4N5LEEI48zOthQ==
X-Received: by 2002:a05:6214:330a:b0:4c6:c265:9fef with SMTP id mo10-20020a056214330a00b004c6c2659fefmr374615qvb.35.1670333563698;
        Tue, 06 Dec 2022 05:32:43 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id g13-20020a05620a40cd00b006fc7c5d456asm11876310qko.136.2022.12.06.05.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:32:43 -0800 (PST)
Message-ID: <3a95b0a2-5833-d517-ff62-a5fa94a7c4ce@redhat.com>
Date:   Tue, 6 Dec 2022 08:32:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] auth-rpcgss-module.service: Don't fail inside linux
 container.
Content-Language: en-US
To:     Joachim Falk <joachim.falk@gmx.de>, linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.com>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <20221126095550.174062-1-joachim.falk@gmx.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221126095550.174062-1-joachim.falk@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/26/22 4:55 AM, Joachim Falk wrote:
> Only try to load the auth_rpcgss kernel module if we are not executing
> inside a Linux container. Otherwise, the auth-rpcgss-module service will
> fail inside a Linux container as the loading of kernel modules is
> forbidden for the container. Thus, the "/sbin/modprobe -q auth_rpcgss"
> call will fail even if the auth_rpcgss kernel module is already loaded.
> This situation occurs when the container host has already loaded the
> auth_rpcgss kernel module to enable kerberized NFS service for its
> containers. This behavior has been tested with kmod up to version
> 30+20220630-3 (current in bookworm as of 2022-09-20).
> 
> Bug-Debian: http://bugs.debian.org/985000
> Discussion-Debian: https://salsa.debian.org/kernel-team/nfs-utils/-/merge_requests/7
> 
> Signed-off-by: Joachim Falk <joachim.falk@gmx.de>
Committed... (tag: nfs-utils-2-6-3-rc5)

steved.
> ---
>   systemd/auth-rpcgss-module.service | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/systemd/auth-rpcgss-module.service b/systemd/auth-rpcgss-module.service
> index 45482833..25c9de80 100644
> --- a/systemd/auth-rpcgss-module.service
> +++ b/systemd/auth-rpcgss-module.service
> @@ -10,6 +10,7 @@ DefaultDependencies=no
>   Before=gssproxy.service rpc-svcgssd.service rpc-gssd.service
>   Wants=gssproxy.service rpc-svcgssd.service rpc-gssd.service
>   ConditionPathExists=/etc/krb5.keytab
> +ConditionVirtualization=!container
> 
>   [Service]
>   Type=oneshot
> --
> 2.35.1
> 

