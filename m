Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5157E354
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiGVPCH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVPCG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 11:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 071846FA07
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658502125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ebf1eyDE6hniJPScsYZO0F23T39UaniEFq6NP2mDXtM=;
        b=MmfN4TDi8CvEBAQmMbBmVird0I5wqbiJ8n9se4WBUtfkV4yB2gz4IeBOCMSXkSopA8u/mI
        SkhlF5TkP6SwdEjE/5jv529SEB3l725jjJvBwfppiPHLLZZQi97SqGentM50SKPNZDHN6M
        ARAzY6dIOQ10DFmDPvQsr/X5/jBAehA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-GRxRXCl9N4eU1NA-zs0zQw-1; Fri, 22 Jul 2022 11:02:03 -0400
X-MC-Unique: GRxRXCl9N4eU1NA-zs0zQw-1
Received: by mail-qv1-f69.google.com with SMTP id ln2-20020a0562145a8200b0047301e9bc53so3159499qvb.3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=Ebf1eyDE6hniJPScsYZO0F23T39UaniEFq6NP2mDXtM=;
        b=SfcM5wlQ4eZ3x+ZZki9q4iZ43fgD4ftpmGiXNArJr9IgK1NZiszn8RnaeeCiZyvO0O
         i5SPQ8QlQCG9U/HKOs2FvsxVyzPy/x2iD/5i27b96xiKAJbfcnKdcP4Dc3wtSTBX9SwW
         1XJIVDe2XU9bAMV9J+ISKaxx3UANQkdfUJvfd3nXgZmPYOFmNX5XvN6M1+hVk+ghYjDV
         5VFUetSrCWEO0k9Cc/uzIhFhHgyvgvycGKW6FDxZzhm7Z0SCwzhS8C2NH5gt6FE79lW8
         FllEsf+dGiUXDFnL+l63j3RAiEcBGbQSSiAwEWC4zd4D6GDI8KiqZH3a/l5CpvsNY+2L
         1Qxg==
X-Gm-Message-State: AJIora9wMqA4xZPJ0LK8YmzDHl2bjzgxkyPvIRqE164c2CMECqGDndIU
        dwbtu6O8lnn+V8dBcvBDkdCfagamcnI7QT5Z/WZ2N1QUEnevzxlmqtQRbDuz1p0GGEiypjyyA3u
        gL9NAzRWCdIdCdHKklSEOo6Pz7crGYzqgArOOd6wWkZJg8IZDzV7MCtiwTTAPWmKC1Q1twQ==
X-Received: by 2002:a05:6214:e85:b0:472:f6fd:3b48 with SMTP id hf5-20020a0562140e8500b00472f6fd3b48mr160631qvb.54.1658502123310;
        Fri, 22 Jul 2022 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJiQXwrnorIax356a77w4eGIWEldfO02Kb1wI+CrMLkpzMxtzD+KDQxAC81/RrHwZwXjwYkQ==
X-Received: by 2002:a05:6214:e85:b0:472:f6fd:3b48 with SMTP id hf5-20020a0562140e8500b00472f6fd3b48mr160582qvb.54.1658502122772;
        Fri, 22 Jul 2022 08:02:02 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.98.133])
        by smtp.gmail.com with ESMTPSA id j189-20020a3755c6000000b006b5c97476e2sm3429322qkb.10.2022.07.22.08.02.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:02:02 -0700 (PDT)
Message-ID: <cccb8de2-1f10-335b-7363-e7f3c1108965@redhat.com>
Date:   Fri, 22 Jul 2022 11:02:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rpc-pipefs-generator: allocate enough space for
 pipefs-directory buffer
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220721191812.60294-1-steved@redhat.com>
In-Reply-To: <20220721191812.60294-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/21/22 3:18 PM, Steve Dickson wrote:
> Commit 7f8463fe fixed a warning but introduce
> a regression by not allocating enough space
> for the pipefs-directory buffer when it is
> not the default.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2106896
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed....

steved.

> ---
>   systemd/rpc-pipefs-generator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
> index 7b2bb4f7..3aaeaeaf 100644
> --- a/systemd/rpc-pipefs-generator.c
> +++ b/systemd/rpc-pipefs-generator.c
> @@ -28,7 +28,7 @@ static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
>   {
>   	char	*path;
>   	FILE	*f;
> -	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit));
> +	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit) + 1);
>   
>   	path = malloc(size);
>   	if (!path)

