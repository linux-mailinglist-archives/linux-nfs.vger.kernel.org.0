Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D57E81CF
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjKJSfB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345648AbjKJSdw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD541B32
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699635274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uInXnBA2w8iDT+aYy4ZjsdLV9Mhns17cXF5x+3sdj6w=;
        b=XhIRdeTJ35C4PofDznhRQI2uwA1UAMnKu3Y09S/Sg47cv7OmK6tgiWSriLlkDkYswiip9q
        ptkuKCCC1cgkBql/sMi+DiMJKb3+lhekZrkwFPkQjvH84yi2ta1FmCyVxIHdPmti3WdWXD
        APDqngRIZlUhWmhL12uMj3pgnOdEndM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Lp-WyizYNkuWimuCGSOLbQ-1; Fri, 10 Nov 2023 11:54:33 -0500
X-MC-Unique: Lp-WyizYNkuWimuCGSOLbQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cbafdb4b6so2028501cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 08:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635272; x=1700240072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uInXnBA2w8iDT+aYy4ZjsdLV9Mhns17cXF5x+3sdj6w=;
        b=mdcmH2vYXuu/aGAgL8A8ZJRjlXf9zxeEivWddG/b6oiHWsv5tU3QzccJ8CQav1MSsW
         P4U1ICvpL2oh/kUjwmA4QjxZqJf2b8yGPGb3Ay16md62wPJr9citqifczVu6uhGSd5L0
         cx8rI4uiY1Kh2Ee2ysxMacM7ls1ZtW/L8Llu9pfpPQnTVK9lCPlbYoghvwc5O1VSmawr
         4kQGC8c+9NBlrs9EKXmVqXCtt9a4YRCotNlsi+FhFuKBTWOoVQElUhpVH/Z0mRsW/R9M
         kPg9l2m5FHC53+c+JYk006Ieb1UeU9GsootPvsCfGFIuunHb5ke4AIG87WpNuuxfjSXi
         +Wkw==
X-Gm-Message-State: AOJu0Yx2aP+FE8BFNkywBDWfK9DCbcV4nijRYyijwXmmsgF57b5cvIdj
        JGnwA/JvhC7DBsYeoLWO9vZBktZrgOceDP5yoPIBxQFrFkjMEOPGlGKND3+w93L7fop3sm4YELY
        4riUuppHMH/UgKuHmcFCWI4NfOIPL
X-Received: by 2002:ac8:4dd8:0:b0:412:d46:a8c3 with SMTP id g24-20020ac84dd8000000b004120d46a8c3mr7337462qtw.2.1699635272785;
        Fri, 10 Nov 2023 08:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtuEUB9wwjV3kLIuPjh4Ae7kKn5MbbIOxgvgENTpmmWoa1oMow42dZ+dS3jP+/wS/GxJYtQw==
X-Received: by 2002:ac8:4dd8:0:b0:412:d46:a8c3 with SMTP id g24-20020ac84dd8000000b004120d46a8c3mr7337450qtw.2.1699635272502;
        Fri, 10 Nov 2023 08:54:32 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id kk13-20020a05622a2c0d00b004181d77e08fsm2922424qtb.85.2023.11.10.08.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 08:54:32 -0800 (PST)
Message-ID: <6b4e6cd5-5711-4033-b813-2f8048c35921@redhat.com>
Date:   Fri, 10 Nov 2023 11:54:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfs(5): adding new mount option 'fasc'
Content-Language: en-US
To:     Chengen Du <chengen.du@canonical.com>
Cc:     linux-nfs@vger.kernel.org
References: <20230828055324.21408-1-chengen.du@canonical.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230828055324.21408-1-chengen.du@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

My apologies on this delay...

On 8/28/23 1:53 AM, Chengen Du wrote:
> Add an option that triggers the clearing of the file
> access cache as soon as the cache timestamp becomes
> older than the user's login time.
> 
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
On a 6.7-rc0 kernel I'm getting "nfs: Unknown parameter 'fasc'"
error... was this never implemented?

steved.

> ---
>   utils/mount/nfs.man | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 9b4bc9c9..2ac7b4ad 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -608,6 +608,19 @@ option is not specified,
>   the default behavior depends on the kernel version,
>   but is usually equivalent to
>   .BR "xprtsec=none" .
> +.TP 1.5i
> +.BI fasc
> +Triggers the clearing of the file access cache as soon as the cache
> +timestamp becomes older than the user's login time. It is supported
> +in kernels 6.4 and later.
> +.IP
> +NFS servers often refresh their users' group membership at their
> +own cadence, which means the NFS client's file access cache can
> +become stale if the user's group membership changes on the server
> +after they've logged in on the client. To align with the principles
> +of the POSIX design, which only refreshes the user's supplementary
> +group information upon login, the mechanism uses the user's login
> +time to determine whether the file access cache needs to be refreshed.
>   .SS "Options for NFS versions 2 and 3 only"
>   Use these options, along with the options in the above subsection,
>   for NFS versions 2 and 3 only.

